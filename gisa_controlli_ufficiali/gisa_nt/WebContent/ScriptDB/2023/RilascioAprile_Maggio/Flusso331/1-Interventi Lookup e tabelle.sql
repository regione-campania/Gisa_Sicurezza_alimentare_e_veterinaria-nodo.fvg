insert into lookup_chk_bns_mod (code, description, codice_specie, nuova_gestione, tipo_allegato_bdn, versione, start_date, end_date, num_allegato, codice_checklist) values (39, 'ALLEGATO BROILER 2023', 1461, true, 50, 6, '2023-01-01', '3000-12-31', 50, 'isBroiler');

insert into lookup_chk_bns_mod (code, description, codice_specie, nuova_gestione, tipo_allegato_bdn, versione, start_date, end_date, num_allegato, codice_checklist) values (40, 'ALLEGATO CONIGLI', 128, true, 8, 6, '2023-01-01', '3000-12-31', 8, 'isConigli');

update lookup_chk_bns_mod set end_date = '2022-12-31' where codice_checklist = 'isBroiler' and versione = 3;

CREATE TABLE public.chk_bns_mod_ist_v6_broiler
(
    id SERIAL PRIMARY KEY,
    id_chk_bns_mod_ist integer,
    trashed_date timestamp without time zone,
    entered_by integer,
    entered timestamp without time zone DEFAULT 'now()',
    num_checklist text,
    veterinario_ispettore text,
    presenza_manuale text,
    veterinario_aziendale text,
	num_totale_capannoni text,
	num_totale_capannoni_attivi text,
	capannone_1_num text,
	capannone_1_capacita text,
	capannone_1_data text,
	capannone_1_accasati text,
	capannone_1_presenti text,
	capannone_1_ispezionato text,
	capannone_2_num text,
	capannone_2_capacita text,
	capannone_2_data text,
	capannone_2_accasati text,
	capannone_2_presenti text,
	capannone_2_ispezionato text,
	capannone_3_num text,
	capannone_3_capacita text,
	capannone_3_data text,
	capannone_3_accasati text,
	capannone_3_presenti text,
	capannone_3_ispezionato text,	
	capannone_4_num text,
	capannone_4_ispezionato text,	
	capannone_5_num text,
	capannone_5_ispezionato text,
    appartenente_condizionalita text,
	criteri_utilizzati text,
    criteri_utilizzati_altro_descrizione text,
    esito_controllo text,
    intenzionalita text,
    evidenze text,
    evidenze_tse text,
	evidenze_ir text,
    evidenze_sv text,
    prescrizioni_descrizione text,
	assegnate_prescrizioni text,
    data_prescrizioni text,
    sanz_blocco text,
    sanz_amministrativa text,
    sanz_abbattimento text,
    sanz_sequestro text,
	sanz_informativa text,
    sanz_altro text,
    sanz_altro_desc text,
    note_controllore text,
    note_proprietario text,
    nome_proprietario text,
    nome_controllore text,
	eseguite_prescrizioni text,
    prescrizioni_eseguite_descrizione text,
    nome_proprietario_prescrizioni_eseguite text,
    data_verifica text,
    nome_controllore_prescrizioni_eseguite text,
    data_chiusura_relazione text,
	ibrido_razza_allevata text,
	stima_capannone_1_num text,
	stima_capannone_1_num_capi text,
	stima_capannone_2_num text,
	stima_capannone_2_num_capi text,
	stima_capannone_3_num text,
	stima_capannone_3_num_capi text
);

ALTER TABLE chk_bns_mod_ist_v6_broiler add column data_primo_controllo text;

CREATE TABLE public.chk_bns_mod_ist_v6_conigli
(
    id SERIAL PRIMARY KEY,
    id_chk_bns_mod_ist integer,
    trashed_date timestamp without time zone,
    entered_by integer,
    entered timestamp without time zone DEFAULT 'now()',
    num_checklist text,
    veterinario_ispettore text,
	presenza_quarantena text,
	vuoto_sanitario text,
    presenza_manuale text,
    veterinario_aziendale text,
	num_animali_allevati text,
	num_fattrici_morte text,
	num_rimonte_morte text,
	num_ingrasso_morti text,
	num_fori_nido text,
	num_fori_maschio text,
	num_totale_capannoni text,
	num_totale_capannoni_attivi text,	
    appartenente_condizionalita text,
	criteri_utilizzati text,
    criteri_utilizzati_altro_descrizione text,
    esito_controllo text,
    intenzionalita text,
    evidenze text,
    evidenze_tse text,
	evidenze_ir text,
    evidenze_sv text,
    prescrizioni_descrizione text,
	assegnate_prescrizioni text,
    data_prescrizioni text,
    sanz_blocco text,
    sanz_amministrativa text,
    sanz_abbattimento text,
    sanz_sequestro text,
	sanz_informativa text,
    sanz_altro text,
    sanz_altro_desc text,
    note_controllore text,
    note_proprietario text,
    nome_proprietario text,
    nome_controllore text,
	eseguite_prescrizioni text,
    prescrizioni_eseguite_descrizione text,
    nome_proprietario_prescrizioni_eseguite text,
    data_verifica text,
    nome_controllore_prescrizioni_eseguite text,
    data_chiusura_relazione text,
	data_primo_controllo text
);

CREATE TABLE public.chk_bns_capannoni_v6
(
    id SERIAL PRIMARY KEY,
    id_chk_bns_mod_ist integer,
    trashed_date timestamp without time zone,
    entered_by integer,
    entered timestamp without time zone DEFAULT 'now()',
    indice integer,
    numero text,
    num_animali text,
    num_fori text,
    tipo_struttura text,
    tipo_gabbia text,
    tipo_gabbia_desc text,
    ventilazione text
);

update rel_indicatore_chk_bns set data_fine_relazione = '2022-12-31' where codice_raggruppamento in (select cod_raggruppamento from dpat_indicatore_new where UPPER(alias_indicatore) in ('A13_U','A13_V', 'A13_BI','A13_W' ) and anno = 2023 and data_scadenza is null) and data_fine_relazione = '2021-12-31 00:00:00';

insert into rel_indicatore_chk_bns (id_indicatore, id_lookup_chk_bns, codice_raggruppamento, enabled, data_inizio_relazione, data_fine_relazione)
select id, 40, cod_raggruppamento, true, '2023-01-01', '3000-12-31' from dpat_indicatore_new where UPPER(alias_indicatore) in ('A13_U','A13_V', 'A13_BI','A13_W' ) and anno = 2023 and data_scadenza is null;

-- RELAZIONE MOTIVO Checklist Conigli

update rel_indicatore_chk_bns set data_fine_relazione = '2022-12-31' where codice_raggruppamento in (select cod_raggruppamento from dpat_indicatore_new where UPPER(alias_indicatore) in ('A13_U','A13_V', 'A13_BI','A13_W' ) and anno = 2023 and data_scadenza is null) and data_fine_relazione = '3000-12-31 00:00:00';

insert into rel_indicatore_chk_bns (id_indicatore, id_lookup_chk_bns, codice_raggruppamento, enabled, data_inizio_relazione, data_fine_relazione)
select id, 40, cod_raggruppamento, true, '2023-01-01', '3000-12-31' from dpat_indicatore_new where UPPER(alias_indicatore) in ('A13_U','A13_V', 'A13_BI','A13_W' ) and anno = 2023 and data_scadenza is null;

-- RELAZIONE MOTIVO Checklist Broiler

update rel_indicatore_chk_bns set data_fine_relazione = '2022-12-31' where codice_raggruppamento in (select cod_raggruppamento from dpat_indicatore_new where UPPER(alias_indicatore) in ('A13_AE','A13_AF', 'A13_BK') and anno = 2023 and data_scadenza is null) and data_fine_relazione = '3000-12-31 00:00:00';

insert into rel_indicatore_chk_bns (id_indicatore, id_lookup_chk_bns, codice_raggruppamento, enabled, data_inizio_relazione, data_fine_relazione)
select id, 39, cod_raggruppamento, true, '2023-01-01', '3000-12-31' from dpat_indicatore_new where UPPER(alias_indicatore) in ('A13_AE','A13_AF', 'A13_BK') and anno = 2023 and data_scadenza is null;

update chk_bns_domande_v6 set quesito = replace(quesito, '�', 'E''');
update chk_bns_domande_v6 set quesito = replace(quesito, '�', 'a''');
update chk_bns_domande_v6 set quesito = replace(quesito, '�', 'e''');
update chk_bns_domande_v6 set quesito = replace(quesito, '�', 'i''');
update chk_bns_domande_v6 set quesito = replace(quesito, '�', 'u''');
update chk_bns_domande_v6 set quesito = replace(quesito, '�', 'u''');
update chk_bns_domande_v6 set quesito = replace(sottotitolo, '�', '-');
update chk_bns_domande_v6 set sottotitolo = replace(sottotitolo, '�', '-');
