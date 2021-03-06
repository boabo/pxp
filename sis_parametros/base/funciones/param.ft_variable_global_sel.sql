CREATE OR REPLACE FUNCTION param.ft_variable_global_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		FRAMEWORK
 FUNCION: 		param.ft_variable_global_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.variable_global'
 AUTOR: 		 (ismael.valdivia)
 FECHA:	        12-05-2021 12:56:39
 COMENTARIOS:
***************************************************************************
 HISTORIAL DE MODIFICACIONES:
#ISSUE				FECHA				AUTOR				DESCRIPCION
 #0				12-05-2021 12:56:39								Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'param.variable_global'
 #
 ***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;

BEGIN

	v_nombre_funcion = 'param.ft_variable_global_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************
 	#TRANSACCION:  'PARAM_varglo_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		ismael.valdivia
 	#FECHA:		12-05-2021 12:56:39
	***********************************/

	if(p_transaccion='PARAM_varglo_SEL')then

    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						varglo.id_variable_global,
						varglo.variable,
						varglo.valor,
						varglo.descripcion
                        from pxp.variable_global varglo
				        where  ';

			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;

		end;

	/*********************************
 	#TRANSACCION:  'PARAM_varglo_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		ismael.valdivia
 	#FECHA:		12-05-2021 12:56:39
	***********************************/

	elsif(p_transaccion='PARAM_varglo_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_variable_global)
					    from pxp.variable_global varglo
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

ALTER FUNCTION param.ft_variable_global_sel (p_administrador integer, p_id_usuario integer, p_tabla varchar, p_transaccion varchar)
  OWNER TO postgres;
