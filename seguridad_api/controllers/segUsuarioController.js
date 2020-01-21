var Respuesta = require("../helpers/respuesta");
var SegUsuarioDao = require("../dao/segUsuarioDao");
var GenPersona = require("../../general_api/dao/genPersonaDao");

var bcrypt = require('bcryptjs');
var jwt = require('jsonwebtoken');
var SEED = require('../../server/config/config').SEED;

var { OAuth2Client } = require('google-auth-library');

var GOOGLE_CLIENT_ID = require('../../server/config/config').GOOGLE_CLIENT_ID;
var GOOGLE_SECRET = require('../../server/config/config').GOOGLE_SECRET;

// =============================================
//  Retorna un listado de los usuarios regitrados
// =============================================
var findAll = function(req, res) {
    var desde = req.body.desde;
    SegUsuarioDao.findAll(desde).then(function(resultado) {
        SegUsuarioDao.findAndCountAll().then((conteo) => {
            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'Consulta get usuarios realizada con exito',
                usuarios: resultado,
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
            mensaje: 'Error al consultar los usuarios',
            errors: error
        });
    });
};
// =============================================
//  Permite crear un nuevo usuario
// =============================================
var create = function(req, res) {

    SegUsuarioDao.findByIdPersona(req.body.id_persona).then((resultado) => {
        if (resultado) {
            return Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'La persona ya tiene un usuario asociado',
                erros: { message: 'La persona ya tiene un usuario asociado' }
            });
        };
        SegUsuarioDao.create(req.body).then(function(resultado) {
            Respuesta.sendJsonResponse(res, 201, {
                ok: true,
                mensaje: 'Usuario creado',
                usuario: resultado
            });
        }).catch(function(error) {
            Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'Error al crear el usuario',
                errors: error
            });
        });
    });

};
// =============================================
//  Permite actualizar la informacion de un 
//  usuario ya registrado
// =============================================
var update = (req, res) => {
    var usuario = req.body;
    SegUsuarioDao.findById(usuario.id_usuario).then((resultado) => {
        if (!resultado) {
            return Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'El usuario con el id ' + usuario.id_usuario + ' no existe',
                erros: { message: 'No existe un usuario con ese ID' }
            });
        };
        SegUsuarioDao.update(usuario).then((resultado) => {
            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'Usuario actualizado!',
                usuario: resultado
            });
        }).catch((error) => {
            Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'Error al actualizar usuario',
                usuario: error
            });
        });
    }).catch((error) => {
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar usuario',
            error: error
        });
    })
};
// =============================================
//  Permite eliminar un usuario
// =============================================
var eliminar = (req, res) => {

    var id_usuario = req.body.id_usuario;
    SegUsuarioDao.findById(id_usuario).then((resultado) => {
        if (!resultado) {
            return Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'El usuario con el id ' + id_usuario + ' no existe',
                erros: { message: 'No existe un usuario con ese ID' }
            });
        };
        SegUsuarioDao.delete(id_usuario).then((resultado) => {
            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'Usuario Eliminado!',
                usuario: resultado
            });
        }).catch((error) => {
            Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'Error al eliminar el usuario',
                usuario: error
            });
        });
    }).catch((error) => {
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al eliminar el usuario',
            error: error
        });
    })
};
// =============================================
//  Login Google
// =============================================
var loginGoogle = (req, res) => {
    var token = req.body.token || '';
    var client = new OAuth2Client(GOOGLE_CLIENT_ID, GOOGLE_SECRET, "");
    async function verify() {
        const ticket = await client.verifyIdToken({
            idToken: token,
            audience: GOOGLE_CLIENT_ID, // Specify the CLIENT_ID of the app that accesses the backend
            // Or, if multiple clients access the backend:
            //[CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3]
        });
        const payload = ticket.getPayload();
        const userid = payload['sub'];
        // If request specified a G Suite domain:
        //const domain = payload['hd'];

        SegUsuarioDao.findByEmail(payload.email).then(usuario => {
            if (usuario) {

                if (!usuario.google) {
                    return Respuesta.sendJsonResponse(res, 400, {
                        ok: false,
                        mensaje: 'Debe usar su autenticacion normal'
                    });
                } else {
                    usuario.password = '=)'
                    var token = jwt.sign({ usuario: usuario }, SEED, { expiresIn: 14400 })

                    Respuesta.sendJsonResponse(res, 200, {
                        ok: true,
                        mensaje: 'Ingreso correcto',
                        usuario: usuario,
                        id_usuario: usuario.id_usuario,
                        token: token
                    });
                }
            } else {
                // si no existe el usuario 
                var persona = {
                    nombre: payload.name,
                    email: payload.email
                };
                var usuario = {
                    email: payload.email,
                    password: '=)',
                    img: payload.picture,
                    google: true
                };
                GenPersona.createPersonaUsuario(persona, usuario).then(datos => {
                    usuario.password = '=)'
                    var token = jwt.sign({ usuario: usuario }, SEED, { expiresIn: 14400 })

                    Respuesta.sendJsonResponse(res, 200, {
                        ok: true,
                        mensaje: 'Ingreso correcto',
                        datos: datos,
                        usuario: datos.usuario,
                        id_usuario: datos.usuario.id_usuario,
                        token: token
                    });
                }).catch(error => {
                    return Respuesta.sendJsonResponse(res, 500, {
                        ok: false,
                        mensaje: 'Error al crear usuario',
                        errors: error
                    });
                });
            }
        }).catch(error => {
            return Respuesta.sendJsonResponse(res, 500, {
                ok: false,
                mensaje: 'Error al buscar usuario - login',
                errors: error
            });
        });
    }
    verify().catch(error => {
        Respuesta.sendJsonResponse(res, 400, {
            ok: true,
            mensaje: 'Fallo la autenticacion token no valido',
            errors: error
        });
    });

};
// =============================================
//  Login
// =============================================
var login = (req, res) => {

    var body = req.body;
    SegUsuarioDao.findByEmail(body.email).then((usuario) => {
        if (!usuario) {
            return Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'Credenciales incorrectas -email',
                erros: { message: 'Credenciales incorrectas -email' }
            });
        } else if (!bcrypt.compareSync(body.password, usuario.password)) {
            return Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'Credenciales incorrectas -password',
                erros: { message: 'Credenciales incorrectas -password' }
            });
        } else {
            // Crear un token
            usuario.password = '=)'
            var token = jwt.sign({ usuario: usuario }, SEED, { expiresIn: 14400 })

            Respuesta.sendJsonResponse(res, 200, {
                ok: true,
                mensaje: 'Ingreso correcto',
                usuario: usuario,
                id_usuario: usuario.id_usuario,
                token: token
            });
        }

    }).catch((error) => {
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar el usuario',
            error: error
        });
    })
}
module.exports.findAll = findAll;
module.exports.create = create;
module.exports.update = update;
module.exports.delete = eliminar;
module.exports.login = login;
module.exports.loginGoogle = loginGoogle;