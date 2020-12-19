var combinations = function (array, unique) {
  return (function () {
    "use strict";
    return main(array, unique);
    function create_array(array, value) {
      var r_array = [];
      var limit = array.indexOf(value);
      for (var i = 0; i < limit; i++) {
        r_array.push(array[i]);
      }
      while (limit--) {
        array.shift();
      }
      return array.concat(r_array);
    }
    function combinations(array, number, unique) {
      var r_array = [];
      var c_number = number;
      var first = array.shift();
      while (number--) {
        r_array.push([first].concat(array.slice(0, c_number - 1)));
        array.push(array.shift());
      }
      if (unique) {
        r_array.map(function (value) {
          return value.sort();
        });
      }
      return r_array;
    }
    function remove_duplicate(array, value) {
      return array.filter(function (item, index, inputArray) {
        return inputArray.indexOf(item) == index;
      });
    }
    function repopulate_array(array, new_value) {
      for (var i = 0, s = new_value.length; i < s; i++) {
        array.push(new_value[i].join("-"));
      }
      return array;
    }
    function main(array) {
      unique = typeof unique === "undefined" ? false : unique;
      var len = array.length + 1;
      var c_array = array.slice();
      var r_array = [];
      var t_array = [];
      var value;
      while (len--) {
        while (c_array.length) {
          value = c_array.shift();
          t_array = create_array(array.slice(), value);
          repopulate_array(r_array, combinations(t_array, len, unique));
        }
        c_array = array.slice();
      }
      r_array = remove_duplicate(r_array);
      return r_array;
    }
  })();
};

var executedCombinations = function (array, unique) {
  let array_posiciones_vector = [];
  for (i = 0; i < array.length; i++) {
    array_posiciones_vector.push(i);
  }
  let combinatoria = combinations(array_posiciones_vector, unique);
  let result = [];
  combinatoria.forEach((element) => {
    let combination = element.split("-");
    let r = [];
    combination.forEach((element) => {
      r.push(array[parseInt(element)]);
    });
    result.push(r);
  });
  return result;
};
/* let p = [110, 50, 110, 50,49,20,130,120,200,300];
c = executedCombinations(p, true); 

//console.log(c);

var funciono = false;
let sma = 0;
let falta = p.reduce((a, b) => a + b, 0);
let vectorfinal = [];
while (!funciono) {
    //console.log("falta",falta);
    len_ant=p.length;
  let mejoractual = [];
  c.forEach((e) => {
    let sumatoria = e.reduce((a, b) => a + b, 0);
    if (
      sumatoria <= falta &&
      mejoractual.reduce((a, b) => a + b, 0) < sumatoria &&
      sumatoria <= 300 &&
      (sumatoria >= 285 || sumatoria <= 260)
    ) {
      mejoractual = e;
    }
  });
  if(mejoractual.length>0){
    //falta = falta - mejoractual.reduce((a, b) => a + b, 0);
    vectorfinal.push(mejoractual);
    mejoractual.forEach(m => {
        var indice = p.indexOf(m); // obtenemos el indice
        //console.log(indice);
        p.splice(indice, 1);
    });
    var indice = c.indexOf(mejoractual); // obtenemos el indice
    
    c.splice(indice, 1);
    c=executedCombinations(p, true);
    falta = p.reduce((a, b) => a + b, 0);
    console.log("faltaa",p);
  } 

  //console.log(c.length);
  if (falta == 0 || c.length==0 || p.length==len_ant) {
    funciono = true;
  }
  
} 
console.log(c,falta,"el",p,"vf",vectorfinal);*/

var mejorCorteLineal = function (array, unique, maximos_p,max_desperdicio,desperdicio_f) {
  let opciones = [];
  maximos_p.forEach((max) => {
    let c = executedCombinations(array, unique);
    let faltante = array.reduce((a, b) => a + b, 0);
    let fin = false;
    let opcion = {
      cortes: [],
      sobrante:[],
      desperdicio: [],
      faltante: [],
      maximo_p: [],
      sumatoria:[],
      desperdicio_real:[],
      desperdicio_final:[]
    };
    let maximo_p = max;
    let optimizarDesperdicio = true;
    let aux_maximos_p = [];
    let aux_array = [];
    con_max_p = 0;

    maximos_p.forEach((element) => {
      aux_maximos_p.push(element);
    });
    aux_maximos_p.splice(aux_maximos_p.indexOf(max), 1);
    aux_maximos_p.sort((a, b) => b + a);
    array.forEach((element) => {
      aux_array.push(element);
    });

    while (!fin) {
      len_ant = aux_array.length;
      let mejorActual = [];
      let desperdicio = 0;
      let desperdicio_real = 0;
      let desperdicio_final=0;
      let sobrante=0;
      let sumMejorActual = 0;
      let sum=0;
      c.forEach((e) => {        
        let sumatoria = e.reduce((a, b) => a + b, 0);
        sumMejorActual = mejorActual.reduce((a, b) => a + b, 0);
        if (optimizarDesperdicio) {
          if (
            sumatoria <= faltante &&
            sumMejorActual < sumatoria &&
            sumatoria <= maximo_p &&
            (sumatoria >= maximo_p - 15 || sumatoria <= maximo_p - max_desperdicio)
          ) {             
            desperdicio=0;
            desperdicio_real=0;
            desperdicio_final=desperdicio_f;
            sobrante=0;     
            sum=0;      
            mejorActual = e;
            sobrante=maximo_p - sumatoria;
            sum=sumatoria;
            if (sobrante <= max_desperdicio && sobrante>10) {
              desperdicio = sobrante; 
       
            }
            if (sobrante <= max_desperdicio) {
              desperdicio_real = sobrante; 
              desperdicio_final=sobrante;
       
            }
          }
        } else {
          if (
            sumatoria <= faltante &&
            sumMejorActual < sumatoria &&
            sumatoria <= maximo_p
          ) {
            desperdicio=0;
            sobrante=0;
            sum=0;
            desperdicio_real=0;
            desperdicio_final=desperdicio_f;
            mejorActual = e;
            sobrante=maximo_p - sumatoria;
            sum=sumatoria;
            if (sobrante <= max_desperdicio && sobrante>10) {
              desperdicio = sobrante;              
            }
            if (sobrante <= max_desperdicio) {
              desperdicio_real = sobrante; 
              desperdicio_final=sobrante;
         
            }
          }
        }
      });
      if (mejorActual.length > 0) {

        opcion.cortes.push(mejorActual);
        opcion.desperdicio.push(desperdicio);
        opcion.sobrante.push(sobrante);
        opcion.maximo_p.push(maximo_p);
        opcion.sumatoria.push(sum);
        opcion.desperdicio_real.push(desperdicio_real);
        opcion.desperdicio_final.push(desperdicio_final);
        mejorActual.forEach((m) => {
          var indice = aux_array.indexOf(m);
          aux_array.splice(indice, 1);
        });

        c = executedCombinations(aux_array, true);
        faltante = aux_array.reduce((a, b) => a + b, 0);
      }

      if (faltante == 0 || aux_array.length == len_ant) {


        if (optimizarDesperdicio && faltante > 0) {

          optimizarDesperdicio = false;
        } else if (
          !optimizarDesperdicio &&
          con_max_p < aux_maximos_p.length &&
          faltante > 0
        ) {
          optimizarDesperdicio = true;
          maximo_p = aux_maximos_p[con_max_p];
          con_max_p++;
        } else if (faltante == 0 || con_max_p >= aux_maximos_p.length) {
          opcion.faltante = aux_array;
          fin = true;
        }
      }
    }
    opciones.push(opcion);    
  });
  let mejorOpcion=null;
  opciones.forEach(element => {
    element.suma_cortes=element.sumatoria.reduce((a,b)=>a+b,0);
    element.suma_desper_r=element.desperdicio_real.reduce((a,b)=>a+b,0);
    element.suma_desper_f=element.desperdicio_final.reduce((a,b)=>a+b,0);
    element.suma_final=element.suma_cortes+element.suma_desper_f;
    if(mejorOpcion==null){
      mejorOpcion=element;
    }else if(mejorOpcion.desperdicio.reduce((a,b)=>a+b,0)>=element.desperdicio.reduce((a,b)=>a+b,0 && element.faltante.length==0)){
      mejorOpcion=element;
    }
  });
  console.log("opciones",mejorOpcion);
  return { mejorOpcion:mejorOpcion,opciones: opciones };
};
//let p = [110, 50, 110, 115,50, 130, 120, 48, 49, 300,22,600];
//let p = [275,275,275,275];
/* let p = [44.5,44.5,120,120];
var res = mejorCorteLineal(p, true, [290],40,18);
console.log(res.mejorOpcion); */
//console.log(res.desperdicio);
module.exports.executedCombinations = executedCombinations;
module.exports.mejorCorteLineal = mejorCorteLineal;
