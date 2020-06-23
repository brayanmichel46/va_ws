'use strict';
module.exports = (sequelize, DataTypes) => {
    var InvInventario = sequelize.define('InvInventario', {
        id_inventario: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_referencia: {
            type: DataTypes.INTEGER,
            allowNull:true
        },   
        descripcion:{
            type:DataTypes.STRING(100),
            allowNull:false
        },
        id_uni_medida:{
            type:DataTypes.INTEGER,
            allowNull:false
        },
        id_formula:{
            type:DataTypes.INTEGER,
            allowNull:false
        },
        nesecita_p:{
            type:DataTypes.CHAR(1),
            allowNull:false
        },
        codigo:{
            type:DataTypes.STRING(30),
            allowNull:false
        },
        maximos_p:{
            type:DataTypes.JSON,
            allowNull:false
        },
        id_gupo:{
            type:DataTypes.INTEGER,
            allowNull:false
        },
        id_fondo:{
            type:DataTypes.INTEGER,
            allowNull:false
        }
    }, {
        tableName: 'inv_inventario',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'inventario'
    });
    InvInventario.associate = function(models) {
        InvInventario.hasMany(models.FinFactura, { foreignKey: 'id_inventario' });
        InvInventario.hasMany(models.InvInvSuc, { foreignKey: 'id_inventario' });
        InvInventario.belongsTo(models.ParFormula, { foreignKey: 'id_formula' });
        InvInventario.belongsTo(models.GenUniMedida, { foreignKey: 'id_uni_medida' });
        InvInventario.hasMany(models.InvInvCom,{foreignKey:'id_inventario'});
        InvInventario.belongsTo(models.InvGrupo, { foreignKey: 'id_grupo' });
    };
    return InvInventario;
};