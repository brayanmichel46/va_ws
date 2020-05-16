var Models = require("../../server/models/index");
var GenPersona = require("../../general_api/dao/genPersonaDao");
var sequelize = Models.sequelize;
var Q = require("q");
// =============================================
//  Funcion que retorna un listado de todos los clientes
// =============================================
var findAll = async function(desde) {
    var limit = 5;
    var clientes= await Models.CliCliente.findAll({
        offset: desde,
        limit: 5,
        include:[
            {
                model:Models.GenPersona,
                attributes:['nombre','identificacion']
            }
        ]       
    });
   
    await clientes.forEach( async element => {
        console.log(element.dataValues);
        element.dataValues.nombre=element.dataValues.GenPersona.nombre;
        element.dataValues.identificacion=element.dataValues.GenPersona.identificacion;
        delete element.dataValues.GenPersona;
    });
    return clientes;
};
// =============================================
// Funcion para crear un nuevo cliente
// =============================================
var create = function(cliente) {
    return Models.CliCliente.create(cliente);
};
// =============================================
// Funcion que permite actualizar la informacion
// de un cliente
// =============================================
var update = async (cliente) => {
    console.log(cliente);
    await Models.GenPersona.update({
        nombre:cliente.nombre,
        identificacion:cliente.identificacion
    },{
        where:{
            id_persona:cliente.id_persona
        }
    });

    let cli = await Models.CliCliente.update({
        email:cliente.email,
        telefono:cliente.telefono,
        celular:cliente.celular,
        direccion:cliente.direccion
    },{
        where:{
            id_cliente:cliente.id_cliente
        }
    });

    let per = await GenPersona.findById(cliente.id_persona);
   return per;

};
// =============================================
// Funcion que permite buscar un cliente por id de la persona
// =============================================
var findByIdPersona = function(id_persona) {
    return Models.CliCliente.find({
        where: {
            id_persona: id_persona
        }
    });
};
// =============================================
// Funcion que permite buscar un cliente por su id
// =============================================
var findById = (id_cliente) => {
    return Models.CliCliente.find({
        where: {
            id_cliente: id_cliente
        }
    });
};
// =============================================
//  funcion que retorna el numero de clientes registrados
// =============================================
var count = () => {
    return Models.CliCliente.count({});
}

// =============================================
//  Funcion que permite buscar a un cliente por email
// =============================================
var findByEmail = (email) => {
    return Models.CliCliente.find({
        where: {
            email: email
        }
    });
};

module.exports.findAll = findAll;
module.exports.create = create;
module.exports.update = update;
module.exports.findByIdPersona = findByIdPersona;
module.exports.findById = findById;
module.exports.count = count;
module.exports.findByEmail = findByEmail;