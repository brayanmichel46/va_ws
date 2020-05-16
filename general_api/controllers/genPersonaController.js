var Respuesta = require("../helpers/respuesta");
var GenPersonaDao = require("../dao/genPersonaDao");

var bcrypt = require('bcryptjs');
var jwt = require('jsonwebtoken');
var SEED = require('../../server/config/config').SEED;

// =============================================
//  Retorna un listado de las personas regitradas
// =============================================
var findAll = function(req, res) {
    var desde = req.body.desde || 0;
    desde = Number(desde);
    GenPersonaDao.findAll(desde).then(function(resultado) {
        GenPersonaDao.findAndCountAll().then((conteo) => {

            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'Consulta obtener personas realizada con exito',
                personas: resultado,
                total: conteo,
                usuariotoken: req.usuario
            });
        }).catch(function(error) {
            Respuesta.sendJsonResponse(res, 500, {
                ok: false,
                mensaje: 'Error al contar personas',
                errors: error
            });
        });
    }).catch(function(error) {
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al consultar las personas',
            errors: error
        });
    });
};
// =============================================
//  Permite crear una nueva persona
// =============================================
var create = function(req, res) {
    GenPersonaDao.create(req.body).then(function(resultado) {
        Respuesta.sendJsonResponse(res, 201, {
            ok: true,
            mensaje: 'Persona creada',
            persona: resultado
        });
    }).catch(function(error) {
        Respuesta.sendJsonResponse(res, 400, {
            ok: false,
            mensaje: 'Error al crear la persona',
            errors: error
        });
    });
};
// =============================================
//  Permite actualizar la informacion de una 
//  persona ya registrada
// =============================================
var update = (req, res) => {
    var persona = req.body;
    GenPersonaDao.findById(persona.id_persona).then((resultado) => {
        if (!resultado) {
            return Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'La persona con el id ' + persona.id_persona + ' no existe',
                erros: { message: 'No existe una persona con ese ID' }
            });
        };
        GenPersonaDao.update(persona).then((resultado) => {
            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'persona actualizado!',
                persona: resultado
            });
        }).catch((error) => {
            Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'Error al actualizar persona',
                persona: error
            });
        });
    }).catch((error) => {
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar persona',
            error: error
        });
    })
};
// =============================================
//  Permite crear una persona y al mismo tiempo crearla como cliente
// =============================================
var createPersonaCliente = function(req, res) {
    var persona = req.body.persona;
    var cliente = req.body.cliente;
    GenPersonaDao.findByIdentificacion(persona.identificacion).then(function(personae) {
        personae = JSON.stringify(personae);
        personae = JSON.parse(personae);
        if (personae) {
            if (personae.CliCliente) {
                Respuesta.sendJsonResponse(res, 400, {
                    ok: false,
                    mensaje: 'La persona ya esta registrada como cliente',
                    errors: { message: 'La persona ya esta registrada como cliente' }
                });
            } else {
                cliente.id_persona = personae.id_persona;
                GenPersonaDao.createPersonaCliente(null, cliente).then(function(resultado) {
                    Respuesta.sendJsonResponse(res, 201, {
                        ok: true,
                        mensaje: 'cliente creado',
                        cliente: resultado
                    });
                }).catch(function(error) {
                    Respuesta.sendJsonResponse(res, 500, {
                        ok: false,
                        mensaje: 'Error al crear el cliente',
                        errors: error
                    });
                });
            }

        } else {
            GenPersonaDao.createPersonaCliente(persona, cliente).then(function(resultado) {
                Respuesta.sendJsonResponse(res, 201, {                    
                    ok: true,
                    mensaje: 'persona y cliente creado',
                    datos: resultado
                });
            }).catch(function(error) {
                console.log("this is error!!",error,req.body);

                Respuesta.sendJsonResponse(res, 500, {
                    ok: false,
                    mensaje: 'Error al crear la persona y el cliente',
                    errors: error
                });
            });
        }
    });
};
// =============================================
//  Permite crear una persona y al mismo tiempo crearla como usuario
// =============================================
var createPersonaUsuario = function(req, res) {
    var persona = req.body.persona;
    var usuario = req.body.usuario;
    usuario.password = bcrypt.hashSync(usuario.password, 10);
    GenPersonaDao.findByIdentificacion(persona.identificacion).then(function(personae) {
        personae = JSON.stringify(personae);
        personae = JSON.parse(personae);
        if (personae) {
            if (personae.SegUsuario) {
                Respuesta.sendJsonResponse(res, 400, {
                    ok: false,
                    mensaje: 'La persona ya esta registrada como usuario',
                    errors: { message: 'La persona ya esta registrada como usuario' }
                });
            } else {
                usuario.id_persona = personae.id_persona;
                GenPersonaDao.createPersonaUsuario(null, usuario).then(function(resultado) {
                    Respuesta.sendJsonResponse(res, 201, {
                        ok: true,
                        mensaje: 'usuario creado',
                        usuario: resultado
                    });
                }).catch(function(error) {
                    Respuesta.sendJsonResponse(res, 500, {
                        ok: false,
                        mensaje: 'Error al crear el usuario',
                        errors: error
                    });
                });
            }

        } else {
            GenPersonaDao.createPersonaUsuario(persona, usuario).then(function(resultado) {
                Respuesta.sendJsonResponse(res, 201, {
                    ok: true,
                    mensaje: 'persona y usuario creado',
                    datos: resultado
                });
            }).catch(function(error) {
                Respuesta.sendJsonResponse(res, 500, {
                    ok: false,
                    mensaje: 'Error al crear la persona y el usuario',
                    errors: error
                });
            });
        }
    });
};

module.exports.findAll = findAll;
module.exports.create = create;
module.exports.update = update;
module.exports.createPersonaCliente = createPersonaCliente;
module.exports.createPersonaUsuario = createPersonaUsuario;