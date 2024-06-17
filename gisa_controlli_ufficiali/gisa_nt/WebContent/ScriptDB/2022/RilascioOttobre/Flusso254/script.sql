
CREATE OR REPLACE FUNCTION preaccettazione.annulla_codice_preaccettazione(
    IN _codice_preaccettazione text,
    IN _idutente integer)
  RETURNS TABLE(_idout integer) AS
$BODY$
DECLARE

BEGIN
	
	update preaccettazione.codici_preaccettazione set trashed_date=now(), trashedby=_idutente where concat(prefix, anno, progres)= upper(_codice_preaccettazione) and trashed_date is null;
	return query 
	select id from preaccettazione.codici_preaccettazione where concat(prefix, anno, progres)= upper(_codice_preaccettazione) and trashed_date is not null order by trashed_date desc limit 1;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION preaccettazione.annulla_codice_preaccettazione(text, integer)
  OWNER TO postgres;

  
CREATE OR REPLACE VIEW preaccettazione.vw_ultimo_stato AS 
 SELECT DISTINCT ON (c.id) s.id AS cod_stato,
    s.id_preaccettazione,
    s.enteredby,
    s.entered,
    c.prefix,
    c.anno,
    c.progres,
    c.id_ente,
    c.id_laboratorio,
    s.id_stato,
    a.riferimento_entita,
    a.tipo_entita,
    a.lda_riferimento_id,
    a.lda_riferimento_id_nome,
    a.lda_riferimento_id_nome_tab,
    a.lda_id_linea,
    a.tipologia_operatore
   FROM preaccettazione.stati_preaccettazione s
     LEFT JOIN preaccettazione.codici_preaccettazione c ON s.id_preaccettazione = c.id
     LEFT JOIN preaccettazione.associazione_preaccettazione_entita a ON a.id_stati = s.id
  WHERE s.trashed_date IS NULL AND c.trashed_date IS NULL
  ORDER BY c.id, s.entered DESC;

ALTER TABLE preaccettazione.vw_ultimo_stato
  OWNER TO postgres;
GRANT ALL ON TABLE preaccettazione.vw_ultimo_stato TO postgres;
GRANT ALL ON TABLE preaccettazione.vw_ultimo_stato TO public;

DROP FUNCTION preaccettazione.get_elenco_preaccettazioni(integer);

CREATE OR REPLACE FUNCTION preaccettazione.get_elenco_preaccettazioni(IN _idutente integer)
  RETURNS TABLE(codice_preaccettazione text, data_conferma text, ragione_sociale text, linea_attivita text, numero_registrazione_stabilimento text, quesito_diagnostico text, matrice_campione text) AS
$BODY$
DECLARE

BEGIN

	return query
	select distinct tab.* from 
	(select concat(t.prefix,t.anno,t.progres) as codice_preaccettazione,
	       to_char(t.entered, 'YYYY-MM-DD  HH24:MI:SS') as data_conferma,
	       ram.ragione_sociale::text as ragione_sociale,
	       ram.attivita::text as linea_attivita,
	       COALESCE(NULLIF(trim(ram.n_reg),''),NULLIF(trim(ram.num_riconoscimento),''))::text as numero_registrazione_stabilimento,
	       -- new 15/09/22
	       cod.quesito_diagnostico,
	       cod.matrice_campione
	from ricerche_anagrafiche_old_materializzata ram
	join preaccettazione.vw_ultimo_stato t 
			on concat(ram.riferimento_id, ram.riferimento_id_nome, ram.riferimento_id_nome_tab, ram.id_linea) = 
			   concat(t.lda_riferimento_id, t.lda_riferimento_id_nome, t.lda_riferimento_id_nome_tab, t.lda_id_linea)
	-- modifica 15/09/22 per estrarre quesito diagnostico e matrice
	join preaccettazione.codici_preaccettazione cod on cod.id=t.id_preaccettazione
	where t.id_stato = 1 and t.enteredby = _idutente order by t.entered desc limit 10) tab order by tab.data_conferma desc;
 	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION preaccettazione.get_elenco_preaccettazioni(integer)
  OWNER TO postgres;
  
  DROP FUNCTION preaccettazione.get_elenco_preaccettazioni_da_linea_attivita(text, integer, integer);

CREATE OR REPLACE FUNCTION preaccettazione.get_elenco_preaccettazioni_da_linea_attivita(
    IN _identificativo_linea text,
    IN _id_ente integer,
    IN _id_laboratorio integer)
  RETURNS TABLE(codice_preaccettazione text, data_conferma text, ragione_sociale text, userid integer, username character varying, desc_quesito text, desc_matrice text, id_quesito text, id_matrice text, ente text, laboratorio text) AS
$BODY$
DECLARE
BEGIN

	return query
	select distinct concat(t.prefix,t.anno,t.progres) as codice_preaccettazione,
	       to_char(t.entered, 'YYYY-MM-DD  HH24:MI:SS') as data_conferma,
	       ram.ragione_sociale::text as ragione_sociale,
	       t.enteredby,
	       a.username,
	       cp.quesito_diagnostico::text as desc_quesito,
	       cp.matrice_campione::text as desc_matrice,
	       cp.id_quesito::text as id_quesito,
	       cp.id_matrice::text as id_matrice,
	       le.description::text as ente,
	       ll.description::text as laboratorio
	 from ricerche_anagrafiche_old_materializzata ram
		join preaccettazione.vw_ultimo_stato t 
			on concat(ram.riferimento_id, ram.riferimento_id_nome, ram.riferimento_id_nome_tab, ram.id_linea) = 
			   concat(t.lda_riferimento_id, t.lda_riferimento_id_nome, t.lda_riferimento_id_nome_tab, t.lda_id_linea)
		join access a on t.enteredby = a.user_id
		join preaccettazione.codici_preaccettazione cp on cp.id = t.id_preaccettazione
		join lookup_destinazione_campione ll on ll.code = cp.id_laboratorio and ll.enabled
		join preaccettazione.lookup_ente le on le.code = cp.id_ente and le.enabled
	   where concat(t.lda_riferimento_id,t.lda_riferimento_id_nome,t.lda_riferimento_id_nome_tab,t.lda_id_linea,t.tipologia_operatore) like _identificativo_linea 
		 and t.id_stato = 1 and cp.id_ente = _id_ente
		 and (case when _id_laboratorio > 0 then cp.id_laboratorio = _id_laboratorio else cp.id_laboratorio in (1,2) end)
		 order by data_conferma desc limit 10;
 
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION preaccettazione.get_elenco_preaccettazioni_da_linea_attivita(text, integer, integer)
  OWNER TO postgres;
