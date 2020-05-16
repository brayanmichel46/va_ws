"use strict";
module.exports = (sequelize, DataTypes) => {
  var ParFormula = sequelize.define(
    "ParFormula",
    {
      id_formula: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
      },
      formula: {
        type: DataTypes.TEXT,
        allowNull: false,
      },
      descripcion: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
    },
    {
      tableName: "par_formula",
      timestamps: false,
      underscored: true,
      freezeTableName: true,
      schema: "general",
    }
  );
  ParFormula.associate = function (models) {};
  return ParFormula;
};
