/**
 *@file Archivo que contiene el modulo FinFacturaDao
 *@name finFacturaDao.js
 *@author Brayan Villota <brayanmichel46@gmail.com>
 *@license brayanmichel
 *@copyright 2020
 */
var Models = require("../../server/models/index");
var GenEstado = require("../../general_api/dao/genEstadoDao");
var sequelize = Models.sequelize;
var Q = require("q");
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
  if (datosGenerales.esCotizacion) {
    factura.saldo = factura.total;
  }
  let estado = "COTIZACION";
  if (factura.saldo == 0 && !datosGenerales.esCotizacion)
    estado = "CANCELADO(A)";
  if (factura.saldo > 0 && !datosGenerales.esCotizacion) estado = "ABONO";
  factura.id_estado = await GenEstado.obtenerEstado({ descripcion: estado });
  factura.id_estado = factura.id_estado.id_estado;
  var deferred = Q.defer();
  var respuesta = await sequelize
    .transaction({ autocommit: false })
    .then(async function (t) {
      factura.num_factura = datosGenerales.esCotizacion
        ? await obtenerSecuencialFactura(t, deferred, "COTIZACION")
        : await obtenerSecuencialFactura(t, deferred, "FACTURA");
      console.log("escocccccccccccccccccccc", datosGenerales.esCotizacion);
      if (
        datosGenerales.id_factura &&
        !datosGenerales.antEsCotizacion &&
        !datosGenerales.esCotizacion
      ) {
        for (const iterator of datosGenerales.items_factura) {
          console.log(
            "entrosdfasdfasdfasdfasdfasdfasdfasdfasdfa",
            datosGenerales.items_factura.length
          );
          if (iterator.Componentes.length > 0) {
            for (const iterator2 of iterator.Componentes) {
              if (iterator2.cantidad_item > 0) {
                let updateInv = await sumarCantidadesInventario(
                  t,
                  deferred,
                  iterator2.id_inv_suc,
                  iterator2.cantidad,
                  parseFloat(iterator2.costo_promedio)
                );
              }
            }
          } else {
            if (iterator.cantidad_item > 0) {
              let updateInv = await sumarCantidadesInventario(
                t,
                deferred,
                iterator.id_inv_suc,
                iterator.cantidad,
                parseFloat(iterator.costo_promedio)
              );
            }
          }
        }
        await cambiarEstadoFactura(
          t,
          deferred,
          "ELIMINADO(A)",
          datosGenerales.id_factura
        );
      }
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
              if (!datosGenerales.esCotizacion) {
                Models.FinAboFac.create(abono, {
                  transaction: t,
                  returning: true,
                })
                  .then(async function (abonoc) {
                    for (const iterator of itemsFactura) {
                      console.log("antessss", iterator.Componentes.length);

                      if (iterator.Componentes.length > 0) {
                        for (const iterator2 of iterator.Componentes) {
                          if (iterator2.cantidad_item > 0) {
                            let updateInv = await restarCantidadesInventario(
                              t,
                              deferred,
                              iterator2.id_inv_suc,
                              iterator2.cantidad
                            );
                          }
                        }
                      } else {
                        if (iterator.cantidad_item > 0) {
                          let updateInv = await restarCantidadesInventario(
                            t,
                            deferred,
                            iterator.id_inv_suc,
                            iterator.cantidad
                          );
                        }
                      }
                    }
                    t.commit();
                    let datos = facturac.id_factura;
                    deferred.resolve(datos);
                  })
                  .catch(function (error) {
                    t.rollback();
                    deferred.reject(error);
                  });
              } else {
                t.commit();
                let datos = facturac.id_factura;
                deferred.resolve(datos);
              }
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
      "num_factura",
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
      {
        attributes: ["descripcion"],
        model: Models.GenEstado,
      },
      {
        model: Models.FinAboFac,
      },
    ],
  });
  respuesta.CliCliente.dataValues.nombre =
    respuesta.dataValues.CliCliente.GenPersona.nombre;
  respuesta.CliCliente.dataValues.identificacion =
    respuesta.dataValues.CliCliente.GenPersona.identificacion;
  respuesta.dataValues.estado = respuesta.dataValues.GenEstado.descripcion;
  return respuesta;
};
/**
 * Funcion que permite obtener una factura por id
 * de una factura.
 * @param t objeto que contiene la transacion.
 * @param deferred Objeto
 * @param s String que contiene que tipo de secuencial se nesecita
 */
var obtenerSecuencialFactura = async function (t, deferred, s) {
  let fecha = new Date();
  let secuencial = await Models.GenSecuencial.update(
    {
      secuencial: sequelize.literal("secuencial + 1"),
    },
    {
      where: {
        descripcion: s,
      },
      transaction: t,
      returning: true,
    },
    { transaction: t }
  )
    .spread(function (contador, data) {
      prefijo = "FAC-";
      if (s == "COTIZACION") prefijo = "COT-";
      data =
        prefijo + fecha.getFullYear() + "-" + data[0].dataValues.secuencial;
      return data;
    })
    .catch(function (error) {
      new Error(error);
      t.rollback();
      deferred.reject(error);
    });
  return secuencial;
};
/**
 * Funcion que permite obtener una factura por id
 * de una factura.
 * @param t objeto que contiene la transacion.
 * @param deferred Objeto
 * @param estado String que contiene el nombre del estado por el que cambiara la factura.
 * @param id_factura Entero que identifica la factura.
 */
var cambiarEstadoFactura = async function (t, deferred, estado, id_factura) {
  let estadoEncontrado = await Models.GenEstado.find(
    {
      attributes: ["id_estado", "descripcion"],
      where: {
        descripcion: estado,
      },
    },
    {
      transaction: t,
      returning: true,
    }
  )
    .then(function (data) {
      return data;
    })
    .catch(function (error) {
      t.rollback();
      deferred.reject(error);
    });
  let updateEstado = await Models.FinFactura.update(
    {
      id_estado: estadoEncontrado.id_estado,
    },
    {
      where: {
        id_factura: id_factura,
      },
      transaction: t,
      returning: true,
    },
    { transaction: t }
  )
    .then(function () {
      return true;
    })
    .catch(function (error) {
      new Error(error);
      t.rollback();
      deferred.reject(error);
    });
  return updateEstado;
};
/**
 * Funcion que permite restar la cantidad
 * de un inventario determinador.
 * @param t objeto que contiene la transacion.
 * @param deferred Objeto
 * @param id_inv_suc Entero que identifica el inventario
 * @param c Float que indica la cantidad a disminuir del inventario
 */
var restarCantidadesInventario = async function (t, deferred, id_inv_suc, c) {
  let updateInvSuc = await Models.InvInvSuc.update(
    {
      cantidad: sequelize.literal(
        "CASE WHEN cantidad-" + c + "<0 THEN 0" + " ELSE cantidad-" + c + " END"
      ),
    },
    {
      where: {
        id_inv_suc: parseInt(id_inv_suc),
      },
      transaction: t,
      returning: true,
    },
    { transaction: t }
  )
    .then(function () {
      return true;
    })
    .catch(function (error) {
      new Error(error);
      t.rollback();
      deferred.reject(error);
    });
  return updateInvSuc;
};
/**
 * Funcion que permite sumar la cantidad
 * de un inventario determinador y actualizar su costo_promedio.
 * @param t objeto que contiene la transacion.
 * @param deferred Objeto
 * @param id_inv_suc Entero que identifica el inventario
 * @param c Float que indica la cantidad a disminuir del inventario
 * @param cp Float que indica el costo promedio anterior del inventario.
 */
var sumarCantidadesInventario = async function (
  t,
  deferred,
  id_inv_suc,
  c,
  cp
) {
  console.log("cantidades", c);
  let updateInvSuc = await Models.InvInvSuc.update(
    {
      cantidad: sequelize.literal("cantidad + " + c),
      costo_promedio: sequelize.literal(
        "((costo_promedio*cantidad)+(" + cp * c + "))/(cantidad+" + c + ")"
      ),
    },
    {
      where: {
        id_inv_suc: parseInt(id_inv_suc),
      },
      transaction: t,
      returning: true,
    },
    { transaction: t }
  )
    .then(function () {
      return true;
    })
    .catch(function (error) {
      new Error(error);
      t.rollback();
      deferred.reject(error);
    });
  return updateInvSuc;
};
/**
 * Funcion que permite agregar un pago a una
 * @param abono objeto que contiene el pago a realizar.
 */
var agregarPagoFacturaId = async function (abono) {
  console.log("llegaaaaaaaaaaaaaaaaaaaaaaaaa", abono);
  let deferred = Q.defer();
  let respuesta = await sequelize
    .transaction({ autocommit: false })
    .then(function (t) {
      Models.FinFactura.find(
        {
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
            "num_factura",
          ],
          where: {
            id_factura: parseInt(abono.id_factura),
          },
        },
        { transaction: t, returning: true }
      )
        .then(function (factura) {
          console.log(
            "factura obtneiadfasdfasdfasdfasdf asldkfjaksldfj",
            factura
          );
          let fecha = new Date();
          abono.abono =
            parseFloat(factura.saldo) >= abono.abono
              ? abono.abono
              : parseFloat(factura.saldo);
          abono.fec_abono = fecha;
          abono.regreso =
            abono.pago - abono.abono < 0 ? 0 : abono.pago - abono.abono;
          abono.saldo = parseFloat(factura.saldo) - abono.abono;
          Models.FinAboFac.create(abono, { transaction: t, returning: true })
            .then(function (pagoc) {
              Models.FinFactura.update(
                {
                  saldo: abono.saldo,
                },
                {
                  where: {
                    id_factura: parseInt(factura.id_factura),
                  },
                  transaction: t,
                  returning: true,
                },
                { transaction: t }
              )
                .then(async function (data) {
                  if (abono.saldo == 0) {
                    await cambiarEstadoFactura(
                      t,
                      deferred,
                      "CANCELADO(A)",
                      parseInt(factura.id_factura)
                    );
                    t.commit();
                    deferred.resolve(data);
                  } else {
                    t.commit();
                    deferred.resolve(data);
                  }
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
          deferred.reject(error);
        });
      return deferred.promise;
    });
  return respuesta;
};

var obtenerFacturas = async function (desde) {
  var limit = 5;
  var facturas = await Models.FinFactura.findAll({
    offset: desde,
    limit: 5,
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
      "num_factura",
    ],
    include:[
      {
        attributes: ["descripcion"],
        model: Models.GenEstado,
      },
      {
        model:Models.CliCliente,
        include: [
          {
            model: Models.GenPersona,
            attributes: ["nombre", "identificacion"],
          },
        ],
      }
    ],
    order:[
      ['fec_factura','DESC']
    ]
  });
  for (const f of facturas) {
    f.dataValues.nombre = f.CliCliente.GenPersona.nombre;
    f.dataValues.identificacion = f.CliCliente.GenPersona.identificacion;
    f.dataValues.estado = f.dataValues.GenEstado.descripcion;
    delete f.CliCliente;
    delete f.GenPersona;
    delete f.GenEstado;
  }
  var count = await Models.FinFactura.count({});

  /* await resultado.forEach(async (element) => {
    console.log(element.dataValues);
    element.dataValues.nombre = element.dataValues.GenPersona.nombre;
    element.dataValues.identificacion =
    element.dataValues.GenPersona.identificacion;
    delete element.dataValues.GenPersona;
  }); */
  return {facturas,count};
};

module.exports.obtenerFacturaIdSucursal = obtenerFacturaIdSucursal;
module.exports.guardarFactura = guardarFactura;
module.exports.obtenerFactura = obtenerFactura;
module.exports.agregarPagoFacturaId = agregarPagoFacturaId;
module.exports.obtenerFacturas = obtenerFacturas;
