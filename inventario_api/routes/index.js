/**
 *@file Archivo que contiene las rutas de servidor del modulo inventario
 *@name index.js
 *@author Brayan Villota <brayanmichel46@gmail.com>
 *@license brayanmichel
 *@copyright 2020
 */

var express = require("express");
var app = express();
var jwt = require("jsonwebtoken");

var mdAutenticacion = require("../../server/middlewares/autenticacion");
var InvInvSuc = require("../controllers/invInvSucController");

/*
 ************************************************
 *** RUTAS TABLA INVENTARIO SUCURSAL ***
 ************************************************
 */

/**
 * RUTA QUE PERMITE OBTENER UN LISTADO
 * DE TODO EL INVENTARIO DE UNA SUCURSAL
 */
app.post(
  "/obtenerinventariosucursal",
  //mdAutenticacion.verificaToken,
  InvInvSuc.obtenerInventarioSucursal
);

module.exports = app;
