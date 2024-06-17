alter table preaccettazione.lookup_stati_pa add column descrizione_breve text;
update preaccettazione.lookup_stati_pa set descrizione_breve='COMPLETO' where id=2;
update preaccettazione.lookup_stati_pa set descrizione_breve='INCOMPLETO: NON ASSOCIATO AL CAMPIONE' where id=1;
update preaccettazione.lookup_stati_pa set descrizione_breve='LETTO' where id=3;
update preaccettazione.lookup_stati_pa set descrizione_breve='RISULTATO RICEVUTO' where id=5;

-- FUNCTION: digemon.dbi_get_report_preaccettazione(timestamp without time zone, timestamp without time zone)

-- DROP FUNCTION IF EXISTS digemon.dbi_get_report_preaccettazione(timestamp without time zone, timestamp without time zone);

CREATE OR REPLACE FUNCTION digemon.dbi_get_report_preaccettazione(
	data_1 timestamp without time zone,
	data_2 timestamp without time zone)
    RETURNS TABLE(asl text, codice_preaccettazione text, data_prelievo timestamp without time zone, laboratorio text, stato text, codice_accettazione text, data_accettazione timestamp without time zone, id_campione integer, numero_verbale text, descrizione_risultato_esame text, norma text, partita_iva text, ragione_sociale text, num_linea text, attivita text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
return query
select 
	asl.description::text
	, UPPER(us.prefix::text || us.anno::text || us.progres::text) as codice_preaccettazione
	, t.assigned_date
    , ldc.description::text as laboratorio
	--, us.id_stato	
	, ls.descrizione_breve as stato
	, t.cause as codice_accettazione
	, t.data_accettazione
	, t.ticketid as id_campione
	, t.location::text as numero_verbale
	--, t.note_esito_esame as risultato_1
	--, replace(replace(replace(regexp_replace(t.note_esito_esame, '(.*?)<(\w+)\s+.*?>(.*)', '\1<\2>\3', 'g'),'</td><td>',''),'<div><table><tr><td>',''),'</td></tr></table></div>','') as risultato_2
	, regexp_replace(t.note_esito_esame,'\s*(<[^>]+>|<script.+?<\/script>|<style.+?<\/style>)\s*','-','gi') 
	, ram.norma
	, ram.partita_iva::text
	, ram.ragione_sociale::text
	, ram.n_linea::text
	, case when length(trim(ram.path_attivita_completo::text))=0 then ram.attivita::text else ram.path_attivita_completo::text end
from preaccettazione.codici_preaccettazione p
join preaccettazione.vw_ultimo_stato us on us.id_preaccettazione = p.id
join preaccettazione.lookup_stati_pa ls on ls.id = us.id_stato
join public.lookup_destinazione_campione ldc on ldc.code = p.id_laboratorio
join preaccettazione.stati_preaccettazione sp on sp.id_preaccettazione = p.id
join preaccettazione.associazione_preaccettazione_entita ap on ap.id_stati = sp.id
join ticket t on (ap.tipo_entita ilike 'C' and t.ticketid::character varying = ap.riferimento_entita)
left join lookup_site_id asl on asl.code=t.site_id 
left join ricerche_anagrafiche_old_materializzata ram on concat(ram.riferimento_id, ram.riferimento_id_nome, ram.riferimento_id_nome_tab, ram.id_linea, ram.tipologia_operatore) = 
				concat(ap.lda_riferimento_id, ap.lda_riferimento_id_nome, ap.lda_riferimento_id_nome_tab, ap.lda_id_linea, ap.tipologia_operatore)
where 
t.assigned_date BETWEEN data_1 and data_2
AND p.trashed_date is null
and t.trashed_date is null and t.tipologia=2 
and sp.trashed_date is null
and ap.trashed_date is null
order by codice_preaccettazione, stato;
END;
$BODY$;

ALTER FUNCTION digemon.dbi_get_report_preaccettazione(timestamp without time zone, timestamp without time zone)
    OWNER TO postgres;
--select * from digemon.dbi_get_report_preaccettazione('2024-01-01','2024-12-31')

-- query per cancellare preaccettazioni con codici associati a laboratori diversi da IZSM e ARPAC
-- select * from preaccettazione.codici_preaccettazione where trashed_date is null and UPPER(prefix::text || anno::text || progres::text) ilike '%G2202%'


 
