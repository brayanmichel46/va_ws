'use strict';
module.exports = (sequelize, DataTypes) => {
    var CliCliente = sequelize.define('CliCliente', {
        id_cliente: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_persona: {
            type: DataTypes.BIGINT,
            allowNull: false
        },
        direccion: {
            type: DataTypes.STRING(250),
            allowNull: true
        },
        email: {
            type: DataTypes.STRING(140),
            allowNull: true
        },
        celular: {
            type: DataTypes.STRING(20),
            allowNull: true
        },
        telefono: {
            type: DataTypes.STRING(20),
            allowNull: true
        },
        img: {
            type: DataTypes.STRING,
            allowNull: true
        }
    }, {
        tableName: 'cli_cliente',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'ventas',
        /*       classMethods: {
                  associate: function(models) {
                      models.CliCliente.belongsTo(models.GenPersona, { foreignKey: 'id_persona' });
                  }
              }, */
    });
    CliCliente.associate = function(models) {
        CliCliente.belongsTo(models.GenPersona, { foreignKey: 'id_persona' });
    };
    return CliCliente;
};