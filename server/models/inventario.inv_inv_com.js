'use strict';
module.exports = (sequelize, DataTypes) => {
    var InvInvCom = sequelize.define('InvInvCom', {
        id_inv_com: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_inventario: {
            type: DataTypes.INTEGER,
            allowNull:true        
        },
        id_componente:{
            type:DataTypes.INTEGER,
            allowNull:false
        }        
    }, {
        tableName: 'inv_inv_com',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'inventario'
    });
    InvInvCom.associate = function(models) {
        InvInvCom.belongsTo(models.InvInventario, { foreignKey: 'id_inventario'});
        InvInvCom.belongsTo(models.InvInventario, { foreignKey: 'id_componente', as:"componente" });
    };
    return InvInvCom;
};