var Respuesta = require("../../server/helpers/respuesta");
var SegUsuarioDao = require("../../seguridad_api/dao/segUsuarioDao")
var CliClienteDao = require("../../ventas_api/dao/cliClienteDao");
var GenPersonaDao = require("../../general_api/dao/genPersonaDao");
var fs = require('fs');
// =============================================
//  Permite buscar en todas las colecciones de datos
// =============================================
var upload = function(req, res) {
    var coleccion = req.body.coleccion;
    var id = req.body.id;
    var coleccionesValidas = ['clientes', 'usuarios', 'personas'];
    if (coleccionesValidas.indexOf(coleccion) < 0) {
        return Respuesta.sendJsonResponse(res, 400, {
            ok: false,
            mensaje: 'Tipo de coleccion no es valida',
            errors: { message: 'Tipo de coleccion no es valida' }
        });
    }
    if (!req.files) {
        return Respuesta.sendJsonResponse(res, 400, {
            ok: false,
            mensaje: 'No envio ningun archivo',
            errors: { message: 'Debe seleccionar una imagen' }
        });
    }
    // obtener nombre del archivo
    var archivo = req.files.imagen;
    var nombreCortado = archivo.name.split('.')
    var extensionArchivo = nombreCortado[nombreCortado.length - 1];
    // validacion de extenciones
    var extencionesValidas = ['png', 'jpeg', 'gif', 'jpg']
    if (extencionesValidas.indexOf(extensionArchivo) < 0) {
        return Respuesta.sendJsonResponse(res, 400, {
            ok: false,
            mensaje: 'Extension no valida',
            errors: { message: 'Las extenciones validas son: ' + extencionesValidas.join(', ') }
        });
    }
    // personalizar nombre archivo
    var nombreArchivo = `${id}-${new Date().getMilliseconds()}.${extensionArchivo}`;
    // mover archivo temporal a un path en especifico
    var path = `./uploads/${coleccion}/${nombreArchivo}`;
    archivo.mv(path, err => {
        if (err) {
            return Respuesta.sendJsonResponse(res, 500, {
                ok: false,
                mensaje: 'Error al mover el archivo',
                errors: err
            });
        }
        subirPorColeccion(coleccion, id, nombreArchivo, res);
    });
};

function subirPorColeccion(coleccion, id, nombreArchivo, res) {
    switch (coleccion) {
        case 'usuarios':
            SegUsuarioDao.findById(id).then(usuario => {
                if (usuario) {
                    var pathViejo = '../../uploads/' + [coleccion] + '/' + usuario.img;
                    // si existe el archivo elimina la imagen anterior
                    console.log("aqui",pathViejo);
                    if (fs.existsSync(pathViejo)) {

                        fs.unlink(pathViejo);
                    }
                    SegUsuarioDao.update({ id_usuario: usuario.id_usuario, img: nombreArchivo }).then(resultado => {

                        SegUsuarioDao.findById(id).then(usuarioActualizado => {
                            Respuesta.sendJsonResponse(res, 200, {
                                ok: true,
                                mensaje: 'Imagen de usuario actualizada',
                                usuario: usuarioActualizado
                            });
                        }).catch(error => {
                            Respuesta.sendJsonResponse(res, 500, {
                                ok: false,
                                mensaje: 'Error al retornar el usuario',
                                errors: error
                            });
                        });
                    }).catch(error => {
                        Respuesta.sendJsonResponse(res, 500, {
                            ok: false,
                            mensaje: 'Error al actualizar el usuario',
                            errors: error
                        });
                    });
                } else {
                    Respuesta.sendJsonResponse(res, 400, {
                        ok: false,
                        mensaje: 'El usuario no existe',
                        errors: { message: 'El id de usuario no existe' }
                    });
                }
            }).catch(error => {
                console.log("error",error);
                Respuesta.sendJsonResponse(res, 500, {
                    ok: false,
                    mensaje: 'Error al buscar el usuario',
                    errors: error
                });
            });
            break;
        case 'clientes':
            CliClienteDao.findById(id).then(cliente => {
                if (cliente) {
                    var pathViejo = './uploads/' + [coleccion] + '/' + cliente.img;
                    // si existe el archivo elimina la imagen anterior
                    if (fs.existsSync(pathViejo)) {

                        fs.unlink(pathViejo);
                    }
                    CliClienteDao.update({ id_cliente: cliente.id_cliente, img: nombreArchivo }).then(resultado => {

                        CliClienteDao.findById(id).then(clienteActualizado => {
                            Respuesta.sendJsonResponse(res, 200, {
                                ok: true,
                                mensaje: 'Imagen de cliente actualizada',
                                cliente: clienteActualizado
                            });
                        }).catch(error => {
                            Respuesta.sendJsonResponse(res, 500, {
                                ok: false,
                                mensaje: 'Error al retornar el cliente',
                                errors: error
                            });
                        });
                    }).catch(error => {
                        Respuesta.sendJsonResponse(res, 500, {
                            ok: false,
                            mensaje: 'Error al actualizar el cliente',
                            errors: error
                        });
                    });
                } else {
                    Respuesta.sendJsonResponse(res, 400, {
                        ok: false,
                        mensaje: 'El cliente no existe',
                        errors: { message: 'El id de cliente no existe' }
                    });
                }
            }).catch(error => {
                Respuesta.sendJsonResponse(res, 500, {
                    ok: false,
                    mensaje: 'Error al buscar el cliente',
                    errors: error
                });
            });
            break;
        case 'personas':
            GenPersonaDao.findById(id).then(persona => {
                if (persona) {
                    var pathViejo = './uploads/' + [coleccion] + '/' + persona.img;
                    // si existe el archivo elimina la imagen anterior
                    if (fs.existsSync(pathViejo)) {
                        fs.unlink(pathViejo);
                    }
                    GenPersonaDao.update({ id_persona: persona.id_persona, img: nombreArchivo }).then(resultado => {
                        GenPersonaDao.findById(id).then(personaActualizada => {
                            Respuesta.sendJsonResponse(res, 200, {
                                ok: true,
                                mensaje: 'Imagen de persona actualizada',
                                persona: personaActualizada
                            });
                        }).catch(error => {
                            Respuesta.sendJsonResponse(res, 500, {
                                ok: false,
                                mensaje: 'Error al retornar la persona',
                                errors: error
                            });
                        });
                    }).catch(error => {
                        Respuesta.sendJsonResponse(res, 500, {
                            ok: false,
                            mensaje: 'Error al actualizar la persona',
                            errors: error
                        });
                    });
                } else {
                    Respuesta.sendJsonResponse(res, 400, {
                        ok: false,
                        mensaje: 'La persona no existe',
                        errors: { message: 'El id de persona no existe' }
                    });
                }
            }).catch(error => {
                Respuesta.sendJsonResponse(res, 500, {
                    ok: false,
                    mensaje: 'Error al buscar la persona',
                    errors: error
                });
            });
            break;
    }
};
var obtenerImgColeccion = (req, res) => {
    console.log(req.params);
    var coleccion = req.params.coleccion;
    var img = req.params.img;

    var path = `./uploads/${ coleccion }/${ img }`;
    fs.exists(path, existe => {
        if (!existe) {
            path = `./server/assets/img/no-img.jpg`;
        }
        res.sendfile(path);
    });
}
module.exports.upload = upload;
module.exports.obtenerImgColeccion = obtenerImgColeccion;