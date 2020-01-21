var Respuesta = require("../helpers/respuesta");
var CliClienteDao = require("../dao/cliClienteDao");


// =============================================
//  Retorna un listado de las clientes regitrados
// =============================================
var findAll = function(req, res) {
    var desde = req.body.desde;
    CliClienteDao.findAll(desde).then(function(resultado) {
        CliClienteDao.count().then((conteo) => {
            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'Consulta obtener clientes realizada con exito',
                clientes: resultado,
                total: conteo,
                usuariotoken: req.usuario
            });
        }).catch(function(error) {
            Respuesta.sendJsonResponse(res, 500, {
                ok: false,
                mensaje: 'Error al contar usuarios',
                errors: error
            });
        });
    }).catch(function(error) {
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al consultar los clientes',
            errors: error
        });
    });
};
// =============================================
//  Permite crear un nuevo cliente
// =============================================
var create = function(req, res) {
    CliClienteDao.findByIdPersona(req.body.id_persona).then((resultado) => {
        if (resultado) {
            return Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'La persona ya tiene un cliente asociado',
                erros: { message: 'La persona ya tiene un cliente asociado' }
            });
        };
        CliClienteDao.create(req.body).then(function(resultado) {
            Respuesta.sendJsonResponse(res, 201, {
                ok: true,
                mensaje: 'cliente creado',
                cliente: resultado
            });
        }).catch(function(error) {
            Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'Error al crear el cliente',
                errors: error
            });
        });

    }).catch((error) => {
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar persona',
            error: error
        });
    });

};
// =============================================
//  Permite actualizar la informacion de una 
//  cliente ya registrado
// =============================================
var update = (req, res) => {
    var cliente = req.body;
    CliClienteDao.findById(cliente.id_cliente).then((resultado) => {
        if (!resultado) {
            return Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'El cliente con el id ' + cliente.id_cliente + ' no existe',
                erros: { message: 'No existe un cliente con ese ID' }
            });
        };
        CliClienteDao.update(cliente).then((resultado) => {
            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'cliente actualizado!',
                cliente: resultado
            });
        }).catch((error) => {
            Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'Error al actualizar cliente',
                cliente: error
            });
        });
    }).catch((error) => {
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar cliente',
            error: error
        });
    })
};

module.exports.findAll = findAll;
module.exports.create = create;
module.exports.update = update;