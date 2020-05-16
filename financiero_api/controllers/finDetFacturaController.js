/**
 * @file Archivo que contiene el modulo FinDetFacturaController
 * @name finDetFacturaController.js
 * @author Brayan Michel <brayanmichel46@gmail.com>
 * @license brayanvillota
 * @copyright 2020
 **/

var Respuesta = require("../../server/helpers/response");
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
  console.log("req", req.body);
  var ids_formulas = [];
  var itemsFactura = req.body.itemsFactura;
  var datosGenerales = req.body.datosGenerales;
  var formulas;
  var mayorVr=itemsFactura[0];  
  var totales={
    sub_total:0.0,
    vr_descuento:0.0,
    vr_antes_iva:0.0,
    vr_iva:0.0,
    total:0.0,
    cantidad_items:0
  };

  await itemsFactura.forEach((element) => {
    if (!ids_formulas.includes(element.id_formula)) {
      ids_formulas.push(element.id_formula);
    }
    element.vr_descuento=0;
    element.vr_antes_iva=0;
    element.vr_iva=0;
    element.total=0;
    element.vr_transporte=0;
    totales.cantidad_items=parseInt((totales.cantidad_items+parseInt(element.cantidad_item)));
  });
  totales.vr_transporte_item=parseFloat((parseInt(datosGenerales.transporte)/totales.cantidad_items).toFixed(2));
  totales.ajuste_transporte=parseFloat((parseInt(datosGenerales.transporte)-parseFloat((totales.vr_transporte_item*totales.cantidad_items).toFixed(2))).toFixed(2));
  totales.transporte=parseInt(datosGenerales.transporte);    
  //console.log("IDs formulas", ids_formulas);

  await ParFormulaDao.obtenerFormulaId(ids_formulas)
    .then((resultado) => {
      console.log(resultado);
      formulas = JSON.parse(JSON.stringify(resultado));
    })
    .catch((error) => {
      Respuesta.sendJsonResponse(res, 500, {
        ok: false,
        mensaje: "Error al obtener formulas",
        errors: error,
      });
    });

  await formulas.forEach(async (element1) => {
    await itemsFactura.forEach((element2) => {
      if (element1.id_formula == element2.id_formula) {
        element2.formula = element1.formula;
      }
    });
  });
     
  await itemsFactura.forEach((element) => {  
    eval(element.formula);
    if(mayorVr.sub_total<element.sub_total){
      mayorVr=element;
    }        
/*     var parametros = element.parametros;
    var pfinales=[null,null];
    for (let i = 0; i < parametros.length; i++) {
      var mulinf=parseInt(parametros[i]/10)*10;
      var diferencia = parametros[i] - mulinf;
      var adicion = 0;
      if (parametros[i] <= 97) {
        if (diferencia >= 4 && diferencia < 8) {
          adicion = 10;
        } else if (diferencia >= 8) {
          adicion = 15;
        } else {
          adicion = 5;
        }
      } else if (parametros[i] >= 168) {
        adicion = 180 - mulinf;
      } else {
        if (diferencia <= 8) {
          adicion = 10;
        } else {
          adicion = 15;
        }
      }
      pfinales[i]= (mulinf + adicion) / 100;
    }
    element.cantidad=parseFloat((pfinales[0]*pfinales[1]).toFixed(2));    
    element.sub_total=parseFloat((element.cantidad_item*element.cantidad*element.vr_venta_local).toFixed(2)); 
    totales.cantidad_items=parseInt((totales.cantidad_items+parseInt(element.cantidad_item)));*/
  });  
  pos=itemsFactura.indexOf(mayorVr);
  itemsFactura[pos].vr_transporte=parseFloat((itemsFactura[pos].vr_transporte+totales.ajuste_transporte).toFixed(2));
  await itemsFactura.forEach((element) => {        
    element.vr_descuento=parseFloat((element.sub_total*parseFloat((datosGenerales.descuento/100).toFixed(2))).toFixed(2));
    element.vr_antes_iva=parseFloat((element.sub_total-element.vr_descuento+element.vr_transporte).toFixed(2));
    element.vr_iva=parseFloat((element.vr_antes_iva*parseFloat((element.iva/100).toFixed(2))).toFixed(2));
    element.total=parseFloat((element.vr_antes_iva+element.vr_iva).toFixed(2));    
    totales.sub_total=parseFloat((totales.sub_total+element.sub_total).toFixed(2));
    totales.vr_descuento=parseFloat((totales.vr_descuento+element.vr_descuento).toFixed(2));
    totales.vr_antes_iva=parseFloat((totales.vr_antes_iva+element.vr_antes_iva).toFixed(2));
    totales.vr_iva=parseFloat((totales.vr_iva+element.vr_iva).toFixed(2));
    totales.total=parseFloat((totales.total+element.total).toFixed(2));  
  });    
  totales.ajuste_total=parseFloat(((Math.ceil(totales.total/500)*500)-totales.total).toFixed(2));
  totales.ajuste_item=parseFloat((totales.ajuste_total/totales.cantidad_items).toFixed(2));
  totales.ajuste_final=parseFloat((totales.ajuste_total-parseFloat((totales.ajuste_item*totales.cantidad_items).toFixed(2))).toFixed(2));
  var v=0;
  var v2=0;
  
  await itemsFactura.forEach((element) => {
   /*  if(mayorVr.total<element.total){
      mayorVr=element;
    } */
    element.total=parseFloat((element.total+parseFloat((totales.ajuste_item*element.cantidad_item).toFixed(2))).toFixed(2));    
    //v+=element.total;
    //console.log(element.total);
  });
  itemsFactura[pos].total=parseFloat((itemsFactura[pos].total+totales.ajuste_final).toFixed(2));
  totales.total=parseFloat((totales.total+totales.ajuste_total).toFixed(2));
  await itemsFactura.forEach((element) => {    
    v+=element.total;
    v2+=element.vr_transporte;
    console.log(element.total);
    console.log(element.vr_transporte);
  });
  console.log(totales,parseFloat(v.toFixed(2)),parseFloat(v2.toFixed(2)));

  Respuesta.sendJsonResponse(res, 200, {
    ok: true,
    mensaje: "Exito",
    itemsFactura: itemsFactura,
    totales:totales
  });

};

module.exports.calcularPreciosItemsFactura = calcularPreciosItemsFactura;
