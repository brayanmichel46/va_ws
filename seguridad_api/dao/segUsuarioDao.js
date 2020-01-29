var Models = require("../../server/models/index");
var sequelize = Models.sequelize;
var bcrypt = require('bcryptjs');

var Q = require("q");
var findAll = async function(desde) {
    console.log("llega");
    limit = 5;
    var usuarios= await Models.SegUsuario.findAll({
        offset: desde,
        limit: 5,
        include:[
            {
                model:Models.GenPersona,
                attributes:['nombre']
            }
        ]
    });
    await usuarios.forEach( async element => {
        console.log(element.dataValues);
        element.dataValues.nombre=element.dataValues.GenPersona.nombre;
        delete element.dataValues.GenPersona;
    });
    return usuarios;
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
var  update = async (usuario)  => {
    console.log("uaudi",usuario)
    var objetoActualizar = {}
    var usu= await findById(usuario.id_usuario);
    
    if (Object.keys(usuario).indexOf('nombre') >= 0) {
        objetoActualizar.nombre = usuario.nombre
        await Models.GenPersona.update(objetoActualizar, {
            where: {
                id_persona: usu.id_persona
            }
        });
    }

    if (Object.keys(usuario).indexOf('img') >= 0 || Object.keys(usuario).indexOf('email') >= 0) {
        objetoActualizar.img = usuario.img
        if(Object.keys(usuario).indexOf('img') >= 0){
            objetoActualizar.img = usuario.img
        }
        if(Object.keys(usuario).indexOf('email') >= 0){
            objetoActualizar.email = usuario.email
        }
        await Models.SegUsuario.update(objetoActualizar, {
            where: {
                id_usuario: usuario.id_usuario
            }
        });
    }

    
    var usu= await findById(usuario.id_usuario);
    usu.dataValues.nombre=usu.dataValues.GenPersona.nombre;
    delete usu.dataValues.GenPersona;
    return usu;
    console.log("entro", objetoActualizar);
    
};
// =============================================
// Funcion que permite buscar un usuario por su id
// =============================================
var findById = (id_usuario) => {
    return Models.SegUsuario.find({
        where: {
            id_usuario: id_usuario
        },
        include:[
            {
                model:Models.GenPersona,
                attributes:['nombre','identificacion']
            }
        ]
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