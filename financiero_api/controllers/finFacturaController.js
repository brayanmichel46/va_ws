/**
 * @file Archivo que contiene el modulo FinFacturaController
 * @name finFacturaController.js
 * @author Brayan Michel <brayanmichel46@gmail.com>
 * @license brayanvillota
 * @copyright 2020
 **/
var Respuesta = require("../../server/helpers/response");
var FinFacturaDao = require("../../financiero_api/dao/finFacturaDao");
var FinFacturaController = require("../../financiero_api/controllers/finDetFacturaController");
const { response } = require("express");

/**
 * Modulo finFacturaController administra todas las operaciones que se realizan sobre una factura.
 * @module FinFacturaController
 **/

/**
 * Funccion que permite guardar toda la informacion de una factura
 * @param {Object} req - Objeto de petición de express
 * @param {Object} res - Objeto de respuesta de express
 **/
var guardarFactura = function (req, res) {
  var itemsFactura = req.body.itemsFactura;
  var id_cliente = req.body.cliente;
  var datosGenerales = req.body.datosGenerales;
  var totales = req.body.totales;
  console.log(req.body);
  FinFacturaDao.guardarFactura(
    id_cliente,
    itemsFactura,
    datosGenerales,
    totales
  )
    .then((resultado) => {
      return Respuesta.sendJsonResponse(res, 200, {
        ok: true,
        message: "!Factura creada con exito!",
        result: resultado,
      });
    })
    .catch((error) => {
      console.log(error);
      Respuesta.sendJsonResponse(res, 500, {
        ok: false,
        mensaje: "Error al crear la factura",
        cliente: error,
      });
    });
};

/**
 * Funccion que permite consultar una factura por su id
 * @param {Object} req - Objeto de petición de express
 * @param {Object} res - Objeto de respuesta de express
 **/
var obtenerFactura = function (req, res) {
  let id_factura = req.body.id_factura;
  FinFacturaDao.obtenerFactura(id_factura)
    .then((result) => {
      return Respuesta.sendJsonResponse(res, 200, {
        ok: true,
        message: "!Factura consultada con exito!",
        result: result,
      });
    })
    .catch((error) => {
      console.log(error);
      Respuesta.sendJsonResponse(res, 500, {
        ok: false,
        mensaje: "Error al obtener la factura",
      });
    });
};

module.exports.guardarFactura = guardarFactura;
module.exports.obtenerFactura = obtenerFactura;
