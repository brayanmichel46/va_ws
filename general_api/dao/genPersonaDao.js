var Models = require("../../server/models/index");
var sequelize = Models.sequelize;
var bcrypt = require('bcryptjs');
var Q = require("q");

var findAll = function(desde) {
    var limit = 5;
    return Models.GenPersona.findAll({
        offset: desde,
        limit: 5
    });
};
// =============================================
// Funcion para crear una nueva persona
// =============================================
var create = function(persona) {
    return Models.GenPersona.create(persona);
};
// =============================================
// Funcion que permite actualizar la informacion
// de una persona
// =============================================
var update = (persona) => {
    var objetoActualizar = {}
    if (Object.keys(persona).indexOf('nombre') >= 0) {
        objetoActualizar.email = persona.nombre
    }
    if (Object.keys(persona).indexOf('img') >= 0) {
        objetoActualizar.img = persona.img
    }
    return Models.GenPersona.update(objetoActualizar, {
        where: {
            id_persona: persona.id_persona
        }
    });
};
// =============================================
// Funcion que permite buscar una persona por su id
// =============================================
var findById = (id_persona) => {
    return Models.GenPersona.find({
        where: {
            id_persona: id_persona
        }
    });
};

// =============================================
//  Funcion que permite buscar una persona por cedula
// =============================================
var findByIdentificacion = (identificacion) => {
    return Models.GenPersona.find({
        where: {
            identificacion: identificacion
        },
        include: [
            { model: Models.CliCliente },
            { model: Models.SegUsuario, attributes: ['id_usuario'] }
        ]
    });
};

// =============================================
//  Funcion que permite crear una persona como cliente
// =============================================
var createPersonaCliente = (persona, cliente) => {
    var deferred = Q.defer();
    if (persona) {
        return sequelize.transaction({ autocommit: false }).then(function(t) {
            Models.GenPersona.create(persona, { transaction: t }).then(function(personac) {
                cliente.id_persona = personac.id_persona;
                Models.CliCliente.create(cliente, { transaction: t }).then(function(clientec) {
                    t.commit();
                    datos = {
                        persona: personac,
                        cliente: usuarioc
                    }
                    deferred.resolve(datos);
                }).catch(function(error) {
                    t.rollback();
                    deferred.reject(error);
                });
            }).catch(function(error) {
                t.rollback();
                deferred.reject(error);
            });
            return deferred.promise;
        });
    } else {
        return Models.CliCliente.create(cliente);
    }
}

// =============================================
//  Funcion que permite crear una persona como usuario
// =============================================
var createPersonaUsuario = (persona, usuario) => {
        var deferred = Q.defer();
        if (persona) {
            return sequelize.transaction({ autocommit: false }).then(function(t) {
                Models.GenPersona.create(persona, { transaction: t }).then(function(personac) {
                    usuario.id_persona = personac.id_persona;
                    Models.SegUsuario.create(usuario, { transaction: t }).then(function(usuarioc) {
                        t.commit();
                        datos = {
                            persona: personac,
                            usuario: usuarioc
                        }
                        deferred.resolve(datos);
                    }).catch(function(error) {
                        t.rollback();
                        deferred.reject(error);
                    });
                }).catch(function(error) {
                    t.rollback();
                    deferred.reject(error);
                });
                return deferred.promise;
            });
        } else {
            return Models.SegUsuario.create(usuario);
        }
    }
    // =============================================
    //  Funcion que retorna el numero de personas registradas
    // =============================================

var findAndCountAll = () => {
    return Models.GenPersona.count({});
}
module.exports.findAll = findAll;
module.exports.create = create;
module.exports.update = update;
module.exports.findById = findById;
module.exports.findByIdentificacion = findByIdentificacion;
module.exports.createPersonaCliente = createPersonaCliente;
module.exports.createPersonaUsuario = createPersonaUsuario;
module.exports.findAndCountAll = findAndCountAll;;