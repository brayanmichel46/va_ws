'use strict';
module.exports = (sequelize, DataTypes) => {
    var SegRoleUsuario = sequelize.define('SegRoleUsuario', {
        id_role_usuario: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_rol: {
            type: DataTypes.BIGINT,
            allowNull: false
        },
        id_usuario: {
            type: DataTypes.BIGINT,
            allowNull: false
        }
    }, {
        tableName: 'seg_role_usuario',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'seguridad',
        classMethods: {
            associate: function(models) {
                models.SegRoleUsuario.belongsTo(models.SegUsuario, { foreignKey: 'id_usuario' });
                models.SegRoleUsuario.belongsTo(models.SegRole, { foreignKey: 'id_role' });
            }
        },
    });
    return SegRoleUsuario;
}