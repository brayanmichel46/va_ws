/**
 *@file Archivo que contiene el modulo GenEstadoDao
 *@name genEstadoDao.js
 *@author Brayan Villota <brayanmichel46@gmail.com>
 *@license brayanmichel
 *@copyright 2020
 */
var Models = require("../../server/models/index");
var sequelize = Models.sequelize;
var Q = require("q");

/**
 * Modulo GenEstadoDao gestiona todas las consultas realizadas a la tabla
 * ger_estado del esquema general
 * @module GenEstadoDao
 */

/**
 * Funcion que permite consultar un estado
 * @param parametros Objeto que contiene los datos por los que se filtra la busqueda
 */
var obtenerEstado = async function (parametros) {
  var respuesta = await Models.GenEstado.find({
    where: parametros,
  });
  return respuesta;
};
module.exports.obtenerEstado = obtenerEstado;
