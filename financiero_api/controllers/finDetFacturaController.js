/**
 * @file Archivo que contiene el modulo FinDetFacturaController
 * @name finDetFacturaController.js
 * @author Brayan Michel <brayanmichel46@gmail.com>
 * @license brayanvillota
 * @copyright 2020
 **/

var Respuesta = require("../../server/helpers/response");
var combinatoria = require("../../server/helpers/combination");
var ParFormulaDao = require("../../general_api/dao/parFormulaDao");

/**
 * Modulo finDetFacturaController administra todas las operaciones que se realizan sobre el detalle de una factura
 * @module FinDetFacturaController
 **/

/**
 * Funccion que permite calcular el precio de cada uno de los items
 * de una factura
 * @param {Object} req - Objeto de petición de express
 * @param {Object} res - Objeto de respuesta de express
 **/
var calcularPreciosItemsFactura = async function (req, res) {
  var itemsFactura = req.body.itemsFactura;
  var datosGenerales = req.body.datosGenerales;
  let result = await calcularPreciosItemsFacturaServidor(itemsFactura,datosGenerales,res);
  if(result){
    Respuesta.sendJsonResponse(res, 200, {
      ok: true,
      mensaje: "Exito",
      itemsFactura: result.itemsFactura,
      totales: result.totales,
    });
  }else{
    Respuesta.sendJsonResponse(res, 500, {
      ok: false,
      mensaje: "Error al calcular los valores",
      cliente: error,
    });
  }
};

/**
 * Funccion que permite calcular el precio de cada uno de los items
 * de una factura en el servidor
 * @param {Object} itemsFactura - Objeto que contine los items de una factura
 * @param {Object} datosGenerales - Objeto que contine los datos generales de una factura
 * @param {Object} res - Objeto de respuesta de express
 **/
var calcularPreciosItemsFacturaServidor = async function (itemsFactura,datosGenerales,res) {
  var ids_formulas = [];
  var formulas;
  var mayorVr = itemsFactura[0];
  var totales = {
    sub_total: 0.0,
    vr_descuento: 0.0,
    vr_antes_iva: 0.0,
    vr_iva: 0.0,
    total: 0.0,
    cantidad_items: 0
  };
  for (const element of itemsFactura) {
    if (!ids_formulas.includes(element.id_formula)) {
      ids_formulas.push(element.id_formula);
    }
    for (const element2 of element.Componentes) {
      ids_formulas.push(element2.id_formula);
    }
    element.vr_descuento = 0;
    element.vr_antes_iva = 0;
    element.vr_iva = 0;
    element.total = 0;
    element.vr_transporte = 0;
    totales.cantidad_items = parseFloat(
      totales.cantidad_items + parseFloat(element.cantidad_item)
    );
  }

  totales.vr_transporte_item = parseFloat(
    (parseFloat(datosGenerales.transporte) / totales.cantidad_items).toFixed(2)
  );
  totales.ajuste_transporte = parseFloat(
    (
      parseFloat(datosGenerales.transporte) -
      parseFloat(
        (totales.vr_transporte_item * totales.cantidad_items).toFixed(2)
      )
    ).toFixed(2)
  );
  totales.transporte = parseFloat(datosGenerales.transporte);

  await ParFormulaDao.obtenerFormulaId(ids_formulas)
    .then((resultado) => {
      formulas = JSON.parse(JSON.stringify(resultado));
    })
    .catch((error) => {
      Respuesta.sendJsonResponse(res, 500, {
        ok: false,
        mensaje: "Error al obtener formulas",
        errors: error,
      });
    });

  for (const element1 of formulas) {
    for (const element2 of itemsFactura) {
      if (element1.id_formula == element2.id_formula) {
        element2.formula = element1.formula;
        element2.vr_transporte = parseFloat(
          (
            parseInt(element2.cantidad_item) * totales.vr_transporte_item
          ).toFixed(2)
        );
      }
      for (const element3 of element2.Componentes) {
        if (element1.id_formula == element3.id_formula) {
          element3.formula = element1.formula;
        }
      }
    }
  }

  for (const element of itemsFactura) {
    eval(element.formula);
    if (mayorVr.sub_total < element.sub_total) {
      mayorVr = element;
    }
  }
  pos = itemsFactura.indexOf(mayorVr);
  if (pos >= 0) {
    itemsFactura[pos].vr_transporte = parseFloat(
      (itemsFactura[pos].vr_transporte + totales.ajuste_transporte).toFixed(2)
    );
  }
  for (const element of itemsFactura) {
    element.vr_descuento = parseFloat(
      (
        element.sub_total *
        parseFloat((datosGenerales.descuento / 100).toFixed(2))
      ).toFixed(2)
    );
    element.vr_antes_iva = parseFloat(
      (
        element.sub_total -
        element.vr_descuento +
        element.vr_transporte
      ).toFixed(2)
    );
    element.vr_iva = parseFloat(
      (
        element.vr_antes_iva * parseFloat((element.iva / 100).toFixed(2))
      ).toFixed(2)
    );
    element.total = parseFloat(
      (element.vr_antes_iva + element.vr_iva).toFixed(2)
    );
    totales.sub_total = parseFloat(
      (totales.sub_total + element.sub_total).toFixed(2)
    );
    totales.vr_descuento = parseFloat(
      (totales.vr_descuento + element.vr_descuento).toFixed(2)
    );
    totales.vr_antes_iva = parseFloat(
      (totales.vr_antes_iva + element.vr_antes_iva).toFixed(2)
    );
    totales.vr_iva = parseFloat((totales.vr_iva + element.vr_iva).toFixed(2));
    totales.total = parseFloat((totales.total + element.total).toFixed(2));
  }
  return {itemsFactura:itemsFactura,totales:totales};
};

module.exports.calcularPreciosItemsFactura = calcularPreciosItemsFactura;
module.exports.calcularPreciosItemsFacturaServidor=calcularPreciosItemsFacturaServidor;

