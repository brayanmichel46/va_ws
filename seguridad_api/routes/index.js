var express = require('express');
var app = express();
var jwt = require('jsonwebtoken');

var mdAutenticacion = require('../../server/middlewares/autenticacion')
var SegUsuarioController = require("../controllers/segUsuarioController");

app.get('/rutaprincipal', (req, res, next) => {
    res.status(200).json({
        ok: true,
        mensaje: 'Get seguridad'
    });
});

/*
 ********************************
 ***     RUTAS USUARIO        ***
 ********************************
 */

// =============================================
//  Obtener todos los usuario
// =============================================
app.post("/obtenerusuarios", mdAutenticacion.verificaToken, SegUsuarioController.findAll);
// =============================================
//  Crear un nuevo usuario
// =============================================
app.post('/crearusuario', SegUsuarioController.create);
// =============================================
//  Crear un nuevo usuario web
// =============================================
app.post('/crearusuarioweb', SegUsuarioController.crearUsuarioWeb);
// =============================================
//  Actualizar usuario
// =============================================
app.post('/actualizarusuario', mdAutenticacion.verificaToken, SegUsuarioController.update);
// =============================================
//  Borrar un usuario
// =============================================
app.post('/eliminarusuario', mdAutenticacion.verificaToken, SegUsuarioController.delete);
// =============================================
//  Desactivar un usuario
// =============================================
app.post('/desactivarusuario', mdAutenticacion.verificaToken, SegUsuarioController.desactivarUsuario);
// =============================================
//  Activar un usuario
// =============================================
app.post('/activarusuario', mdAutenticacion.verificaToken, SegUsuarioController.activarUsuario);

/*
 ****************************************
 ***       RUTAS AUTENTICACION        ***
 ****************************************
 */

// =============================================
//  Autenticacion normal
// =============================================
app.post('/login', SegUsuarioController.login);

// =============================================
//  Autenticacion de Google
// =============================================
app.post('/logingoogle', SegUsuarioController.loginGoogle);
module.exports = app;