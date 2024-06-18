--- INVIO

-- 1: Costruire json da inviare a SetChecklist

-- Il JSON deve contenere: IDCLCheckList: id classyfarm della checklist, IDCheckList: codice gisa della checklist, DataValidit�: La data dalla quale tale checklist sar� valida. E' meglio usare la stessa data validit� che usiamo in GISA. Gli altri parametri lasciarli cos�. (ricordarsi di modificare anche il codice_gisa nella query interna)

-- SetChecklist

SELECT 1, '{"IDCLCheckList": "106","IDCheckList": "biosicurezza-2023-suini-stab_alta-01","IDRegione": "U150","IDASL": "R201","DataValidit�": "2024-01-01T00:00:00.000Z","Domande": ['

UNION

(select 2, 
'{"IDCLDomanda": '||d.id_classyfarm||',"IDDomanda": '||d.id||',"DescrDomanda": "'|| regexp_replace(replace(replace(d.domanda, '''', ''), '"', ''), E'[\\n\\r]+', ' ', 'g' )||'","Risposte": ['
|| string_agg('{"IDRisposta": '||r.id||',"Valore": "'||r.risposta||'", "IDCLRisposta": '||r.id_classyfarm||'}', ',')
||']},'

from biosicurezza_sezioni s
join biosicurezza_domande d on d.id_sezione = s.id
join biosicurezza_risposte r on d.id = r.id_domanda
join lookup_chk_classyfarm_mod l on l.code = s.id_lookup_chk_classyfarm_mod
where l.codice_gisa = 'biosicurezza-2023-suini-stab_alta-01'
group by d.id_classyfarm, d.id, d.domanda
order by d.ordine)


UNION

SELECT 3, ']}'

order by 1

-- Importante: cancellare l'ultima virgola nell'ultimo pezzo

-- Inviare questo json a setChecklist seguendo lo stesso procedimento fatto per chiamare GetTemplateCL sulla pagina dei servizi.

-- checklist biosicurezza-2023-suini-semib_alta-01

SELECT 1, '{"IDCLCheckList": "108","IDCheckList": "biosicurezza-2023-suini-semib_alta-01","IDRegione": "U150","IDASL": "R201","DataValidit�": "2024-01-01T00:00:00.000Z","Domande": ['

UNION

(select 2, 
'{"IDCLDomanda": '||d.id_classyfarm||',"IDDomanda": '||d.id||',"DescrDomanda": "'|| regexp_replace(replace(replace(d.domanda, '''', ''), '"', ''), E'[\\n\\r]+', ' ', 'g' )||'","Risposte": ['
|| string_agg('{"IDRisposta": '||r.id||',"Valore": "'||r.risposta||'", "IDCLRisposta": '||r.id_classyfarm||'}', ',')
||']},'

from biosicurezza_sezioni s
join biosicurezza_domande d on d.id_sezione = s.id
join biosicurezza_risposte r on d.id = r.id_domanda
join lookup_chk_classyfarm_mod l on l.code = s.id_lookup_chk_classyfarm_mod
where l.codice_gisa = 'biosicurezza-2023-suini-semib_alta-01'
group by d.id_classyfarm, d.id, d.domanda
order by d.ordine)


UNION

SELECT 3, ']}'

order by 1


-- checklist biosicurezza-2023-suini-stab_bassa-01

SELECT 1, '{"IDCLCheckList": "107","IDCheckList": "biosicurezza-2023-suini-stab_bassa-01","IDRegione": "U150","IDASL": "R201","DataValidit�": "2024-01-01T00:00:00.000Z","Domande": ['

UNION

(select 2, 
'{"IDCLDomanda": '||d.id_classyfarm||',"IDDomanda": '||d.id||',"DescrDomanda": "'|| regexp_replace(replace(replace(d.domanda, '''', ''), '"', ''), E'[\\n\\r]+', ' ', 'g' )||'","Risposte": ['
|| string_agg('{"IDRisposta": '||r.id||',"Valore": "'||r.risposta||'", "IDCLRisposta": '||r.id_classyfarm||'}', ',')
||']},'

from biosicurezza_sezioni s
join biosicurezza_domande d on d.id_sezione = s.id
join biosicurezza_risposte r on d.id = r.id_domanda
join lookup_chk_classyfarm_mod l on l.code = s.id_lookup_chk_classyfarm_mod
where l.codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01'
group by d.id_classyfarm, d.id, d.domanda
order by d.ordine)


UNION

SELECT 3, ']}'

order by 1

-- checklist biosicurezza-2023-suini-semib_bassa-01

SELECT 1, '{"IDCLCheckList": "109","IDCheckList": "biosicurezza-2023-suini-semib_bassa-01","IDRegione": "U150","IDASL": "R201","DataValidit�": "2024-01-01T00:00:00.000Z","Domande": ['

UNION

(select 2, 
'{"IDCLDomanda": '||d.id_classyfarm||',"IDDomanda": '||d.id||',"DescrDomanda": "'|| regexp_replace(replace(replace(d.domanda, '''', ''), '"', ''), E'[\\n\\r]+', ' ', 'g' )||'","Risposte": ['
|| string_agg('{"IDRisposta": '||r.id||',"Valore": "'||r.risposta||'", "IDCLRisposta": '||r.id_classyfarm||'}', ',')
||']},'

from biosicurezza_sezioni s
join biosicurezza_domande d on d.id_sezione = s.id
join biosicurezza_risposte r on d.id = r.id_domanda
join lookup_chk_classyfarm_mod l on l.code = s.id_lookup_chk_classyfarm_mod
where l.codice_gisa = 'biosicurezza-2023-suini-semib_bassa-01'
group by d.id_classyfarm, d.id, d.domanda
order by d.ordine)


UNION

SELECT 3, ']}'

order by 1

--- DBI INVIO





CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_biosicurezza_2023_suini(_id integer)
  RETURNS text AS
$BODY$
DECLARE
_codice_gisa text;
_tipo_operazione integer;
ret text;
BEGIN

select l.codice_gisa into _codice_gisa from
biosicurezza_istanze i
join lookup_chk_classyfarm_mod l on i.id_lookup_chk_classyfarm_mod = l.code
where i.id = _id;

select case when id_esito_classyfarm <> 0 then 0 when riaperta then 1 else 0 end into _tipo_operazione from biosicurezza_istanze where id = _id;

select
concat(
'{ "IDCLCheckList": "', (select codice_classyfarm from lookup_chk_classyfarm_mod where codice_gisa = _codice_gisa) , '",
  "IDCL": "', _codice_gisa , '",
  "IDRegione": "', 'U150' , '",
  "IDASL": "', 'R'||t.site_id , '",
  "DataVisita": "', t.assigned_date , '",
  "DataCompilazione": "', i.entered , '",
  "IDAzienda": "', o.account_number , '",
  "IDFiscale": "', o.codice_fiscale_rappresentante , '",
  "CodiceSpecie": "', o.specie_allevamento , '",
  "TpOperazione": ', _tipo_operazione, ',
  "IDCU": "', (t.ticketid)::text, '", 
  "ListaRisposte": [' , (select * from get_chiamata_ws_insert_biosicurezza_2023_suini_risposte (_id)) ,'
  ]}') into ret
  
  from biosicurezza_istanze i
  left join ticket t on t.ticketid = i.idcu
  left join organization o on o.org_id = t.org_id
  where i.id = _id;

 RETURN ret;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;



CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_biosicurezza_2023_suini_risposte(_id integer)
  RETURNS text AS
$BODY$
DECLARE
	ret text;
BEGIN

select

string_agg(concat('{"IDDomanda": ', risp.id_domanda, ',
      "DescrDomanda": "', regexp_replace(replace(replace(risp.descr_domanda, '''', ''), '"', ''), E'[\\n\\r]+', ' ', 'g' ), '",
      "IDRisposta": ', risp.id_risposta, ',
      "Valore": "', risp.valore, '"}'), ',') into ret
      
FROM (
SELECT

d.id as id_domanda,
d.domanda as descr_domanda,
r.id as id_risposta,
ir.note as valore
from biosicurezza_istanze i
left join biosicurezza_istanze_risposte ir on ir.id_istanza = i.id
left join biosicurezza_domande d on d.id = ir.id_domanda
left join biosicurezza_risposte r on r.id = ir.id_risposta
where i.id = _id and i.trashed_date is null and ir.trashed_date is null

) risp;

 RETURN ret;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;


-- Function: public.get_chiamata_ws_insert_biosicurezza(integer)

-- DROP FUNCTION public.get_chiamata_ws_insert_biosicurezza(integer);

CREATE OR REPLACE FUNCTION public.get_chiamata_ws_insert_biosicurezza(_id integer)
  RETURNS text AS
$BODY$
DECLARE
_codice_gisa text;
ret text;
BEGIN

select l.codice_gisa into _codice_gisa from
biosicurezza_istanze i
join lookup_chk_classyfarm_mod l on i.id_lookup_chk_classyfarm_mod = l.code
where i.id = _id;

IF _codice_gisa = 'biosicurezza-suini-01' THEN
ret := (select * from get_chiamata_ws_insert_biosicurezza_2020_suini(_id));
END IF;

IF  _codice_gisa = 'biosicurezza-2022-suini-stab_alta-01' or _codice_gisa = 'biosicurezza-2022-suini-stab_bassa-01' or _codice_gisa = 'biosicurezza-2022-suini-semib_alta-01' or _codice_gisa = 'biosicurezza-2022-suini-semib_bassa-01' THEN
ret := (select * from get_chiamata_ws_insert_biosicurezza_2022_suini(_id));
END IF;


IF  _codice_gisa = 'biosicurezza-2023-suini-stab_alta-01' or _codice_gisa = 'biosicurezza-2023-suini-stab_bassa-01' or _codice_gisa = 'biosicurezza-2023-suini-semib_alta-01' or _codice_gisa = 'biosicurezza-2023-suini-semib_bassa-01' THEN
ret := (select * from get_chiamata_ws_insert_biosicurezza_2023_suini(_id));
END IF;


IF  _codice_gisa = 'biosicurezza-2022-tacchini-01' or _codice_gisa = 'biosicurezza-2022-galline-01' or _codice_gisa = 'biosicurezza-2022-broiler-01' THEN
ret := (select * from get_chiamata_ws_insert_biosicurezza_2022_avicoli(_id));
END IF;

 RETURN ret;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;



