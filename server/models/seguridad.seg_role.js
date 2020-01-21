'use strict';
module.exports = (sequelize, DataTypes) => {
    var SegRole = sequelize.define('SegRole', {
        id_role: {
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
        tableName: 'seg_role',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'seguridad',
        classMethods: {
            associate: function(models) {
                models.SegRole.hasMany(models.SegRoleUsuario, { foreignKey: "id_role" });
            }
        },
    });
    return SegRole;
}