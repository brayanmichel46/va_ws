'use strict'
module.exports = (sequelize, DataTypes) => {
    var SegUsuario = sequelize.define('SegUsuario', {
        id_usuario: {
            type: DataTypes.BIGINT,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        id_persona: {
            type: DataTypes.BIGINT,
            allowNull: false,
        },
        email: {
            type: DataTypes.STRING,
            allowNull: false,
            validate: {
                len: {
                    args: [6, 128],
                    msg: "El email debe tener entre 6 y 128 caracteres"
                },
                isEmail: {
                    msg: "El email no es valido"
                },
                isUnique: function(value, next) {
                    var self = this;
                    SegUsuario.find({ where: { email: value } })
                        .then(function(user) {
                            // reject if a different user wants to use the same email
                            if (user) {
                                return next('El email debe ser unico!');
                            }


                            return next();
                        })
                        .catch(function(err) {
                            return next(err);
                        });
                }
            },
        },
        password: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        img: {
            type: DataTypes.STRING,
            allowNull: true
        },
        google: {
            type: DataTypes.BOOLEAN,
            allowNull: true
        },
        estado:{
            type:DataTypes.CHAR(1),
            allowNull:false
        }
    }, {
        tableName: 'seg_usuario',
        timestamps: false,
        underscored: true,
        freezeTableName: true,
        schema: 'seguridad'
    });
    SegUsuario.associate = function(models) {
        SegUsuario.belongsTo(models.GenPersona, { foreignKey: 'id_persona' });
        SegUsuario.hasMany(models.SegRoleUsuario, { foreignKey: 'id_usuario' });
    };
    return SegUsuario;
}