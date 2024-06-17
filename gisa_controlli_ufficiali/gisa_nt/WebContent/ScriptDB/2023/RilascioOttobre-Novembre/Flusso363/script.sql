
select * from master_list_linea_attivita where linea_attivita ilike '%UDER%' and rev <> 11;
select  id_nuova_linea_attivita, path_descrizione from ml8_linee_attivita_nuove_materializzata where id_nuova_linea_attivita in (
40730,
40739,
40748,
40165,
40174,
40183)

select 'update master_list_linea_attivita set 
note_hd='';[Flusso 363] Vecchia descrizione: '||linea_attivita||''',
linea_attivita=''UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA'' 
where linea_attivita ilike ''%UDER UTILIZZO PER SCOPI DIAGNOSTICI, DIDATTICI E RICERCA%'';select * from refresh_ml_materializzata('||id||');'
from master_list_linea_attivita where linea_attivita ilike '%UDER UTILIZZO PER SCOPI DIAGNOSTICI, DIDATTICI E RICERCA%';


update ml8_linee_attivita_nuove_materializzata set 
descrizione='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
attivita='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION X - Usi in deroga Cat. 1->UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA'
where id_nuova_linea_attivita = 40730;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
attivita='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION X - Usi in deroga Cat. 2->UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA'
where id_nuova_linea_attivita = 40739;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
attivita='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION X - Usi in deroga Cat. 3->UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA'
where id_nuova_linea_attivita = 40748;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
attivita='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION X - Usi in deroga Cat. 1->UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA'
where id_nuova_linea_attivita = 40165;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
attivita='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION X - Usi in deroga Cat. 2->UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA'
where id_nuova_linea_attivita = 40174;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
attivita='UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION X - Usi in deroga Cat. 3->UDER UTILIZZO PER SCOPI DIAGNOSTICI,DIDATTICI,RICERCA'
where id_nuova_linea_attivita = 40183;


delete from ricerche_anagrafiche_old_materializzata;
insert into ricerche_anagrafiche_old_materializzata (select * from ricerca_anagrafiche);