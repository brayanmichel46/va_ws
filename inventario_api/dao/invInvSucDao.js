/**
 *@file Archivo que contiene el modulo InvInvSucDao
 *@name InvInvSucDao.js
 *@author Brayan Villota <brayanmichel46@gmail.com>
 *@license brayanmichel
 *@copyright 2020
 */
var Models = require("../../server/models/index");
var sequelize = Models.sequelize;
var Q = require("q");

/**
 * Modulo InvInvSuc gestiona todas las consultas realizadas a la tabla
 * inv_inv_suc del esquema inventario
 * @module InvInvSucDao
 */

/**
 * Funcion que permite consultar todo el
 * inventario registrado de una sucursal
 * @param desde Varialble que contiene el punto de partida de la consulta
 */
var obtenerInventarioSucursal = async function (desde) {
  var limit = 5;
  var respuesta = await Models.InvInvSuc.findAll({
    offset: desde,
    limit: 5,
    include: [
      {
        model: Models.InvInventario,
        attributes: [
          "id_inventario",
          "id_referencia",
          "descripcion",
          "id_uni_medida",
          "id_formula",
          "nesecita_p",
        ],
        include: [
          {
            model: Models.GenUniMedida,
            attributes: ["unidad", "n_parametros"],
          },
        ],
      },
    ],
  });
  console.log(respuesta);

  await respuesta.forEach(async (element) => {
    (element.dataValues.descripcion =
      element.dataValues.InvInventario.descripcion),
      (element.dataValues.id_formula =
        element.dataValues.InvInventario.id_formula),
      (element.dataValues.nesecita_p =
        element.dataValues.InvInventario.nesecita_p),
      (element.dataValues.unidad =
        element.dataValues.InvInventario.GenUniMedida.unidad),
      (element.dataValues.n_parametros =
        element.dataValues.InvInventario.GenUniMedida.n_parametros);
    //delete element.dataValues.InvInventario.GenUniMedida;
    delete element.dataValues.InvInventario;
  });
  return respuesta;
};

var count = () => {
  return Models.InvInvSuc.count({});
};

var update = async (inventario) => {
  console.log(inventario);
  let objetoUpdate = {};

  if (inventario.costo_promedio) {
    objetoUpdate.costo_promedio = inventario.costo_promedio;
  }
  if (inventario.vr_venta_domicilio) {
    objetoUpdate.vr_venta_domicilio = inventario.vr_venta_domicilio;
  }
  if (inventario.vr_venta_local) {
    objetoUpdate.vr_venta_local = inventario.vr_venta_local;
  }
  let inv = await Models.InvInvSuc.update(objetoUpdate, {
    where: {
      id_inv_suc: inventario.id_inv_suc,
    },
  });

  return inv;
};

var findById = (id_inv_suc) => {
  return Models.InvInvSuc.find({
    where: {
      id_inv_suc: id_inv_suc,
    },
  });
};

module.exports.obtenerInventarioSucursal = obtenerInventarioSucursal;
module.exports.count = count;
module.exports.update = update;
module.exports.findById = findById;
