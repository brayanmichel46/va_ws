'use strict';
module.exports = (sequelize, DataTypes) => {
    var GenTipUnidad = sequelize.define('GenTipUnidad', {
        id_tip_unidad: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        descripcion: {
            type: DataTypes.STRING,
            allowNull: false
        },        
    }, {
        tableName: 'gen_tip_unidad',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'general'
    });
    GenTipUnidad.associate = function(models) {
        GenTipUnidad.hasMany(models.GenTipUnidad, { foreignKey: 'id_tip_unidad' });    
    };
    return GenTipUnidad;
};