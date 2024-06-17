--DROP FUNCTION get_modello_5(integer)
CREATE OR REPLACE FUNCTION public.get_modello_5(IN _idcu integer)
  RETURNS TABLE(controllo_id integer, enteredby integer, entered timestamp without time zone, modifiedby integer, modified timestamp without time zone, id integer, bozza boolean, controllo_asl text, controllo_anno integer, 
  controllo_mese text, controllo_giorno integer, controllo_ore text, controllo_nucleo text, controllo_oggetto text, controllo_piano text, controllo_attivita text, controllo_ncformali text, 
  controllo_ncsignificative text, controllo_ncgravi text, controllo_ncformalipunti text, controllo_ncsignificativepunti text, controllo_ncgravipunti text, controllo_ncformalival text, controllo_ncsignificativeval text, 
  stabilimento_comune text, stabilimento_indirizzo text, stabilimento_civico text, stabilimento_num_registrazione text, stabilimento_ce text, operatore_ragione_sociale text, operatore_comune text, operatore_indirizzo text, 
  operatore_civico text, operatore_partita_iva text, rappresentante_nome text, rappresentante_comune_nascita text, rappresentante_data_nascita text, rappresentante_comune text, rappresentante_indirizzo text, rappresentante_civico text, 
  rappresentante_domicilio_digitale text, controllo_linea text, controllo_data_fine text, header_servizio text, header_pec1 text, header_uo text, header_pec2 text, presente_nome text, presente_comune_nascita text, 
  presente_data_nascita text, presente_comune text, presente_indirizzo text, presente_civico text, presente_documento text, presente_documento_numeri text, presente_modalita_ispezione text, responsabile_procedimento text,
   provvedimenti_non_imputabili text, nc_formali_giorni_risoluzione text, nc_significative_giorni_risoluzione text, 
  nc_significative_ulteriore_ispezione text,
  nc_significative_prove_inviate text,
nc_significative_verifica text,
nc_significative_verifica_data text,
nc_significative_verifica_ora text,
nc_significative_verifica_piattaforma text,
nc_significative_verifica_stanza text,
   nc_gravi_constestazione text, nc_gravi_accertamento text, nc_gravi_diffida text,
    nc_gravi_sequestro_amministrativo text, nc_gravi_sequestro_penale text, nc_gravi_blocco text, nc_gravi_dispone text, nc_gravi_constestazione_desc text, nc_gravi_diffida_desc text, nc_gravi_sequestro_amministrativo_desc text, 
    nc_gravi_sequestro_penale_desc text, nc_gravi_blocco_desc text, nc_gravi_dispone_desc text, 
nc_gravi_diffida_eliminazione text, nc_gravi_diffida_eliminazione_numero text,
    valutazione_rischio text, presente_dichiarazione text, note text, ispezione_verifica text, azioni_descrizione text, nc_punteggio_totale text) AS
$BODY$
DECLARE
	 	
BEGIN

FOR controllo_id, enteredby, entered, modifiedby, modified, id, bozza, controllo_asl, controllo_anno, controllo_mese, controllo_giorno, controllo_ore, controllo_nucleo, controllo_oggetto, controllo_piano, controllo_attivita, controllo_ncformali, controllo_ncsignificative, controllo_ncgravi, controllo_ncformalipunti, controllo_ncsignificativepunti, controllo_ncgravipunti, controllo_ncformalival,  controllo_ncsignificativeval, stabilimento_comune, stabilimento_indirizzo, stabilimento_civico, stabilimento_num_registrazione, stabilimento_ce, operatore_ragione_sociale, operatore_comune, operatore_indirizzo, operatore_civico, operatore_partita_iva, rappresentante_nome, rappresentante_comune_nascita, rappresentante_data_nascita, rappresentante_comune, rappresentante_indirizzo, rappresentante_civico, rappresentante_domicilio_digitale, controllo_linea, controllo_data_fine, header_servizio,header_pec1,header_uo,header_pec2,presente_nome,presente_comune_nascita,presente_data_nascita,presente_comune, presente_indirizzo,presente_civico,presente_documento,presente_documento_numeri,presente_modalita_ispezione, responsabile_procedimento,
provvedimenti_non_imputabili, nc_formali_giorni_risoluzione, nc_significative_giorni_risoluzione, 
--new 08/09/22
nc_significative_ulteriore_ispezione,
nc_significative_prove_inviate,
nc_significative_verifica,
nc_significative_verifica_data,
nc_significative_verifica_ora,
nc_significative_verifica_piattaforma,
nc_significative_verifica_stanza,
--
nc_gravi_constestazione, 
nc_gravi_accertamento, nc_gravi_diffida, nc_gravi_sequestro_amministrativo, nc_gravi_sequestro_penale, nc_gravi_blocco, nc_gravi_dispone, 
nc_gravi_constestazione_desc, 
nc_gravi_diffida_desc, 
nc_gravi_sequestro_amministrativo_desc, nc_gravi_sequestro_penale_desc, nc_gravi_blocco_desc, nc_gravi_dispone_desc, 
--new 08/09/22
nc_gravi_diffida_eliminazione,
nc_gravi_diffida_eliminazione_numero,
--
valutazione_rischio, presente_dichiarazione, note, ispezione_verifica, azioni_descrizione , nc_punteggio_totale
		in

SELECT distinct
t.ticketid as controllo_id
,v.enteredby
,v.entered
,v.modifiedby
,v.modified
,v.id
,case when t.flag_mod5 = 'false' then false else true end as bozza
,asl.description as controllo_asl
,date_part('year', t.assigned_date) as controllo_anno
, CASE WHEN date_part('month', t.assigned_date)= 1 then 'GENNAIO' WHEN date_part('month', t.assigned_date)= 2 then 'FEBBRAIO' WHEN date_part('month', t.assigned_date)= 3 then 'MARZO' WHEN date_part('month', t.assigned_date)= 4 then 'APRILE' WHEN date_part('month', t.assigned_date)= 5 then 'MAGGIO' WHEN date_part('month', t.assigned_date)= 6 then 'GIUGNO' WHEN date_part('month', t.assigned_date)= 7 then 'LUGLIO' WHEN date_part('month', t.assigned_date)= 8 then 'AGOSTO' WHEN date_part('month', t.assigned_date)= 9 then 'SETTEMBRE' WHEN date_part('month', t.assigned_date)= 10 then 'OTTOBRE' WHEN date_part('month', t.assigned_date)= 11 then 'NOVEMBRE' WHEN date_part('month', t.assigned_date)= 12 then 'DICEMBRE' END as controllo_mese
, date_part('day', t.assigned_date) as controllo_giorno
,v.controllo_ore
,(select string_agg(CASE WHEN a.user_id > 0 THEN concat_ws(' ', c.namefirst, c.namelast) ELSE concat_ws(' ', ce.namefirst, ce.namelast) END, ', ') from cu_nucleo cun left join access_ a on a.user_id = cun.id_componente left join contact_ c on c.contact_id = a.contact_id left join access_ext_ ae on ae.user_id = cun.id_componente left join contact_ext_ ce on ce.contact_id = ae.contact_id where cun.id_controllo_ufficiale = _idcu) as controllo_nucleo
,(select CONCAT_WS(E'\n', string_agg(a.oggetti, E'\n'), (select
CONCAT( 
case when num_documento_accompagnamento <> '' then 'Num. Documento di Accompagnam. Controllati: '||num_documento_accompagnamento else '' end , 
case when num_specie1 > 0 or num_specie2 > 0 or num_specie3 > 0 or num_specie6 > 0 or num_specie5 > 0 or num_specie9 > 0 or num_specie14 > 0 or num_specie15 > 0 or num_specie22 > 0 or num_specie23 > 0 or num_specie24 > 0 or num_specie25 > 0 or num_specie26 > 0  then ' Specie controllate: ' else '' end ,
case when num_specie1 > 0 then ' Bovini: '||num_specie1 else '' end ,
case when num_specie2 > 0 then ' Suini: '||num_specie2 else '' end ,
case when num_specie3 > 0 then ' Equidi: '||num_specie3 else '' end ,
case when num_specie6 > 0 then ' Altre specie: '||num_specie6 else '' end ,
case when num_specie5 > 0 then ' Bufali: '||num_specie5 else '' end ,
case when num_specie9 > 0 then ' Conigli: '||num_specie9 else '' end ,
case when num_specie14 > 0 then ' Cani: '||num_specie14 else '' end ,
case when num_specie15 > 0 then ' Ovicaprini: '||num_specie15 else '' end ,
case when num_specie22 > 0 then ' Pollame: '||num_specie22 else '' end ,
case when num_specie23 > 0 then ' Pesci: '||num_specie23 else '' end ,
case when num_specie24 > 0 then ' Uccelli: '||num_specie24 else '' end ,
case when num_specie25 > 0 then ' Rettili: '||num_specie25 else '' end ,
case when num_specie26 > 0 then ' Altro: '||num_specie26 else '' end 
) from ticket where ticketid = _idcu)) FROM
(select concat_ws(' -> ', m.description,string_agg(i.description, ';')) as oggetti
from tipocontrolloufficialeimprese tcu
join lookup_ispezione i on i.code = tcu.ispezione and i.enabled
join lookup_ispezione_macrocategorie m on m.code = i.level and m.enabled
where tcu.idcontrollo  = _idcu and tcu.enabled group by m.description) a) as controllo_oggetto
, (select string_agg(p.short_description, E'\n') from tipocontrolloufficialeimprese tcu 
join lookup_piano_monitoraggio p on tcu.pianomonitoraggio = p.code
and tcu.idcontrollo = _idcu and tcu.enabled and tcu.pianomonitoraggio>0) as controllo_piano
, (select string_agg(concat_ws(' ', i.alias, i.description), E'\n') from tipocontrolloufficialeimprese tcu 
join lookup_tipo_ispezione i on tcu.tipoispezione = i.code
and tcu.idcontrollo = _idcu and tcu.enabled and tcu.pianomonitoraggio<0) as controllo_attivita
, (SELECT string_agg(CONCAT('[NC', aa.rnum,'] ', aa.note), ' ') from (SELECT nc.note,
    row_number() OVER () as rnum
  FROM salvataggio_nc_note nc where nc.idticket in (select ticketid from ticket where  id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and tipologia = 1) aa) as controllo_ncformali
, (SELECT string_agg(CONCAT('[NC', aa.rnum,'] ', aa.note), ' ') from (SELECT nc.note,
    row_number() OVER () as rnum
  FROM salvataggio_nc_note nc where nc.idticket in (select ticketid from ticket where  id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and tipologia = 2) aa) as controllo_ncsignificative
, (SELECT string_agg(CONCAT('[NC', aa.rnum,'] ', aa.note), ' ') from (SELECT nc.note,
    row_number() OVER () as rnum
  FROM salvataggio_nc_note nc where nc.idticket in (select ticketid from ticket where  id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and tipologia = 3) aa) as controllo_ncgravi
, (select puntiformali from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncformalipunti
, (select puntisignificativi from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncsignificativepunti
, (select puntigravi from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncgravipunti
, (select nc_formali_valutazione from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncformalival
, (select nc_significative_valutazione from ticket where ticketid in (select ticketid from ticket where id_controllo_ufficiale = _idcu::text and tipologia = 8 and trashed_date is null) and trashed_date is null) as controllo_ncsignificativeval
, r.comune as stabilimento_comune
,r.indirizzo as stabilimento_indirizzo
,COALESCE(opu_ind.civico, sin_ind.civico, org_ind.civico) as stabilimento_civico
,r.n_reg as stabilimento_num_registrazione
,v.stabilimento_ce
,r.ragione_sociale as operatore_ragione_sociale
,r.comune_leg as operatore_comune
,r.indirizzo_leg as operatore_indirizzo
,COALESCE(opu_ind_leg.civico, sin_ind_leg.civico, org_ind_leg.civico) as operatore_civico
,r.partita_iva as operatore_partita_iva
,r.nominativo_rappresentante as rappresentante_nome
,COALESCE(opu_sog.comune_nascita, sin_sog.comune_nascita) as rappresentante_comune_nascita
,to_char(COALESCE(opu_sog.data_nascita, sin_sog.data_nascita), 'dd/MM/yyyy') as rappresentante_data_nascita
,COALESCE(opu_com_sog.nome, sin_com_sog.nome) as rappresentante_comune
,COALESCE(opu_sog_ind.via, sin_sog_ind.via) as rappresentante_indirizzo
,COALESCE(opu_sog_ind.civico, sin_sog_ind.civico) as rappresentante_civico
,COALESCE(opu_sog.email, sin_sog.email) as rappresentante_domicilio_digitale
,ml8.attivita as controllo_linea
,case when t.data_fine_controllo is null then to_char(t.assigned_date, 'dd/MM/yyyy') else to_char(t.data_fine_controllo, 'dd/MM/yyyy')  end  as controllo_data_fine     
,v.header_servizio
,v.header_pec1
,v.header_uo
,v.header_pec2
,v.presente_nome
,v.presente_comune_nascita
,v.presente_data_nascita
,v.presente_comune
,v.presente_indirizzo
,v.presente_civico
,v.presente_documento
,v.presente_documento_numeri
,v.presente_modalita_ispezione
,v.responsabile_procedimento
,v.provvedimenti_non_imputabili
,v.nc_formali_giorni_risoluzione
,v.nc_significative_giorni_risoluzione
,v.nc_significative_ulteriore_ispezione
,v.nc_significative_prove_inviate
,v.nc_significative_verifica
,v.nc_significative_verifica_data
,v.nc_significative_verifica_ora
,v.nc_significative_verifica_piattaforma
,v.nc_significative_verifica_stanza
,v.nc_gravi_constestazione
,v.nc_gravi_accertamento
,v.nc_gravi_diffida
,v.nc_gravi_sequestro_amministrativo
,v.nc_gravi_sequestro_penale
,v.nc_gravi_blocco
,v.nc_gravi_dispone
,v.nc_gravi_constestazione_desc
,v.nc_gravi_diffida_desc
,v.nc_gravi_sequestro_amministrativo_desc
,v.nc_gravi_sequestro_penale_desc
,v.nc_gravi_blocco_desc
,v.nc_gravi_dispone_desc
,v.nc_gravi_diffida_eliminazione
,v.nc_gravi_diffida_eliminazione_numero
,v.valutazione_rischio
,v.presente_dichiarazione
,v.note
,v.ispezione_verifica
,v.azioni_descrizione
,v.nc_punteggio_totale

from ticket t
left join lookup_site_id asl on asl.code = t.site_id
left join ricerche_anagrafiche_old_materializzata r on 
((t.org_id > 0 and r.riferimento_id = t.org_id and r.riferimento_id_nome_tab = 'organization')
or (t.id_stabilimento > 0 and r.riferimento_id = t.id_stabilimento and r.riferimento_id_nome_tab = 'opu_stabilimento')
or (t.alt_id > 0 and r.riferimento_id = t.alt_id))
left join linee_attivita_controlli_ufficiali lacu on lacu.id_controllo_ufficiale = t.ticketid
left join ml8_linee_attivita_nuove_materializzata ml8 on ml8.codice_attivita = lacu.codice_linea
left join modello_5_values v on v.id_controllo = t.ticketid and v.trashed_date is null
left join opu_indirizzo opu_ind on opu_ind.id = r.id_sede_operativa and r.riferimento_id_nome_tab = 'opu_stabilimento'
left join sintesis_indirizzo sin_ind on sin_ind.id = r.id_sede_operativa and r.riferimento_id_nome_tab = 'sintesis_stabilimento'
left join organization_address org_ind on org_ind.address_id= r.id_sede_operativa and r.riferimento_id_nome_tab = 'organization'
left join opu_indirizzo opu_ind_leg on opu_ind_leg.id = r.id_indirizzo_impresa and r.riferimento_id_nome_tab = 'opu_stabilimento'
left join sintesis_indirizzo sin_ind_leg on sin_ind_leg.id = r.id_indirizzo_impresa and r.riferimento_id_nome_tab = 'sintesis_stabilimento'
left join organization_address org_ind_leg on org_ind_leg.address_id= r.id_indirizzo_impresa and r.riferimento_id_nome_tab = 'organization'
left join opu_soggetto_fisico opu_sog on opu_sog.id = r.id_soggetto_fisico and r.riferimento_id_nome_tab = 'opu_stabilimento'
left join sintesis_soggetto_fisico sin_sog on sin_sog.id = r.id_soggetto_fisico and r.riferimento_id_nome_tab = 'sintesis_stabilimento'
left join opu_indirizzo opu_sog_ind on opu_sog_ind.id = opu_sog.indirizzo_id
left join sintesis_indirizzo sin_sog_ind on sin_sog_ind.id = sin_sog.indirizzo_id
left join comuni1 opu_com_sog on opu_com_sog.id = opu_sog_ind.comune
left join comuni1 sin_com_sog on sin_com_sog.id = sin_sog_ind.comune
where t.ticketid = _idcu

 LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
    
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_modello_5(integer)
  OWNER TO postgres;

alter TABLE  modello_5_values add column nc_gravi_diffida_eliminazione text;
alter TABLE  modello_5_values  add column nc_gravi_diffida_eliminazione_numero text;
alter TABLE  modello_5_values  add column nc_significative_ulteriore_ispezione text;
alter TABLE  modello_5_values  add column nc_significative_prove_inviate text;
alter TABLE  modello_5_values  add column nc_significative_verifica text;
alter TABLE  modello_5_values  add column nc_significative_verifica_data text;
alter TABLE  modello_5_values  add column nc_significative_verifica_ora text;
alter TABLE  modello_5_values  add column nc_significative_verifica_piattaforma text;
alter TABLE  modello_5_values  add column nc_significative_verifica_stanza text;


--select * from public.get_modello_5(1710760)