'use strict';
module.exports = (sequelize, DataTypes) => {
    var FinFactura = sequelize.define('FinFactura', {
        id_factura: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_movimiento: {
            type: DataTypes.INTEGER,
            allowNull: true
        },
        id_cliente: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        id_estado: {
            type: DataTypes.DATE,
            allowNull: false
        },
    }, {
        tableName: 'fin_movimiento',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'financiero'
    });
    FinFactura.associate = function(models) {
        FinFactura.belongsTo(models.FinMovimiento, { foreignKey: 'id_movimiento' });
        FinFactura.belongsTo(models.CliCliente, { foreignKey: 'id_cliente' });            
        FinFactura.hasMany(models.FinFactura, { foreignKey: 'id_factura' });

    };
    return FinFactura;
};