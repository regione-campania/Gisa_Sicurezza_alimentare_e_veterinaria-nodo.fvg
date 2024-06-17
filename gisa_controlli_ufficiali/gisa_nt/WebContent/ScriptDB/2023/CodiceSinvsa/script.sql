CREATE OR REPLACE FUNCTION digemon.dbi_get_codice_sinvsa(
	_riferimento_id integer DEFAULT NULL::integer,
	_riferimento_id_nome_tab text default NULL::text)
    RETURNS TABLE(riferimento_id integer, riferimento_id_nome_tab text, codice_sinvsa text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
BEGIN
	
    return query 
		select e.riferimento_id, e.riferimento_id_nome_tab, e.cun_sinvsa from sinvsa_osm_anagrafica_esiti e 
		where e.trashed_date is null and 
		(_riferimento_id is null or e.riferimento_id = _riferimento_id )and 
		(_riferimento_id_nome_tab is null or e.riferimento_id_nome_tab = _riferimento_id_nome_tab) ;
 END;
$BODY$;

ALTER FUNCTION digemon.dbi_get_codice_sinvsa(integer, text)
    OWNER TO postgres;
