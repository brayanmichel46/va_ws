'use strict';
module.exports = (sequelize, DataTypes) => {
    var SegRoleUsuario = sequelize.define('SegRoleUsuario', {
        id_role_usuario: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_role: {
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
       /*  classMethods: {
            associate: function(models) {
                models.SegRoleUsuario.belongsTo(models.SegRole, { foreignKey: 'id_role' });
                models.SegRoleUsuario.belongsTo(models.SegUsuario, { foreignKey: 'id_usuario' });                
            }
        }, */
    });
    SegRoleUsuario.associate = function(models) {
        SegRoleUsuario.belongsTo(models.SegRole, { foreignKey: 'id_role' });
        SegRoleUsuario.belongsTo(models.SegUsuario, { foreignKey: 'id_usuario' });  
    };
    return SegRoleUsuario;
}