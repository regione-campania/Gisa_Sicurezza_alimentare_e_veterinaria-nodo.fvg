DROP FUNCTION public.get_info_chk_biosicurezza_istanza(integer, integer);

CREATE OR REPLACE FUNCTION public.get_info_chk_biosicurezza_istanza(
    IN _idcu integer,
    IN _codspecie integer,
    IN _versione integer)
  RETURNS TABLE(id integer, id_lookup_chk_classyfarm_mod integer, bozza boolean, id_esito_classyfarm integer, descrizione_errore_classyfarm text, descrizione_messaggio_classyfarm text, data_invio timestamp without time zone, riaperta boolean) AS
$BODY$
DECLARE
r RECORD;	
BEGIN
RETURN QUERY

select ist.id, ist.id_lookup_chk_classyfarm_mod, ist.bozza, ist.id_esito_classyfarm, ist.descrizione_errore_classyfarm, ist.descrizione_messaggio_classyfarm, ist.data_invio, ist.riaperta
from biosicurezza_istanze ist 
where ist.idcu = _idcu and ist.trashed_date is null and ist.id_lookup_chk_classyfarm_mod in (select code from lookup_chk_classyfarm_mod where cod_specie::integer = _codspecie and versione = _versione);

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
