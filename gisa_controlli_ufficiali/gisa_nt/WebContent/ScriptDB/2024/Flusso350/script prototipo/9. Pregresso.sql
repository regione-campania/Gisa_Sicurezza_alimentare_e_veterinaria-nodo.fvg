--GISA
CREATE TABLE public.opu_informazioni_pregresse_struttura
(
  id_rel_stab_lp integer,
  tipologia_sinaaf text,
  cf_responsabile text,
  privato boolean,
  cf_proprietario text,
  cf_gestore text,
  vet_id_fiscale text,
  capacita text,
  tipologia_sinaaf_vet text,
  cani boolean,
  gatti boolean,
  altri_animali boolean
)
WITH ( OIDS=FALSE);
ALTER TABLE public.opu_informazioni_pregresse_struttura OWNER TO postgres;
GRANT ALL ON TABLE public.opu_informazioni_pregresse_struttura TO postgres;

--Scaricare file xls nuovi, convertire in csv con delimitatore | e charset UTF-8, uploadare su macchina db sotto tmp, eseguire: COPY strutture_detenzione_sinac from '/tmp/elencocanili.csv' delimiter '|' csv;
CREATE TABLE public.strutture_detenzione_sinac
(
  CODICE_ASL text,
  DENOMINAZIONE_ASL text,	
  CODICE text,	
  CODICE_REGIONALE text,	
  DENOMINAZIONE text,	
  TIPOLOGIA_STRUTTURA text,	
  PARTITA_IVA text,	
  INDIRIZZO text,	
  CAP text,	
  COMUNE text,	
  PROVINCIA text,	
  LATITUDINE text,	
  LONGITUDINE text,	
  TEL_FISSO text,	
  TEL_MOBILE text,	
  FAX text,	
  EMAIL text,	
  CAPACITA text,	
  INIZIO_ATTIVITA text,
  FINE_ATTIVITA text,	
  CANILE_PRIVATO text,	
  PROPRIETARIO text,	
  ID_FISCALE_PROPRIETARIO text,	
  COMUNE_PROPRIETARIO text,	
  CAP_PROPRIETARIO text,	
  PROVINCIA_PROPRIETARIO text,	
  GESTORE text,	
  ID_FISCALE_GESTORE text
)
WITH ( OIDS=FALSE);
ALTER TABLE public.strutture_detenzione_sinac OWNER TO postgres;
GRANT ALL ON TABLE public.strutture_detenzione_sinac TO postgres;


CREATE TABLE public.strutture_veterinarie_sinac
(
  CODICE_ASL	text, 
  DENOMINAZIONE_ASL	text, 	
  CODICE	text, 	
  DENOMINAZIONE	text, 	
  TIPOLOGIA_STRUTTURA	text, 	
  PARTITA_IVA	text, 	
  INDIRIZZO	text, 	
  CAP	text, 	
  COMUNE	text, 	
  PROVINCIA	text, 	
  LATITUDINE	text, 	
  LONGITUDINE	text, 	
  TEL_FISSO	text, 	
  TEL_MOBILE	text, 	
  FAX	text, 	
  EMAIL	text, 	
  INIZIO_ATTIVITA	text, 	
  FINE_ATTIVITA	text, 	
  RESPONSABILE	text, 	
  ID_FISCALE_RESPONSABILE	text, 	
  INIZIO_RESPONSABILE	text 

)
WITH ( OIDS=FALSE);
ALTER TABLE public.strutture_veterinarie_sinac OWNER TO postgres;
GRANT ALL ON TABLE public.strutture_veterinarie_sinac TO postgres;




insert into opu_informazioni_pregresse_struttura (id_rel_stab_lp, cani, gatti, altri_animali) values(451792, false, false, true);
insert into opu_informazioni_pregresse_struttura (id_rel_stab_lp, cani, gatti, altri_animali) values(449401, false, false, true);
insert into opu_informazioni_pregresse_struttura (id_rel_stab_lp, cani, gatti, altri_animali) values(449513, false, false, true);
insert into opu_informazioni_pregresse_struttura (id_rel_stab_lp, cani, gatti, altri_animali) values(443669, false, false, true);
insert into opu_informazioni_pregresse_struttura (id_rel_stab_lp, cani, gatti, altri_animali) values(452472, false, false, true);
insert into opu_informazioni_pregresse_struttura (id_rel_stab_lp, cani, gatti, altri_animali) values(452616, false, false, true);


--BDU
--Confrontare i dati del rapp legale tra i sistemi
--Confronto tra BDU, GISA, VAM e SINAC
--Query di confronto a partire bdu left join verso gisa e viceversa. man mano che si fanno le azioni correttive avremo che le query convergeranno
--tutti quelli in gisa devono stare in bdu e viceversa
--Portare tipologia_sinaaf_vet,  tipologia_sinaaf, codice_sinaaf, id_sinaaf, capacita, cf_proprietario, cf_gestore, vet_id_fiscale, privato in Gisa 
--Verificare discordanze tra tipologia_sinaaf_vet,  tipologia_sinaaf,  prese da configurazione
--Verificare discordanze tra capacita, cf_proprietario, cf_gestore, vet_id_fiscale pregresse, privato  prese da query normale
--adeguare le dbi di propagazione per far tenere conto dei dati portati in gisa dal recupero del pregresso







drop view strutture_detenzione_bdu;
create or replace view strutture_detenzione_bdu as
select 
	upper(asl.description) as asl,
        rel.id, 
        upper(op.ragione_sociale) as ragione_sociale, 
        upper(op.partita_iva) as partita_iva,
        upper(op.codice_fiscale_impresa) as codice_fiscale_impresa,
	case 
		when rel.id_linea_produttiva = 4 then 'OPERATORE COMMERCIALE/IMPORTATORE'
		when rel.id_linea_produttiva = 5 then 'CANILE'
		when rel.id_linea_produttiva = 6 then 'OPERATORE COMMERCIALE'
	end as linea_produttiva,
	upper(ind_op.via) as sede_legale_via , 
	upper(com_op.nome) as sede_legale_comune,
        upper(sogg_op.codice_fiscale) as cf_resp_legale,
      	upper(ind_stab.via) as stab_indirizzo , 
	upper(com_stab.nome)  as stab_comune,
 	ind_stab.longitudine  , 
	ind_stab.latitudine  , 
	case 
		when info_c.mq_disponibili is not null then info_c.mq_disponibili 
		else info_comm.mq_disponibili
	end as mq_disponibili,
        info_c.tipologia_sinaaf_vet,
	info_c.tipologia_sinaaf,
	rel.codice_sinaaf,
        rel.id_sinaaf,
        rel.data_fine, 
	rel.data_inizio, 
	rel.telefono1 as telefono_struttura, 
        rel.telefono2 as telefono_struttura2,
        stab.id_stabilimento_gisa,
        info_c.capacita,
        case 
		when info_c.cf_proprietario is not null and info_c.cf_proprietario <> '' then info_c.cf_proprietario
		else info_comm.cf_proprietario
	end as cf_proprietario,
	case 
		when info_c.cf_gestore is not null and info_c.cf_gestore <> '' then info_c.cf_gestore
		else info_comm.cf_gestore
	end as cf_gestore,
	info_c.vet_id_fiscale,
	info_c.privato

        -- stab.entered,
	/*concat(sogg.nome, sogg.cognome) as   rapp_legale_nominativo,    
        sogg.telefono1  as   rapp_legale_telefono ,
        sogg.telefono   as   rapp_legale_telefono1  ,
        sogg.provincia_residenza  as   rapp_legale_telefono_provincia_res ,
        sogg.provincia_nascita  as   rapp_legale_telefono_provincia_nas,
        
        sogg.indirizzo_residenza  ,
        sogg.codice_fiscale_fittizio_sinaaf  ,
        sogg.id_sinaaf  ,
        sogg.email  ,
        sogg.documento_identita  ,
        sogg.data_nascita  ,
        sogg.comune_residenza  ,
        sogg.comune_nascita  ,
        sogg.cognome   ,*/
       /*com_sogg_nascita.nome,*/  
	--ind_stab.provincia  , 
	--sogg.codice_fiscale as cf_responsabile,
	--ind_stab.comune  , 
	--ind_stab.cap,
	--prov_stab.description,
	--ind_op.provincia  ,
	--ind_op.comune  , 
	--ind_op.cap,
	
	/*sogg_op.telefono1  ,
	sogg_op.telefono   ,
	sogg_op.sesso ,
	sogg_op.provincia_residenza  ,
	sogg_op.provincia_nascita ,
	
	sogg_op.nome  ,
	sogg_op.indirizzo_residenza  ,
	sogg_op.codice_fiscale_fittizio_sinaaf  ,
	sogg_op.id_sinaaf  ,
	sogg_op.email  ,
	sogg_op.documento_identita  ,
	sogg_op.data_nascita  ,
	sogg_op.comune_residenza  ,
	sogg_op.comune_nascita  ,
	sogg_op.cognome   ,*/
	
	--com_sogg_op_nascita.nome


	/* rel.note, 
        rel.note_internal_use_only, 
        stab.note_internal_use_only_hd, 
        op.note_internal_use_only,  
        op.note,
        sogg.note_internal_use_only_hd,
        info_c.note_internal_use_only,
        info_c.note,
        ind_stab.note_internal_use_only  , 
        ind_op.note_internal_use_only  , 
        sogg_op.note_internal_use_only_hd  */

        /*
	 info_c.vet_id_fiscale ,
        info_c.cf_responsabile   ,
	info_c.privato,*/
	/*info_comm.mq_disponibili    ,
	info_c.capacita,
	info_c.cf_proprietario   ,
	info_comm.cf_proprietario ,
	info_c.cf_gestore   ,
	info_comm.cf_gestore,
        */
	-- stab.id as id_stabilimento, 
	--rel.modified_sinaaf,         
from opu_relazione_stabilimento_linee_produttive rel
join opu_stabilimento stab on stab.id = rel.id_stabilimento
left join opu_indirizzo ind_stab on ind_stab.id = stab.id_indirizzo
left join comuni1 com_stab on com_stab.id = ind_stab.comune
left join lookup_province prov_stab on prov_stab.code::text = ind_stab.provincia
left join opu_soggetto_fisico sogg on sogg.id = stab.id_soggetto_fisico and sogg.trashed_date is null
left join lookup_province prov_nas_sogg on prov_nas_sogg.code::text = sogg.provincia_nascita
left join comuni1 com_sogg_nascita on upper(com_sogg_nascita.nome) = upper(sogg.comune_nascita)
join opu_operatore op on op.id = stab.id_operatore and op.trashed_date is null
left join opu_relazione_operatore_sede rel_op_sede on rel_op_sede.id_operatore = op.id
left join opu_indirizzo ind_op on ind_op.id = rel_op_sede.id_indirizzo
left join comuni1 com_op on ind_op.comune = com_op.id
left join opu_rel_operatore_soggetto_fisico rel_op_sogg on rel_op_sogg.id_operatore = op.id and rel_op_sogg.enabled
left join opu_soggetto_fisico sogg_op on sogg_op.id = rel_op_sogg.id_soggetto_fisico and sogg_op.trashed_date is null
left join comuni1 com_sogg_op_nascita on upper(com_sogg_op_nascita.nome) = upper(sogg_op.comune_nascita)
left join lookup_province prov_nas_sogg_op on prov_nas_sogg_op.code::text = sogg_op.provincia_nascita
left join opu_informazioni_canile info_c on info_c.id_relazione_stabilimento_linea_produttiva = rel.id
left join opu_informazioni_commerciali info_comm on info_comm.id_relazione_stabilimento_lp = rel.id
left join lookup_asl_rif asl on asl.code = com_stab.codiceistatasl::integer   
where rel.trashed_date is null and rel.id_linea_produttiva in (4,5,6)
order by com_stab.codiceistatasl   , op.ragione_sociale;




--count: 566  
select * from strutture_detenzione_bdu;




--GISA
drop view strutture_detenzione_gisa;

create or replace view strutture_detenzione_gisa as
select 
asl.description as asl,
stab.id as id_stabilimento_gisa,
rel.id as id_rel_stab_lp,
upper(op.ragione_sociale) as ragione_sociale, 
upper(op.partita_iva) as partita_iva,
upper(op.codice_fiscale_impresa) as codice_fiscale_impresa,
upper(ml8.macroarea || ' -> ' || ml8.aggregazione || ' -> ' || ml8.attivita)  as linea_produttiva,
ml8.codice as codice_linea,
upper(ind_op.via) as sede_legale_via , 
upper(com_op.nome) as sede_legale_comune,
upper(sogg_op.codice_fiscale) as cf_resp_legale,
upper(ind_stab.via) as stab_indirizzo , 
upper(com_stab.nome)  as stab_comune,
ind_stab.longitudine  , 
ind_stab.latitudine  ,
value.valore_campo as mq_disponibili,
rel.codice_sinaaf,
rel.id_sinaaf, 
rel.data_fine, 
rel.data_inizio, 
upper(rel.telefono1) as telefono_struttura, 
upper(rel.telefono2) as telefono_struttura2,
flag.bdu,
null as org_id_c,
rel.entered,
coalesce(info_preg.cani,true) as cani,
coalesce(info_preg.gatti,true) as gatti,
coalesce(info_preg.altri_animali,true) as altri_animali
from opu_relazione_stabilimento_linee_produttive rel
join opu_stabilimento stab on stab.id = rel.id_stabilimento
left join opu_indirizzo ind_stab on ind_stab.id = stab.id_indirizzo
left join comuni1 com_stab on com_stab.id = ind_stab.comune
left join lookup_province prov_stab on prov_stab.code::text = ind_stab.provincia
left join opu_soggetto_fisico sogg on sogg.id = stab.id_soggetto_fisico and sogg.trashed_date is null
left join lookup_province prov_nas_sogg on prov_nas_sogg.code::text = sogg.provincia_nascita
left join comuni1 com_sogg_nascita on upper(com_sogg_nascita.nome) = upper(sogg.comune_nascita)
join opu_operatore op on op.id = stab.id_operatore and op.trashed_date is null
left join opu_relazione_operatore_sede rel_op_sede on rel_op_sede.id_operatore = op.id
left join opu_indirizzo ind_op on ind_op.id = rel_op_sede.id_indirizzo
left join comuni1 com_op on ind_op.comune = com_op.id
left join opu_rel_operatore_soggetto_fisico rel_op_sogg on rel_op_sogg.id_operatore = op.id and rel_op_sogg.enabled
left join opu_soggetto_fisico sogg_op on sogg_op.id = rel_op_sogg.id_soggetto_fisico and sogg_op.trashed_date is null
left join comuni1 com_sogg_op_nascita on upper(com_sogg_op_nascita.nome) = upper(sogg_op.comune_nascita)
left join lookup_province prov_nas_sogg_op on prov_nas_sogg_op.code::text = sogg_op.provincia_nascita
left join lookup_site_id asl on asl.code = com_stab.codiceistatasl::integer   
join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva and sinac
left join linee_mobili_html_fields field on field.nome_campo ilike '%superficie destinata al ricovero%' and field.id_linea = rel.id_linea_produttiva and field.enabled 
left join linee_mobili_fields_value value on (value.id_rel_stab_linea = rel.id or value.id_opu_rel_stab_linea = rel.id) and value.enabled and value.id_linee_mobili_html_fields = field.id
left join ml8_linee_attivita_nuove_materializzata ml8 on ml8.id_nuova_linea_attivita = rel.id_linea_produttiva
left join opu_informazioni_pregresse_struttura info_preg on info_preg.id_rel_stab_lp = rel.id
where rel.enabled
union

select asl.description as asl,
o.org_id as id_stabilimento_gisa,
null as id_rel_stab_lp,
upper(o.name) as ragione_sociale,
upper(o.partita_iva) as partita_iva,
upper(o.codice_fiscale) as codice_fiscale_impresa ,
upper(mater.attivita) as linea_produttiva,
null as codice_linea,
case when upper(oaleg.addrline1) is not null then upper(oaleg.addrline1) else ' ' end || ' '|| case when upper(oaleg.addrline2) is not null then upper(oaleg.addrline2) else ' ' end || ' '|| case when upper(oaleg.city) is not null then upper(oaleg.city) else ' ' end || ' '|| case when oaleg.postalcode is not null then oaleg.postalcode else ' ' end || ' '|| case when upper(oaleg.state) is not null then upper(oaleg.state) else ' ' end as sede_legale_via,
case when upper(oaleg.addrline1) is not null then upper(oaleg.addrline1) else ' ' end || ' '|| case when upper(oaleg.addrline2) is not null then upper(oaleg.addrline2) else ' ' end || ' '|| case when upper(oaleg.city) is not null then upper(oaleg.city) else ' ' end || ' '|| case when oaleg.postalcode is not null then oaleg.postalcode else ' ' end || ' '|| case when upper(oaleg.state) is not null then upper(oaleg.state) else ' ' end as sede_legale_comune,
upper(o.codice_fiscale_rappresentante) as cf_resp_legale,
case when upper(oaope.addrline1) is not null then upper(oaope.addrline1) else ' ' end || ' '|| case when upper(oaope.city) is not null then upper(oaope.city) else ' ' end || ' '|| case when oaope.postalcode is not null then oaope.postalcode else ' ' end || ' '|| case when oaope.state is not null then oaope.state else ' ' end as stab_indirizzo,
case when upper(oaope.addrline1) is not null then upper(oaope.addrline1) else ' ' end || ' '|| case when upper(oaope.city) is not null then upper(oaope.city) else ' ' end || ' '|| case when oaope.postalcode is not null then oaope.postalcode else ' ' end || ' '|| case when oaope.state is not null then oaope.state else ' ' end as stab_comune,
null as longitudine,
null as latitudine,
null as mq_disponibili,
null as codice_sinaaf,
null as id_sinaaf,
null as data_fine,
null as data_inizio,
upper(p.number) as telefono_struttura,
upper(p2.number) as telefono_struttura2,
true as bdu,
o.org_id_c,
o.entered,
true as cani,
true as gatti,
true as altri_animali
from organization o
left join lookup_site_id asl on o.site_id = asl.code
left join organization_address oaleg on (o.org_id = oaleg.org_id and oaleg.address_type = 1) and oaleg.trasheddate is null
left join organization_address oaope on (o.org_id = oaope.org_id and oaope.address_type = 2) and oaope.trasheddate is null
left join organization_phone p on o.org_id = p.org_id and p.phone_type =1
left join organization_phone p2 on o.org_id = p2.org_id and p2.phone_type =2
left join ricerche_anagrafiche_old_materializzata mater on mater.riferimento_id = o.org_id and mater.riferimento_id_nome_col = 'org_id'
where o.trashed_date is null and o.tipologia in (10,20) 
order by asl   ,ragione_sociale;

--count: 435
select * from strutture_detenzione_gisa;

--query di confronto
select * from strutture_detenzione_gisa;
select * from strutture_detenzione_bdu;
select * from strutture_veterinarie_sinac;
select * from strutture_detenzione_sinac;

--c'è in gisa e in bdu no
select 'select * from public_functions.suap_inserisci_canile_bdu(' || s.id_stabilimento_gisa ||');', s.* from strutture_detenzione_gisa s
LEFT JOIN ( SELECT *
           FROM dblink(( SELECT get_pg_conf.get_pg_conf
                   FROM conf.get_pg_conf('BDU'::text) get_pg_conf(get_pg_conf)), 'select asl, id, ragione_sociale,  partita_iva,codice_fiscale_impresa,linea_produttiva,sede_legale_via , 
										         sede_legale_comune, cf_resp_legale, 	stab_indirizzo , stab_comune,	longitudine  , 	latitudine  , mq_disponibili,
											 tipologia_sinaaf_vet,	tipologia_sinaaf,codice_sinaaf, id_sinaaf,data_fine, data_inizio, telefono_struttura, 
											 telefono_struttura2, id_stabilimento_gisa, capacita, cf_proprietario, cf_gestore, vet_id_fiscale, privato from strutture_detenzione_bdu'::text) t(asl text, id integer, 
											 ragione_sociale text, partita_iva text, codice_fiscale_impresa text, linea_produttiva text, sede_legale_via text, 
											 sede_legale_comune text, cf_resp_legale text, stab_indirizzo text, stab_comune text, longitudine text, latitudine text, 
											 mq_disponibili text, tipologia_sinaaf_vet text, tipologia_sinaaf text,codice_sinaaf text, id_sinaaf integer, 
											 data_fine timestamp without time zone, data_inizio  timestamp without time zone, telefono_struttura text, 
											 telefono_struttura2 text,id_stabilimento_gisa integer, capacita text, 
											 cf_proprietario text, cf_gestore text, vet_id_fiscale text, privato boolean)) strutture_bdu 
                   ON strutture_bdu.id_stabilimento_gisa = s.id_stabilimento_gisa or strutture_bdu.id = s.org_id_c
where strutture_bdu.id is null and s.bdu and (s.cani or s.gatti) and s.linea_produttiva ilike '%commercio%'

--select * from public_functions.suap_inserisci_canile_bdu(233516);
--select * from public_functions.suap_inserisci_canile_bdu(309172);
--select * from public_functions.suap_inserisci_canile_bdu(241469);
--select * from public_functions.suap_inserisci_canile_bdu(234148);
--select * from public_functions.suap_inserisci_canile_bdu(201056);
--select * from public_functions.suap_inserisci_canile_bdu(248151);
--select * from public_functions.suap_inserisci_canile_bdu(233518);
--select * from public_functions.suap_inserisci_canile_bdu(368413);
--select * from public_functions.suap_inserisci_canile_bdu(367281);
select * from public_functions.suap_inserisci_canile_bdu(173666);
select * from public_functions.suap_inserisci_canile_bdu(173668);
--select * from public_functions.suap_inserisci_canile_bdu(366115);
--select * from public_functions.suap_inserisci_canile_bdu(221211);
--select * from public_functions.suap_inserisci_canile_bdu(222994);
--select * from public_functions.suap_inserisci_canile_bdu(236444);
select * from public_functions.suap_inserisci_canile_bdu(369582);
--select * from public_functions.suap_inserisci_canile_bdu(243147);
--select * from public_functions.suap_inserisci_canile_bdu(313785);
--select * from public_functions.suap_inserisci_canile_bdu(313471);
--select * from public_functions.suap_inserisci_canile_bdu(157917);
--select * from public_functions.suap_inserisci_canile_bdu(255988);
select * from public_functions.suap_inserisci_canile_bdu(368653);
--select * from public_functions.suap_inserisci_canile_bdu(352351);
--select * from public_functions.suap_inserisci_canile_bdu(256036);
select * from public_functions.suap_inserisci_canile_bdu(347785);






--c'è in bdu ma non in gisa e in bdu no
select s.* from strutture_detenzione_bdu s
LEFT JOIN ( SELECT *
           FROM dblink(( SELECT get_pg_conf.get_pg_conf
                   FROM conf.get_pg_conf('GISA'::text) get_pg_conf(get_pg_conf)), 'select asl, id_stabilimento_gisa, id_rel_stab_lp, ragione_sociale, partita_iva,codice_fiscale_impresa, linea_produttiva,
                                                                                   codice_linea, sede_legale_via , sede_legale_comune, cf_resp_legale, stab_indirizzo , stab_comune, longitudine  ,  latitudine  ,
                                                                                   mq_disponibili, codice_sinaaf, id_sinaaf, data_fine, data_inizio, telefono_struttura, telefono_struttura2,bdu, org_id_c,
                                                                                   entered, cani, gatti, altri_animali from strutture_detenzione_gisa'::text) t(asl text, id_stabilimento_gisa text, 
                                                                                   id_rel_stab_lp text, ragione_sociale text, partita_iva text,codice_fiscale_impresa text, linea_produttiva text,
                                                                                   codice_linea text, sede_legale_via  text, sede_legale_comune text, cf_resp_legale text, stab_indirizzo  text, 
                                                                                   stab_comune text, longitudine  text ,  latitudine  text , mq_disponibili text, codice_sinaaf text, id_sinaaf text, 
                                                                                   data_fine text, data_inizio text, telefono_struttura text, telefono_struttura2 text,bdu text, org_id_c text, entered text, 
                                                                                   cani text, gatti text, altri_animali text)) strutture_gisa 
                   ON s.id_stabilimento_gisa = strutture_gisa.id_stabilimento_gisa or s.id = strutture_gisa.org_id_c
where strutture_bdu.id is null and s.bdu and (s.cani or s.gatti) and s.linea_produttiva ilike '%commercio%'


