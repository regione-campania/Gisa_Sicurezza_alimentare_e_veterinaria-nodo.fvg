
CREATE OR REPLACE FUNCTION digemon.ocse_estrazione_controlli_ispezione_semplice(
    IN _data_1 timestamp without time zone DEFAULT '1900-01-01 00:00:00'::timestamp without time zone,
    IN _data_2 timestamp without time zone DEFAULT NULL::timestamp without time zone)
  RETURNS TABLE(id_controllo_ufficiale text, id_asl integer, asl text, norma text, numero_registrazione text, numero_riconoscimento text, codice_macroarea text, codice_aggregazione text, codice_attivita text, 
  macroarea_sottoposta_a_controllo text, aggregazione_sottoposta_a_controllo text, linea_attivita_sottoposta_a_controllo text, categoria_rischio_campana text, tipo_categorizzazione text, categoria_rischio_nazionale text, id_checklist text,
  tipo_controllo text, punteggio_totale_controllo integer, data_inizio_controllo timestamp without time zone, anno_controllo integer, ruoli_componente_nucleo text, tipo_non_conformita text, oggetto_non_conformita text, 
  provincia_stab text, comune text, puntiformali text, puntisignificativi text, puntigravi text, num_sanzioni_intraprese integer, num_sequestri_intrapresi integer, num_reati_intrapresi integer,data_inizio_attivita timestamp without time zone) AS
$BODY$
DECLARE
BEGIN
RETURN QUERY
	select distinct 
  (select * from anon_get_controllo(a.id_controllo, a.id_asl)) as id_controllo_ufficiale,
 a.id_asl,
  case 
	when a.id_asl = '201' then 'Avellino'
	when a.id_asl = '202' then 'Benevento'
	when a.id_asl = '203' then 'Caserta'
	when a.id_asl = '204' then 'Napoli 1 Centro'
	when a.id_asl = '205' then 'Napoli 2 Nord'
	when a.id_asl = '206' then 'Napoli 3 Sud'
	when a.id_asl = '207' then 'Salerno'
	end
  as asl,
  case 
	when norma_lda.codice_norma ilike '%853%' then '853-04'
	when norma_lda.codice_norma ilike '%852%' then '852-04'
	end 
  as norma,
	case 
	when a.riferimento_nome_tab = 'opu_stabilimento' then (select * from anon_get_num_registrazione(lda.n_linea))
	end 
  as numero_registrazione,
	case 
	when a.riferimento_nome_tab = 'sintesis_stabilimento' then (select * from anon_get_num_riconoscimento(lda. num_riconoscimento))
	end 
  as numero_riconoscimento,
  lda.codice_macroarea,  lda.codice_aggregazione,  lda.codice_attivita,  
  lda.macroarea as macroarea_sottoposta_a_controllo,  lda.aggregazione as aggregazione_sottoposta_a_controllo,  
  lda.attivita as linea_attivita_sottoposta_a_controllo,
   'NA' as categoria_rischio_campana,
   'NA' as tipo_categorizzazione,
   'NA' as categoria_rischio_nazionale,
   'NA' as ID_checklist,
   'Ispezione Semplice' as tipo_controllo,
    case 
	when (a.punteggio < 0 or a.punteggio is null) then '0'
	else a.punteggio 
	end
	as punteggio_totale_controllo,a.data_inizio_controllo, 
	date_part('years',a.data_inizio_controllo)::int as anno_controllo,
   concat_ws(';',ni.nucleo_ispettivo,ni.nucleo_ispettivo_due,ni.nucleo_ispettivo_tre,ni.nucleo_ispettivo_quattro,
   ni.nucleo_ispettivo_cinque,ni.nucleo_ispettivo_sei,ni.nucleo_ispettivo_sette,ni.nucleo_ispettivo_otto,ni.nucleo_ispettivo_nove,ni.nucleo_ispettivo_dieci) as ruoli_componente_nucleo,
    case
	when nc.tipo_non_conformita is null then 'NESSUNA NC RILEVATA'
	else nc.tipo_non_conformita
    end as tipo_non_conformita, 
    nc.oggetto_non_conformita,
    osa.provincia_stab,
    (select * from anon_get_comune(com.id)) as comune,
    nc.puntiformali,
    nc.puntisignificativi, 
    nc.puntigravi, 
    nc.num_sanzioni_intraprese, 
    nc.num_sequestri_intrapresi, 
    nc.num_reati_intrapresi,
    lda.data_inizio_attivita
 
from digemon.get_controlli_ispezioni_semplici(null, _data_1, _data_2, true) a
join 
(select * from digemon.dbi_get_all_stabilimenti_('1900-01-01', _data_2)) osa on a.riferimento_id = osa.riferimento_id
join digemon.dbi_get_all_linee('1900-01-01', _data_2) lda on (a.riferimento_id = lda.riferimento_id)
join
(select * from digemon.get_linee_attivita_controllo_list(_data_1,_data_2,'{4}'::int[])) d on d.id_controllo = a.id_controllo 
left join ml8_linee_attivita_nuove_materializzata norma_lda on (d.codice_linea = norma_lda.codice )
join nucleo_ispettivo_mv ni on ( a.id_controllo = ni.id_controllo_ufficiale )
join comuni1 com on (com.nome = osa.comune and com.id > 0)
left join
(select * from digemon.dbi_get_non_conformita(_data_1, _data_2)) nc on a.id_controllo = nc.id_controllo_ufficiale
where a.riferimento_nome_tab in ('sintesis_stabilimento', 'opu_stabilimento') 
and a.id_asl in (201,202,203,204,205,206,207) and norma_lda.codice_norma in ('852-04','853-04') 
and norma_lda.id_lookup_tipo_attivita <> 2 
and d.codice_linea = (lda.codice_macroarea||'-'||lda.codice_aggregazione||'-'||lda.codice_attivita) 
order by id_asl, id_controllo_ufficiale;

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION digemon.ocse_estrazione_controlli_ispezione_semplice(timestamp without time zone, timestamp without time zone)
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION digemon.ocse_estrazione_controlli_audit(
    IN _data_1 timestamp without time zone DEFAULT '1900-01-01 00:00:00'::timestamp without time zone,
    IN _data_2 timestamp without time zone DEFAULT NULL::timestamp without time zone)
  RETURNS TABLE(id_controllo_ufficiale text, id_asl integer, asl text, norma text, numero_registrazione text, numero_riconoscimento text, codice_macroarea text, codice_aggregazione text, codice_attivita text, 
  macroarea_sottoposta_a_controllo text, aggregazione_sottoposta_a_controllo text, linea_attivita_sottoposta_a_controllo text, categoria_rischio_campana text, tipo_categorizzazione text, categoria_rischio_nazionale text, 
  id_checklist text, tipo_controllo text, punteggio_totale_controllo integer, data_inizio_controllo timestamp without time zone, anno_controllo integer, ruoli_componente_nucleo text, tipo_non_conformita text, oggetto_non_conformita text, 
  provincia_stab text, comune text, puntiformali text, puntisignificativi text, puntigravi text, num_sanzioni_intraprese integer, num_sequestri_intrapresi integer, num_reati_intrapresi integer,data_inizio_attivita timestamp without time zone) AS
$BODY$
DECLARE
BEGIN
RETURN QUERY
	select distinct 
 (select * from anon_get_controllo(a.id_controllo, a.id_asl)) as id_controllo_ufficiale,
 a.id_asl,
  case 
	when a.id_asl = '201' then 'Avellino'
	when a.id_asl = '202' then 'Benevento'
	when a.id_asl = '203' then 'Caserta'
	when a.id_asl = '204' then 'Napoli 1 Centro'
	when a.id_asl = '205' then 'Napoli 2 Nord'
	when a.id_asl = '206' then 'Napoli 3 Sud'
	when a.id_asl = '207' then 'Salerno'
	end
  as asl,
  case 
	when norma_lda.codice_norma ilike '%853%' then '853-04'
	when norma_lda.codice_norma ilike '%852%' then '852-04'
	end 
  as norma,
  a.riferimento_id||'.'||
	case 
	when a.riferimento_nome_tab = 'opu_stabilimento' then (select * from anon_get_num_registrazione(lda.n_linea))
	end 
  as numero_registrazione,
  a.riferimento_id||'.'||
	case 
	when a.riferimento_nome_tab = 'sintesis_stabilimento' then (select * from anon_get_num_riconoscimento(lda. num_riconoscimento))
	end 
  as numero_riconoscimento,
  lda.codice_macroarea,  lda.codice_aggregazione,  lda.codice_attivita,  
  lda.macroarea as macroarea_sottoposta_a_controllo,  lda.aggregazione as aggregazione_sottoposta_a_controllo,  
  lda.attivita as linea_attivita_sottoposta_a_controllo,

   'NA' as categoria_rischio_campana,
   'NA' as tipo_categorizzazione,
   'NA' as categoria_rischio_nazionale,
   'NA' as ID_checklist,
   'Ispezione Semplice' as tipo_controllo,
    case 
	when (a.punteggio < 0 or a.punteggio is null) then '0'
	else a.punteggio 
	end
	as punteggio_totale_controllo,a.data_inizio_controllo, 
	date_part('years',a.data_inizio_controllo)::int as anno_controllo,
   concat_ws(';',ni.nucleo_ispettivo,ni.nucleo_ispettivo_due,ni.nucleo_ispettivo_tre,ni.nucleo_ispettivo_quattro,
   ni.nucleo_ispettivo_cinque,ni.nucleo_ispettivo_sei,ni.nucleo_ispettivo_sette,ni.nucleo_ispettivo_otto,ni.nucleo_ispettivo_nove,ni.nucleo_ispettivo_dieci) as ruoli_componente_nucleo,
    case
	when nc.tipo_non_conformita is null then 'NESSUNA NC RILEVATA'
	else nc.tipo_non_conformita
    end as tipo_non_conformita, 
    nc.oggetto_non_conformita,
    osa.provincia_stab,
    (select * from anon_get_comune(com.id)) as comune,
    nc.puntiformali,
    nc.puntisignificativi, 
    nc.puntigravi, 
    nc.num_sanzioni_intraprese, 
    nc.num_sequestri_intrapresi, 
    nc.num_reati_intrapresi,
    lda.data_inizio_attivita
 
from digemon.get_controlli_audit(null, _data_1, _data_2, true) a
join 
(select * from digemon.dbi_get_all_stabilimenti_('1900-01-01', _data_2)) osa on a.riferimento_id = osa.riferimento_id
join digemon.dbi_get_all_linee('1900-01-01', _data_2) lda on (a.riferimento_id = lda.riferimento_id)
join
(select * from digemon.get_linee_attivita_controllo_list(_data_1, _data_2,'{3}'::int[])) d on d.id_controllo = a.id_controllo 
left join ml8_linee_attivita_nuove_materializzata norma_lda on (d.codice_linea = norma_lda.codice )
join nucleo_ispettivo_mv ni on ( a.id_controllo = ni.id_controllo_ufficiale )
join comuni1 com on (com.nome = osa.comune and com.id > 0)
left join
(select * from digemon.dbi_get_non_conformita(_data_1, _data_2)) nc on a.id_controllo = nc.id_controllo_ufficiale
where a.riferimento_nome_tab in ('sintesis_stabilimento', 'opu_stabilimento') 
and a.id_asl in (201,202,203,204,205,206,207) and norma_lda.codice_norma in ('852-04','853-04') 
and norma_lda.id_lookup_tipo_attivita <> 2 
and d.codice_linea = (lda.codice_macroarea||'-'||lda.codice_aggregazione||'-'||lda.codice_attivita) 
order by id_asl, id_controllo_ufficiale;

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION digemon.ocse_estrazione_controlli_audit(timestamp without time zone, timestamp without time zone)
  OWNER TO postgres;

  
CREATE OR REPLACE FUNCTION digemon.ocse_estrazione_controlli_sorveglianza(
    IN _data_1 timestamp without time zone DEFAULT '1900-01-01 00:00:00'::timestamp without time zone,
    IN _data_2 timestamp without time zone DEFAULT NULL::timestamp without time zone)
  RETURNS TABLE(id_controllo_ufficiale text, id_asl integer, asl text, norma text, numero_registrazione text, numero_riconoscimento text, codice_linea_controllo text, codice_macroarea text, codice_aggregazione text, codice_attivita text, 
  macroarea_sottoposta_a_controllo text, aggregazione_sottoposta_a_controllo text, linea_attivita_sottoposta_a_controllo text, categoria_rischio_campana integer, tipo_categorizzazione text, categoria_rischio_nazionale text, 
  id_checklist integer, tipo_controllo text, punteggio_totale_controllo integer, data_inizio_controllo timestamp without time zone, anno_controllo integer, ruoli_componente_nucleo text, tipo_non_conformita text, oggetto_non_conformita text, 
  provincia_stab text, comune text, puntiformali text, puntisignificativi text, puntigravi text, num_sanzioni_intraprese integer, num_sequestri_intrapresi integer, num_reati_intrapresi integer,data_inizio_attivita timestamp without time zone) AS
$BODY$
DECLARE
BEGIN
RETURN QUERY
	select distinct 
  --reverse(cast(a.id_controllo as VARCHAR(10)))  as id_controllo_ufficiale,
 (select * from anon_get_controllo(a.id_controllo, a.id_asl)) as id_controllo_ufficiale,
 a.id_asl,
  case 
	when a.id_asl = '201' then 'Avellino'
	when a.id_asl = '202' then 'Benevento'
	when a.id_asl = '203' then 'Caserta'
	when a.id_asl = '204' then 'Napoli 1 Centro'
	when a.id_asl = '205' then 'Napoli 2 Nord'
	when a.id_asl = '206' then 'Napoli 3 Sud'
	when a.id_asl = '207' then 'Salerno'
	end
  as asl,
  case 
  	when lda.norma ilike '%853%' then '853-04'
	when lda.norma ilike '%852%' then '852-04'
	else 'NON COMPILATO'
	end 
  as norma,
  a.riferimento_id||'.'||
	case 
	when a.riferimento_nome_tab = 'opu_stabilimento' then (select * from anon_get_num_registrazione(lda.n_linea))
	end 
  as numero_registrazione,
  a.riferimento_id||'.'||
	case 
	when a.riferimento_nome_tab = 'sintesis_stabilimento' then (select * from anon_get_num_riconoscimento(lda. num_riconoscimento))
	end 
  as numero_riconoscimento,
  'NON COMPILATO' as codice_linea_controllo, 
  lda.codice_macroarea,  lda.codice_aggregazione,  lda.codice_attivita,  
  lda.macroarea as macroarea_sottoposta_a_controllo,  lda.aggregazione as aggregazione_sottoposta_a_controllo,  
  lda.attivita as linea_attivita_sottoposta_a_controllo,
    osa.categoria_rischio as categoria_rischio_campana,
    osa.tipo_categorizzazione,
    case 
	when (osa.categoria_rischio = 1 or osa.categoria_rischio = 2) then 'BASSA'
	when (osa.categoria_rischio = 3) then 'MEDIA'
	when (osa.categoria_rischio = 4 or osa.categoria_rischio = 5) then 'ALTA'
	else ''
	end
	as categoria_rischio_nazionale,
cc.num_chk as ID_checklist,
    'Ispezione con tecnica sorveglianza' as tipo_controllo,
    case 
	when (a.punteggio < 0 or a.punteggio is null) then '0'
	else a.punteggio 
	end
	as punteggio_totale_controllo,a.data_inizio_controllo, 
	date_part('years',current_timestamp)::int as anno_controllo,
  
    ni.nucleo_ispettivo||ni.nucleo_ispettivo_due||ni.nucleo_ispettivo_tre||ni.nucleo_ispettivo_quattro|| ni.nucleo_ispettivo_cinque||ni.nucleo_ispettivo_sei||ni.nucleo_ispettivo_sette||ni.nucleo_ispettivo_otto||ni.nucleo_ispettivo_nove||ni.nucleo_ispettivo_dieci as ruoli_componente_nucleo,
    case
	when nc.tipo_non_conformita is null then 'NESSUNA NC RILEVATA'
	else nc.tipo_non_conformita
    end as tipo_non_conformita, 
    nc.oggetto_non_conformita,
    osa.provincia_stab,
    --'com.'||reverse(cast(com.id as VARCHAR(10)))  as comune,
    (select * from anon_get_comune(com.id)) as comune,
    nc.puntiformali,
    nc.puntisignificativi, 
    nc.puntigravi, 
    nc.num_sanzioni_intraprese, 
    nc.num_sequestri_intrapresi, 
    nc.num_reati_intrapresi,
    lda.data_inizio_attivita

from digemon.get_controlli_sorveglianze(null, _data_1, _data_2, true) a
left join
(select * from digemon.get_checklist_sorveglianza_new()) cc on a.id_controllo = cc.id_controllo and cc.is_principale -- verificare se va bene solo la principale
left join
(select * from digemon.dbi_get_non_conformita(_data_1, _data_2)) nc on a.id_controllo = nc.id_controllo_ufficiale
join 
(select * from digemon.dbi_get_all_stabilimenti_('1900-01-01', _data_2)) osa on a.riferimento_id = osa.riferimento_id
left join digemon.dbi_get_all_linee('1900-01-01', _data_2) lda on (a.riferimento_id = lda.riferimento_id)
join nucleo_ispettivo_mv ni on ( a.id_controllo = ni.id_controllo_ufficiale )
join comuni1 com on (com.nome = osa.comune and com.id > 0)
where a.riferimento_nome_tab in ('sintesis_stabilimento', 'opu_stabilimento') 
and a.id_asl in (201,202,203,204,205,206,207) 
and lda.norma in ('REG CE 852-04','REG CE 853-04') 
and lda.tipo_attivita <> 2 
order by id_asl, id_controllo_ufficiale;

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION digemon.ocse_estrazione_controlli_sorveglianza(timestamp without time zone, timestamp without time zone)
  OWNER TO postgres;

  
CREATE OR REPLACE FUNCTION digemon.get_comuni(
    IN _id integer,
    IN _nome character varying,
    IN _cod_regione character varying,
    IN _id_provincia integer,
    IN _id_asl integer)
  RETURNS TABLE(id integer, cod_comune character varying, cod_regione character varying, cod_provincia integer, nome character varying, istat character varying, cap character varying, cod_nazione integer, id_asl integer) AS
$BODY$
 SELECT id,
    cod_comune, 
    cod_regione, 
    cod_provincia::integer,
    nome,
    istat,
    cap,
    cod_nazione,
    codiceistatasl::integer as _id_asl
from public.comuni1 c
where 
    (_id is null or c.id = _id) 
    and (_nome is null or c.nome ilike _nome || '%')
    and (_cod_regione is null or c.cod_regione ilike _cod_regione || '%')
    and (cod_provincia::integer is null or c.cod_provincia::integer = _id_provincia or _id_provincia is null)
    and (_id_asl is null or c.codiceistatasl::integer = _id_asl)
    and c.notused is not true

order by nome $BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION digemon.get_comuni(integer, character varying, character varying, integer, integer)
  OWNER TO postgres;

------------------------------ 07/11/2022 -> aggiornamento dbi oggetto del controllo
 
CREATE OR REPLACE FUNCTION digemon.get_controlli_ispezioni_semplici_oggetto_del_controllo(
    IN _data_1 timestamp without time zone DEFAULT '1900-01-01 00:00:00'::timestamp without time zone,
    IN _data_2 timestamp without time zone DEFAULT NULL::timestamp without time zone)
  RETURNS TABLE(id_controllo integer, id_oggetto_del_controllo integer, oggetto_del_controllo text, id_macrocategoria integer, descrizione_macrocategoria text) AS
$BODY$
DECLARE
BEGIN
for   
	id_controllo,
	id_oggetto_del_controllo,
	oggetto_del_controllo,
	id_macrocategoria,
	descrizione_macrocategoria
in select
	distinct t.ticketid as id_controllo,
	li.code as id_oggetto_del_controllo,
	case when (li.description::text) ilike 'altro' then concat_ws('-',concat(li.description,':'),t.note_altro,t.ispezioni_desc1, t.ispezioni_desc2,  
	t.ispezioni_desc3, t.ispezioni_desc4,t.ispezioni_desc5, t.ispezioni_desc6, t.ispezioni_desc7,t.ispezioni_desc8)
        else (li.description::text) 
        end as oggetto_del_controllo,
	lim.code,
	lim.description
	from ticket t
	left join tipocontrolloufficialeimprese tcu on tcu.idcontrollo = t.ticketid
	left join lookup_ispezione li on li.code=tcu.ispezione 
	left join lookup_ispezione_macrocategorie lim on lim.code = li.level 
							and (case when (lim.description is not null or lim.description <> '') then lim.enabled end) 
where 
	t.provvedimenti_prescrittivi = 4 and t.tipologia = 3 
	and t.trashed_date is null and tcu.ispezione > 0 
        and t.assigned_date  between coalesce (_data_1,'1900-01-01') and coalesce (_data_2,now()) 
  
  LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
  
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;