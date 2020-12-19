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
/**
 * Function que permite actualizar los datos de un inventario
 * @param {Object} req - Objeto de petición de express
 * @param {Object} res - Objeto de respuesta de express
 **/
var update = async (req, res) => {
    var inventario = req.body.inventario;
    InvInvSucDao.findById(inventario.id_inv_suc).then((resultado) => {
        if (!resultado) {
            Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'El inventario con el id ' + inventario.id_inv_suc + ' no existe',
                erros: { message: 'No existe un cliente con ese ID' }
            });            
        }else{
            InvInvSucDao.update(inventario).then((resultado) => {
       
                return Respuesta.sendJsonResponse(res, 200, {
                   ok: true,
                   mensaje: 'inventario actualizado!',
                   inventario: resultado
               });
           }).catch((error) => {
               console.log(error);
               Respuesta.sendJsonResponse(res, 400, {
                   ok: false,
                   mensaje: 'Error al actualizar el inventario',
                   cliente: error
               });
           });
        }
       
    }).catch((error) => {
        console.log(error);
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar inventario',
            error: error
        });
    });
};
module.exports.obtenerInventarioSucursal = obtenerInventarioSucursal;
module.exports.update=update;
