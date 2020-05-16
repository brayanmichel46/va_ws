'use strict';
module.exports = (sequelize, DataTypes) => {
    var FinMovimiento = sequelize.define('FinMovimiento', {
        id_movimiento: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_sucursal: {
            type: DataTypes.INTEGER,
            allowNull: true
        },
        id_tipo_movimiento: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        fecha: {
            type: DataTypes.DATE,
            allowNull: false
        },
        observacion: {
            type: DataTypes.DATE,
            allowNull: true
        },
        id_estado: {
            type: DataTypes.INTEGER,
            allowNull: false
        },
    }, {
        tableName: 'fin_movimiento',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'financiero'
    });
    FinMovimiento.associate = function(models) {
        FinMovimiento.hasOne(models.FinFactura,{foreignKey:'id_movimiento'});        
        /* FinMovimiento.hasOne(models.SegUsuario, { foreignKey: 'id_persona' });
        FinMovimiento.hasOne(models.CliCliente, { foreignKey: 'id_persona' }); */
    };
    return FinMovimiento;
};