/**
 *@file Archivo que contiene el modulo ParFormulaDao
 *@name parFormulaDao.js
 *@author Brayan Villota <brayanmichel46@gmail.com>
 *@license brayanmichel
 *@copyright 2020
 */
var Models = require("../../server/models/index");
var sequelize = Models.sequelize;
var Q = require("q");

/**
 * Modulo ParFormulaDao gestiona todas las consultas realizadas a la tabla
 * par_formula del esquema general
 * @module ParFormulaDao
 */

/**
 * Funcion que permite consultar todo el
 * inventario registrado de una sucursal
 * @param ids Array con que contiene los ids de las formulas a consultar
 */
var obtenerFormulaId = async function (ids) {
  var limit = 5;
  var respuesta = await Models.ParFormula.findAll({
    where: {
      id_formula: ids,
    },
  });
  return respuesta;
};
module.exports.obtenerFormulaId = obtenerFormulaId;
