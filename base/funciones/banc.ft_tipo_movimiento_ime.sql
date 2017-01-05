CREATE OR REPLACE FUNCTION banc.ft_tipo_movimiento_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Control Bancos
 FUNCION: 		banc.ft_tipo_movimiento_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'banc.ttipo_movimiento'
 AUTOR: 		 (gvelasquez)
 FECHA:	        21-11-2016 20:20:09
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:
 AUTOR:
 FECHA:
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_tipo_movimiento	integer;
    v_fk_tipo_movimiento	integer;

BEGIN

    v_nombre_funcion = 'banc.ft_tipo_movimiento_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'BANC_TIPMOV_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:20:09
	***********************************/

	if(p_transaccion='BANC_TIPMOV_INS')then

        begin

            IF v_parametros.fk_tipo_movimiento != 'id' and v_parametros.fk_tipo_movimiento != '' THEN
             v_fk_tipo_movimiento = v_parametros.fk_tipo_movimiento::integer;
           ELSE
           --verificamos que no existe una cuenta raiz para este tipo_cuenta

               /*IF(exists (select 1
                          from conta.tcuenta  c
                            and c.tipo_cuenta = v_parametros.tipo_cuenta
                            and c.estado_reg='activo')) THEN

                    raise exception 'solo se permite una cuenta base de %',v_parametros.tipo_cuenta;

                END IF;*/
           END IF;

        	--Sentencia de la insercion
        	insert into banc.ttipo_movimiento(
			nombre_movimiento,
			orden,
			nivel,
			fk_tipo_movimiento,
            tipo,
			estado_reg,
			id_usuario_ai,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			fecha_mod,
			id_usuario_mod
          	) values(
			v_parametros.nombre_movimiento,
			v_parametros.orden,
			v_parametros.nivel,
			v_fk_tipo_movimiento,
            v_parametros.tipo,
			'activo',
			v_parametros._id_usuario_ai,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null



			)RETURNING id_tipo_movimiento into v_id_tipo_movimiento;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Movimiento almacenado(a) con exito (id_tipo_movimiento'||v_id_tipo_movimiento||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_movimiento',v_id_tipo_movimiento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'BANC_TIPMOV_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:20:09
	***********************************/

	elsif(p_transaccion='BANC_TIPMOV_MOD')then

		begin
			--Sentencia de la modificacion
			update banc.ttipo_movimiento set
			nombre_movimiento = v_parametros.nombre_movimiento,
			orden = v_parametros.orden,
			nivel = v_parametros.nivel,
			fk_tipo_movimiento = v_parametros.fk_tipo_movimiento,
            tipo = v_parametros.tipo,
			fecha_mod = now(),
			id_usuario_mod = p_id_usuario,
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_tipo_movimiento=v_parametros.id_tipo_movimiento;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Movimiento modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_movimiento',v_parametros.id_tipo_movimiento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'BANC_TIPMOV_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:20:09
	***********************************/

	elsif(p_transaccion='BANC_TIPMOV_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from banc.ttipo_movimiento
            where id_tipo_movimiento=v_parametros.id_tipo_movimiento;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Tipo Movimiento eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_tipo_movimiento',v_parametros.id_tipo_movimiento::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	else

    	raise exception 'Transaccion inexistente: %',p_transaccion;

	end if;

EXCEPTION

	WHEN OTHERS THEN
		v_resp='';
		v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
		v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
		v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
		raise exception '%',v_resp;

END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;