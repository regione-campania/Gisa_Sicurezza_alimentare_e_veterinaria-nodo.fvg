alter table master_list_aggregazione add column note_hd text;
--select * from master_list_aggregazione where aggregazione ilike '%copn%'
update master_list_aggregazione set note_hd='Integrazione Flusso 363 di 11/23', aggregazione=replace(aggregazione,'copn','con') where aggregazione ilike '%copn%';

select 'select * from refresh_ml_materializzata('||a.id||');' 
from 
master_list_linea_attivita a
join master_list_aggregazione agg on agg.id = a.id_aggregazione
where agg.aggregazione='SECTION I - Magazzinaggio con manipolazione Cat. 1'
union
select 'select * from refresh_ml_materializzata('||a.id||');' 
from 
master_list_linea_attivita a
join master_list_aggregazione agg on agg.id = a.id_aggregazione
where agg.aggregazione='SECTION I - Magazzinaggio con manipolazione Cat. 2'
union
select 'select * from refresh_ml_materializzata('||a.id||');' 
from 
master_list_linea_attivita a
join master_list_aggregazione agg on agg.id = a.id_aggregazione
where agg.aggregazione='SECTION I - Magazzinaggio con manipolazione Cat. 3'

update master_list_aggregazione set note_hd='Integrazione Flusso 363 di 11/23', 
aggregazione='SECTION VIII - impianti di produzione di alimenti per animali da compagnia Cat. 3' 
where rev=11 and aggregazione ilike 'SECTION VIII - ALIMENTI PER ANIMALI DA COMPAGNIA CAT. 3';
select * from refresh_ml_materializzata();

select 'select * from refresh_ml_materializzata('||a.id||');' 
from 
master_list_linea_attivita a
join master_list_aggregazione agg on agg.id = a.id_aggregazione
where agg.aggregazione='SECTION VIII - impianti di produzione di alimenti per animali da compagnia Cat. 3';

/*
update master_list_linea_attivita set note_hd=concat_ws(';',note_hd,'Integrazione Flusso 363 di 11/23 (vecchia descrizione PHAR ATTIVITÀ FARMACEUTICHE (INCLUSI I DISPOSITIVI MEDICI) )'), 
linea_attivita ='PHAR ATTIVITÀ FARMACEUTICHE (INCLUSI I DISP. MEDICI)' 
where linea_attivita ilike '%PHAR ATTIVITÀ FARMACEUTICHE (INCLUSI I DISPOSITIVI MEDICI)%';

select 'select * from refresh_ml_materializzata('||id||');' from 
master_list_linea_attivita 
where linea_attivita ilike '%PHAR ATTIVITÀ FARMACEUTICHE (INCLUSI I DISP. MEDICI)%';
*/