"use strict";
module.exports = (sequelize, DataTypes) => {
  var FinFacItem = sequelize.define(
    "FinFacPar",
    {
      id_fac_item: {
        type: DataTypes.BIGINT,
        allowNull: false,
        primaryKey: true,
        autoIncrement: true,
      },
      id_det_factura: {
        type: DataTypes.INTEGER,
        allowNull: true,
      },
      parametro: {
        type: DataTypes.DECIMAL(4,1),
        allowNull: false,
      },
    },
    {
      tableName: "fin_fac_par",
      timestamps: false,
      underscored: true,
      freezeTableName: true,
      schema: "financiero",
    }
  );
  FinFacItem.associate = function (models) {
    FinFacItem.belongsTo(models.FinDetFactura, {
      foreignKey: "id_det_factura",
    });
  };
  return FinFacItem;
};
