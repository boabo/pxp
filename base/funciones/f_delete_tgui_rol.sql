CREATE OR REPLACE FUNCTION pxp.f_delete_tgui_rol (
  par_gui varchar,
  par_rol varchar
)
RETURNS varchar AS
$body$
DECLARE
	v_id_rol integer;
    v_id_gui integer;
BEGIN

	
    
    select id_rol into v_id_rol
    from segu.trol r
    where r.rol = par_rol;
    
    select id_gui into v_id_gui
    from segu.tgui g
    where g.codigo_gui = par_gui;
    
    update segu.tgui_rol
    set estado_reg = 'inactivo'
    where id_rol = v_id_rol and
    	id_gui = v_id_gui and estado_reg = 'activo';
    
    return 'exito';
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;