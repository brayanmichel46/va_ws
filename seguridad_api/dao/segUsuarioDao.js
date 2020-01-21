var Models = require("../../server/models/index");
var sequelize = Models.sequelize;
var bcrypt = require('bcryptjs');

var Q = require("q");
var findAll = function(desde) {
    limit = 5;
    return Models.SegUsuario.findAll({
        offset: desde,
        limit: 5
    });
};
// =============================================
// Funcion para crear un nuevo usuario
// =============================================
var create = function(usuario) {
    usuario.password = bcrypt.hashSync(usuario.password, 10);
    return Models.SegUsuario.create(usuario);
};
// =============================================
// Funcion que permite actualizar la informacion
// de un usuario
// =============================================
var update = (usuario) => {
    var objetoActualizar = {}
    if (Object.keys(usuario).indexOf('email') >= 0) {
        objetoActualizar.email = usuario.email
    }
    if (Object.keys(usuario).indexOf('img') >= 0) {
        objetoActualizar.img = usuario.img
    }
    console.log("entro", objetoActualizar);
    return Models.SegUsuario.update(objetoActualizar, {
        where: {
            id_usuario: usuario.id_usuario
        }
    });
};
// =============================================
// Funcion que permite buscar un usuario por su id
// =============================================
var findById = (id_usuario) => {
    return Models.SegUsuario.find({
        where: {
            id_usuario: id_usuario
        }
    });
};
// =============================================
//  Funcion que permite eliminar un usuario
// =============================================
var eliminar = (id_usuario) => {
    return Models.SegUsuario.destroy({
        where: {
            id_usuario: id_usuario
        }
    });
};
// =============================================
//  Funcion que permite buscar un usuario por email
// =============================================
var findByEmail = (email) => {
    return Models.SegUsuario.find({
        where: {
            email: email
        }
    });
};
// =============================================
// Funcion que permite buscar un usuario por id de la persona
// =============================================
var findByIdPersona = function(id_persona) {
    return Models.SegUsuario.find({
        where: {
            id_persona: id_persona
        }
    });
};
// =============================================
//  funcion que retorna el numero de usuario registrados
// =============================================
var findAndCountAll = () => {
    return Models.SegUsuario.count({});
}
module.exports.findAll = findAll;
module.exports.create = create;
module.exports.update = update;
module.exports.delete = eliminar;
module.exports.findById = findById;
module.exports.findByEmail = findByEmail;
module.exports.findByIdPersona = findByIdPersona;
module.exports.findAndCountAll = findAndCountAll;