'use strict';
module.exports = (sequelize, DataTypes) => {
    var GenPersona = sequelize.define('GenPersona', {
        id_persona: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        identificacion: {
            type: DataTypes.STRING,
            allowNull: true
        },
        nombre: {
            type: DataTypes.STRING,
            allowNull: false
        }
    }, {
        tableName: 'gen_persona',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'general',
        /* classMethods: {
            associate: function(models) {
                models.GenPersona.belongsTo(models.SegUsuario, { foreignKey: 'id_persona' });
                models.GenPersona.belongsTo(models.CliCliente, { foreignKey: 'id_persona' });
            }
        }, */
    });
    GenPersona.associate = function(models) {
        GenPersona.hasOne(models.SegUsuario, { foreignKey: 'id_persona' });
        GenPersona.hasOne(models.CliCliente, { foreignKey: 'id_persona' });
    };
    return GenPersona;
};