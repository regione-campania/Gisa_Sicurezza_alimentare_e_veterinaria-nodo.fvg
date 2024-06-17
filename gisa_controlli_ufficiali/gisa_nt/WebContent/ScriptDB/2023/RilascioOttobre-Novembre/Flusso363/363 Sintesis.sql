alter table sintesis_stabilimenti_import_log add column json_scartati json;
alter table sintesis_stabilimenti_import_log add column json_validazione json;
alter table sintesis_stabilimenti_import_log add column header_file text;
alter table sintesis_stabilimenti_import add column riga integer;
alter table sintesis_stabilimenti_import add column note_hd text;


--Documentale
select header, id_invio_sintesis, 'update sintesis_stabilimenti_import_log set header_file ='''||header||''' where id = '||id_invio_sintesis||';' from storage_gisa_sintesis;
--Lanciare risultato su gisa

-- semaforo

alter table sintesis_stabilimenti_import_log add column ended timestamp without time zone;
update sintesis_stabilimenti_import_log set ended = entered;

alter table sintesis_stabilimenti_import add column tentativo_process boolean default false;
update sintesis_stabilimenti_import set tentativo_process = true;
alter table sintesis_stabilimenti_import add column data_tentativo_process timestamp without time zone;

CREATE OR REPLACE FUNCTION public.get_semaforo_import_sintesis()
    RETURNS TABLE(id_import integer, data_import text, record_da_processare integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
r RECORD;	
idImport integer;
dataImport text;
recordDaProcessare integer;
recordProcessati integer;
BEGIN

idImport := -1;
dataImport := '';

recordDaProcessare := 0;
recordProcessati := 0;

-- Estraggo dati di eventuale record import in corso
select id, to_char(entered, 'dd/MM/yyyy HH24:MI') into idImport, dataImport from sintesis_stabilimenti_import_log where ended is null order by id desc limit 1;

-- Se esiste, verifico quanti record sono ancora da processare e quanti processati
IF idImport > 0 THEN
select count(i.*) into recordDaProcessare from sintesis_stabilimenti_import i where i.id_import = idImport and i.trashed_date is null and i.tentativo_process is not true;

select count(i.*) into recordProcessati from sintesis_stabilimenti_import i where i.id_import = idImport and i.trashed_date is null and i.tentativo_process is true;

-- Se c'è almeno un record processato e i record da processare sono 0, vuol dire che il thread ha fallito la conclusione e aggiorno ended forzatamente
IF recordProcessati > 0 AND recordDaProcessare = 0 THEN
update sintesis_stabilimenti_import_log set ended = now(), errore = 'Ended valorizzato di default per terminazione thread' where id = idImport;

-- Ricalcolo dati di import in corso
select id, to_char(entered, 'dd/MM/yyyy HH24:MI') into idImport, dataImport from sintesis_stabilimenti_import_log where ended is null order by id desc limit 1;

END IF;

END IF;


FOR 

id_import, data_import, record_da_processare

in

select
idImport, dataImport, recordDaProcessare


    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

-- test
select * from get_semaforo_import_sintesis();


-- FUNCTION: public.mapping_linea_attivita_sintesis(integer, text, text)

-- DROP FUNCTION IF EXISTS public.mapping_linea_attivita_sintesis(integer, text, text);

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
where m.rev = _rev and f.sintesis and regexp_replace(replace(l.linea_attivita, 'A''', ''), '[^a-zA-Z0-9]', '', 'g') ilike inattivita and regexp_replace(a.aggregazione, '[^a-zA-Z0-9]', '', 'g') ilike inaggregazione);
 raise info 'id master list mappato al primo giro (mapping con master list): % ', id_linea_attivita;
 
return id_linea_attivita;

 END;
$BODY$;

ALTER FUNCTION public.mapping_linea_attivita_sintesis(integer, text, text)
    OWNER TO postgres;