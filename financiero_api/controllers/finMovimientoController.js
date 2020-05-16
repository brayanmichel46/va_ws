var Respuesta = require("../helpers/respuesta");
var CliClienteDao = require("../dao/cliClienteDao");
var GenPersonaDao = require("../../general_api/dao/genPersonaDao");


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
        console.log("error",error);
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
        }
        else{
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
    }
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
var update = async (req, res) => {
    var cliente = req.body.cliente;
    let consulta1 =await CliClienteDao.findById(cliente.id_cliente).then((resultado) => {
        if (!resultado) {
            Respuesta.sendJsonResponse(res, 400, {
                ok: false,
                mensaje: 'El cliente con el id ' + cliente.id_cliente + ' no existe',
                erros: { message: 'No existe un cliente con ese ID' }
            });
            return 1;
        };
       
    }).catch((error) => {
        console.log(error);
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar cliente',
            error: error
        });
        return 1;
    });
    if(consulta1==1){
        return;
    }
    let consulta2 =await CliClienteDao.findByEmail(cliente.email).then((resultado) => {
        if(resultado){
            if (resultado.dataValues.id_cliente!=cliente.id_cliente) {
                Respuesta.sendJsonResponse(res, 400, {
                    ok: false,
                    mensaje: 'El cliente con el email ' + cliente.email + ' ya existe',
                    erros: { message: 'Ya existe un cliente con este email' }
                });
                return 1;
            }
        };
       
    }).catch((error) => {
        console.log(error);
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar cliente2',
            error: error
        });
        return 1;
    });
    if(consulta2==1){
        return;
    }
    let consulta3 =await GenPersonaDao.findByIdentificacion(cliente.identificacion).then((resultado) => {
               
        if(resultado){
            if (resultado.dataValues.id_persona!=cliente.id_persona) {
                console.log(resultado.dataValues.id_persona!=cliente.id_persona);
                Respuesta.sendJsonResponse(res, 400, {
                    ok: false,
                    mensaje: 'El cliente con la identificacion ' + cliente.identificacion + ' ya existe',
                    erros: { message: 'Ya existe una persona con esta identificacion' }
                });
                return 1;
            };
        }
               
    }).catch((error) => {
        console.log(error);
        Respuesta.sendJsonResponse(res, 500, {
            ok: false,
            mensaje: 'Error al buscar la persona',
            error: error
        });
        return 1;
    });
    
    if(consulta3==1){
        return;
    }
    CliClienteDao.update(cliente).then((resultado) => {
       
         return Respuesta.sendJsonResponse(res, 200, {
            ok: true,
            mensaje: 'cliente actualizado!',
            persona: resultado
        });
    }).catch((error) => {
        console.log(error);
        Respuesta.sendJsonResponse(res, 400, {
            ok: false,
            mensaje: 'Error al actualizar cliente',
            cliente: error
        });
    });
};

module.exports.findAll = findAll;
module.exports.create = create;
module.exports.update = update;