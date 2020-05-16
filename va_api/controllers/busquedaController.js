var Respuesta = require("../../server/helpers/response");
var BusquedaDao = require("../dao/busquedaDao");
// =============================================
//  Permite buscar en todas las colecciones de datos
// =============================================
var busqueda = function (req, res) {
  var busqueda = req.body.busqueda;

  Promise.all([
    BusquedaDao.findAllClientes(busqueda),
    BusquedaDao.findAllUsuarios(busqueda),
    BusquedaDao.findAllPersonas(busqueda),
  ])
    .then((respuestas) => {
      Respuesta.sendJsonResponse(res, 200, {
        ok: true,
        mensaje: "Busqueda exitosa",
        clientes: respuestas[0],
        usuarios: respuestas[1],
        personas: respuestas[2],
      });
    })
    .catch(function (error) {
      Respuesta.sendJsonResponse(res, 500, {
        ok: false,
        mensaje: "Error al realizar la busqueda",
        errors: error,
      });
    });
};
var busquedaColeccion = (req, res) => {
  var coleccion = req.body.coleccion;
  var busqueda = req.body.busqueda;
  console.log(req.body);
  switch (coleccion) {
    case "usuarios":
      promesa = BusquedaDao.findAllUsuarios(busqueda);
      break;
    case "clientes":
      promesa = BusquedaDao.findAllClientes(busqueda);
      break;
    case "personas":
      promesa = BusquedaDao.findAllPersonas(busqueda);
      break;
    case "inv_sucursal":
      promesa = BusquedaDao.findAllInvSucursal(busqueda);
      break;
    default:
      Respuesta.sendJsonResponse(res, 400, {
        ok: false,
        mensaje: "El tipo de busqueda no existe",
        errors: { message: "Tipo de coleccion no valido" },
      });
  }
  promesa
    .then((data) => {
      Respuesta.sendJsonResponse(res, 200, {
        ok: true,
        mensaje: "Busqueda exitosa",
        [coleccion]: data,
      });
    })
    .catch(function (error) {
      console.log("erro al buscar coleccion", error);
      Respuesta.sendJsonResponse(res, 500, {
        ok: false,
        mensaje: "Error al realizar la busqueda",
        errors: error,
      });
    });
};
module.exports.busqueda = busqueda;
module.exports.busquedaColeccion = busquedaColeccion;
