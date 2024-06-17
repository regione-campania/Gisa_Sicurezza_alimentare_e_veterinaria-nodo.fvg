CREATE OR REPLACE FUNCTION public.mapping_linea_attivita_sintesis(
	_rev integer,
	_attivita text,
	_aggregazione text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE
inaggregazione text;
inattivita text;
revmax integer;
id_linea_attivita integer;

BEGIN

inaggregazione = regexp_replace(_aggregazione, '[^a-zA-Z0-9]', '', 'g');
inattivita = regexp_replace(_attivita, '[^a-zA-Z0-9]', '', 'g');
 raise info 'aggregazione: % ', inaggregazione;
 raise info 'attivita: % ', inattivita;
id_linea_attivita := (select l.id from master_list_macroarea m
join master_list_aggregazione a on a.id_macroarea = m.id
join master_list_linea_attivita l on l.id_aggregazione = a.id
join master_list_flag_linee_attivita f on f.id_linea = l.id
where m.rev = _rev and f.sintesis and regexp_replace(l.linea_attivita, '[^a-zA-Z0-9]', '', 'g') ilike inattivita and regexp_replace(a.aggregazione, '[^a-zA-Z0-9]', '', 'g') ilike inaggregazione);
 raise info 'id master list mappato al primo giro (mapping con master list): % ', id_linea_attivita;
 
return id_linea_attivita;


 END;
$BODY$;