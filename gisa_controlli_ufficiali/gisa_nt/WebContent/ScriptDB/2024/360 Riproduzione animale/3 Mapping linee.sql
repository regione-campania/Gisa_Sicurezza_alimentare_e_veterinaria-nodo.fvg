--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->RECAPITI

-- Verifico linee rev not 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev <> 11;

-- verifico linea rev 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 11;

-- Verifico istanze con linee rev not 11
select * from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev <> 11);

-- Verifico campi estesi su istanze linee rev not 11
select * from linee_mobili_fields_value where (id_opu_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev <> 11)) or id_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev <> 11))) and enabled;

-- Aggiorno campi estesi
select 'update linee_mobili_fields_value set id_linee_mobili_html_fields = '|| f_new.id || ', note_hd = concat_ws('';'', note_hd, ''Flusso 360 campo mappato. Valore di id_linee_mobili_html_fields precedente: '||f_old.id||''') where id_linee_mobili_html_fields = '||f_old.id||';',
* from linee_mobili_html_fields f_old
left join linee_mobili_html_fields f_new on f_old.codice_raggruppamento = f_new.codice_raggruppamento
where f_old.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev <> 11) and f_old.enabled and f_new.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 11) and f_new.enabled;

-- Aggiorno linee
update opu_relazione_stabilimento_linee_produttive set id_linea_produttiva = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev = 11), note_hd = concat_ws(';', note_hd, 'Flusso 360 linea mappata a rev 11. Valore precedente: '||id_linea_produttiva) where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-007' and rev <> 11);


-----------------------------------------------------------------------------------

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->CENTRO PRODUZIONE MATERIALE SEMINALE

-- Verifico linee rev not 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev <> 11;

-- verifico linea rev 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 11;

-- Verifico istanze con linee rev not 11
select * from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev <> 11);

-- Verifico campi estesi su istanze linee rev not 11
select * from linee_mobili_fields_value where (id_opu_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev <> 11)) or id_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev <> 11))) and enabled;

-- Aggiorno campi estesi
select 'update linee_mobili_fields_value set id_linee_mobili_html_fields = '|| f_new.id || ', note_hd = concat_ws('';'', note_hd, ''Flusso 360 campo mappato. Valore di id_linee_mobili_html_fields precedente: '||f_old.id||''') where id_linee_mobili_html_fields = '||f_old.id||';',
* from linee_mobili_html_fields f_old
left join linee_mobili_html_fields f_new on f_old.codice_raggruppamento = f_new.codice_raggruppamento
where f_old.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev <> 11) and f_old.enabled and f_new.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 11) and f_new.enabled;

-- Aggiorno linee
update opu_relazione_stabilimento_linee_produttive set id_linea_produttiva = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev = 11), note_hd = concat_ws(';', note_hd, 'Flusso 360 linea mappata a rev 11. Valore precedente: '||id_linea_produttiva) where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-R-003' and rev <> 11);

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->CENTRO DI PRODUZIONE EMBRIONI	

-- Verifico linee rev not 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev <> 11;

-- verifico linea rev 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 11;

-- Verifico istanze con linee rev not 11
select * from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev <> 11);

-- Verifico campi estesi su istanze linee rev not 11
select * from linee_mobili_fields_value where (id_opu_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev <> 11)) or id_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev <> 11))) and enabled;

-- Aggiorno campi estesi
select 'update linee_mobili_fields_value set id_linee_mobili_html_fields = '|| f_new.id || ', note_hd = concat_ws('';'', note_hd, ''Flusso 360 campo mappato. Valore di id_linee_mobili_html_fields precedente: '||f_old.id||''') where id_linee_mobili_html_fields = '||f_old.id||';',
* from linee_mobili_html_fields f_old
left join linee_mobili_html_fields f_new on f_old.codice_raggruppamento = f_new.codice_raggruppamento
where f_old.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev <> 11) and f_old.enabled and f_new.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 11) and f_new.enabled;

-- Aggiorno linee
update opu_relazione_stabilimento_linee_produttive set id_linea_produttiva = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev = 11), note_hd = concat_ws(';', note_hd, 'Flusso 360 linea mappata a rev 11. Valore precedente: '||id_linea_produttiva) where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-B' and rev <> 11);

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->STAZIONE INSEMINAZIONE ARTIFICIALE EQUINA	

-- Verifico linee rev not 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev <> 11;

-- verifico linea rev 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 11;

-- Verifico istanze con linee rev not 11
select * from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev <> 11);

-- Verifico campi estesi su istanze linee rev not 11
select * from linee_mobili_fields_value where (id_opu_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev <> 11)) or id_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev <> 11))) and enabled;

-- Aggiorno campi estesi
select 'update linee_mobili_fields_value set id_linee_mobili_html_fields = '|| f_new.id || ', note_hd = concat_ws('';'', note_hd, ''Flusso 360 campo mappato. Valore di id_linee_mobili_html_fields precedente: '||f_old.id||''') where id_linee_mobili_html_fields = '||f_old.id||';',
* from linee_mobili_html_fields f_old
left join linee_mobili_html_fields f_new on f_old.codice_raggruppamento = f_new.codice_raggruppamento
where f_old.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev <> 11) and f_old.enabled and f_new.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 11) and f_new.enabled;

-- Aggiorno linee
update opu_relazione_stabilimento_linee_produttive set id_linea_produttiva = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev = 11), note_hd = concat_ws(';', note_hd, 'Flusso 360 linea mappata a rev 11. Valore precedente: '||id_linea_produttiva) where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-D-0126' and rev <> 11);

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->STAZIONE MONTA NATURALE EQUINA PUBBLICA	

-- Verifico linee rev not 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev <> 11;

-- verifico linea rev 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 11;

-- Verifico istanze con linee rev not 11
select * from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev <> 11);

-- Verifico campi estesi su istanze linee rev not 11
select * from linee_mobili_fields_value where (id_opu_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev <> 11)) or id_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev <> 11))) and enabled;

-- Aggiorno campi estesi
select 'update linee_mobili_fields_value set id_linee_mobili_html_fields = '|| f_new.id || ', note_hd = concat_ws('';'', note_hd, ''Flusso 360 campo mappato. Valore di id_linee_mobili_html_fields precedente: '||f_old.id||''') where id_linee_mobili_html_fields = '||f_old.id||';',
* from linee_mobili_html_fields f_old
left join linee_mobili_html_fields f_new on f_old.codice_raggruppamento = f_new.codice_raggruppamento
where f_old.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev <> 11) and f_old.enabled and f_new.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 11) and f_new.enabled;

-- Aggiorno linee
update opu_relazione_stabilimento_linee_produttive set id_linea_produttiva = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 11), note_hd = concat_ws(';', note_hd, 'Flusso 360 linea mappata a rev 11. Valore precedente: '||id_linea_produttiva) where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev <> 11);

--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->PERSONALE LAICO CHE EFFETTUA LA FECONDAZIONE ARTIFICIALE SOLO NEL PROPRIO ALLEVAMENTO	

-- Verifico linee rev not 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev <> 11;

-- verifico linea rev 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 11;

-- Verifico istanze con linee rev not 11
select * from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev <> 11);

-- Verifico campi estesi su istanze linee rev not 11
select * from linee_mobili_fields_value where (id_opu_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev <> 11)) or id_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev <> 11))) and enabled;

-- Aggiorno campi estesi
select 'update linee_mobili_fields_value set id_linee_mobili_html_fields = '|| f_new.id || ', note_hd = concat_ws('';'', note_hd, ''Flusso 360 campo mappato. Valore di id_linee_mobili_html_fields precedente: '||f_old.id||''') where id_linee_mobili_html_fields = '||f_old.id||';',
* from linee_mobili_html_fields f_old
left join linee_mobili_html_fields f_new on f_old.codice_raggruppamento = f_new.codice_raggruppamento
where f_old.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev <> 11) and f_old.enabled and f_new.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 11) and f_new.enabled;

-- Aggiorno linee
update opu_relazione_stabilimento_linee_produttive set id_linea_produttiva = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev = 11), note_hd = concat_ws(';', note_hd, 'Flusso 360 linea mappata a rev 11. Valore precedente: '||id_linea_produttiva) where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-006' and rev <> 11);


--RIPRODUZIONE ANIMALE->STABILIMENTI IN MATERIA DI RIPRODUZIONE ANIMALE CON COMMERCIALIZZAZIONE IN AMBITO NAZIONALE->MEDICO VETERINARIO CHE EFFETTUA FECONDAZIONE ARTIFICIALE ED IMPIANTI EMBRIONALI	

-- Verifico linee rev not 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev <> 11;

-- verifico linea rev 11
select id_nuova_linea_attivita, path_descrizione, rev, codice from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 11;

-- Verifico istanze con linee rev not 11
select * from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev <> 11);

-- Verifico campi estesi su istanze linee rev not 11
select * from linee_mobili_fields_value where (id_opu_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev <> 11)) or id_rel_stab_linea in (select id from opu_relazione_stabilimento_linee_produttive where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev <> 11))) and enabled;

-- Aggiorno campi estesi
select 'update linee_mobili_fields_value set id_linee_mobili_html_fields = '|| f_new.id || ', note_hd = concat_ws('';'', note_hd, ''Flusso 360 campo mappato. Valore di id_linee_mobili_html_fields precedente: '||f_old.id||''') where id_linee_mobili_html_fields = '||f_old.id||';',
* from linee_mobili_html_fields f_old
left join linee_mobili_html_fields f_new on f_old.codice_raggruppamento = f_new.codice_raggruppamento
where f_old.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev <> 11) and f_old.enabled and f_new.id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 11) and f_new.enabled;

-- Aggiorno linee
update opu_relazione_stabilimento_linee_produttive set id_linea_produttiva = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev = 11), note_hd = concat_ws(';', note_hd, 'Flusso 360 linea mappata a rev 11. Valore precedente: '||id_linea_produttiva) where id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-E-005' and rev <> 11);

-- REFRESH GLOBALE

delete from ricerche_anagrafiche_old_materializzata;
insert into ricerche_anagrafiche_old_materializzata select * from ricerca_anagrafiche;