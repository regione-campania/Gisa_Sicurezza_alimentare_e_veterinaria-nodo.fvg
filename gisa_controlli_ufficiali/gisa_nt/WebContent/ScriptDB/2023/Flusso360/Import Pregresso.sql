--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->RECAPITI

-- Verifico linee
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev <> 11;

-- Verifico anagrafiche
select r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale, r.partita_iva, r.n_reg, f.rev from ricerche_anagrafiche_old_materializzata r left join master_list_linea_attivita a on a.id = r.id_attivita left join master_list_flag_linee_attivita f on f.id_linea = a.id where a.codice_univoco = 'CG-NAZ-R-007' order by f.rev;

-- Verifico campi estesi
select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 11)) and enabled order by id_linea asc, ordine asc;

-------------------------------------- Rev 8

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8))) and enabled;

-- Inserisco nuovi valori campi estesi

-- Direttore recapito
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and enabled and nome_campo = 'dir_recapito'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- codice_fiscale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- Titolo di studio
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and enabled and nome_campo = 'titolo_studio'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and enabled and nome_campo = 'codice_recapito'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_recapito');

-------------------------------------- Rev 10

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10))) and enabled;

-- Inserisco nuovi valori campi estesi

-- Direttore recapito
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and enabled and nome_campo = 'dir_recapito'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- codice_fiscale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- Titolo di studio
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and enabled and nome_campo = 'titolo_studio'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and enabled and nome_campo = 'codice_recapito'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_recapito');

-----------------------------------------------------------------------------------

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->CENTRO PRODUZIONE MATERIALE SEMINALE

-- Verifico linee
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev <> 11;

-- Verifico anagrafiche
select r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale, r.partita_iva, r.n_reg, f.rev from ricerche_anagrafiche_old_materializzata r left join master_list_linea_attivita a on a.id = r.id_attivita left join master_list_flag_linee_attivita f on f.id_linea = a.id where a.codice_univoco = 'CG-NAZ-R-003' order by f.rev;

-- Verifico campi estesi
select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 11)) and enabled order by id_linea asc, ordine asc;

-------------------------------------- Rev 8

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8))) and enabled;

-- Inserisco nuovi valori campi estesi

-- veterinario responsabile
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'veterinario_responsabile'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- data_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'data_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'data_nascita');

-- nazione_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'nazione_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nazione_nascita');

-- comune_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'comune_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_nascita');

-- codice_fiscale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- indirizzo residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'indirizzo_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'indirizzo_res_medico');

-- comune residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'comune_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_res_medico');

-- provincia residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'provincia_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'provincia_res_medico');

-- codice_iscrizione_elenco_regionale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'codice_iscrizione_elenco_regionale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_iscrizione_elenco_regionale');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and enabled and nome_campo = 'codice_stazione'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_stazione');

-------------------------------------- Rev 10

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10))) and enabled;

-- Inserisco nuovi valori campi estesi

-- veterinario responsabile
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'veterinario_responsabile'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- data_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'data_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'data_nascita');

-- nazione_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'nazione_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nazione_nascita');

-- comune_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'comune_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_nascita');

-- codice_fiscale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- indirizzo residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'indirizzo_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'indirizzo_res_medico');

-- comune residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'comune_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_res_medico');

-- provincia residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'provincia_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'provincia_res_medico');

-- codice_iscrizione_elenco_regionale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'codice_iscrizione_elenco_regionale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_iscrizione_elenco_regionale');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and enabled and nome_campo = 'codice_stazione'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_stazione');

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->CENTRO DI PRODUZIONE EMBRIONI	

-- Verifico linee
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev <> 11;

-- Verifico anagrafiche
select r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale, r.partita_iva, r.n_reg, f.rev from ricerche_anagrafiche_old_materializzata r left join master_list_linea_attivita a on a.id = r.id_attivita left join master_list_flag_linee_attivita f on f.id_linea = a.id where a.codice_univoco = 'CG-NAZ-B' order by f.rev;

-- Verifico campi estesi
select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 11)) and enabled order by id_linea asc, ordine asc;

-------------------------------------- Rev 8

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8))) and enabled;

-- Inserisco nuovi valori campi estesi

-- veterinario direttore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'veterinario_direttore_sanitario'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- data_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'data_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'data_nascita');

-- nazione_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'nazione_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nazione_nascita');

-- comune_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'comune_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_nascita');

-- codice_fiscale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- indirizzo residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'indirizzo_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'indirizzo_res_medico');

-- comune residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'comune_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_res_medico');

-- provincia residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'provincia__res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'provincia__res_medico');

-- codice_iscrizione_elenco_regionale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'codice_iscrizione_elenco_regionale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_iscrizione_elenco_regionale');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and enabled and nome_campo = 'codice_stazione'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_stazione');

-------------------------------------- Rev 10

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10))) and enabled;

-- Inserisco nuovi valori campi estesi

-- veterinario direttore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'veterinario_direttore_sanitario'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- data_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'data_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'data_nascita');

-- nazione_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'nazione_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nazione_nascita');

-- comune_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'comune_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_nascita');

-- codice_fiscale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- indirizzo residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'indirizzo_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'indirizzo_res_medico');

-- comune residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'comune_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_res_medico');

-- provincia residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'provincia__res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'provincia__res_medico');

-- codice_iscrizione_elenco_regionale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'codice_iscrizione_elenco_regionale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_iscrizione_elenco_regionale');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and enabled and nome_campo = 'codice_stazione'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_stazione');

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA	

-- Verifico linee
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev <> 11;

-- Verifico anagrafiche
select r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale, r.partita_iva, r.n_reg, f.rev from ricerche_anagrafiche_old_materializzata r left join master_list_linea_attivita a on a.id = r.id_attivita left join master_list_flag_linee_attivita f on f.id_linea = a.id where a.codice_univoco = 'CG-NAZ-D-0126' order by f.rev;

-- Verifico campi estesi
select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 11)) and enabled order by id_linea asc, ordine asc;

-------------------------------------- Rev 8

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8))) and enabled;

-- Inserisco nuovi valori campi estesi

-- veterinario responsabile
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'veterinario_responsabile'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- data_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'data_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'data_nascita');

-- nazione_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'nazione_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nazione_nascita');

-- comune_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'comune_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_nascita');

-- codice_fiscale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- indirizzo residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'indirizzo_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'indirizzo_res_medico');

-- comune residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'comune_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_res_medico');

-- provincia residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'provincia_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'provincia_res_medico');

-- codice_iscrizione_elenco_regionale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'codice_iscrizione_elenco_regionale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_iscrizione_elenco_regionale');


-- gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'nome_gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'cognome_gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- codice_fiscale gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'codice_fiscale_gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- Titolo di studio
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
case when id_rel_stab_linea > 0 then id_rel_stab_linea else id_opu_rel_stab_linea end, case when id_opu_rel_stab_linea > 0 then id_opu_rel_stab_linea else id_rel_stab_linea end, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'titolo_studio_gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and enabled and nome_campo = 'codice_stazione'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_stazione');

-------------------------------------- Rev 10

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10))) and enabled;

-- Inserisco nuovi valori campi estesi

-- veterinario responsabile
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'veterinario_responsabile'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- data_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'data_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'data_nascita');

-- nazione_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'nazione_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nazione_nascita');

-- comune_nascita
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'comune_nascita'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_nascita');

-- codice_fiscale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- indirizzo residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'indirizzo_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'indirizzo_res_medico');

-- comune residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'comune_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'comune_res_medico');

-- provincia residenza
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'provincia_res_medico'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'provincia_res_medico');

-- codice_iscrizione_elenco_regionale
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'codice_iscrizione_elenco_regionale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_iscrizione_elenco_regionale');


-- gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'nome_gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'cognome_gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- codice_fiscale gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'codice_fiscale_gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- Titolo di studio
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'titolo_studio_gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and enabled and nome_campo = 'codice_stazione'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_stazione');

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->STAZIONE MONTA NATURALE EQUINA PUBBLICA	

-- Verifico linee
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev <> 11;

-- Verifico anagrafiche
select r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale, r.partita_iva, r.n_reg, f.rev from ricerche_anagrafiche_old_materializzata r left join master_list_linea_attivita a on a.id = r.id_attivita left join master_list_flag_linee_attivita f on f.id_linea = a.id where a.codice_univoco = 'CG-NAZ-V-0127' order by f.rev;

-- Verifico campi estesi
select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and enabled order by ordine asc;

select * from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 11)) and enabled order by id_linea asc, ordine asc;

-------------------------------------- Rev 8

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8))) and enabled;

-- Inserisco nuovi valori campi estesi

-- gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and enabled and nome_campo = 'gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- codice_fiscale gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- Titolo di studio
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and enabled and nome_campo = 'titolo_studio'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and enabled and nome_campo = 'codice_stazione'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 8)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_stazione');

-------------------------------------- Rev 10

-- Disabilito vecchi campi estesi

update linee_mobili_html_fields set enabled = false, notes_hd = concat_ws(';', notes_hd, 'Flusso 360 disabilitato per adeguamento vecchi campi estesi') where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and enabled;

-- Inserisco nuovi campi estesi

insert into linee_mobili_html_fields (id_linea, nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, notes_hd )
select (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10), nome_campo, tipo_campo, label_campo, tabella_lookup, javascript_function, javascript_function_evento, link_value, ordine_campo, maxlength, only_hd, label_link, multiple, obbligatorio, gestione_interna, ordine, enabled, readonly, dbi_generazione, regex_expr, messaggio_se_invalid, codice_raggruppamento, 'Flusso 360 inserito per adeguamento vecchi campi estesi' from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 11)) and enabled;

-- Disabilito vecchi valori campi estesi

update linee_mobili_fields_value set enabled = false, note_hd = 'Flusso 360 disabilitato per adeguamento vecchi campi estesi' where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10))) and enabled;

-- Inserisco nuovi valori campi estesi

-- gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and enabled and nome_campo = 'gestore'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- nome gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and enabled and nome_campo = 'nome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- cognome gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and enabled and nome_campo = 'cognome'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'cognome');

-- codice_fiscale gestore
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and enabled and nome_campo = 'codice_fiscale'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_fiscale');

-- Titolo di studio
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and enabled and nome_campo = 'titolo_studio'), '', 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'nome');

-- codice_stazione
insert into linee_mobili_fields_value (id_rel_stab_linea, id_opu_rel_stab_linea, id_linee_mobili_html_fields, valore_campo, indice, enabled, id_utente_inserimento, data_inserimento, note_hd, data_modifica, id_utente_modifica)
select 
id_rel_stab_linea, id_opu_rel_stab_linea, (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and enabled and nome_campo = 'codice_stazione'), valore_campo, 1, true, id_utente_inserimento, data_inserimento, 'Flusso 360 inserito per adeguamento vecchi campi estesi', data_modifica, id_utente_modifica
from linee_mobili_fields_value where id_linee_mobili_html_fields in (select id from linee_mobili_html_fields where id_linea in ((select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 10)) and notes_hd ilike '%Flusso 360 disabilitato%' and nome_campo = 'codice_stazione');

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->PERSONALE LAICO CHE EFFETTUA LA FECONDAZIONE ARTIFICIALE SOLO NEL PROPRIO ALLEVAMENTO	

select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev <> 11;

-- NON FACCIO NULLA - I CAMPI SONO GIA' CORRETTI

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->MEDICO VETERINARIO CHE EFFETTUA FECONDAZIONE ARTIFICIALE ED IMPIANTI EMBRIONALI	

select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev <> 11;

-- NON FACCIO NULLA - I CAMPI SONO GIA' CORRETTI