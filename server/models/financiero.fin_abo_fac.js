'use strict';
module.exports = (sequelize, DataTypes) => {
    var FinAboFac = sequelize.define('FinAboFac', {
        id_abo_fac: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_factura: {
            type: DataTypes.BIGINT,
            allowNull: true
        },
        id_movimiento: {
            type: DataTypes.BIGINT,
            allowNull: true
        },
        abono: {
            type: DataTypes.DECIMAL(20,2),
            allowNull: false
        },
        fec_abono: {
            type: DataTypes.DATE,
            allowNull: true
        },
        pago: {
            type: DataTypes.DECIMAL(20,2),
            allowNull: false
        },
        regreso: {
            type: DataTypes.DECIMAL(20,2),
            allowNull: false
        },
        saldo: {
            type: DataTypes.DECIMAL(20,2),
            allowNull: false
        },
    }, {
        tableName: 'fin_abo_fac',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'financiero'
    });
    FinAboFac.associate = function(models) {
        FinAboFac.belongsTo(models.FinFactura,{foreignKey:'id_factura'});
        /* FinAboFac.hasOne(models.SegUsuario, { foreignKey: 'id_persona' });
        FinAboFac.hasOne(models.CliCliente, { foreignKey: 'id_persona' }); */
    };
    return FinAboFac;
};