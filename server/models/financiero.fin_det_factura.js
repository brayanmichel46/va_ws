'use strict';
module.exports = (sequelize, DataTypes) => {
    var FinDetFactura = sequelize.define('FinDetFactura', {
        id_det_factura: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_factura: {
            type: DataTypes.INTEGER,
            allowNull: true
        },
        id_inventario: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        cantidad:{
            type: DataTypes.DECIMAL,
            allowNull:false
        },
        detalle:{
            type:DataTypes.STRING,
            allowNull:false
        },
        sub_total:{
            type: DataTypes.DECIMAL,
            allowNull:false
        },
        descuento:{
            type:DataTypes.INTEGER,
            allowNull:false
        },
        vr_descuento:{
            type: DataTypes.DECIMAL,
            allowNull:false
        },
        vr_transporte:{
            type: DataTypes.DECIMAL,
            allowNull:false
        },
        vr_antes_iva:{
            type: DataTypes.DECIMAL,
            allowNull:false
        },
        iva:{
            type:DataTypes.INTEGER,
            allowNull:false
        },
        vr_iva:{
            type: DataTypes.DECIMAL,
            allowNull:false
        },
        total:{
            type: DataTypes.DECIMAL,
            allowNull:false
        }
    }, {
        tableName: 'fin_det_factura',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'financiero'
    });
    FinDetFactura.associate = function(models) {
        FinDetFactura.belongsTo(models.FinFactura, { foreignKey: 'id_factura' });
        /* FinDetFactura.hasOne(models.SegUsuario, { foreignKey: 'id_persona' });
        FinDetFactura.hasOne(models.CliCliente, { foreignKey: 'id_persona' }); */
    };
    return FinDetFactura;
};