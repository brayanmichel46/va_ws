"use strict";
module.exports = (sequelize, DataTypes) => {
  var GenUniMedida = sequelize.define(
    "GenUniMedida",
    {
      id_uni_medida: {
        type: DataTypes.INTEGER,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
      },
      unidad: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      id_tip_unidad: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      n_parametros: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
    },
    {
      tableName: "gen_uni_medida",
      timestamps: false,
      underscored: true,
      freezeTableName: true,
      schema: "general",
    }
  );
  GenUniMedida.associate = function (models) {
    GenUniMedida.belongsTo(models.GenTipUnidad, {
      foreignKey: "id_tip_unidad",
    });
  };
  return GenUniMedida;
};
