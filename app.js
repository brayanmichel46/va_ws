// Require
var express = require('express');
const logger = require('morgan');
const bodyParser = require('body-parser');


// Inicializar variables
var app = express();

// Log requests to the console.
app.use(logger('dev'));

//CORS
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header("AccesAccess-Control-Allow-Methods","POST, GET, PUT, DELETE, OPTIONS")
    next();
  });

// Parse incoming requests data (https://github.com/expressjs/body-parser)
//app.use(bodyParser.json());
//app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({limit: '50mb'}));

// Importar rutas
var appRoutes = require('./va_api/routes/index');
var appRoutesSeguridad = require('./seguridad_api/routes/index');
var appRoutesGeneral = require('./general_api/routes/index');
var appRoutesVentas = require('./ventas_api/routes/index');
var appRoutesFinanciero = require('./financiero_api/routes/index');
var appRoutesInventario = require('./inventario_api/routes/index');



// Escuchar peticiones
app.listen(3000,"192.168.1.57", () => {
//app.listen(3000, () => {
    console.log('Express server puerto 3000: \x1b[32m%s\x1b[0m', 'online');
});

// Rutas
app.use('/seguridad', appRoutesSeguridad);
app.use('/general', appRoutesGeneral);
app.use('/inventario', appRoutesInventario);
app.use('/ventas', appRoutesVentas);
app.use('/financiero', appRoutesFinanciero);
app.use('/va', appRoutes);

module.exports = app;