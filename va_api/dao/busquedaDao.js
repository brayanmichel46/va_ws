const Models = require("../../server/models/index");
const sequelize = Models.sequelize;
const Q = require("q");
const Op = sequelize.Op;
// =============================================
//  Funcion que permite buscar los clientes
//  que coincidan con el parametro de busqueda
// =============================================
var findAllClientes = async function (busqueda) {
  var clientes = await Models.CliCliente.findAll({
    include: [
      {
        model: Models.GenPersona,
        where: {
          [Op.or]: [
            {
              nombre: {
                [Op.iLike]: "%" + busqueda + "%",
              },
            },
            {
              identificacion: {
                [Op.like]: "%" + busqueda + "%",
              },
            },
            sequelize.literal(
              '"CliCliente"."email" ilike \'%' + busqueda + "%'"
            ),
            sequelize.literal(
              '"CliCliente"."telefono" ilike \'%' + busqueda + "%'"
            ),
            sequelize.literal(
              '"CliCliente"."celular" ilike \'%' + busqueda + "%'"
            ),
          ],
        },
      },
    ],
    attributes: [
      "id_cliente",
      "id_persona",
      "email",
      "direccion",
      "telefono",
      "celular",
    ],
  });

  await clientes.forEach(async (element) => {
    console.log(element.dataValues);
    element.dataValues.nombre = element.dataValues.GenPersona.nombre;
    element.dataValues.identificacion =
      element.dataValues.GenPersona.identificacion;
    delete element.dataValues.GenPersona;
  });
  return clientes;
};
// =============================================
//  Funcion que permite buscar los usuarios
//  que coincidan con el parametro de busqueda
// =============================================
var findAllUsuarios = function (busqueda) {
  return Models.SegUsuario.findAll({
    include: [
      {
        model: Models.GenPersona,
        where: {
          [Op.or]: [
            {
              nombre: {
                [Op.iLike]: "%" + busqueda + "%",
              },
            },
            {
              identificacion: {
                [Op.like]: "%" + busqueda + "%",
              },
            },
            sequelize.literal(
              '"SegUsuario"."email" ilike \'%' + busqueda + "%'"
            ),
          ],
        },
      },
    ],
    attributes: ["id_usuario", "email"],
  });
};
var findAllPersonas = function (busqueda) {
  return Models.GenPersona.findAll({
    include: [
      {
        model: Models.SegUsuario,
        attributes: ["id_usuario", "email"],
      },
      {
        model: Models.CliCliente,
        attributes: ["id_cliente", "email", "direccion", "telefono", "celular"],
      },
    ],
    where: {
      [Op.or]: [
        {
          nombre: {
            [Op.iLike]: "%" + busqueda + "%",
          },
        },
        {
          identificacion: {
            [Op.like]: "%" + busqueda + "%",
          },
        },
      ],
    },
  });
};

var findAllInvSucursal = async function (busqueda) {
    console.log("busqueda",busqueda);
  var resultado = await Models.InvInvSuc.findAll({
    include: [
      {
        model: Models.InvInventario,
        attributes: [
          "id_inventario",
          "id_referencia",
          "descripcion",
          "id_uni_medida",
          "id_formula",
          "nesecita_p",
          "codigo",
          "id_grupo",
          "maximos_p",
          'id_grupo'
        ],
        where: {
          [Op.or]: [
            {
              descripcion: {
                [Op.iLike]: "%" + busqueda + "%",
              },
            },
            {
              codigo: {
                [Op.iLike]: "%" + busqueda + "%",
              },
            },
          ],
        },
        include: [
          {
            model: Models.GenUniMedida,
            attributes: ["unidad", "n_parametros"],
          },
          {
            model: Models.InvGrupo,
            attributes: ["cambio"],
          },
          {
            model:Models.InvInvCom,
            attributes:["id_inv_com","id_componente"],
            include:[{
              model: Models.InvInventario,
              as:"componente",
              attributes:["id_formula","id_inventario","maximos_p"],
              include:[
                {
                  model:Models.InvInvSuc,
                  where:{
                    id_sucursal:1
                  }
                  /* where:sequelize.literal(
                    '"InvInventario->InvInvComs->componente->InvInvSucs"."id_sucursal"=1'
                    
                  ) */
                },
                
              ],

            }],
           
          }
        ],
      },
    ],
  });

  await resultado.forEach(async (element) => {
    element.dataValues.descripcion = element.dataValues.InvInventario.descripcion;
    element.dataValues.codigo = element.dataValues.InvInventario.codigo;
    element.dataValues.id_formula = element.dataValues.InvInventario.id_formula;
    element.dataValues.nesecita_p = element.dataValues.InvInventario.nesecita_p;
    element.dataValues.id_grupo = element.dataValues.InvInventario.id_grupo;
    element.dataValues.maximos_p = element.dataValues.InvInventario.maximos_p;
    element.dataValues.unidad = element.dataValues.InvInventario.GenUniMedida.unidad;
    element.dataValues.n_parametros = element.dataValues.InvInventario.GenUniMedida.n_parametros;
    element.dataValues.cambio=element.dataValues.InvInventario.InvGrupo.dataValues.cambio;     
    var componentes=[]
    await element.dataValues.InvInventario.InvInvComs.forEach(element2 => {
      element2.componente.dataValues.vr_venta=element2.componente.InvInvSucs[0].vr_venta_local;
      delete element2.componente.InvInvSuc;
      componentes.push(element2.componente);      
    }); 
    element.dataValues.Componentes=componentes;
    delete element.dataValues.InvInventario;
  });
  return resultado;
};
module.exports.findAllClientes = findAllClientes;
module.exports.findAllUsuarios = findAllUsuarios;
module.exports.findAllPersonas = findAllPersonas;
module.exports.findAllInvSucursal = findAllInvSucursal;
