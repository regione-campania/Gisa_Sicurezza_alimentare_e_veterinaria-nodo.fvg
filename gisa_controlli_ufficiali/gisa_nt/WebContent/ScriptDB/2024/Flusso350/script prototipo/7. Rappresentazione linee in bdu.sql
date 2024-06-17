--Controllare le funzioni e le viste se sono allineate con ufficiale
--GISA
drop view linee_propagazione_bdu;
create or replace view linee_propagazione_bdu as 
select  flag.id_linea as code, l.path_descrizione as description_long, l.attivita as description, flag.codice_univoco, flag.bdu_canile, flag.bdu_operatore_commerciale from master_list_flag_linee_attivita flag
left join ml8_linee_attivita_nuove_materializzata l on l.id_nuova_linea_attivita = flag.id_linea
where flag.trashed is null and flag.rev = 11 and flag.bdu ;



--BDU -Versione con le linee gisa incorporate nelle linee bdu
CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_canili_opc_gisa AS 
 SELECT t.id_stabilimento,
    t.id_opu_operatore,
    t.partita_iva,
    t.codice_fiscale_impresa,
    t.ragione_sociale,
    t.nome_rapp_sede_legale,
    t.cognome_rapp_sede_legale,
    t.cf_rapp_sede_legale,
    t.data_nascita_rapp_sede_legale,
    t.sesso,
    t.comune_nascita_rapp_sede_legale,
    t.sigla_prov_soggfisico,
    t.comune_residenza,
    t.via_rapp_sede_legale,
    t.civico,
    t.cap_residenza,
    t.nazione_residenza,
    t.sigla_prov_legale,
    t.comune_sede_legale,
    t.via_sede_legale,
    t.civico_sede_legale,
    t.cap_sede_legale,
    t.nazione_sede_legale,
    t.sigla_prov_operativa,
    t.comune_stab,
    t.via_stabilimento_calcolata,
    t.civico_sede_stab,
    t.cap_stab,
    t.nazione_stab,
    t.id_asl,
    t.toponimo_residenza,
    t.toponimo_sede_legale,
    t.toponimo_sede_stab,
    t.id_linea_attivita,
    t.modifiedby,
    t.modified,
    t.enteredby,
    t.entered,
    t.id_linea_bdu,
    t.lat_stab,
    t.long_stab, t.id_linea_attivita_stab
   FROM dblink(( SELECT get_pg_conf.get_pg_conf
           FROM conf.get_pg_conf('GISA'::text) get_pg_conf(get_pg_conf)), 'select id_stabilimento  ,
    id_opu_operatore  ,
    partita_iva  ,
    codice_fiscale_impresa  ,
    ragione_sociale  ,
    nome_rapp_sede_legale  ,
    cognome_rapp_sede_legale  ,
    cf_rapp_sede_legale  ,
    data_nascita_rapp_sede_legale  ,
    sesso  ,
    comune_nascita_rapp_sede_legale  ,
    sigla_prov_soggfisico  ,
    comune_residenza  ,
    via_rapp_sede_legale  ,
    civico  ,
    cap_residenza  ,
    nazione_residenza ,
    sigla_prov_legale  ,
    comune_sede_legale  ,
    via_sede_legale  ,
    civico_sede_legale  ,
    cap_sede_legale  ,
    nazione_sede_legale  ,
    sigla_prov_operativa  ,
    comune_stab  ,
    via_stabilimento_calcolata  ,
    civico_sede_stab  ,
    cap_stab  ,
    nazione_stab  ,
    id_asl  ,
    toponimo_residenza  ,
    toponimo_sede_legale  ,
    toponimo_sede_stab  ,
    id_linea_attivita  ,
    modifiedby  ,
    modified  ,
    enteredby  ,
    entered ,
    id_linea_bdu  ,
    lat_stab ,
    long_stab , id_linea_attivita_stab  from opu_operatori_denormalizzati_view_bdu t'::text) t(id_stabilimento integer, id_opu_operatore integer, partita_iva text, codice_fiscale_impresa text, ragione_sociale text, nome_rapp_sede_legale text, cognome_rapp_sede_legale text, 
    cf_rapp_sede_legale text, data_nascita_rapp_sede_legale timestamp without time zone, sesso text, comune_nascita_rapp_sede_legale text, sigla_prov_soggfisico text, comune_residenza text, 
    via_rapp_sede_legale text, civico text, cap_residenza text, nazione_residenza text, sigla_prov_legale text, comune_sede_legale text, via_sede_legale text, civico_sede_legale text, cap_sede_legale text, 
    nazione_sede_legale text, sigla_prov_operativa text, comune_stab text, via_stabilimento_calcolata text, civico_sede_stab text, cap_stab text, nazione_stab text, id_asl integer, toponimo_residenza text, 
    toponimo_sede_legale text, toponimo_sede_stab text, id_linea_attivita integer, modifiedby integer, modified timestamp without time zone, enteredby integer, entered timestamp without time zone, 
    id_linea_bdu integer, lat_stab double precision, long_stab double precision, id_linea_attivita_stab integer);

ALTER TABLE public.opu_operatori_denormalizzati_canili_opc_gisa
  OWNER TO postgres;



alter table opu_lookup_attivita_linee_produttive_aggregazioni add column description_long text;
alter table opu_lookup_attivita_linee_produttive_aggregazioni add column codice_univoco text;
alter table opu_lookup_attivita_linee_produttive_aggregazioni add column bdu_canile boolean;
alter table opu_lookup_attivita_linee_produttive_aggregazioni add column bdu_operatore_commerciale boolean;
alter table opu_lookup_attivita_linee_produttive_aggregazioni drop column short_description;

drop view linee_gisa_view;
create or replace view linee_gisa_view as 
select  t.code, t.description, false as default_item, 0 as level, true as enabled, -1 as id_aggregazione, null as codice, null::timestamp without time zone as entered, null::timestamp without time zone as modified, t.codice_univoco, t.bdu_canile, t.bdu_operatore_commerciale, t.description_long FROM dblink((select * from conf.get_pg_conf('GISA')), 'select t.code, t.description, t.codice_univoco, t.bdu_canile, t.bdu_operatore_commerciale, t.description_long from linee_propagazione_bdu t') 
                  as t(code integer, description text,  codice_univoco text, bdu_canile boolean, bdu_operatore_commerciale boolean, description_long text);

--create table linee_gisa
--(code integer, description text, short_description text, codice_univoco text, bdu_canile boolean, bdu_operatore_commerciale boolean);

delete from opu_relazione_attivita_produttive_aggregazioni where id > 10;
delete from opu_lookup_attivita_linee_produttive_aggregazioni where bdu_canile is not null;
insert into opu_lookup_attivita_linee_produttive_aggregazioni (select * from linee_gisa_view);

 select * from opu_lookup_attivita_linee_produttive_aggregazioni
insert into opu_relazione_attivita_produttive_aggregazioni  (select t.code, t.code,  1  from opu_lookup_attivita_linee_produttive_aggregazioni t where bdu_canile is true                and bdu_canile                is not null );
insert into opu_relazione_attivita_produttive_aggregazioni  (select t.code, t.code,  1  from opu_lookup_attivita_linee_produttive_aggregazioni t where bdu_operatore_commerciale is true and bdu_operatore_commerciale is not null );

alter table opu_relazione_stabilimento_linee_produttive add column id_linea_gisa integer;

update opu_relazione_stabilimento_linee_produttive set id_linea_gisa = id_linea_produttiva;


CREATE OR REPLACE VIEW public.opu_operatori_denormalizzati_view AS 
 SELECT o.id AS id_opu_operatore,
    rel.id AS id_rel_stab_lp,
    o.ragione_sociale,
    o.partita_iva,
    o.codice_fiscale_impresa,
    o.note,
    o.entered,
    o.modified,
    o.enteredby,
    o.modifiedby,
    sogg.nome,
    sogg.cognome,
    sogg.codice_fiscale,
    i.comune,
    rel.id_linea_produttiva,
    stab.id_asl,
    rel.data_inizio,
    rel.data_fine,
    rel.id_linea_gisa
   FROM opu_relazione_stabilimento_linee_produttive rel
     LEFT JOIN opu_stabilimento stab ON rel.id_stabilimento = stab.id
     LEFT JOIN opu_indirizzo i ON i.id = stab.id_indirizzo
     LEFT JOIN opu_operatore o ON stab.id_operatore = o.id
     LEFT JOIN opu_rel_operatore_soggetto_fisico rels ON rels.id_operatore = o.id
     LEFT JOIN opu_soggetto_fisico sogg ON sogg.id = rels.id_soggetto_fisico
  WHERE o.trashed_date IS NULL AND rel.trashed_date IS NULL;


alter table opu_operatori_denormalizzati add column id_linea_gisa integer;



delete from opu_operatori_denormalizzati ;
insert into opu_operatori_denormalizzati (select * from opu_operatori_denormalizzati_view where id_opu_operatore is not null);

--BDU -Versione con le linee gisa separate da quelle bdu
delete  from opu_relazione_attivita_produttive_aggregazioni where id > 10;
delete from opu_lookup_attivita_linee_produttive_aggregazioni where bdu_canile or bdu_operatore_commerciale;

insert into opu_lookup_attivita_linee_produttive_aggregazioni (code,description,default_item,level,enabled,id_aggregazione) values (8,'Struttura di detenzione',false,0,true,-1);

insert into opu_relazione_attivita_produttive_aggregazioni  values(9,8,1 );



--BDU -Riattivare versione con le linee gisa incorporate nelle linee bdu
insert into opu_lookup_attivita_linee_produttive_aggregazioni (select * from linee_gisa_view);
insert into opu_relazione_attivita_produttive_aggregazioni  (select t.code, t.code,  1  from opu_lookup_attivita_linee_produttive_aggregazioni t where bdu_canile is true                and bdu_canile                is not null );
insert into opu_relazione_attivita_produttive_aggregazioni  (select t.code, t.code,  1  from opu_lookup_attivita_linee_produttive_aggregazioni t where bdu_operatore_commerciale is true and bdu_operatore_commerciale is not null );

update opu_lookup_attivita_linee_produttive_aggregazioni set enabled = true where code = 8;

--BDU - Versione con solo linee gisa