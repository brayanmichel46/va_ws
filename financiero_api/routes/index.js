/**
 *@file Archivo que contiene las rutas de servidor del modulo financiero
 *@name index.js
 *@author Brayan Villota <brayanmichel46@gmail.com>
 *@license brayanmichel
 *@copyright 2020
 */
var express = require("express");
var app = express();
var jwt = require("jsonwebtoken");

var mdAutenticacion = require("../../server/middlewares/autenticacion");
var FinDetFacturaController = require("../controllers/finDetFacturaController");
var FinFacturaController = require("../controllers/finFacturaController");

/*
 ********************************
 RUTAS DETALLE FACTURA
 ********************************
 */

/**
 * RUTA QUE PERMITE OBTENER EL PRECIO
 * DE CADA UNO DE LOS ITEMS DE UNA FACTURA
 */
app.post(
  "/calcularpreciositemsfactura",
  mdAutenticacion.verificaToken,
  FinDetFacturaController.calcularPreciosItemsFactura
);
/*
 ********************************
 RUTAS FACTURA
 ********************************
 */
/**
 * RUTA QUE PERMITE GUARDAR UNA
 * FACTURA
 */
app.post(
  "/guardarfactura",
  mdAutenticacion.verificaToken,
  FinFacturaController.guardarFactura
);
/**
 * RUTA QUE PERMITE OBTENER UNA
 * FACTURA
 */
app.post(
  "/obtenerfactura",
  mdAutenticacion.verificaToken,
  FinFacturaController.obtenerFactura
);
/**
 * RUTA QUE PERMITE REALIZAR UN PAGO A UNA
 * FACTURA
 */
app.post(
  "/agregarPagoFacturaId",
  mdAutenticacion.verificaToken,
  FinFacturaController.agregarPagoFacturaId
);
/**
 * RUTA QUE PERMITE OBTENER EL LISTADO DE 
 * FACTURAS DE UNA SUCURSAL
 */
app.post(
  "/obtenerfacturas",
  mdAutenticacion.verificaToken,
  FinFacturaController.obtenerFacturas
);

module.exports = app;
