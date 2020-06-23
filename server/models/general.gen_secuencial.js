'use strict';
module.exports = (sequelize, DataTypes) => {
    var GenSecuencial = sequelize.define('GenSecuencial', {
        id_secuencial: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        descripcion: {
            type: DataTypes.STRING(50),
            allowNull:false
        },   
        secuencial:{
            type:DataTypes.BIGINT,
            allowNull:false
        }     
    }, {
        tableName: 'gen_secuencial',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'general'
    });
    GenSecuencial.associate = function(models) {        
        GenSecuencial.hasMany(models.FinFactura, { foreignKey: 'id_secuencial' });        
    };
    return GenSecuencial;
};