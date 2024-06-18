--Dagli script sono omesse le creazioni delle tabelle lista_ufficiale_comuni e import_catastale_operazione_bonifica_comuni poiche vengono create tramite import da file csv e non su sql quindi al momento non ho script da fornire a riguardo

CREATE OR REPLACE FUNCTION rimuovi_spazi() RETURNS TRIGGER AS $$
BEGIN
    NEW.codice_comune = TRIM(NEW.codice_comune);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_rimuovi_spazi
BEFORE INSERT OR UPDATE ON lista_ufficiale_comuni
FOR EACH ROW EXECUTE FUNCTION rimuovi_spazi();


alter table comuni1
add column denominazione_old_pre_bonifica text;
alter table comuni1
add column istat_vecchi_pre_bonifica text; 
alter table comuni1 
add column cod_comune_pre_bonifica text; 
alter table comuni1
add column cod_regione_pre_bonifica text;
alter table comuni1
add column cod_provincia_pre_bonifica text;
alter table comuni1
add column comune_aggiunto_post_bonifica boolean;
alter table comuni1
add column note_hd text;
alter table comuni1
add column codice_catastale text;

CREATE SEQUENCE import_catastale_nextval
    INCREMENT BY 1
    START WITH 1
    NO MAXVALUE
    NO CYCLE;
	
ALTER TABLE import_catastale_operazione_bonifica_comuni
    ALTER COLUMN id SET DEFAULT NEXTVAL('import_catastale_nextval');
SELECT 
    'UPDATE comuni1 SET codice_catastale = ''' || subquery.codice_catastale || ''' WHERE istat = ''' || subquery.istat || ''';' as string
FROM (
    SELECT DISTINCT ON (c2.codice_istat) c2.codice_istat, c2.codice_catastale, c1.istat
    FROM import_catastale_operazione_bonifica_comuni c2
    LEFT JOIN comuni1 c1 ON TRIM(LEADING '0' FROM c1.istat) = c2.codice_istat 
	 WHERE c1.istat IS NOT NULL
) AS subquery;


SELECT 
    'UPDATE comuni1 SET trashed = true  WHERE istat = ''' || TRIM(LEADING '0' FROM c1.istat) || ''';
	INSERT INTO public.comuni1( cod_comune, cod_regione, cod_provincia, nome, istat, codiceistatasl, codice, codice_old, codiceistatasl_old, cap, trashed, cod_nazione, denominazione_old_pre_bonifica, istat_vecchi_pre_bonifica, cod_comune_pre_bonifica, cod_regione_pre_bonifica, cod_provincia_pre_bonifica, comune_aggiunto_post_bonifica)
 	VALUES ('''||c2.codice_comune ||''', '''||c2.codice_regione ||''', '''||c2.codice_provincia ||''','''|| c2.denominazione_in_italiano ||''', '''|| c2.istat ||''', 14, null, null, null, null ,' || trashed || ', 106,'''|| c1.nome ||''','''|| c1.istat ||''','''|| c1.cod_comune ||''','''|| c1.cod_regione ||''','''|| c1.cod_provincia ||''',  true);' AS update_query
FROM 
    comuni1 c1
join 
    lista_ufficiale_comuni c2 ON c1.nome = c2.denominazione_in_italiano
WHERE 
    (TRIM(LEADING '0' FROM c1.istat) <> TRIM(LEADING '0' FROM c2.istat)) OR (TRIM(LEADING '0' FROM c1.cod_comune) <> TRIM(LEADING '0' FROM c2.codice_comune)) OR (TRIM(LEADING '0' FROM c1.cod_regione) <> TRIM(LEADING '0' FROM c2.codice_regione)) OR (TRIM(LEADING '0' FROM c1.cod_provincia) <> TRIM(LEADING '0' FROM c2.codice_provincia));


WITH nuovi_comuni AS (
    SELECT
        codice_comune,
        codice_regione::integer,
        codice_provincia::integer,
        denominazione_in_italiano AS nome,
        TRIM(LEADING '0' FROM istat) AS istat,
        false AS trashed
    FROM
        lista_ufficiale_comuni
    EXCEPT
    SELECT
        cod_comune,
        cod_regione::integer,
        cod_provincia::integer,
        nome,
        TRIM(LEADING '0' FROM istat) AS istat,
        trashed
    FROM
        comuni1
)
SELECT
    'INSERT INTO public.comuni1( cod_comune, cod_regione, cod_provincia, nome, istat, codiceistatasl, codice, codice_old, codiceistatasl_old, cap, trashed, cod_nazione, denominazione_old_pre_bonifica, istat_vecchi_pre_bonifica, cod_comune_pre_bonifica, cod_regione_pre_bonifica, cod_provincia_pre_bonifica, comune_aggiunto_post_bonifica)
 VALUES ('''||codice_comune ||''', '''|| codice_regione ||''', '''|| codice_provincia ||''','''|| nome ||''', '''|| istat ||''', 14, null, null, null, null ,' || trashed || ', 106, null, null, null, null, null, true);' AS insert_query
FROM
    nuovi_comuni;
	
	
WITH nuovi_comuni AS (
    SELECT
        cod_comune,
        cod_regione::integer,
        cod_provincia::integer,
        nome,
        TRIM(LEADING '0' FROM istat) AS istat,
        trashed
    FROM
        comuni1
	where trashed = false and nome not ilike 'estero' and id <> -1
	EXCEPT
	 SELECT
        codice_comune,
        codice_regione::integer,
        codice_provincia::integer,
        denominazione_in_italiano AS nome,
        TRIM(LEADING '0' FROM istat) AS istat,
        false AS trashed
    FROM
        lista_ufficiale_comuni
)
select 
'UPDATE comuni1 set trashed = true, note_hd = ''Comune cancellato in seguito al operazione di bonifica dei comuni'' where istat = ''' ||istat||''';'
from nuovi_comuni;



select 
'Array("'||codice_catastale||'","'||nome||'"),'
from comuni1
SELECT 
    'UPDATE comuni1 SET nome= '''||c2.denominazione_in_italiano||''', denominazione_old_pre_bonifica = '''||c1.nome||''' WHERE istat = ''' || TRIM(LEADING '0' FROM c1.istat) || ''';'
FROM 
    comuni1 c1
join 
    lista_ufficiale_comuni c2 ON (TRIM(LEADING '0' FROM c1.istat) = TRIM(LEADING '0' FROM c2.istat))
WHERE 
   c1.nome <> c2.denominazione_in_italiano;
   
   

update comuni1 set nome_decode_ampersand = nome where denominazione_old_pre_bonifica is not null and istat_vecchi_pre_bonifica is null

update comuni1 set nome_decode_ampersand = nome where comune_aggiunto_post_bonifica is true and nome_decode_ampersand is null
update lookup_province set description = 'Bolzano' where code = 21;
update lookup_province set description = 'Valle d''Aosta' where code = 7;
update lookup_province set description = 'Forlì Cesena' where code = 40;

select * from lookup_province where description ilike '%forl%'
-- RICORDARSI DI FARE GLI UPDATE SULLE PROVINCE DI BOLZANO, VALLE DA OSTA E FORLI E CESENA O QUANTOMENO CAPIRE SE C E BISOGNO DI UPDATE