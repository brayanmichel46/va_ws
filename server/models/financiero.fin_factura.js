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
            type: DataTypes.INTEGER,
            allowNull: false
        },
        totales:{
            type:DataTypes.JSON,
            allowNull:false
        },
        items:{
            type:DataTypes.JSON,
            allowNull:false
        },
        saldo:{
            type:DataTypes.DECIMAL(20,2),
            allowNull:false
        },
        total:{
            type:DataTypes.DECIMAL(20,2),
            allowNull:false
        },
        transporte:{
            type:DataTypes.DECIMAL(20,2),
            allowNull:false
        },
        descuento:{
            type:DataTypes.DECIMAL(20,2),
            allowNull:false
        },
        saldo:{
            type:DataTypes.DECIMAL(20,2),
            allowNull:false
        },
        fec_factura:{
            type:DataTypes.DATE,
            allowNull:false
        },
        num_factura:{
            type:DataTypes.STRING(50),
            allowNull:false
        }
    }, {
        tableName: 'fin_factura',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'financiero'
    });
    FinFactura.associate = function(models) {
        FinFactura.belongsTo(models.FinMovimiento, { foreignKey: 'id_movimiento' });
        FinFactura.belongsTo(models.CliCliente, { foreignKey: 'id_cliente' });            
        FinFactura.hasMany(models.FinAboFac, { foreignKey: 'id_factura' });
        FinFactura.belongsTo(models.GenEstado, { foreignKey: 'id_estado' });
    };
    return FinFactura;
};