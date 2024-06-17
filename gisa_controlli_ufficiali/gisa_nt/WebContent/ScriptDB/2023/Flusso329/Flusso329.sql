-- Configurazione per C da confermare: restano fuori
-- il default per le linee senza allegati ma categorizzabili. 
--Punteggio valorizzato con punteggio =40,parametro=50, classe_rischio='RISCHIO BASSO', compilato=false, 'Non contemplato nell'elenco'                  


-----------------------------------------------------------------
insert into permission_category (category, description, level, enabled, active, constant) values ('Nuova Sorveglianza', 'Gestione allegati in nuova sorveglianza', 1200, true, true, 3);

insert into permission (category_id, permission, permission_view, description, level, enabled) values ((select category_id from permission_category where category = 'Nuova Sorveglianza'), 'sorveglianza_funzioni_test', true, 'Funzioni di test nel modulo nuova sorveglianza', 0, true );

alter table ticket add column sorv_previsto_allegato_d boolean;
alter table opu_stabilimento add column categoria_qualitativa integer;
alter table sintesis_stabilimento add column categoria_qualitativa integer;
alter table organization add column categoria_qualitativa integer;
alter table opu_relazione_stabilimento_linee_produttive add column categoria_quantitativa integer;
alter table opu_relazione_stabilimento_linee_produttive add column id_ultimo_controllo_sorveglianza integer;
alter table sintesis_relazione_stabilimento_linee_produttive add column categoria_quantitativa integer;
alter table sintesis_relazione_stabilimento_linee_produttive add column id_ultimo_controllo_sorveglianza integer;
alter table dpat_indicatore_new add column incidenza_su_categoria boolean;s
alter table master_list_flag_linee_attivita add column allegati_a boolean;
alter table master_list_flag_linee_attivita add column allegati_b boolean;
alter table master_list_flag_linee_attivita add column allegati_c boolean;
alter table master_list_flag_linee_attivita add column allegati_d boolean;
alter table master_list_flag_linee_attivita add column allegati_e boolean;
alter table master_list_flag_linee_attivita add column parte_speciale boolean;
alter table master_list_flag_linee_attivita add column sorv_id_allegato_c integer;
alter table master_list_flag_linee_attivita add column sorv_id_allegato_e integer;
alter table master_list_flag_linee_attivita add column sorv_id_allegato_e_2 integer;
alter table master_list_flag_linee_attivita add column allegati_categorizzazione text;
update cl_23.b_prod set id_parent=1, grp=1 where prog in (2,3,4);
update cl_23.b_prod set grp=2 where prog in (13,14,15);

alter table cl_23.c_prod add column id_alleg integer;
update cl_23.c_prod  set id_alleg=18 where sez='Ristorazione pubblica';
update cl_23.c_prod  set id_alleg=17 where sez='Prodotti della pesca';
update cl_23.c_prod  set id_alleg=20 where sez='Latte';
update cl_23.c_prod  set id_alleg=24 where sez='Prodotti lattiero-caseari';
update cl_23.c_prod  set id_alleg=19 where sez='Ristorazione collettiva';
update cl_23.c_prod  set id_alleg=25 where sez='Mangimificio';

update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PZ-1';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PL';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07P2';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PD';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PK';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PZ-2';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07P1';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PR-1';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.M-MCA-A07PF';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M14';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M15';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M15';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M14';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M15';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M14';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M14';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M14';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M15';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M15';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M18';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M10';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-DG-M07';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-OSMM-M29';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-OSMM-PET';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-PDD7-M39';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-PDD7-M36';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MG-PDD7-M35';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MR-PDD7-M39';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MR-PDD7-M35';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MR-PDD7-M36';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-ALLCAN';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-AAF';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-ALLGAT';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-DEG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-ADCA';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-CODAC';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-COIAC';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-COIAC';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-PEN';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-RIFSAN';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'IUV-CAN-RIFRIC';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.040-MS.040.500-852IT5A401';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.040-MS.040.300-852IT5A201';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.040-MS.040.400-852IT5A301';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.040-MS.040.200-852IT5A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.040-MS.040.100-852IT5A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.040-MS.040.600-852IT5A501';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.030-MS.030.100-852IT4A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.030-MS.030.100-852IT4A002';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.030-MS.030.100-852IT4A003';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.030-MS.030.200-852IT4A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.030-MS.030.200-852IT4A102';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'ALT-PCT-020';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.200-852IT7A103';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.200-852IT7A102';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.200-852IT7A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.200-852IT7A101-B';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.200-852IT7A101-A';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.400-852IT7A304';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.100-852IT7A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.100-852IT7A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.100-FU';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.100-852IT7A003';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.100-852IT7A003';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.100-852IT7A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.060-MS.060.100-852IT7A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.080-MS.080.100-010';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.080-MS.080.100-002';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.070-MS.070.100-852IT8A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.070-MS.070.100-852IT8A002';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.070-MS.070.200-852IT8A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-43-023';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-MS.020.500-852IT3A401';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-MS.020.200-852IT3A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-MS.020.200-852IT3A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-MS.020.200-852IT3A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-MS.020.200-852IT3A102';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-MS.020.100-852IT3A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-MS.020.300-852IT3A201';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.020-MS.020.400-852IT3A301';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A40.100-852ITEA001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A40.100-014';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.100-852ITBA002';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.100-852ITBA001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.200-011';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.200-013';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A40.200-852ITEA101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A40.200-014';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.300-011';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.300-013';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A40.300-852ITEA201';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A40.300-014';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.400-011';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.400-013';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.500-852ITBA007';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A30.500-852ITBA';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A10-CN-G';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A10-PC-G';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A10-PP-G';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A10-ST-G';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-BIB-015';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A12-CN-S';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A12-PC-S';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A12-PP-S';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A12-ST-S';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A11-CN-SG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A11-PC-SG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A11-PP-SG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.A-MS.A11-ST-SG';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.000-0130-AL-S';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.000-MS.000.100-017';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.000-MS.000.700-SF';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.000-MS.000.700-CF';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.000-MS.000.600-018';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.000-MS.000.400-852IT1A301';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A002';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.100-852IT6A002';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-008';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-008';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-010';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-003';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-852IT6A102';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-852IT6A102';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-005';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-006';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-HORE';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-852IT6A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-852IT6A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.050-MS.050.200-004';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.700-852IT2A601';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.800-852IT2A701';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.500-852IT2A403';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.500-852IT2A402';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.500-852IT2A401';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.500-852IT2A404';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.100-852IT2A001';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.100-852IT2A003-B';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.100-852IT2A003';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.100-852IT2A002';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.100-852IT2A004';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.100-FU';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-44-024';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.400-852IT2A301';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.400-852IT2A304';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.400-852IT2A303';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.400-852IT2A302';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.200-852IT2A101';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.300-852IT2A202';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.300-852IT2A201';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.010-MS.010.600-852IT2A501';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B00-MS.B00.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B00-MS.B00.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B00-MS.B00.300';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B10-MS.B10.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B10-MS.B10.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BA0-MS.BA0.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BA0-MS.BA0.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BA0-MS.BA0.300';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BB0-MS.BB0.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BC0-MS.BC0.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BC0-MS.BC0.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BD0-MS.BD0.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BE0-MS.BE0.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BE0-MS.BE0.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BF0-MS.BF0.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BF0-MS.BF0.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BG0-MS.BG0.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B20-MS.B20.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B20-MS.B20.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B30-MS.B30.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B30-MS.B30.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B40-MS.B40.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B40-MS.B40.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B50-MS.B50.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B50-MS.B50.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B50-MS.B50.300';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B60-MS.B60.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B70-MS.B70.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B70-MS.B70.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B80-MS.B80.700';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B80-MS.B80.300';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B80-MS.B80.800';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B80-MS.B80.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B80-MS.B80.400';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B80-MS.B80.500';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B80-MS.B80.600';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B80-MS.B80.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B90-MS.B90.100';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B90-MS.B90.200';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B90-MS.B90.500';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B90-MS.B90.400';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.B90-MS.B90.300';
update master_list_flag_linee_attivita set allegati_a=true, allegati_b=true, allegati_c=true, allegati_d=true, allegati_e=true where codice_univoco = 'MS.B-MS.BH0-MS.BH0.100';

update master_list_flag_linee_attivita set sorv_id_allegato_c=2, sorv_id_allegato_e =8 where codice_univoco= 'MS.B-MS.B20-MS.B20.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-ADCA';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-CODAC';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-COIAC';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =17 where codice_univoco= 'MG-PDD7-M36';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =17 where codice_univoco= 'MG-PDD7-M39';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-PDD7-M40';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-OSMM-MMDP';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =17 where codice_univoco= 'MR-PDD7-M39';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-PDD7-M40';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-HORE';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.040-MS.040.500-852IT5A401';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.040-MS.040.300-852IT5A201';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.040-MS.040.400-852IT5A301';
update master_list_flag_linee_attivita set sorv_id_allegato_c=2, sorv_id_allegato_e = null where codice_univoco= 'MS.040-MS.040.200-852IT5A101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=7, sorv_id_allegato_e = null where codice_univoco= 'MS.040-MS.040.100-852IT5A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=9, sorv_id_allegato_e =4 where codice_univoco= 'MS.040-MS.040.600-852IT5A501';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.030-MS.030.100-852IT4A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.030-MS.030.100-852IT4A002';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.030-MS.030.100-852IT4A003';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.030-MS.030.200-852IT4A101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.030-MS.030.200-852IT4A102';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'ALT-PCT-020';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =10 where codice_univoco= 'MS.060-MS.060.400-852IT7A304';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =10 where codice_univoco= 'MS.060-MS.060.200-852IT7A103';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =10 where codice_univoco= 'MS.060-MS.060.200-852IT7A102';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =10 where codice_univoco= 'MS.060-MS.060.200-852IT7A101';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =10 where codice_univoco= 'MS.060-MS.060.200-852IT7A101-B';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =10 where codice_univoco= 'MS.060-MS.060.200-852IT7A101-A';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.060-MS.060.100-852IT7A001';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.060-MS.060.100-852IT7A001';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.060-MS.060.100-FU';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.060-MS.060.100-852IT7A003';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.060-MS.060.100-852IT7A003';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.060-MS.060.100-852IT7A001';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.060-MS.060.100-852IT7A001';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.080-MS.080.100-010';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.080-MS.080.100-002';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.070-MS.070.100-852IT8A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.070-MS.070.100-852IT8A002';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.070-MS.070.200-852IT8A101';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'FVET-COMM-VDET';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'FVET-COMM-VDET';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'FVET-COMM-SVDET';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'FVET-COMM-SVDET';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-ALLCAN';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-AAF';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-ALLGAT';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-DEG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-PEN';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-RIFSAN';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =19 where codice_univoco= 'IUV-CAN-RIFRIC';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-OPR-M01';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DPNC-M21';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M14';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M15';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M15';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M14';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M15';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M14';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M14';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M14';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M15';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-DG-M15';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M13';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M19';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M06';
update master_list_flag_linee_attivita set sorv_id_allegato_c=16, sorv_id_allegato_e =18 where codice_univoco= 'MG-DG-M18';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M08';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M11';
update master_list_flag_linee_attivita set sorv_id_allegato_c=15, sorv_id_allegato_e =17 where codice_univoco= 'MG-DG-M10';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M05';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M04';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M09';
update master_list_flag_linee_attivita set sorv_id_allegato_c=15, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M07';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-DG-M12';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-OSMM-PELL';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-OSMM-M33';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-OSMM-M31';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-OSMM-M30';
update master_list_flag_linee_attivita set sorv_id_allegato_c=15, sorv_id_allegato_e = null where codice_univoco= 'MG-OSMM-M29';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-OSMM-MMDP';
update master_list_flag_linee_attivita set  sorv_id_allegato_e =16 where codice_univoco= 'MG-OSMM-PET';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-PDD7-M38';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MG-PDD7-M37';
update master_list_flag_linee_attivita set sorv_id_allegato_c=15, sorv_id_allegato_e =17 where codice_univoco= 'MG-PDD7-M35';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-DPNC-M21';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-OSMM-M33';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-OSMM-M31';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-OSMM-M30';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-OSMM-M29';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-PDD7-M37';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MR-PDD7-M38';
update master_list_flag_linee_attivita set sorv_id_allegato_c=15, sorv_id_allegato_e =17 where codice_univoco= 'MR-PDD7-M35';
update master_list_flag_linee_attivita set sorv_id_allegato_c=15, sorv_id_allegato_e =17 where codice_univoco= 'MR-PDD7-M36';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.020-43-023';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.020-MS.020.500-852IT3A401';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =14 where codice_univoco= 'MS.020-MS.020.200-852IT3A101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =14 where codice_univoco= 'MS.020-MS.020.200-852IT3A101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =14 where codice_univoco= 'MS.020-MS.020.200-852IT3A101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =14 where codice_univoco= 'MS.020-MS.020.200-852IT3A102';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =14 where codice_univoco= 'MS.020-MS.020.100-852IT3A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e =4 where codice_univoco= 'MS.020-MS.020.300-852IT3A201';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.020-MS.020.400-852IT3A301';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'FITO-E500A-E510A';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'FITO-E500A-E510A';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'FITO-E500A-E510A';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'FITO-E500A-E520A';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'FITO-E500A-E520A';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'RI.A-RI.A00-RI.A00.000';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B00-MS.B00.100';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B00-MS.B00.200';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B00-MS.B00.300';
update master_list_flag_linee_attivita set sorv_id_allegato_c=1, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B10-MS.B10.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=3, sorv_id_allegato_e =7 where codice_univoco= 'MS.B-MS.B10-MS.B10.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=14, sorv_id_allegato_e =12 where codice_univoco= 'MS.B-MS.BA0-MS.BA0.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=14, sorv_id_allegato_e =13 where codice_univoco= 'MS.B-MS.BA0-MS.BA0.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=14, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BA0-MS.BA0.300';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BB0-MS.BB0.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BC0-MS.BC0.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BC0-MS.BC0.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BD0-MS.BD0.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BE0-MS.BE0.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BE0-MS.BE0.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BF0-MS.BF0.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BF0-MS.BF0.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BG0-MS.BG0.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=1, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B20-MS.B20.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=2, sorv_id_allegato_e =45543 where codice_univoco= 'MS.B-MS.B20-MS.B20.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=1, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B30-MS.B30.200';
--update master_list_flag_linee_attivita set sorv_id_allegato_c=2 o 3, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B30-MS.B30.100'; 
update master_list_flag_linee_attivita set sorv_id_allegato_c=1, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B40-MS.B40.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=1, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B40-MS.B40.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B50-MS.B50.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B50-MS.B50.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B50-MS.B50.300';
update master_list_flag_linee_attivita set sorv_id_allegato_c=4, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B60-MS.B60.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=8, sorv_id_allegato_e =2 where codice_univoco= 'MS.B-MS.B70-MS.B70.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=8, sorv_id_allegato_e =3 where codice_univoco= 'MS.B-MS.B70-MS.B70.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=7, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B80-MS.B80.700';
update master_list_flag_linee_attivita set sorv_id_allegato_c=7, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B80-MS.B80.300';
update master_list_flag_linee_attivita set sorv_id_allegato_c=7, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B80-MS.B80.800';
update master_list_flag_linee_attivita set sorv_id_allegato_c=7, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B80-MS.B80.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=7, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B80-MS.B80.400';
update master_list_flag_linee_attivita set sorv_id_allegato_c=7, sorv_id_allegato_e =1 where codice_univoco= 'MS.B-MS.B80-MS.B80.500';
update master_list_flag_linee_attivita set sorv_id_allegato_c=6, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B80-MS.B80.600';
update master_list_flag_linee_attivita set sorv_id_allegato_c=7, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.B80-MS.B80.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=10, sorv_id_allegato_e =4 where codice_univoco= 'MS.B-MS.B90-MS.B90.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=9, sorv_id_allegato_e =4 where codice_univoco= 'MS.B-MS.B90-MS.B90.200';
update master_list_flag_linee_attivita set sorv_id_allegato_c=9, sorv_id_allegato_e =4 where codice_univoco= 'MS.B-MS.B90-MS.B90.500';
update master_list_flag_linee_attivita set sorv_id_allegato_c=9, sorv_id_allegato_e =4 where codice_univoco= 'MS.B-MS.B90-MS.B90.400';
update master_list_flag_linee_attivita set sorv_id_allegato_c=10, sorv_id_allegato_e =4 where codice_univoco= 'MS.B-MS.B90-MS.B90.300';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.B-MS.BH0-MS.BH0.100';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A40.100-852ITEA001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A40.100-014';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.100-852ITBA002';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.100-852ITBA001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.200-011';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.200-013';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A40.200-852ITEA101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A40.200-014';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.300-011';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.300-013';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A40.300-852ITEA201';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A40.300-014';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.400-011';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.400-013';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.500-852ITBA007';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A30.500-852ITBA';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A10-CN-G';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A10-PC-G';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A10-PP-G';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A10-ST-G';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-BIB-015';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A12-CN-S';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A12-PC-S';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A12-PP-S';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A12-ST-S';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A11-CN-SG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A11-PC-SG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A11-PP-SG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.A-MS.A11-ST-SG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MS.000-AL-PEL';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MS.000-ALES-016';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.000-0130-AL-S';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MS.000-0130-AL-SN';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.000-MS.000.100-017';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MS.000-0130-CR-X';
update master_list_flag_linee_attivita set sorv_id_allegato_c=13, sorv_id_allegato_e =15 where codice_univoco= 'MS.000-MS.000.700-SF';
update master_list_flag_linee_attivita set sorv_id_allegato_c=13, sorv_id_allegato_e =15 where codice_univoco= 'MS.000-MS.000.700-CF';
update master_list_flag_linee_attivita set sorv_id_allegato_c=13, sorv_id_allegato_e =15 where codice_univoco= 'MS.000-MS.000.600-018';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MS.000-ALLOM-019';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'MS.000-0130-PS-X';
update master_list_flag_linee_attivita set  sorv_id_allegato_e = null where codice_univoco= 'MS.000-MS.000.400-852IT1A301';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PZ-1';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PL';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07P2';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PD';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PK';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PZ-2';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07P1';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PR-1';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PG';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.M-MCA-A07PF';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A002';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=12, sorv_id_allegato_e =6 where codice_univoco= 'MS.050-MS.050.100-852IT6A002';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-008';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-008';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-010';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-003';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-852IT6A102';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-852IT6A102';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-005';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-006';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-852IT6A101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-852IT6A101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=11, sorv_id_allegato_e =5 where codice_univoco= 'MS.050-MS.050.200-004';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'SPE-A-ALNAU-ALSC';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-AMBV-PR';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-AMBV-PU';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-CLIV-PR';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-CLIV-PU';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-LABV-LABV';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-OSPV-PR';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-OSPV-PU';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-STUV-ACCA';
update master_list_flag_linee_attivita set sorv_id_allegato_c=null, sorv_id_allegato_e = null where codice_univoco= 'VET-STUV-SACA';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.700-852IT2A601';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.800-852IT2A701';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.500-852IT2A403';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.500-852IT2A402';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.500-852IT2A401';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.500-852IT2A404';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.100-852IT2A001';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.100-852IT2A003-B';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.100-852IT2A003';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.100-852IT2A002';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.100-852IT2A004';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.100-FU';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-44-024';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.400-852IT2A301';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.400-852IT2A304';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.400-852IT2A303';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.400-852IT2A302';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.200-852IT2A101';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.300-852IT2A202';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.300-852IT2A201';
update master_list_flag_linee_attivita set sorv_id_allegato_c=5, sorv_id_allegato_e = null where codice_univoco= 'MS.010-MS.010.600-852IT2A501';

update master_list_flag_linee_Attivita set parte_speciale=null where sorv_id_allegato_e is null;
update master_list_flag_linee_attivita set parte_speciale =true where sorv_id_allegato_e is not null;
update master_list_flag_linee_attivita set allegati_categorizzazione ='allegato a-b-c-d-e' where allegati_a='true' and allegati_b='true' and allegati_c='true' and allegati_d='true' and allegati_e='true';
update master_list_flag_linee_attivita 
set allegati_categorizzazione = 'allegato a' 
where codice_univoco in ('MR-OSMM-MMDP',
'MR-PDD7-M40',
'MR-DPNC-M21',
'MR-OSMM-M33',
'MR-OSMM-M31',
'MR-OSMM-M30',
'MR-OSMM-M29',
'MR-PDD7-M37',
'MR-PDD7-M38',
'MR-DR3-MIAG',
'MR-DR3-PROBD',
'MR-DR3-TRASOL',
'MR-DR3-TROAC',
'MR-DR-M23',
'MR-DR-M22',
'MR-DR-M25',
'MR-DR-M24',
'MR-DR-M27',
'MR-DR-M26',
'CG-NAZ-D-0122',
'CG-NAZ-B',
'CG-NAZ-R-003',
'CG-NAZ-R-007',
'CG-NAZ-D-0126',
'CG-NAZ-V-0126',
'CG-NAZ-V-0127',
'CG-NAZ-P-0121',
'CG-NAZ-P-0122',
'SPE-A-ALNAU-ALSC')
update master_list_flag_linee_attivita set parte_speciale=true, sorv_id_allegato_e=8, sorv_id_allegato_e_2=9 
where codice_univoco='MS.B-MS.B20-MS.B20.100';

alter table cl_23.lookup_sorv_allegati add column id_parte_speciale integer;
update cl_23.lookup_sorv_allegati set id_parte_speciale=1 where titolo ilike 'prodotti della pesca';
update cl_23.lookup_sorv_allegati set id_parte_speciale=2 where titolo ilike 'MOLLUSCHI CENTRI DI DEPURAZIONE';
update cl_23.lookup_sorv_allegati set id_parte_speciale=3 where titolo ilike 'MOLLUSCHI CENTRI DI SPEDIZIONE';
update cl_23.lookup_sorv_allegati set id_parte_speciale=4 where titolo ilike 'LATTE';
update cl_23.lookup_sorv_allegati set id_parte_speciale=4 where titolo ilike 'PRODOTTI LATTIERO-CASEARI';
update cl_23.lookup_sorv_allegati set id_parte_speciale=5 where titolo ilike 'RISTORAZIONE PUBBLICA';
update cl_23.lookup_sorv_allegati set id_parte_speciale=6 where titolo ilike 'RISTORAZIONE COLLETTIVA';
update cl_23.lookup_sorv_allegati set id_parte_speciale=8 where titolo ilike 'MACELLO AVICOLI';
update cl_23.lookup_sorv_allegati set id_parte_speciale=9 where titolo ilike 'MACELLO CONIGLI';
update cl_23.lookup_sorv_allegati set id_parte_speciale=10 where titolo ilike 'COMMERCIO AL DETTAGLIO';
update cl_23.lookup_sorv_allegati set id_parte_speciale=12 where titolo ilike 'CENTRO IMBALLAGGIO UOVA';
update cl_23.lookup_sorv_allegati set id_parte_speciale=13 where titolo ilike 'IMPIANTO PRODUZIONE UOVA LIQUIDE';
update cl_23.lookup_sorv_allegati set id_parte_speciale=14 where titolo ilike 'PRODUZIONE DI PASNE, PIZZA, E PRODOTTI DA FORNO E DI PASTICCERIA';
update cl_23.lookup_sorv_allegati set id_parte_speciale=17 where titolo ilike 'MANGIMIFICIO';

update cl_23.lookup_sorv_allegati set short_description='C-prod-pesca' where code=17;
update cl_23.lookup_sorv_allegati set short_description='C-latte' where code=20;
update cl_23.lookup_sorv_allegati set short_description='C-latte-cas' where code=24;
update cl_23.lookup_sorv_allegati set short_description='C-risto-coll' where code=19;
update cl_23.lookup_sorv_allegati set short_description='C-mangimi' where code=25;
----------------- file di ORSA ----------------
1	Prodotti della pesca
2	Molluschi cdm
3	Molluschi csm
4	Latte e prodotti lattiero caseari
5	Ristorazione pubblica
6	Ristorazione collettiva
7	Macello ungulati
8	Macello avicoli
9	Macello cunicoli
10	Commercio al dettaglio
11	Mercato ittico
12	Centro Imballaggio uova
13	Impianto produzione uova liquide
14	produzione di pane,pizza e prodotti da forno e di pasticceria
15	produzione primaria
16	Rivendite mangimi
17	Mangimifici
18	Mulini
19	Canili/strutture di detenzione animali d'affezione

--------------------- LISTA ALLEGATI C LEGATI ALLA LINEA DI ATTIVITA' ----------------------------------------
1	Prodotti della pesca
2	Molluschi
3	Carne Sezionate
4	Prodotti lattiero-caseari
5	Ristorazione pubblica           -> id allegato 18 configurato
6	Mensa collettiva
7	Latte
8	Prodotti a base di carne/preparazioni
9	Commercio                      
10	Non contemplata nell’elenco

--------------------- RISTORAZIONE PUBBLICA ----------------------------------------
update cl_23.c_prod set id_alleg=18 where sez ilike '%Ristorazione pubblica%';
-- aggiorno id allegato c per ristorazione pubblica

select 
'update master_list_flag_linee_attivita set sorv_id_allegato_c=18 where id_linea='||l.id_linea||';' 
codice from 
ml8_linee_attivita_nuove_materializzata m
join master_list_flag_linee_attivita l on l.id_linea= m.id_nuova_linea_attivita
where aggregazione ilike '%ristorazione pubblica%' and livello=3;

--------------------- LISTA ALLEGATI E PARTE SPECIALE ----------------------------------------
1	E+molluschi_centro_depurazione_molluschi
2	E+molluschi_centro_spedizione_molluschi
3	E+centro_imballaggio_uova
4	E+commercio_dettaglio
5	E+impianto produzione uova liquide
6	E+Latte
7	E+macello_avicoli
8	E+macello_conigli
9	E+prodotti della pesca
10	E+produzione pasticceria e produzione pasta
11	E+ristorazione pubblica                       -------> id allegato 14 configurato

-- aggiorno id allegato e per latte partendo dalla cl_23.lookup_sorv_allegati per E+risto pubblica
select 
'update master_list_flag_linee_attivita set sorv_id_allegato_e=14 where id_linea='||l.id_linea||';' 
codice from 
ml8_linee_attivita_nuove_materializzata m
join master_list_flag_linee_attivita l on l.id_linea= m.id_nuova_linea_attivita
where aggregazione ilike '%ristorazione pubblica%' and livello=3 and l.parte_speciale;


-------------- tabelle ------------------------------
CREATE TABLE cl_23.sorv_parametrizzazioni_punteggio
(
    id serial,
    id_allegato integer,
    range_rischio_da integer,
    range_rischio_a integer,
    parametro_rischio integer,
    enabled boolean DEFAULT true
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.sorv_parametrizzazioni_punteggio
    OWNER to postgres;


alter table cl_23.sorv_parametrizzazioni_punteggio add column classe_rischio text;
update cl_23.sorv_parametrizzazioni_punteggio set classe_rischio='RISCHIO BASSO' where parametro_rischio = 50;
update cl_23.sorv_parametrizzazioni_punteggio set classe_rischio='RISCHIO MEDIO' where parametro_rischio = 100;
update cl_23.sorv_parametrizzazioni_punteggio set classe_rischio='RISCHIO ALTO' where parametro_rischio = 200;
update cl_23.sorv_parametrizzazioni_punteggio set classe_rischio='RISCHIO BASSO' where parametro_rischio in (10,20);
update cl_23.sorv_parametrizzazioni_punteggio set classe_rischio='RISCHIO MEDIO' where parametro_rischio IN (30,40);


CREATE TABLE IF NOT EXISTS cl_23.lookup_sorv_allegati
(
    code serial,
    description character varying(100) COLLATE pg_catalog."default" NOT NULL,
    short_description text, 
    default_item boolean DEFAULT false,
    level integer DEFAULT 0,
    enabled boolean DEFAULT true
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.lookup_sorv_allegati
    OWNER to postgres;
    
---- DA COMPLETARE SHORT DESCRIPTION-------------
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato A','A');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato B','B');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-prod-pesca');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-risto-pub');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-risto-coll');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-latte');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-molluschi');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-carne-sez');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-carne-prep');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-latt-cas');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato C-mangimi');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato D','D');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E','E');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-com-det');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-latte');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-macello-avic');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-macello-conig');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-molluschi-dep');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-molluschi-sped');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-pasta');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-prod-pesca');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-risto-pub');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-uova-imb');
insert into cl_23.lookup_sorv_allegati(description, short_description) values('Allegato E-uova-liq');

-- AGGIUNTA DEL TITOLO PER GLI ALLEGATI
alter table cl_23.lookup_sorv_allegati add column titolo text;
update cl_23.lookup_sorv_allegati set titolo='ENTITA'' PRODUTTIVA, TARGET DI RIFERIMENTO E CARATTERISTICHE DEI PRODOTTI' where code=2;
update cl_23.lookup_sorv_allegati set titolo='RISTORAZIONE PUBBLICA' where code=18;
update cl_23.lookup_sorv_allegati set titolo='RISTORAZIONE COLLETTIVA' where code=19;
update cl_23.lookup_sorv_allegati set titolo='PROVVEDIMENTI ADOTTATI' where code=4;
update cl_23.lookup_sorv_allegati set titolo='TIPOLOGIA PRODUTTIVA' where code=1;
update cl_23.lookup_sorv_allegati set titolo='CRITERI DINAMICI' where code=5;
update cl_23.lookup_sorv_allegati set titolo='PRODOTTI DELLA PESCA' where code=17;
update cl_23.lookup_sorv_allegati set titolo='MOLLUSCHI' where code=21;
update cl_23.lookup_sorv_allegati set titolo='CARNI SEZIONATE' where code=22;
update cl_23.lookup_sorv_allegati set titolo='PRODOTTI LATTIERO-CASEARI' where code=24;
update cl_23.lookup_sorv_allegati set titolo='LATTE' where code=20;
update cl_23.lookup_sorv_allegati set titolo='PRODOTTI A BASE DI CARNE/PREPARAZIONI' where code=23;
update cl_23.lookup_sorv_allegati set titolo='MANGIMIFICIO' where code=25;
update cl_23.lookup_sorv_allegati set titolo='COMMERCIO AL DETTAGLIO' where code=6;
update cl_23.lookup_sorv_allegati set titolo='LATTE' where code=7;
update cl_23.lookup_sorv_allegati set titolo='MACELLO AVICOLI' where code=8;
update cl_23.lookup_sorv_allegati set titolo='MACELLO CONIGLI' where code=9;
update cl_23.lookup_sorv_allegati set titolo='MOLLUSCHI CENTRI DI DEPURAZIONE' where code=10;
update cl_23.lookup_sorv_allegati set titolo='MOLLUSCHI CENTRI DI SPEDIZIONE' where code=11;
update cl_23.lookup_sorv_allegati set titolo='PRODUZIONE DI PASNE, PIZZA, E PRODOTTI DA FORNO E DI PASTICCERIA' where code=12;
update cl_23.lookup_sorv_allegati set titolo='PRODOTTI DELLA PESCA' where code=13;
update cl_23.lookup_sorv_allegati set titolo='RISTORAZIONE PUBBLICA' where code=14;
update cl_23.lookup_sorv_allegati set titolo='CENTRO IMBALLAGGIO UOVA' where code=15;
update cl_23.lookup_sorv_allegati set titolo='IMPIANTO PRODUZIONE UOVA LIQUIDE' where code=16;

alter table cl_23.lookup_sorv_allegati add column autori text;
update cl_23.lookup_sorv_allegati set autori='DR.SSA BRUNA NISCI - DR. FRANCESCO PAPPONE' where code=14;
update cl_23.lookup_sorv_allegati set autori = 'Dr. Maurizio Della Rotonda - Dr.  Giuseppe Di Loria' where code=10;
update cl_23.lookup_sorv_allegati set autori = 'Dr. Maurizio Della Rotonda - Dr.  Giuseppe Di Loria' where code=11;
update cl_23.lookup_sorv_allegati set autori = 'Dr.ssa Angelamaria Barone -  Dr. Vincenzo D''Andrea' where code=15;
update cl_23.lookup_sorv_allegati set autori = 'Dr. ssa Bruna Nisci - Dr. Francesco Pappone' where code=6;
update cl_23.lookup_sorv_allegati set autori = 'Dr. ssa Bruna Nisci - Dr. Francesco Pappone' where code=12;
update cl_23.lookup_sorv_allegati set autori = 'Dr.ssa Angelamaria Barone -  Dr. Vincenzo D''Andrea' where code=16;
update cl_23.lookup_sorv_allegati set autori = 'Dr. Maurizio Della Rotonda - Dr.  Giuseppe Di Loria' where code=7;
update cl_23.lookup_sorv_allegati set autori = 'Dr. Giacomo Peres - Dr. Andrea Brando' where code=8;
update cl_23.lookup_sorv_allegati set autori = 'Dr. Giacomo Peres - Dr. Andrea Brando' where code=9;
update cl_23.lookup_sorv_allegati set autori = 'Dr. Alfredo Improta - Dr.  Massimo D''Antonio' where code=13;


-- Allegato A
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (1,1,1,10,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (1,2,2,20,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (1,3,3,30,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (1,4,4,40,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (1,5,5,50,true);

-- Allegato B 
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (2,0,120,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (2,121,240,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (2,241,null,200,true);

-- C per pesca
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (17,0,0,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (17,0,0,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (17,60,60,200,true);

-- C per risto pub 
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (18,40,40,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (18,60,60,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (18,80,80,200,true);

-- C per risto collettiva 
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (19,40,40,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (19,60,60,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (19,80,80,200,true);

-- C per latte
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (20,0,0,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (20,0,80,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (20,81,null,200,true);

-- C per molluschi
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (21,0,0,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (21,40,40,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (21,60,60,200,true);

-- C per carne sezionate
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (22,0,0,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (22,40,40,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (22,60,60,200,true);

-- C per carne prep
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (23,0,80,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (23,81,120,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (23,121,null,200,true);

-- C per latt-caseario
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (24,0,120,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (24,121,250,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (24,251,null,200,true);

-- C per mangimi
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (25,40,40,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (25,60,60,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (25,80,80,200,true);

-- Allegato D
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (4,0,50,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (4,51,100,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (4,101,null,200,true);

-- Allegato E
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (5,0,1200,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (5,1201,1510,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (5,1511,null,200,true);

-- Allegato E+comm det.
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (6,0,1260,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (6,1261,1470,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (6,1471,null,200,true);


-- Allegato E+latte
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (7,0,1380,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (7,1381,1860,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (7,1861,null,200,true);

-- Allegato E+mac.avicoli
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (8,0,1440,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (8,1441,1650,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (8,1651,null,200,true);

-- Allegato E+mac.conigli
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (9,0,1440,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (9,1441,1650,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (9,1651,null,200,true);

-- Allegato E+dep-mollu 
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (10,0,1770,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (10,1771,2060,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (10,2061,null,200,true);

-- Allegato E+sped-mollu 
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (11,0,1440,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (11,1441,1860,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (11,1861,null,200,true);

-- allegato E+ pasta
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (12,0,1200,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (12,1201,1410,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (12,1411,null,200,true);

-- Allegato E+prod.pesca
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (13,0,1320,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (13,1321,1530,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (13,1531,null,200,true);

-- Allegato E+risto
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (14,0,1230,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (14,1231,1440,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (14,1441,null,200,true);

-- Allegato E+uova imb.
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (15,0,1200,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (15,1201,1410,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (15,1411,null,200,true);

-- Allegato E+uova liq.
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (16,0,1200,50,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (16,1201,1410,100,true);
insert into cl_23.sorv_parametrizzazioni_punteggio(id_allegato, range_rischio_da, range_rischio_a, parametro_rischio, enabled)
values (16,1411,null,200,true);


CREATE OR REPLACE FUNCTION cl_23.sorv_get_classe_rischio_da_punteggio(
	_punteggio integer,
	_id_allegato integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
DECLARE
	rischio text;
BEGIN

	rischio := (select classe_rischio 
 				from cl_23.sorv_parametrizzazioni_punteggio 
 			  	where _punteggio between range_rischio_da and range_rischio_a
				and enabled and id_allegato = _id_allegato);
				
	raise info 'rischio: %', rischio;
				
	return rischio;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_classe_rischio_da_punteggio(integer, integer)
    OWNER TO postgres;

------------------------ GESTIONE ALLEGATO A ------------------------------------
---------------------------------------------------------------------------------
-- FUNCTION: cl_23.sorv_get_allegato_a(integer)

-- DROP FUNCTION IF EXISTS cl_23.sorv_get_allegato_a(integer);

CREATE OR REPLACE FUNCTION cl_23.sorv_get_allegato_a(
	_idcu integer)
    RETURNS TABLE(categoria integer, parametro integer, classe_rischio text, compilato boolean, titolo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
 punt  integer;
 rischio text;
 categoria_rischio integer;
 presente boolean;
 codice_linea text;
BEGIN

	presente = false;
	
	codice_linea := (select c.codice_linea from linee_attivita_controlli_ufficiali c where c.id_controllo_ufficiale = _idcu and c.trashed_date is null);
	raise info 'codice linea CU: %', codice_linea;
	--select coalesce(id_attivita, id_rel_ateco_attivita) from get_linee_attivita(352705,'opu_stabilimento',true,_idcu)
	categoria_rischio := (select distinct categoria_rischio_default from master_list_flag_linee_attivita where codice_univoco = codice_linea limit 1);
	raise info 'categoria ex ante: %', categoria_rischio;
	
	punt:= (select parametro_rischio 
	from cl_23.sorv_parametrizzazioni_punteggio where id_allegato=1 and enabled
	and categoria_rischio between range_rischio_da and range_rischio_a);
	raise info 'punteggio: %', punt;
	
	rischio := (select p.classe_rischio 
	from cl_23.sorv_parametrizzazioni_punteggio p where p.id_allegato=1 and p.enabled
	and categoria_rischio between range_rischio_da and range_rischio_a);
	raise info 'rischio: %', rischio;
	
	presente :=(select distinct allegato_compilato from cl_23.sorv_istanze_allegati_cu where id_controllo = _idcu and trashed_date is null and tipo_allegato='A');
	titolo := (select t.titolo from cl_23.lookup_sorv_allegati t where t.short_description = 'A' and enabled);

	
 RETURN query select categoria_rischio, punt, rischio, presente, titolo;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_allegato_a(integer)
    OWNER TO postgres;



------------------------ GESTIONE ALLEGATO B-----------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
create table cl_23.sorv_istanza_allegato_b 
(
id serial,
id_controllo integer,
id_domanda integer,
si boolean,
no boolean,
na boolean,
trashed_date timestamp,
id_utente integer,
note_hd text,
entered timestamp default now()
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.sorv_istanza_allegato_b
    OWNER to postgres;
    
    
CREATE OR REPLACE FUNCTION cl_23.sorv_get_parametro_da_punteggio(_punteggio integer, _id_allegato integer)
RETURNS integer 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
DECLARE
	parametro integer;
BEGIN

 parametro:=  (select parametro_rischio 
 				from cl_23.sorv_parametrizzazioni_punteggio 
 			  	where _punteggio between range_rischio_da and range_rischio_a
				and enabled and id_allegato = _id_allegato);
				
	return parametro;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_parametro_da_punteggio(integer, integer)
    OWNER TO postgres;
	

CREATE OR REPLACE FUNCTION cl_23.sorv_get_allegato_b(
	_idcu integer)
    RETURNS TABLE(punteggio integer, parametro integer, classe_rischio text, compilato boolean, titolo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	idallegato integer;
	punteggio integer;
	parametro integer;
	presente boolean;
	rischio text;
BEGIN

	idallegato := (select code from cl_23.lookup_sorv_allegati where short_description = 'B' and enabled);
	titolo := (select t.titolo from cl_23.lookup_sorv_allegati t where short_description = 'B' and enabled);
	raise info 'id_allegato: %', idallegato;
	punteggio := (select sum(b.punteggio)::integer from cl_23.sorv_get_domande_e_risposte_allegato_b(_idcu) b where risposta_si);
	raise info 'punteggio: %', punteggio;
	parametro := (select * from cl_23.sorv_get_parametro_da_punteggio(punteggio, idallegato));
	rischio := (select * from cl_23.sorv_get_classe_rischio_da_punteggio(punteggio, idallegato));
	
	if punteggio is null then
		punteggio := 0;
		parametro :=50;
		rischio := 'RISCHIO BASSO';
		presente :=false;
	end if;
	
	if parametro is null and punteggio is not null then 
		parametro := (select s.parametro_rischio 
					  from cl_23.sorv_parametrizzazioni_punteggio s
					  where s.enabled and s.id_allegato = idallegato and s.range_rischio_a is null);
		raise info 'parametro associato a punteggio: %', parametro;			  
		rischio := (select p.classe_rischio 
					from cl_23.sorv_parametrizzazioni_punteggio p where p.id_allegato = idallegato and p.enabled 
					and p.range_rischio_a is null
				    );
		raise info 'rischio: %', rischio;
		
	end if;
	
	presente :=(select distinct allegato_compilato from cl_23.sorv_istanze_allegati_cu where id_controllo = _idcu and trashed_date is null and tipo_allegato='B');
	
	
    RETURN query select punteggio, parametro, rischio, presente, titolo;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_allegato_b(integer)
    OWNER TO postgres;
    
    
CREATE OR REPLACE FUNCTION cl_23.sorv_get_domande_e_risposte_allegato_b(
	_idcu integer DEFAULT NULL::integer)
    RETURNS TABLE(id integer, sezione text, id_gruppo integer, domanda text, id_padre integer, punteggio_si integer, punteggio_no integer, punteggio integer, risposta_si boolean, risposta_no boolean, risposta_na boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	tot integer;
BEGIN

    tot := (select  count(*) from cl_23.sorv_istanza_allegato_b where trashed_date is null and id_controllo = _idcu);
	if(tot > 0) then
		RETURN query  
		 select b.id, b.sez, b.grp::integer, b.domanda, b.id_parent::integer, b.risp_si::integer, b.rispo_no::integer, b.risp_si::integer as punteggio, 
			i.si, i.no, i.na
		 from cl_23.b_prod b 
		 left join cl_23.sorv_istanza_allegato_b i on i.id_domanda = b.id and i.trashed_date is null
		 where b.trashed_date is null 
		 and i.id_controllo = _idcu
		 order by coalesce(i.id_domanda, b.id);
	else
		RETURN query  
			select b.id, b.sez, b.grp::integer, b.domanda, b.id_parent::integer, b.risp_si::integer, b.rispo_no::integer, b.risp_si::integer as punteggio, 
			false, false, false
		 	from cl_23.b_prod b 
		 	order by b.domanda;		
	end if;

 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_domande_e_risposte_allegato_b(integer)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION cl_23.sorv_upsert_domande_e_risposte_allegato_b(
	_idcu integer,
	_id_domanda integer,
	_risposta_si boolean,
	_risposta_no boolean,
	_risposta_na boolean,
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

BEGIN
  update cl_23.sorv_istanza_allegato_b set 
  note_hd=concat_ws('-',note_hd,'Cancellazione per aggiornamento risposte allegato B.'), 
  trashed_date = now() where 
  id_controllo = _idcu and id_domanda= _id_domanda and trashed_date is null;
  
  insert into cl_23.sorv_istanza_allegato_b(id_controllo, id_domanda, si, no, na, id_utente) values (_idcu, _id_domanda, _risposta_si, _risposta_no, _risposta_na, _id_utente);
  return 'OK';
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_upsert_domande_e_risposte_allegato_b(integer, integer, boolean, boolean, boolean, integer)
    OWNER TO postgres;
    
    
---------------------- GESTIONE ALLEGATO C ------------------
-------------------------------------------------------------------------------------------

create table cl_23.sorv_istanza_allegato_c 
(
id serial,
id_controllo integer,
id_domanda integer,
si boolean,
no boolean,
na boolean,
trashed_date timestamp,
id_utente integer,
note_hd text,
entered timestamp default now()
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.sorv_istanza_allegato_c
    OWNER to postgres;
    


CREATE OR REPLACE FUNCTION cl_23.sorv_get_domande_e_risposte_allegato_c(
	_idcu integer DEFAULT NULL::integer)
    RETURNS TABLE(id integer, sezione text, id_gruppo integer, domanda text, id_padre integer, punteggio_si integer, punteggio_no integer, punteggio integer, risposta_si boolean, risposta_no boolean, risposta_na boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	idallegato integer;
	codice_linea text;
	tot integer;
BEGIN
    -- mi recupero l'id allegato dalla l.d.a sottoposta a CU
	codice_linea := (select c.codice_linea from linee_attivita_controlli_ufficiali c where c.id_controllo_ufficiale = _idcu and c.trashed_date is null);
	raise info 'codice linea CU: %', codice_linea;
	idallegato := (select code from cl_23.lookup_sorv_allegati where short_description is not null and id_parte_speciale= (select distinct sorv_id_allegato_c from master_list_flag_linee_attivita where codice_univoco = codice_linea));
	raise info 'id_allegato: %', idallegato;
	  
	if (idallegato is null) then
		RETURN query  
		select -1, '',-1,'',-1,-1,-1,0,false, false, false;
	else
		-- verifico la presenza o meno del controllo
		tot := (select  count(*) from cl_23.sorv_istanza_allegato_c where trashed_date is null and id_controllo = _idcu);
		if(tot > 0) then
			RETURN query  
				select c.id, c.sez, c.grp::integer, c.domanda, c.id_parent::integer, c.risp_si::integer, c.rispo_no::integer, c.risp_si::integer as punteggio, 
				i.si, i.no, i.na
				from cl_23.c_prod c 
				left join cl_23.sorv_istanza_allegato_c i on i.id_domanda = c.id 
				where c.trashed_date is null and i.trashed_date is null
				and i.id_controllo = _idcu
				and c.id_alleg = idallegato
				order by c.sez;
	
		else
			RETURN query  
				select c.id, c.sez, c.grp::integer, c.domanda, c.id_parent::integer, c.risp_si::integer, c.rispo_no::integer, c.risp_si::integer as punteggio, 
				false, false, false
				from cl_23.c_prod c 
				where c.trashed_date is null 
				and c.id_alleg = idallegato
				order by c.sez;
		end if; --totale
		
	end if; -- globale
 	
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_domande_e_risposte_allegato_c(integer)
    OWNER TO postgres;



CREATE OR REPLACE FUNCTION cl_23.sorv_upsert_domande_e_risposte_allegato_c(
	_idcu integer,
	_id_domanda integer,
	_risposta_si boolean,
	_risposta_no boolean,
	_risposta_na boolean, 
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

BEGIN
  update cl_23.sorv_istanza_allegato_c set 
  note_hd=concat_ws('-',note_hd,'Cancellazione per aggiornamento risposte allegato C.'), 
  trashed_date = now() where 
  id_controllo = _idcu and id_domanda= _id_domanda and trashed_date is null;
  
  insert into cl_23.sorv_istanza_allegato_c(id_controllo, id_domanda, si, no, na, id_utente) values (_idcu, _id_domanda, _risposta_si, _risposta_no, _risposta_na, _id_utente);
  return 'OK';
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_upsert_domande_e_risposte_allegato_c(integer, integer, boolean, boolean, integer)
    OWNER TO postgres;




-- FUNCTION: cl_23.sorv_get_allegato_c(integer)

-- DROP FUNCTION IF EXISTS cl_23.sorv_get_allegato_c(integer);
CREATE OR REPLACE FUNCTION cl_23.sorv_get_allegato_c(
	_idcu integer)
    RETURNS TABLE(punteggio integer, parametro integer, classe_rischio text, compilato boolean, titolo text, previsto boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	idallegato integer;
	punteggio integer;
	parametro integer;
	codice_linea text;
	presente boolean;
	rischio text;
BEGIN
	-- mi recupero l'id allegato dalla l.d.a sottoposta a CU
	codice_linea := (select c.codice_linea from linee_attivita_controlli_ufficiali c where c.id_controllo_ufficiale = _idcu and c.trashed_date is null);
	raise info 'codice linea CU: %', codice_linea;
	idallegato := (select code from cl_23.lookup_sorv_allegati where enabled and short_description ilike '%C-%' 
			       and id_parte_speciale in (select distinct sorv_id_allegato_c from master_list_flag_linee_attivita 
										 	 where codice_univoco = codice_linea));
	raise info 'id_allegato: %', idallegato;
	
	if (idallegato is null) then
		return query select 40, 50, 'RISCHIO BASSO', false, 'NON CONTEMPLATO NELL''ELENCO', false;
	else
		punteggio := (select sum(c.punteggio)::integer from cl_23.sorv_get_domande_e_risposte_allegato_c(_idcu) c where risposta_si);
		raise info 'punteggio: %', punteggio;
		parametro := (select * from cl_23.sorv_get_parametro_da_punteggio(punteggio, idallegato));
		raise info 'parametro associato a punteggio: %', parametro;
		rischio := (select * from cl_23.sorv_get_classe_rischio_da_punteggio(punteggio, idallegato));
		raise info 'rischio: %', rischio;
		if parametro is null then 
			parametro := (select s.parametro_rischio 
						  from cl_23.sorv_parametrizzazioni_punteggio s
						  where s.enabled and s.id_allegato = idallegato and s.range_rischio_a is null);

			rischio := (select p.classe_rischio 
						from cl_23.sorv_parametrizzazioni_punteggio p where p.id_allegato = idallegato and p.enabled
						and p.range_rischio_a is null);
		
		end if;
		presente :=(select distinct allegato_compilato from cl_23.sorv_istanze_allegati_cu where id_controllo = _idcu and trashed_date is null and tipo_allegato='C');
    	titolo := (select t.titolo from cl_23.lookup_sorv_allegati t where code = idallegato and enabled);
		
    	RETURN query select punteggio, parametro, rischio, presente, titolo, true;
	
	end if;
	

 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_allegato_c(integer)
    OWNER TO postgres;

--------------- GESTIONE ALLEGATO D
create table cl_23.sorv_istanza_allegato_d
(
id serial,
id_controllo integer,
id_domanda integer,
si boolean,
no boolean,
na boolean, 
trashed_date timestamp,
id_utente integer,
note_hd text,
entered timestamp default now()
)
    

CREATE OR REPLACE FUNCTION cl_23.sorv_get_domande_e_risposte_allegato_d(
	_idcu integer DEFAULT NULL::integer)
    RETURNS TABLE(id integer, domanda text, id_gruppo integer, punteggio_si integer, punteggio_no integer, punteggio integer, risposta_si boolean, risposta_no boolean, risposta_na boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	tot integer;
BEGIN

    tot := (select  count(*) from cl_23.sorv_istanza_allegato_d where trashed_date is null and id_controllo = _idcu);
	if(tot > 0) then
		 RETURN query  
			select d.id, d.domanda, d.grp::integer, d.risp_si::integer, d.rispo_no::integer, d.risp_si::integer as punteggio, 
			i.si, i.no, i.na
			from cl_23.d_provv d
			left join cl_23.sorv_istanza_allegato_d i on i.id_domanda = d.id 
			where d.trashed_date is null and i.trashed_date is null
			and i.id_controllo = _idcu
			order by d.id;
	else
		RETURN query  
			select d.id, d.domanda, d.grp::integer, d.risp_si::integer, d.rispo_no::integer, d.risp_si::integer as punteggio, 
			false, false, false
			from cl_23.d_provv d
			where d.trashed_date is null
			order by d.id;	
	end if;

 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_domande_e_risposte_allegato_d(integer)
    OWNER TO postgres;
    

CREATE OR REPLACE FUNCTION cl_23.sorv_upsert_domande_e_risposte_allegato_d(
	_idcu integer,
	_id_domanda integer,
	_risposta_si boolean,
	_risposta_no boolean,
	_risposta_na boolean,
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

BEGIN
  update cl_23.sorv_istanza_allegato_d set 
  note_hd=concat_ws('-',note_hd,'Cancellazione per aggiornamento risposte allegato D.'), 
  trashed_date = now() where 
  id_controllo = _idcu and id_domanda= _id_domanda and trashed_date is null;
  
  insert into cl_23.sorv_istanza_allegato_d(id_controllo, id_domanda, si, no, na, id_utente) values (_idcu, _id_domanda, _risposta_si, _risposta_no, _risposta_na, _id_utente);
  return 'OK';
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_upsert_domande_e_risposte_allegato_d(integer, integer, boolean, boolean, integer)
    OWNER TO postgres;
    
CREATE OR REPLACE FUNCTION cl_23.sorv_upsert_previsto_allegato_d(_previsto boolean, _id_cu integer)
    RETURNS boolean 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

BEGIN
	update cl_23.sorv_istanze_cu set sorv_previsto_allegato_d = _previsto where id_controllo = _id_cu and trashed_date is null;
 RETURN _previsto;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_upsert_previsto_allegato_d(boolean, integer)
    OWNER TO postgres;


CREATE OR REPLACE FUNCTION cl_23.sorv_get_allegato_d(
	_idcu integer)
    RETURNS TABLE(punteggio integer, parametro integer, classe_rischio text, previsto boolean, compilato boolean, titolo text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	idallegato integer;
	punteggio integer;
	parametro integer;
	codice_linea text;
	previsto boolean;
	presente boolean;
	rischio text;
BEGIN
	
	-- va calcolato bene il valore dal cu 
	previsto := (select sorv_previsto_allegato_d from cl_23.sorv_istanze_cu where trashed_date is null and id_controllo = _idcu); 
	
	-- mi recupero l'id allegato dalla l.d.a sottoposta a CU
	codice_linea := (select c.codice_linea from linee_attivita_controlli_ufficiali c where c.id_controllo_ufficiale = _idcu and c.trashed_date is null);
	raise info 'codice linea CU: %', codice_linea;
	idallegato := (select code from cl_23.lookup_sorv_allegati where short_description = 'D' and enabled);
	titolo := (select t.titolo from cl_23.lookup_sorv_allegati t where t.short_description = 'D' and enabled);
	raise info 'id_allegato: %', idallegato;
	
	punteggio := (select sum(d.punteggio)::integer from cl_23.sorv_get_domande_e_risposte_allegato_d(_idcu) d where risposta_si);
	raise info 'punteggio: %', punteggio;
	if punteggio is null then
		punteggio :=0;
	end if;
	parametro := (select * from cl_23.sorv_get_parametro_da_punteggio(punteggio, idallegato));
	raise info 'parametro associato a punteggio: %', parametro;
	rischio := (select * from cl_23.sorv_get_classe_rischio_da_punteggio(punteggio, idallegato));
	raise info 'rischio: %', rischio;
	if parametro is null then 
		parametro := (select s.parametro_rischio 
					  from cl_23.sorv_parametrizzazioni_punteggio s
					  where s.enabled and s.id_allegato = idallegato and s.range_rischio_a is null);
					  
		rischio := (select p.classe_rischio 
					from cl_23.sorv_parametrizzazioni_punteggio p where p.id_allegato = idallegato and p.enabled
					and p.range_rischio_a is null);
		raise info 'rischio: %', rischio;
		
	end if;
	
	presente :=(select distinct allegato_compilato from cl_23.sorv_istanze_allegati_cu where id_controllo = _idcu and trashed_date is null and tipo_allegato='D');

	
	if previsto then
	    RETURN query select punteggio, parametro, rischio, true, presente, titolo;
	else 
		RETURN query select 0, 0, '', false, presente, titolo;	
	end if;
	
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_allegato_d(integer)
    OWNER TO postgres;
 
-------------------- GESTIONE ALLEGATO E------------------------------------
create table cl_23.sorv_istanza_allegato_e 
(
id serial,
id_controllo integer,
id_domanda integer,
risposta_c boolean,
risposta_nc boolean,
risposta_ncc boolean,
risposta_na boolean,
trashed_date timestamp,
id_utente integer,
note_hd text,
entered timestamp default now()
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.sorv_istanza_allegato_e
    OWNER to postgres;

CREATE OR REPLACE FUNCTION cl_23.sorv_iscompilato_allegato_e(IN _idcu integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
DECLARE
	tot_risp_non_date_e integer;
	tot_risp_non_date_e_speciale integer;
BEGIN
  		
		tot_risp_non_date_e := (select count(*) from cl_23.sorv_get_domande_e_risposte_allegato_e(_idcu)
								where risposta_c=false and risposta_nc=false and risposta_ncc=false and risposta_na=false);
		
		tot_risp_non_date_e_speciale := (select count(*) from cl_23.sorv_get_domande_e_risposte_linea_allegato_e(_idcu) 
										where risposta_c=false and risposta_nc=false and risposta_ncc=false and risposta_na=false);
		
		if (tot_risp_non_date_e = 0 and tot_risp_non_date_e_speciale = 0) then
			return true;			
		else
			return false;
		end if;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_iscompilato_allegato_e(integer)
    OWNER TO postgres;
    
-- FUNCTION: cl_23.sorv_get_allegato_e(integer)

-- DROP FUNCTION IF EXISTS cl_23.sorv_get_allegato_e(integer);

cl_23.sorv_istanze_cu



CREATE OR REPLACE FUNCTION cl_23.sorv_get_allegato_e(
	_idcu integer)
    RETURNS TABLE(punteggio integer, parametro integer, classe_rischio text, compilato boolean, titolo text, autori text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	idallegato_base integer;
	idallegato_parte_speciale integer;
	punteggio integer;
	punteggio_parte_speciale integer;
	parametro integer;
	parametro_parte_speciale integer;
	codice_linea text;
	presente boolean;
	rischio text;
	rischio_parte_speciale text;
BEGIN

 	-- mi recupero l'id allegato dalla l.d.a sottoposta a CU
	codice_linea := (select c.codice_linea from linee_attivita_controlli_ufficiali c where c.id_controllo_ufficiale = _idcu and c.trashed_date is null);
	raise info 'codice linea CU: %', codice_linea;
	idallegato_base := (select code from cl_23.lookup_sorv_allegati where short_description = 'E' and enabled);
	raise info 'id_allegato: %', idallegato_base;
	idallegato_parte_speciale := (select code from cl_23.lookup_sorv_allegati 
								  where enabled and description ilike '%E-%' and
								  id_parte_speciale= (select distinct sorv_id_allegato_e from master_list_flag_linee_attivita 
													  where parte_speciale and codice_univoco = codice_linea and trashed is null));
		
		
	raise info 'id_allegato speciale: %', idallegato_parte_speciale;
	
	
	punteggio := (select sum(case when risposta_c then punteggio_c	 
							  when risposta_nc then punteggio_nc
							  when risposta_ncc then punteggio_ncc
		 					  when risposta_na then null
				    		  end)
				 from cl_23.sorv_get_domande_e_risposte_allegato_e(_idcu) e
				  );
	raise info 'punteggio E base: %', punteggio;
	if (punteggio is null) then
		punteggio := 0;
	end if;
	
	parametro := (select * from cl_23.sorv_get_parametro_da_punteggio(punteggio, idallegato_base));
	rischio := (select * from cl_23.sorv_get_classe_rischio_da_punteggio(punteggio, idallegato_base));

	
	if parametro is null then 
		parametro := (select s.parametro_rischio 
					  from cl_23.sorv_parametrizzazioni_punteggio s
					  where s.enabled and s.id_allegato = idallegato_base and s.range_rischio_a is null);
		raise info 'parametro associato a punteggio: %', parametro;			  
		rischio := (select p.classe_rischio 
					from cl_23.sorv_parametrizzazioni_punteggio p 
					where p.id_allegato = idallegato_base and p.enabled
					and p.range_rischio_a is null);
		raise info 'rischio: %', rischio;
	end if;
		
	
	if idallegato_parte_speciale is not null then
		punteggio_parte_speciale := (select sum(case when risposta_c then punteggio_c	 
							  when risposta_nc then punteggio_nc
							  when risposta_ncc then punteggio_ncc
		 					  when risposta_na then null
				    		  end)
				 from cl_23.sorv_get_domande_e_risposte_linea_allegato_e(_idcu) e
				  );
		raise info 'punteggio E parte speciale: %', punteggio_parte_speciale;
		if (punteggio_parte_speciale is null) then
			punteggio_parte_speciale := 0;
		end if;
		parametro_parte_speciale := (select * from cl_23.sorv_get_parametro_da_punteggio(punteggio_parte_speciale, idallegato_parte_speciale));
		raise info 'parametro parte speciale associato a punteggio: %', parametro_parte_speciale;
    	rischio_parte_speciale := (select * from cl_23.sorv_get_classe_rischio_da_punteggio(punteggio_parte_speciale, idallegato_parte_speciale));
		raise info 'rischio parte speciale: %', rischio_parte_speciale;
		
		if parametro_parte_speciale is null then 
			parametro_parte_speciale := (select s.parametro_rischio 
					  from cl_23.sorv_parametrizzazioni_punteggio s
					  where s.enabled and s.id_allegato = idallegato_parte_speciale and s.range_rischio_a is null);
		
			rischio_parte_speciale := (select p.classe_rischio 
					from cl_23.sorv_parametrizzazioni_punteggio p 
					where p.id_allegato = idallegato_parte_speciale and p.enabled
					and p.range_rischio_a is null);
			raise info 'rischio parte speciale: %', rischio_parte_speciale;
		end if;
 	  	titolo := (select t.titolo from cl_23.lookup_sorv_allegati t where t.code = idallegato_parte_speciale and enabled);
		autori := (select t.autori from cl_23.lookup_sorv_allegati t where t.code = idallegato_parte_speciale and enabled);
	end if;
	

	presente := (select distinct allegato_compilato from cl_23.sorv_istanze_allegati_cu where id_controllo = _idcu and trashed_date is null and tipo_allegato='E');
	
	if(idallegato_parte_speciale is not null) then	 
		return query select punteggio+punteggio_parte_speciale, parametro+parametro_parte_speciale, (select distinct rischio union select rischio_parte_speciale) ,presente, titolo, autori;
	elsif (idallegato_parte_speciale is null and idallegato_base is not null) then 
		return query select punteggio, parametro, rischio ,presente, '', '';
	else
		return query select 0, parametro, rischio ,presente, '', '';
	end if;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_allegato_e(integer)
    OWNER TO postgres;
    

    
    
CREATE OR REPLACE FUNCTION cl_23.sorv_upsert_domande_e_risposte_allegato_e(
	_idcu integer,
	_id_domanda integer,
	_risposta_c boolean,
	_risposta_nc boolean,
	_risposta_ncc boolean,
	_risposta_na boolean,
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

BEGIN
  update cl_23.sorv_istanza_allegato_e set 
  note_hd=concat_ws('-',note_hd,'Cancellazione per aggiornamento risposte allegato E.'), 
  trashed_date = now() where 
  id_controllo = _idcu and id_domanda= _id_domanda and trashed_date is null;
  
  insert into cl_23.sorv_istanza_allegato_e(id_controllo, id_domanda, risposta_c, risposta_nc, risposta_ncc, risposta_na, id_utente) 
  values(_idcu, _id_domanda, _risposta_c, _risposta_nc, _risposta_ncc, _risposta_na, _id_utente);
  
  return 'OK';
 END;
$BODY$;


------------------ GESTIONE ALLEGATI E PARTE SPECIALE -----------------------
-----------------------------------------------------------------------------
create table cl_23.sorv_istanza_allegati_e_speciali
(
id serial,
id_controllo integer,
id_domanda integer,
risposta_c boolean,
risposta_nc boolean,
risposta_ncc boolean,
risposta_na boolean,
trashed_date timestamp,
id_utente integer,
note_hd text,
entered timestamp default now()
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.sorv_istanza_allegati_e_speciali
    OWNER to postgres;



-- FUNCTION: cl_23.sorv_get_domande_e_risposte_linea_allegato_e(integer)

-- DROP FUNCTION IF EXISTS cl_23.sorv_get_domande_e_risposte_linea_allegato_e(integer);

CREATE OR REPLACE FUNCTION cl_23.sorv_get_domande_e_risposte_linea_allegato_e(
	_idcu integer DEFAULT NULL::integer)
    RETURNS TABLE(id integer, sezione text, domanda text, punteggio_c integer, punteggio_nc integer, punteggio_ncc integer, punteggio integer, risposta_c boolean, risposta_nc boolean, risposta_ncc boolean, risposta_na boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	idallegato integer;
	punteggio integer;
	codice_linea text;
BEGIN

 	-- mi recupero la l.d.a sottoposta a CU
	codice_linea := (select c.codice_linea from linee_attivita_controlli_ufficiali c where c.id_controllo_ufficiale = _idcu and c.trashed_date is null);
	raise info 'codice linea CU: %', codice_linea;
	idallegato := (select code from cl_23.lookup_sorv_allegati 
								  where enabled and description ilike '%E-%' and
								  id_parte_speciale= (select distinct sorv_id_allegato_e from master_list_flag_linee_attivita 
													  where parte_speciale and codice_univoco = codice_linea and trashed is null));
	
	if (idallegato = 6) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_com_det',_idcu));
	elsif (idallegato = 7) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_latte',_idcu));
	elsif (idallegato = 8) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_macello_avic',_idcu));
	elsif (idallegato = 9) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_macello_conig',_idcu));
	elsif (idallegato = 10) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_molluschi_dep',_idcu));
	elsif (idallegato = 11) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_molluschi_sped',_idcu));
	elsif (idallegato = 12) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_pasta',_idcu));
	elsif (idallegato = 13) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_prod_pesca',_idcu));
	elsif (idallegato = 14) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_risto_pub',_idcu));
	elsif (idallegato = 15) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_uova_imb',_idcu));
	elsif (idallegato = 16) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_uova_liq',_idcu));
	elsif (idallegato = 29) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_mulini',_idcu));
	elsif (idallegato = 28) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_mangimi',_idcu));
	elsif (idallegato = 27) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_macello_ungul',_idcu));
	elsif (idallegato = 26) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_risto_col',_idcu));
	elsif (idallegato = 30) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_riven_mangimi',_idcu));
	elsif (idallegato = 32) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_prod_primar_veg',_idcu));
	elsif (idallegato = 31) then
		return query (select * from cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale('cl_23.e_mercato_ittico',_idcu));
	end if;
	
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_domande_e_risposte_linea_allegato_e(integer)
    OWNER TO postgres;

--select * from cl_23.lookup_sorv_allegati where upper(description) ilike '%E-%'



CREATE OR REPLACE FUNCTION cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale(
	_nome_tabella text,
	_idcu integer DEFAULT NULL::integer)
    RETURNS TABLE(id integer, sezione text, domanda text, punteggio_c integer, punteggio_nc integer, punteggio_ncc integer, punteggio integer, risposta_c boolean, risposta_nc boolean, risposta_ncc boolean, risposta_na boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
	tot integer;
BEGIN

  tot := (select  count(*) from cl_23.sorv_istanza_allegati_e_speciali where trashed_date is null and id_controllo = _idcu);
	if(tot > 0) then
		RETURN query  
		 EXECUTE format('select e.id, e.sez,  e.domanda, e.comp_conf::integer, e.no_comp_conf::integer, e.no_conf::integer, 
		coalesce(e.comp_conf::integer, e.no_comp_conf::integer, e.no_conf::integer), 
		i.risposta_c, i.risposta_nc, i.risposta_ncc, i.risposta_na
		from %s e
		left join cl_23.sorv_istanza_allegati_e_speciali i on i.id_domanda = e.id 
		where i.trashed_date is null and e.trashed_date is null
		and i.id_controllo = %s
		order by e.id;', _nome_tabella, _idcu);
	else
		RETURN query  
				EXECUTE format('select e.id, e.sez,  e.domanda, e.comp_conf::integer, e.no_comp_conf::integer, e.no_conf::integer, 
		coalesce(e.comp_conf::integer, e.no_comp_conf::integer, e.no_conf::integer), 
		false, false, false, false
		from %s e
		where e.trashed_date is null
		order by e.id;', _nome_tabella, _idcu);
	
	end if;

 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_domande_e_risposte_linea_allegato_e_speciale(text, integer)
    OWNER TO postgres;
    
    
	
CREATE OR REPLACE FUNCTION cl_23.sorv_upsert_domande_e_risposte_linea_allegato_e(
	_idcu integer,
	_id_domanda integer,
	_risposta_c boolean,
	_risposta_nc boolean,
	_risposta_ncc boolean,
	_risposta_na boolean,
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$

BEGIN
  update cl_23.sorv_istanza_allegati_e_speciali set 
  note_hd=concat_ws('-',note_hd,'Cancellazione per aggiornamento risposte allegato E parte speciale.'), 
  trashed_date = now() where 
  id_controllo = _idcu and id_domanda= _id_domanda and trashed_date is null;
  
  insert into cl_23.sorv_istanza_allegati_e_speciali(id_controllo, id_domanda, risposta_c, risposta_nc, risposta_ncc, risposta_na, id_utente) values 
                                     (_idcu, _id_domanda, _risposta_c, _risposta_nc, _risposta_ncc, _risposta_na, _id_utente);
  return 'OK';
 END;
$BODY$;


       
----- GET VALORE FINALE E CATEGORIA. LA CATEGORIA DI RISCHIO VA DEFINITA DA 1 A 5 
----- GET VALORE FINALE E CATEGORIA. LA CATEGORIA DI RISCHIO VA DEFINITA DA 1 A 5 
-- FUNCTION: public.sorv_get_valore_e_categoria(integer)

-- DROP FUNCTION IF EXISTS public.sorv_get_valore_e_categoria(integer);

CREATE OR REPLACE FUNCTION cl_23.sorv_get_valore_e_categoria(
	_idcu integer)
    RETURNS TABLE(punteggio_finale double precision, categoria integer, chiusura_definitiva boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
 	calcolo double precision;
	categoria_rischio integer;
	chiusura_definitiva boolean;
BEGIN
	chiusura_definitiva :=(select c.chiusura_definitiva from cl_23.sorv_istanze_cu c where c.trashed_date is null and c.id_controllo = _idcu);
	raise info 'CHIUSURA CU DEFINITIVA: %', chiusura_definitiva;
	calcolo := (
			-- formula completa [(A+B) X 0.3] + (C X 0.1) + [(D+E) X 0.4]
			select sum(ab) as valore 
			from
			(
				--[(A+B) X 0.3]
				select sum(t.valore)* 0.3::double precision as ab from (
					(select a.valore 
					from cl_23.sorv_get_allegato_a(_idcu) a) 
					union 
					(select b.valore 
					from cl_23.sorv_get_allegato_b(_idcu) b)
				)t
				union
				--(C X 0.1) 
				(select c.valore*0.1::double precision as c
				from cl_23.sorv_get_allegato_c(_idcu) c)
				union
				--[(D+E) X 0.4]
				(select sum(a.valore)* 0.4::double precision as de from (
					(select d.valore 
					from cl_23.sorv_get_allegato_d(_idcu) d) 
					union 
					(select e.valore 
					from cl_23.sorv_get_allegato_e(_idcu) e)
				)a)
			)f);
	raise info 'calcolo finale: %', calcolo;
	categoria_rischio := (select c.categoria from cl_23.sorv_parametrizzazioni_categoria c where c.enabled and calcolo between range_da and coalesce(range_a,1000000));
	raise info 'CATEGORIA DI RISCHIO: %', categoria_rischio;
	
 RETURN query    
		select calcolo, categoria_rischio, chiusura_definitiva;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_valore_e_categoria(integer)
    OWNER TO postgres;

---------------- GESTIONE TABELLA ISTANZE CU -----------------------
CREATE TABLE cl_23.sorv_istanze_cu
(
    id serial,
    id_controllo integer,
	sorv_previsto_allegato_d boolean,
	trashed_date timestamp,
	chiusura_definitiva boolean,
	entered timestamp default now(),
	note_hd text
)
alter table cl_23.sorv_istanze_cu add column modified timestamp;
alter table cl_23.sorv_istanze_cu add column modified_by integer;
alter table cl_23.sorv_istanze_cu add column entered_by integer;

CREATE TABLE cl_23.sorv_istanze_allegati_cu
(
	id serial,
	id_utente_per_allegato integer,
	data_inserimento_allegato timestamp,
	allegato_compilato boolean,
	tipo_allegato text, 
	entered timestamp default now(),
	note_hd text,
	trashed_date timestamp
)

CREATE OR REPLACE FUNCTION cl_23.sorv_aggiorna_istanza_compilazione_allegato(
	_idcu integer,
	_tipo_allegato text,
	_compilato boolean,
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
DECLARE 
	idcu integer;
BEGIN
  idcu := (Select count(id_controllo) from cl_23.sorv_istanze_cu where trashed_date is null and id_controllo= _idcu);
  if (idcu = 0) then
	  insert into cl_23.sorv_istanze_cu(id_controllo, entered_by) values (_idcu, _id_utente);
  end if;
  insert into cl_23.sorv_istanze_allegati_cu(id_utente_per_allegato, id_controllo, data_inserimento_allegato, allegato_compilato, tipo_allegato)
														 VALUES (_id_utente, _idcu, now(), _compilato, _tipo_allegato);
                                     
  return 'OK';
 END;
$BODY$;


 CREATE OR REPLACE FUNCTION cl_23.sorv_aggiorna_istanza_cu(
	_idcu integer,
	_id_utente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
AS $BODY$
DECLARE 
	idcu integer;
BEGIN
  	update cl_23.sorv_istanze_cu set chiusura_definitiva = true, modified= now(), modified_by = _id_utente where id_controllo = _idcu;
                                     
  return 'OK';
 END;
$BODY$;



CREATE TABLE IF NOT EXISTS cl_23.sorv_parametrizzazioni_categoria
(
    id serial,
    range_da integer,
    range_a integer,
    categoria integer,
    enabled boolean DEFAULT true
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.sorv_parametrizzazioni_categoria
    OWNER to postgres;


insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (0,112,1,true);

insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (113,150,2,true);

insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (151,188,3,true);

insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (189,225,4,true);

insert into cl_23.sorv_parametrizzazioni_categoria(range_da, range_a, categoria, enabled) 
values (226,NULL,5,true);
    


-- FUNCTION: cl_23.sorv_get_dettaglio(integer)

-- DROP FUNCTION IF EXISTS cl_23.sorv_get_dettaglio(integer);

CREATE OR REPLACE FUNCTION cl_23.sorv_get_dettaglio(
	_idcu integer)
    RETURNS TABLE(punteggio_finale double precision, categoria integer, chiusura_definitiva boolean, linea_sottoposta_a_controllo text, codice_linea_sottoposta_a_controllo text, categoria_qualitativa text, controllo_chiuso boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
DECLARE
 	calcolo double precision;
	categoria_rischio integer;
	chiusura_definitiva boolean;
	codice_linea text;
	categoriaqual text;
	linea_cu text;
	iscontrollochiuso boolean;
BEGIN
	
	--select * from public.get_linee_attivita(352705, 'opu_stabilimento' , false , 1880955)

	iscontrollochiuso := (select case when closed is null then false else true end from ticket where trashed_date is null and ticketid = _idcu);
	codice_linea := (select c.codice_linea from linee_attivita_controlli_ufficiali c where c.id_controllo_ufficiale = _idcu and c.trashed_date is null);
	raise info 'codice linea CU: %', codice_linea;
	linea_cu := (select distinct path_descrizione from ml8_linee_attivita_nuove_materializzata where codice ilike codice_linea limit 1);
	raise info 'descrizione linea: %', linea_cu;
	chiusura_definitiva :=(select c.chiusura_definitiva from cl_23.sorv_istanze_cu c where c.trashed_date is null and c.id_controllo = _idcu);
	raise info 'CHIUSURA CU DEFINITIVA: %', chiusura_definitiva;
	calcolo := (
			-- formula completa [(A+B) X 0.3] + (C X 0.1) + [(D+E) X 0.4]
			select sum(ab) as valore 
			from
			(
				--[(A+B) X 0.3]
				select sum(t.parametro)* 0.3::double precision as ab from (
					(select a.parametro 
					from cl_23.sorv_get_allegato_a(_idcu) a) 
					union all
					(select b.parametro 
					from cl_23.sorv_get_allegato_b(_idcu) b)
				)t
				union
				--(C X 0.1) 
				(select c.parametro*0.1::double precision as c
				from cl_23.sorv_get_allegato_c(_idcu) c)
				union all
				--[(D+E) X 0.4]
				(select sum(a.parametro)* 0.4::double precision as de from (
					(select d.parametro 
					from cl_23.sorv_get_allegato_d(_idcu) d) 
					union all
					(select e.parametro 
					from cl_23.sorv_get_allegato_e(_idcu) e)
				)a)
			)f);
	raise info 'calcolo finale: %', calcolo;
	categoria_rischio := (select c.categoria from cl_23.sorv_parametrizzazioni_categoria c where c.enabled and calcolo between range_da and coalesce(range_a,1000000));
	categoriaqual := (select c.categoria_qualitativa from cl_23.sorv_parametrizzazioni_categoria c where c.enabled and calcolo between range_da and coalesce(range_a,1000000));

	raise info 'CATEGORIA DI RISCHIO: %', categoria_rischio;
	
 RETURN query    
		select calcolo, categoria_rischio, chiusura_definitiva, linea_cu, codice_linea, categoriaqual, iscontrollochiuso;
 END;
$BODY$;

ALTER FUNCTION cl_23.sorv_get_dettaglio(integer)
    OWNER TO postgres;



	

-- query per determinare l'ultimo controllo in sorveglianza per linea di uno stab
	
	-- FUNCTION: public.get_valori_anagrafica_linee(integer)

-- DROP FUNCTION IF EXISTS public.get_valori_anagrafica_linee(integer);

CREATE OR REPLACE FUNCTION public.get_valori_anagrafica_linee(
	_altid integer)
    RETURNS TABLE(norma text, macroarea text, aggregazione text, attivita text, livelli_aggiuntivi text, carattere text, data_inizio text, data_fine text, numero_registrazione text, gia_codificato_come text, cun text, stato text, variazione_stato text, id_ultimo_controllo_categorizzazione integer, tipo_categorizzazione text, categoria_rischio integer, dati_aggiuntivi text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
		
BEGIN

	return query
	select 

	norme.description::text as norma,
	ml8.macroarea::text as macroarea,
	ml8.aggregazione::text as aggregazione,
	replace(replace(ml8.attivita::text,'"',''''), '''','''''') as attivita,

	string_agg(distinct concat(l3.valore || '-><br/>' || l2.valore || '-><br/>' || l.valore || '<br/><br/>'), '')::text as livelli_aggiuntivi,
		 
	coalesce(oltc.description,'PERMANENTE')::text as carattere,
	to_char(rel.data_inizio, 'dd/MM/yyyy')::text as data_inizio,
	to_char(rel.data_fine, 'dd/MM/yyyy')::text as data_fine,

	CASE WHEN (flag.categorizzabili or flag.no_scia is false) THEN rel.numero_registrazione::text ELSE null::text END as numero_registrazione,

	CASE WHEN (flag.categorizzabili or flag.no_scia is false) THEN rel.codice_ufficiale_esistente::text ELSE null::text END as gia_codificato_come,

	CASE WHEN (rel.codice_nazionale is null or trim(rel.codice_nazionale) = '') THEN null::text ELSE rel.codice_nazionale::text END as cun,

	CASE WHEN (flag.no_scia and lsl.code = 4) THEN concat(lsl.description, '/REVOCATO')::text ELSE lsl.description::text END as stato,

	CASE WHEN string_agg(concat(lvso.description, to_char(vsos.data_variazione, 'dd/MM/yyyy')), '') <> '' then 
	string_agg(concat(' Data ', lvso.description, ' ', to_char(vsos.data_variazione, 'dd/MM/yyyy')), '-><br/>' order by vsos.data_variazione ,vsos.data )::text else 
	 ''::text end 
	as variazione_stato,
	
	-- dati categorizzazione linea (VERSIONE STATICA)
	case when rel.id_ultimo_controllo_sorveglianza is null then null else rel.id_ultimo_controllo_sorveglianza
	end as id_controllo_ultima_categorizzazione,
	case when rel.id_ultimo_controllo_sorveglianza is null then ''  else 'CATEGORIZZATO DA CU' 
	END as tipo_categorizzazione,
    case when rel.id_ultimo_controllo_sorveglianza is null then flag.categoria_rischio_default else 
			  (select t.categoria_rischio from ticket t where t.ticketid = rel.id_ultimo_controllo_sorveglianza and t.trashed_date is null)
	end as categoria_rischio,
	(select * from get_valori_anagrafica_dati_aggiuntivi(_altid, rel.id))::text as dati_aggiuntivi
	from opu_stabilimento s
	join opu_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = s.id and rel.enabled
	left join ml8_linee_attivita_nuove_materializzata ml8 on ml8.id_nuova_linea_attivita = rel.id_linea_produttiva
	left join opu_lookup_tipologia_carattere oltc on oltc.code = rel.tipo_carattere
	left join opu_lookup_norme_master_list norme on norme.code = ml8.id_norma
	left join lookup_stato_lab lsl on lsl.code = rel.stato
	left join master_list_configuratore_livelli_aggiuntivi_values v on rel.id = v.id_istanza and v.checked
	left join master_list_configuratore_livelli_aggiuntivi l on l.id = v.id_configuratore_livelli_aggiuntivi 
	left join master_list_configuratore_livelli_aggiuntivi l2 on l2.id = l.id_padre
	left join master_list_configuratore_livelli_aggiuntivi l3 on l3.id = l2.id_padre 
	left join master_list_flag_linee_attivita flag on ml8.id_nuova_linea_attivita = flag.id_linea
	left join variazione_stato_operazioni_storico vsos on vsos.id_stabilimento = s.id and vsos.id_rel_stab_lp = rel.id 
	left join lookup_variazione_stato_operazioni lvso on lvso.code = vsos.id_operazione

	where s.alt_id = _altid
	group by s.id, norme.description, ml8.macroarea, ml8.aggregazione, ml8.attivita, oltc.description, rel.data_inizio, rel.data_fine, flag.categorizzabili, flag.no_scia, rel.numero_registrazione, rel.codice_ufficiale_esistente, rel.codice_nazionale, 
	lsl.description, ml8.norma, lsl.code, rel.id, flag.categoria_rischio_default
	order by ml8.norma asc;

 END;
$BODY$;

ALTER FUNCTION public.get_valori_anagrafica_linee(integer)
    OWNER TO postgres;

	
CREATE TABLE IF NOT EXISTS cl_23.sorv_parametrizzazioni_categoria_qualitativa
(
    id integer serial,
    range_da double precision,
    range_a double precision,
    categoria text,
    enabled boolean DEFAULT true
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.sorv_parametrizzazioni_categoria_qualitativa
    OWNER to postgres;
    
-- nuove dbi
CREATE OR REPLACE FUNCTION public.sorv_calcola_ultima_categorizzazione_linea(
	_riferimento_id integer, _riferimento_id_nome_tab text)
    RETURNS TABLE(riferimento_id integer, riferimento_nome_tab text, categoria_rischio integer, id_controllo_ultima_categorizzazione integer, data_controllo_ultima_categorizzazione timestamp without time zone, tipo_categorizzazione text, codice_linea text, id_linea_attivita integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE  
BEGIN
		return query
					with cte_ext as (
						with cte_int as	(
							 select t.assigned_date, 
							 t.ticketid as id_controllo,
							 t.categoria_rischio,
							 t.assigned_date as data_controllo,
							linee.codice_linea,
							linee.id_linea_attivita,
							case 	when t.alt_id > 0 then t.alt_id
									when t.id_stabilimento > 0 then t.id_stabilimento
									when t.id_apiario > 0 then t.id_apiario
									when t.org_id > 0 then t.org_id 
							end as rifid,
							case 	when t.alt_id > 0 then (select return_nome_tabella from gestione_id_alternativo(t.alt_id,-1))
									when t.id_stabilimento > 0 then 'opu_stabilimento'
									when t.id_apiario > 0 then 'apicoltura_imprese'
									when t.org_id > 0 then 'organization' 
							end as riftab
							from ticket t
							join linee_attivita_controlli_ufficiali linee on linee.id_controllo_ufficiale = t.ticketid and linee.trashed_date is null
							where t.tipologia=3 and t.trashed_date is null and t.provvedimenti_prescrittivi=5 and t.closed is not null
							--and t.id_stabilimento = 352705
							order by rifid, riftab, assigned_date desc
						)
						select distinct on  (id_linea_attivita)
								id_controllo,
								rifid,
								riftab,
								cte_int.categoria_rischio,
								id_controllo as id_controllo_ultima_categorizzazione,
								data_controllo as data_controllo_ultima_categorizzazione,
								cte_int.codice_linea,
								cte_int.id_linea_attivita,
								case when id_controllo is null then 'EX ANTE' ELSE 'CATEGORIZZATO DA CU' end as tipo_categorizzazione
								from cte_int
						) 
						select distinct 
						l.rifid,
						l.riftab,
						l.categoria_rischio,
						l.id_controllo as id_controllo_ultima_categorizzazione,
						l.data_controllo_ultima_categorizzazione,
						case when l.id_controllo is null then 'EX ANTE' ELSE 'CATEGORIZZATO DA CU' end as tipo_categorizzazione,
						l.codice_linea::text,
						l.id_linea_attivita
						from cte_ext l 
						left join get_linee_attivita(l.rifid,l.riftab, false, coalesce(l.id_controllo,-1)) v  
						on l.id_linea_attivita  = v.id_attivita
						where l.rifid = _riferimento_id and l.riftab= _riferimento_id_nome_tab;
						
 END;
$BODY$;

ALTER FUNCTION public.sorv_calcola_ultima_categorizzazione_linea(integer, text)
    OWNER TO postgres;



CREATE OR REPLACE FUNCTION public.sorv_aggiorna_categoria_linee(
	_riferimento_id integer,
	_riferimento_id_nome_tab text,
	_id_linea integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE  
	idcontrollo integer;
BEGIN
		raise info '[aggiorna_categoria_linee] RIFID: %', _riferimento_id;
		idcontrollo := (select id_controllo_ultima_categorizzazione from sorv_calcola_ultima_categorizzazione_linea(_riferimento_id, _riferimento_id_nome_tab) where id_linea_attivita = _id_linea);
		raise info 'id controllo: %',idcontrollo;
		raise info 'id_linea: %', _id_linea;
		if ( _riferimento_id_nome_tab = 'opu_stabilimento') then
			update opu_relazione_stabilimento_linee_produttive set id_ultimo_controllo_sorveglianza = idcontrollo where id_stabilimento = _riferimento_id and 
			id = _id_linea and enabled;
		elsif ( _riferimento_id_nome_tab = 'sintesis_stabilimento') then
			update sintesis_relazione_stabilimento_linee_produttive set id_ultimo_controllo_sorveglianza = idcontrollo where id_stabilimento = (select return_id from public.gestione_id_alternativo(_riferimento_id,-1)) and 
			id = _id_linea and enabled;
		end if;
		
 RETURN true;
 END;
$BODY$;

ALTER FUNCTION public.sorv_aggiorna_categoria_linee(integer, text, integer)
    OWNER TO postgres;
	

CREATE OR REPLACE FUNCTION public.sorv_categoria_qualitativa(
	_riferimento_id integer,
	_riferimento_id_nome_tab text)
    RETURNS TABLE(categoria_qualitativa text, media_categoria double precision) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE  
		num_linee integer;
		somma_categorie integer;
		media double precision;
		categoria text;
		idcategoria integer;
BEGIN
		if( _riferimento_id_nome_tab = 'opu_stabilimento') then
			num_linee := (select count(*) from opu_relazione_stabilimento_linee_produttive where id_stabilimento = _riferimento_id);	
			somma_categorie := (select sum(coalesce((select t.categoria_rischio from ticket t where t.ticketid = rel.id_ultimo_controllo_sorveglianza 
												 and t.trashed_date is null),(flag.categoria_rischio_default)))
							from opu_relazione_stabilimento_linee_produttive rel
							join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva
							where rel.id_stabilimento = _riferimento_id 
							and rel.enabled);
		elsif ( _riferimento_id_nome_tab = 'sintesis_stabilimento') then 
			num_linee := (select count(*) from sintesis_relazione_stabilimento_linee_produttive where id_stabilimento = ((select return_id from public.gestione_id_alternativo(_riferimento_id,-1))));
			somma_categorie := (select sum(coalesce((select t.categoria_rischio from ticket t where t.ticketid = rel.id_ultimo_controllo_sorveglianza 
												 and t.trashed_date is null),(flag.categoria_rischio_default)))
							from sintesis_relazione_stabilimento_linee_produttive rel
							join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva
							where rel.id_stabilimento = (select return_id from public.gestione_id_alternativo(_riferimento_id,-1)) 
							and rel.enabled);
		end if;
		raise info 'Totale linee: %', num_linee;
		raise info 'somma categorie: %', somma_categorie;
		media := (somma_categorie::double precision/ num_linee)::double precision;
		raise info 'media: %', media;
		categoria := (select qual.categoria from cl_23.sorv_parametrizzazioni_categoria_qualitativa qual where media between qual.range_da and qual.range_a);
		raise info 'Categoria: %', categoria;
		return query select categoria, media;
END;
$BODY$;

ALTER FUNCTION public.sorv_categoria_qualitativa(integer, text)
    OWNER TO postgres;
	
CREATE OR REPLACE FUNCTION public.sorv_categoria_qualitativa(
	_riferimento_id integer,
	_riferimento_id_nome_tab text)
    RETURNS TABLE(categoria_qualitativa text, media_categoria double precision) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE  
		num_linee integer;
		somma_categorie integer;
		media double precision;
		categoria text;
		idcategoria integer;
BEGIN
		if( _riferimento_id_nome_tab = 'opu_stabilimento') then
			num_linee := (select count(*) from opu_relazione_stabilimento_linee_produttive where id_stabilimento = _riferimento_id);	
			somma_categorie := (select sum(coalesce((select t.categoria_rischio from ticket t where t.ticketid = rel.id_ultimo_controllo_sorveglianza 
												 and t.trashed_date is null),(flag.categoria_rischio_default)))
							from opu_relazione_stabilimento_linee_produttive rel
							join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva
							where rel.id_stabilimento = _riferimento_id 
							and rel.enabled);
		elsif ( _riferimento_id_nome_tab = 'sintesis_stabilimento') then 
			num_linee := (select count(*) from sintesis_relazione_stabilimento_linee_produttive where id_stabilimento = ((select return_id from public.gestione_id_alternativo(_riferimento_id,-1))));
			somma_categorie := (select sum(coalesce((select t.categoria_rischio from ticket t where t.ticketid = rel.id_ultimo_controllo_sorveglianza 
												 and t.trashed_date is null),(flag.categoria_rischio_default)))
							from sintesis_relazione_stabilimento_linee_produttive rel
							join master_list_flag_linee_attivita flag on flag.id_linea = rel.id_linea_produttiva
							where rel.id_stabilimento = (select return_id from public.gestione_id_alternativo(_riferimento_id,-1)) 
							and rel.enabled);
		end if;
		raise info 'Totale linee: %', num_linee;
		raise info 'somma categorie: %', somma_categorie;
		media := (somma_categorie::double precision/ num_linee)::double precision;
		raise info 'media: %', media;
		categoria := (select qual.categoria from cl_23.sorv_parametrizzazioni_categoria_qualitativa qual where media between qual.range_da and qual.range_a);
		raise info 'Categoria: %', categoria;
		return query select categoria, media;
END;
$BODY$;

ALTER FUNCTION public.sorv_categoria_qualitativa(integer, text)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.sorv_chiudi_cu(
	_idcu integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

declare
 	json_result text;
	messaggio text;
	num_nc_chiuse integer;
	num_nc_terzi_chiuse integer;
	iscontrollochiuso boolean;
	categoria integer;
	rifid integer;
	idlineacu integer;
	rifnometab text;
	aggiornata_categoria boolean;
	categoriaqualitativa integer;
BEGIN
	
		iscontrollochiuso := (select case when closed is not null then true else false end from ticket where ticketid = _idcu and trashed_date is null);
		num_nc_chiuse := (select count(*) from ticket where closed is null and tipologia=8 and trashed_date is null and id_controllo_ufficiale=_idcu::text);
		num_nc_terzi_chiuse := (select count(*) from ticket where closed is null and tipologia=10 and trashed_date is null  and id_controllo_ufficiale=_idcu::text);
		
		if iscontrollochiuso then
			messaggio := 'KO. Il controllo risulta chiuso in precedenza.';
	   		select concat('{"idControlloUfficiale" : "', _idcu, '", 
					   "numNonConformitaChiuse" : "', num_nc_chiuse,'",
					   "numNonConformitaTerziChiuse" : "', num_nc_terzi_chiuse,'",
					   "messaggio" : "', messaggio, '"}') 
			into json_result;
		else
			categoria := (select c.categoria  from cl_23.sorv_get_dettaglio(_idcu) c);
			update ticket set closed=now() where id_controllo_ufficiale=_idcu::text and closed is null;
			update ticket set closed=now(), status_id=2, categoria_rischio = categoria, isaggiornata_categoria=true where ticketid = _idcu::integer;
			
			-- aggiorno la categoria di rischio per la linea di attività controllata
			rifid := (select case when id_apiario > 0 then id_apiario 
					  			  when alt_id > 0 then alt_id
					              when id_stabilimento > 0 then id_stabilimento 
					  			  when org_id > 0 then org_id 
					  else -1 end from ticket where ticketid = _idcu and trashed_date is null);
			rifnometab := (select case when id_apiario > 0 then 'apicoltura_imprese' 
					  			  when alt_id > 0 then 'sintesis_stabilimento'
					              when id_stabilimento > 0 then 'opu_stabilimento' 
					  			  when org_id > 0 then 'organization' 
					  else '' end from ticket where ticketid = _idcu and trashed_date is null);
			idlineacu := (select id_linea_attivita from linee_attivita_controlli_ufficiali where id_controllo_ufficiale = _idcu and trashed_date is null);
			raise info 'Riferimento id: %', rifid;
			raise info 'Riferimento nome tab: %', rifnometab;
			raise info 'Riferimento id linea controllata: %', idlineacu;
			
			aggiornata_categoria := (select * from sorv_aggiorna_categoria_linee(rifid, rifnometab,idlineacu));
			raise info 'Aggiornata categoria: %', aggiornata_categoria;
			
	   		messaggio := 'Chiusura CU eseguita correttamente.';
	   		select concat('{"idControlloUfficiale" : "', _idcu, '", 
					   "numNonConformitaChiuse" : "', num_nc_chiuse,'",
					   "numNonConformitaTerziChiuse" : "', num_nc_terzi_chiuse,'",
					   "messaggio" : "', messaggio, '"}') 
			into json_result;
		end if;
		return json_result;	
END
$BODY$;

ALTER FUNCTION public.sorv_chiudi_cu(integer)
    OWNER TO postgres;

	
	
CREATE OR REPLACE FUNCTION public.sorv_get_riferimenti_id_e_nome_tab_da_cu(
	_idcu integer)
    RETURNS table(riferimento_id integer, riferimento_id_nome_tab text)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	rifid integer;
	rifnometab text; 
BEGIN
	       rifid := (select case when id_apiario > 0 then id_apiario 
					  			  when alt_id > 0 then alt_id
					              when id_stabilimento > 0 then id_stabilimento 
					  			  when org_id > 0 then org_id 
					  else -1 end from ticket where ticketid = _idcu and trashed_date is null);
			rifnometab := (select case when id_apiario > 0 then 'apicoltura_imprese' 
					  			  when alt_id > 0 then 'sintesis_stabilimento'
					              when id_stabilimento > 0 then 'opu_stabilimento' 
					  			  when org_id > 0 then 'organization' 
					  else '' end from ticket where ticketid = _idcu and trashed_date is null);

		return query select rifid, rifnometab;
END
$BODY$;

ALTER FUNCTION public.sorv_get_riferimenti_id_e_nome_tab_da_cu(integer)
    OWNER TO postgres;
	


    
insert into cl_23.sorv_parametrizzazioni_categoria_qualitativa(range_da, range_a, categoria) values (0,3.5,'RISCHIO BASSO');
insert into cl_23.sorv_parametrizzazioni_categoria_qualitativa(range_da, range_a, categoria) values (3.6,4.4,'RISCHIO MEDIO');
insert into cl_23.sorv_parametrizzazioni_categoria_qualitativa(range_da, range_a, categoria) values (4.5,NULL,'RISCHIO ALTO');


alter table cl_23.sorv_parametrizzazioni_categoria add column categoria_qualitativa text;
update cl_23.sorv_parametrizzazioni_categoria set categoria_qualitativa='RISCHIO BASSO' where id in (1,2);
update cl_23.sorv_parametrizzazioni_categoria set categoria_qualitativa='RISCHIO MEDIO' where id in (3,4);
update cl_23.sorv_parametrizzazioni_categoria set categoria_qualitativa='RISCHIO ALTO' where id in (5);

CREATE TABLE IF NOT EXISTS cl_23.e_risto_col
(
    id serial,
    prog numeric NOT NULL,
    domanda text COLLATE pg_catalog."default" NOT NULL,
    comp_conf numeric,
    no_comp_conf numeric,
    no_conf numeric,
    sez text COLLATE pg_catalog."default",
    comm text COLLATE pg_catalog."default",
    trashed_date text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.e_risto_col
    OWNER to postgres;
    
DROP FUNCTION get_valori_anagrafica_linee(integer);
 CREATE OR REPLACE FUNCTION public.get_valori_anagrafica_extra(
	_altid integer)
    RETURNS TABLE(inserito_da text, inserito_il text, categoria_di_rischio text, data_prossimo_controllo text, data_inizio text, stato text, tipo_attivita text, note text, categorizzabili text, note_impresa text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
	r RECORD;
	descrizioneStato text;
	idLineaAttiva integer;
	flagCategorizzabili boolean;
	id_stato_stab integer;	
	_id_stabilimento integer;
	_cat_di_rischio integer;
BEGIN

	select get_stato_stabilimento into id_stato_stab from get_stato_stabilimento(_altid);

	IF id_stato_stab = 0 THEN
		descrizioneStato := 'Attivo';
	ELSIF id_stato_stab = 2 THEN
		descrizioneStato := 'Sospeso';
	ELSE 
		descrizioneStato := 'Cessato';
	END IF;

	select id into _id_stabilimento from opu_stabilimento where alt_id = _altid; 

	update opu_stabilimento 
	set data_inizio_attivita = (select min(orels.data_inizio) from opu_relazione_stabilimento_linee_produttive orels where orels.id_stabilimento = _id_stabilimento and orels.enabled) 
	where id = _id_stabilimento;    

	select flag.categorizzabili into flagCategorizzabili 
		from opu_relazione_stabilimento_linee_produttive oprel join ml8_linee_attivita_nuove_materializzata ml8 on oprel.id_linea_produttiva  = ml8.id_nuova_linea_attivita
			join master_list_flag_linee_attivita flag on ml8.id_nuova_linea_attivita = flag.id_linea
		where  oprel.enabled and  oprel.id_stabilimento = (select os.id from opu_stabilimento os where os.alt_id = _altid) order by flag.categorizzabili desc;

	/*IF _cat_di_rischio < 0 and flagCategorizzabili THEN
		select coalesce(max(categoria_rischio_default),3)::integer into _cat_di_rischio 
			from opu_relazione_stabilimento_linee_produttive rel 
				join ml8_linee_attivita_nuove_materializzata ml8 on ml8.id_nuova_linea_attivita = rel.id_linea_produttiva 
				left join master_list_flag_linee_attivita flag on flag.id_linea = ml8.id_nuova_linea_attivita
			where flag.categorizzabili and rel.enabled and rel.id_stabilimento = _id_stabilimento;
		update opu_stabilimento set categoria_rischio = _cat_di_rischio where id = _id_stabilimento;
		perform refresh_anagrafica(_id_stabilimento, 'opu');
	END IF;*/
		

	FOR
	inserito_da, inserito_il, categoria_di_rischio, data_prossimo_controllo, data_inizio, stato, tipo_attivita, note, categorizzabili, note_impresa
	in
	select 

	CASE WHEN acc.user_id > 0 THEN 
		concat_ws(' ', con.namefirst, con.namelast) 
	ELSE concat_ws(' ', conext.namefirst, conext.namelast) 
	END as inserito_da,
	to_char(s.entered, 'dd/MM/yyyy') as inserito_il,

	--coalesce(s.categoria_rischio::text,'')::text as categoria_di_rischio,
	(select coalesce(categoria_qualitativa,'') as categoria_di_rischio from  cl_23.sorv_parametrizzazioni_categoria 
	 where id = (select categoria_qualitativa from opu_stabilimento where id = s.id and trashed_date is null)),
	
	CASE WHEN s.categoria_rischio is not null THEN 
		to_char(COALESCE(s.data_prossimo_controllo,  now()), 'dd/MM/yyyy') 
	ELSE ''
	END as data_prossimo_controllo,
	to_char(s.data_inizio_attivita, 'dd/MM/yyyy') as data_inizio,
	descrizioneStato as stato,
	lti.description as tipo_attivita,
	--s.note::text as note,
	CASE WHEN (length(trim(s.note)) <> 0) THEN trim( regexp_replace(s.note, '\r|\n', ' ', 'g'))::text ELSE ''::text END as note,
	flagCategorizzabili::text as categorizzabili,
	CASE WHEN (length(trim(o.note)) <> 0) THEN trim( regexp_replace(o.note, '\r|\n', ' ', 'g'))::text ELSE ''::text END as note_impresa

	from opu_stabilimento s
	join opu_operatore o on s.id_operatore = o.id
	left join access_ acc on acc.user_id = s.entered_by
	left join contact_ con on con.contact_id = acc.contact_id
	left join access_ext_ accext on accext.user_id = s.entered_by
	left join contact_ext_ conext on conext.contact_id = accext.contact_id
	left join lookup_tipo_attivita lti on lti.code = s.tipo_attivita

	where s.alt_id = _altid

	    LOOP
		RETURN NEXT;
	     END LOOP;
	     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.get_valori_anagrafica_extra(integer)
    OWNER TO postgres;
    
 -- update_categoria_rischio_qualitativa_mercati(integer)
-- FUNCTION: public.update_categoria_rischio_qualitativa_mercati(integer)
-- DROP FUNCTION IF EXISTS public.update_categoria_rischio_qualitativa_mercati(integer);

CREATE OR REPLACE FUNCTION public.update_categoria_rischio_qualitativa_mercati(
	_id_controllo integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE  
 msg text;  
 tot_cu_mercato integer;
 tot_categorie_cu_mercato integer;
 tot_cu_operatori integer;
 tot_categorie_cu_operatori integer;
 media integer;
 categoriaqualitativa integer;

 id_linea_operatore_mercato integer;
 id_linea_mercato integer;
 _id_mercato integer;
 _id_operatore_mercato integer;
 _id_stabilimento integer;
 
BEGIN 

categoriaqualitativa = -1;
id_linea_mercato = -1;

-- verifico se si tratti di una linea al mercato;
id_linea_operatore_mercato := (
select ml.id_nuova_linea_attivita
from ticket t
join opu_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = t.id_stabilimento and rel.enabled
join ml8_linee_attivita_nuove_materializzata ml on ml.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on ml.id_nuova_linea_attivita = flag.id_linea
where t.ticketid = _id_controllo and flag.operatore_mercato and t.trashed_date is null);

id_linea_mercato :=(
select ml.id_nuova_linea_attivita
from ticket t
join sintesis_stabilimento s on s.alt_id=t.alt_id and s.trashed_date is null
join sintesis_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = s.id and rel.enabled
join ml8_linee_attivita_nuove_materializzata ml on ml.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on ml.id_nuova_linea_attivita = flag.id_linea
where t.ticketid = _id_controllo and ml.codice ilike 'MS.B-MS.B80-MS.B80.600'
);

-- se il CU è stato effettuato su un operatore al mercato o su un mercato
if (id_linea_operatore_mercato > 0 or id_linea_mercato > 0) then -- vado avanti ad individuare l'osa

          _id_mercato := (select * from public.get_altid_mercato_by_idcu(_id_controllo)); -- sintesis
          _id_operatore_mercato := (select * from public.get_altid_operatore_mercato_by_idcu(_id_controllo)); -- operatore

          if _id_mercato > 0 then -- controlli sul mercato
		_id_stabilimento := _id_mercato;
		
          end if;
          if _id_operatore_mercato > 0 then -- controlli sull'operatore del mercato
		_id_stabilimento := _id_operatore_mercato;
          end if;

	raise info 'id_stabilimento finale: %', _id_stabilimento;

	tot_cu_mercato := (
					select count(cu.ticketid) 
					from ticket cu
					join sintesis_stabilimento mercatostab on mercatostab.alt_id = cu.alt_id 
					join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
					where cu.trashed_date is null 
					and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
					and mercatostab.alt_id = _id_stabilimento
				  );
	tot_categorie_cu_mercato := (
					select sum(cu.categoria_rischio)  
					from ticket cu
					join sintesis_stabilimento mercatostab on mercatostab.alt_id = cu.alt_id 
					join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
					where cu.trashed_date is null 
					and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
					and mercatostab.alt_id = _id_stabilimento
				);
		
		-- calcola per tutti gli operatori associati al mercato la categoria di rischio e il totale cu in sorveglianza
	tot_cu_operatori := (select max(totale_cu) from public.get_tot_cu_e_categorie(_id_stabilimento));
	tot_categorie_cu_operatori := (select max(somma_categorie_rischio) from public.get_tot_cu_e_categorie(_id_stabilimento));

	media = ((tot_categorie_cu_mercato + tot_categorie_cu_operatori) / (tot_cu_mercato + tot_cu_operatori));
	raise info 'media: %', media;

	if media <=1 then
		categoriaqualitativa := 91;
	end if;

	if media > 1 and media <= 3 then
		categoriaqualitativa := 92;
	end if;

	if media >=4 then
		categoriaqualitativa := 93;
	end if;

        -- aggiorna sintesis_stabilimento (livello_rischio + note hd con categoria precedente e modifica)
	update sintesis_stabilimento  set notes_hd = concat(notes_hd,'[Utilizzo funzione di aggiornamento categoria rischio qualitativa]','Livello di rischio precedente: ',livello_rischio,'; Livello di rischio attuale:',livello_rischio,'; Modificato il ',current_timestamp,'; Per chiusura cu: ', 
	_id_controllo), livello_rischio = categoriaqualitativa where alt_id = _id_stabilimento;

end if; -- fine if sulla linea al mercato

return categoriaqualitativa;

return msg;
END 
$BODY$;

ALTER FUNCTION public.update_categoria_rischio_qualitativa_mercati(integer)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.get_cu_richiede_checklist_classica(
	_idcu integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	rif_id integer;
	rif_tab text;
	isopmercato boolean;
	ismercato boolean;
	idlinea integer;
	isaziendazootecnica boolean;
BEGIN
		rif_id := (select riferimento_id from sorv_get_riferimenti_id_e_nome_tab_da_cu(_idcu));
		rif_tab := (select riferimento_id_nome_tab from sorv_get_riferimenti_id_e_nome_tab_da_cu(_idcu));
	    idlinea := (select id_rel_ateco_attivita from  get_linee_attivita(rif_id,rif_tab, false, _idcu));
		ismercato := (select distinct mercato from master_list_flag_linee_attivita where id_linea = idlinea);
		isopmercato := (select distinct operatore_mercato from master_list_flag_linee_attivita where id_linea = idlinea);
		if (rif_tab = 'organization') then
			isaziendazootecnica := (select case when tipologia_operatore = 2 then true else false end from ricerche_anagrafiche_old_materializzata 
								     where riferimento_id = rif_id and riferimento_id_nome_tab='organization');	   
		end if;
		raise info 'rif id: %', rif_id;
		raise info 'rif nome tab %', rif_tab;
		raise info 'id linea %', idlinea;
		raise info 'is operatore mercato? %', isopmercato;
		raise info 'is mercato? %', ismercato;
		raise info 'isaziendazootecnica? %', isaziendazootecnica;

		if (ismercato or isopmercato or isaziendazootecnica) then
			return true;
		else 
			return false;
		end if;
END
$BODY$;

ALTER FUNCTION public.get_cu_richiede_checklist_classica(integer)
    OWNER TO postgres;

    -- cl_23.sorv_parametrizzazioni_categoria_qualitativa usata per determinare SUBITO LA CATEGORIA_QUALITATIVA viene sostituita con
    -- cl_23.sorv_parametrizzazioni_categoria
    -- dovrebbe essere disabilitata la chiamata a questa funzione 
    --public.sorv_categoria_qualitativa(
	--_riferimento_id integer,
	--_riferimento_id_nome_tab text)

--select * from cl_23.lookup_sorv_allegati

CREATE TABLE IF NOT EXISTS cl_23.lookup_allegati_e_orsa
(
    code serial,
    description character varying(100) COLLATE pg_catalog."default" NOT NULL,
    default_item boolean DEFAULT false,
    level integer DEFAULT 0,
    enabled boolean DEFAULT true
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.lookup_allegati_e_orsa
    OWNER to postgres;
	
	insert into cl_23.lookup_allegati_e_orsa(description) values('Prodotti della pesca');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Molluschi cdm');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Molluschi csm');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Latte e prodotti lattiero caseari');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Ristorazione pubblica');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Ristorazione collettiva');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Macello ungulati');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Macello avicoli');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Macello cunicoli');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Commercio al dettaglio');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Mercato ittico');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Centro Imballaggio uova');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Impianto produzione uova liquide');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Produzione di pane,pizza e prodotti da forno e di pasticceria');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Produzione primaria');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Rivendite mangimi');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Mangimifici');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Mulini');
	insert into cl_23.lookup_allegati_e_orsa(description) values('Canili/strutture di detenzione animali d''affezione');

drop table cl_23.lookup_allegati_c_orsa;
CREATE TABLE IF NOT EXISTS cl_23.lookup_allegati_c_orsa
(
    code serial,
    description character varying(700) COLLATE pg_catalog."default" NOT NULL,
    default_item boolean DEFAULT false,
    level integer DEFAULT 0,
    enabled boolean DEFAULT true
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS cl_23.lookup_allegati_c_orsa
    OWNER to postgres;
	
	insert into cl_23.lookup_allegati_c_orsa(description) values('Carne Sezionate/CP LABORATORIO DI SEZIONAMENTO/GHE CENTRO LAVORAZIONE SELVAGGINA');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Prodotti a base di carne/preparazioni - MM LAB. DI CARNI MACINATE/MP LAB. DI PREPARAZIONI DI CARNI/MSM IMPIANTO CARNI SEPARATE MECCANICAMENTE/PP STABILIMENTO DI TRASFORMAZIONE');
	insert into cl_23.lookup_allegati_c_orsa(description) values('CARNE DEGLI UNGULATI DOMESTICI/MACELLO');
	insert into cl_23.lookup_allegati_c_orsa(description, enabled) values('MANCA', false);
	insert into cl_23.lookup_allegati_c_orsa(description, enabled) values('MANCA', false);
	insert into cl_23.lookup_allegati_c_orsa(description) values('Mercato ittico - WM MERCATO ALL''INGROSSO');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Prodotti della pesca - LAVORAZIONE E TRASFORMAZIONE DI PRODOTTI DELLA PESCA IN IMPIANTI NON RICONOSCIUTI FUNZIONALMENTE ANNESSI A ESERCIZIO DI VENDITA, CONTIGUI O MENO AD ESSI/FFPP LOCALE DI CERNITA E SEZIONAMENTO/FFPP LOCALE DI MACELLAZIONE DI PROD. DI ACQUACULTURA/FV NAVE OFFICINA/MSM IMPIANTO CARNI SEPARATE MECCANICAMENTE/PP STABILIMENTO DI TRASFORMAZIONE/ZV NAVE DEPOSITO FRIGORIFERO');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Molluschi-DC CENTRO DI SPEDIZIONE MOLLUSCHI/PC CENTRO DI DEPURAZIONE MOLLUSCHI');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Latte-Stabilimenti di trasformazione/PP CENTRO DI STANDARDIZZAZIONE/PP STABILIMENTO DI STAGIONATURA/PRODUZIONE DI PRODOTTI A BASE DI LATTE (IN IMPIANTI NON RICONOSCIUTI)');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Latte-CC CENTRO DI RACCOLTA/PP STABILIMENTO DI TRATTAMENTO TERMICO');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Ristorazione pubblica');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Ristorazione collettiva');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Produzione primaria');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Uova-EPC CENTRO DI IMBALLAGGIO UOVA');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Mangimificio');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Mulini');
	insert into cl_23.lookup_allegati_c_orsa(description) values('Tutte le altre linee di attivita'' (rif. Nortmativo ELEMENTI PER DEFINIRE LA DIMENSIONE DELL''IMPRESA” DECRETO  DEL MINISTERO DELLE ATTIVITA'' PRODUTTIVE 18/04/2005');
	
--------------------- RIPRESA DEL FLUSSO 329 --------------------------------
update cl_23.lookup_sorv_allegati set id_parte_speciale = null where short_description ilike '%C-%';
update master_list_flag_linee_attivita set sorv_id_allegato_c = null where sorv_id_allegato_c > 0;
-- esempio solo con ristorazione pubblica e privata
update master_list_flag_linee_attivita set sorv_id_allegato_c = 11 where sorv_id_allegato_e = 5;
update master_list_flag_linee_attivita set sorv_id_allegato_c = 12 where sorv_id_allegato_e = 6;

update cl_23.lookup_sorv_allegati set id_parte_speciale = 11 where short_description ilike '%C-ristopub%';
update cl_23.lookup_sorv_allegati set id_parte_speciale = 12 where short_description ilike '%C-risto-coll%';
delete from cl_23.e_risto_col where prog=104;

