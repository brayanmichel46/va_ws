'use strict';
module.exports = (sequelize, DataTypes) => {
    var GenEstado = sequelize.define('GenEstado', {
        id_estado: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        descripcion: {
            type: DataTypes.STRING,
            allowNull:false
        },   
        clase:{
            type:DataTypes.STRING,
            allowNull:false
        }     
    }, {
        tableName: 'gen_estado',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'general'
    });
    GenEstado.associate = function(models) {
        GenEstado.hasMany(models.FinMovimiento, { foreignKey: 'id_estado' });        
        GenEstado.hasMany(models.FinFactura, { foreignKey: 'id_estado' });        
    };
    return GenEstado;
};