-- Scheda centralizzata

update scheda_operatore_metadati set enabled = false where tipo_operatore = 36;insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','COMUNE DI NASCITA TITOLARE','','luogo_nascita_rappresentante as luogo_nascita_titolare ','organization ','org_id = #orgid#','o','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','TELEFONO TITOLARE','','telefono_rappresentante as telefono_titolare ','organization ','org_id = #orgid#','p','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','SEDE LEGALE','capitolo','','','','r','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','INFORMAZIONE PRIMARIA','capitolo','','','','a','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','DETTAGLI ADDIZIONALI','capitolo','','','','Z','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','DATA INIZIO','','to_char(datapresentazione, ''dd/mm/yy'') as data_dia ','organization ','org_id = #orgid#','C','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','NUMERO REGISTRAZIONE / AUTORIZZAZIONE','','account_number','organization o ','o.org_id = #orgid#','D','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','TITOLARE O LEGALE RAPPRESENTANTE','capitolo','','','','i','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','LISTA LINEE PRODUTTIVE','capitolo','','','','V','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','IMPRESA','','name as ragione_sociale ','organization ','org_id = #orgid#','E','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','CATEGORIA DI RISCHIO','','categoria_rischio as cat_rischio ','organization ','org_id = #orgid#','F','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','DATA PROSSIMO CONTROLLO CON LA TECNICA DELLA SORVEGLIANZA','','to_char(now(), ''dd/mm/yy'') as prossimo_controllo ','organization ','org_id = #orgid#','G','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','NOME TITOLARE','','nome_rappresentante as nome_titolare ','organization ','org_id = #orgid#','l','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','COGNOME TITOLARE','','cognome_rappresentante as cognome_titolare ','organization ','org_id = #orgid#','m','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','SEDE OPERATIVA','capitolo','','','','t','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','MODIFICATO DA','','c.namefirst || '' '' || c.namelast ||  '' '' || to_char(o.modified, ''dd/MM/yyyy'')','organization o left join access_ a on a.user_id = o.modifiedby left join contact_ c on c.contact_id = a.contact_id','o.org_id = #orgid#','ZZZZ','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','ASL','','asl.description as descr_asl ','lookup_site_id asl left join organization o on o.site_id = asl.code ','o.org_id = #orgid#','b','screen');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','PARTITA IVA','','partita_iva','organization ','org_id = #orgid#','EE','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','STATO','','case when stato_lab = 4 then ''CESSATO IN DATA '' || to_char( contract_end, ''dd/MM/yy'') else ''Attivo'' end as stato','organization ','org_id = #orgid#','H','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','DATA DI NASCITA TITOLARE','','to_char(data_nascita_rappresentante, ''dd/mm/yy'') as data_nascita_titolare ','organization ','org_id = #orgid#','n','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','FAX TITOLARE','','fax as fax_titolare ','organization ','org_id = #orgid#','q','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','INDIRIZZO SEDE LEGALE ','indirizzo','case when upper(oaleg.addrline1) is not null then upper(oaleg.addrline1) else  '' '' end || '',  ''|| case when upper(oaleg.city) is not null  then upper(oaleg.city) else  '' '' end || '',  ''|| case when oaleg.postalcode is not null  then oaleg.postalcode else  '' '' end || '', ''|| case when oaleg.state is not null  then oaleg.state else  '' '' end','organization o left join organization_address oaleg on (o.org_id = oaleg.org_id and oaleg.address_type = 1) ','o.org_id = #orgid# and oaleg.trasheddate is null','s','screen');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','INDIRIZZO SEDE OPERATIVA ','indirizzo','case when upper(oaope.addrline1) is not null then upper(oaope.addrline1) else  '' '' end || '',  ''|| case when upper(oaope.city) is not null  then upper(oaope.city) else  '' '' end || '',  ''|| case when oaope.postalcode is not null  then oaope.postalcode else  '' '' end || '', ''|| case when oaope.state is not null  then oaope.state else  '' '' end','organization o left join organization_address oaope on (o.org_id = oaope.org_id and oaope.address_type = 5) ','o.org_id = #orgid# and oaope.trasheddate is null
','u','screen');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','ATTIVITA','','norma ||''<br/>''||attivita','ricerche_anagrafiche_old_materializzata','riferimento_id = #orgid# and riferimento_id_nome_col = ''org_id''','VV','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','DESCRIZIONE STORICA DELLE LINEE DI ATTIVITA'' (MASTER LIST , ATECO, ECC.)','','''ALTRI OPERATORI NON PRESENTI ALTROVE''','organization ','org_id = #orgid#','VVV','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','NOTE','','notes','organization','org_id = #orgid#','ZZ','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','INSERITO DA','','c.namefirst || '' '' || c.namelast ||  '' '' || to_char(o.entered, ''dd/MM/yyyy'')','organization o left join access_ a on a.user_id = o.enteredby left join contact_ c on c.contact_id = a.contact_id','o.org_id = #orgid#','ZZZ','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('36','DESCRIZIONE ATTIVITA''','','sic_description','organization','org_id = #orgid#','HH','');

-- digemon


DROP FUNCTION IF EXISTS digemon.dbi_get_campi_estesi();

CREATE OR REPLACE FUNCTION digemon.dbi_get_campi_estesi(
	)
    RETURNS TABLE(org_id integer, specie_macelli character varying, codifica_specie_sintesi character varying, data_ricezione_autorizzazione_ingrosso timestamp without time zone, numero_autorizzazione_ingrosso text, data_ricezione_autorizzazione_dettaglio timestamp without time zone, numero_autorizzazione_dettaglio text, tipo_trasporto character varying, animale_trasportato character varying, targa text, descrizione text, classe character varying, tipologia_acque integer, codice_classe integer, dataprovvedimento timestamp without time zone, provvedimento text, data_classificazione timestamp without time zone, data_fine_classificazione timestamp without time zone, tipo_produzione text, numero_decreto text, ente_gestore character varying, codice_punto_prelievo character varying, tipologia_punto_prelievo character varying, tipo_struttura character varying, codice_l30 character varying, razza character varying, provvedimento_autorizzazione character varying, scadenza_autorizzazione character varying, sede character varying, descrizione_attivita text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
	r RECORD;
	 	
BEGIN
     FOR org_id, specie_macelli, codifica_specie_sintesi, data_ricezione_autorizzazione_ingrosso, numero_autorizzazione_ingrosso, data_ricezione_autorizzazione_dettaglio,
     numero_autorizzazione_dettaglio, tipo_trasporto, animale_trasportato, targa, descrizione, classe, tipologia_acque, codice_classe, dataprovvedimento, provvedimento,
     data_classificazione, data_fine_classificazione, tipo_produzione, numero_decreto, ente_gestore, codice_punto_prelievo, tipologia_punto_prelievo,
     tipo_struttura, codice_l30, razza, provvedimento_autorizzazione, scadenza_autorizzazione, sede , descrizione_attivita
  in
  select
o.org_id, 
l.description as specie_macelli, l.short_description as codifica_specie_sintesi,
o.data_ric_ingrosso AS data_ricezione_autorizzazione_ingrosso,
o.num_ric_ingrosso AS numero_autorizzazione_ingrosso,
o.data_ric_dettaglio AS data_ricezione_autorizzazzione_dettaglio,
o.num_ric_dettaglio AS numero_autorizzazzione_dettaglio,
o.duns_type AS tipo_trasporto,
lst.description AS animale_trasportato,
auto.targa,
auto.descrizione,
lc.description AS classe,
o.tipologia_acque,
lc.code AS codice_classe,
o.date2 AS dataprovvedimento,
o.note1 AS provvedimento,
o.data_classificazione,
o.data_fine_classificazione,
lz.description AS tipo_zona_produzione,
o.numaut AS numero_decreto,
o.banca as ente_gestore, o.account_number as codice_punto_prelievo, 
lta.description as tipologia_punto_prelievo,
CASE
    	WHEN c.monta_equina_attive IS NOT NULL AND c.monta_equina_attive THEN 'STAZIONE DI MONTA NATURALE EQUINA'
    	WHEN c.monta_bovina_attive IS NOT NULL AND c.monta_bovina_attive THEN 'STAZIONE DI MONTA NATURALE BOVINA'
	WHEN c.stazione_inseminazione_equine IS NOT NULL AND c.stazione_inseminazione_equine THEN 'STAZIONE DI INSEMINAZIONE ARTIFICIALE EQUINA'
	WHEN c.centro_produzione_embrioni IS NOT NULL AND c.centro_produzione_embrioni THEN 'CENTRO DI PRODUZIONE EMBRIONI'
	WHEN c.centro_produzione_sperma IS NOT NULL AND c.centro_produzione_sperma THEN 'CENTRO DI PRODUZIONE SPERMA'
	WHEN c.gruppo_raccolta_embrioni IS NOT NULL AND c.gruppo_raccolta_embrioni THEN 'GRUPPO DI RACCOLTA EMBRIONI'
	WHEN c.recapiti_autorizzati IS NOT NULL AND c.recapiti_autorizzati THEN 'RECAPITI ATTIVI'
	ELSE null
END AS tipo_struttura,
c.codice_legge_30 as codice_l30,
c.razza,
c.provv_aut as provvedimento_autorizzazione,
c.scadenza_aut as scadenza_autorizzazione,
c.sede,
o.sic_description
from  
organization o
LEFT JOIN lookup_classi_acque lc ON lc.code = o.classificazione
LEFT JOIN animalitrasportati at ON at.org_id = o.org_id
LEFT JOIN lookup_specie_trasportata lst ON lst.code = at.tipo_animale
LEFT JOIN organization_autoveicoli auto ON o.org_id = auto.org_id AND auto.elimina IS NULL
left join macelli_specie m on m.org_id = o.org_id
left join lookup_specie_macelli l on l.code = m.id_specie_macelli and l.enabled 
left join lookup_tipo_acque lta on lta.code = o.tipo_struttura
left join lookup_zone_di_produzione lz on lz.code=o.tipologia_acque
left join centri_riproduzione_animale c  ON o.org_id = c.org_id
where o.trashed_date is null and o.tipologia in (8,9,802,14,3,151,201,12)

    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

ALTER FUNCTION digemon.dbi_get_campi_estesi()
    OWNER TO postgres;