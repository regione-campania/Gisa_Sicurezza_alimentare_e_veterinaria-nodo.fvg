insert into opu_lookup_norme_master_list(description, enabled, codice_norma) values ('Reg. CE 1255/97', true, '1255-97');
insert into opu_lookup_norme_master_list(description, enabled, codice_norma) values ('Reg.(UE) 2016/429-Reg. (UE) 2020/686-Reg. (UE) 2020/999', true, '429-16');
alter table master_list_flag_linee_attivita  add column sinac boolean;

/*CREATE TABLE public.masterlist11
(
  norma	text,
  codice_norma	text,	
  macroarea	 text,
  aggregazione	 text,
  linea_attivita text,
  codice_univoco	 text,
  codice_sezione text,	
  codice_attivita	 text,
  codice_prodotto_specie	 text,
  registrati	 text,
  riconosciuti	 text,
  sede_fissa	 text,
  sede_mobile text,
  procedura_amministrativa text,
  scheda_supplementare text,
  cat_ex_ante	 text,
  categorizzabili	 text,
  attivita_specifica_attributi  text,	
  codice_nazionale_richiesto	 text,
  tipo	 text,
  apicoltura	 text,
  gestiti_sintesis	 text,
  propagati_bdu	 text,
  propagati_vam	 text,
  propagati_sinac text,
  note text,
  gestione_dati_aggiuntivi text
)
WITH (
  OIDS=FALSE
);

alter table master_list_flag_linee_attivita  add column sinac boolean;
alter table masterlist11 add column no_scia text;

-- import file Masterlist11 da csv, delimiter , e latin1 encoding
-- no-scia aggiornati in base al feedback orsa
insert into masterlist11
select norme.description as norma, 
norme.codice_norma,
 ml10.macroarea, 
 ml10.aggregazione,
 ml10.attivita as linea_attivita,
 ml10.codice as codice_univoco,
 ml10.codice_macroarea as codice_sezione, 
 ml10.codice_aggregazione as codice_attivita, 
 ml10.codice_attivita as codice_prodotto_specie, 
 case when registrabili then 'x' else '' end as registrati, 
 case when riconoscibili then 'x' else '' end as riconosciuti, 
 case when fisso then 'x' else '' end as sede_fissa, 
 case when mobile then 'x' else '' end as sede_mobile,
 'No-SCIA' as procedura_amministrativa, 
 '' as scheda_supplementare, 
 '' as cat_ex_ante, 
 case when categorizzabili then 'x' else '' end as categorizzabili,
 '' as attivita_specifica_attributi, 
 '' as codice_nazionale_richiesto,
 '' as tipo, 
 case when apicoltura then 'x' else '' end as apicoltura , 
 case when sintesis then 'x' else '' end as gestiti_sintesis, 
case when bdu then 'x' else '' end as propagati_bdu, 
case when vam then 'x' else '' end as propagati_vam, 
case when sinac then 'x' else '' end as propagati_sinac, 
'' as note, 
'' as gestione_dati_aggiuntivi,
case when no_scia then 'x' else '' end as no_scia
 from ml8_linee_attivita_nuove_materializzata ml10
 JOIN opu_lookup_norme_master_list norme on norme.code = ml10.id_norma
join master_list_flag_linee_attivita flag on flag.id_linea = ml10.id_nuova_linea_attivita
where flag.no_scia and (ml10.rev = 10)
and flag.codice_univoco not in ('MG-OSMM-M29',
'MG-OSMM-M31',
'MG-OSMM-M32',
'MG-OSMM-M33',
'MG-OSMM-M34',
'MR-OSMM-M30',
'MR-OSMM-M31')



update masterlist11 set norma = 'Altra normativa' where norma = 'ALTRA NORMATIVA';
update masterlist11 set codice_norma = 'Altro' where codice_norma = 'ALTRA NORMATIVA';-- ci sta solo SINTESIS
--select distinct codice_nazionale_richiesto from masterlist11 where codice_nazionale_richiesto <> '' --241
-- si devono recuperare anche gli altri valori? Se sì, ci sta lo script di update da lanciare e che ora è commentato
--select distinct codice_nazionale_richiesto from master_list_linea_attivita where codice_nazionale_richiesto <> '' and rev=10 --241
-- select 'update masterlist11 set codice_nazionale_richiesto  = '''||codice_nazionale_richiesto||''' where codice_univoco = '''||codice_univoco||''';', 
--codice_univoco from master_list_linea_attivita  where codice_nazionale_richiesto <> '' and rev=10;
*/

DROP FUNCTION import_master_list(integer);
CREATE OR REPLACE FUNCTION public.import_master_list(IN _rev integer)
  RETURNS TABLE(_norma text, _codice_norma text, _codice_sezione text, _macroarea text, _codice_attivita text, 
				_codice_prodotto_specie text, _aggregazione text, _linea_attivita text, _codice_univoco text, 
				_procedura_amministrativa text, 
				_codice_nazionale_richiesto text, 
				_scheda_supplementare text, _tipo text, 
				_mobile text, _fisso text, _apicoltura text, 
				_registrati text, _riconosciuti text, 
				_gestiti_sintesis text, _propagati_bdu text, 
				_propagati_vam text, _propagati_sinac text,
				_categorizzabili text, 
				_no_scia text, _cat_ex_ante text) AS
$BODY$
DECLARE

tot integer;
curr_index integer;
_id_macroarea integer;
_id_aggregazione integer;
_id_linea integer;

BEGIN

tot := 0;
curr_index := 0;

for
  _norma , --ok
  _codice_norma , --ok
  _codice_sezione , --ok
  _macroarea , --ok
  _codice_attivita , --ok
  _codice_prodotto_specie , --ok
  _aggregazione , --ok
  _linea_attivita , --ok
  _codice_univoco ,--ok
  _procedura_amministrativa , --ok (diventa nota in linea_attivita)
  _codice_nazionale_richiesto , --ok
  _scheda_supplementare , --ok
  _tipo , --ok
  _mobile , --ok
  _fisso , --ok
  _apicoltura ,--ok
  _registrati ,--ok
  _riconosciuti , --ok
  _gestiti_sintesis , --ok
  _propagati_bdu ,--ok
  _propagati_vam ,--ok
  _propagati_sinac, 
  _categorizzabili , --ok
  _no_scia, 
  _cat_ex_ante --ok,
in
select 
  norma ,
  codice_norma ,
  codice_sezione ,
  macroarea ,
  codice_attivita ,
  codice_prodotto_specie ,
  aggregazione ,
  linea_attivita ,
  codice_univoco ,
  procedura_amministrativa ,
  codice_nazionale_richiesto ,
  scheda_supplementare ,
  tipo ,
  sede_mobile ,
  sede_fissa ,
  apicoltura ,
  registrati ,
  riconosciuti ,
  gestiti_sintesis ,
  propagati_bdu ,
  propagati_vam ,
  propagati_sinac,
  categorizzabili,
  no_scia,
  cat_ex_ante from masterlist11 where 1=1

loop

curr_index := curr_index+1;
 raise info '--------------------------------------------------------------------------------------------------------';
 raise info '------------------------------------- [IMPORT IN CORSO] %-------------------------------------', curr_index;
 raise info '--------------------------------------------------------------------------------------------------------';


-- inserimento macroarea
--insert into master_list_macroarea (codice_sezione, codice_norma, norma, macroarea, entered, enteredby, rev)  values (_codice_sezione, _codice_norma, _norma,_macroarea,now(),6567,_rev) returning id into id_macroarea; 

SELECT id into _id_macroarea FROM master_list_macroarea where rev = _rev AND codice_sezione = _codice_sezione AND id_norma = (select code from opu_lookup_norme_master_list where trim(codice_norma) ilike trim(_codice_norma) and enabled);

IF _id_macroarea IS NULL OR _id_macroarea <=0 THEN

insert into master_list_macroarea (codice_sezione, codice_norma, norma, id_norma, macroarea, entered, enteredby, rev)  values (_codice_sezione, _codice_norma, _norma, 
(select code from opu_lookup_norme_master_list where trim(codice_norma) ilike trim(_codice_norma) and enabled), _macroarea,now(),6567,_rev) returning id into _id_macroarea;

END IF;

raise info 'id macroarea: %', _id_macroarea;

-- inserimento aggregazione

SELECT id into _id_aggregazione FROM master_list_aggregazione where rev = _rev AND codice_attivita = _codice_attivita AND id_macroarea = _id_macroarea;

IF _id_aggregazione IS NULL OR _id_aggregazione <=0 THEN

insert into master_list_aggregazione(codice_attivita, aggregazione, id_macroarea,entered, enteredby, rev)  values (_codice_attivita, _aggregazione, _id_macroarea, now(),6567,_rev) returning id into _id_aggregazione ;

END IF;

raise info 'id aggregazione: %', _id_aggregazione;

-- inserimento linea
insert into master_list_linea_attivita (codice_prodotto_specie, linea_attivita, tipo, scheda_supplementare, note, codice_univoco, codice_nazionale_richiesto, id_aggregazione,entered, enteredby, rev) 
values (_codice_prodotto_specie, _linea_attivita, _tipo, _scheda_supplementare, _procedura_amministrativa, _codice_univoco, _codice_nazionale_richiesto, _id_aggregazione, now(),6567,_rev ) returning id into _id_linea ;

 raise info 'id linea: %', _id_linea;

-- saltiamo insert per allegati
-- saltiamo insert per livelli aggiuntivi
-- inserimento flag manca la definizione dell'operatore al mercato e no scia - default false
insert into master_list_flag_linee_attivita (codice_univoco, mobile, fisso, apicoltura, registrabili, riconoscibili, sintesis, bdu, vam, categorizzabili, no_scia, categoria_rischio_default, entered, enteredby, rev,id_linea, 
mercato,operatore_mercato) values 
(concat_ws('-', _codice_sezione, _codice_attivita, _codice_prodotto_specie), 
case when _mobile ilike 'x' then true 
else false end, 
case when _fisso ilike 'x' then true 
else false end,
case when _apicoltura ilike 'x' then true 
else false end,
case when _registrati ilike 'x' then true 
else false end,
case when _riconosciuti ilike 'x' then true 
else false end,
case when _gestiti_sintesis ilike 'x' then true 
else false end,
case when _propagati_bdu ilike 'x' then true 
else false end,
case when _propagati_vam ilike 'x' then true 
else false end,
case when _categorizzabili ilike 'x' then true 
else false end,
case when _no_scia ilike 'x' then true 
else false end,
case when _cat_ex_ante='1' then 1
 when _cat_ex_ante='2' then 2
 when _cat_ex_ante='3' then 3
 when _cat_ex_ante='4' then 4
 when _cat_ex_ante='5' then 5
else null end,
now(),6567,_rev,_id_linea,
case when concat_ws('-', _codice_sezione, _codice_attivita, _codice_prodotto_specie)  = 'MS.B-MS.B00-MS.B00.300' or concat_ws('-', _codice_sezione, _codice_attivita, _codice_prodotto_specie) = 'MS.B-MS.B80-MS.B80.600' then true end,
 -- new 07/12
case when concat_ws('-', _codice_sezione, _codice_attivita, _codice_prodotto_specie)  = 'COM-COMING-OPMERC' then true end-- new 07/12
);

   
end loop;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.import_master_list(integer)
  OWNER TO postgres;

select * from import_master_list(11)
-- View: public.master_list_view

-- 
CREATE OR REPLACE VIEW public.master_list_view 
 AS
 SELECT master_list_macroarea.id AS id_nuova_linea_attivita,
    true AS enabled,
    master_list_macroarea.id AS id_macroarea,
    NULL::integer AS id_aggregazione,
    NULL::integer AS id_attivita,
    master_list_macroarea.codice_sezione AS codice_macroarea,
    ''::text AS codice_aggregazione,
    ''::text AS codice_attivita,
    master_list_macroarea.macroarea,
    ''::text AS aggregazione,
    ''::text AS attivita,
    master_list_macroarea.id_norma,
    master_list_macroarea.norma,
    master_list_macroarea.macroarea AS descrizione,
    1 AS livello,
    '-1'::integer AS id_padre,
    '-1'::character varying(1000) AS path_id,
    master_list_macroarea.macroarea::character varying(1000) AS path_desc,
    master_list_macroarea.codice_sezione AS codice,
    master_list_macroarea.codice_sezione::character varying(1000) AS path_codice,
    false AS consenti_valori_multipli,
    master_list_macroarea.codice_norma
   FROM master_list_macroarea
     LEFT JOIN opu_lookup_norme_master_list norme ON norme.code = master_list_macroarea.id_norma
  WHERE master_list_macroarea.trashed_date IS NULL AND master_list_macroarea.rev = 11
UNION ALL
 SELECT t.id AS id_nuova_linea_attivita,
    true AS enabled,
    t.id_macroarea,
    t.id AS id_aggregazione,
    NULL::integer AS id_attivita,
    rt.codice_sezione AS codice_macroarea,
    t.codice_attivita AS codice_aggregazione,
    ''::text AS codice_attivita,
    rt.macroarea,
    t.aggregazione,
    ''::text AS attivita,
    rt.id_norma,
    rt.norma,
    t.aggregazione AS descrizione,
    2 AS livello,
    t.id_macroarea AS id_padre,
    (((rt.id::text || ';'::text) || t.id))::character varying(1000) AS path_id,
    (((rt.macroarea || '->'::text) || t.aggregazione))::character varying(1000) AS path_desc,
    t.codice_attivita AS codice,
    (((rt.codice_sezione || '->'::text) || t.codice_attivita))::character varying(1000) AS path_codice,
    false AS consenti_valori_multipli,
    rt.codice_norma
   FROM master_list_aggregazione t
     JOIN master_list_macroarea rt ON rt.id = t.id_macroarea
     LEFT JOIN opu_lookup_norme_master_list norme2 ON norme2.code = rt.id_norma
  WHERE t.trashed_date IS NULL AND rt.trashed_date IS NULL AND rt.rev = 11 AND t.rev = 11
UNION ALL
 SELECT a.id AS id_nuova_linea_attivita,
    true AS enabled,
    rt3.id AS id_macroarea,
    rt2.id AS id_aggregazione,
    a.id AS id_attivita,
    rt3.codice_sezione AS codice_macroarea,
    rt2.codice_attivita AS codice_aggregazione,
    a.codice_prodotto_specie AS codice_attivita,
    rt3.macroarea,
    rt2.aggregazione,
    a.linea_attivita AS attivita,
    rt3.id_norma,
    norme3.codice_norma AS norma,
    a.linea_attivita AS descrizione,
    3 AS livello,
    a.id_aggregazione AS id_padre,
    ((((rt3.id::text || ';'::text) || (rt2.id::text || ';'::text)) || a.id))::character varying(1000) AS path_id,
    ((((rt3.macroarea || '->'::text) || (rt2.aggregazione || '->'::text)) || a.linea_attivita))::character varying(1000) AS path_desc,
    concat_ws('-'::text, rt3.codice_sezione, rt2.codice_attivita, a.codice_prodotto_specie) AS codice,
	--a.codice_univoco as codice, 
    ((((rt3.codice_sezione || '->'::text) || (rt2.codice_attivita || '->'::text)) || a.codice_prodotto_specie))::character varying(1000) AS path_codice,
    a.consenti_valori_multipli,
    rt3.codice_norma
   FROM master_list_linea_attivita a
     JOIN master_list_aggregazione rt2 ON rt2.id = a.id_aggregazione
     JOIN master_list_macroarea rt3 ON rt3.id = rt2.id_macroarea
     LEFT JOIN opu_lookup_norme_master_list norme3 ON norme3.code = rt3.id_norma
  WHERE a.trashed_date IS NULL AND rt2.trashed_date IS NULL AND rt3.trashed_date IS NULL AND a.rev = 11 AND rt2.rev = 11 AND rt3.rev = 11;

ALTER TABLE public.master_list_view
    OWNER TO postgres;


 CREATE OR REPLACE FUNCTION public.refresh_ml_materializzata(IN _id_linea integer default null::integer)
  RETURNS integer AS
$BODY$
DECLARE
BEGIN

delete from ml8_linee_attivita_nuove_materializzata where 1=1 
-- solo le nuove linee 
and id_nuova_linea_attivita in (select id_nuova_linea_attivita from master_list_view)
and (null is null or id_nuova_linea_attivita = null);

insert into ml8_linee_attivita_nuove_materializzata (
 id_nuova_linea_attivita, enabled, id_macroarea, id_aggregazione, id_attivita, codice_macroarea, codice_aggregazione, codice_attivita, macroarea, aggregazione,
 attivita, id_norma, norma, codice_norma, descrizione, livello, id_padre, path_id, path_descrizione, codice, path_codice,rev
) select id_nuova_linea_attivita, enabled, id_macroarea, id_aggregazione, id_attivita, codice_macroarea, codice_aggregazione, codice_attivita, macroarea, aggregazione,
 attivita, id_norma, norma, codice_norma, descrizione, livello, id_padre, path_id, path_desc, codice, path_codice, 11 as rev from master_list_view 
 where 1=1
 and (_id_linea is null or id_nuova_linea_attivita = _id_linea);

return 1;

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.refresh_ml_materializzata(integer)
  OWNER TO postgres;
  
  

-- procedura rollback
--delete from masterlist11;
--delete from master_list_macroarea where rev=11;
--delete from master_list_aggregazione where rev=11;
--delete from master_list_linea_attivita where rev=11;
--delete from master_list_flag_linee_attivita where rev=11;
--delete from ml8_linee_attivita_nuove_materializzata where rev=11;

--select distinct 'update master_list_flag_linee_attivita set visibilita_asl='||ml10.visibilita_asl||', visibilita_regione = '||ml10.visibilita_regione||' where rev=11 and codice_univoco='''||ml10.codice_univoco||''';'
--from master_list_flag_linee_attivita ml11
--join master_list_flag_linee_attivita ml10 on ml10.codice_univoco = ml11.codice_univoco
--where ml10.rev=10;

update master_list_flag_linee_attivita set visibilita_asl=true where registrabili = true and rev=11 and (visibilita_regione is null and visibilita_asl is null);
update master_list_flag_linee_attivita set visibilita_regione=true where riconoscibili = true and rev=11 and (visibilita_regione is null and visibilita_asl is null);

------------------- aggiunta del distintivo rev11 per testing ------------------------------------
--update master_list_macroarea set macroarea=concat('(rev11) ',macroarea) where rev=11;
--update master_list_aggregazione set aggregazione=concat('(rev11) ',aggregazione) where rev=11;
--update master_list_linea_attivita set linea_attivita=concat('(rev11) ',linea_attivita) where rev=11;
select * from refresh_ml_materializzata(null);

-- aggiunta per gestione dati aggiuntivi (escludo le linee bdu per flusso 336)
select distinct id_linea from linee_mobili_html_fields where enabled
select distinct codice_univoco from master_list_flag_linee_attivita where id_linea in (select distinct id_linea from linee_mobili_html_fields where enabled)
-- ho escluso poi tutte quelle di bdu
select distinct codice_univoco from master_list_flag_linee_attivita where id_linea in (select distinct id_linea from linee_mobili_html_fields where enabled) 
and rev=11 

select distinct 'insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = '''||codice_univoco||''' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = '''||codice_univoco||''' and rev=10) and enabled;'
from master_list_flag_linee_attivita 
where codice_univoco in (
'1069-R-37-TRANS',
'MS.090-TCT-T',
'CG-NAZ-E-005',
'CG-NAZ-R-003',
'CG-NAZ-E-004',
'1069-R-39-TRANS',
'MS.020-MS.020.300-852IT3A201',
'MS.020-43-023',
'MS.020-MS.020.100-852IT3A001',
'MG-DG-M20',
'CG-NAZ-P-0121',
'MS.020-MS.020.200-852IT3A102',
'CG-NAZ-E-007',
'CG-NAZ-D-0126',
'MS.020-MS.020.200-852IT3A101',
'MS.060-MS.060.400-852IT7A302',
'CG-NAZ-E-008',
'MS.020-MS.020.400-852IT3A301',
'CG-NAZ-R-007',
'CG-EST-B-0124',
'CG-NAZ-E-009',
'CG-NAZ-P-0122',
'CG-NAZ-V-0127',
'1069-R-38-TRANS',
'CG-NAZ-E-006',
'MS.060-MS.060.400-852IT7A301',
'CG-NAZ-B',
'MS.090-MS.090.100-852ITAA003',
'MS.020-MS.020.500-852IT3A401',
'CG-NAZ-V-0126')
order by bdu, vam

------------- eseguire queste
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = '1069-R-38-TRANS' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = '1069-R-38-TRANS' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-B' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-B' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.200-852IT3A102' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.200-852IT3A102' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-006' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-006' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = '1069-R-39-TRANS' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = '1069-R-39-TRANS' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.300-852IT3A201' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.300-852IT3A201' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-R-007' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-R-007' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.500-852IT3A401' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.500-852IT3A401' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.090-MS.090.100-852ITAA003' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.090-MS.090.100-852ITAA003' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MG-DG-M20' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MG-DG-M20' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-EST-B-0124' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-EST-B-0124' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-43-023' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-43-023' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-P-0121' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-P-0121' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.090-TCT-T' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.090-TCT-T' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-009' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-009' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-R-003' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-R-003' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-004' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-004' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-005' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-005' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-007' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-007' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-V-0127' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-V-0127' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.060-MS.060.400-852IT7A301' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.060-MS.060.400-852IT7A301' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = '1069-R-37-TRANS' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = '1069-R-37-TRANS' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-V-0126' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-V-0126' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.100-852IT3A001' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.100-852IT3A001' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.400-852IT3A301' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.400-852IT3A301' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-D-0126' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-D-0126' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.060-MS.060.400-852IT7A302' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.060-MS.060.400-852IT7A302' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-008' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-E-008' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-P-0122' and rev=11),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=(select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'CG-NAZ-P-0122' and rev=10) and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select 41268,--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=40623
and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select 41269,
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=40624
and enabled;
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select 41270,--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=40625
and enabled;

/*
insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.200-852IT3A101' and rev=11 and id_nuova_linea_attivita=41268),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=40623 and enabled;

insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.200-852IT3A101' and rev=11 and id_nuova_linea_attivita=41269),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=40624 and enabled;

insert into linee_mobili_html_fields(id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly)
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice  = 'MS.020-MS.020.200-852IT3A101' and rev=11 and id_nuova_linea_attivita=41270),--dev 
nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, 
only_hd, label_link, l.enabled, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, maxlength, multiple, gestione_interna,ordine,readonly
from linee_mobili_html_fields l 
where l.id_linea=40625 and enabled;*/

-- operatore_mercato a false
update master_list_flag_linee_attivita set operatore_mercato=false where operatore_mercato is not true;
select * from refresh_ml_materializzata(null);

 update master_list_flag_linee_attivita set visibilita_regione=false where rev=11 and visibilita_regione is not true;
update master_list_flag_linee_attivita set visibilita_asl=false where rev=11 and visibilita_asl is not true;

-- Recupero categoria di rischio null a parità di codice univoco 
select distinct 'update master_list_flag_linee_attivita set categoria_rischio_default ='||m10.categoria_rischio_default||' where codice_univoco='''||m11.codice_univoco||''' and rev=11;', m10.codice_univoco, m11.codice_univoco
from 
master_list_flag_linee_attivita m11 
join master_list_flag_linee_attivita m10 on m10.codice_univoco = m11.codice_univoco 
where m11.rev=11 and m11.categorizzabili and 
m11.categoria_rischio_default is null and m10.categorizzabili and m10.categoria_rischio_default > 0

update master_list_flag_linee_attivita set categoria_rischio_default = 2 where codice_univoco in ('COM-COMING-OPMERC',
'MG-OSMM-M32'
'MG-OSMM-M34') and rev=11

update master_list_flag_linee_attivita set categoria_rischio_default = 2 where no_scia=true and rev=10 and categoria_rischio_default is null
-- FUNCTION: public.get_linea_attivita_noscia()

-- DROP FUNCTION IF EXISTS public.get_linea_attivita_noscia();

CREATE OR REPLACE FUNCTION public.get_linea_attivita_noscia(
	)
    RETURNS TABLE(codice_attivita text, path_descrizione text, description text) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

	select ml8.codice, upper(concat(ln.description, '-> ', ml8.path_descrizione)) path_descrizione , ln.description
		from ml8_linee_attivita_nuove_materializzata ml8 
			join master_list_flag_linee_attivita mlf on mlf.id_linea = ml8.id_nuova_linea_attivita 
			join opu_lookup_norme_master_list ln on code = ml8.id_norma
		where mlf.no_scia = true and mlf.operatore_mercato is not true and mlf.rev = (select max(rev) from master_list_flag_linee_attivita )
		and mlf.trashed is null
		order by path_descrizione;
$BODY$;

ALTER FUNCTION public.get_linea_attivita_noscia()
    OWNER TO postgres;

    insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, only_hd, obbligatorio, gestione_interna, ordine, enabled, readonly, codice_raggruppamento)
select id_nuova_linea_attivita, 'senza_glutine', 'checkbox','Produce alimenti senza glutine', 0, true, false, 1, true, false, 'CONGLUGLU' from ml8_linee_attivita_nuove_materializzata where rev = 11 and path_descrizione ilike '%PANIFICIO CON CONSUMO DI FARINA GIORNALIERO%' and livello = 3

-- FUNCTION: public.is_linea_presente_opu(integer, integer)

-- DROP FUNCTION IF EXISTS public.is_linea_presente_opu(integer, integer);

CREATE OR REPLACE FUNCTION public.is_linea_presente_opu(
	_id_linea integer,
	_id_stabilimento integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE  

_presente boolean; 
_descrizionelineanuova text;
_descrizionelineapresente text;

BEGIN 

_presente := false;
_descrizionelineapresente := '';

select replace(trim(concat(ml8.macroarea, ml8.aggregazione, ml8.attivita)), ' ', '') into _descrizionelineanuova from ml8_linee_attivita_nuove_materializzata ml8 where ml8.id_nuova_linea_attivita = _id_linea;

SELECT linea into _descrizionelineapresente FROM (
select replace(trim(concat(ml8.macroarea, ml8.aggregazione, ml8.attivita)), ' ', '') as linea from opu_relazione_stabilimento_linee_produttive rel
join ml8_linee_attivita_nuove_materializzata ml8 on ml8.id_nuova_linea_attivita = rel.id_linea_produttiva
where rel.id_stabilimento = _id_stabilimento and rel.enabled
) aa where aa.linea ilike _descrizionelineanuova;

IF length(_descrizionelineapresente) > 0 THEN
_presente := true;
ELSE
_presente := false;
END IF;

RETURN _presente;

END 
$BODY$;

ALTER FUNCTION public.is_linea_presente_opu(integer, integer)
    OWNER TO postgres;
    
-- se non sono escluse a priori, lanciare questi update!
/*    
delete from master_list_linea_attivita where trashed_date is not null;
delete from master_list_flag_linee_attivita where id_linea not in (select id from master_list_linea_attivita);
delete from ml8_linee_attivita_nuove_materializzata where livello = 3 and id_nuova_linea_attivita > 0 and id_nuova_linea_attivita not in (select id from  master_list_linea_attivita);
select * from refresh_ml_materializzata();
*/
    

CREATE TABLE IF NOT EXISTS cl_23.sorv_parametrizzazioni_categoria
(
    id serial,
    range_da integer,
    range_a integer,
    categoria integer,
    enabled boolean DEFAULT true
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.sorv_parametrizzazioni_categoria
    OWNER to postgres;


insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (0,112,1,true);

insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (113,150,2,true);

insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (151,188,3,true);

insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (189,225,4,true);

insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (226,NULL,5,true);
    
