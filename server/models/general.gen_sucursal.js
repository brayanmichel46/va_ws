'use strict';
module.exports = (sequelize, DataTypes) => {
    var GenSucursal = sequelize.define('GenSucursal', {
        id_sucursal: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        nombre: {
            type: DataTypes.STRING,
            allowNull:false
        },   
        telefono:{
            type:DataTypes.STRING,
            allowNull:false
        },
        direccion:{
            type:DataTypes.STRING,
            allowNull:false
        }  
    }, {
        tableName: 'gen_sucursal',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'general'
    });
    GenSucursal.associate = function(models) {
        GenSucursal.hasMany(models.FinMovimiento, { foreignKey: 'id_sucursal' });
        GenSucursal.hasMany(models.SegUsuario, { foreignKey: 'id_sucursal' });        
    };
    return GenSucursal;
};