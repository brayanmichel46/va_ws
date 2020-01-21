var Models = require("../../server/models/index");
var sequelize = Models.sequelize;
var Q = require("q");
// =============================================
//  Funcion que retorna un listado de todos los clientes
// =============================================
var findAll = function(desde) {
    var limit = 5;
    return Models.CliCliente.findAll({
            offset: desde,
            limit: 5
        },
        include = [
            { model: Models.GenPersona }
        ]
    );
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
var update = (cliente) => {
    var objetoActualizar = {}
    if (Object.keys(cliente).indexOf('email') >= 0) {
        objetoActualizar.email = cliente.email
    }
    if (Object.keys(cliente).indexOf('img') >= 0) {
        objetoActualizar.img = cliente.img
    }
    return Models.CliCliente.update(objetoActualizar, {
        where: {
            id_cliente: cliente.id_cliente
        }
    });
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

module.exports.findAll = findAll;
module.exports.create = create;
module.exports.update = update;
module.exports.findByIdPersona = findByIdPersona;
module.exports.findById = findById;
module.exports.count = count;