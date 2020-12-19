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
var guardarFactura = async function (req, res) {
  var itemsFactura = req.body.itemsFactura;
  var id_cliente = req.body.cliente;
  var datosGenerales = req.body.datosGenerales;
  let result = await FinFacturaController.calcularPreciosItemsFacturaServidor(
    itemsFactura,
    datosGenerales,
    res
  );
  if (result) {
    FinFacturaDao.guardarFactura(
      id_cliente,
      result.itemsFactura,
      datosGenerales,
      result.totales
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
  } else {
    Respuesta.sendJsonResponse(res, 500, {
      ok: false,
      mensaje: "Error al calcular los valores",
    });
  }
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
/**
 * Funccion que permite realizar un pago a una factura
 * por su id
 * @param {Object} req - Objeto de petición de express
 * @param {Object} res - Objeto de respuesta de express
 **/
var agregarPagoFacturaId = function (req, res) {
  let abono = req.body.abono;
  FinFacturaDao.agregarPagoFacturaId(abono)
    .then((result) => {
      console.log("dsfasdfasdfasdfaswd", result);
      return Respuesta.sendJsonResponse(res, 200, {
        ok: true,
        message: "!Pago realizado con exito!",
        result: result,
      });
    })
    .catch((error) => {
      console.log(error);
      Respuesta.sendJsonResponse(res, 500, {
        ok: false,
        mensaje: "Error al realizar el pago",
      });
    });
};
var obtenerFacturas = function (req, res) {
  var desde = req.body.desde;
  FinFacturaDao.obtenerFacturas(desde)
    .then(function (result) {
      Respuesta.sendJsonResponse(res, 200, {
        ok: true,
        mensaje: "Facturas obtenidas con exito",
        facturas: result.facturas,
        total: result.count,
      });
    })
    .catch(function (error) {
      console.log("error", error);
      Respuesta.sendJsonResponse(res, 500, {
        ok: false,
        mensaje: "Error al consultar facturas",
        errors: error,
      });
    });
};
module.exports.guardarFactura = guardarFactura;
module.exports.obtenerFactura = obtenerFactura;
module.exports.agregarPagoFacturaId = agregarPagoFacturaId;
module.exports.obtenerFacturas = obtenerFacturas;
