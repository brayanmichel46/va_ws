var jwt = require('jsonwebtoken');
var SEED = require('../config/config').SEED;
var Respuesta = require("../helpers/response");

/*
 ********************************
 ***     VERIFICAR TOKEN    ***
 ********************************
 */
exports.verificaToken = (req, res, next) => {
    var token = req.query.token

    jwt.verify(token, SEED, (err, decoded) => {

        if (err) {
            return Respuesta.sendJsonResponse(res, 500, {
                ok: false,
                mensaje: 'Token incorrecto',
                errors: err
            });

        }
        req.usuario = decoded.usuario;
        next();
    })

};