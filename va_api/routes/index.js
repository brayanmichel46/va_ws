var express = require('express');
var fileUpload = require('express-fileupload');
var app = express();
var jwt = require('jsonwebtoken');
var busquedaController = require('../controllers/busquedaController');
var UploadController = require('../controllers/uploadController');
var mdAutenticacion = require('../../server/middlewares/autenticacion')

app.use(fileUpload());

app.get('/', (req, res, next) => {
    res.status(200).json({
        ok: true,
        mensaje: 'Peticion realizada correctamente P: 3000'
    });
});

/*
 ****************************************
 ***     RUTAS BUSQUEDAS GLOBALES    ***
 ****************************************
 */

// =============================================
//  Busqueda general
// =============================================
app.post('/busqueda', mdAutenticacion.verificaToken, busquedaController.busqueda);
// =============================================
//  Busqueda por coleccion de datos
// =============================================
app.post('/busquedacoleccion', mdAutenticacion.verificaToken, busquedaController.busquedaColeccion);

/*
 ************************************
 ***     RUTAS UPLOAD ARCHIVOS    ***
 ************************************
 */

// =============================================
//  Rutas imagenes de colecciones
// =============================================
app.post('/upload', mdAutenticacion.verificaToken, UploadController.upload);
app.post('/obtenerimgcoleccion', mdAutenticacion.verificaToken, UploadController.obtenerImgColeccion);
module.exports = app;