'use strict';
module.exports = (sequelize, DataTypes) => {
  var Prueba = sequelize.define('Prueba', {
    title: DataTypes.STRING
  }, {});
  Prueba.associate = function(models) {
    // associations can be defined here
  };
  return Prueba;
};