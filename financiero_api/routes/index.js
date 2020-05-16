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



/*
 ********************************
 ***     RUTAS CLIENTE       ***
 ********************************
 */

// =============================================
//  Obtener todos los clientes
// =============================================
//app.post("/obtenerclientes", mdAutenticacion.verificaToken, genClienteController.findAll);
// =============================================
//  Crear una nueva cliente
// =============================================
//app.post('/crearcliente', mdAutenticacion.verificaToken, genClienteController.create);
// =============================================
//  Actualizar cliente
// =============================================
//app.post('/actualizarcliente', mdAutenticacion.verificaToken, genClienteController.update);

/**
 * RUTA QUE PERMITE OBTENER EL PRECIO
 * DE CADA UNO DE LOS ITEMS DE UNA FACTURA
 */
app.post(
  "/calcularpreciositemsfactura",
  mdAutenticacion.verificaToken,
  FinDetFacturaController.calcularPreciosItemsFactura
);
module.exports = app;
