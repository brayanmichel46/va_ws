'use strict';
module.exports = (sequelize, DataTypes) => {
    var InvInvSuc = sequelize.define('InvInvSuc', {
        id_inv_suc: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_inventario: {
            type: DataTypes.INTEGER,
            allowNull:false
        },
        id_sucursal: {
            type: DataTypes.INTEGER,
            allowNull:false
        },   
        cantidad:{
            type:DataTypes.DECIMAL,
            allowNull:false
        },
        costo_promedio:{
            type:DataTypes.STRING,
            allowNull:false
        },
        vr_venta_local:{
            type:DataTypes.STRING,
            allowNull:false
        },
        vr_venta_domicilio:{
            type:DataTypes.STRING,
            allowNull:false
        } 
    }, {
        tableName: 'inv_inv_suc',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'inventario'
    });
    InvInvSuc.associate = function(models) {
        InvInvSuc.belongsTo(models.GenSucursal, { foreignKey: 'id_inv_suc' });
        InvInvSuc.belongsTo(models.InvInventario, { foreignKey: 'id_inventario' });
    };
    return InvInvSuc;
};