CREATE OR REPLACE FUNCTION public.is_linea_propagabile_bdu(id_linea_ integer)
  RETURNS boolean AS
$BODY$
DECLARE
	ret text;
BEGIN

select bdu into ret from master_list_flag_linee_attivita where id_linea = id_linea_;

 RETURN ret;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;
ALTER FUNCTION public.is_linea_propagabile_bdu(integer)
  OWNER TO postgres;
