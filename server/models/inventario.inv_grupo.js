'use strict';
module.exports = (sequelize, DataTypes) => {
    var InvGrupo = sequelize.define('InvGrupo', {
        id_grupo: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        grupo: {
            type: DataTypes.STRING(50),
            allowNull:true        
        },
        id_componente:{
            type:DataTypes.CHAR(1),
            allowNull:false
        }        
    }, {
        tableName: 'inv_grupo',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'inventario'
    });
    InvGrupo.associate = function(models) {
        InvGrupo.hasMany(models.InvInventario, { foreignKey: 'id_grupo'});        
    };
    return InvGrupo;
};