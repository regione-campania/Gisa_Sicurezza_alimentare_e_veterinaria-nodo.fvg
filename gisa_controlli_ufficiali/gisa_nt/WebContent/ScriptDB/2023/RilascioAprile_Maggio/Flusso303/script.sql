--creare la dbi generaCodiceFlussoC40_303 copiandola da generaCodiceFlussoC40 con la modifica sulla residenza

-- Function: public.generacodiceflussoc40(integer, text, integer, integer)
-- DROP FUNCTION public.generacodiceflussoc40(integer, text, integer, integer);

CREATE OR REPLACE FUNCTION public.generacodiceflussoc40_303(
    id_richiesta_in integer,
    suffisso_in text,
    id_linee_mob_in integer,
    id_stabilimento_in integer DEFAULT NULL::integer)
  RETURNS text AS
$BODY$
declare
	id_indirizzo_t integer;
	id_provincia_t integer;
	cod_provincia_lett text;
	rec1 record;
	tempn integer;
	tempn1 integer;
	maxprog integer;
	num_risultati_prog integer;
begin
	/*estraggo cod_provincia a partire dalla residenza*/
	select trim(lpsf.cod_provincia) into cod_provincia_lett
	from opu_rel_operatore_soggetto_fisico rel 
	join opu_operatore op on rel.id_operatore = op.id
	join opu_soggetto_fisico osf on osf.id = rel.id_soggetto_fisico  and rel.enabled
	join opu_stabilimento os on os.id_operatore = op.id
	left join opu_indirizzo oiop on oiop.id = osf.indirizzo_id
	left join comuni1 cop on cop.id = oiop.comune
	left join lookup_province lpsf on lpsf.code = trim(cop.cod_provincia)::integer
	where os.id = id_stabilimento_in; 
	

	select count(*) into tempn1 from seqs_campiestesi_autogenerati_per_provincia 
	where lower(cod_provincia) = lower(cod_provincia_lett) and id_linee_mobili_html_fields = id_linee_mob_in;

	if tempn1 > 0 then
		select seq into tempn from seqs_campiestesi_autogenerati_per_provincia 
		where lower(cod_provincia) = lower(cod_provincia_lett) and id_linee_mobili_html_fields = id_linee_mob_in;

		maxprog := 0;
		num_risultati_prog := 0;
		select max( (case when substring(lmobvalue.valore_campo from 3 for 4) ~ '^[0-9\.]+$' then 
				substring(lmobvalue.valore_campo from 3 for 4) 
			     else null end)::integer ) as max_prog,
		      count(*) into maxprog, num_risultati_prog
		from linee_mobili_html_fields lmobfied 
			join linee_mobili_fields_value lmobvalue on lmobvalue.id_linee_mobili_html_fields = lmobfied.id
		where length(trim(lmobfied.dbi_generazione)) > 1 
			and trim(lmobvalue.valore_campo) ilike ( cod_provincia_lett || lpad((tempn+1)::text,4,'0') || suffisso_in );

		IF num_risultati_prog > 0 THEN
			update seqs_campiestesi_autogenerati_per_provincia set seq = maxprog+1 
				where lower(cod_provincia) = lower(cod_provincia_lett) and id_linee_mobili_html_fields = id_linee_mob_in;
			tempn := maxprog;
		ELSE 
			update seqs_campiestesi_autogenerati_per_provincia set seq = seq+1 
				where lower(cod_provincia) = lower(cod_provincia_lett) and id_linee_mobili_html_fields = id_linee_mob_in;
		END IF;
		
		
	else
		tempn := 0;

		maxprog := 0;
		num_risultati_prog := 0;
		select max( (case when substring(lmobvalue.valore_campo from 3 for 4) ~ '^[0-9\.]+$' then 
				substring(lmobvalue.valore_campo from 3 for 4) 
			     else null end)::integer ) as max_prog,
		      count(*) as numero_ris into maxprog, num_risultati_prog
		from linee_mobili_html_fields lmobfied 
			join linee_mobili_fields_value lmobvalue on lmobvalue.id_linee_mobili_html_fields = lmobfied.id
		where length(trim(lmobfied.dbi_generazione)) > 1 
			and trim(lmobvalue.valore_campo) ilike ( cod_provincia_lett || lpad((tempn+1)::text,4,'0') || suffisso_in );

		IF num_risultati_prog > 0 THEN
			insert into seqs_campiestesi_autogenerati_per_provincia  values(id_linee_mob_in,lower(cod_provincia_lett),maxprog +1);
			tempn := maxprog;
		ELSE
			insert into seqs_campiestesi_autogenerati_per_provincia  values(id_linee_mob_in,lower(cod_provincia_lett),tempn +1);
		END IF;
		
		 
	end if;
	
	return ( cod_provincia_lett || lpad((tempn+1)::text,4,'0') || suffisso_in );
	 
	
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.generacodiceflussoc40_303(integer, text, integer, integer)
  OWNER TO postgres;
  
  
  --rev 10

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, only_hd, obbligatorio, enabled, readonly, dbi_generazione, codice_raggruppamento,gestione_interna) values
((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 10),
'codice_stazione','codice_stazione_recapito','Codice Stazione', 0, true, true, true, 'generaCodiceFlussoC40(:idRichiesta:,''F'',397, :idStabilimento:)', 'CODSTASTA', NULL);


insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, only_hd, obbligatorio, enabled, readonly, dbi_generazione, codice_raggruppamento, gestione_interna) values
((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 10),
'codice_stazione','codice_stazione_recapito','Codice Stazione', 0, true, true, true, 'generaCodiceFlussoC40(:idRichiesta:,''L'',397, :idStabilimento:)', 'CODSTASTA', NULL);


-- rev 8

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, only_hd, obbligatorio, enabled, readonly, dbi_generazione, codice_raggruppamento,gestione_interna) values
((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 8),
'codice_stazione','codice_stazione_recapito','Codice Stazione', 0, true, true, true, 'generaCodiceFlussoC40(:idRichiesta:,''F'',397, :idStabilimento:)', 'CODSTASTA', NULL);


insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, only_hd, obbligatorio, enabled, readonly, dbi_generazione, codice_raggruppamento, gestione_interna) values
((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 8),
'codice_stazione','codice_stazione_recapito','Codice Stazione', 0, true, true, true, 'generaCodiceFlussoC40(:idRichiesta:,''L'',397, :idStabilimento:)', 'CODSTASTA', NULL);

-- Fix

update
linee_mobili_html_fields
set dbi_generazione =
replace(replace(dbi_generazione, 'generaCodiceFlussoC40', 'generaCodiceFlussoC40_303'), '397', id||'')
where dbi_generazione <> '' and id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice in ('CG-NAZ-E-005', 'CG-NAZ-E-006'))

-- 005 10

select * from linee_mobili_html_fields where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 10) and nome_campo in ('codice_iscrizione_elenco_regionale', 'codice_stazione');

update linee_mobili_html_fields set 
tipo_campo = 'codice_stazione_recapito', gestione_interna = null, ordine = null, readonly = true, dbi_generazione = 'generaCodiceFlussoC40_303(:idRichiesta:,''F'','||id||', :idStabilimento:)', regex_expr = '^([a-zA-Z]+[0-9]{4}[fFlL]{1})*$', messaggio_se_invalid = null where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 10) and nome_campo in ('codice_iscrizione_elenco_regionale');

delete from linee_mobili_html_fields where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 10) and nome_campo in ('codice_stazione');

-- 006 10

select * from linee_mobili_html_fields where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 10) and nome_campo in ('codice_iscrizione_elenco_regionale', 'codice_stazione');

update linee_mobili_html_fields set 
tipo_campo = 'codice_stazione_recapito', gestione_interna = null, ordine = null, readonly = true, dbi_generazione = 'generaCodiceFlussoC40_303(:idRichiesta:,''L'','||id||', :idStabilimento:)', regex_expr = '^([a-zA-Z]+[0-9]{4}[fFlL]{1})*$', messaggio_se_invalid = null where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 10) and nome_campo in ('codice_iscrizione_elenco_regionale');

delete from linee_mobili_html_fields where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 10) and nome_campo in ('codice_stazione');

-- 005 8

select * from linee_mobili_html_fields where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 8) and nome_campo in ('codice_iscrizione_elenco_regionale', 'codice_stazione');

update linee_mobili_html_fields set 
tipo_campo = 'codice_stazione_recapito', gestione_interna = null, ordine = null, readonly = true, dbi_generazione = 'generaCodiceFlussoC40_303(:idRichiesta:,''F'','||id||', :idStabilimento:)', regex_expr = '^([a-zA-Z]+[0-9]{4}[fFlL]{1})*$', messaggio_se_invalid = null where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 8) and nome_campo in ('codice_iscrizione_elenco_regionale');

delete from linee_mobili_html_fields where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 8) and nome_campo in ('codice_stazione');

-- 006 8


select * from linee_mobili_html_fields where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 8) and nome_campo in ('codice_iscrizione_elenco_regionale', 'codice_stazione');

update linee_mobili_html_fields set 
tipo_campo = 'codice_stazione_recapito', gestione_interna = null, ordine = null, readonly = true, dbi_generazione = 'generaCodiceFlussoC40_303(:idRichiesta:,''L'','||id||', :idStabilimento:)', regex_expr = '^([a-zA-Z]+[0-9]{4}[fFlL]{1})*$', messaggio_se_invalid = null where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 8) and nome_campo in ('codice_iscrizione_elenco_regionale');

delete from linee_mobili_html_fields where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 8) and nome_campo in ('codice_stazione');


------------------------> modifica label
--select * from ml8_linee_attivita_nuove_materializzata where id_nuova_linea_attivita in (
--select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice='CG-NAZ-E-006') --CG-NAZ-E-006
--select * from linee_mobili_html_fields  where  label_campo ilike '%indirizzo' and id_linea in (40082,40083,40688,40689)

-- verifica se corrispondono gli id e poi lanciare update
update linee_mobili_html_fields set label_campo  = 'Comune di residenza'  where  label_campo ilike '%comune' and id_linea in (40082,40083,40688,40689);
update linee_mobili_html_fields set label_campo  = 'Provincia di residenza'  where  label_campo ilike '%provincia' and id_linea in (40082,40083,40688,40689);
update linee_mobili_html_fields set label_campo  = 'Indirizzo di residenza'  where  label_campo ilike '%indirizzo' and id_linea in (40082,40083,40688,40689);

-- ignorare
------------------------------- BONIFICA DELLE DBI GENERAZIONE CODICE_STAZIONE inizio

------------ ESTRAZIONE DI TUTTE LE DBI

SELECT 

id, dbi_generazione, lettera, vecchio_id, min,
'update linee_mobili_html_fields set dbi_generazione = ''' || replace(replace(dbi_generazione, vecchio_id::text, min::text), '''', '''''') || ''' where id = '|| id ||';'

 FROM

(

SELECT id, 
dbi_generazione, 
lettera,
vecchio_id,
(select min(id) from linee_mobili_html_fields where replace(substring(dbi_generazione, position(',' in dbi_generazione)+2,3), ''',', '') = lettera and enabled)

 FROM (
	
select 
id, 
dbi_generazione, 
replace(substring(dbi_generazione, position(',' in dbi_generazione)+2,3), ''',', '') as lettera,
substring(dbi_generazione, position(''',' in dbi_generazione)+2,3) as vecchio_id
from linee_mobili_html_fields where tipo_campo = 'codice_stazione_recapito' and enabled
order by dbi_generazione asc, id asc

) aa order by lettera asc, dbi_generazione asc, id asc

) bb;

-- LANCIO UPDATE SOLO SU QUELLE PER CUI VECCHIO_ID <> MIN PER LA STESSA LETTERA

------------------------------- BONIFICA DELLE DBI GENERAZIONE CODICE_STAZIONE fine




-- Nuovi interventi 28/11

-- Fixo tutte le dbi generazione usando un unico id per le stesse lettere. In questo modo tutte le dbi che generano la stessa lettera incrementeranno lo stesso progressivo

SELECT 

id, dbi_generazione, lettera, vecchio_id, min,
'update linee_mobili_html_fields set dbi_generazione = ''' || replace(replace(dbi_generazione, vecchio_id::text, min::text), '''', '''''') || ''' where id = '|| id ||';'

 FROM

(

SELECT id, 
dbi_generazione, 
lettera,
vecchio_id,
(select min(id) from linee_mobili_html_fields where replace(substring(dbi_generazione, position(',' in dbi_generazione)+2,3), ''',', '') = lettera and enabled)

 FROM (
	
select 
id, 
dbi_generazione, 
replace(substring(dbi_generazione, position(',' in dbi_generazione)+2,3), ''',', '') as lettera,
substring(dbi_generazione, position(''',' in dbi_generazione)+2,3) as vecchio_id
from linee_mobili_html_fields where tipo_campo = 'codice_stazione_recapito' and enabled
order by dbi_generazione asc, id asc

) aa order by lettera asc, dbi_generazione asc, id asc

) bb;

-- Gestisco nuova linea fecondatori negli allevamenti

select * from ml8_linee_attivita_nuove_materializzata where codice in ('CG-NAZ-E-009');
40086
40692

select * from linee_mobili_html_fields where id_linea in (40086) and nome_campo = 'codice_iscrizione_elenco_regionale';
707

update linee_mobili_html_fields set tipo_campo = 'codice_stazione_recapito', tabella_lookup = '', javascript_function = '', javascript_function_evento = '', link_value = '', label_link = '', gestione_interna = null, ordine = null, readonly = true, dbi_generazione = 'generaCodiceFlussoC40_303(:idRichiesta:,''L'',628, :idStabilimento:)', messaggio_se_invalid = null where id = 707;

select * from linee_mobili_html_fields where id_linea in (40692) and nome_campo = 'codice_iscrizione_elenco_regionale';
802

update linee_mobili_html_fields set tipo_campo = 'codice_stazione_recapito', tabella_lookup = '', javascript_function = '', javascript_function_evento = '', link_value = '', label_link = '', gestione_interna = null, ordine = null, readonly = true, dbi_generazione = 'generaCodiceFlussoC40_303(:idRichiesta:,''L'',628, :idStabilimento:)', messaggio_se_invalid = null where id = 802;


-- Gestisco nuova gestione codice sulla linea veterinari fecondatori

select * from ml8_linee_attivita_nuove_materializzata where codice in ('CG-NAZ-E-005');
40082
40688

select * from linee_mobili_html_fields where id_linea in (40082,40688) and nome_campo = 'codice_iscrizione_elenco_regionale';
611
761

update linee_mobili_html_fields set tipo_campo = 'text', ordine_campo = 14, obbligatorio = true, readonly = false, gestione_interna = true, dbi_generazione='',regex_expr = '^([a-zA-Z0-9]*[fF]{1})*$', messaggio_se_invalid = 'VERIFICARE  CHE TERMINI CON LA LETTERA F.' where id in (611, 761);



------------------------> modifica label
select * from ml8_linee_attivita_nuove_materializzata where id_nuova_linea_attivita in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice='CG-NAZ-E-009')

select * from linee_mobili_html_fields  where  label_campo ilike '%Indirizzo </br>operatore laico%' and id_linea in (40086,40692)
select * from linee_mobili_html_fields  where  label_campo ilike '%Comune </br>operatore laico%' and id_linea in (40086,40692)
select * from linee_mobili_html_fields  where  label_campo ilike '%Provincia </br>operatore laico%' and id_linea in (40086,40692)

-- verifica se corrispondono gli id e poi lanciare update
update linee_mobili_html_fields set label_campo  = 'Indirizzo di residenza</br>operatore laico'  where  label_campo ilike '%Indirizzo </br>operatore laico%' and id_linea in (40086,40692)

update linee_mobili_html_fields set label_campo  = 'Comune di residenza</br>operatore laico'  where  label_campo ilike '%Comune </br>operatore laico%' and id_linea in (40086,40692)

update linee_mobili_html_fields set label_campo  = 'Provincia di residenza</br>operatore laico'  where  label_campo ilike '%Provincia </br>operatore laico%' and id_linea in (40086,40692)


-- Nuove nuove modifiche

alter table linee_mobili_html_fields add column notes_hd text;

update linee_mobili_html_fields set enabled = false, notes_hd = 'Campo disabilitato a seguito flusso 303' where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where livello = 3 and codice in ('CG-NAZ-E-006', 'CG-NAZ-E-009', 'CG-NAZ-E-005')) and enabled and nome_campo not like 'codice_iscrizione_elenco_regionale';

update linee_mobili_html_fields set messaggio_se_invalid = 'INSERIRE CODICE ISCRIZIONE ALBO PROVINCIALE DEI MEDICI VETERINARI, SEGUITO DALLA LETTERA F' where nome_campo = 'codice_iscrizione_elenco_regionale' and id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005');

