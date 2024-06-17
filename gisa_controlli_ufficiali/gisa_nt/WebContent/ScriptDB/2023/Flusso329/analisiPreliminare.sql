-- aggiunta delle colonne nuove
alter table master_list_flag_linee_attivita
add column allegati_categorizzazione text,
add column parte_speciale boolean,
add column allegati_a text,
add column allegati_b text,
add column allegati_c text,
add column allegati_d text,
add column allegati_e text;

-- creazione tabella d'appoggio
create table import_master_list_csv(
	codice_univoco text,
	allegati_categorizzazione text,
	parte_speciale text
);
-- creato il file .csv contentente codice_univoco ed i valori per le due colonne nuove

-- update
update master_list_flag_linee_attivita
set allegati_categorizzazione = imp.allegati_categorizzazione,
 	parte_speciale = imp.parte_speciale::boolean
from(select * from import_master_list_csv) as imp
where imp.codice_univoco = master_list_flag_linee_attivita.codice_univoco;

-- split allegati_categorizzazione nelle rispettive colonne
update master_list_flag_linee_attivita
set allegati_a = (case when substring(allegati_categorizzazione,9) ilike '%a%' then 'a' end),
 allegati_b = (case when substring(allegati_categorizzazione,9) ilike '%b%' then 'b' end),
 allegati_c = (case when substring(allegati_categorizzazione,9) ilike '%c%' then 'c' end),
 allegati_d = (case when substring(allegati_categorizzazione,9) ilike '%d%' then 'd' end),
 allegati_e = (case when substring(allegati_categorizzazione,9) ilike '%e%' then 'e' end)
where allegati_categorizzazione is not null;

-- drop della tabella d'appoggio
drop table import_maser_list_csv;