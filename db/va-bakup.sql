PGDMP         &            	    z            va    10.11    13.1 9              0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16393    va    DATABASE     ^   CREATE DATABASE va WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE va;
                postgres    false                        2615    16537 
   financiero    SCHEMA        CREATE SCHEMA financiero;
    DROP SCHEMA financiero;
                postgres    false                       0    0    SCHEMA financiero    COMMENT     e   COMMENT ON SCHEMA financiero IS 'Contiene todos los datos referentes a los movimientos financieros';
                   postgres    false    12                        2615    16394    general    SCHEMA        CREATE SCHEMA general;
    DROP SCHEMA general;
                postgres    false                       0    0    SCHEMA general    COMMENT     t   COMMENT ON SCHEMA general IS 'Esquema que contine tablas de uso general para otros esquemas
y toda la aplicacion';
                   postgres    false    6            
            2615    16495 
   inventario    SCHEMA        CREATE SCHEMA inventario;
    DROP SCHEMA inventario;
                postgres    false                        2615    16408 	   seguridad    SCHEMA        CREATE SCHEMA seguridad;
    DROP SCHEMA seguridad;
                postgres    false                       0    0    SCHEMA seguridad    COMMENT     [   COMMENT ON SCHEMA seguridad IS 'Tablas para la gestion de la seguridad de la aplicacion.';
                   postgres    false    5                        2615    16458    ventas    SCHEMA        CREATE SCHEMA ventas;
    DROP SCHEMA ventas;
                postgres    false                       0    0    SCHEMA ventas    COMMENT     m   COMMENT ON SCHEMA ventas IS 'Esquema que contiene las tablas para gestionar todo lo relacionado con ventas';
                   postgres    false    11            �            1259    24791    fin_det_factura    TABLE     �  CREATE TABLE financiero.fin_det_factura (
    id_det_factura bigint NOT NULL,
    id_factura bigint NOT NULL,
    cantidad numeric(6,2) NOT NULL,
    detalle character varying(250) NOT NULL,
    sub_total numeric(20,2) NOT NULL,
    descuento smallint DEFAULT 0 NOT NULL,
    vr_descuento numeric(20,2) DEFAULT 0 NOT NULL,
    vr_transporte numeric(20,2) DEFAULT 0 NOT NULL,
    vr_antes_iva numeric(20,2) NOT NULL,
    iva smallint DEFAULT 0 NOT NULL,
    vr_iva numeric(20,2) DEFAULT 0 NOT NULL,
    total numeric(20,2) NOT NULL,
    id_inventario bigint NOT NULL
);
ALTER TABLE ONLY financiero.fin_det_factura ALTER COLUMN id_det_factura SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_det_factura ALTER COLUMN id_factura SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_det_factura ALTER COLUMN cantidad SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_det_factura ALTER COLUMN detalle SET STATISTICS 0;
 '   DROP TABLE financiero.fin_det_factura;
    
   financiero            postgres    false    12                       0    0    TABLE fin_det_factura    COMMENT     k   COMMENT ON TABLE financiero.fin_det_factura IS 'Tabla que contiene los items relacionados a una factura.';
       
   financiero          postgres    false    222                       0    0 %   COLUMN fin_det_factura.id_det_factura    COMMENT     ]   COMMENT ON COLUMN financiero.fin_det_factura.id_det_factura IS 'Identificador de la tabla.';
       
   financiero          postgres    false    222                       0    0 !   COLUMN fin_det_factura.id_factura    COMMENT     �   COMMENT ON COLUMN financiero.fin_det_factura.id_factura IS 'Llave foranea que relaciona el detalle del movimiento con el movimiento.';
       
   financiero          postgres    false    222                       0    0    COLUMN fin_det_factura.cantidad    COMMENT     �   COMMENT ON COLUMN financiero.fin_det_factura.cantidad IS 'CANTIDAD DE INVENTARIO QUE SE RELACIONA EN EL DETALLE DE LA FACTURA.';
       
   financiero          postgres    false    222                       0    0    COLUMN fin_det_factura.detalle    COMMENT     r   COMMENT ON COLUMN financiero.fin_det_factura.detalle IS 'Caampo donde se describe los detalles dle moviemiento.';
       
   financiero          postgres    false    222                        0    0     COLUMN fin_det_factura.sub_total    COMMENT     c   COMMENT ON COLUMN financiero.fin_det_factura.sub_total IS 'subtotal del item antes de descuento.';
       
   financiero          postgres    false    222            !           0    0     COLUMN fin_det_factura.descuento    COMMENT     e   COMMENT ON COLUMN financiero.fin_det_factura.descuento IS 'Porcentaje de descuento del movimiento.';
       
   financiero          postgres    false    222            "           0    0 #   COLUMN fin_det_factura.vr_descuento    COMMENT     l   COMMENT ON COLUMN financiero.fin_det_factura.vr_descuento IS 'Valor del descuento del detalle movimiento.';
       
   financiero          postgres    false    222            #           0    0 $   COLUMN fin_det_factura.vr_transporte    COMMENT     _   COMMENT ON COLUMN financiero.fin_det_factura.vr_transporte IS 'Valor del trasporte del item.';
       
   financiero          postgres    false    222            $           0    0 #   COLUMN fin_det_factura.vr_antes_iva    COMMENT     �   COMMENT ON COLUMN financiero.fin_det_factura.vr_antes_iva IS 'Valor del item restado los descuentos y sumado otros costos ejemplo: transporte.';
       
   financiero          postgres    false    222            %           0    0    COLUMN fin_det_factura.iva    COMMENT     S   COMMENT ON COLUMN financiero.fin_det_factura.iva IS 'porcentaje de iva del item.';
       
   financiero          postgres    false    222            &           0    0    COLUMN fin_det_factura.vr_iva    COMMENT     R   COMMENT ON COLUMN financiero.fin_det_factura.vr_iva IS 'Valor del iva del item.';
       
   financiero          postgres    false    222            '           0    0    COLUMN fin_det_factura.total    COMMENT     U   COMMENT ON COLUMN financiero.fin_det_factura.total IS 'Valor total del movimiento.';
       
   financiero          postgres    false    222            (           0    0 $   COLUMN fin_det_factura.id_inventario    COMMENT     �   COMMENT ON COLUMN financiero.fin_det_factura.id_inventario IS 'llave foranea que relaciona el item con un inventario (con un producto).';
       
   financiero          postgres    false    222            �            1259    24789 ,   detalle_movimiento_id_detalle_movimiento_seq    SEQUENCE     �   CREATE SEQUENCE financiero.detalle_movimiento_id_detalle_movimiento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 G   DROP SEQUENCE financiero.detalle_movimiento_id_detalle_movimiento_seq;
    
   financiero          postgres    false    222    12            )           0    0 ,   detalle_movimiento_id_detalle_movimiento_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE financiero.detalle_movimiento_id_detalle_movimiento_seq OWNED BY financiero.fin_det_factura.id_det_factura;
       
   financiero          postgres    false    221            �            1259    24806 $   detalle_movimiento_id_inventario_seq    SEQUENCE     �   CREATE SEQUENCE financiero.detalle_movimiento_id_inventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE financiero.detalle_movimiento_id_inventario_seq;
    
   financiero          postgres    false    222    12            *           0    0 $   detalle_movimiento_id_inventario_seq    SEQUENCE OWNED BY     r   ALTER SEQUENCE financiero.detalle_movimiento_id_inventario_seq OWNED BY financiero.fin_det_factura.id_inventario;
       
   financiero          postgres    false    223            �            1259    25597    fin_abo_fac    TABLE     +  CREATE TABLE financiero.fin_abo_fac (
    id_abo_fac bigint NOT NULL,
    id_factura bigint NOT NULL,
    id_movimiento bigint,
    abono numeric(20,2) NOT NULL,
    fec_abono timestamp(0) with time zone DEFAULT now() NOT NULL,
    pago numeric(20,2),
    regreso numeric(20,2),
    saldo numeric(20,2)
);
ALTER TABLE ONLY financiero.fin_abo_fac ALTER COLUMN id_abo_fac SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_abo_fac ALTER COLUMN id_factura SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_abo_fac ALTER COLUMN id_movimiento SET STATISTICS 0;
 #   DROP TABLE financiero.fin_abo_fac;
    
   financiero            postgres    false    12            +           0    0    COLUMN fin_abo_fac.id_abo_fac    COMMENT     e   COMMENT ON COLUMN financiero.fin_abo_fac.id_abo_fac IS 'IDENTIFICADOR ÚNICO DEL ABONO DE FACTURA.';
       
   financiero          postgres    false    242            ,           0    0    COLUMN fin_abo_fac.id_factura    COMMENT     y   COMMENT ON COLUMN financiero.fin_abo_fac.id_factura IS 'LLAVE FORANEA QUE IDENTIFICA A QUE FACTURA PERTENECE EL ABONO.';
       
   financiero          postgres    false    242            -           0    0     COLUMN fin_abo_fac.id_movimiento    COMMENT        COMMENT ON COLUMN financiero.fin_abo_fac.id_movimiento IS 'LLAVE FORANEA QUE IDENTIFICA EL MOVIMIENTO QUE REGISTRO EL ABONO.';
       
   financiero          postgres    false    242            .           0    0    COLUMN fin_abo_fac.abono    COMMENT     X   COMMENT ON COLUMN financiero.fin_abo_fac.abono IS 'ABONO QUE SE REALIZA A LA FACTURA.';
       
   financiero          postgres    false    242            /           0    0    COLUMN fin_abo_fac.fec_abono    COMMENT     l   COMMENT ON COLUMN financiero.fin_abo_fac.fec_abono IS 'FECHA EN LA QUE SE REALIZA EL ABONO A UNA FACTURA.';
       
   financiero          postgres    false    242            0           0    0    COLUMN fin_abo_fac.pago    COMMENT     D   COMMENT ON COLUMN financiero.fin_abo_fac.pago IS 'VALOR DEL PAGO.';
       
   financiero          postgres    false    242            1           0    0    COLUMN fin_abo_fac.regreso    COMMENT     O   COMMENT ON COLUMN financiero.fin_abo_fac.regreso IS 'VALOR DEL REGRESO DADO.';
       
   financiero          postgres    false    242            2           0    0    COLUMN fin_abo_fac.saldo    COMMENT     Y   COMMENT ON COLUMN financiero.fin_abo_fac.saldo IS 'SALDO RESULTANTE DESPUES DEL ABONO.';
       
   financiero          postgres    false    242            �            1259    25595    fin_abo_fac_id_abo_fac_seq    SEQUENCE     �   CREATE SEQUENCE financiero.fin_abo_fac_id_abo_fac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE financiero.fin_abo_fac_id_abo_fac_seq;
    
   financiero          postgres    false    12    242            3           0    0    fin_abo_fac_id_abo_fac_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE financiero.fin_abo_fac_id_abo_fac_seq OWNED BY financiero.fin_abo_fac.id_abo_fac;
       
   financiero          postgres    false    241            �            1259    24817    fin_fac_par    TABLE     2  CREATE TABLE financiero.fin_fac_par (
    id_fac_par bigint NOT NULL,
    id_det_factura bigint NOT NULL,
    parametros json NOT NULL
);
ALTER TABLE ONLY financiero.fin_fac_par ALTER COLUMN id_fac_par SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_fac_par ALTER COLUMN id_det_factura SET STATISTICS 0;
 #   DROP TABLE financiero.fin_fac_par;
    
   financiero            postgres    false    12            4           0    0    TABLE fin_fac_par    COMMENT     �   COMMENT ON TABLE financiero.fin_fac_par IS 'Contiene datos adicionales si el item lo requiere
ejemplo un vidrio tiene medidas que usan para el calculo 
del area del vidrio.';
       
   financiero          postgres    false    226            5           0    0    COLUMN fin_fac_par.id_fac_par    COMMENT     m   COMMENT ON COLUMN financiero.fin_fac_par.id_fac_par IS 'IDENTIFICADOR UNICO DE LA TABLA FACTURA PARAMETRO.';
       
   financiero          postgres    false    226            6           0    0 !   COLUMN fin_fac_par.id_det_factura    COMMENT     �   COMMENT ON COLUMN financiero.fin_fac_par.id_det_factura IS 'LLAVE FORANEA QUE IDENTIFICA A QUE DETALLE FACTURA PERTENECE EL PARAMETRO.';
       
   financiero          postgres    false    226            7           0    0    COLUMN fin_fac_par.parametros    COMMENT     [   COMMENT ON COLUMN financiero.fin_fac_par.parametros IS 'PARAMETROS ADICIONALES DEL ITEM.';
       
   financiero          postgres    false    226            �            1259    24813    fin_fac_item_id_fac_item_seq    SEQUENCE     �   CREATE SEQUENCE financiero.fin_fac_item_id_fac_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE financiero.fin_fac_item_id_fac_item_seq;
    
   financiero          postgres    false    226    12            8           0    0    fin_fac_item_id_fac_item_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE financiero.fin_fac_item_id_fac_item_seq OWNED BY financiero.fin_fac_par.id_fac_par;
       
   financiero          postgres    false    224            �            1259    24815    fin_fac_item_id_factura_seq    SEQUENCE     �   CREATE SEQUENCE financiero.fin_fac_item_id_factura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE financiero.fin_fac_item_id_factura_seq;
    
   financiero          postgres    false    12    226            9           0    0    fin_fac_item_id_factura_seq    SEQUENCE OWNED BY     f   ALTER SEQUENCE financiero.fin_fac_item_id_factura_seq OWNED BY financiero.fin_fac_par.id_det_factura;
       
   financiero          postgres    false    225            �            1259    24832    fin_factura    TABLE     �  CREATE TABLE financiero.fin_factura (
    id_factura bigint NOT NULL,
    id_cliente bigint NOT NULL,
    id_estado smallint NOT NULL,
    totales json NOT NULL,
    items json NOT NULL,
    total numeric(20,2) NOT NULL,
    saldo numeric(20,2) NOT NULL,
    transporte numeric(20,2) NOT NULL,
    descuento numeric(3,1) NOT NULL,
    id_movimiento bigint,
    fec_factura timestamp(0) with time zone DEFAULT now() NOT NULL,
    num_factura character varying(50) DEFAULT 'NA'::character varying NOT NULL
);
ALTER TABLE ONLY financiero.fin_factura ALTER COLUMN id_factura SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_factura ALTER COLUMN id_cliente SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_factura ALTER COLUMN id_estado SET STATISTICS 0;
 #   DROP TABLE financiero.fin_factura;
    
   financiero            postgres    false    12            :           0    0    TABLE fin_factura    COMMENT     �   COMMENT ON TABLE financiero.fin_factura IS 'Tabla para manejar los detalles genetales de una factura esta tabla se extiende de movimiento';
       
   financiero          postgres    false    229            ;           0    0    COLUMN fin_factura.id_factura    COMMENT     [   COMMENT ON COLUMN financiero.fin_factura.id_factura IS 'Identificador unico de la tabla.';
       
   financiero          postgres    false    229            <           0    0    COLUMN fin_factura.id_cliente    COMMENT     �   COMMENT ON COLUMN financiero.fin_factura.id_cliente IS 'llave foranea que relaciona la tabla factura con el cliente relacionado a esta.';
       
   financiero          postgres    false    229            =           0    0    COLUMN fin_factura.id_estado    COMMENT     �   COMMENT ON COLUMN financiero.fin_factura.id_estado IS 'llave foranea que relaciona la factura con el estado en el que se encuentra ejemplo: abono, cancelado, eliminado.';
       
   financiero          postgres    false    229            >           0    0    COLUMN fin_factura.totales    COMMENT     k   COMMENT ON COLUMN financiero.fin_factura.totales IS 'OBJETO JSON QUE CONTIENE LOS TOTALES DE LA FACTURA.';
       
   financiero          postgres    false    229            ?           0    0    COLUMN fin_factura.items    COMMENT     q   COMMENT ON COLUMN financiero.fin_factura.items IS 'ARRAY DE OBJETOS JSON QUE CONTIENE LOS ITEMS DE LA FACTURA.';
       
   financiero          postgres    false    229            @           0    0    COLUMN fin_factura.total    COMMENT     O   COMMENT ON COLUMN financiero.fin_factura.total IS 'VALOR TOTAL DE LA FACTURA';
       
   financiero          postgres    false    229            A           0    0    COLUMN fin_factura.saldo    COMMENT     [   COMMENT ON COLUMN financiero.fin_factura.saldo IS 'SALDO PENDIENTE DE PAGO DE LA FACTURA';
       
   financiero          postgres    false    229            B           0    0    COLUMN fin_factura.transporte    COMMENT     P   COMMENT ON COLUMN financiero.fin_factura.transporte IS 'VALOR DEL TRANSPORTE.';
       
   financiero          postgres    false    229            C           0    0    COLUMN fin_factura.descuento    COMMENT     `   COMMENT ON COLUMN financiero.fin_factura.descuento IS 'PORCENTAJE DE DESCUENTO DE LA FACTURA.';
       
   financiero          postgres    false    229            D           0    0     COLUMN fin_factura.id_movimiento    COMMENT     �   COMMENT ON COLUMN financiero.fin_factura.id_movimiento IS 'LLAVE FORANEA QUE IDENTIFICA LOS MOVIMIENTOS CONTABLES A LOS QUE PERTENESE LA FACTURA.';
       
   financiero          postgres    false    229            E           0    0    COLUMN fin_factura.fec_factura    COMMENT     a   COMMENT ON COLUMN financiero.fin_factura.fec_factura IS 'FECHA EN LA QUE SE GENERA LA FACTURA.';
       
   financiero          postgres    false    229            F           0    0    COLUMN fin_factura.num_factura    COMMENT     a   COMMENT ON COLUMN financiero.fin_factura.num_factura IS 'SECUENCIAL QUE IDENTIFICA LA FACTURA.';
       
   financiero          postgres    false    229            �            1259    24830    fin_factura_id_cliente_seq    SEQUENCE     �   CREATE SEQUENCE financiero.fin_factura_id_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE financiero.fin_factura_id_cliente_seq;
    
   financiero          postgres    false    12    229            G           0    0    fin_factura_id_cliente_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE financiero.fin_factura_id_cliente_seq OWNED BY financiero.fin_factura.id_cliente;
       
   financiero          postgres    false    228            �            1259    24826    fin_factura_id_factura_seq    SEQUENCE     �   CREATE SEQUENCE financiero.fin_factura_id_factura_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE financiero.fin_factura_id_factura_seq;
    
   financiero          postgres    false    229    12            H           0    0    fin_factura_id_factura_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE financiero.fin_factura_id_factura_seq OWNED BY financiero.fin_factura.id_factura;
       
   financiero          postgres    false    227            �            1259    25539 	   fin_fondo    TABLE     �   CREATE TABLE financiero.fin_fondo (
    fondo character varying(20) NOT NULL,
    id_fondo smallint NOT NULL
);
ALTER TABLE ONLY financiero.fin_fondo ALTER COLUMN fondo SET STATISTICS 0;
 !   DROP TABLE financiero.fin_fondo;
    
   financiero            postgres    false    12            I           0    0    TABLE fin_fondo    COMMENT     �   COMMENT ON TABLE financiero.fin_fondo IS 'TABLA PERSONALIZADA QUE CONTIENE LOS FONDOS DE LA EMPRESA (PARTICULARIDAD VICTOR H)';
       
   financiero          postgres    false    237            J           0    0    COLUMN fin_fondo.fondo    COMMENT     Q   COMMENT ON COLUMN financiero.fin_fondo.fondo IS 'DESCRIPCIÓN CORTA DEL FONDO.';
       
   financiero          postgres    false    237            K           0    0    COLUMN fin_fondo.id_fondo    COMMENT     V   COMMENT ON COLUMN financiero.fin_fondo.id_fondo IS 'IDENTIFICADOR ÚNICO DEL FONDO.';
       
   financiero          postgres    false    237            �            1259    25546    fin_fondo_id_fondo_seq    SEQUENCE     �   CREATE SEQUENCE financiero.fin_fondo_id_fondo_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE financiero.fin_fondo_id_fondo_seq;
    
   financiero          postgres    false    12    237            L           0    0    fin_fondo_id_fondo_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE financiero.fin_fondo_id_fondo_seq OWNED BY financiero.fin_fondo.id_fondo;
       
   financiero          postgres    false    238            �            1259    16538    fin_movimiento    TABLE     �  CREATE TABLE financiero.fin_movimiento (
    id_movimiento bigint NOT NULL,
    id_sucursal smallint,
    id_tipo_movimiento smallint NOT NULL,
    fecha timestamp with time zone DEFAULT now() NOT NULL,
    observacion text DEFAULT 'NA'::text NOT NULL,
    id_estado smallint NOT NULL
);
ALTER TABLE ONLY financiero.fin_movimiento ALTER COLUMN id_movimiento SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_movimiento ALTER COLUMN id_sucursal SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_movimiento ALTER COLUMN id_tipo_movimiento SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_movimiento ALTER COLUMN fecha SET STATISTICS 0;
ALTER TABLE ONLY financiero.fin_movimiento ALTER COLUMN observacion SET STATISTICS 0;
 &   DROP TABLE financiero.fin_movimiento;
    
   financiero            postgres    false    12            M           0    0 #   COLUMN fin_movimiento.id_movimiento    COMMENT     e   COMMENT ON COLUMN financiero.fin_movimiento.id_movimiento IS 'Identificador único del movimiento.';
       
   financiero          postgres    false    217            N           0    0 !   COLUMN fin_movimiento.id_sucursal    COMMENT     |   COMMENT ON COLUMN financiero.fin_movimiento.id_sucursal IS 'llave foranea a la sucursal que esta haciendo el moviemiento.';
       
   financiero          postgres    false    217            O           0    0 (   COLUMN fin_movimiento.id_tipo_movimiento    COMMENT     r   COMMENT ON COLUMN financiero.fin_movimiento.id_tipo_movimiento IS 'llave foranea a la tabla tipo de movimiento.';
       
   financiero          postgres    false    217            P           0    0    COLUMN fin_movimiento.fecha    COMMENT     _   COMMENT ON COLUMN financiero.fin_movimiento.fecha IS 'Fecha en la que se realiza la factura.';
       
   financiero          postgres    false    217            Q           0    0 !   COLUMN fin_movimiento.observacion    COMMENT     \   COMMENT ON COLUMN financiero.fin_movimiento.observacion IS 'Observaciones del movimiento.';
       
   financiero          postgres    false    217            R           0    0    COLUMN fin_movimiento.id_estado    COMMENT     �   COMMENT ON COLUMN financiero.fin_movimiento.id_estado IS 'LLave foranea que relaciona el movimiento con el estado en que se encuentra ejemplo: abierto, cerrado, eliminado.';
       
   financiero          postgres    false    217            �            1259    24842 
   gen_estado    TABLE     �  CREATE TABLE general.gen_estado (
    id_estado smallint NOT NULL,
    descripcion character varying(20) NOT NULL,
    clase character varying(20) NOT NULL
);
ALTER TABLE ONLY general.gen_estado ALTER COLUMN id_estado SET STATISTICS 0;
ALTER TABLE ONLY general.gen_estado ALTER COLUMN descripcion SET STATISTICS 0;
ALTER TABLE ONLY general.gen_estado ALTER COLUMN clase SET STATISTICS 0;
    DROP TABLE general.gen_estado;
       general            postgres    false    6            S           0    0    COLUMN gen_estado.id_estado    COMMENT     W   COMMENT ON COLUMN general.gen_estado.id_estado IS 'Identificador uníco de la tabla.';
          general          postgres    false    231            T           0    0    COLUMN gen_estado.descripcion    COMMENT     O   COMMENT ON COLUMN general.gen_estado.descripcion IS 'Descripcion del estado.';
          general          postgres    false    231            U           0    0    COLUMN gen_estado.clase    COMMENT     j   COMMENT ON COLUMN general.gen_estado.clase IS 'Clase del estado ejemplo : error, warning, succes, info.';
          general          postgres    false    231            �            1259    24840    gen_estado_id_estado_seq    SEQUENCE     �   CREATE SEQUENCE general.gen_estado_id_estado_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE general.gen_estado_id_estado_seq;
       general          postgres    false    6    231            V           0    0    gen_estado_id_estado_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE general.gen_estado_id_estado_seq OWNED BY general.gen_estado.id_estado;
          general          postgres    false    230            �            1259    16397    gen_persona    TABLE     �  CREATE TABLE general.gen_persona (
    id_persona bigint NOT NULL,
    identificacion character varying(20) DEFAULT NULL::character varying,
    nombre character varying(250) NOT NULL
);
ALTER TABLE ONLY general.gen_persona ALTER COLUMN id_persona SET STATISTICS 0;
ALTER TABLE ONLY general.gen_persona ALTER COLUMN identificacion SET STATISTICS 0;
ALTER TABLE ONLY general.gen_persona ALTER COLUMN nombre SET STATISTICS 0;
     DROP TABLE general.gen_persona;
       general            postgres    false    6            W           0    0    COLUMN gen_persona.id_persona    COMMENT     a   COMMENT ON COLUMN general.gen_persona.id_persona IS 'Identificador uníco de la tabla persona.';
          general          postgres    false    202            X           0    0 !   COLUMN gen_persona.identificacion    COMMENT     c   COMMENT ON COLUMN general.gen_persona.identificacion IS 'Numero de identificacón de la persona.';
          general          postgres    false    202            Y           0    0    COLUMN gen_persona.nombre    COMMENT     Q   COMMENT ON COLUMN general.gen_persona.nombre IS 'Nombre completo de la persona';
          general          postgres    false    202            �            1259    16395    gen_persona_id_persona_seq    SEQUENCE     �   CREATE SEQUENCE general.gen_persona_id_persona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE general.gen_persona_id_persona_seq;
       general          postgres    false    202    6            Z           0    0    gen_persona_id_persona_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE general.gen_persona_id_persona_seq OWNED BY general.gen_persona.id_persona;
          general          postgres    false    201            �            1259    25641    gen_secuencial    TABLE     �  CREATE TABLE general.gen_secuencial (
    id_secuencial smallint NOT NULL,
    descripcion character varying(50) NOT NULL,
    secuencial bigint NOT NULL
);
ALTER TABLE ONLY general.gen_secuencial ALTER COLUMN id_secuencial SET STATISTICS 0;
ALTER TABLE ONLY general.gen_secuencial ALTER COLUMN descripcion SET STATISTICS 0;
ALTER TABLE ONLY general.gen_secuencial ALTER COLUMN secuencial SET STATISTICS 0;
 #   DROP TABLE general.gen_secuencial;
       general            postgres    false    6            [           0    0 #   COLUMN gen_secuencial.id_secuencial    COMMENT     b   COMMENT ON COLUMN general.gen_secuencial.id_secuencial IS 'IDENTIFICADOR ÚNICO DEL SECUENCIAL.';
          general          postgres    false    244            \           0    0 !   COLUMN gen_secuencial.descripcion    COMMENT     \   COMMENT ON COLUMN general.gen_secuencial.descripcion IS 'DESCRIPCION CORTA DEL SECUENCIAL';
          general          postgres    false    244            ]           0    0     COLUMN gen_secuencial.secuencial    COMMENT     \   COMMENT ON COLUMN general.gen_secuencial.secuencial IS 'NUMERO EN EL QUE VA LA SECUENCIA.';
          general          postgres    false    244            �            1259    25639     gen_secuencial_id_secuencial_seq    SEQUENCE     �   CREATE SEQUENCE general.gen_secuencial_id_secuencial_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE general.gen_secuencial_id_secuencial_seq;
       general          postgres    false    6    244            ^           0    0     gen_secuencial_id_secuencial_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE general.gen_secuencial_id_secuencial_seq OWNED BY general.gen_secuencial.id_secuencial;
          general          postgres    false    243            �            1259    16506    gen_sucursal    TABLE     	  CREATE TABLE general.gen_sucursal (
    id_sucursal bigint NOT NULL,
    nombre character varying(250) NOT NULL,
    telefono character varying(20) NOT NULL,
    direccion character varying(100) NOT NULL
);
ALTER TABLE ONLY general.gen_sucursal ALTER COLUMN id_sucursal SET STATISTICS 0;
ALTER TABLE ONLY general.gen_sucursal ALTER COLUMN nombre SET STATISTICS 0;
ALTER TABLE ONLY general.gen_sucursal ALTER COLUMN telefono SET STATISTICS 0;
ALTER TABLE ONLY general.gen_sucursal ALTER COLUMN direccion SET STATISTICS 0;
 !   DROP TABLE general.gen_sucursal;
       general            postgres    false    6            _           0    0    TABLE gen_sucursal    COMMENT     h   COMMENT ON TABLE general.gen_sucursal IS 'Tabla para el manejo de los datos generales de una sucursal';
          general          postgres    false    214            `           0    0    COLUMN gen_sucursal.id_sucursal    COMMENT     [   COMMENT ON COLUMN general.gen_sucursal.id_sucursal IS 'Identificador único de la tabla.';
          general          postgres    false    214            a           0    0    COLUMN gen_sucursal.nombre    COMMENT     K   COMMENT ON COLUMN general.gen_sucursal.nombre IS 'Nombre de la sucursal.';
          general          postgres    false    214            b           0    0    COLUMN gen_sucursal.telefono    COMMENT     O   COMMENT ON COLUMN general.gen_sucursal.telefono IS 'Telefono de la sucursal.';
          general          postgres    false    214            c           0    0    COLUMN gen_sucursal.direccion    COMMENT     P   COMMENT ON COLUMN general.gen_sucursal.direccion IS 'Direccion de la sucursal';
          general          postgres    false    214            �            1259    16504    gen_sucursal_id_sucursal_seq    SEQUENCE     �   CREATE SEQUENCE general.gen_sucursal_id_sucursal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE general.gen_sucursal_id_sucursal_seq;
       general          postgres    false    214    6            d           0    0    gen_sucursal_id_sucursal_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE general.gen_sucursal_id_sucursal_seq OWNED BY general.gen_sucursal.id_sucursal;
          general          postgres    false    213            �            1259    16566    gen_tip_unidad    TABLE     #  CREATE TABLE general.gen_tip_unidad (
    id_tip_unidad bigint NOT NULL,
    descripcion character varying(20) NOT NULL
);
ALTER TABLE ONLY general.gen_tip_unidad ALTER COLUMN id_tip_unidad SET STATISTICS 0;
ALTER TABLE ONLY general.gen_tip_unidad ALTER COLUMN descripcion SET STATISTICS 0;
 #   DROP TABLE general.gen_tip_unidad;
       general            postgres    false    6            e           0    0    TABLE gen_tip_unidad    COMMENT     b   COMMENT ON TABLE general.gen_tip_unidad IS 'Tabla que contiene los tipos de unidades de medida.';
          general          postgres    false    220            f           0    0 #   COLUMN gen_tip_unidad.id_tip_unidad    COMMENT     ^   COMMENT ON COLUMN general.gen_tip_unidad.id_tip_unidad IS 'IDENTIFICADOR UNICO DE LA TABLA.';
          general          postgres    false    220            g           0    0 !   COLUMN gen_tip_unidad.descripcion    COMMENT     �   COMMENT ON COLUMN general.gen_tip_unidad.descripcion IS 'DESCRIPCION EXACTA DE LO QUE LA UNIDAD DE MEDIDA MIDE EJEMPLO LONGITUD, AREA, POTENCIA.';
          general          postgres    false    220            �            1259    16564 "   gen_tipo_unidad_id_tipo_unidad_seq    SEQUENCE     �   CREATE SEQUENCE general.gen_tipo_unidad_id_tipo_unidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE general.gen_tipo_unidad_id_tipo_unidad_seq;
       general          postgres    false    220    6            h           0    0 "   gen_tipo_unidad_id_tipo_unidad_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE general.gen_tipo_unidad_id_tipo_unidad_seq OWNED BY general.gen_tip_unidad.id_tip_unidad;
          general          postgres    false    219            �            1259    16559    gen_uni_medida    TABLE       CREATE TABLE general.gen_uni_medida (
    id_uni_medida bigint DEFAULT nextval(('general.gen_uni_medida_id_uni_medida_seq'::text)::regclass) NOT NULL,
    id_tip_unidad smallint NOT NULL,
    unidad character varying(20) NOT NULL,
    n_parametros smallint NOT NULL
);
ALTER TABLE ONLY general.gen_uni_medida ALTER COLUMN id_uni_medida SET STATISTICS 0;
ALTER TABLE ONLY general.gen_uni_medida ALTER COLUMN id_tip_unidad SET STATISTICS 0;
ALTER TABLE ONLY general.gen_uni_medida ALTER COLUMN unidad SET STATISTICS 0;
 #   DROP TABLE general.gen_uni_medida;
       general            postgres    false    6            i           0    0    TABLE gen_uni_medida    COMMENT     c   COMMENT ON TABLE general.gen_uni_medida IS 'Tabla general para el manejo de la unidad de medida.';
          general          postgres    false    218            j           0    0 #   COLUMN gen_uni_medida.id_uni_medida    COMMENT     h   COMMENT ON COLUMN general.gen_uni_medida.id_uni_medida IS 'IDENTICADOR ÚNICO DE LA UNIDAD DE MEDIDA.';
          general          postgres    false    218            k           0    0 #   COLUMN gen_uni_medida.id_tip_unidad    COMMENT     �   COMMENT ON COLUMN general.gen_uni_medida.id_tip_unidad IS 'LLAVE FORANEA QUE IDENTIFICA EL TIPO DE UNIDAD DE LA UNIDAD DE MEDIDA EJEMPLO: AREA,POTENCIA.';
          general          postgres    false    218            l           0    0    COLUMN gen_uni_medida.unidad    COMMENT     u   COMMENT ON COLUMN general.gen_uni_medida.unidad IS 'DESCRIPCIÓN DE LA UNIDAD DE MEDIDA EJEMPLO MT2, WATTS, M, cm.';
          general          postgres    false    218            m           0    0 "   COLUMN gen_uni_medida.n_parametros    COMMENT        COMMENT ON COLUMN general.gen_uni_medida.n_parametros IS 'NUMERO DE PARAMETROS NECESARIOS PARA CALCULAR LA UNIDAD DE MEDIDA.';
          general          postgres    false    218            �            1259    25476     gen_uni_medida_id_uni_medida_seq    SEQUENCE     �   CREATE SEQUENCE general.gen_uni_medida_id_uni_medida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE general.gen_uni_medida_id_uni_medida_seq;
       general          postgres    false    6            �            1259    25488    par_formula    TABLE     ~  CREATE TABLE general.par_formula (
    id_formula smallint NOT NULL,
    formula text NOT NULL,
    descripcion character varying(100) NOT NULL
);
ALTER TABLE ONLY general.par_formula ALTER COLUMN id_formula SET STATISTICS 0;
ALTER TABLE ONLY general.par_formula ALTER COLUMN formula SET STATISTICS 0;
ALTER TABLE ONLY general.par_formula ALTER COLUMN descripcion SET STATISTICS 0;
     DROP TABLE general.par_formula;
       general            postgres    false    6            n           0    0    TABLE par_formula    COMMENT     �   COMMENT ON TABLE general.par_formula IS 'TABLA QUE CONTIENE LAS FORMULAS UTILIZADAS DENTRO DE LA APLICACION EN CODIGO JAVASCRIPT';
          general          postgres    false    234            o           0    0    COLUMN par_formula.id_formula    COMMENT     [   COMMENT ON COLUMN general.par_formula.id_formula IS 'IDENTIFICADOR ÚNICO DE LA FORMULA.';
          general          postgres    false    234            p           0    0    COLUMN par_formula.formula    COMMENT     R   COMMENT ON COLUMN general.par_formula.formula IS 'FORMULA EN CODIGO JAVASCRIPT.';
          general          postgres    false    234            q           0    0    COLUMN par_formula.descripcion    COMMENT     Y   COMMENT ON COLUMN general.par_formula.descripcion IS 'DESCRIPCION CORTA DE LA FORMULA.';
          general          postgres    false    234            �            1259    25486    par_formula_id_formula_seq    SEQUENCE     �   CREATE SEQUENCE general.par_formula_id_formula_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE general.par_formula_id_formula_seq;
       general          postgres    false    6    234            r           0    0    par_formula_id_formula_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE general.par_formula_id_formula_seq OWNED BY general.par_formula.id_formula;
          general          postgres    false    233            �            1259    25525 	   inv_grupo    TABLE     ?  CREATE TABLE inventario.inv_grupo (
    id_grupo smallint NOT NULL,
    grupo character varying(50) NOT NULL,
    cambio character(1) DEFAULT 'N'::bpchar NOT NULL
);
ALTER TABLE ONLY inventario.inv_grupo ALTER COLUMN id_grupo SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_grupo ALTER COLUMN grupo SET STATISTICS 0;
 !   DROP TABLE inventario.inv_grupo;
    
   inventario            postgres    false    10            s           0    0    TABLE inv_grupo    COMMENT     Y   COMMENT ON TABLE inventario.inv_grupo IS 'TABLA QUE CONTIENE LOS GRUPOS DE INVENTARIO.';
       
   inventario          postgres    false    236            t           0    0    COLUMN inv_grupo.id_grupo    COMMENT     V   COMMENT ON COLUMN inventario.inv_grupo.id_grupo IS 'IDENTIFICADOR ÚNICO DEL GRUPO.';
       
   inventario          postgres    false    236            u           0    0    COLUMN inv_grupo.grupo    COMMENT     P   COMMENT ON COLUMN inventario.inv_grupo.grupo IS 'DESCRIPCION CORTA DEL GRUPO.';
       
   inventario          postgres    false    236            v           0    0    COLUMN inv_grupo.cambio    COMMENT     �   COMMENT ON COLUMN inventario.inv_grupo.cambio IS 'CAMPO PARA IDENTIFICAR SI EL GRUPO PERMITE INTERCAMBIAR ENTRE INVENTARIO QUE PERTENCE AL MISMO GRUPO.';
       
   inventario          postgres    false    236            �            1259    25523    inv_grupo_id_grupo_seq    SEQUENCE     �   CREATE SEQUENCE inventario.inv_grupo_id_grupo_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE inventario.inv_grupo_id_grupo_seq;
    
   inventario          postgres    false    10    236            w           0    0    inv_grupo_id_grupo_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE inventario.inv_grupo_id_grupo_seq OWNED BY inventario.inv_grupo.id_grupo;
       
   inventario          postgres    false    235            �            1259    25584    inv_inv_com    TABLE     L  CREATE TABLE inventario.inv_inv_com (
    id_inv_com smallint NOT NULL,
    id_inventario smallint NOT NULL,
    id_componente smallint NOT NULL,
    seleccionar character(1) DEFAULT 'N'::bpchar NOT NULL,
    detalle character varying(50) DEFAULT 'detalle'::character varying NOT NULL,
    seleccionado boolean DEFAULT true NOT NULL
);
ALTER TABLE ONLY inventario.inv_inv_com ALTER COLUMN id_inv_com SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_inv_com ALTER COLUMN id_inventario SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_inv_com ALTER COLUMN id_componente SET STATISTICS 0;
 #   DROP TABLE inventario.inv_inv_com;
    
   inventario            postgres    false    10            x           0    0    TABLE inv_inv_com    COMMENT     �   COMMENT ON TABLE inventario.inv_inv_com IS 'TABLA QUE CONDITNE LOS COMPONENTES(INVENTARIO) POR LOS QUE ESTA CONFORMADO UN INVENTARIO.';
       
   inventario          postgres    false    240            y           0    0    COLUMN inv_inv_com.id_inv_com    COMMENT     _   COMMENT ON COLUMN inventario.inv_inv_com.id_inv_com IS 'IDENTIFICADOR ÚNICO DEL OCMPONENTE.';
       
   inventario          postgres    false    240            z           0    0     COLUMN inv_inv_com.id_inventario    COMMENT     x   COMMENT ON COLUMN inventario.inv_inv_com.id_inventario IS 'LLAVE FORANEA AL INVENTARIO QUE CORRESPONDE EL COMPONENTE.';
       
   inventario          postgres    false    240            {           0    0     COLUMN inv_inv_com.id_componente    COMMENT     v   COMMENT ON COLUMN inventario.inv_inv_com.id_componente IS 'LLAVE FORANEA A INVENTARIO QUE IDENTIFICA AL COMPONENTE.';
       
   inventario          postgres    false    240            |           0    0    COLUMN inv_inv_com.seleccionar    COMMENT     }   COMMENT ON COLUMN inventario.inv_inv_com.seleccionar IS 'IDENTIFICA SI EL COMPONENTE DEBE SER SELECCIONADO POR EL USUARIO.';
       
   inventario          postgres    false    240            }           0    0    COLUMN inv_inv_com.detalle    COMMENT     O   COMMENT ON COLUMN inventario.inv_inv_com.detalle IS 'DETALLE DEL COMPONENTE.';
       
   inventario          postgres    false    240            ~           0    0    COLUMN inv_inv_com.seleccionado    COMMENT     �   COMMENT ON COLUMN inventario.inv_inv_com.seleccionado IS 'INDICA SI EL COMPONENTE ES SELECCIONADO PARA CALCULAR EL PRECIO DEL ITEM.';
       
   inventario          postgres    false    240            �            1259    25582    inv_inv_com_id_com_inv_seq    SEQUENCE     �   CREATE SEQUENCE inventario.inv_inv_com_id_com_inv_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE inventario.inv_inv_com_id_com_inv_seq;
    
   inventario          postgres    false    10    240                       0    0    inv_inv_com_id_com_inv_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE inventario.inv_inv_com_id_com_inv_seq OWNED BY inventario.inv_inv_com.id_inv_com;
       
   inventario          postgres    false    239            �            1259    16514    inv_inv_suc    TABLE     �  CREATE TABLE inventario.inv_inv_suc (
    id_inv_suc bigint NOT NULL,
    id_inventario bigint NOT NULL,
    id_sucursal smallint NOT NULL,
    cantidad numeric(6,2) DEFAULT 0 NOT NULL,
    costo_promedio numeric(20,2) DEFAULT 0 NOT NULL,
    vr_venta_local numeric(20,2) DEFAULT 0 NOT NULL,
    vr_venta_domicilio numeric(20,2) DEFAULT 0 NOT NULL
);
ALTER TABLE ONLY inventario.inv_inv_suc ALTER COLUMN id_inv_suc SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_inv_suc ALTER COLUMN id_inventario SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_inv_suc ALTER COLUMN id_sucursal SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_inv_suc ALTER COLUMN cantidad SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_inv_suc ALTER COLUMN costo_promedio SET STATISTICS 0;
 #   DROP TABLE inventario.inv_inv_suc;
    
   inventario            postgres    false    10            �           0    0    TABLE inv_inv_suc    COMMENT     n   COMMENT ON TABLE inventario.inv_inv_suc IS 'Tabla intermedia entre la tabla inventario y la tabla sucursal.';
       
   inventario          postgres    false    216            �           0    0    COLUMN inv_inv_suc.id_inv_suc    COMMENT     \   COMMENT ON COLUMN inventario.inv_inv_suc.id_inv_suc IS 'Identificador único de la tabla.';
       
   inventario          postgres    false    216            �           0    0     COLUMN inv_inv_suc.id_inventario    COMMENT     a   COMMENT ON COLUMN inventario.inv_inv_suc.id_inventario IS 'llave foranea a la tabla inventario';
       
   inventario          postgres    false    216            �           0    0    COLUMN inv_inv_suc.id_sucursal    COMMENT     ^   COMMENT ON COLUMN inventario.inv_inv_suc.id_sucursal IS 'llave foranea a la tabla sucursal.';
       
   inventario          postgres    false    216            �           0    0    COLUMN inv_inv_suc.cantidad    COMMENT     k   COMMENT ON COLUMN inventario.inv_inv_suc.cantidad IS 'Cantidad de determinado inventario en la sucursal.';
       
   inventario          postgres    false    216            �           0    0 !   COLUMN inv_inv_suc.costo_promedio    COMMENT     ]   COMMENT ON COLUMN inventario.inv_inv_suc.costo_promedio IS 'Costo promedio del inventario.';
       
   inventario          postgres    false    216            �           0    0 !   COLUMN inv_inv_suc.vr_venta_local    COMMENT     i   COMMENT ON COLUMN inventario.inv_inv_suc.vr_venta_local IS 'Valor de venta del inventario en el local.';
       
   inventario          postgres    false    216            �           0    0 %   COLUMN inv_inv_suc.vr_venta_domicilio    COMMENT     �   COMMENT ON COLUMN inventario.inv_inv_suc.vr_venta_domicilio IS 'Valor de venta del producto si se entrega instalado en el domicilio.';
       
   inventario          postgres    false    216            �            1259    16512    inv_inv_sur_id_inv_suc_seq    SEQUENCE     �   CREATE SEQUENCE inventario.inv_inv_sur_id_inv_suc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE inventario.inv_inv_sur_id_inv_suc_seq;
    
   inventario          postgres    false    216    10            �           0    0    inv_inv_sur_id_inv_suc_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE inventario.inv_inv_sur_id_inv_suc_seq OWNED BY inventario.inv_inv_suc.id_inv_suc;
       
   inventario          postgres    false    215            �            1259    16498    inv_inventario    TABLE     q  CREATE TABLE inventario.inv_inventario (
    id_inventario bigint NOT NULL,
    id_referencia smallint,
    descripcion character varying(100) NOT NULL,
    id_uni_medida smallint NOT NULL,
    id_formula smallint NOT NULL,
    nesecita_p character(1) NOT NULL,
    codigo character varying(30) NOT NULL,
    maximos_p json DEFAULT '{}'::json NOT NULL,
    id_grupo smallint NOT NULL,
    id_fondo smallint DEFAULT 1 NOT NULL,
    iva numeric(3,1) DEFAULT 0 NOT NULL,
    descuento numeric(3,1) DEFAULT 0 NOT NULL,
    CONSTRAINT inv_inventario_chk CHECK (((nesecita_p = 'S'::bpchar) OR (nesecita_p = 'N'::bpchar)))
);
ALTER TABLE ONLY inventario.inv_inventario ALTER COLUMN id_inventario SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_inventario ALTER COLUMN id_referencia SET STATISTICS 0;
ALTER TABLE ONLY inventario.inv_inventario ALTER COLUMN descripcion SET STATISTICS 0;
 &   DROP TABLE inventario.inv_inventario;
    
   inventario            postgres    false    10            �           0    0 #   COLUMN inv_inventario.id_inventario    COMMENT     e   COMMENT ON COLUMN inventario.inv_inventario.id_inventario IS 'IDENTIFICADOR ÚNICO DEL INVENTARIO.';
       
   inventario          postgres    false    212            �           0    0 #   COLUMN inv_inventario.id_referencia    COMMENT     h   COMMENT ON COLUMN inventario.inv_inventario.id_referencia IS 'REFERENCIA CODIGO INTERNACIONAL UNSPSC.';
       
   inventario          postgres    false    212            �           0    0 !   COLUMN inv_inventario.descripcion    COMMENT     a   COMMENT ON COLUMN inventario.inv_inventario.descripcion IS 'DESCRIPCIÓN CORTA DEL INVENTARIO.';
       
   inventario          postgres    false    212            �           0    0 #   COLUMN inv_inventario.id_uni_medida    COMMENT     �   COMMENT ON COLUMN inventario.inv_inventario.id_uni_medida IS 'LLAVE FORANEA QUE IDENTIFICA LA UNIDAD DE MEDIDA QUE TIENE EL INVENTARIO';
       
   inventario          postgres    false    212            �           0    0     COLUMN inv_inventario.id_formula    COMMENT     �   COMMENT ON COLUMN inventario.inv_inventario.id_formula IS 'LLAVE FORANEA A LA FORMULA PARA CALCULAR EL AREA O VOLUMEN O CANTIDAD DEL INVENTARIO.';
       
   inventario          postgres    false    212            �           0    0     COLUMN inv_inventario.nesecita_p    COMMENT     �   COMMENT ON COLUMN inventario.inv_inventario.nesecita_p IS 'INDICA SI EL INVENTARIO NESECITA PEDIR LOS PARAMETROS PARA EL CALCULO DE LAS CANTIDADES A ENTRAR O SALIR.';
       
   inventario          postgres    false    212            �           0    0    COLUMN inv_inventario.codigo    COMMENT     w   COMMENT ON COLUMN inventario.inv_inventario.codigo IS 'CODIGO UNICO O CODIGO DE BARRAS QUE IDENTIFICA AL INVENTARIO.';
       
   inventario          postgres    false    212            �           0    0    COLUMN inv_inventario.maximos_p    COMMENT     e   COMMENT ON COLUMN inventario.inv_inventario.maximos_p IS 'VALOR MAXIMO VALIDO PARA LOS PARAMETROS.';
       
   inventario          postgres    false    212            �           0    0    COLUMN inv_inventario.id_grupo    COMMENT     �   COMMENT ON COLUMN inventario.inv_inventario.id_grupo IS 'LLAVE FORANEA QUE IDENTIFICA AL GRUPO AL QUE PERTENECE EL INVENTARIO.';
       
   inventario          postgres    false    212            �           0    0    COLUMN inv_inventario.id_fondo    COMMENT     �   COMMENT ON COLUMN inventario.inv_inventario.id_fondo IS 'LLAVE FORANEA QUE IDENTIFICA A QUE FONDO PERTENECE DETERMINADO INVENTARIO. PARTICULARIDAD DE VICTO H.';
       
   inventario          postgres    false    212            �           0    0    COLUMN inv_inventario.iva    COMMENT     t   COMMENT ON COLUMN inventario.inv_inventario.iva IS 'PORCENTAJE DEL IVA DE DETERMINADO INVENTARIO PARA LAS VENTAS.';
       
   inventario          postgres    false    212            �           0    0    COLUMN inv_inventario.descuento    COMMENT     }   COMMENT ON COLUMN inventario.inv_inventario.descuento IS 'PORCENTAJE DE DESCUENTO DE DETERMINADO INVENTARIO PARA LA VENTA.';
       
   inventario          postgres    false    212            �            1259    16496    inventario_id_inventario_seq    SEQUENCE     �   CREATE SEQUENCE inventario.inventario_id_inventario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE inventario.inventario_id_inventario_seq;
    
   inventario          postgres    false    10    212            �           0    0    inventario_id_inventario_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE inventario.inventario_id_inventario_seq OWNED BY inventario.inv_inventario.id_inventario;
       
   inventario          postgres    false    211            �            1259    16423    seg_role    TABLE       CREATE TABLE seguridad.seg_role (
    id_role bigint NOT NULL,
    descripcion character varying(20) NOT NULL
);
ALTER TABLE ONLY seguridad.seg_role ALTER COLUMN id_role SET STATISTICS 0;
ALTER TABLE ONLY seguridad.seg_role ALTER COLUMN descripcion SET STATISTICS 0;
    DROP TABLE seguridad.seg_role;
    	   seguridad            postgres    false    5            �           0    0    COLUMN seg_role.id_role    COMMENT     Y   COMMENT ON COLUMN seguridad.seg_role.id_role IS 'Identificador uníco de la tabla rol.';
       	   seguridad          postgres    false    206            �           0    0    COLUMN seg_role.descripcion    COMMENT     M   COMMENT ON COLUMN seguridad.seg_role.descripcion IS 'Descripción del rol.';
       	   seguridad          postgres    false    206            �            1259    16421    seg_role_id_role_seq    SEQUENCE     �   CREATE SEQUENCE seguridad.seg_role_id_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE seguridad.seg_role_id_role_seq;
    	   seguridad          postgres    false    206    5            �           0    0    seg_role_id_role_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE seguridad.seg_role_id_role_seq OWNED BY seguridad.seg_role.id_role;
       	   seguridad          postgres    false    205            �            1259    16431    seg_role_usuario    TABLE     �  CREATE TABLE seguridad.seg_role_usuario (
    id_role_usuario bigint NOT NULL,
    id_role bigint NOT NULL,
    id_usuario bigint NOT NULL
);
ALTER TABLE ONLY seguridad.seg_role_usuario ALTER COLUMN id_role_usuario SET STATISTICS 0;
ALTER TABLE ONLY seguridad.seg_role_usuario ALTER COLUMN id_role SET STATISTICS 0;
ALTER TABLE ONLY seguridad.seg_role_usuario ALTER COLUMN id_usuario SET STATISTICS 0;
 '   DROP TABLE seguridad.seg_role_usuario;
    	   seguridad            postgres    false    5            �           0    0 '   COLUMN seg_role_usuario.id_role_usuario    COMMENT     q   COMMENT ON COLUMN seguridad.seg_role_usuario.id_role_usuario IS 'Identificador uníco de la tabla rol_usuario.';
       	   seguridad          postgres    false    208            �           0    0    COLUMN seg_role_usuario.id_role    COMMENT     {   COMMENT ON COLUMN seguridad.seg_role_usuario.id_role IS 'llave foranea que enlaza la tabla rol usuario con la tabla rol.';
       	   seguridad          postgres    false    208            �           0    0 "   COLUMN seg_role_usuario.id_usuario    COMMENT     �   COMMENT ON COLUMN seguridad.seg_role_usuario.id_usuario IS 'llave foranea que enlaza la tabla rol_uauario
con la tabla usuario.';
       	   seguridad          postgres    false    208            �            1259    16429 $   seg_role_usuario_id_role_usuario_seq    SEQUENCE     �   CREATE SEQUENCE seguridad.seg_role_usuario_id_role_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE seguridad.seg_role_usuario_id_role_usuario_seq;
    	   seguridad          postgres    false    5    208            �           0    0 $   seg_role_usuario_id_role_usuario_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE seguridad.seg_role_usuario_id_role_usuario_seq OWNED BY seguridad.seg_role_usuario.id_role_usuario;
       	   seguridad          postgres    false    207            �            1259    16411    seg_usuario    TABLE     K  CREATE TABLE seguridad.seg_usuario (
    id_usuario bigint NOT NULL,
    id_persona bigint NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(250) NOT NULL,
    img character varying(500) NOT NULL,
    google boolean DEFAULT false NOT NULL,
    estado character(1) DEFAULT 'A'::bpchar NOT NULL,
    id_sucursal smallint DEFAULT 1 NOT NULL
);
ALTER TABLE ONLY seguridad.seg_usuario ALTER COLUMN id_usuario SET STATISTICS 0;
ALTER TABLE ONLY seguridad.seg_usuario ALTER COLUMN id_persona SET STATISTICS 0;
ALTER TABLE ONLY seguridad.seg_usuario ALTER COLUMN email SET STATISTICS 0;
ALTER TABLE ONLY seguridad.seg_usuario ALTER COLUMN password SET STATISTICS 0;
ALTER TABLE ONLY seguridad.seg_usuario ALTER COLUMN img SET STATISTICS 0;
ALTER TABLE ONLY seguridad.seg_usuario ALTER COLUMN google SET STATISTICS 0;
 "   DROP TABLE seguridad.seg_usuario;
    	   seguridad            postgres    false    5            �           0    0    COLUMN seg_usuario.id_usuario    COMMENT     c   COMMENT ON COLUMN seguridad.seg_usuario.id_usuario IS 'Idemtificador uníco de la tabla usuario.';
       	   seguridad          postgres    false    204            �           0    0    COLUMN seg_usuario.id_persona    COMMENT     �   COMMENT ON COLUMN seguridad.seg_usuario.id_persona IS 'llave foranea a la tabla persona para identificar a que persona pertenece el usuario.';
       	   seguridad          postgres    false    204            �           0    0    COLUMN seg_usuario.email    COMMENT     G   COMMENT ON COLUMN seguridad.seg_usuario.email IS 'Email del usuario.';
       	   seguridad          postgres    false    204            �           0    0    COLUMN seg_usuario.password    COMMENT     O   COMMENT ON COLUMN seguridad.seg_usuario.password IS 'Contrasena del usuario.';
       	   seguridad          postgres    false    204            �           0    0    COLUMN seg_usuario.img    COMMENT     P   COMMENT ON COLUMN seguridad.seg_usuario.img IS 'url de la imagen del usuario.';
       	   seguridad          postgres    false    204            �           0    0    COLUMN seg_usuario.google    COMMENT     v   COMMENT ON COLUMN seguridad.seg_usuario.google IS 'Identifica si el usuario esta logueado con una cuenta de google.';
       	   seguridad          postgres    false    204            �           0    0    COLUMN seg_usuario.estado    COMMENT     U   COMMENT ON COLUMN seguridad.seg_usuario.estado IS 'Estado del usuario del sistema.';
       	   seguridad          postgres    false    204            �           0    0    COLUMN seg_usuario.id_sucursal    COMMENT     |   COMMENT ON COLUMN seguridad.seg_usuario.id_sucursal IS 'LLAVE FORANEA QUE IDENTIFICA A QUE SUCURSAL PERTENECE EL USUARIO.';
       	   seguridad          postgres    false    204            �            1259    16409    seg_usuario_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE seguridad.seg_usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE seguridad.seg_usuario_id_usuario_seq;
    	   seguridad          postgres    false    204    5            �           0    0    seg_usuario_id_usuario_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE seguridad.seg_usuario_id_usuario_seq OWNED BY seguridad.seg_usuario.id_usuario;
       	   seguridad          postgres    false    203            �            1259    16463    cli_cliente    TABLE     �  CREATE TABLE ventas.cli_cliente (
    id_cliente bigint NOT NULL,
    id_persona bigint NOT NULL,
    direccion character varying(250),
    email character varying(140),
    celular character varying(20),
    telefono character varying(20),
    img character varying(500)
);
ALTER TABLE ONLY ventas.cli_cliente ALTER COLUMN id_cliente SET STATISTICS 0;
ALTER TABLE ONLY ventas.cli_cliente ALTER COLUMN id_persona SET STATISTICS 0;
ALTER TABLE ONLY ventas.cli_cliente ALTER COLUMN direccion SET STATISTICS 0;
ALTER TABLE ONLY ventas.cli_cliente ALTER COLUMN email SET STATISTICS 0;
ALTER TABLE ONLY ventas.cli_cliente ALTER COLUMN celular SET STATISTICS 0;
ALTER TABLE ONLY ventas.cli_cliente ALTER COLUMN telefono SET STATISTICS 0;
    DROP TABLE ventas.cli_cliente;
       ventas            postgres    false    11            �           0    0    TABLE cli_cliente    COMMENT     `   COMMENT ON TABLE ventas.cli_cliente IS 'Tabla que contiene los datos generales de un cliente.';
          ventas          postgres    false    210            �           0    0    COLUMN cli_cliente.id_cliente    COMMENT     a   COMMENT ON COLUMN ventas.cli_cliente.id_cliente IS 'Identificador uníco de la tabla clientes.';
          ventas          postgres    false    210            �           0    0    COLUMN cli_cliente.id_persona    COMMENT     w   COMMENT ON COLUMN ventas.cli_cliente.id_persona IS 'Llave foranea que identifica a que persona pertenece el cliente.';
          ventas          postgres    false    210            �           0    0    COLUMN cli_cliente.direccion    COMMENT     L   COMMENT ON COLUMN ventas.cli_cliente.direccion IS 'Direccion del cliente.';
          ventas          postgres    false    210            �           0    0    COLUMN cli_cliente.email    COMMENT     Q   COMMENT ON COLUMN ventas.cli_cliente.email IS 'Correo electronico del cliente.';
          ventas          postgres    false    210            �           0    0    COLUMN cli_cliente.celular    COMMENT     H   COMMENT ON COLUMN ventas.cli_cliente.celular IS 'Celular del cliente.';
          ventas          postgres    false    210            �           0    0    COLUMN cli_cliente.telefono    COMMENT     I   COMMENT ON COLUMN ventas.cli_cliente.telefono IS 'telefono del cliente';
          ventas          postgres    false    210            �           0    0    COLUMN cli_cliente.img    COMMENT     Z   COMMENT ON COLUMN ventas.cli_cliente.img IS 'contiene el path de la imagen del cliente.';
          ventas          postgres    false    210            �            1259    16459    cli_cliente_cli_cliente_seq    SEQUENCE     �   CREATE SEQUENCE ventas.cli_cliente_cli_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE ventas.cli_cliente_cli_cliente_seq;
       ventas          postgres    false    11    210            �           0    0    cli_cliente_cli_cliente_seq    SEQUENCE OWNED BY     Z   ALTER SEQUENCE ventas.cli_cliente_cli_cliente_seq OWNED BY ventas.cli_cliente.id_cliente;
          ventas          postgres    false    209            $           2604    25600    fin_abo_fac id_abo_fac    DEFAULT     �   ALTER TABLE ONLY financiero.fin_abo_fac ALTER COLUMN id_abo_fac SET DEFAULT nextval('financiero.fin_abo_fac_id_abo_fac_seq'::regclass);
 I   ALTER TABLE financiero.fin_abo_fac ALTER COLUMN id_abo_fac DROP DEFAULT;
    
   financiero          postgres    false    242    241    242                       2604    24794    fin_det_factura id_det_factura    DEFAULT     �   ALTER TABLE ONLY financiero.fin_det_factura ALTER COLUMN id_det_factura SET DEFAULT nextval('financiero.detalle_movimiento_id_detalle_movimiento_seq'::regclass);
 Q   ALTER TABLE financiero.fin_det_factura ALTER COLUMN id_det_factura DROP DEFAULT;
    
   financiero          postgres    false    222    221    222                       2604    24808    fin_det_factura id_inventario    DEFAULT     �   ALTER TABLE ONLY financiero.fin_det_factura ALTER COLUMN id_inventario SET DEFAULT nextval('financiero.detalle_movimiento_id_inventario_seq'::regclass);
 P   ALTER TABLE financiero.fin_det_factura ALTER COLUMN id_inventario DROP DEFAULT;
    
   financiero          postgres    false    223    222                       2604    24820    fin_fac_par id_fac_par    DEFAULT     �   ALTER TABLE ONLY financiero.fin_fac_par ALTER COLUMN id_fac_par SET DEFAULT nextval('financiero.fin_fac_item_id_fac_item_seq'::regclass);
 I   ALTER TABLE financiero.fin_fac_par ALTER COLUMN id_fac_par DROP DEFAULT;
    
   financiero          postgres    false    224    226    226                       2604    24835    fin_factura id_factura    DEFAULT     �   ALTER TABLE ONLY financiero.fin_factura ALTER COLUMN id_factura SET DEFAULT nextval('financiero.fin_factura_id_factura_seq'::regclass);
 I   ALTER TABLE financiero.fin_factura ALTER COLUMN id_factura DROP DEFAULT;
    
   financiero          postgres    false    227    229    229                       2604    25548    fin_fondo id_fondo    DEFAULT     �   ALTER TABLE ONLY financiero.fin_fondo ALTER COLUMN id_fondo SET DEFAULT nextval('financiero.fin_fondo_id_fondo_seq'::regclass);
 E   ALTER TABLE financiero.fin_fondo ALTER COLUMN id_fondo DROP DEFAULT;
    
   financiero          postgres    false    238    237                       2604    24845    gen_estado id_estado    DEFAULT     ~   ALTER TABLE ONLY general.gen_estado ALTER COLUMN id_estado SET DEFAULT nextval('general.gen_estado_id_estado_seq'::regclass);
 D   ALTER TABLE general.gen_estado ALTER COLUMN id_estado DROP DEFAULT;
       general          postgres    false    231    230    231            �
           2604    16400    gen_persona id_persona    DEFAULT     �   ALTER TABLE ONLY general.gen_persona ALTER COLUMN id_persona SET DEFAULT nextval('general.gen_persona_id_persona_seq'::regclass);
 F   ALTER TABLE general.gen_persona ALTER COLUMN id_persona DROP DEFAULT;
       general          postgres    false    202    201    202            &           2604    25644    gen_secuencial id_secuencial    DEFAULT     �   ALTER TABLE ONLY general.gen_secuencial ALTER COLUMN id_secuencial SET DEFAULT nextval('general.gen_secuencial_id_secuencial_seq'::regclass);
 L   ALTER TABLE general.gen_secuencial ALTER COLUMN id_secuencial DROP DEFAULT;
       general          postgres    false    244    243    244                       2604    16509    gen_sucursal id_sucursal    DEFAULT     �   ALTER TABLE ONLY general.gen_sucursal ALTER COLUMN id_sucursal SET DEFAULT nextval('general.gen_sucursal_id_sucursal_seq'::regclass);
 H   ALTER TABLE general.gen_sucursal ALTER COLUMN id_sucursal DROP DEFAULT;
       general          postgres    false    213    214    214                       2604    16569    gen_tip_unidad id_tip_unidad    DEFAULT     �   ALTER TABLE ONLY general.gen_tip_unidad ALTER COLUMN id_tip_unidad SET DEFAULT nextval('general.gen_tipo_unidad_id_tipo_unidad_seq'::regclass);
 L   ALTER TABLE general.gen_tip_unidad ALTER COLUMN id_tip_unidad DROP DEFAULT;
       general          postgres    false    219    220    220                       2604    25491    par_formula id_formula    DEFAULT     �   ALTER TABLE ONLY general.par_formula ALTER COLUMN id_formula SET DEFAULT nextval('general.par_formula_id_formula_seq'::regclass);
 F   ALTER TABLE general.par_formula ALTER COLUMN id_formula DROP DEFAULT;
       general          postgres    false    233    234    234                       2604    25528    inv_grupo id_grupo    DEFAULT     �   ALTER TABLE ONLY inventario.inv_grupo ALTER COLUMN id_grupo SET DEFAULT nextval('inventario.inv_grupo_id_grupo_seq'::regclass);
 E   ALTER TABLE inventario.inv_grupo ALTER COLUMN id_grupo DROP DEFAULT;
    
   inventario          postgres    false    235    236    236                        2604    25587    inv_inv_com id_inv_com    DEFAULT     �   ALTER TABLE ONLY inventario.inv_inv_com ALTER COLUMN id_inv_com SET DEFAULT nextval('inventario.inv_inv_com_id_com_inv_seq'::regclass);
 I   ALTER TABLE inventario.inv_inv_com ALTER COLUMN id_inv_com DROP DEFAULT;
    
   inventario          postgres    false    239    240    240                       2604    16517    inv_inv_suc id_inv_suc    DEFAULT     �   ALTER TABLE ONLY inventario.inv_inv_suc ALTER COLUMN id_inv_suc SET DEFAULT nextval('inventario.inv_inv_sur_id_inv_suc_seq'::regclass);
 I   ALTER TABLE inventario.inv_inv_suc ALTER COLUMN id_inv_suc DROP DEFAULT;
    
   inventario          postgres    false    216    215    216                        2604    16501    inv_inventario id_inventario    DEFAULT     �   ALTER TABLE ONLY inventario.inv_inventario ALTER COLUMN id_inventario SET DEFAULT nextval('inventario.inventario_id_inventario_seq'::regclass);
 O   ALTER TABLE inventario.inv_inventario ALTER COLUMN id_inventario DROP DEFAULT;
    
   inventario          postgres    false    212    211    212            �
           2604    16426    seg_role id_role    DEFAULT     z   ALTER TABLE ONLY seguridad.seg_role ALTER COLUMN id_role SET DEFAULT nextval('seguridad.seg_role_id_role_seq'::regclass);
 B   ALTER TABLE seguridad.seg_role ALTER COLUMN id_role DROP DEFAULT;
    	   seguridad          postgres    false    205    206    206            �
           2604    16434     seg_role_usuario id_role_usuario    DEFAULT     �   ALTER TABLE ONLY seguridad.seg_role_usuario ALTER COLUMN id_role_usuario SET DEFAULT nextval('seguridad.seg_role_usuario_id_role_usuario_seq'::regclass);
 R   ALTER TABLE seguridad.seg_role_usuario ALTER COLUMN id_role_usuario DROP DEFAULT;
    	   seguridad          postgres    false    207    208    208            �
           2604    16414    seg_usuario id_usuario    DEFAULT     �   ALTER TABLE ONLY seguridad.seg_usuario ALTER COLUMN id_usuario SET DEFAULT nextval('seguridad.seg_usuario_id_usuario_seq'::regclass);
 H   ALTER TABLE seguridad.seg_usuario ALTER COLUMN id_usuario DROP DEFAULT;
    	   seguridad          postgres    false    204    203    204            �
           2604    16466    cli_cliente id_cliente    DEFAULT     �   ALTER TABLE ONLY ventas.cli_cliente ALTER COLUMN id_cliente SET DEFAULT nextval('ventas.cli_cliente_cli_cliente_seq'::regclass);
 E   ALTER TABLE ventas.cli_cliente ALTER COLUMN id_cliente DROP DEFAULT;
       ventas          postgres    false    209    210    210                      0    25597    fin_abo_fac 
   TABLE DATA           x   COPY financiero.fin_abo_fac (id_abo_fac, id_factura, id_movimiento, abono, fec_abono, pago, regreso, saldo) FROM stdin;
 
   financiero          postgres    false    242   �      �          0    24791    fin_det_factura 
   TABLE DATA           �   COPY financiero.fin_det_factura (id_det_factura, id_factura, cantidad, detalle, sub_total, descuento, vr_descuento, vr_transporte, vr_antes_iva, iva, vr_iva, total, id_inventario) FROM stdin;
 
   financiero          postgres    false    222   �      �          0    24817    fin_fac_par 
   TABLE DATA           Q   COPY financiero.fin_fac_par (id_fac_par, id_det_factura, parametros) FROM stdin;
 
   financiero          postgres    false    226   ��                0    24832    fin_factura 
   TABLE DATA           �   COPY financiero.fin_factura (id_factura, id_cliente, id_estado, totales, items, total, saldo, transporte, descuento, id_movimiento, fec_factura, num_factura) FROM stdin;
 
   financiero          postgres    false    229   ��      	          0    25539 	   fin_fondo 
   TABLE DATA           8   COPY financiero.fin_fondo (fondo, id_fondo) FROM stdin;
 
   financiero          postgres    false    237   ��      �          0    16538    fin_movimiento 
   TABLE DATA           {   COPY financiero.fin_movimiento (id_movimiento, id_sucursal, id_tipo_movimiento, fecha, observacion, id_estado) FROM stdin;
 
   financiero          postgres    false    217   ��                0    24842 
   gen_estado 
   TABLE DATA           D   COPY general.gen_estado (id_estado, descripcion, clase) FROM stdin;
    general          postgres    false    231   �      �          0    16397    gen_persona 
   TABLE DATA           J   COPY general.gen_persona (id_persona, identificacion, nombre) FROM stdin;
    general          postgres    false    202   b�                0    25641    gen_secuencial 
   TABLE DATA           Q   COPY general.gen_secuencial (id_secuencial, descripcion, secuencial) FROM stdin;
    general          postgres    false    244   H�      �          0    16506    gen_sucursal 
   TABLE DATA           Q   COPY general.gen_sucursal (id_sucursal, nombre, telefono, direccion) FROM stdin;
    general          postgres    false    214   ��      �          0    16566    gen_tip_unidad 
   TABLE DATA           E   COPY general.gen_tip_unidad (id_tip_unidad, descripcion) FROM stdin;
    general          postgres    false    220   ��      �          0    16559    gen_uni_medida 
   TABLE DATA           ]   COPY general.gen_uni_medida (id_uni_medida, id_tip_unidad, unidad, n_parametros) FROM stdin;
    general          postgres    false    218   %�                0    25488    par_formula 
   TABLE DATA           H   COPY general.par_formula (id_formula, formula, descripcion) FROM stdin;
    general          postgres    false    234   ]�                0    25525 	   inv_grupo 
   TABLE DATA           @   COPY inventario.inv_grupo (id_grupo, grupo, cambio) FROM stdin;
 
   inventario          postgres    false    236   �                 0    25584    inv_inv_com 
   TABLE DATA           w   COPY inventario.inv_inv_com (id_inv_com, id_inventario, id_componente, seleccionar, detalle, seleccionado) FROM stdin;
 
   inventario          postgres    false    240   �      �          0    16514    inv_inv_suc 
   TABLE DATA           �   COPY inventario.inv_inv_suc (id_inv_suc, id_inventario, id_sucursal, cantidad, costo_promedio, vr_venta_local, vr_venta_domicilio) FROM stdin;
 
   inventario          postgres    false    216   M      �          0    16498    inv_inventario 
   TABLE DATA           �   COPY inventario.inv_inventario (id_inventario, id_referencia, descripcion, id_uni_medida, id_formula, nesecita_p, codigo, maximos_p, id_grupo, id_fondo, iva, descuento) FROM stdin;
 
   inventario          postgres    false    212   5      �          0    16423    seg_role 
   TABLE DATA           ;   COPY seguridad.seg_role (id_role, descripcion) FROM stdin;
 	   seguridad          postgres    false    206   �	      �          0    16431    seg_role_usuario 
   TABLE DATA           S   COPY seguridad.seg_role_usuario (id_role_usuario, id_role, id_usuario) FROM stdin;
 	   seguridad          postgres    false    208   3
      �          0    16411    seg_usuario 
   TABLE DATA           s   COPY seguridad.seg_usuario (id_usuario, id_persona, email, password, img, google, estado, id_sucursal) FROM stdin;
 	   seguridad          postgres    false    204   e
      �          0    16463    cli_cliente 
   TABLE DATA           g   COPY ventas.cli_cliente (id_cliente, id_persona, direccion, email, celular, telefono, img) FROM stdin;
    ventas          postgres    false    210   �      �           0    0 ,   detalle_movimiento_id_detalle_movimiento_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('financiero.detalle_movimiento_id_detalle_movimiento_seq', 388, true);
       
   financiero          postgres    false    221            �           0    0 $   detalle_movimiento_id_inventario_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('financiero.detalle_movimiento_id_inventario_seq', 1, false);
       
   financiero          postgres    false    223            �           0    0    fin_abo_fac_id_abo_fac_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('financiero.fin_abo_fac_id_abo_fac_seq', 103, true);
       
   financiero          postgres    false    241            �           0    0    fin_fac_item_id_fac_item_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('financiero.fin_fac_item_id_fac_item_seq', 1, false);
       
   financiero          postgres    false    224            �           0    0    fin_fac_item_id_factura_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('financiero.fin_fac_item_id_factura_seq', 1, false);
       
   financiero          postgres    false    225            �           0    0    fin_factura_id_cliente_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('financiero.fin_factura_id_cliente_seq', 1, false);
       
   financiero          postgres    false    228            �           0    0    fin_factura_id_factura_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('financiero.fin_factura_id_factura_seq', 123, true);
       
   financiero          postgres    false    227            �           0    0    fin_fondo_id_fondo_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('financiero.fin_fondo_id_fondo_seq', 3, true);
       
   financiero          postgres    false    238            �           0    0    gen_estado_id_estado_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('general.gen_estado_id_estado_seq', 4, true);
          general          postgres    false    230            �           0    0    gen_persona_id_persona_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('general.gen_persona_id_persona_seq', 25, true);
          general          postgres    false    201            �           0    0     gen_secuencial_id_secuencial_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('general.gen_secuencial_id_secuencial_seq', 2, true);
          general          postgres    false    243            �           0    0    gen_sucursal_id_sucursal_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('general.gen_sucursal_id_sucursal_seq', 1, true);
          general          postgres    false    213            �           0    0 "   gen_tipo_unidad_id_tipo_unidad_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('general.gen_tipo_unidad_id_tipo_unidad_seq', 3, true);
          general          postgres    false    219            �           0    0     gen_uni_medida_id_uni_medida_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('general.gen_uni_medida_id_uni_medida_seq', 4, true);
          general          postgres    false    232            �           0    0    par_formula_id_formula_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('general.par_formula_id_formula_seq', 13, true);
          general          postgres    false    233            �           0    0    inv_grupo_id_grupo_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('inventario.inv_grupo_id_grupo_seq', 22, true);
       
   inventario          postgres    false    235            �           0    0    inv_inv_com_id_com_inv_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('inventario.inv_inv_com_id_com_inv_seq', 148, true);
       
   inventario          postgres    false    239            �           0    0    inv_inv_sur_id_inv_suc_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('inventario.inv_inv_sur_id_inv_suc_seq', 59, true);
       
   inventario          postgres    false    215            �           0    0    inventario_id_inventario_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('inventario.inventario_id_inventario_seq', 68, true);
       
   inventario          postgres    false    211            �           0    0    seg_role_id_role_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('seguridad.seg_role_id_role_seq', 2, true);
       	   seguridad          postgres    false    205            �           0    0 $   seg_role_usuario_id_role_usuario_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('seguridad.seg_role_usuario_id_role_usuario_seq', 4, true);
       	   seguridad          postgres    false    207            �           0    0    seg_usuario_id_usuario_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('seguridad.seg_usuario_id_usuario_seq', 7, true);
       	   seguridad          postgres    false    203            �           0    0    cli_cliente_cli_cliente_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('ventas.cli_cliente_cli_cliente_seq', 12, true);
          ventas          postgres    false    209            D           2606    24796 '   fin_det_factura detalle_movimiento_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY financiero.fin_det_factura
    ADD CONSTRAINT detalle_movimiento_pkey PRIMARY KEY (id_det_factura);
 U   ALTER TABLE ONLY financiero.fin_det_factura DROP CONSTRAINT detalle_movimiento_pkey;
    
   financiero            postgres    false    222            V           2606    25602    fin_abo_fac fin_abo_fac_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY financiero.fin_abo_fac
    ADD CONSTRAINT fin_abo_fac_pkey PRIMARY KEY (id_abo_fac);
 J   ALTER TABLE ONLY financiero.fin_abo_fac DROP CONSTRAINT fin_abo_fac_pkey;
    
   financiero            postgres    false    242            F           2606    24825 '   fin_fac_par fin_fac_item_id_factura_key 
   CONSTRAINT     p   ALTER TABLE ONLY financiero.fin_fac_par
    ADD CONSTRAINT fin_fac_item_id_factura_key UNIQUE (id_det_factura);
 U   ALTER TABLE ONLY financiero.fin_fac_par DROP CONSTRAINT fin_fac_item_id_factura_key;
    
   financiero            postgres    false    226            H           2606    24823    fin_fac_par fin_fac_item_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY financiero.fin_fac_par
    ADD CONSTRAINT fin_fac_item_pkey PRIMARY KEY (id_fac_par);
 K   ALTER TABLE ONLY financiero.fin_fac_par DROP CONSTRAINT fin_fac_item_pkey;
    
   financiero            postgres    false    226            J           2606    24839    fin_factura fin_factura_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY financiero.fin_factura
    ADD CONSTRAINT fin_factura_pkey PRIMARY KEY (id_factura);
 J   ALTER TABLE ONLY financiero.fin_factura DROP CONSTRAINT fin_factura_pkey;
    
   financiero            postgres    false    229            R           2606    25550    fin_fondo fin_fondo_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY financiero.fin_fondo
    ADD CONSTRAINT fin_fondo_pkey PRIMARY KEY (id_fondo);
 F   ALTER TABLE ONLY financiero.fin_fondo DROP CONSTRAINT fin_fondo_pkey;
    
   financiero            postgres    false    237            >           2606    16547    fin_movimiento ven_factura_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY financiero.fin_movimiento
    ADD CONSTRAINT ven_factura_pkey PRIMARY KEY (id_movimiento);
 M   ALTER TABLE ONLY financiero.fin_movimiento DROP CONSTRAINT ven_factura_pkey;
    
   financiero            postgres    false    217            L           2606    24847    gen_estado gen_estado_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY general.gen_estado
    ADD CONSTRAINT gen_estado_pkey PRIMARY KEY (id_estado);
 E   ALTER TABLE ONLY general.gen_estado DROP CONSTRAINT gen_estado_pkey;
       general            postgres    false    231            (           2606    16407 *   gen_persona gen_persona_identificacion_key 
   CONSTRAINT     p   ALTER TABLE ONLY general.gen_persona
    ADD CONSTRAINT gen_persona_identificacion_key UNIQUE (identificacion);
 U   ALTER TABLE ONLY general.gen_persona DROP CONSTRAINT gen_persona_identificacion_key;
       general            postgres    false    202            *           2606    16405    gen_persona gen_persona_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY general.gen_persona
    ADD CONSTRAINT gen_persona_pkey PRIMARY KEY (id_persona);
 G   ALTER TABLE ONLY general.gen_persona DROP CONSTRAINT gen_persona_pkey;
       general            postgres    false    202            X           2606    25646 "   gen_secuencial gen_secuencial_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY general.gen_secuencial
    ADD CONSTRAINT gen_secuencial_pkey PRIMARY KEY (id_secuencial);
 M   ALTER TABLE ONLY general.gen_secuencial DROP CONSTRAINT gen_secuencial_pkey;
       general            postgres    false    244            :           2606    16511    gen_sucursal gen_sucursal_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY general.gen_sucursal
    ADD CONSTRAINT gen_sucursal_pkey PRIMARY KEY (id_sucursal);
 I   ALTER TABLE ONLY general.gen_sucursal DROP CONSTRAINT gen_sucursal_pkey;
       general            postgres    false    214            B           2606    16571 #   gen_tip_unidad gen_tipo_unidad_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY general.gen_tip_unidad
    ADD CONSTRAINT gen_tipo_unidad_pkey PRIMARY KEY (id_tip_unidad);
 N   ALTER TABLE ONLY general.gen_tip_unidad DROP CONSTRAINT gen_tipo_unidad_pkey;
       general            postgres    false    220            @           2606    25479 %   gen_uni_medida gen_unidad_medida_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY general.gen_uni_medida
    ADD CONSTRAINT gen_unidad_medida_pkey PRIMARY KEY (id_uni_medida);
 P   ALTER TABLE ONLY general.gen_uni_medida DROP CONSTRAINT gen_unidad_medida_pkey;
       general            postgres    false    218            N           2606    25496    par_formula par_formula_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY general.par_formula
    ADD CONSTRAINT par_formula_pkey PRIMARY KEY (id_formula);
 G   ALTER TABLE ONLY general.par_formula DROP CONSTRAINT par_formula_pkey;
       general            postgres    false    234            P           2606    25530    inv_grupo inv_grupo_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY inventario.inv_grupo
    ADD CONSTRAINT inv_grupo_pkey PRIMARY KEY (id_grupo);
 F   ALTER TABLE ONLY inventario.inv_grupo DROP CONSTRAINT inv_grupo_pkey;
    
   inventario            postgres    false    236            T           2606    25589    inv_inv_com inv_inv_com_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY inventario.inv_inv_com
    ADD CONSTRAINT inv_inv_com_pkey PRIMARY KEY (id_inv_com);
 J   ALTER TABLE ONLY inventario.inv_inv_com DROP CONSTRAINT inv_inv_com_pkey;
    
   inventario            postgres    false    240            <           2606    16522    inv_inv_suc inv_inv_sur_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY inventario.inv_inv_suc
    ADD CONSTRAINT inv_inv_sur_pkey PRIMARY KEY (id_inv_suc);
 J   ALTER TABLE ONLY inventario.inv_inv_suc DROP CONSTRAINT inv_inv_sur_pkey;
    
   inventario            postgres    false    216            8           2606    16503    inv_inventario inventario_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY inventario.inv_inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id_inventario);
 L   ALTER TABLE ONLY inventario.inv_inventario DROP CONSTRAINT inventario_pkey;
    
   inventario            postgres    false    212            .           2606    16428    seg_role seg_role_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY seguridad.seg_role
    ADD CONSTRAINT seg_role_pkey PRIMARY KEY (id_role);
 C   ALTER TABLE ONLY seguridad.seg_role DROP CONSTRAINT seg_role_pkey;
    	   seguridad            postgres    false    206            0           2606    16443 %   seg_role_usuario seg_role_usuario_idx 
   CONSTRAINT     r   ALTER TABLE ONLY seguridad.seg_role_usuario
    ADD CONSTRAINT seg_role_usuario_idx UNIQUE (id_usuario, id_role);
 R   ALTER TABLE ONLY seguridad.seg_role_usuario DROP CONSTRAINT seg_role_usuario_idx;
    	   seguridad            postgres    false    208    208            2           2606    16436 &   seg_role_usuario seg_role_usuario_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY seguridad.seg_role_usuario
    ADD CONSTRAINT seg_role_usuario_pkey PRIMARY KEY (id_role_usuario);
 S   ALTER TABLE ONLY seguridad.seg_role_usuario DROP CONSTRAINT seg_role_usuario_pkey;
    	   seguridad            postgres    false    208            ,           2606    16420    seg_usuario seg_usuario_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY seguridad.seg_usuario
    ADD CONSTRAINT seg_usuario_pkey PRIMARY KEY (id_usuario);
 I   ALTER TABLE ONLY seguridad.seg_usuario DROP CONSTRAINT seg_usuario_pkey;
    	   seguridad            postgres    false    204            4           2606    16471 &   cli_cliente cli_cliente_id_persona_key 
   CONSTRAINT     g   ALTER TABLE ONLY ventas.cli_cliente
    ADD CONSTRAINT cli_cliente_id_persona_key UNIQUE (id_persona);
 P   ALTER TABLE ONLY ventas.cli_cliente DROP CONSTRAINT cli_cliente_id_persona_key;
       ventas            postgres    false    210            6           2606    16469    cli_cliente cli_cliente_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY ventas.cli_cliente
    ADD CONSTRAINT cli_cliente_pkey PRIMARY KEY (id_cliente);
 F   ALTER TABLE ONLY ventas.cli_cliente DROP CONSTRAINT cli_cliente_pkey;
       ventas            postgres    false    210            g           2606    24858 "   fin_det_factura fin_det_factura_fk    FK CONSTRAINT     �   ALTER TABLE ONLY financiero.fin_det_factura
    ADD CONSTRAINT fin_det_factura_fk FOREIGN KEY (id_factura) REFERENCES financiero.fin_factura(id_factura);
 P   ALTER TABLE ONLY financiero.fin_det_factura DROP CONSTRAINT fin_det_factura_fk;
    
   financiero          postgres    false    2890    229    222            h           2606    24863 #   fin_det_factura fin_det_factura_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY financiero.fin_det_factura
    ADD CONSTRAINT fin_det_factura_fk1 FOREIGN KEY (id_inventario) REFERENCES inventario.inv_inventario(id_inventario);
 Q   ALTER TABLE ONLY financiero.fin_det_factura DROP CONSTRAINT fin_det_factura_fk1;
    
   financiero          postgres    false    212    2872    222            i           2606    24883    fin_fac_par fin_fac_item_fk    FK CONSTRAINT     �   ALTER TABLE ONLY financiero.fin_fac_par
    ADD CONSTRAINT fin_fac_item_fk FOREIGN KEY (id_det_factura) REFERENCES financiero.fin_fac_par(id_det_factura);
 I   ALTER TABLE ONLY financiero.fin_fac_par DROP CONSTRAINT fin_fac_item_fk;
    
   financiero          postgres    false    2886    226    226            j           2606    24873    fin_factura fin_factura_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY financiero.fin_factura
    ADD CONSTRAINT fin_factura_fk1 FOREIGN KEY (id_cliente) REFERENCES ventas.cli_cliente(id_cliente);
 I   ALTER TABLE ONLY financiero.fin_factura DROP CONSTRAINT fin_factura_fk1;
    
   financiero          postgres    false    229    210    2870            k           2606    24878    fin_factura fin_factura_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY financiero.fin_factura
    ADD CONSTRAINT fin_factura_fk2 FOREIGN KEY (id_estado) REFERENCES general.gen_estado(id_estado);
 I   ALTER TABLE ONLY financiero.fin_factura DROP CONSTRAINT fin_factura_fk2;
    
   financiero          postgres    false    2892    231    229            d           2606    24848     fin_movimiento fin_movimiento_fk    FK CONSTRAINT     �   ALTER TABLE ONLY financiero.fin_movimiento
    ADD CONSTRAINT fin_movimiento_fk FOREIGN KEY (id_estado) REFERENCES general.gen_estado(id_estado);
 N   ALTER TABLE ONLY financiero.fin_movimiento DROP CONSTRAINT fin_movimiento_fk;
    
   financiero          postgres    false    217    231    2892            e           2606    24853 !   fin_movimiento fin_movimiento_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY financiero.fin_movimiento
    ADD CONSTRAINT fin_movimiento_fk1 FOREIGN KEY (id_sucursal) REFERENCES general.gen_sucursal(id_sucursal);
 O   ALTER TABLE ONLY financiero.fin_movimiento DROP CONSTRAINT fin_movimiento_fk1;
    
   financiero          postgres    false    2874    217    214            f           2606    16572 #   gen_uni_medida gen_unidad_medida_fk    FK CONSTRAINT     �   ALTER TABLE ONLY general.gen_uni_medida
    ADD CONSTRAINT gen_unidad_medida_fk FOREIGN KEY (id_tip_unidad) REFERENCES general.gen_tip_unidad(id_tip_unidad);
 N   ALTER TABLE ONLY general.gen_uni_medida DROP CONSTRAINT gen_unidad_medida_fk;
       general          postgres    false    2882    218    220            b           2606    24898    inv_inv_suc inv_inv_suc_fk    FK CONSTRAINT     �   ALTER TABLE ONLY inventario.inv_inv_suc
    ADD CONSTRAINT inv_inv_suc_fk FOREIGN KEY (id_inventario) REFERENCES inventario.inv_inventario(id_inventario);
 H   ALTER TABLE ONLY inventario.inv_inv_suc DROP CONSTRAINT inv_inv_suc_fk;
    
   inventario          postgres    false    2872    216    212            c           2606    24903    inv_inv_suc inv_inv_suc_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY inventario.inv_inv_suc
    ADD CONSTRAINT inv_inv_suc_fk1 FOREIGN KEY (id_sucursal) REFERENCES general.gen_sucursal(id_sucursal);
 I   ALTER TABLE ONLY inventario.inv_inv_suc DROP CONSTRAINT inv_inv_suc_fk1;
    
   inventario          postgres    false    216    2874    214            ^           2606    25497     inv_inventario inv_inventario_fk    FK CONSTRAINT     �   ALTER TABLE ONLY inventario.inv_inventario
    ADD CONSTRAINT inv_inventario_fk FOREIGN KEY (id_uni_medida) REFERENCES general.gen_uni_medida(id_uni_medida);
 N   ALTER TABLE ONLY inventario.inv_inventario DROP CONSTRAINT inv_inventario_fk;
    
   inventario          postgres    false    218    2880    212            _           2606    25502 !   inv_inventario inv_inventario_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY inventario.inv_inventario
    ADD CONSTRAINT inv_inventario_fk1 FOREIGN KEY (id_formula) REFERENCES general.par_formula(id_formula);
 O   ALTER TABLE ONLY inventario.inv_inventario DROP CONSTRAINT inv_inventario_fk1;
    
   inventario          postgres    false    234    212    2894            `           2606    25563 !   inv_inventario inv_inventario_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY inventario.inv_inventario
    ADD CONSTRAINT inv_inventario_fk2 FOREIGN KEY (id_grupo) REFERENCES inventario.inv_grupo(id_grupo);
 O   ALTER TABLE ONLY inventario.inv_inventario DROP CONSTRAINT inv_inventario_fk2;
    
   inventario          postgres    false    2896    236    212            a           2606    25568 !   inv_inventario inv_inventario_fk3    FK CONSTRAINT     �   ALTER TABLE ONLY inventario.inv_inventario
    ADD CONSTRAINT inv_inventario_fk3 FOREIGN KEY (id_fondo) REFERENCES financiero.fin_fondo(id_fondo);
 O   ALTER TABLE ONLY inventario.inv_inventario DROP CONSTRAINT inv_inventario_fk3;
    
   inventario          postgres    false    2898    212    237            [           2606    16437 $   seg_role_usuario seg_role_usuario_fk    FK CONSTRAINT     �   ALTER TABLE ONLY seguridad.seg_role_usuario
    ADD CONSTRAINT seg_role_usuario_fk FOREIGN KEY (id_role) REFERENCES seguridad.seg_role(id_role);
 Q   ALTER TABLE ONLY seguridad.seg_role_usuario DROP CONSTRAINT seg_role_usuario_fk;
    	   seguridad          postgres    false    2862    208    206            \           2606    16490 %   seg_role_usuario seg_role_usuario_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY seguridad.seg_role_usuario
    ADD CONSTRAINT seg_role_usuario_fk2 FOREIGN KEY (id_usuario) REFERENCES seguridad.seg_usuario(id_usuario);
 R   ALTER TABLE ONLY seguridad.seg_role_usuario DROP CONSTRAINT seg_role_usuario_fk2;
    	   seguridad          postgres    false    208    2860    204            Y           2606    16444    seg_usuario seg_usuario_fk    FK CONSTRAINT     �   ALTER TABLE ONLY seguridad.seg_usuario
    ADD CONSTRAINT seg_usuario_fk FOREIGN KEY (id_persona) REFERENCES general.gen_persona(id_persona);
 G   ALTER TABLE ONLY seguridad.seg_usuario DROP CONSTRAINT seg_usuario_fk;
    	   seguridad          postgres    false    202    2858    204            Z           2606    24888    seg_usuario seg_usuario_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY seguridad.seg_usuario
    ADD CONSTRAINT seg_usuario_fk1 FOREIGN KEY (id_sucursal) REFERENCES general.gen_sucursal(id_sucursal);
 H   ALTER TABLE ONLY seguridad.seg_usuario DROP CONSTRAINT seg_usuario_fk1;
    	   seguridad          postgres    false    204    2874    214            ]           2606    16475    cli_cliente cli_cliente_fk    FK CONSTRAINT     �   ALTER TABLE ONLY ventas.cli_cliente
    ADD CONSTRAINT cli_cliente_fk FOREIGN KEY (id_persona) REFERENCES general.gen_persona(id_persona);
 D   ALTER TABLE ONLY ventas.cli_cliente DROP CONSTRAINT cli_cliente_fk;
       ventas          postgres    false    202    2858    210               �  x�}��q�(��*�����ī����_�
�|�-;�Irb��������o�!����'� ;c��'�������#h_ ��O0���@y������SH�pfG^�>_/1�O����מz�S�|!�eG	������Ӵ�Em�U���k}|t�*�(v����&�z���;�iQ �˝��X��AH����&�ļcPK!�(*�#I̹EAŋ FWicv��3�R
/���,���FЩ�`9�+c�p� �}P:�"\���6�D�D���.x3J4�I6�q��ݘ�<qH��������8M�B���CIc�ox�QV<�=�<)I���f�dz�6�����\�ί�ZO���Y�~4́�=���=���g	ܛ_,�f Q|�þ�\6�JuP􌧅b�2��kJ�k�qAX=��i�����<]��VZ��̜Q�a���4vL}�U}��Z--Y����:��(�����"Z+$�|��Uf�ռ�P��R��#HD�*m{Km�[�U�'�;`꫸��gmp7��Z(�����:����p����h�`�\�)$��W|T��퉳�Nb��/��>vŭy2�Ҿpq}��)����D�O�Z�9T��':���D⽦��7�*��|�/^fAp�j֯��_�Qt�u>n23}���^B�_�����_g��ڭo��4��M��.�V;��?�P�9|�u�nr�ϡ�d}ӱ��c�՗�^���Y��SN���+/p�8��Gn��/�^Z����^|7yH:�y`�6��7h$XB�Z��%����6}gS���{�)y�(�i�ĳ�j��mR�!��ʋ:~[y6��=�s�N٦>�իb��zQ��v�<y}��$ՌwL'|�uJ5���,��] ����|�L���0�0	���"$���&b�rz�~�B���-SV���}?rU�����f�J&�P��4u��G�qZ�ί�'s%\}�2G�v�F?"h�=���EP2eLC@&O��>�����Rs���7���\)mZ�7��������wVmLN�K�������_�4�>M:k�M=��t
X����1��O�I� p'd�����<�s28��5��yQO���5��� �-s�����. ʛ�g�Yǰ[��E����u�3�d}:ͽ�j�o���\��,x*�������uW���H��qӶ`wW�*�]/�w!��w�3�66"�'�m���9y^ET1� a���j}�r^�8{��qt po!/�~�d4�������g��      �   �  x����n����O�O`��x���=Hv{��\�f�],r�&���J���Z��9���l}*�~R<�쒣�������q�|:�<�����~�_Ç}[;�]v��I������'�����e\ѿ������8�ŽDV�h6�.�ځB�G4u�':�=8�1��d�܃S�������__���ӷ����wX^8|[;�-��Ts�Fӄs|G�%^�V��,;�8'sV��t�tz��/�����_���F�[�&��Ŏ�����r}��7��p�vY�r{Т����Q�F�|����L�>��ď���t����ɴ2%'�+��\��*N���1ʆ����V���NAi֕�#(�'�W邱z{��:�_���?��_�Ck{U�d�;Q��j���G�j'P�3�R ��M���F��M�rTܹS����bc}��*k}�n>0J����Kr��:���G׉U�>�N���ݏ	<ƛ�����>�wѯI��-*��z�fS�Ej���W��@%��-�l2%�"��S0����&Q�R_ť�!v)�}N����=�r�gx�bY�&S;�1vd����X_�O�OǗ�y�6������k���&^���fc���b�s���i�ݦ�_n��.�66�RẆ���֪��*�n0�K�{��	���&��Ͷ��d#���6^-kg�9��4�����'��y3&�������Ruڨ����3#ד��\�.�zї��շKWRM��qW�H(���%�]�}H�H@���w@�H��d�$}��o2�������o�h��kg���P�������Dq2p��y	qјO�v����H�����GD�)��Tt�2�Pj/{�PL.#�1� �,ҍ�BE��� � 0*��Rg �x0Q�"o�`Y%� )��#}�4 ����RP@A���)���EP@@�dT@:�k 0����
t��d�E:�j �q�`%���
�(@%	u�u�Q�t�u聅�0
P@D6� Q�P*�
` ( � �$4Ҟ~�3��n2JA��
` ( � �$4�.i`�,���
�G�
( �dUIBS"5� Lӵ��T�PI"s*�y@�d��D&$؇ ��j�6�Q�|�9l3U�"�� KU	-EWek��f�Uq��J��K5�l�iS�K3����IS���}����l�Jˮ��fi�a�F��FػF9��C9����XQd�nS�G�R�}2e�-qw.gi��?����^5:��ؼ�g,f��U��u��
1�J�O�k�}��Y�]Ծˤ"�Nc�e>�m;��2�ﳩ���z����$Q���1lh��;;�*�,S,��͵��
~ �M�KP�e[;�=�h]����#kg���=x,�R.���oc+g���L�]ƌ�$�/�T[j�@B�	&T�`��@��	L�5aMFX��d�5�`M&X�	�d�5�`M&X�	�d�5�`M&X��d�5�aMfX��d�5�aMfX��d�5Y`MX��d�5Y`MX��d�5Y`MX��d�5YaMڼ�ﲰ�6�*`sn�D�)(��aB�	$�}��	&��jR<�I�&ţ�k�`M�I�5I�&	�$��$X�k�`M�I�5ɰ&�$ÚdX�k�aM2�I�5ɰ&֤��X�kR`M
�I�5)�&֤���&�� krX�A6ɰЃ"LH0!Ä*Jw0��	�&#��k2��&#��k2��L�&��k2��L�&��krX��	���7�k��L�1a�w0s +�d�Vxl n�����|�)vnّF�`|��g�z�Z�&���T��<7s���Ŀ%��d�Y��d��YboW�w�����N,;M-vbe+�Y��*oQ��6�*�rg�V�;�������������?���������q�s�S����vb�L4���	���B�8��u����4P�g��Z��pQ�m�ib\W3�G*���̔��l�k�E�n�o����|�ʶ>=����|xy}:�ku��ck��H��l���{+-�Vϼ�2�ɶs=���9ĕo2�U��u�i)ɰ6�m���f�#�Z��.n봯��ن+nx��÷�>�4=��֘�uh���l���nv���B�      �      x������ � �            x��[w۶����_������q	�"J��������Υ���Pm�u�#���q���? )�$��ŎdY]�M� 	L s~s2�����\���������I?��o?���׳����pts����n�׿��5(��~U?V/?Ue��g���?_?鋬���`t����f�Ϯ�y{�~/N嵕�����'����\���#<����~�ty���"}������_����\=�ޓ�'��������_���l?9���{w{:�C]������"~b�ESn����ū�����
�^^�\�������,�JA��O�w�j����4���zu�_>uv�����|��Iq�r��/����i�y�ޗ������������|����������������lSnm�P�(I�aڕ�������e�f][d-Y�X��N�u��S�_핿�6wI��%Y�������KdC�Hc��o��so�z_�z;Jm��XU��a�9_�D��0��M���I骢c�\y_>���k�'��n/.����^v�M��ܧ����ŴK��޹V���`��m������{��^x�.�����;WW�/�?/MW_G����N?{�����T=����DFG7���~9?�󄿥�D��Þ�^G��u�������g��.G����Y��r��uӇK��n���z��g��/�$-XT�>�W�0�C��z�hZ�|8;Z������险���<����CZ_�tQz�?�}�=c�������y�R����dj���lڎZ�����olu1n���H�C=�X6�MJneR8��:�i�ܴ"ռO�j�kTf5o�ɲu�l�q���揝����f�h�z�(�|T}^�^׸ЦS�6��ZT�0�W�V'	��>2,�b�e71-�b�Y>�p'FU(jR�"�*ٗ^�P����ݸ�MgE~vɒ�,�U�p]���\t]�B�&=�X̷�QW섁I,¦�߲������0���l�1���̡�vM�~���f]=�6ʺ��R-���v�p�n1i�Y%�r��<��tEwƮM]ѥ+ں";�����ߩJ����_��Z�~�_�~Q�v��#C�'�/wu��d�k��T������\5��3���BD�I�>������-�Z��|�����K�A����^�=��y?�:~�<M�_nGc)x#�o��;��������f��,tF{��h��{]ۮ��ή.�;�|W[����tp6�]|V�������f0*m��;��tx��^�;�i]�-_�5����ߞ�t�|��x:�O7_6_���2m�j#NZ��rt}�}�����d��Q��������r25wǫ�U�vӝ��٭�~�m%E�r�˫����9)���F��7vR��I.٫l�..p��^��9��to�Lm��v�JA1)8�z�W�T�i+���53O]��\4˓H�-��Z����e&o�=�K�1F}�d?���'/����������|��y����~:�>�_�3�,����j�n�ƺ���l�W�y�kf�߱}i���mGۜ7�t��-�-��HK��	:h1ak��l��}C[�������R�[j�~׋��E��6Ane-V����6��k�[M/n{�g���֍-o��E����kaK���2}Km�Vn�L�F\�Aڭ���6���xb�ECD�]ĭ͗^�&�˕��_�� =V�ՉBoyV�VӃ/>~���q���u��m�V��-f���J^.��毬�Ymk�F��N��I'ۍ��P��W��QG�����ռ�����~�9�ۈa%`%`%���+++������)+++++�p��J�aW�J�J�JXO�J�J�J��V�ZVVVVVV�Y��#+'R���`b��O8��f�1���������������PPPP�=55555�p�@M�aW@M|{jbb��,�A;;1. ;;;;a|4؉ey�a'a'`'`'`'`'։��v#Sl"�Ѥ?�6~"�����!�Ĵ�Δ�'j�Ϋ���E����yS�۞�ԧYP��j_�V��)�u����{up�g�FW��o�Fں����X9X��٢���04D �u��=�pR�(�K��tȴ"G=�C�9��}�H�']F��y)�f��
}������j+f��f�S�WͶ�n�������co����ۃ^��f�U=�s�݆=��6��Qգ5qX4�M��Y<��-F[H+H����ʐV�
,gF�{<V֙V�F�qø�}��3n7�۸�j��J��D��E��Mƍ`�0n�����m��d�,���ͣ7.cF��p2fØ�.c�(�����>f�e�,�"�2X��QKSv`��Y�h	���7?�������χ���G�q#+�F:�a���*�R��~\�}̌|�1#�d������鉨$�PN�LȘa�0fZ�L�/����>f��a�Lim��k�/)Y�D��`�ZTa�X]��1Y�;�A��� !� � � ���bՄ,]׉����Y$�=�F�'$dy؂�8_�mbA6���7a����uOHb�J��$a��$,��nA[h^����7�8�W�D�R��ze��z�Z��+�^!�
�WH�B�9S�$��x�����~ &dDL<��ቇ�э�G7��9ݥxx=.ް�J��N_�g㺉��;-�͢�q}��ƻnq"Ay��-J$��ؼ�ۭ�u����wN��_������;��9F�2:���ȏ��j�H.��&�b��b��z���xo�,K/���������&��>hL�z)z)z)z������dvV� �K}������HV^V^V^V^V^V^V��W޶e7��x��������c���e������❚��~[4�;n	㎿Yw\$�jq_�}�K��b#0��[��o%�)�)�)������Ae��,�,�,�,�,�,�w� ��&�Xn���B��2+J�vaLf���5�5�5�5�5�5x���mrm~�\�AmŐ�v`εI��;�:l�Rm�ΠΠΠά�:Ӛj�'�&�6�R��_�`��j�A	��X�mbA���H*h�Rm�uO�-��	�T�+3*H�yש6�e��ZRm�mG�ڴ>�6I�I��5H I���jiRm�j�T���$�&�6�L��sYZєl3���/
�/���=��_E)���{�/ > ><�x��x�������C�A�A�A���k� > > > > > ��� | | | | | | | | | | | | | |w
�����������<x1� � � � � ����� � � � � � � � � � � � � ��]��I��d�&?�r�t�"��4�O�����?�w��S�ҶF�z�?��!�o<�x��������uuuf�� > > > > > > > ��� | | | | | | | | | | | | | |��     �����$ʠ������/@@@@@@@@@@@@@@�(o0��7�]m�6�&�fJ�n0}m�yT�+������<<z��:����{�f�Y�6���k�X
��2=���2�ľ���W6�'�`��z��r6�I��?4����2����6�ؐB*�+�RHMK�)��z
�x'"�I�H":::Ѽ��:	
	
	
	
	�:�:�:���$($($($($($($($�c�HPHPHPHPHPHPHPHPHPHPHPHPHPHP�H�������@@@@fe�����Ё���������������$�"�Ԫ'�z�b$�|T� e�ޓ(�h	��Wb������I'K ��#��А��ۏ�i>�x#�vDGV��i�ZґMsJ�����HEF*2   ��m� �����W�PuQ_������ݍ Q�oP]}��a��Ҧ�����JV_V_V_V_V_V���.bK��˓3��LkJ�nM�{up��[��u�cp��eJ�J�b@���%��s��'J���~�t���l����'"�4���n��Oܵ��"�����r�M��o52; ��1�0����)���K�,5+b���    @e���LrR�|��9�&�MVx��y[�E�{� QoD��F�QoD��Fԛ�R�ވz#ꍨ��ǘ7����mFR,b����2HB�E�BG{���H H H�jO H H H��'@@@@��7� � � � � � � � � �(�� � � � � � � � � � �X!@B��h
H�zN 	��Gid�X�� � � �X9O8����D�o          Q>           �B�D������o�Hh�<J#�Ī������y�$ $ $ $j~s 	 	 	 	 	 	 	 	 	 ��i 	 	 	 	 	 	 	 	 	 	 �{$�v@"��2$�ý�00@A(\(� Lb|F�$Db%�h'����s�I�P5��L`�g[��U��}�����޷�}����q����V0���ծTn�ڸ9A�2*3Q�yq�D̎L�MvU�`����i�	�	�	�	�	�	�	�	��ttttb�������,���l	���b�4�����}`���@�)��%A9��m��w�w�BZn�Jx�;��g�x<x<x<x<x����d���%��Ar®�w�Ҵ�FsM�a}m�n�zM��y��{lr��NC�/���|��zTm�xQ����%�$��l���ʱ%B�%�%��V��(^^^^^^^^b�䃗�������;^b���+�h�7���|��ԙe����1�{�������?��U6����ݥ���̻����l���<��p����k ���w��ͻ�f�L���Do.@��w����݃w?���w��^�-žkX��L�`�#�pI��8l��N�`�Ÿ�q�.�]��w1�b�Ÿ�qw�q�[wg����9bۚ�x�45�)���F�6�?�z{�6����{���M�f35w��D�`���z��qDQ�(ꚶ��̭@��1gc�Ɯ�����R�lj�-��|�T��S��Om�N��?|{���۾B�P���2Z���]�6*���f�Ƈ���"F++++՚�T-~;��eHSdrж�
��ʟ).#��Qo~���ޫß���ZV��wRm������OU�c�䲖&�.M�"����|�HR�T!U�)U��hb�;5��9��&\ԐC�Dl˳.ʮ�]��UߵTq�zv�%�d�\�/�yr�����8d�|P	T���*2O>(�Xއ����2.�"{m;&i���|I�l�wԔq)2g\�2.����b}�l�t�H�iJj$M��K��q�:�����o��U\�����*}�ɛ�jbu@6�^4����@�i7�C�n�`|�n8)��At�Dg�At�DgX/%:���3��hx�{L��/_*�T|��R��Kŗ�/_�Z9���Kŗ�/_���R�z�'m�Ћ2�R��Kŗ�/_*�T|��R��K�Kŗ�/_*�T|��R��Kŗ�/_*�T|��R��Kŗ�/_*�T|��R��Kŗ�/_*�T|��ԗz�A����?��������#}�?���JQ?��A�܏����ÎT����=�0�ֈiU�/��M��D�I�.)��a��k�������EKk+����K��g�=8�� ���*�so�Lx�VcW1�ڌEm��LxPb$��l�&�ٻ���͗D�d�n��N%�i�,�UÄq��w�Rkn�J�՟m��>2Ye�r��*7��BQ[MK�mTqL>������b�n�O,�j�*�D�D�D����e��'&��Ar�m������^�z}m�n�����U�P��Ԑ��ww���(&�Ct�:�l�X ��X��M/
�4/�������Wo����1MS�i�r��N0��k��S��u��l0��.l�h� h h h h h h h h��]4�f$�e�?����/{��Oᙣ��0��N 777�����ʙ�f�f�f�f�f�f�f�f�f�f�f�f�f�f�V����������������������������Yn&��AT$�a���3A��LK難���w
����5pk��XQ�_+Ya�5_+YqP��� J�@I�V��J�-��_+�������(^��x\��Q<.��G1�b�8�q�(�Q��G1��!��{toϜ} S�}�pt���с��Y�qt��SG!�a�a�a�a�Ȇ���l�"�SSl�4E0/�{�xO+Ӻ�T�[@ޟ�T&r	�q-v�� S�8Lq��0�a���)S�8L�8L�7�6�d�"k'?4Dֆ}M2�w;B���Z�j1�b8�p�ᔠZXXX�XXX�U�j5�Xo���Z�j��#�G��x�<�����#�G��1>��T��� 8:pt��xlm8:�%��*��a�a�a��#���Z�jq��0�a���)S�8Lq��0�a���'�XZ[@m��ŧj�F�tD'�F���!�vZH�Ŧ�Z����^��y/�۞׷�9ժ{i_�K5��^m/�����ho�ضk6������Z�/�in��e�1>�G� �w��["��~���~��pǜ��rft0:�����`<:"�������x���qh�UC�Q�V�F�����G2>�V5D��1���c#`t0:����#�GI���Q���!�x�H�"D_�������x$��}Q�#�$ڈ"�uW�i"�4D�"��Juc$0��K#AP#o~���ޫß���f�l�E��Z�*k���hi���l�}�9^Kd�h��pb�b���@a�<��"�J��bY�7�n]�
�2����K^F�e��R�HF�G��i��|�=��t��tX̶ݍ���&�碜��d_=�z�'\F����I��ŋ{����߻�no�4%+�p��IE�m�b��hI�H�盨�|$�X�>\�$aŃ�L0�L��⡋	+��>	+HXA�
V����cF�l�Ɉ>Q�ٙY�0qݙ��v����Ӂ߶Fǆ4}ġ��d;Ah���V���@��7�� p�^�T7�;b��1�/D�>y�@ژ_�����jJ����?�zۘ1f�OlH��W?U9Xa���y%v�jb��X�t1��!]�$1!]�}�4�bHC��Ő.�t1��} ��0 P�s�P P P<<O9    �H��P P P P P�������������0 ��4 ŲZ�����b} ��N�@%M�2�ט�%N�� �~�}r燽���)��5%�.��Rz�a̡�҅�.�t�H�Hzt��������$�$�$����@$A$A$A$A$���"	"	"	"	"	"	"	"��0D��4DҲZ"	"	"	"	"i}�$ ��4 P�s�P P P<<O9    �H��P P P P P�������������0 ��4 ŲZ�����b�
���d��NN:Y��4Y���А:(�ˠ�:(؈�����AQ�9hZHk��x�E�3���$t��4�H�l��)�k������W�?��G�,�,�2���f[?U9XYr#K���:cYw��q�RP���D)X��/h1�,��"J'�(������q_M�2J�ޣ���W�sE�ҴL�E)�	�'�iW���b&�c���6C���P�q�_�����������co����ۃ^��f+�w���\����NMT��%b��#�4aPqTF�9��pi�������K���E8;,6b�#k�����V�^�Y�$��3����K^�[у �����JfG�G�Y����	�ڢ���k�	��)t
đ�4� b>$�7�ZI3b�AL<zzzz�	ՍUP��t�;��`X�Z�E��L�}`
�[ӍEa�X��'������<�I�n-�n{k�6��+_M{ީ*ָ��`�m︀q���>����L�b��Ұb�b�b�b�b�bs~�+ی�V���W�hÎ�a���>�cwÎ��������_�R:���X!�,,n^Ƈ�U+�I��u�=�W����U/O�H_E�*�W�t/9888ă�!H_��;3�W����U��IIIIr=�d=    ����IIIIIZ$	�b5� ��{   �S@@@@1���     +�3� � � � � � � �p=@a=@���� � � � �Xc��D'$:Y��!f��󇎲tP�W&?���f.꧿�>3nt���H�G~��G�R��k��w�-id�bD�����\wGB���g�a{�j��\~ͩ=����Ns����yx�n���w���><ܿ�l��K���U`Opw�=��{d�>-خ�dk����u~�?����|#����x���sDX��jiXOXOXOXOXOX�9�ߗ�He(�BF�q��UȨh�Ȩ���NFMK�dT~B'��(�(�(�(�(�(�(�(�(�(�(�(�(ȨY�(�(�(�(�(�(Ȩ��Q�(�(�(�(�(�(�(�(�(�(˥�Q�Q�Q�Q�A<��F�N:b��ۨ����#Ya�⍤Kv��2�����e�y��l�����o֬�����׆{�d�/eh?V*��� ��k��c!>{�4�����������収.�qbk���s���z6�z%��O�~K�&-�����������������ji`D`D`D`D`���KiڴlmH,�D܏�~W 1���&�	4J,�Pb�R:%���)�J���`��z�*D�62�����ώ/_:�t|�Η�X1=X�YY���?I!S���Y�����F�62�GYOGGG��u_-E�6���A�3�1C��R�N:��R�ݤ9�dܗQ?H*Hq��5坌�Q<-���	�(!�P+?� �!�!�!�!��6�b�b�b�b�b�b�b�ⵐ�b�b����ACCCC[OCCC��
Q|_-QQQQQQQ2�6�b���	��6�N$[QϠ�*�gw��3��$�e@=��	�	�	�	�Y�̂z�z�z�z�z�z�z�z����z�z�z���������z���s DP��jiPOPOPOPOPOPOPO���A�3�1C��R�fK�E�B�6�NK8�E)���:QC3�V~@ACCCCWm&��������k!)���+��(�(�(�(�(���(�(�(^����Z�������dhm�!�1C�3�1C�l�z�������Vr=�A�\�F"�z�sAק��F�O��zt�!��C
ttttt�j�]]]]]]]]_I]]]_��:�:�:�:��4�:�:��* ՠ���Ҡ������� Ck�!f�b��!f�b��!f�2B"�F�"$�0sS�D���b#���8r�����5Zd��H��`H���"B�	"$�� B�j&B�	"$�� B�	"$��XI!B�	"$V~�G�DH!A���4DH!�
�>���DH!A�DH!A���� C�b��!f�b��!f�b��=d1;�dA/Y N��~?���8r#	�8=��3-�7Z~B���ÐZ�!E �8��C ΰJ	�C �8��C �8⬃��C �8+��#�@q�!�z�@q�Y��q	�!�@q�!�@���A�3�1C�3�1C�3�1C�3�l�x���{%�5�K�}Q��
6�����eK�WQJk��	=�K��A�cj��_|�E�_�*�B�_|�E�_|��B�_|�����/��"���/�i��"�k����&���/��"���/�@��B�3�1C�3�1C�3�1C�3�1[u1;�d1|i$���ָ�n��q��F�
��%�pZJ�+�O��
q����S�WH\!q����q��WH\!q��WH\�:H
q��W��;>�
�+$���B�
���+$����U�v#��Z��B�
�+$���B�
�+Zd1C�3�1C�3�1C�3�1C�3�1C��4|5��W��!|U&���x#�;�V�WE��Y̢��h�z�jD�*Cj�ѫD��J�*ѫ�*ZG�*ѫD��J�*ѫD����B�*ѫD������U�W�^%z��U�i�W�^%zub*�^���&z��U�W�^%z��U�WA��B�3�1[K1;�d�nJOh`��~�L�����)�=�q�8q@��RZ��O�Hq�d����֏�q5%��V�@$ 6!�������m"�������^�s�.�Lh��J�t�YpY!\�ing�kCԥix�h��uv�k����ZwKmh��n���-D:���N�i�ħF3�oi��uxX�S����C[�Y������򰔂$�K�,}�K��	~!����_�#�%�j�d�l�����&e`����MjV`׬�?�>������ѱ�w��_����2�ɆU)��&u�qdb*���a4�ki�˺��vV	V	V	V	V	V	V	V	V	V	V	Vy�X%a�k羪m%��x!ԏ#ZíW��c�n;0w�,7�$G���z�4KO7gO�}{��[W	����� ��6�~a!ط�eߖ�R¾�ZO�7��6� �����i!��E�Z��Ӄ�}�u#!��D�V�t    ���X�z\�����}�W ��P�X�[Mi�(,bu����O?{Go�����g�/rŘL$�ȕq-vre\��/@�Xrrrex
ȕ�ji�������}�:�Jy��,ME-~�d�L��%�`POx~�槽��p�:��p����.�AYav�Kq���Q�}7pAIZ�>N�J�x�ɒ*������<O�4ϓ��e���X)7��#:���X�|;vZJ7�'*/s���R=1�3��yfv���|v��K� �}�K���]�ӡ��8��8~���Q���jJb(C�.������[+�n�_E'vo川��=�
��GX�<6�o�ji�|,�[a�|Dfffffv�[ffffff�ޙ�5&gǨ�XL.�)Z"5�J3T'1ސw&����ݾ��è,�d#�,,,,,,,,,,,,,,,,,,,,,,,,,,,�U ,,,� F�x_-������Xl=�,&}�퇲
,�6zAGtdX���X���l|B咁E�ĸ��o5�@�&������ؾ-i!�M�����nN]���^D��DVxUF:F�ks#J���\�m����ۓ�����.j��x%{[�:8f��^ՉXcL*A4�����=_���a<�	��<�����>�}^���(I"��Y  �.@@@\+ 1�j�d�l����!�d`����(ivbY�
�Oǯ?�=x�wt����ױ��LP�aU�f�"�$e���ۼ���[Y����a�`�`�`�`�`�`�`�`�`�`�`��U"��ڹ�j[�h;^F�B�V��c�n;0w�,7�$�u�v=�����ѭ�o��}�*�q� �]�`�`�f�/"����ےTJطU�i��B�ƶ`����`1m"�|��T˷uzм��n$���h�J�����ĲKR��&� j�8���%�1��V�EA�,
K�XDb9x�������ћ���{�bG$�2��Z��F}r��@�+�+�+k�S@��WKC�@�@�@�@�@��E��t�D"i:�`�1�IO	_?��E\In"��^hHnD.�M����&��J�����p���%�	^����]����&���Kr���܄�&$71��M�B�B�B�BHnBr������4�� �*3 "$7!�	�MHnBr����&�	��bJ�������mUTJطU�i��������)�X�Br����rrrrre�-�������re�}g�d�wr+h�������G��N�W�w������,�M�f�ŷ����/���eJ�-qu+������:cgs'��`O��}�WM�#6z1�u@��;Lz���^Ā�:��!��uH�ӾT�^2	2	2	2�v�uH�Cz % % �9��@J@J@J@J@J@J@J@J�)�^g��W��!��u�{ ��:�o�y(I��    FzطUQ)a�V��I�Cz  ��by�uH�Cz����ȕ�4�
�
�
�
�
�
�uH������}?�Zz�`���N����:������tM�uB��܅w��: ��1 ���uH�Cz��^�}� �ddddR�:��^��:@J@J@Js������������������VR"��ڹ�H�Cz���� 6�u`��P�^���:�o��R¾�ZO�^��:@,@,nO	��8 ��^��:�+�+�+�+�+�oi��������^g��,"��f�p�t,Q3��D������5�ɣ����qi�ҔK�~�E�E�VZ���N�Ir�n[r'!�RK�n�W��I��N�BZ���+���㖚����Ufkf�h#-jjѪ��(��:R�G�Hґ������@naȣ&i�Ա�QVD�����G�0�6�g�`���
�����T��:�Y�ẻ��%�ry���������co����c/�޼iY�T/����Ȑ1�%�B����4�Ɖպ�"W�����*�~�;;�Ϙ|��g�v^|.�v~������V0���ze��]�i��e'�]��ի�?�k�t������\S�E�k�_����F_�Ͻ�\�[�X����_���|�y���G��ܛf��<7�l���ё[Z���b�@����n�����Ю�Ҕ�U#Վ��bA����Y�Y��˪����%u)7��L�R�j��pԖ��7�UK�L{����I��'e[ ���w������~l�	�;A�(�IĬX�Q
��:�R�P��%v(Ն���������tE�u:ݸ�xz"�G��'U3a��K����'��Z<-�M���^�W&�� י"��髭���.�5%hU���}u]�tu��z���˛c]�q"U2���������Χ�|��a��; �<6���,�:����߮Pjr�N!|k9r�"�M��U*w�T�u�
%C ��J���[@��8��yw>���o��-;K�/BD�I��Pu����Wo��w��L��aι�xA�_^��ߗ��Q��"ʙ(g��� ��(��ji���r&ʙ(g���r�+�����F�Ў�܉�A�J��"�n;!���V�77�������F�����������������i������\tg���F�;�;����ΣDwt��H�Yz�����$x������������YhM ����Y/9������������Y7�x�ZxxxxxxgAx����}ѫ���n_�zzzzzzzzzzg�5zzzzg��zzzzzzzzzzzzgݘ��ji�����蝻O��eXI�n?����K���)Ji���	�ߑ�;�;�;�;�;�;�;�;�;�;�;�;�;�;+!G�;�;�;�;�;�;�;�;�;�;�;�;�F����WK���������������l�T�[O���M{OѶ��n>3�z�Ww����������co����ۃ^�ض�L�:N[аg߃�}�����eJE.a'�Wb߉u{���2��|\���q寬+��I'=S�4춲�ݾ�����~�e�A�;�TL�O�gt�4�'l T T T T �{P��Iu��8�y���RO��S��V0�Z[����g�ݢ줼��[�*�SQ���u�ƚ"sM�ծ)~�[�V��պ�\�[�X��􏦅/�nb�w�r����1��Y��G�f��҃?:n	Ʀ�꼳��Z��vn�λM���~�~�~�~�[��~�~�~�~�~�~�~�~�~�~�~�~�F�������������o������� �
�Q���39�\��룪0���pT����Խ��z�����,�i�q�������/���%hy%v� ?_�
NV���"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �H%�#�8������ǣ������>]O������s?������6�wDGv�.7n^��AK�W*�5��L�T�Ez���K�y{�~�������/���[� �U��/�T��R���=��Q���0{��X�'6q�A��i�����x��N~=ٮ?[id�4�zUĵ2|���#K�ہ��=�O>;�:����ٷ��9U�����k����:^�'��n��^�j�}���Y�>Oj�����r+�zg�zGIm���{[$mC]�\���Q}@O�\=HS����.��^����E��5��|:.�ת?�^\l{��'/>~���q��x���*��)�3��-�k�ZMÛ��m�-o�{�7�7�W7�6/�7޹����y����~��C�~�l��;��S��P}>�4�����f��_�O��<�o)���jg矆W����@Ub����.ڕ���T��8s�ɳ<��]�׭���|����B��,?�K/�]��)�_y���W�&�CCݭ5E�/�]S�Zzs��g����_��ѥ�0���4^�.��X6k�Z<�厵nN��~su;|����M���>��>����䥃�XnF�*=X��d�I[B5�x�?�T������V�ɔ��C�*U/?-n�����T�r]�Z�3�j7�n��9�_l֋f��O_��2Z_���5-Ţ[[�Ӆx[������5��/ǑAo��^�I��ā�;�0*�Q��Y��DS�#�*\�ڮ���b�8����Bb:+���w��b�<�m�pW�59�]�H�&G=�ͩ�QW섁I��&}Ϊ���rڵ��֏E����o�"�N0�M�ܭq.C�i[�vV�XýWrC8g���x8c��v�Y%�|�/�]������j�q���������>��wl��((Rk��ЩI�%�](Rs���KBD�ItRu�uGʇ�Wo��w�G��G��gq�H�O�nb�ve��P�.[�%8T�J����E04��������h�y�Ym����Ng��`j�ʎ}��8���F����կȌ�����4ue��/n�Fv��۳�N�O�O~�����C�|Z��Qm�I��^��o�O���r?�<4;j�~��y:=�Y���x����nje��#���ϻ���V�qyu08�c:oe��ۨ��/Ҕ�FOr��^e�tq�v�����ͱT��g^�e��ZPL
N�*U;U;��4S��Fim�r�,O")��~k�:T�k������/i��5�&s�尰>ya}%����7�W烝��?/���	���h8�����IeQ�t}�V#u;5O�g���σ_3K�����on8�n��椸���un�0m�dEZZ�L�Aӈ	[�d���f���(�ld6����R���^����	rS~��l���9^_�/�jzq�3=�<D�nly���/�^^[ʷL���Xj3�rSe2}��6�[?5
YmZ����b����>�[�/��M(�+�ÿ��`�����Э��ނ��d��m_W�%,���K^.��Fì�Y-��ޖY������w����h�|�Y7����ݧ��>>|�����;z�����?��?S���4����Ad߄����F�tE��K؉��w�A��t���@@@@@1��
���o�`A�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	D�@$	|�x�Ad��r����ǣ������>]O��P��x�G����g�C�IGt����֍���W�S5��~Q/4�[~��:����!cي�[���VG��*�*��~����,:�
�.��A7    ��̒cy��y��m�o������K<���F���?~��X��P�NPx2����W���b��5>���<���^۸{�<�>�bӸ뵌;��;���w�q�K*�"�O*�OD��w����͛�u/܉��(��a�u���bz�>KW�EDa��pR�}$NJT�bѶŐ�kp�}�t>\��0�et{q������o��Q�2y1eE�;��977��o[����o�so���Sw�6/�7޹����yi��b8���u�ٳ-������G�&��pt�Y����;O�[j�?س�Oë���|��5_�|\y~���<���}�,�y�����åEJ7�~����|ߗ^�,*N���z���j�l4-[>�-�a~HU���tH�⟨�k+}H뫙.J/�Ǹ�gL�R#�qsu;|1�S�y�R�T�L�w�ɦ�����z���V�f���9�Ïe�٤�V&��*���nM+R����V�Fe��f]�Z���7�n��9�_l֋f���2k�G՗��u3������$��tɞX��-��a���["�#�-�-�-�-��U_��N�̲v[��ָ��5.P]��,[,[,[,[�k�2�Z�^-_���_�=<��_�UK����K���K=��l�֮��-W�,c˕�Ұ��T׮���������q�]k���wzbe�\��K���5.�Y
{,[,[,[,[��l�tr��	�HuR?
�aP!�doC�ݎ�A�8�8���6��O����P�s����/�"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H �"�H ����t�q�������,Qߏ�_gB$���$1��a�+I����'���D�{�Η�6܂�a���]�^�>�~���6�F������k��g�3��G���^��m�ن�!�[7�}���a����a0<�i���/C�Vv�-2���8eq��8F�Ue\�b�ǰ��mC�ܼ����uSFʷ�R���p�?\U���+"B�{bK9w8�K����tZ�<��
9�N4��q�\s�\��~=�GP\ǜun��>~���qd�	���tSkb���\���K=�g�4q�
f�W���8�8ӞA�(;)�N�zU�����z�1�\cM���Ƌj��Ν�N5�r�U��xb�kݜ����-�nb�w�2ݹ��0���7�����e��`ŏ�����V�ɜ;_ֽj]KK��V�����{h�$|Z�ҚI"�e���aߨV�^�@k���q]IkZ�iX����a%��hkphY���m�����~[-��Y��������U�����7�)1~�(�񌹅5�?�ߘTx��ț}`O,ܠ��U��.���Lٚ?�B�y훌#y�`h:������ҨU�w��;��{:8�E�ᬢˋ�۫��`TJA\^u+"���zA�fw��5IK�x��z���g?�4��5�����W��W����L�ڈ�9�]�x�.Gg�~*��v�Zy��y:=�)�S]�8^��*��.��d���y����V�qyu08�c:oe��ۘX�7%�Nw)'�Hd��U�����r{���X*SM��Rs���+Ť�4=p{�N�n���3u-u]��\4˓H�-��Z����e&o��K�1W�&��rX��������ߔ�wsyu>��<���j?��^������/ۙTn���m5R�ӝb~�q�"(�<�5S�wl_~s��;�mN��[:Z�ӖNV��E�4�����@6]_���� H5�ʈr�[jV���/�E�m��b�Jks��6_����gz�kj���&/[_$�����o�(ӧ��fh��d�h�bLp�F!�M�6�Xl��b�qk�׻	�rer�נش��`u��[�����x�>6clU~���
��4�����/��w��e��Y?�l��!��?�(,�QCH��A�� ���bɆ��C0P��Rzw�)?�C�!?����YA��jX�j�;92뾶���u�*� ����תOӕ|p5�������B=���r�3uy� ��$H"�#����HV���9;�,^�n����L�:%�>jx��H����%(�<��^/��}�e��:�u��p���]����R�]t��]�1��8딁�;��#�����ݸ�����Sh�2��袽���j�إ���ܫ�s؀ E�����C?�{��Ek�e�V$�����Ol��nd�>q�p�Ѷ!�os(�<�vݥC��tHX���l(�C�3|�ZjM�d�IjB���he�<�c��^�=��y?�:�!���H;H"gI�	$IZ9�������FiK�X�%)�UR�8�Q%ŉ���៺U$3���/3�AfK�������穧���ڛ�������Ѥ�S����9)�]�C;�2�XU����e�*��^���79��l�}�(\��|�4یNog}���i/�8�깔ʀ��RNu�NueN{)�)uR����U��n譲RM����n�)�*4y�6�g��nȏ�R�k�X��m���ؿ��s7=Jc�ߜG��26��xՌ�^����n���҅�4�z�=LA,�%t@kr�hL/u6��лz)�%��go�N�5eх��B�;��o<C�jʊ�s�Z���6�j�cp:�Fi5���:�>�}4e�X�E�n���p�)�C�=\_^�徛�X��
���,n��ܯ�u^�=g�_�^��]�nX
�C�t{�z$_�J��:?K;��K]?]��)���8���z���+���p0��tiU��J�=�Q
�7�,]Sa#K�PL��%�BF����V��p�4�Lh�#J���ˋ�۫A&��������Ԅ���m���f8RG�(�|�����*]y��t�YK�eTC5.����ë��lH����gi_]e�`K'Y�ҁ4,Zx
��F����%�l%No6��|�/�{g�?���]�l�W~~��k�Ҷ�\�+�Wz�e�/5�ui#"�iD$K.H(Cb�!jC"Y�!Q�]N��V��k6�?����gfcxvn�f�f�#�km���5(�YG�*��D�"o�}����z�7��G�WJ�Φ�����H���y��F�����*�s����������ĸ�N����ywsS��ss�lm}g|����K=�I����ݨ<�mc^�(����v?~|�A��8�uLK�����r���~�W�[h7�T�޴���������'����br�&*�=�ڦ�j�V�^v��j~5#��ZTd��\˾��PyS�0D'�y����U�n����[9�o�{׷ 8ūT���e���k��//�JHT�[��fO�t�*���԰��7_N�R�:�U|-�}3̪�u[�Hc�}�rp�����8[��w��$�Κ�Չ��ql�{)��UJ�e�vw�B`�{�Ѽ�Q���.���f��[��LU�������g�'�֝
���W5
�Qt��IN��\6I����2���⥗5ʢ}nt�ӫ����?qw��}>�曘��A��ޫ"U�Xh��j5�{M^smd4�լ�p�V���v�j��L
����jy������U���l��m�>�W����4���ph���.Ռ=�������י~�=OM�__�SVmI��|֧��Y��"d5DN�Wcq˃����;9���Uw�
���q����uU-!�JQ�w�_����-�#��*F�ɍo4�9,$���r���򩱲�e�`���z�,��_����2�?��h������͟l?��H�+9���л4Vz���O������~�à<�B��dGV���=]C��4"0?�9=w�vr��K�)����"ؔ`S�M�KnXr�.�v���;��+�~�*����e����"-,iaI��JI{_-MZX������%-�ia�r2X�iOt�"Q�jF�`C�:5���"�E)=�A~B�kH��5�k�����_�~��5�k�����_�FY��k�����_�~��5�_c{����,������ߝϺ ��T[��f�]��n�_!�a/i�%��3~.��Zg�|:-.��}`�� �  ��|�C�����9vSAq��n�5Y�=�ӫ�]̇����k�~s���2�g���J�w���a�	��ܒ�Չ��E�T]��o1��w�4�#Ko�����:���op����9iR�3I����?��SM�¦U"���|d�H�\z�A���T��U�&!
��H��I�ם�����4�y>b����]閭���;���&�VE���m���Zɮ��zF�g��d1111111'DL�1�-[�9$L�i��,�ʖQ#9tp�f����:|��[8�Wb���F� �>�����,�C��ҀC�C�C�C�C�CsDg��itܫFF��{}!�A��QGtB-&��ݵDDw�#�kyw��yw-�ݵisݲ�3�K�����-�χ��{����{���M�;�>s�f<��}�z0�w$�]W��&'��J�mQm�n>&|L���1�?n~�usmh�I+�B�n?�~��~��}�%J)�ݔ"u����(0�c�	G�(K��eQ��UA�HP�K-rՠ'�P�P�P�P�P�P�\�t��4����	������/���$��$���$�/k����Yvu	u�.@�R&=M�RV m	m	m	m	m	m�I[R��Ԟd���DQ�A?�V�m�Ҕ�m�G��ЋЋЋЋЋ�^��n�q_v+森R�B�	�"�"�"�"�"�"�"�����kDQT��B��J�$*Ѵ������Z%ZF6�l�lIhO+V��V}t�J��j�}6TMq�}�S�ԙ�<�Z��0A���oG�|�"+�����n�=������ ��H-�![��*�"�zs�����AFFFFF6�i�V%�M�jjZF
]�29O�ڻP_����&=���\׈��IKHrk��y����m�\���{y�4�F�w�d�l72W�,#M��CfO����C:,y���K��}���!ڇ6��v�|�c7�Ԛ<2���%��KMh۹���jn��{��{������!�_n�\з�Wb��%�/;���ºQ��V���'��_��֐�Hpz:���R�d6���>�x�zj�>�=��﹪ɻM�;U�������?���l���+���]~�����+i{�Ӽ�φޗ�"Ő�:�=�6���Y*�n�^*q*�s)��<l/�TW�TW����̋�:����w��J��[�Pj2��wS�g���q�m��O�tQFi�+�±��q�6/,����>wӣ4����p4��X~��3>z-�e�эw5��ԅ�4�z��K�3R/QL�^�"sr�hL/M�t^n@�z�i���;���ip���l"�P](=�Z�r�g�RMY�t�UkR:�FYmN��(���_�翏����K���-���<�p������띢�w��y?k��nL �~�Ю�����9��J���`��w�bP���Z�#�T*���Y�9�^Z�j��B�N34��.No/������=r5L{2]Z�-��zOo�>�5K��_ؘ�ԡ��9�K&��Q�=Wkem��M3Ȅv<�T+}��8��d2zq������GM��J�6_�o�#uD��a���Ϝ��R`��<M������2�����`�t����y6�J�	K᳴��23����m��h�i*Ҳ��h��^����ĉa�͖˴|�/�{g�>���N�g����߬�P���],��"���_j��FD8ӈH�>"\��2$f�6$�����$�m�->�f3��x�|f6�g�Vi6hV=�A>��怋��_�b�u�$kno�p�7�>g����@��m�o���σ+�FgS�h��p���������g��h	��/�d�.�!:^]ݞ���W�i���>9�nn�7ynn������p��5��~���G�m̋�2S3��ǏO>��'��)	Us��f��r���~�W�[h7�T�޴���������'����br�&*�=�ڦ�j�V�^S��0mV�Uˎ�c�Y�=ײ/�1T��4�I�ja�#���J�O������ֻw}zS�J�~]V��v����eYi�J}k��i�n\%v���5����M��ӣ���i_Ks��jn�V+�X_ƺ����r7Ζ���fAo�\��Ys�:1?���w/��Ji������X�}� �W7j����`tz�,�u����*�_Vv�s���ܺS�w�Fa�"�Np5�	Y��]��&I��rRf7�^���FY�ύxz5�t���'�N�����|3� :_�{U��M�U��|��k���澚��O�T���v�j��L
����jy������U���l��m�>�W����4���ph���.Ռ=������o���s��yj��2����jK�-�>}���b�!�!rz��5�� .~4!ir��CI_uwz��O�X��򺪖�t�(���W�Jז��#���7���W���KN���eO�Scee˜�^7y��Y�[���kS�/��S�����>U~���O��Le�I�ɇ4@:%��{�w�����BT�C�!D�#:A5@Z��p�.�X�əo&v�g�+h�-�=��ab�Bv���z�_!�m��ґ&t����G�=⮻ǐe��{BLN�q�{d���	�&��-�$�G0<Ԯ��e׈�Fj]�}l]��%v��b��	�]��e<�����8�%.7Q�@�hAY(k��t�Pӥ���=��1�ƥg�z���{�8�I���=�h/�.�mgcȱ�:tI�*��9�ؖ"t,��!�Q	xW隟�����ok]3��%���E>(�Aͺ�<�|P����-����j�i��W�4��tS+��ق����0˨�R�R�R�R�R�R�:K�7N3�/�K%K%K%K%K%K�-�q��6��^\� ��o����Z�^�^�^�^�^��z�{��yo�|Zt��_o��sϸ\�VKVKVKVKV���2J�`�VL��2t[15�*����W̷?��d�d�d�d�d�\�]f���`��i��?�]���?�f�d�d�d�d�dż�����4���ke�ϕ����V>i�`�f�bYL4�TY7���~��烣�{G{���������7{�*�����v���e|����2�/��?W6����&��?Y6)a�+�4�i!�[�4ԫ�7|�lpv�W|����'�4褺����A�ɿ(S�P6K��7h�q}~q����߆�op���*Ң���l���<T��]�Ƭ�au1)�t����^�˰�jLqk�~��XYu;��o'r����~K�f�s���my��\���3ܰ�o��a�~ð�wc�;�e-h�grh�����.��Qے���Rj꼾|YҀj��O����H8�7���&N�ʆ����1���>��.{��7�����K{�ZG_v�e�������t�c�y�����w9JW���/C%�W�z�ѧ��e��H6���Ɓ�RD���݇�d�]
�`�5�����,�(��1p}G���n���;��c��˟@������;���c���;�pè�#�w�fyǨ�盓[���l����o��_uJ�U�8qW,�TW�g����w�'�۟L.�d�����r�*U{���,Iw�ݪ������U34~���~s5n/���N�"�Rnw�:�J�-jӠ�^�����>�77�V�g�<c瘦��$�59��Erc��l\�d�*�n+ٱ�;%�n1O^� ��|���tХ�t�wk2h{.f�g^z�g���~=��v�4�so�)�z"�Ga?J*i��ކ��#;a5t�'Y��R�uu|B�-���l��l��$���V�����S[����n�?|��������X�(�㻞�����;Q�d���53}�4�!/G9�GqE]T�؏k���*�����5X����5���<>@�G٪��C�4�H>��s)�L����n������Ҏ��v�E�];*JiK���������Z(G�T�J����D.C9�kiP��(G(G(G(G(G(G���v��Ђ=�D�"�oPd�X���!Ol_�DR���~>�^<a�6�A����е�
�IS��KPƵ��q���p�:���ƞ)ǩ�>��Ac��S����ǝ����U�      	   "   x��t�R��4��u�tT�4����� S.Q      �      x������ � �         M   x�3�t�����st��p��L-*�/�2�tv�sv��
�&'�ss::���sf��s�p:��xF9:{��ADb���� <q}      �   �   x�M�AN�0E�3��	Pf��2E�)��*���q*F�]�����K�����ïvH|��]��X�p��qg#�� �+S���H��������	�N(�e�
f�cg�T�}��1&�"��b0�R�o�s[���ۋ7�Ҭ���dU���>��Ơ���*�
>���T�����*�,�t��6�� ���v݋}���]#�_�a��n����t�J�         *   x�3�tst	r�41�2�t��rt����44����� �      �   Y   x�3��t	��V�Tp�	�����<�C��<4�=��=�S����������Ғ�I�������G�����U�X�/_�X�И+F��� ��      �   *   x�3�tru�2�tv��tqt�2����s�	u����� ��/      �   (   x�3�4��5�4�b�P?OGN.cNcN_ ���� c�W         J
  x��kO�:���+|�0�Mڔ�������x\1p��A#����4�&)�/��;;�㸥��V������ʱ��@<2'~�oc?v�Z�0"g^��F���� ��8�_;�F��D-$�5���~����a6��(���� ��
�U6��1��{|�9��߸H���������{z5�_���7c4_L`�M/��f:F�Stw��o��;ݒFRn�_+�F�����-s���
��xr{w3�1><�-f��=O��K��C��������/���<���"��˻�!H���C�N���p�ς5<#pt��k�$<�?�O0�n7�_t!��`��\���܏e��ޣd0�2:��rǝ������|��Fav\�|�t6�Τ�(�#tt(0�A�OF��>~�����Q�����oK�E�`>�!��+8�g��l�op{P�	[�W*O����ߊ���
z+J?ܒ�pI�_)���T���Id��b�Z�����3�=dQ���J]���h2�L����"{��`/[9(�EL���6�� m\��i�&��(�2Q�@���6ax5��*ҁ*o�r~zs~����r�����;a �yY��6v�����hA~J�ض	$	����&Z-fA-䐘�s�g����3L6�`B+�=�_����#��$C?B�^n�9��Ͽ�.�^�.υ).W�m'*uZx��.Cc?�?h1�MIT�q����f�sT��h�h��i��0&ȷa���X،\���!,E���Q�0�(.�p?��E����! 9�����'�,�I�dQ �{`����}�O&#�G�DL�R�ߐ�*&ڎ]�4|��f6�V���J���Oy�eE�_E�,G=Tz�H�sy�QZWߧ�����%(A���s�Ȟ#L��P�H<��_�x(�.9@cd2���'l�S$П8r}�3T���ȵ����� mAa�A$4p1��
CR�/��S#M.4���$9օ7
��I=�u(�T���F}!��aP^H�����>�݂ Q���<��`�g/=���q���E��)N;v�1XF��l��x嘟�X�q�5H@$���FQ�s'�03��7@��s�!fV�-A�.����'�:L�jL|�!4�R>��4��lx%{L�������n�,3��q�{䫌
P��H�
Y�VT�*W�A��O�v��������ޫ������n5��"���3�O��/\�`���,�4<KX��w��nG�at��fB�zA_*�i����j�
l����N�w��Ω�μ+���,�����j�P�(M����+L�W0��h�	T[�u�T'�����7[f[�fs�����G/�<���GFG�GݮF��m&�3��2ȣR�
L�9�,ea���d	����=�Hڠ��󆋉�u��΁�h6	å��_�,V�[��F8�,�B�y ���o\�Z�k���8�y�f�{����]S����&�b8�Al����"PQ2�;�HE���R2��|�d3pa�Z��}ō�s��
�=a���eb!��� 4�#=�ab���W�`-ѯf���&�v��	��NEs�!RSlP�Ҩ�>!q�Q�X-%�R��ؑ��s_i�׳]>��`�;|��%�Rڑ/�B~H������E���Rn�pm̢'�fg��
C�&�+*���.ֵ)����z[j�Y�߰���&��a�TVW���`h�Mx��Ze�ds��f��c�b>_u�L�z�%���^zS�o�Q64��E�ؗ<�i���Y��Z��6Vu��Ǥ�_ϼ�F��D���^�U��R&�l}ɹ�;��J���#��VP��^���GH:�h+�>|�l�9����F^��J�I�0����ه �*��Z��j/��awM+tiv����#Y�ڮï5Љ8�nGe�,�/!�	��6�����,Z��6?�������*/s�'6_u˅_���8S�7S���i�>�~�Q_�|�|Rv�+i6Ն���,���e7�ZfK����J}�DX��~�K��j�O�d���׿Q�B2!X}������:��4���\���:��:��1��-(��V�E���=(�8c~�i�B�����#�B���G�Z`��y��?`����=�y�����S����;T6�{�BCNG�G��6O�Y�S��dt4�(L���ӣ�o�R���̎^9�K��Tݔ�Q}��u��Y��zz��t��T�AU�E��SC駲Ш������!�?b�~"�.1ԽT�w�EK}�d��dl՗�����&:�eJ(V{#�M�JV{UBp�~���,Fp�����.FpK���aO���|�Y�傀y���g��k��2�n���n�t��a�u]Ȫ��-���y���l��l�J���l��z2�d����՗���m�AA�==�z���T�Yz�i�T�Yz�Y��Y*�֏�5G"�.k��,�'ejdl�I8x�;^��~7�F��ܪ�,�h]�����lzB�X㖍��s���K��:�Ѩ�Ӏ�4`thj�R��k�lz[; Lo@�{ )vP�����Ǟ��OR�l���y�iS�&�a�ֵ0o5:�z�0���2��;x�f�;6�n�ڮ�ezu;��������_G(�         �   x�]�QR�0D��S�0��6�SuD0c[E�3��?����[��+��8�U��ٜ~P�Tn���RN(gn�>�;.������~Tjp�U_q�g/����G%Y9����Y_���S�ؤ��+���H�o�h�+�z�d�z	��h�!la����g�O�^B�[v1ze=���?s���{4�;@	�
-����1n �U�mQ���i���F�u���z6�| �X[         �  x�e��n�A��=O���޷L�@��t��P������<�~���������NO������ח�v) ��@%��FPw����t��{*�g�#�4�VC=n���0��0
�`,
��a,���NØ��3�IC����J�2c>�F5��b��cՊ�@}��������I(�a��;��g�c�j4�a��1�ZW�P���p�.�$�	e�3aٌ0��N��^M	�С��;S�A(��0o�.c��曒�g���
a�>������s����1rc��I(їCQ4��3a�>��t�guXc��eku�E,�|;|N������Җ/s&*W!�F+77]J���Q�5	��"��wv��Pv�a�K� �:�f�F(�;�D���ݑ{Qh9��6�F*>W�%�����|�]my��eyP��A�@��Լ-��A�����I;'K%�R;.��{+��2i��{���q+T|P*>(����ckؽ�]�8��8�ސ�8^����HC��1����j4tݗ�@��2,�q�[ȩt�ũ�N��C�"r*��69���t-s*��eN��h�,Tk��%}�p���|M�A�m��G������v8��>?����?Q�����zs{��E�w���O�C�Ǖ�����ׇ�|�\. �S��      �   �  x��U[��0���L0~�e��%�����O�*+$�a h_����@Z�IpV;i�+��AwF#�u�CAڕ!R�gH�`�y�E��}�wjM��t��������	c�jN�-�0HrX_��8 g�%�Wځ����[:Ɲ1��j��2����p�4���b��P��T��C�������Q5O��	�0��6B?v�L�U�|�.5���{o���>���k�b�v"
�
>c ��6�ٿ�IP�1��pD%���w�P�aНa��t��Q�-�Y�wd$ܓ<b������~s?��2���^W����*�qD�z�f�s+�#�ReD�]w��j�\G�Z'��8T��� :?9MWY<\S&�q��M�lW��Oy�:9tZ��S%��^��t���w%�W\f;n�7϶�#B㮝O@�'��9��SCn?0��#թ����N���5+�ͳ"��BĿ�@#      �   �  x����n�0���S��.���Kܔ��Y���>�j�}�C�(��s�gpD�풏��g���3��6���4My�%T�̋�7�3}I�ߓZq�'�/)�g!/�]��jͻ�H./�b"��d5��UޱW��5�(�?�݊��]s|	��m����Y�H���c9�eF���᳷�L�]�Q�y֊�PQ.9��jcO��$��l�07ӝ!��<畏y� /	(I�x��u��Lh;���6:�Ce�\�C��'i��w�����/��_��5��������"?P��I��;v���
΋�y4_��G1�QLfQ6%=��c��1]���<�G�c�<�� ��B�Q�	���@8J�S�K4lڳ�9V7M�x7�.%T��k����SxT��j�����I�O*���!=3����5y@�>j�����7UV[���	*\)oR���ΑH���[8(j�O��i��2Q��i�,��;A����6�Y�a���t}�siNY�{3%e�Q���֚>�ĳC��,���ǧ��U܈�.�%ۭ��-��	�9�Z��q=�,�
&]�}�י� �������l1>;�?/�)ӈ�m$pX��0,/�u?^^�!����Ì[﨩���+�Fa)Y�Ƶ:T�p0]3Gg9��u�]���43�G�)7�e7���7Fd��:��E#w�W\y�0���0���GRSX���PכuL^�<�+J;��m�8q�К���p�[�,������d����|j�4P^oC�i� ��]�G����o�0����ܮ2(��]�eǝ�n]Y(�ߵ�M{����8˺�l���*�r��ܵ&��:Z[��N��{Ɣ\]����wn�*#�1xWz�ςg,'�)�c���r"���Ae�:�qc͖�a���n�"_��G
�a|�O��/OOO� o��      �   ,   x�3�tt����	r���2�tst	rt�������� ���      �   "   x�3�4�4�2�4�4�2��\&@Ҍ+F��� 4�y      �   #  x�e��n�@E�����0��h"*F�I�Uk�n: 0���/�11���{��@��E��i��%� L,j6��2�=�0���^2�đ:7��X���7Ђ�`�S�n��x8�uh+�}}R��*7��^�~yN�d�������(M��9-��JpLǵQ^��~��;t/!�%Y����x��¸]��F�n����ܮ��|a�nz�l�"������.��Ǚj�J����tv�}��hVTko?�^T�].�j�;�١fs�9z��T�Je��jxG�a|I�s@      �   �   x�uO;�0�_N�	���ց���6T�h��*8>5
H^�϶���к֕M��i]�;e�(Q���,"�'�L�K"�
ݥ>���g�Ba�nMB6I�h����4�OG� �k��i�@ӆ6`F=� Qb�1ȳmF_U�ܯ^u�r'pqfK	�L8��>jin�7̎X7���^$���?C�~m���$a�     