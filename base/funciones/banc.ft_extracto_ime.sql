CREATE OR REPLACE FUNCTION banc.ft_extracto_ime (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Control Bancos
 FUNCION: 		banc.ft_extracto_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'banc.textracto'
 AUTOR: 		 (gvelasquez)
 FECHA:	        21-11-2016 20:18:54
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
	v_id_extracto	integer;

BEGIN

    v_nombre_funcion = 'banc.ft_extracto_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'BANC_EXTRA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:18:54
	***********************************/

	if(p_transaccion='BANC_EXTRA_INS')then

        begin
        	--Sentencia de la insercion
        	insert into banc.textracto(
            id_cuenta_bancaria,
			id_tipo_movimiento,
			saldo,
			cod_operacion,
			fecha,
			credito,
			nro_cbte,
			estado_conciliacion,
			importe_conciliar,
			estado_reg,
			nro_documento,
			cuenta_transf,
			secuencial,
			glosa,
			debito,
			id_usuario_ai,
			usuario_ai,
			fecha_reg,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
            v_parametros.id_cuenta_bancaria,
			v_parametros.id_tipo_movimiento,
			v_parametros.saldo,
			v_parametros.cod_operacion,
			v_parametros.fecha,
			COALESCE(v_parametros.credito,0.00),
			v_parametros.nro_cbte,
			v_parametros.estado_conciliacion,
			v_parametros.importe_conciliar,
			'activo',
			v_parametros.nro_documento,
			v_parametros.cuenta_transf,
			v_parametros.secuencial,
			v_parametros.glosa,
			COALESCE(v_parametros.debito,0.00),
			v_parametros._id_usuario_ai,
			v_parametros._nombre_usuario_ai,
			now(),
			p_id_usuario,
			null,
			null
			)RETURNING id_extracto into v_id_extracto;

			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Extracto almacenado(a) con exito (id_extracto'||v_id_extracto||')');
            v_resp = pxp.f_agrega_clave(v_resp,'id_extracto',v_id_extracto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'BANC_EXTRA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:18:54
	***********************************/

	elsif(p_transaccion='BANC_EXTRA_MOD')then

		begin
			--Sentencia de la modificacion
			update banc.textracto set
			id_tipo_movimiento = v_parametros.id_tipo_movimiento,
			saldo = v_parametros.saldo,
			cod_operacion = v_parametros.cod_operacion,
			fecha = v_parametros.fecha,
			credito = v_parametros.credito,
			nro_cbte = v_parametros.nro_cbte,
			estado_conciliacion = v_parametros.estado_conciliacion,
			importe_conciliar = v_parametros.importe_conciliar,
			nro_documento = v_parametros.nro_documento,
			cuenta_transf = v_parametros.cuenta_transf,
			secuencial = v_parametros.secuencial,
			glosa = v_parametros.glosa,
			debito = v_parametros.debito,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_extracto=v_parametros.id_extracto;

			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Extracto modificado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_extracto',v_parametros.id_extracto::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************
 	#TRANSACCION:  'BANC_EXTRA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:18:54
	***********************************/

	elsif(p_transaccion='BANC_EXTRA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from banc.textracto
            where id_extracto=v_parametros.id_extracto;

            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','Extracto eliminado(a)');
            v_resp = pxp.f_agrega_clave(v_resp,'id_extracto',v_parametros.id_extracto::varchar);

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