const Models = require("../../server/models/index");
const sequelize = Models.sequelize;
const Q = require("q");
const Op = sequelize.Op;
// =============================================
//  Funcion que permite buscar los clientes 
//  que coincidan con el parametro de busqueda
// =============================================
var findAllClientes = function(busqueda) {
    return Models.CliCliente.findAll({
        include: [{
            model: Models.GenPersona,
            where: {
                [Op.or]: [{
                        nombre: {
                            [Op.iLike]: '%' + busqueda + '%'
                        }
                    },
                    {
                        identificacion: {
                            [Op.like]: '%' + busqueda + '%'
                        }
                    },
                    sequelize.literal('"CliCliente"."email" ilike \'%' + busqueda + '%\''),
                    sequelize.literal('"CliCliente"."telefono" ilike \'%' + busqueda + '%\''),
                    sequelize.literal('"CliCliente"."celular" ilike \'%' + busqueda + '%\'')
                ]
            }
        }],
        attributes: [
            'id_cliente',
            'email',
            'direccion',
            'telefono',
            'celular'
        ]
    });
};
// =============================================
//  Funcion que permite buscar los usuarios 
//  que coincidan con el parametro de busqueda
// =============================================
var findAllUsuarios = function(busqueda) {
    return Models.SegUsuario.findAll({
        include: [{
            model: Models.GenPersona,
            where: {
                [Op.or]: [{
                        nombre: {
                            [Op.iLike]: '%' + busqueda + '%'
                        }
                    },
                    {
                        identificacion: {
                            [Op.like]: '%' + busqueda + '%'
                        }
                    },
                    sequelize.literal('"SegUsuario"."email" ilike \'%' + busqueda + '%\'')
                ]
            }
        }],
        attributes: [
            'id_usuario',
            'email'
        ]
    });
};
var findAllPersonas = function(busqueda) {
    return Models.GenPersona.findAll({
        include: [{
                model: Models.SegUsuario,
                attributes: [
                    'id_usuario',
                    'email'
                ]
            },
            {
                model: Models.CliCliente,
                attributes: [
                    'id_cliente',
                    'email',
                    'direccion',
                    'telefono',
                    'celular'
                ]
            }
        ],
        where: {
            [Op.or]: [{
                    nombre: {
                        [Op.iLike]: '%' + busqueda + '%'
                    }
                },
                {
                    identificacion: {
                        [Op.like]: '%' + busqueda + '%'
                    }
                },
            ]
        }
    });
};
module.exports.findAllClientes = findAllClientes;
module.exports.findAllUsuarios = findAllUsuarios;
module.exports.findAllPersonas = findAllPersonas;