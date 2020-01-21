var express = require('express');
var app = express();
var jwt = require('jsonwebtoken');

var mdAutenticacion = require('../../server/middlewares/autenticacion')
var genPersonaController = require("../controllers/genPersonaController");

app.get('/rutaprincipal', (req, res, next) => {
    res.status(200).json({
        ok: true,
        mensaje: 'Get general'
    });
});

/*
 ********************************
 ***     RUTAS GENERAL       ***
 ********************************
 */

// =============================================
//  Obtener todos las personas
// =============================================
app.post("/obtenerpersonas", mdAutenticacion.verificaToken, genPersonaController.findAll);
// =============================================
//  Crear una nueva persona
// =============================================
app.post('/crearpersona', mdAutenticacion.verificaToken, genPersonaController.create);
// =============================================
//  Actualizar persona
// =============================================
app.post('/actualizarpersona', mdAutenticacion.verificaToken, genPersonaController.update);
// =============================================
//  Crear persona y cliente
// =============================================
app.post('/crearpersonacliente', mdAutenticacion.verificaToken, genPersonaController.createPersonaCliente);
// =============================================
//  Crear persona y usuario
// =============================================
app.post('/crearpersonausuario', mdAutenticacion.verificaToken, genPersonaController.createPersonaUsuario);

module.exports = app;