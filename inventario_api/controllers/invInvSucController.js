/**
 * @file Archivo que contiene el modulo InvInvSuc 
 * @name invInvSucController.js
 * @author Brayan Michel <brayanmichel46@gmail.com>
 * @license brayanvillota
 * @copyright 2020
 **/

var Respuesta = require("../../server/helpers/response");
var InvInvSucDao = require("../dao/invInvSucDao");

/**
 * Modulo invInvSucController administra todas las operaciones que se realizan sobre el inventario de una sucursal
 * @module InvInvSucController
 **/

/**
 * Function que permite obtener un listado de todo el inventario de una sucursal
 * @param {Object} req - Objeto de petición de express
 * @param {Object} res - Objeto de respuesta de express
 **/
var obtenerInventarioSucursal = function(req, res) {
    var desde = req.body.desde;
    InvInvSucDao.obtenerInventarioSucursal(desde).then(function(resultado) {
        InvInvSucDao.count().then((conteo) => {
            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'Exito en la consuta',
                resultado: resultado,
                total: conteo,
                usuariotoken: req.usuario
            });
        }).catch(function(error) {
            Respuesta.sendJsonResponse(res, 500, {
                ok: false,
                mensaje: 'Error al contar el inventario',
                errors: error
            });
        });
    }).catch(function(error) {
        console.log("error",error);
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al consultar el inventario',
            errors: error
        });
    });
};

module.exports.obtenerInventarioSucursal = obtenerInventarioSucursal;
