/**
 *@file Archivo que contiene el modulo FinFacturaDao
 *@name finFacturaDao.js
 *@author Brayan Villota <brayanmichel46@gmail.com>
 *@license brayanmichel
 *@copyright 2020
 */
var Models = require("../../server/models/index");
var sequelize = Models.sequelize;
var Q = require("q");
const { response } = require("express");

/**
 * Modulo FinFacturaDao gestiona todas las consultas realizadas a la tabla
 * fin_factura del esquema financiero
 * @module FinFacturaDao
 */

/**
 * Funcion que permite consultar todas las facturas
 * registradas de una sucursal
 * @param id identifiador de la suscursal a consultar sus facturas
 */
var obtenerFacturaIdSucursal = async function (id) {
  var respuesta = await Models.FinFactura.findAll({
    where: {
      id_sucursal: id,
    },
  });
  return respuesta;
};
/**
 * Funcion que permite crear un registro
 * de una factura.
 * @param id_cliente Entero identificador del cliente.
 * @param itemsFactura Array de objectos json que contiene información de los items de la factura.
 * @param datosGenerales Objeto Json con los datos generales de una factura.
 */
var guardarFactura = async function (
  id_cliente,
  itemsFactura,
  datosGenerales,
  totales
) {
  fecha = new Date();
  var factura = {
    id_cliente: parseInt(id_cliente),
    id_estado: 1,
    items: itemsFactura,
    totales: totales,
    total: totales.total,
    saldo:
      totales.total >= datosGenerales.abono
        ? totales.total - datosGenerales.abono
        : 0,
    transporte: datosGenerales.transporte,
    descuento: datosGenerales.descuento,
    fec_factura: fecha,
  };
  console.log("llega al dato", factura);
  var deferred = Q.defer();
  var respuesta = await sequelize
    .transaction({ autocommit: false })
    .then(async function (t) {
      factura.num_factura= await obtenerSecuencialFactura(t,deferred);
      Models.FinFactura.create(factura, { transaction: t, returning: true })
        .then(function (facturac) {
          itemsFactura.forEach((element) => {
            element.id_factura = parseInt(facturac.id_factura);
            element.detalle = element.descripcion;
          });
          Models.FinDetFactura.bulkCreate(itemsFactura, {
            transaction: t,
            returning: true,
          })
            .then(function (detFacc) {
              let abono = {
                id_factura: parseInt(facturac.id_factura),
                abono:
                  totales.total >= datosGenerales.abono
                    ? datosGenerales.abono
                    : parseFloat(totales.total.toFixed(2)),
                fec_abono: fecha,
                pago: datosGenerales.abono,
                regreso:
                  totales.total <= datosGenerales.abono
                    ? parseInt(
                        (datosGenerales.abono - totales.total).toFixed(2)
                      )
                    : 0,
                saldo:
                  totales.total >= datosGenerales.abono
                    ? parseInt(
                        (totales.total - datosGenerales.abono).toFixed(2)
                      )
                    : 0,
              };
              Models.FinAboFac.create(abono, {
                transaction: t,
                returning: true,
              })
                .then(function (abonoc) {
                  t.commit();
                  let datos = facturac.id_factura;
                  deferred.resolve(datos);
                })
                .catch(function (error) {
                  t.rollback();
                  deferred.reject(error);
                });
            })
            .catch(function (error) {
              t.rollback();
              deferred.reject(error);
            });
        })
        .catch(function (error) {
          t.rollback();
          deferred.reject(error);
        });
      return deferred.promise;
    });
  return respuesta;
};
/**
 * Funcion que permite obtener una factura por id
 * de una factura.
 * @param id_factura Entero identificador de la factura
 */
var obtenerFactura = async function (id_factura) {
  var respuesta = await Models.FinFactura.find({
    attributes: [
      "id_factura",
      "id_movimiento",
      "id_cliente",
      "id_estado",
      "totales",
      "items",
      "saldo",
      "total",
      "transporte",
      "descuento",
      "fec_factura",
      'num_factura'
    ],
    where: {
      id_factura: id_factura,
    },
    include: [
      {
        model: Models.CliCliente,
        attributes: [
          "id_cliente",
          "id_persona",
          "email",
          "direccion",
          "telefono",
          "celular",
        ],
        include: [
          {
            model: Models.GenPersona,
          },
        ],
      },
    ],
  });
  respuesta.CliCliente.dataValues.nombre =
    respuesta.dataValues.CliCliente.GenPersona.nombre;
  respuesta.CliCliente.dataValues.identificacion =
    respuesta.dataValues.CliCliente.GenPersona.identificacion;
  return respuesta;
};
/**
 * Funcion que permite obtener una factura por id
 * de una factura.
 * @param t objeto que contiene la transacion. 
 */
var obtenerSecuencialFactura = async function (t,deferred) {
  let fecha=new Date();   
  let sec=null;
  let secuencial = await Models.GenSecuencial.find({
    attributes: [
      "id_secuencial",
      "descripcion",
      "secuencial"
    ],
    where: {
      descripcion: 'FACTURA',
    }
  }, {
    transaction: t,
    returning: true,
  }).then(function (data) {
      sec=parseInt(data.dataValues.secuencial,10)+1;
      data=fecha.getFullYear()+"-"+ data.dataValues.secuencial;
      return(data);
  }).catch(function (error) {
    t.rollback();
    deferred.reject(error);
  });
  let updateSecuencial = await Models.GenSecuencial.update({
      secuencial: sec
  }, {
      where: {
        descripcion: 'FACTURA',
      },
      transaction: t,
      returning: true,
  }, { transaction: t }).then(function() {
      return true
  }).catch(function(error) {
      new Error(error);
      deferred.reject(error);
  });
  return secuencial;
};

module.exports.obtenerFacturaIdSucursal = obtenerFacturaIdSucursal;
module.exports.guardarFactura = guardarFactura;
module.exports.obtenerFactura = obtenerFactura;
