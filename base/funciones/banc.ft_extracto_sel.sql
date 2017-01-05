CREATE OR REPLACE FUNCTION banc.ft_extracto_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Control Bancos
 FUNCION: 		banc.ft_extracto_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'banc.textracto'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'banc.ft_extracto_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'BANC_EXTRA_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:18:54
	***********************************/

	if(p_transaccion='BANC_EXTRA_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						extra.id_extracto,
						extra.id_tipo_movimiento,
                        tipmov.nombre_movimiento,
						extra.saldo,
						extra.cod_operacion,
						extra.fecha,
						extra.credito,
						extra.nro_cbte,
						extra.estado_conciliacion,
						extra.importe_conciliar,
						extra.estado_reg,
						extra.nro_documento,
						extra.cuenta_transf,
						extra.secuencial,
						extra.glosa,
						extra.debito,
						extra.id_usuario_ai,
						extra.usuario_ai,
						extra.fecha_reg,
						extra.id_usuario_reg,
						extra.id_usuario_mod,
						extra.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from banc.textracto extra
                        left join banc.ttipo_movimiento tipmov on tipmov.id_tipo_movimiento=extra.id_tipo_movimiento
						inner join segu.tusuario usu1 on usu1.id_usuario = extra.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = extra.id_usuario_mod
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'BANC_EXTRA_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:18:54
	***********************************/

	elsif(p_transaccion='BANC_EXTRA_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_extracto)
					    from banc.textracto extra
					    inner join segu.tusuario usu1 on usu1.id_usuario = extra.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = extra.id_usuario_mod
					    where ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;

	else

		raise exception 'Transaccion inexistente';

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