--select code from opu_lookup_norme_master_list where description = 'Altra normativa' --47



INSERT INTO schema_anagrafica
SELECT nextval('schema_anagrafica_id_seq'),'ASSANIM-ASSANIM-ASSANIM' as codice_univoco_ml,id_gruppo_template, id_campo_configuratore, campo_esteso, enabled, data_scadenza FROM schema_anagrafica
WHERE  codice_univoco_ml = 'FARM-FARM-FARMVET';
INSERT INTO master_list_flag_linee_attivita(id, codice_univoco,mobile, fisso, apicoltura, registrabili, riconoscibili, sintesis, bdu, vam,no_scia, categorizzabili, operatore_mercato, compatibilita_noscia, rev, entered, enteredby, id_linea, visibilita_asl, visibilita_regione, incompatibilita)
    SELECT nextval('master_list_flag_linee_attivita_id_seq'),'ASSANIM-ASSANIM-ASSANIM' as codice_univoco,
    mobile, fisso, apicoltura, registrabili, riconoscibili, sintesis, bdu, vam,no_scia, categorizzabili, operatore_mercato, compatibilita_noscia,11, now(),6567, id_linea, visibilita_asl, visibilita_regione, incompatibilita 
    FROM master_list_flag_linee_attivita
    WHERE  codice_univoco = 'FARM-FARM-FARMVET' and rev=10;
update master_list_flag_linee_attivita set categoria_rischio_default  = 2 where codice_univoco = 'ASSANIM-ASSANIM-ASSANIM';
   
  
insert into master_list_macroarea(codice_sezione, codice_norma, norma, macroarea, id_norma,rev, entered, enteredby) values ('ASSANIM', 'Altro','Altra normativa','Associazione  animalista',
(select code from opu_lookup_norme_master_list where description = 'Altra normativa'),11,now(),6567) returning id;


insert into master_list_aggregazione (id_macroarea, codice_attivita, aggregazione, id_flusso_originale,rev,entered, enteredby) values 
(?, 'ASSANIM', 'ASSOCIAZIONE ANIMALISTA', 5,11,now(),6567) returning id

insert into master_list_linea_attivita (id_aggregazione, codice_prodotto_specie, linea_attivita, codice_univoco,rev,entered, enteredby) values 
(?, 'ASSANIM', 'ASSOCIAZIONE ANIMALISTA', 'ASSANIM-ASSANIM-ASSANIM',11,now(),6567) returning id; --41450

update  master_list_flag_linee_attivita set  id_linea= ? where codice_univoco='ASSANIM-ASSANIM-ASSANIM';

--select * from master_list_flag_linee_attivita mlfla where codice_univoco ='ASSANIM-ASSANIM-ASSANIM'

update  master_list_flag_linee_attivita set operatore_mercato=false, compatibilita_noscia =null,sinac =true where codice_univoco='ASSANIM-ASSANIM-ASSANIM';

--select * from master_list_macroarea where codice_sezione='ASSANIM'
SELECT * FROM refresh_ml_materializzata(null);

select * from ml8_linee_attivita_nuove_materializzata where codice='ASSANIM-ASSANIM-ASSANIM'


