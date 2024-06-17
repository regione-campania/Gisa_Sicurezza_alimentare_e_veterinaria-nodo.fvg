
--select * from lookup_pnaa_programma_controllo order by level
-- valutare drop e create o update code
alter table lookup_pnaa_programma_controllo add column data_inizio timestamp without time zone;
alter table  lookup_pnaa_programma_controllo add column data_fine timestamp without time zone;
delete from lookup_pnaa_programma_controllo;
ALTER SEQUENCE "lookup_pnaa_programma_controllo_code_seq" RESTART WITH 1; 

insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Costituenti di origine animale vietati','1','2000-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Diossine e PCB','2','2000-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Titolo','7','2000-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Uso illecito','8','2000-01-01','2023-12-31');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Uso improprio','9','2000-01-01','2023-12-31');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Micotossine e Tossine Vegetali','4','2000-01-01','2023-12-31');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Salmonella','3','2000-01-01','3000-01-01'); 
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('OGM Autorizzato','5','2000-01-01','2023-12-31');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('OGM NON Autorizzato','6','2000-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Principi farmacologicamente attivi e additivi per CARRY OVER','10','2000-01-01','2023-12-31');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Contaminanti inorganici e composti azotati,composti organoclorurati, radionuclidi','11','2000-01-01','2023-12-31');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Micotossine (normate) e Tossine Vegetali','4','2024-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('OGM Autorizzato (solo circuito convenzionale)','5','2024-01-01','3000-01-01'); 
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Contaminanti inorganici e composti azotati,composti organoclorurati, radionuclidi','11','2024-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Sostanze farmacologicamente attivi e additivi per CARRY OVER','10','2024-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Uso vietato','8','2024-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Uso non prescritto/non dichiarato','9','2024-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Additivi nutrizionali','12','2024-01-01','3000-01-01');
insert into lookup_pnaa_programma_controllo (description,level,data_inizio, data_fine) values('Altro','13','2000-01-01','3000-01-01');


CREATE OR REPLACE FUNCTION public.pnaa_get_lookup_programma_controllo(_data_prelievo timestamp without time zone)
	
    RETURNS TABLE(code integer, description character varying, default_item boolean, level integer, enabled boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS
  $BODY$
   BEGIN

		return query 
			select l.code, l.description, l.default_item, l.level, l.enabled  
			from lookup_pnaa_programma_controllo l
			where l.enabled and _data_prelievo between l.data_inizio and l.data_fine
			order by l.level;
   END;

 $BODY$;
select * from public.pnaa_get_lookup_programma_controllo('2024-05-01')

alter table lookup_contaminanti add column data_inizio timestamp without time zone;
alter table  lookup_contaminanti add column data_fine timestamp without time zone;

delete from lookup_contaminanti;
ALTER SEQUENCE "lookup_contaminanti_code_seq" RESTART WITH 1; 
insert into lookup_contaminanti(description, level, enabled, data_inizio, data_fine) values ('Contaminanti inorganici e composti azotati',0,true,'2000-01-01','3000-01-01');
--insert into lookup_contaminanti(description, level, enabled, data_inizio, data_fine) values ('Radionuclidi',1,true,'2000-01-01','3000-01-01');
--insert into lookup_contaminanti(description, level, enabled, data_inizio, data_fine) values ('Pesticidi',2,true,'2000-01-01','3000-01-01');
--insert into lookup_contaminanti(description, level, enabled, data_inizio, data_fine) values ('Conoscitivo per radiunuclidi',3,true,'2024-01-01','3000-01-01');
--insert into lookup_contaminanti(description, level, enabled, data_inizio, data_fine) values ('Conoscitivo per nitrati',4,true,'2024-01-01','3000-01-01');


CREATE OR REPLACE FUNCTION public.pnaa_get_lookup_contaminanti(_data_prelievo timestamp without time zone)
	
    RETURNS TABLE(code integer, description character varying, default_item boolean, level integer, enabled boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS
  $BODY$
   BEGIN

		return query 
			select l.code, l.description, l.default_item, l.level, l.enabled  
			from lookup_contaminanti l
			where l.enabled and _data_prelievo between l.data_inizio and l.data_fine
			order by l.level;
   END;

 $BODY$;
 

alter table modello_pnaa_values add column campione_mangime text;
alter table modello_pnaa_values add column campione_sottoprodotti text;
alter table modello_pnaa_values add column strategia_campionamento_conoscitivo text;
alter table modello_pnaa_values add column id_strategia_campionamento_conoscitivo_analita integer;
alter table modello_pnaa_values add column micotossine_conoscitivo text;
alter table modello_pnaa_values add column additivi_nutrizionali_specifica text;
alter table modello_pnaa_values add column additivi_nutrizionali_conoscitivo text;
alter table modello_pnaa_values add column dimensione_porzione text;
alter table modello_pnaa_values add column cf1_peso text;
alter table modello_pnaa_values add column cf1_sigillo text;
alter table modello_pnaa_values add column cf2_peso text;
alter table modello_pnaa_values add column cf2_sigillo text;
alter table modello_pnaa_values add column cf3_peso text;
alter table modello_pnaa_values add column cf3_sigillo text;
alter table modello_pnaa_values add column cf4_peso text;
alter table modello_pnaa_values add column cf4_sigillo text;
alter table modello_pnaa_values add column cf5_peso text;
alter table modello_pnaa_values add column cf5_sigillo text;
alter table modello_pnaa_values add column cf_ulteriore text;
alter table modello_pnaa_values add column cf_ulteriore_peso text;
alter table modello_pnaa_values add column cf_ulteriore_ricerca text;


DROP FUNCTION IF EXISTS public.get_modello_pnaa(integer);

-- FUNCTION: public.get_modello_pnaa(integer)

-- DROP FUNCTION IF EXISTS public.get_modello_pnaa(integer);
CREATE OR REPLACE FUNCTION public.get_modello_pnaa(
	_idcampione integer)
    RETURNS TABLE(id_campione integer, enteredby integer, entered timestamp without time zone, id integer, numero_scheda text, campione_motivazione text, campione_data timestamp without time zone, campione_verbale text, campione_codice_preaccettazione text, campione_asl text, campione_percontodi text, campione_anno text, campione_mese text, campione_giorno text, campione_ore text, campione_presente text, campione_sottoscritto text, campione_num_prelevati text, id_dpa integer, id_strategia_campionamento integer, id_metodo_campionamento integer, id_programma_controllo integer, programma_controllo_fa_specifica text, programma_controllo_an_specifica text, programma_controllo_ci_specifica text, programma_controllo_at_specifica text, programma_controllo_ao_specifica text, programma_controllo_az_specifica text, programma_controllo_co_fa_specifica text, programma_controllo_co_ci_specifica text, programma_controllo_in_ci_specifica text, programma_controllo_in_ra_specifica text, programma_controllo_in_pe_specifica text, micotossine_specifica text, altro_specifica text, id_principi_additivi integer, id_principi_additivi_co integer, quantita_pa text, id_contaminanti integer, prelevatore text, id_luogo_prelievo integer, codice_luogo_prelievo text, codice_sinvsa text, targa_mezzo text, indirizzo_luogo_prelievo text, comune_luogo_prelievo text, provincia_luogo_prelievo text, lat_luogo_prelievo text, lon_luogo_prelievo text, ragione_sociale text, rappresentante_legale text, codice_fiscale text, detentore text, telefono text, id_matrice_campione integer, lista_specie_vegetale_dichiarata text, mangime_semplice_specifica text, id_mangime_composto integer, id_premiscela_additivi integer, trattamento_mangime text, id_confezionamento integer, ragione_sociale_ditta_produttrice text, indirizzo_ditta_produttrice text, lista_specie_alimento_destinato text, id_metodo_produzione integer, nome_commerciale_mangime text, lista_stato_prodotto_prelievo text, responsabile_etichettatura text, indirizzo_responsabile_etichettatura text, paese_produzione text, data_produzione text, data_scadenza text, num_lotto text, dimensione_lotto text, ingredienti text, commenti_mangime_prelevato text, laboratorio_destinazione text, id_allega_cartellino integer, descrizione_attrezzature text, num_punti text, num_ce text, volume text, operazioni text, volume_2 text, operazioni_2 text, numero_cf text, quantita_gml text, dichiarazione text, conservazione_campione text, num_copie text, num_campioni_finali text, custode text, id_campione_finale integer, id_rinuncia_campione integer, codice_esame text, codice_osa text, lista_codice_matrice text, volume_3 text, num_campioni_finali_invio text, num_copie_invio text, destinazione_invio text, data_invio text, id_cg_ridotto integer, id_cg_cr integer, id_sequestro_partita integer, id_categoria_sottoprodotti integer, bozza boolean, num_aliquote_cf text, num_unita_campionarie text, peso_unita_campionaria text, data_inizio_analisi text, ora_inizio_analisi text, campione_mangime text, campione_sottoprodotti text, strategia_campionamento_conoscitivo text, id_strategia_campionamento_conoscitivo_analita integer, micotossine_conoscitivo text, additivi_nutrizionali_specifica text, additivi_nutrizionali_conoscitivo text, dimensione_porzione text, cf1_peso text, cf1_sigillo text, cf2_peso text, cf2_sigillo text, cf3_peso text, cf3_sigillo text, cf4_peso text, cf4_sigillo text, cf5_peso text, cf5_sigillo text, cf_ulteriore text, cf_ulteriore_peso text, cf_ulteriore_ricerca text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
	 	
BEGIN
	return query
select
        t.ticketid as id_campione
	, v.enteredby
	, v.entered
	, v.id
	, v.numero_scheda
	, (select p.short_description::text from ticket t 
	join lookup_piano_monitoraggio p on t.motivazione_piano_campione = p.code
	where t.ticketid = _idcampione) as campione_motivazione
	, t.assigned_date as campione_data 
	, t.location::text as campione_verbale
	, (select codice_preaccettazione from preaccettazione.get_codice_preaccettazione_da_campione(_idcampione::text)) as campione_codice_preaccettazione
	, asl.description::text as campione_asl
	, (select string_agg(distinct n.descrizione_padre,';') as per_conto_di_completo from tipocontrolloufficialeimprese tcu 
	left join dpat_strutture_asl n on n.id = tcu.id_unita_operativa   
	where tcu.idcontrollo = (select id_controllo_ufficiale::int from ticket where ticketid = _idcampione) and tcu.enabled and (tcu.tipoispezione > 0 or tcu.pianomonitoraggio > 0) 
	and tcu.id_unita_operativa > 0 )as campione_percontodi
	, date_part('year', t.assigned_date)::text as campione_anno
	, CASE WHEN date_part('month', t.assigned_date)= 1 then 'GENNAIO' WHEN date_part('month', t.assigned_date)= 2 then 'FEBBRAIO' WHEN date_part('month', t.assigned_date)= 3 then 'MARZO' WHEN date_part('month', t.assigned_date)= 4 then 'APRILE' WHEN date_part('month', t.assigned_date)= 5 then 'MAGGIO' WHEN date_part('month', t.assigned_date)= 6 then 'GIUGNO' WHEN date_part('month', t.assigned_date)= 7 then 'LUGLIO' WHEN date_part('month', t.assigned_date)= 8 then 'AGOSTO' WHEN date_part('month', t.assigned_date)= 9 then 'SETTEMBRE' WHEN date_part('month', t.assigned_date)= 10 then 'OTTOBRE' WHEN date_part('month', t.assigned_date)= 11 then 'NOVEMBRE' WHEN date_part('month', t.assigned_date)= 12 then 'DICEMBRE' END as campione_mese
	, date_part('day', t.assigned_date)::text as campione_giorno
	, v.campione_ore
	, v.campione_presente 
	, (select string_agg(CASE WHEN a.user_id > 0 THEN concat_ws(' ', c.namefirst, c.namelast) ELSE concat_ws(' ', ce.namefirst, ce.namelast) END, ', ') 
	   from cu_nucleo cun left join access_ a on a.user_id = cun.id_componente 
	   left join contact_ c on c.contact_id = a.contact_id left join access_ext_ ae on ae.user_id = cun.id_componente left join contact_ext_ ce 
	   on ce.contact_id = ae.contact_id where cun.id_controllo_ufficiale::int = (select id_controllo_ufficiale::int from ticket where ticketid = _idcampione)) as campione_sottoscritto 
	, v.campione_num_prelevati 
	, v.id_dpa
	, (select CASE 
			WHEN p.short_description::text ilike '%SORV%' THEN 2
			WHEN p.short_description::text ilike '%MON%' THEN 1
			WHEN p.short_description::text ilike '%EXTRAPIANO%' THEN 4 --- non è contemplato extrapiano mon e extrapiano sorv
			WHEN p.short_description::text ilike '%SOSPETT%' THEN 3
			ELSE 1
		END
		from ticket t 
		join lookup_piano_monitoraggio p on t.motivazione_piano_campione = p.code
		where t.ticketid = _idcampione) AS id_strategia_campionamento
	, v.id_metodo_campionamento
	, (select * from public.get_id_programma_controllo(t.assigned_date, _idcampione)) as id_programma_controllo
	, v.programma_controllo_fa_specifica 
	, v.programma_controllo_an_specifica
	, v.programma_controllo_ci_specifica 
	, v.programma_controllo_at_specifica 
	, v.programma_controllo_ao_specifica 
	, v.programma_controllo_az_specifica 
	, v.programma_controllo_co_fa_specifica 
	, v.programma_controllo_co_ci_specifica   
	, v.programma_controllo_in_ci_specifica
	, v.programma_controllo_in_ra_specifica
	, v.programma_controllo_in_pe_specifica
	, v.micotossine_specifica
	, v.altro_specifica
	, v.id_principi_additivi
	, v.id_principi_additivi_co
	, v.quantita_pa 
	, v.id_contaminanti 	
	, (select string_agg(CASE WHEN a.user_id > 0 THEN concat_ws(' ', c.namefirst, c.namelast) ELSE concat_ws(' ', ce.namefirst, ce.namelast) END, ', ') 
	   from cu_nucleo cun left join access_ a on a.user_id = cun.id_componente 
	   left join contact_ c on c.contact_id = a.contact_id left join access_ext_ ae on ae.user_id = cun.id_componente left join contact_ext_ ce 
	   on ce.contact_id = ae.contact_id where cun.id_controllo_ufficiale::int = (select id_controllo_ufficiale::int from ticket where ticketid = _idcampione)) as prelevatore
	 , v.id_luogo_prelievo
	 --, v.codice_luogo_prelievo 
	 , coalesce(org.account_number, opstab.numero_registrazione, sistab.approval_number)::text as codice_luogo_prelievo  -- modifica 07/12/2021 --> uguale al codice_osa calcolato dopo. Il camp non e' utente ma recuperato dal sistema.
	 , coalesce((select cun_sinvsa from sinvsa_osm_anagrafica_esiti where trashed_date is null and riferimento_id = org.org_id and riferimento_id_nome_tab='organization'),(select cun_sinvsa from sinvsa_osm_anagrafica_esiti where trashed_date is null and riferimento_id = opstab.id and riferimento_id_nome_tab='opu_stabilimento'))---codice sinvsa
	 , v.targa_mezzo 
	, CASE WHEN org.org_id > 0 THEN coalesce(az.indrizzo_azienda::text, orga.addrline1::text) WHEN opstab.id > 0 THEN opind.via::text WHEN sistab.id>0 THEN siind.via::text end, --a8
		CASE WHEN org.org_id > 0 THEN coalesce(azc.comune::text, orga.city::text) WHEN opstab.id > 0 THEN opc.nome::text WHEN sistab.id>0 THEN sic.nome::text end, --a9
		CASE WHEN org.org_id > 0 THEN 
		CASE when org.tipologia = 2 then coalesce(az.prov_sede_azienda::text,orga.city::text) 
		WHEN org.tipologia <> 2 and org.site_id = 201 then 'AV'
		WHEN org.tipologia <> 2 and org.site_id = 202 then 'BN'
		WHEN org.tipologia <> 2 and org.site_id = 203 then 'CE'
		WHEN org.tipologia <> 2 and org.site_id in (204,205,206) then 'NA'
		WHEN org.tipologia <> 2 and org.site_id = 207 then 'SA' END		
		WHEN opstab.id > 0 THEN opprov.description::text WHEN sistab.id>0 THEN siprov.description::text end, --a10
		CASE WHEN org.org_id > 0 THEN coalesce(az.latitudine_geo::text, latitude::text) WHEN opstab.id > 0 THEN opind.latitudine::text WHEN sistab.id>0 THEN siind.latitudine::text end, --a11_1
		CASE WHEN org.org_id > 0 THEN coalesce(az.longitudine_geo::text, longitude::text) WHEN opstab.id > 0 THEN opind.longitudine::text WHEN sistab.id>0 THEN siind.longitudine::text end, --a11_2
		CASE WHEN org.org_id > 0 THEN coalesce(op_prop.nominativo::text, org.name::text) WHEN opstab.id > 0 THEN opop.ragione_sociale::text WHEN sistab.id>0 THEN siop.ragione_sociale::text end, --a12
		CASE WHEN org.org_id > 0 THEN coalesce(op_prop.nominativo::text,concat(org.nome_rappresentante, ' ', org.cognome_rappresentante)::text) WHEN opstab.id > 0 THEN concat(opsf.nome, ' ', opsf.cognome)::text WHEN sistab.id>0 THEN concat(sisf.nome, ' ', sisf.cognome)::text end, --a13
		CASE WHEN org.org_id > 0 THEN COALESCE(op_prop.cf, org.codice_fiscale_rappresentante)::text WHEN opstab.id > 0 THEN opsf.codice_fiscale WHEN sistab.id>0 THEN sisf.codice_fiscale end, --a14
		CASE WHEN org.org_id > 0 THEN coalesce(op_detentore.nominativo::text,concat(org.nome_rappresentante, ' ', org.cognome_rappresentante)::text) WHEN opstab.id > 0 THEN opsf.codice_fiscale::text WHEN sistab.id>0 THEN sisf.codice_fiscale::text end --a15
	 , v.telefono
	 , v.id_matrice_campione  --b1
         , v.lista_specie_vegetale_dichiarata  
	 , v.mangime_semplice_specifica  
	 , v.id_mangime_composto
	 , v.id_premiscela_additivi
	 , v.trattamento_mangime  --b2
	 --, v.confezionamento 
	 , v.id_confezionamento
	 , v.ragione_sociale_ditta_produttrice 
	 , v.indirizzo_ditta_produttrice 
	 , v.lista_specie_alimento_destinato 
	 , v.id_metodo_produzione 
	 , v.nome_commerciale_mangime  --b8
	 , v.lista_stato_prodotto_prelievo 
	 , v.responsabile_etichettatura  --b10
	 , v.indirizzo_responsabile_etichettatura  --b11
	 , v.paese_produzione  --b12
	 , v.data_produzione --b13
	 , v.data_scadenza  --b14
	 , v.num_lotto  --b15
	 , v.dimensione_lotto  --b16
	 , v.ingredienti  -- b17
	 , v.commenti_mangime_prelevato   
	 , v.laboratorio_destinazione --- sezione C
	 , v.id_allega_cartellino 
	 , v.descrizione_attrezzature 
	 , v.num_punti 
	 , v.num_ce 
	 , v.volume 
	 , v.operazioni 
	 , v.volume_2 
	 , v.operazioni_2 
	 , v.numero_cf 
	 , v.quantita_gml 
	 , v.dichiarazione 
	 , v.conservazione_campione  
	 , v.num_copie 	
	 , v.num_campioni_finali 
	 , v.custode 
	 , v.id_campione_finale
	 , v.id_rinuncia_campione 
	 , (select p.codice_esame::text from ticket t 
		join lookup_piano_monitoraggio p on t.motivazione_piano_campione = p.code
		where t.ticketid = _idcampione) as codice_esame 
	, coalesce(org.account_number, opstab.numero_registrazione, sistab.approval_number)::text as codice_osa 
	, (select concat_ws(',',m3.codice_esame,m2.codice_esame,m.codice_esame) from matrici_campioni mc left join 
	   matrici m on m.matrice_id = mc.id_matrice --figlio
	   left join matrici m2 on m2.matrice_id = m.id_padre
	   left join matrici m3 on m3.matrice_id = m2.id_padre
	  where mc.id_campione = _idcampione ) lista_codice_matrice
	, v.volume_3  
	, v.num_campioni_finali_invio 
	, v.num_copie_invio 
	, v.destinazione_invio 
	, v.data_invio 
	, v.id_cg_ridotto 
	, v.id_cg_cr 
	, v.id_sequestro_partita 
	, v.id_categoria_sottoprodotti
    , coalesce(v.bozza, 'true' )
	, v.num_aliquote_cf
	, v.num_unita_campionarie
	, v.peso_unita_campionaria
	, v.data_inizio_analisi
	, v.ora_inizio_analisi
	, v.campione_mangime
	, v.campione_sottoprodotti
	, v.strategia_campionamento_conoscitivo
	, v.id_strategia_campionamento_conoscitivo_analita integer
	, v.micotossine_conoscitivo
	, v.additivi_nutrizionali_specifica
	, v.additivi_nutrizionali_conoscitivo
	, v.dimensione_porzione
	, v.cf1_peso
	, v.cf1_sigillo
	, v.cf2_peso
	, v.cf2_sigillo
	, v.cf3_peso
	, v.cf3_sigillo
	, v.cf4_peso
	, v.cf4_sigillo
	, v.cf5_peso
	, v.cf5_sigillo
	, v.cf_ulteriore
	, v.cf_ulteriore_peso
	, v.cf_ulteriore_ricerca
	from ticket t
	left join lookup_site_id asl on asl.code = t.site_id
	left join modello_pnaa_values v on v.id_campione = t.ticketid and v.trashed_date is null
	left join organization org on t.org_id > 0 and org.org_id = t.org_id and org.trashed_date is null
	-- gestione campi anagrafica
	left join organization_address orga on t.org_id > 0 and orga.org_id = t.org_id and org.trashed_date is null and orga.address_type=5
	left join aziende az ON az.cod_azienda = org.account_number::text AND org.tipologia = 2
	LEFT JOIN operatori_allevamenti op_detentore ON org.cf_correntista::text = op_detentore.cf
	LEFT JOIN operatori_allevamenti op_prop ON org.codice_fiscale_rappresentante::text = op_prop.cf
	LEFT JOIN comuni_old azc ON azc.codiceistatcomune::text = az.cod_comune_azienda
	left join opu_stabilimento opstab on t.id_stabilimento > 0 and opstab.id = t.id_stabilimento and opstab.trashed_date is null
	left join opu_operatore opop on opop.id = opstab.id_operatore
	left join opu_rel_operatore_soggetto_fisico oprelos on oprelos.id_operatore = opop.id
	left join opu_soggetto_fisico opsf on opsf.id = oprelos.id_soggetto_fisico
	left join opu_indirizzo opind on opind.id = opstab.id_indirizzo
	left join comuni1 opc on opc.id = opind.comune
	left join lookup_province opprov on opprov.code = opc.cod_provincia::integer
	left join sintesis_stabilimento sistab on t.alt_id > 0 and sistab.alt_id = t.alt_id and sistab.trashed_date is null
	left join sintesis_operatore siop on siop.id = sistab.id_operatore
	left join sintesis_rel_operatore_soggetto_fisico sirelos on sirelos.id_operatore = siop.id
	left join sintesis_soggetto_fisico sisf on sisf.id = sirelos.id_soggetto_fisico
	left join sintesis_indirizzo siind on siind.id = sistab.id_indirizzo
	left join comuni1 sic on sic.id = siind.comune
	left join lookup_province siprov on siprov.code = sic.cod_provincia::integer
	--left join ricerche_anagrafiche_old_materializzata r ON (t.alt_id = r.riferimento_id AND r.riferimento_id_nome_tab = 'sintesis_stabilimento'::text OR t.id_stabilimento = r.riferimento_id AND r.riferimento_id_nome_tab = 'opu_stabilimento'::text OR t.org_id = r.riferimento_id AND r.riferimento_id_nome_tab = 'organization'::text OR t.id_apiario = r.riferimento_id AND r.riferimento_id_nome_tab = 'apicoltura_imprese'::text) AND t.tipologia = 2 AND t.trashed_date IS NULL
	where t.ticketid = _idcampione and t.trashed_date is null;
 END;
$BODY$;

ALTER FUNCTION public.get_modello_pnaa(integer)
    OWNER TO postgres;



CREATE OR REPLACE FUNCTION public.get_id_programma_controllo(_data_prelievo timestamp without time zone, _id_campione integer)
    RETURNS INTEGER
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE

AS $BODY$

DECLARE
id_programma integer;
	
BEGIN
	
	
	if (_data_prelievo >='2024-01-01') then
			id_programma :=( 
				select CASE  
					WHEN  p.short_description::text ~~* '%BSE%'::text OR p.short_description::text ~~* '%acquacoltura%'::text THEN 1
					WHEN  p.short_description::text ~~* '%SOSTANZE FARMACOLOGICHE%CARRY OVER)'::text THEN 15
					WHEN upper( p.short_description::text) ~~* '%tab. 3.2 finalità 1%'::text THEN 3 
					WHEN upper( p.short_description::text) ~~* '%tab. 3.2 finalità 2%'::text THEN 16
					WHEN upper( p.short_description::text) ~~* '%tab. 3.2 finalità 3%'::text THEN 17
					WHEN upper( p.short_description::text) ~~* '%CONTAMINANTI%'::text OR p.short_description::text ~~* '%radionuclidi%'::text THEN 14
					WHEN  p.short_description::text ~~* '%DIOSSINE%'::text THEN 2
				    WHEN  p.short_description::text ~~* '%OLIGOELEMENTI%'::text THEN 18
					WHEN  p.short_description::text ~~* '%MICOTOSSINE%'::text THEN 12
					WHEN  p.short_description::text ~~* '%SALMONELLA%'::text THEN 7
					WHEN upper(p.short_description::text) ~~* '%OGM AUTORIZZAT%'::text THEN 13
					WHEN upper(p.short_description::text) ~~* '%OGM NON AUTORIZZAT%'::text THEN 9
					ELSE 19 --altro

				END 
				from ticket t 
				join lookup_piano_monitoraggio p on t.motivazione_piano_campione = p.code
				where t.ticketid = _id_campione);
		else
			id_programma :=(
					select CASE  
					WHEN  p.short_description::text ~~* '%BSE%'::text OR p.short_description::text ~~* '%acquacoltura%'::text THEN 1
					WHEN  p.short_description::text ~~* '%SOSTANZE FARMACOLOGICHE%CARRY OVER)'::text THEN 10
					WHEN upper( p.short_description::text) ~~* '%tab. 3.2 finalità 1%'::text THEN 3 
					WHEN upper( p.short_description::text) ~~* '%tab. 3.2 finalità 2%'::text THEN 4
					WHEN upper( p.short_description::text) ~~* '%tab. 3.2 finalità 3%'::text THEN 5
					WHEN upper( p.short_description::text) ~~* '%CONTAMINANTI%'::text OR p.short_description::text ~~* '%radionuclidi%'::text THEN 11
					WHEN  p.short_description::text ~~* '%DIOSSINE%'::text THEN 2
					WHEN  p.short_description::text ~~* '%MICOTOSSINE%'::text THEN 6
					WHEN  p.short_description::text ~~* '%SALMONELLA%'::text THEN 7
					WHEN upper(p.short_description::text) ~~* '%OGM AUTORIZZAT%'::text THEN 8
					WHEN upper(p.short_description::text) ~~* '%OGM NON AUTORIZZAT%'::text THEN 9
					ELSE 19 --altro

				END 
				from ticket t 
				join lookup_piano_monitoraggio p on t.motivazione_piano_campione = p.code
				where t.ticketid = _id_campione) ;
			
		end if;
 
	return id_programma;
END;
$BODY$;

ALTER FUNCTION public.get_id_programma_controllo(timestamp without time zone, Integer)
    OWNER TO postgres;
    

--------------------------------*********************integrazioni flusso del 11/04************************---------------------------

-- integrazione flusso 384
alter table associazione_analiti_piani add column aliquota_conoscitiva_cromo boolean;
alter table associazione_analiti_piani add column aliquota_conoscitiva_micotossine boolean;
alter table associazione_analiti_piani add column aliquota_conoscitiva_nitrati boolean;
alter table associazione_analiti_piani add column aliquota_conoscitiva_radionuclidi boolean;

-- A12_F
update associazione_analiti_piani set aliquota_conoscitiva_cromo=true where id_piano=(select id from dpat_indicatore_new  where alias_indicatore='A12_F' and anno=2024)
and id_analiti_foglia=(select analiti_id from analiti where enabled and nome ='RAME');

--A12_K
update associazione_analiti_piani set aliquota_conoscitiva_micotossine=true where id_piano=(select id from dpat_indicatore_new  where alias_indicatore='A12_K' and anno=2024)
and id_analiti_foglia=(select analiti_id from analiti where enabled and nome ='OCRATOSSINA A' AND id_padre <>3);

update associazione_analiti_piani set aliquota_conoscitiva_micotossine=true where id_piano=(select id from dpat_indicatore_new  where alias_indicatore='A12_K' and anno=2024)
and id_analiti_foglia=(select analiti_id from analiti where enabled and nome ='AFLATOSSINA B1');

update associazione_analiti_piani set aliquota_conoscitiva_micotossine=FALSE where id_piano=(select id from dpat_indicatore_new  where alias_indicatore='A12_K' and anno=2024)
and id_analiti_foglia=(select analiti_id from analiti where enabled and nome ='MICOTOSSINE' and id_padre <>3);

--A12_M
update associazione_analiti_piani set aliquota_conoscitiva_nitrati=true where id_piano=(select id from dpat_indicatore_new  where alias_indicatore='A12_M' and anno=2024)
and id_analiti_foglia=3082;

--A12_U
update associazione_analiti_piani set aliquota_conoscitiva_radionuclidi=true where id_piano=(select id from dpat_indicatore_new  where alias_indicatore ilike '%A12_U%' and anno=2024)
and id_analiti_foglia=(select analiti_id from analiti where enabled and nome ='IMPURITA'' BOTANICHE');

update associazione_analiti_piani set aliquota_conoscitiva_radionuclidi=true where id_piano=(select id from dpat_indicatore_new  where alias_indicatore ilike '%A12_U%' and anno=2024)
and id_analiti_foglia=(select analiti_id from analiti where enabled and nome ='PESTICIDI ORGANOFOSFORATI');


CREATE OR REPLACE FUNCTION public.pnaa_previsti_conoscitivi( _idcampione integer)
    RETURNS table(cromo boolean, micotossine boolean, nitrati boolean, radionuclidi boolean)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE  
motivazione_piano integer;
BEGIN 
		motivazione_piano := (select motivazione_piano_campione from ticket where ticketid = _idcampione and trashed_date is null);
		
	return query
		select  distinct coalesce(asp.aliquota_conoscitiva_cromo, false), coalesce(asp.aliquota_conoscitiva_micotossine, false), 
				coalesce(asp.aliquota_conoscitiva_nitrati,false), coalesce(asp.aliquota_conoscitiva_radionuclidi,false) 
		from analiti_campioni ac
		join associazione_analiti_piani asp on ac.analiti_id = asp.id_analiti_foglia
		where id_campione = _idcampione and asp.trashed_date is null and asp.id_piano = motivazione_piano
		and (asp.aliquota_conoscitiva_cromo =true or aliquota_conoscitiva_micotossine=true or aliquota_conoscitiva_nitrati= true
		or aliquota_conoscitiva_radionuclidi=true) ;
		
END 
$BODY$;

ALTER FUNCTION public.pnaa_previsti_conoscitivi(integer)
    OWNER TO postgres;
    
    
--select * from pnaa_previsti_conoscitivi(2060157)
alter table modello_pnaa_values add column aliquota_conoscitiva_cromo text;
alter table modello_pnaa_values add column aliquota_conoscitiva_micotossine text;
alter table modello_pnaa_values add column aliquota_conoscitiva_nitrati text;
alter table modello_pnaa_values add column aliquota_conoscitiva_radionuclidi text;
    
update lookup_contaminanti set enabled=false where code in (2,3,4,5);
    
 
alter table modello_pnaa_values drop column strategia_campionamento_conoscitivo ;
alter table modello_pnaa_values drop column id_strategia_campionamento_conoscitivo_analita ;
alter table modello_pnaa_values drop column micotossine_conoscitivo ;
alter table modello_pnaa_values drop column additivi_nutrizionali_conoscitivo ;


alter table modello_pnaa_values add column id_micotossine_tipo integer;

CREATE TABLE IF NOT EXISTS public.lookup_pnaa_micotossine
(
    code serial,
    description character varying(150),
    default_item boolean DEFAULT false,
    level integer DEFAULT 0,
    enabled boolean DEFAULT true
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.lookup_animali_non_alimentari
    OWNER to postgres;
	
insert into lookup_pnaa_micotossine(description) values ('Aliquota conoscitiva Ocratossina A');
insert into lookup_pnaa_micotossine(description) values ('Aliquota conoscitiva Zearalenone');
insert into lookup_pnaa_micotossine(description) values ('Aliquota conoscitiva Deossinvalenolo');
insert into lookup_pnaa_micotossine(description) values ('Aliquota conoscitiva Fumonisine (B1 e B2)');
insert into lookup_pnaa_micotossine(description) values ('Aliquota conoscitiva Tossine T2 e Ht2');


-- FUNCTION: public.upsert_modello_pnaa(json)

-- DROP FUNCTION IF EXISTS public.upsert_modello_pnaa(json);

CREATE OR REPLACE FUNCTION public.upsert_modello_pnaa(
	_dati_pnaa json)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE 
	id_modello_pnaa integer;
	conta_campione integer;
	_num_scheda text;
BEGIN

--2. Se esiste, recupera il suo numero_scheda e metti tutto a trashed
--3. Se non esiste, genera un numero_scheda-
--4 .Insert nei values

	conta_campione := (select count(*) from modello_pnaa_values where id_campione = (_dati_pnaa ->>'idCampione')::integer and trashed_date is null);
	raise info '%', conta_campione;
	if (conta_campione > 0) then 
		-- recupera numero scheda e metti tutti i record a trashed;
		_num_scheda := (select numero_scheda from modello_pnaa_values  where id_campione = (_dati_pnaa ->>'idCampione')::integer and trashed_date is null); --1594375 (R00202115574O)
		update modello_pnaa_values set trashed_date=current_date where id_campione = (_dati_pnaa ->>'idCampione')::integer and trashed_date is null;
	else
		-- genera numero scheda + insert
		_num_scheda := (select genera_num_scheda_pnaa from genera_num_scheda_pnaa());
		raise info '%', _num_scheda;
		-- insert nella tabella dei values
	end if;
		
	insert into modello_pnaa_values (
			numero_scheda
			, id_campione   
			, enteredby 
			, campione_num_prelevati 
			, id_metodo_campionamento 
			, id_principi_additivi 
			, id_principi_additivi_co
			, id_contaminanti 
			, programma_controllo_fa_specifica 
			, programma_controllo_an_specifica 
			, programma_controllo_ci_specifica 
			, programma_controllo_at_specifica 
			, programma_controllo_ao_specifica 
			, programma_controllo_az_specifica 
			, programma_controllo_co_fa_specifica 
			, programma_controllo_co_ci_specifica 
			, programma_controllo_in_ci_specifica 
			, programma_controllo_in_ra_specifica 
			, programma_controllo_in_pe_specifica  
			, quantita_pa  
			, id_luogo_prelievo 
			, codice_luogo_prelievo 
			, targa_mezzo 
			, telefono 
			, id_matrice_campione  --b1
			, mangime_semplice_specifica  
			, id_mangime_composto 
			, id_premiscela_additivi 
			, lista_specie_vegetale_dichiarata   
			, trattamento_mangime  --b2
			--, confezionamento 
			, id_confezionamento
			, ragione_sociale_ditta_produttrice 
			, indirizzo_ditta_produttrice 
			, lista_specie_alimento_destinato 
			, id_metodo_produzione 
			, nome_commerciale_mangime  --b8
			, lista_stato_prodotto_prelievo 
			, responsabile_etichettatura  --b10
			, indirizzo_responsabile_etichettatura  --b11
			, paese_produzione  --b12
			, data_produzione  --b13
			, data_scadenza  --b14
			, num_lotto  --b15
			, dimensione_lotto  --b16
			, ingredienti  -- b17
			, commenti_mangime_prelevato 
			, laboratorio_destinazione 
			, id_allega_cartellino 
			, descrizione_attrezzature 
			, num_punti 
			, num_ce 
			, volume 
			, operazioni 
			, volume_2 
			, operazioni_2 
			, numero_cf 
			, quantita_gml 
			, dichiarazione 
			, conservazione_campione  
			, num_copie 
			, num_campioni_finali 
			, custode 
			, id_rinuncia_campione 
			, id_campione_finale 
			, micotossine_specifica 
			, altro_specifica  
			, campione_ore 
			, id_dpa
			, volume_3
			, num_campioni_finali_invio 
			, num_copie_invio
			, destinazione_invio 
			, data_invio
			, campione_presente
			, id_cg_ridotto
			, id_cg_cr 
			, id_sequestro_partita
			, id_categoria_sottoprodotti
			, bozza
			, num_aliquote_cf
			, num_unita_campionarie
			, peso_unita_campionaria
			, data_inizio_analisi
			, ora_inizio_analisi
			, campione_mangime
			, campione_sottoprodotti
			, additivi_nutrizionali_specifica
			, dimensione_porzione
			, cf1_peso
			, cf1_sigillo
			, cf2_peso
			, cf2_sigillo
			, cf3_peso
			, cf3_sigillo
			, cf4_peso
			, cf4_sigillo
			, cf5_peso
			, cf5_sigillo
			, cf_ulteriore
			, cf_ulteriore_peso
			, cf_ulteriore_ricerca
			, aliquota_conoscitiva_cromo
			, aliquota_conoscitiva_micotossine 
			, aliquota_conoscitiva_nitrati 
			, aliquota_conoscitiva_radionuclidi
			, id_micotossine_tipo
		) values
		(	
			_num_scheda,
			(_dati_pnaa ->> 'idCampione')::integer,
			(_dati_pnaa ->> 'enteredBy')::integer,
			_dati_pnaa ->> 'campioneNumPrelevati',
			(_dati_pnaa ->> 'idMetodoCampionamento')::integer,
			(_dati_pnaa ->> 'idPrincipiAdditivi')::integer,
			(_dati_pnaa ->> 'idPrincipiAdditiviCO')::integer,
			(_dati_pnaa ->> 'idContaminanti')::integer,
			_dati_pnaa ->> 'programmaControlloFASpecifica',
			_dati_pnaa ->> 'programmaControlloANSpecifica',
			_dati_pnaa ->> 'programmaControlloCISpecifica',
			_dati_pnaa ->> 'programmaControlloATSpecifica',
			_dati_pnaa ->> 'programmaControlloAOSpecifica',
			_dati_pnaa ->> 'programmaControlloAZSpecifica',
			_dati_pnaa ->> 'programmaControlloCOFASpecifica',
			_dati_pnaa ->> 'programmaControlloCOCISpecifica',
			_dati_pnaa ->> 'programmaControlloINCISpecifica',
			_dati_pnaa ->> 'programmaControlloINRASpecifica',
			_dati_pnaa ->> 'programmaControlloINPESpecifica',
			_dati_pnaa ->> 'quantitaPa',
			(_dati_pnaa ->> 'idLuogoPrelievo')::integer,
			_dati_pnaa ->> 'codiceLuogoPrelievo',
			_dati_pnaa ->> 'targaMezzo',
			_dati_pnaa ->> 'telefono',
			(_dati_pnaa ->> 'idMatriceCampione')::integer,
			_dati_pnaa ->> 'mangimeSempliceSpecifica',
			(_dati_pnaa ->> 'idMangimeComposto')::integer,
			(_dati_pnaa ->> 'idPremiscelaAdditivi')::integer,
			_dati_pnaa ->> 'listaSpecieVegetaleDichiarata',
			_dati_pnaa ->> 'trattamentoMangime',
			(_dati_pnaa ->> 'idConfezionamento')::integer,
			_dati_pnaa ->> 'ragioneSocialeDittaProduttrice',
			_dati_pnaa ->> 'indirizzoDittaProduttrice',
			_dati_pnaa ->> 'listaSpecieAlimentoDestinato',
			(_dati_pnaa ->> 'idMetodoProduzione')::integer,
			_dati_pnaa ->> 'nomeCommercialeMangime',
			_dati_pnaa ->> 'listaStatoProdottoPrelievo',
			_dati_pnaa ->> 'responsabileEtichettatura',
			_dati_pnaa ->> 'indirizzoResponsabileEtichettatura',
			_dati_pnaa ->> 'paeseProduzione',
			_dati_pnaa ->> 'dataProduzione',
			_dati_pnaa ->> 'dataScadenza',
			_dati_pnaa ->> 'numLotto',
			_dati_pnaa ->> 'dimensioneLotto',
			_dati_pnaa ->> 'ingredienti',
			_dati_pnaa ->> 'commentiMangimePrelevato',
			_dati_pnaa ->> 'laboratorioDestinazione',
			(_dati_pnaa ->> 'idAllegaCartellino')::integer,
			_dati_pnaa ->> 'descrizioneAttrezzature',
			_dati_pnaa ->> 'numPunti',
			_dati_pnaa ->> 'numCE',
			_dati_pnaa ->> 'volume',
			_dati_pnaa ->> 'operazioni',
			_dati_pnaa ->> 'volume2',
			_dati_pnaa ->> 'operazioni2',
			_dati_pnaa ->> 'numeroCF',
			_dati_pnaa ->> 'quantitaGML',
			_dati_pnaa ->> 'dichiarazione',
			_dati_pnaa ->> 'conservazioneCampione',
			_dati_pnaa ->> 'numCopie',
			_dati_pnaa ->> 'numCampioniFinali',
			_dati_pnaa ->> 'custode',
			(_dati_pnaa ->> 'idRinunciaCampione')::integer,
			(_dati_pnaa ->> 'idCampioneFinale')::integer,
			_dati_pnaa ->> 'micotossineSpecifica',
			_dati_pnaa ->> 'altroSpecifica', 
			_dati_pnaa ->> 'campioneOre', 
			(_dati_pnaa ->> 'idDpa')::integer,
			_dati_pnaa ->> 'volume3',
			_dati_pnaa ->> 'numCampioniFinaliInvio',
			_dati_pnaa ->> 'numCopieInvio',
			_dati_pnaa ->> 'destinazioneInvio',
			_dati_pnaa ->> 'dataInvio',
			_dati_pnaa ->> 'campionePresente',
			(_dati_pnaa ->> 'idCgRidotto')::integer,
			(_dati_pnaa ->> 'idCgCr')::integer,
			(_dati_pnaa ->> 'idSequestroPartita')::integer,
			(_dati_pnaa ->> 'idCategoriaSottoprodotti')::integer,
			(_dati_pnaa ->> 'bozza')::boolean,
			_dati_pnaa ->> 'numAliquoteCF',
			_dati_pnaa ->> 'numUnitaCampionarie',
			_dati_pnaa ->> 'pesoUnitaCampionaria',
			_dati_pnaa ->> 'dataInizioAnalisi',
			_dati_pnaa ->> 'oraInizioAnalisi',
			_dati_pnaa ->> 'campioneMangime',
			_dati_pnaa ->> 'campioneSottoprodotti',
			_dati_pnaa ->> 'additiviNutrizionaliSpecifica',
			_dati_pnaa ->> 'dimensionePorzione',
			_dati_pnaa ->> 'cf1Peso',
			_dati_pnaa ->> 'cf1Sigillo',
			_dati_pnaa ->> 'cf2Peso',
			_dati_pnaa ->> 'cf2Sigillo',
			_dati_pnaa ->> 'cf3Peso',
			_dati_pnaa ->> 'cf3Sigillo',
			_dati_pnaa ->> 'cf4Peso',
			_dati_pnaa ->> 'cf4Sigillo',
			_dati_pnaa ->> 'cf5Peso',
			_dati_pnaa ->> 'cf5Sigillo',
			_dati_pnaa ->> 'cfUlteriore',
			_dati_pnaa ->> 'cfUlteriorePeso',
			_dati_pnaa ->> 'cfUlterioreRicerca',
			_dati_pnaa ->> 'aliquotaConoscitivaCromo',
			_dati_pnaa ->> 'aliquotaConoscitivaMicotossine',
			_dati_pnaa ->> 'aliquotaConoscitivaNitrati',
			_dati_pnaa ->> 'aliquotaConoscitivaRadionuclidi',
			(_dati_pnaa ->> 'idMicotossineTipo')::integer
		) 
	RETURNING id into id_modello_pnaa;

	return id_modello_pnaa;
END;
$BODY$;

ALTER FUNCTION public.upsert_modello_pnaa(json)
    OWNER TO postgres;


DROP FUNCTION get_modello_pnaa(integer);
CREATE OR REPLACE FUNCTION public.get_modello_pnaa(
	_idcampione integer)
    RETURNS TABLE(id_campione integer, enteredby integer, entered timestamp without time zone, id integer, numero_scheda text, campione_motivazione text, campione_data timestamp without time zone, campione_verbale text, campione_codice_preaccettazione text, campione_asl text, campione_percontodi text, campione_anno text, campione_mese text, campione_giorno text, campione_ore text, campione_presente text, campione_sottoscritto text, campione_num_prelevati text, id_dpa integer, id_strategia_campionamento integer, id_metodo_campionamento integer, id_programma_controllo integer, programma_controllo_fa_specifica text, programma_controllo_an_specifica text, programma_controllo_ci_specifica text, programma_controllo_at_specifica text, programma_controllo_ao_specifica text, programma_controllo_az_specifica text, programma_controllo_co_fa_specifica text, programma_controllo_co_ci_specifica text, programma_controllo_in_ci_specifica text, programma_controllo_in_ra_specifica text, programma_controllo_in_pe_specifica text, micotossine_specifica text, altro_specifica text, id_principi_additivi integer, id_principi_additivi_co integer, quantita_pa text, id_contaminanti integer, prelevatore text, id_luogo_prelievo integer, codice_luogo_prelievo text, codice_sinvsa text, targa_mezzo text, indirizzo_luogo_prelievo text, comune_luogo_prelievo text, provincia_luogo_prelievo text, lat_luogo_prelievo text, lon_luogo_prelievo text, ragione_sociale text, rappresentante_legale text, codice_fiscale text, detentore text, telefono text, id_matrice_campione integer, lista_specie_vegetale_dichiarata text, mangime_semplice_specifica text, id_mangime_composto integer, id_premiscela_additivi integer, trattamento_mangime text, id_confezionamento integer, ragione_sociale_ditta_produttrice text, indirizzo_ditta_produttrice text, lista_specie_alimento_destinato text, id_metodo_produzione integer, nome_commerciale_mangime text, lista_stato_prodotto_prelievo text, responsabile_etichettatura text, indirizzo_responsabile_etichettatura text, paese_produzione text, data_produzione text, data_scadenza text, num_lotto text, dimensione_lotto text, ingredienti text, commenti_mangime_prelevato text, laboratorio_destinazione text, id_allega_cartellino integer, descrizione_attrezzature text, num_punti text, num_ce text, volume text, operazioni text, volume_2 text, operazioni_2 text, numero_cf text, quantita_gml text, dichiarazione text, conservazione_campione text, num_copie text, num_campioni_finali text, custode text, id_campione_finale integer, id_rinuncia_campione integer, codice_esame text, codice_osa text, lista_codice_matrice text, volume_3 text, num_campioni_finali_invio text, num_copie_invio text, destinazione_invio text, data_invio text, id_cg_ridotto integer, id_cg_cr integer, id_sequestro_partita integer, id_categoria_sottoprodotti integer, bozza boolean, num_aliquote_cf text, num_unita_campionarie text, peso_unita_campionaria text, data_inizio_analisi text, ora_inizio_analisi text, campione_mangime text, campione_sottoprodotti text, 
				  additivi_nutrizionali_specifica text, dimensione_porzione text, cf1_peso text, cf1_sigillo text, cf2_peso text, cf2_sigillo text, cf3_peso text, cf3_sigillo text, cf4_peso text, cf4_sigillo text, cf5_peso text, cf5_sigillo text, cf_ulteriore text, cf_ulteriore_peso text, cf_ulteriore_ricerca text, aliquota_conoscitiva_cromo text, aliquota_conoscitiva_micotossine text, aliquota_conoscitiva_nitrati text, aliquota_conoscitiva_radionuclidi text, id_micotossine_tipo integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
	 	
BEGIN
	return query
select
        t.ticketid as id_campione
	, v.enteredby
	, v.entered
	, v.id
	, v.numero_scheda
	, (select p.short_description::text from ticket t 
	join lookup_piano_monitoraggio p on t.motivazione_piano_campione = p.code
	where t.ticketid = _idcampione) as campione_motivazione
	, t.assigned_date as campione_data 
	, t.location::text as campione_verbale
	, (select codice_preaccettazione from preaccettazione.get_codice_preaccettazione_da_campione(_idcampione::text)) as campione_codice_preaccettazione
	, asl.description::text as campione_asl
	, (select string_agg(distinct n.descrizione_padre,';') as per_conto_di_completo from tipocontrolloufficialeimprese tcu 
	left join dpat_strutture_asl n on n.id = tcu.id_unita_operativa   
	where tcu.idcontrollo = (select id_controllo_ufficiale::int from ticket where ticketid = _idcampione) and tcu.enabled and (tcu.tipoispezione > 0 or tcu.pianomonitoraggio > 0) 
	and tcu.id_unita_operativa > 0 )as campione_percontodi
	, date_part('year', t.assigned_date)::text as campione_anno
	, CASE WHEN date_part('month', t.assigned_date)= 1 then 'GENNAIO' WHEN date_part('month', t.assigned_date)= 2 then 'FEBBRAIO' WHEN date_part('month', t.assigned_date)= 3 then 'MARZO' WHEN date_part('month', t.assigned_date)= 4 then 'APRILE' WHEN date_part('month', t.assigned_date)= 5 then 'MAGGIO' WHEN date_part('month', t.assigned_date)= 6 then 'GIUGNO' WHEN date_part('month', t.assigned_date)= 7 then 'LUGLIO' WHEN date_part('month', t.assigned_date)= 8 then 'AGOSTO' WHEN date_part('month', t.assigned_date)= 9 then 'SETTEMBRE' WHEN date_part('month', t.assigned_date)= 10 then 'OTTOBRE' WHEN date_part('month', t.assigned_date)= 11 then 'NOVEMBRE' WHEN date_part('month', t.assigned_date)= 12 then 'DICEMBRE' END as campione_mese
	, date_part('day', t.assigned_date)::text as campione_giorno
	, v.campione_ore
	, v.campione_presente 
	, (select string_agg(CASE WHEN a.user_id > 0 THEN concat_ws(' ', c.namefirst, c.namelast) ELSE concat_ws(' ', ce.namefirst, ce.namelast) END, ', ') 
	   from cu_nucleo cun left join access_ a on a.user_id = cun.id_componente 
	   left join contact_ c on c.contact_id = a.contact_id left join access_ext_ ae on ae.user_id = cun.id_componente left join contact_ext_ ce 
	   on ce.contact_id = ae.contact_id where cun.id_controllo_ufficiale::int = (select id_controllo_ufficiale::int from ticket where ticketid = _idcampione)) as campione_sottoscritto 
	, v.campione_num_prelevati 
	, v.id_dpa
	, (select CASE 
			WHEN p.short_description::text ilike '%SORV%' THEN 2
			WHEN p.short_description::text ilike '%MON%' THEN 1
			WHEN p.short_description::text ilike '%EXTRAPIANO%' THEN 4 --- non è contemplato extrapiano mon e extrapiano sorv
			WHEN p.short_description::text ilike '%SOSPETT%' THEN 3
			ELSE 1
		END
		from ticket t 
		join lookup_piano_monitoraggio p on t.motivazione_piano_campione = p.code
		where t.ticketid = _idcampione) AS id_strategia_campionamento
	, v.id_metodo_campionamento
	, (select * from public.get_id_programma_controllo(t.assigned_date, _idcampione)) as id_programma_controllo
	, v.programma_controllo_fa_specifica 
	, v.programma_controllo_an_specifica
	, v.programma_controllo_ci_specifica 
	, v.programma_controllo_at_specifica 
	, v.programma_controllo_ao_specifica 
	, v.programma_controllo_az_specifica 
	, v.programma_controllo_co_fa_specifica 
	, v.programma_controllo_co_ci_specifica   
	, v.programma_controllo_in_ci_specifica
	, v.programma_controllo_in_ra_specifica
	, v.programma_controllo_in_pe_specifica
	, v.micotossine_specifica
	, v.altro_specifica
	, v.id_principi_additivi
	, v.id_principi_additivi_co
	, v.quantita_pa 
	, v.id_contaminanti 	
	, (select string_agg(CASE WHEN a.user_id > 0 THEN concat_ws(' ', c.namefirst, c.namelast) ELSE concat_ws(' ', ce.namefirst, ce.namelast) END, ', ') 
	   from cu_nucleo cun left join access_ a on a.user_id = cun.id_componente 
	   left join contact_ c on c.contact_id = a.contact_id left join access_ext_ ae on ae.user_id = cun.id_componente left join contact_ext_ ce 
	   on ce.contact_id = ae.contact_id where cun.id_controllo_ufficiale::int = (select id_controllo_ufficiale::int from ticket where ticketid = _idcampione)) as prelevatore
	 , v.id_luogo_prelievo
	 --, v.codice_luogo_prelievo 
	 , coalesce(org.account_number, opstab.numero_registrazione, sistab.approval_number)::text as codice_luogo_prelievo  -- modifica 07/12/2021 --> uguale al codice_osa calcolato dopo. Il camp non e' utente ma recuperato dal sistema.
	 , coalesce((select cun_sinvsa from sinvsa_osm_anagrafica_esiti where trashed_date is null and riferimento_id = org.org_id and riferimento_id_nome_tab='organization'),(select cun_sinvsa from sinvsa_osm_anagrafica_esiti where trashed_date is null and riferimento_id = opstab.id and riferimento_id_nome_tab='opu_stabilimento'))---codice sinvsa
	 , v.targa_mezzo 
	, CASE WHEN org.org_id > 0 THEN coalesce(az.indrizzo_azienda::text, orga.addrline1::text) WHEN opstab.id > 0 THEN opind.via::text WHEN sistab.id>0 THEN siind.via::text end, --a8
		CASE WHEN org.org_id > 0 THEN coalesce(azc.comune::text, orga.city::text) WHEN opstab.id > 0 THEN opc.nome::text WHEN sistab.id>0 THEN sic.nome::text end, --a9
		CASE WHEN org.org_id > 0 THEN 
		CASE when org.tipologia = 2 then coalesce(az.prov_sede_azienda::text,orga.city::text) 
		WHEN org.tipologia <> 2 and org.site_id = 201 then 'AV'
		WHEN org.tipologia <> 2 and org.site_id = 202 then 'BN'
		WHEN org.tipologia <> 2 and org.site_id = 203 then 'CE'
		WHEN org.tipologia <> 2 and org.site_id in (204,205,206) then 'NA'
		WHEN org.tipologia <> 2 and org.site_id = 207 then 'SA' END		
		WHEN opstab.id > 0 THEN opprov.description::text WHEN sistab.id>0 THEN siprov.description::text end, --a10
		CASE WHEN org.org_id > 0 THEN coalesce(az.latitudine_geo::text, latitude::text) WHEN opstab.id > 0 THEN opind.latitudine::text WHEN sistab.id>0 THEN siind.latitudine::text end, --a11_1
		CASE WHEN org.org_id > 0 THEN coalesce(az.longitudine_geo::text, longitude::text) WHEN opstab.id > 0 THEN opind.longitudine::text WHEN sistab.id>0 THEN siind.longitudine::text end, --a11_2
		CASE WHEN org.org_id > 0 THEN coalesce(op_prop.nominativo::text, org.name::text) WHEN opstab.id > 0 THEN opop.ragione_sociale::text WHEN sistab.id>0 THEN siop.ragione_sociale::text end, --a12
		CASE WHEN org.org_id > 0 THEN coalesce(op_prop.nominativo::text,concat(org.nome_rappresentante, ' ', org.cognome_rappresentante)::text) WHEN opstab.id > 0 THEN concat(opsf.nome, ' ', opsf.cognome)::text WHEN sistab.id>0 THEN concat(sisf.nome, ' ', sisf.cognome)::text end, --a13
		CASE WHEN org.org_id > 0 THEN COALESCE(op_prop.cf, org.codice_fiscale_rappresentante)::text WHEN opstab.id > 0 THEN opsf.codice_fiscale WHEN sistab.id>0 THEN sisf.codice_fiscale end, --a14
		CASE WHEN org.org_id > 0 THEN coalesce(op_detentore.nominativo::text,concat(org.nome_rappresentante, ' ', org.cognome_rappresentante)::text) WHEN opstab.id > 0 THEN opsf.codice_fiscale::text WHEN sistab.id>0 THEN sisf.codice_fiscale::text end --a15
	 , v.telefono
	 , v.id_matrice_campione  --b1
         , v.lista_specie_vegetale_dichiarata  
	 , v.mangime_semplice_specifica  
	 , v.id_mangime_composto
	 , v.id_premiscela_additivi
	 , v.trattamento_mangime  --b2
	 --, v.confezionamento 
	 , v.id_confezionamento
	 , v.ragione_sociale_ditta_produttrice 
	 , v.indirizzo_ditta_produttrice 
	 , v.lista_specie_alimento_destinato 
	 , v.id_metodo_produzione 
	 , v.nome_commerciale_mangime  --b8
	 , v.lista_stato_prodotto_prelievo 
	 , v.responsabile_etichettatura  --b10
	 , v.indirizzo_responsabile_etichettatura  --b11
	 , v.paese_produzione  --b12
	 , v.data_produzione --b13
	 , v.data_scadenza  --b14
	 , v.num_lotto  --b15
	 , v.dimensione_lotto  --b16
	 , v.ingredienti  -- b17
	 , v.commenti_mangime_prelevato   
	 , v.laboratorio_destinazione --- sezione C
	 , v.id_allega_cartellino 
	 , v.descrizione_attrezzature 
	 , v.num_punti 
	 , v.num_ce 
	 , v.volume 
	 , v.operazioni 
	 , v.volume_2 
	 , v.operazioni_2 
	 , v.numero_cf 
	 , v.quantita_gml 
	 , v.dichiarazione 
	 , v.conservazione_campione  
	 , v.num_copie 	
	 , v.num_campioni_finali 
	 , v.custode 
	 , v.id_campione_finale
	 , v.id_rinuncia_campione 
	 , (select p.codice_esame::text from ticket t 
		join lookup_piano_monitoraggio p on t.motivazione_piano_campione = p.code
		where t.ticketid = _idcampione) as codice_esame 
	, coalesce(org.account_number, opstab.numero_registrazione, sistab.approval_number)::text as codice_osa 
	, (select concat_ws(',',m3.codice_esame,m2.codice_esame,m.codice_esame) from matrici_campioni mc left join 
	   matrici m on m.matrice_id = mc.id_matrice --figlio
	   left join matrici m2 on m2.matrice_id = m.id_padre
	   left join matrici m3 on m3.matrice_id = m2.id_padre
	  where mc.id_campione = _idcampione ) lista_codice_matrice
	, v.volume_3  
	, v.num_campioni_finali_invio 
	, v.num_copie_invio 
	, v.destinazione_invio 
	, v.data_invio 
	, v.id_cg_ridotto 
	, v.id_cg_cr 
	, v.id_sequestro_partita 
	, v.id_categoria_sottoprodotti
    , coalesce(v.bozza, 'true' )
	, v.num_aliquote_cf
	, v.num_unita_campionarie
	, v.peso_unita_campionaria
	, v.data_inizio_analisi
	, v.ora_inizio_analisi
	, v.campione_mangime
	, v.campione_sottoprodotti
	, v.additivi_nutrizionali_specifica
	, v.dimensione_porzione
	, v.cf1_peso
	, v.cf1_sigillo
	, v.cf2_peso
	, v.cf2_sigillo
	, v.cf3_peso
	, v.cf3_sigillo
	, v.cf4_peso
	, v.cf4_sigillo
	, v.cf5_peso
	, v.cf5_sigillo
	, v.cf_ulteriore
	, v.cf_ulteriore_peso
	, v.cf_ulteriore_ricerca
	, v.aliquota_conoscitiva_cromo
	, v.aliquota_conoscitiva_micotossine
	, v.aliquota_conoscitiva_nitrati
	, v.aliquota_conoscitiva_radionuclidi
	, v.id_micotossine_tipo
	from ticket t
	left join lookup_site_id asl on asl.code = t.site_id
	left join modello_pnaa_values v on v.id_campione = t.ticketid and v.trashed_date is null
	left join organization org on t.org_id > 0 and org.org_id = t.org_id and org.trashed_date is null
	-- gestione campi anagrafica
	left join organization_address orga on t.org_id > 0 and orga.org_id = t.org_id and org.trashed_date is null and orga.address_type=5
	left join aziende az ON az.cod_azienda = org.account_number::text AND org.tipologia = 2
	LEFT JOIN operatori_allevamenti op_detentore ON org.cf_correntista::text = op_detentore.cf
	LEFT JOIN operatori_allevamenti op_prop ON org.codice_fiscale_rappresentante::text = op_prop.cf
	LEFT JOIN comuni_old azc ON azc.codiceistatcomune::text = az.cod_comune_azienda
	left join opu_stabilimento opstab on t.id_stabilimento > 0 and opstab.id = t.id_stabilimento and opstab.trashed_date is null
	left join opu_operatore opop on opop.id = opstab.id_operatore
	left join opu_rel_operatore_soggetto_fisico oprelos on oprelos.id_operatore = opop.id
	left join opu_soggetto_fisico opsf on opsf.id = oprelos.id_soggetto_fisico
	left join opu_indirizzo opind on opind.id = opstab.id_indirizzo
	left join comuni1 opc on opc.id = opind.comune
	left join lookup_province opprov on opprov.code = opc.cod_provincia::integer
	left join sintesis_stabilimento sistab on t.alt_id > 0 and sistab.alt_id = t.alt_id and sistab.trashed_date is null
	left join sintesis_operatore siop on siop.id = sistab.id_operatore
	left join sintesis_rel_operatore_soggetto_fisico sirelos on sirelos.id_operatore = siop.id
	left join sintesis_soggetto_fisico sisf on sisf.id = sirelos.id_soggetto_fisico
	left join sintesis_indirizzo siind on siind.id = sistab.id_indirizzo
	left join comuni1 sic on sic.id = siind.comune
	left join lookup_province siprov on siprov.code = sic.cod_provincia::integer
	--left join ricerche_anagrafiche_old_materializzata r ON (t.alt_id = r.riferimento_id AND r.riferimento_id_nome_tab = 'sintesis_stabilimento'::text OR t.id_stabilimento = r.riferimento_id AND r.riferimento_id_nome_tab = 'opu_stabilimento'::text OR t.org_id = r.riferimento_id AND r.riferimento_id_nome_tab = 'organization'::text OR t.id_apiario = r.riferimento_id AND r.riferimento_id_nome_tab = 'apicoltura_imprese'::text) AND t.tipologia = 2 AND t.trashed_date IS NULL
	where t.ticketid = _idcampione and t.trashed_date is null;
 END;
$BODY$;

ALTER FUNCTION public.get_modello_pnaa(integer)
    OWNER TO postgres;


 DROP FUNCTION IF EXISTS digemon.estrazione_campioni_pnaa(timestamp without time zone, timestamp without time zone);

CREATE OR REPLACE FUNCTION digemon.estrazione_campioni_pnaa(
	_data_1 timestamp without time zone,
	_data_2 timestamp without time zone)
    RETURNS TABLE("id campione" integer, "id controllo" integer, "numero scheda" text, "Codice Accettazione" text, 
				  "Data campione" timestamp without time zone, "Verbale campione" text, "Codice preaccettazione campione" text, 
				  "Asl campione" text, "CU Per conto di" text, "Verbale Anno" text, "Verbale Mese" text, 
				  "Verbale giorno" text, "Verbale ore" text, "Verbale Presente al prelievo" text, 
				  "Verbale sottoscritti" text, "Verbale Numero campioni prelevati" text, "Verbale Campioni Mangime/Acqua" text, 
				  "Verbale DPA" text, "Verbale Campioni sottoprodotti" text, "A1. Strategia di campionamento" text, 
				  --"A1. Conoscitivo" text, 
				 -- "A1. Analita Conoscitivo" text, 
				  "A2. Metodo di campionamento" text, 
				  "A3. Programma di Controllo" text, 
				  "A3. spec. principi farmac. attivi per princ/sost" text, 
				  "A3. spec. additivi nutriz. per principi o sostanze" text, 
				  "A3. spec. cocciodiostatici/istomonostatici per princ/sost" text, 
				  "A3. spec. additivi tecnologici princ/sost" text, 
				  "A3. spec. Principi additivi organolettici princ/sost" text, 
				  "A3. spec. additivi zootecnici per princ/sost" text, 
				  "A3. spec. principi farm. attivi carry over  (o sostanze)" text, 
				  "A3. spec. coccidiostatici/istomonastici carry over" text, 
				  "A3. spec. contamin. inorganici e composti azotati" text, 
				  "A3. specifica radionuclidi" text, 
				  "A3. specifica pesticidi" text, 
				  "A3. specifica micotossine" text, 
				  "A3. tipo conoscitivo micotossine" text, 
				  "A3. specifica additivi nutrizionali" text, 
				 -- "A3. additivi nutrizionali conoscitivo per cromo" text, 
				  "A3. specifica altro" text, 
				  "A3. Principi farmacologicamente attivi (o sostanze)" text, 
				  "A3. Principi farmacologicamente attivi carry over" text, 
				  "A3. Quantità di P.A/Cocc." text, 
				  "A3. Contaminanti inorganici e composti az, pe, ra" text, 
				  "A3. Aliquota conoscitiva per Cromo" text,
				  "A3. Aliquota conoscitiva per Micotossine" text,
				  "A3. Aliquota conoscitiva per Nitrati" text,
				  "A3. Aliquota conoscitiva per Radionuclidi" text,
				  "A4. Prelevatore" text, 
				  "A5. Luogo di prelievo" text, 
				  "A6. Codice luogo di prelievo" text, "A7. Targa mezzo di trasporto" text, "A8. Indirizzo del luogo di prelievo" text, "A9. Comune" text, "A10. Provincia" text, "A11. Latitudine luogo" text, "A11. Longitudine luogo" text, "A12. Ragione sociale" text, "A13. Rappresentante legale" text, "A14. Codice fiscale" text, "A15. Detentore" text, "A16. Telefono" text, "B1. Matrice del campione" text, "B1. Specie vegetale dichiarata" text, "B1. Specifica materia prima/mangime semplice" text, "B1. Mangime composto" text, "B1. Premiscela additivi" text, "B1. Categoria Sottoprodotti" text, "B2. Trattamento mangime" text, "B3. Confezionamento" text, "B4. Ragione sociale ditta produttrice" text, "B5. Indrizzo ditta produttrice" text, "B6. Specie e categoria animale per alimento" text, "B7. Metodo di produzione" text, "B8. Nome commerciale mangime" text, "B9. Stato prodotto" text, "B10. Ragione sociale responsabile etichettatura" text, "B11. Indirizzo responsabile etichettatura" text, "B12. Paese di produzione" text, "B13. Data di produzione" text, "B14. Data di scadenza" text, "B15. Numero di lotto" text, "B16. Dimensione del lotto" text, "B16bis. Dimensione porzione campionata" text, "B17. Ingredienti" text, "B18. Commenti ulteriori sul mangime" text, "C1. Laboratorio destinazione" text, "D. Informazioni cartellino" text, "D. Descrizione attrezzature" text, "D. Num punti" text, "D. Num CE" text, "D. Peso Volume" text, "D. Operazioni" text, "D. Volume finale" text, "D. CG ridotto" text, "D. Kg/lt" text, "D. CG/CR" text, "D. Operazioni campione globale" text, "D. CF" text, "D. g/ml" text, "D. CF1 peso" text, "D. CF1 sigillo" text, "D. CF2 peso" text, "D. CF2 sigillo" text, "D. CF3 peso" text, "D. CF3 sigillo" text, "D. CF4 peso" text, "D. CF4 sigillo" text, "D. CF5 peso" text, "D. CF5 sigillo" text, "D. CF ulteriore" text, "D. CF ulteriore peso" text, "D. CF ulteriore ricerca" text, "D. Dichiarazione" text, "D. Numero campioni finali inviati" text, "D. Numero copie inviate" text, "D. Destinazione invio" text, "D. Data invio" text, "D. Conservazione campione" text, "D. Numero copia/e" text, "D. Numero campioni finali" text, "D. Custode campione" text, "D. Per conto di" text, "D. Rinuncia per controversia/controperizia" text, "D. Sequestro partita" text, "Codice SINVSA" text, "Macroarea" text, "Aggregazione" text, "Linea" text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
   rec integer;
   macroarea_ text;
   aggregazione_ text;
   linea_ text;
BEGIN
     FOR rec IN
        SELECT t.ticketid from ticket t
		join dpat_indicatore_new dpat on dpat.id = t.motivazione_piano_campione and dpat.codice_esame in ('PNASV', 'PNAMT') -- valutare se mettere lookup_piano_monitoraggio?
		join ticket cu on cu.ticketid::text = t.id_controllo_ufficiale and cu.trashed_date is null and t.trashed_date is null
		and (t.assigned_date between _data_1 and _data_2) 
		--and (t.assigned_date between '2020-01-01' and '2020-12-31') --470 id_campione
     LOOP
		
		--ricavo la linea attivita completa
		select distinct macroarea,COALESCE(categoria,aggregazione),linea_attivita from public.get_linee_attivita(
			(select case 
				when alt_id is not null and alt_id > 0 then alt_id
				when id_stabilimento is not null and id_stabilimento > 0 then id_stabilimento
				when org_id is not null and org_id > 0 then org_id
			end id_
			from ticket t where trashed_date is null and ticketid = (select id_controllo_ufficiale::int from ticket where ticketid = rec and trashed_date is null and tipologia=2)),
			(select case 
				when alt_id is not null and alt_id > 0 then 'sintesis_stabilimento'
				when id_stabilimento is not null and id_stabilimento > 0 then 'opu_stabilimento'
				when org_id is not null and org_id > 0 then 'organization'
			end tipo_
			from ticket t where trashed_date is null and ticketid = (select id_controllo_ufficiale::int from ticket where ticketid = rec and trashed_date is null and tipologia=2)),
			'false',
			(select id_controllo_ufficiale::int from ticket where ticketid = rec and trashed_date is null and tipologia=2))
		into macroarea_,aggregazione_,linea_;
		
		--split linea	
		IF linea_ ilike '%->%' THEN 
			linea_ := (select split_part(linea_,'->',3));
		END IF;
		
        RETURN QUERY
        with cte as (SELECT 
		a.id_campione
		, (select id_controllo_ufficiale::int from ticket where ticketid = a.id_campione) as id_controllo
		, a.numero_scheda 	
		, (select cause from ticket where ticketid = a.id_campione)::text as codice_accettazione
		, a.campione_data 
		, a.campione_verbale 
		, a.campione_codice_preaccettazione 
		, a.campione_asl 
		, a.campione_percontodi 
		, a.campione_anno 
		, a.campione_mese 
		, a.campione_giorno 
		, a.campione_ore 
		, a.campione_presente 
		, a.campione_sottoscritto 
		, a.campione_num_prelevati  --20sima colonna
		-- new
		, a.campione_mangime
		-- fine new
		, g.description::text as id_dpa 
		--new
		, a.campione_sottoprodotti			 
		-- fine new
		, f.description::text as id_strategia_campionamento 
		, h.description::text as id_metodo_campionamento 
		, a.campione_motivazione 
		, a.programma_controllo_fa_specifica 
		, a.programma_controllo_an_specifica
		, a.programma_controllo_ci_specifica 
		, a.programma_controllo_at_specifica 
		, a.programma_controllo_ao_specifica 
		, a.programma_controllo_az_specifica 
		, a.programma_controllo_co_fa_specifica 
		, a.programma_controllo_co_ci_specifica 
		, a.programma_controllo_in_ci_specifica
		, a.programma_controllo_in_ra_specifica 
		, a.programma_controllo_in_pe_specifica  --35sima
		, a.micotossine_specifica 
		, v.description::text as tipo_micotossine
		, a.additivi_nutrizionali_specifica			 
		, a.altro_specifica  
		, i.description::text as id_principi_additivi 
		, j.description::text as id_principi_additivi_co 
		, a.quantita_pa 
		, k.description::text as id_contaminanti 
		, a.aliquota_conoscitiva_cromo
		, a.aliquota_conoscitiva_micotossine
		, a.aliquota_conoscitiva_nitrati
		, a.aliquota_conoscitiva_radionuclidi
		, a.prelevatore 
		, l.description::text as id_luogo_prelievo 
		, a.codice_luogo_prelievo 
		, a.targa_mezzo 
		, a.indirizzo_luogo_prelievo 
		, a.comune_luogo_prelievo 
		, a.provincia_luogo_prelievo 
		, a.lat_luogo_prelievo 
		, a.lon_luogo_prelievo 
		, a.ragione_sociale 
		, a.rappresentante_legale 
		, a.codice_fiscale 
		, a.detentore 
		, a.telefono 
		, m.description::text as id_matrice_campione  --b1
		, case when length(a.lista_specie_vegetale_dichiarata) > 0 then (select string_agg(description,' - ') from lookup_specie_vegetale_pnaa  where code in (
		   select unnest(string_to_array(substring(a.lista_specie_vegetale_dichiarata,1,length(a.lista_specie_vegetale_dichiarata)-1), ','))::int))  
		  else '' end as lista_specie_vegetale_dichiarata   
		, a.mangime_semplice_specifica  
		, c.description::text as id_mangime_composto 
		, d.description::text as id_premiscela_additivi 
		, u.description::text as id_categoria_sottoprodotto 
		, a.trattamento_mangime  --b2
		--, a.confezionamento 
		, q.description::text as confezionamento --confezionamento
		, a.ragione_sociale_ditta_produttrice 
		, a.indirizzo_ditta_produttrice 
		, case when length(a.lista_specie_alimento_destinato) > 0 then (select string_agg(description,' - ') from lookup_specie_alimento  where code in (
		   select unnest(string_to_array(substring(a.lista_specie_alimento_destinato,1,length(a.lista_specie_alimento_destinato)-1), ','))::int)) 
		   else '' end as lista_specie_alimento_destinato  
		, n.description::text as id_metodo_produzione 
		, a.nome_commerciale_mangime  --b8
		, case when length(a.lista_stato_prodotto_prelievo) > 0 then (select string_agg(description,' - ') from lookup_prodotti_pnaa where code in (
		   select unnest(string_to_array(substring(a.lista_stato_prodotto_prelievo,1,length(a.lista_stato_prodotto_prelievo)-1), ','))::int)) 
		   else '' end as lista_stato_prodotto_prelievo 
		, a.responsabile_etichettatura  --b10
		, a.indirizzo_responsabile_etichettatura  --b11
		, a.paese_produzione  --b12
		, a.data_produzione  --b13
		, a.data_scadenza  --b14
		, a.num_lotto  --b15
		, a.dimensione_lotto  --b16
		-- new
		, a.dimensione_porzione --b16bis			 
		-- new
		, a.ingredienti  -- b17
		, a.commenti_mangime_prelevato 
		, a.laboratorio_destinazione 
		, e.description::text as id_allega_cartellino 
		, a.descrizione_attrezzature 
		, a.num_punti 
		, a.num_ce 
		, a.volume 
		, a.operazioni
		, a.volume_3
		, r.description::text as cg_ridotto
		, a.volume_2 
		, s.description::text as cg_cr
		, a.operazioni_2 
		, a.numero_cf 
		, a.quantita_gml 
		----------------- inizio blocco nuovo
		, a.cf1_peso
		, a.cf1_sigillo
		, a.cf2_peso
		, a.cf2_sigillo
		, a.cf3_peso
		, a.cf3_sigillo
		, a.cf4_peso
		, a.cf4_sigillo
		, a.cf5_peso
		, a.cf5_sigillo
		, a.cf_ulteriore
		, a.cf_ulteriore_peso
		, a.cf_ulteriore_ricerca			 
		----------------- fine blocco nuovo
		, a.dichiarazione
		, a.num_campioni_finali_invio
		, a.num_copie_invio
		, a.destinazione_invio 
		, a.data_invio
		, a.conservazione_campione  
		, a.num_copie 
		, a.num_campioni_finali
		, a.custode 
		, o.description::text as id_campione_finale 
		, p.description:: text as id_rinuncia_campione 
		, t.description::text as sequestro_partita
		, a.codice_sinvsa::text
		, macroarea_ as macroarea
		, aggregazione_ as aggregazione
		, linea_ as linea
		FROM get_modello_pnaa(rec) a
		left join lookup_pnaa_mangime_composto c on c.code = a.id_mangime_composto
		left join lookup_pnaa_premiscela_additivi d on d.code = a.id_premiscela_additivi
		left join lookup_pnaa_si_no e on e.code = a.id_allega_cartellino
		left join lookup_pnaa_strategia_campionamento f on f.code = a.id_strategia_campionamento
		left join lookup_dpa g on g.code = a.id_dpa
		left join lookup_metodo_campionamento h on h.code = a.id_metodo_campionamento
		left join lookup_principi_farm_attivi_additivi i on i.code = a.id_principi_additivi
		left join lookup_principi_farm_attivi_additivi_carryover j on j.code = a.id_principi_additivi_co
		left join lookup_contaminanti k on k.code = a.id_contaminanti
		left join lookup_luogo_prelievo l on l.code = a.id_luogo_prelievo
		left join lookup_matrice_campione_sinvsa_new m on m.code =  a.id_matrice_campione
		left join lookup_circuito_pna n on n.code = a.id_metodo_produzione
		left join lookup_pnaa_campione_finale o on o.code = a.id_campione_finale
		left join lookup_pnaa_si_no p on p.code = a.id_rinuncia_campione 
		left join lookup_pnaa_confezionamento q on q.code = a.id_confezionamento
		left join lookup_pnaa_cg_ridotto r on r.code = a.id_cg_ridotto
		left join lookup_pnaa_cg_cr s on s.code = a.id_cg_cr
		left join lookup_pnaa_sequestro_partita t on t.code = a.id_sequestro_partita
		left join lookup_pnaa_categoria_sottoprodotti u on t.code = a.id_categoria_sottoprodotti
		left join lookup_pnaa_micotossine v on v.code = a.id_micotossine_tipo
		)
	  select distinct 
		  cte.id_campione
		, cte.id_controllo
		, cte.numero_scheda
		, cte.codice_accettazione
		, cte.campione_data 
		, cte.campione_verbale 
		, cte.campione_codice_preaccettazione 
		, cte.campione_asl 
		, cte.campione_percontodi 
		, cte.campione_anno 
		, cte.campione_mese 
		, cte.campione_giorno
		, cte.campione_ore 
		, cte.campione_presente 
		, cte.campione_sottoscritto 
		, cte.campione_num_prelevati  --20sima colonna
		-- new
		, cte.campione_mangime
		-- fine new
		, cte.id_dpa
		-- new
		, cte.campione_sottoprodotti
		-- fine new		 
		, cte.id_strategia_campionamento
		, cte.id_metodo_campionamento 
		, cte.campione_motivazione 
		, cte.programma_controllo_fa_specifica 
		, cte.programma_controllo_an_specifica
		, cte.programma_controllo_ci_specifica 
		, cte.programma_controllo_at_specifica 
		, cte.programma_controllo_ao_specifica 
		, cte.programma_controllo_az_specifica 
		, cte.programma_controllo_co_fa_specifica 
		, cte.programma_controllo_co_ci_specifica 
		, cte.programma_controllo_in_ci_specifica 
		, cte.programma_controllo_in_ra_specifica 
		, cte.programma_controllo_in_pe_specifica  --35sima
		, cte.micotossine_specifica 
		, cte.tipo_micotossine
		, cte.additivi_nutrizionali_specifica
		, cte.altro_specifica  
		, cte.id_principi_additivi 
		, cte.id_principi_additivi_co 
		, cte.quantita_pa 
		, cte.id_contaminanti
		, cte.aliquota_conoscitiva_cromo
		, cte.aliquota_conoscitiva_micotossine
		, cte.aliquota_conoscitiva_nitrati
		, cte.aliquota_conoscitiva_radionuclidi
		, cte.prelevatore 
		, cte.id_luogo_prelievo 
		, cte.codice_luogo_prelievo 
		, cte.targa_mezzo 
		, cte.indirizzo_luogo_prelievo 
		, cte.comune_luogo_prelievo 
		, cte.provincia_luogo_prelievo 
		, cte.lat_luogo_prelievo 
		, cte.lon_luogo_prelievo 
		, cte.ragione_sociale 
		, cte.rappresentante_legale 
		, cte.codice_fiscale 
		, cte.detentore 
		, cte.telefono 
		, cte.id_matrice_campione  --b1
		, cte.lista_specie_vegetale_dichiarata   
		, cte.mangime_semplice_specifica  
		, cte.id_mangime_composto 
		, cte.id_premiscela_additivi 
		, cte.id_categoria_sottoprodotto
		, cte.trattamento_mangime  --b2
		, cte.confezionamento 
		, cte.ragione_sociale_ditta_produttrice 
		, cte.indirizzo_ditta_produttrice 
		, cte.lista_specie_alimento_destinato 
		, cte.id_metodo_produzione 
		, cte.nome_commerciale_mangime  --b8
		, cte.lista_stato_prodotto_prelievo 
		, cte.responsabile_etichettatura  --b10
		, cte.indirizzo_responsabile_etichettatura  --b11
		, cte.paese_produzione  --b12
		, cte.data_produzione  --b13
		, cte.data_scadenza  --b14
		, cte.num_lotto  --b15
		, cte.dimensione_lotto  --b16
		-- new
		, cte.dimensione_porzione --b16bis
		-- fine new
		, cte.ingredienti  -- b17
		, cte.commenti_mangime_prelevato 
		, cte.laboratorio_destinazione 
		, cte.id_allega_cartellino 
		, cte.descrizione_attrezzature 
		, cte.num_punti 
		, cte.num_ce 
		, cte.volume 
		, cte.operazioni
		, cte.volume_3
		, cte.cg_ridotto --
		, cte.volume_2
		, cte.cg_cr
		, cte.operazioni_2 
		, cte.numero_cf 
		, cte.quantita_gml 
		------------------------ inizio blocco new
		, cte.cf1_peso
		, cte.cf1_sigillo
		, cte.cf2_peso
		, cte.cf2_sigillo
		, cte.cf3_peso
		, cte.cf3_sigillo
		, cte.cf4_peso
		, cte.cf4_sigillo
		, cte.cf5_peso
		, cte.cf5_sigillo
		, cte.cf_ulteriore
		, cte.cf_ulteriore_peso
		, cte.cf_ulteriore_ricerca		
		----------------------- fine blocco new
		, cte.dichiarazione 
		, cte.num_campioni_finali_invio
		, cte.num_copie_invio
		, cte.destinazione_invio
		, cte.data_invio 
		, cte.conservazione_campione  
		, cte.num_copie 
		, cte.num_campioni_finali
		, cte.custode 
		, cte.id_campione_finale 
		, cte.id_rinuncia_campione
		, cte.sequestro_partita
		, cte.codice_sinvsa
		, cte.macroarea
		, cte.aggregazione
		, cte.linea
	 from cte; --rec in input dovrebbe essere il singolo campione
     END LOOP;
END
$BODY$;

ALTER FUNCTION digemon.estrazione_campioni_pnaa(timestamp without time zone, timestamp without time zone)
    OWNER TO postgres;
    
select * from	digemon.estrazione_campioni_pnaa('2024-01-01','2024-04-25')
 