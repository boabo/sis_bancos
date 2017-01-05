CREATE OR REPLACE FUNCTION banc.ft_tipo_movimiento_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Control Bancos
 FUNCION: 		banc.ft_tipo_movimiento_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'banc.ttipo_movimiento'
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

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
    v_where				varchar;

BEGIN

	v_nombre_funcion = 'banc.ft_tipo_movimiento_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'BANC_TIPMOV_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:20:09
	***********************************/

	if(p_transaccion='BANC_TIPMOV_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						tipmov.id_tipo_movimiento,
						tipmov.nombre_movimiento,
						tipmov.orden,
						tipmov.nivel,
						tipmov.fk_tipo_movimiento,
						tipmov.estado_reg,
						tipmov.id_usuario_ai,
						tipmov.fecha_reg,
						tipmov.usuario_ai,
						tipmov.id_usuario_reg,
						tipmov.fecha_mod,
						tipmov.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod
						from banc.ttipo_movimiento tipmov
						inner join segu.tusuario usu1 on usu1.id_usuario = tipmov.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipmov.id_usuario_mod
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

    /*********************************
     #TRANSACCION:  'BANC_TIPMOV_ARB_SEL'
     #DESCRIPCION:    Consulta de datos
     #AUTOR:            Gonzalo Sarmiento
     #FECHA:            23-12-2016
    ***********************************/

    elseif(p_transaccion='BANC_TIPMOV_ARB_SEL')then

        begin
              if(v_parametros.id_padre = '%') then
                v_where := ' tipmov.fk_tipo_movimiento is NULL';

              else
                v_where := ' tipmov.fk_tipo_movimiento = '||v_parametros.id_padre;
              end if;

            --Sentencia de la consulta
            v_consulta:='select
                        tipmov.id_tipo_movimiento,
                        tipmov.fk_tipo_movimiento,
                        tipmov.nombre_movimiento,
                        case when (tipmov.fk_tipo_movimiento is null) then
                        	''raiz''::varchar
                             when (tipmov.tipo =''transaccion'') then
                             ''hoja''::varchar
                             else
                             ''hijo''::varchar
            			end as tipo_nodo,
                        tipmov.tipo,
                        tipmov.orden,
                        tipmov.nivel
                        from banc.ttipo_movimiento tipmov
                        where  '||v_where|| '
                           and tipmov.estado_reg = ''activo''
                        ORDER BY tipmov.orden, tipmov.nombre_movimiento';
            raise notice '%',v_consulta;

            --Devuelve la respuesta
            return v_consulta;

        end;

	/*********************************
 	#TRANSACCION:  'BANC_TIPMOV_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		gvelasquez
 	#FECHA:		21-11-2016 20:20:09
	***********************************/

	elsif(p_transaccion='BANC_TIPMOV_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_tipo_movimiento)
					    from banc.ttipo_movimiento tipmov
					    inner join segu.tusuario usu1 on usu1.id_usuario = tipmov.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = tipmov.id_usuario_mod
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