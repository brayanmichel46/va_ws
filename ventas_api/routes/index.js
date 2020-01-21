var express = require('express');
var app = express();
var jwt = require('jsonwebtoken');

var mdAutenticacion = require('../../server/middlewares/autenticacion')
var genClienteController = require("../controllers/cliClienteController");

app.get('/rutaprincipal', (req, res, next) => {
    res.status(200).json({
        ok: true,
        mensaje: 'Get cliente'
    });
});

/*
 ********************************
 ***     RUTAS CLIENTE       ***
 ********************************
 */

// =============================================
//  Obtener todos los clientes
// =============================================
app.post("/obtenerclientes", mdAutenticacion.verificaToken, genClienteController.findAll);
// =============================================
//  Crear una nueva cliente
// =============================================
app.post('/crearcliente', mdAutenticacion.verificaToken, genClienteController.create);
// =============================================
//  Actualizar cliente
// =============================================
app.post('/actualizarcliente', mdAutenticacion.verificaToken, genClienteController.update);


module.exports = app;