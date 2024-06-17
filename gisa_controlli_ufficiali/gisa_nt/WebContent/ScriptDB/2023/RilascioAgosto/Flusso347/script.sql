-- aggiornamento linee flusso 347 rev.8
-- id linea 40267 "TRASPORTO CONTO TERZI ->TRASPORTO MATERIE PRIME,MANGIMI, PREMISCELE E ADDITIVI DESTINATI ALL'ALIMENTAZIONE ANIMALE- TRASPORTO CONTO TERZI  ART. 5, COMMA 2->TRASPORTO MATERIE PRIME,MANGIMI, PREMISCELE E ADDITIVI DESTINATI ALL'ALIMENTAZIONE ANIMALE"
select * from ml8_linee_attivita_nuove_materializzata where rev=8 and codice='MS.090-TCT-T'
-- id linea 46053 "MANGIMISTICA IN GENERE (stabilimenti registrati)->DITTE REGISTRABILI AI SENSI DEL REG. CE 183/2005 ART. 5, COMMA 2->TRASPORTO CONTO TERZI MANGIMI (MATERIE PRIME, MANGIMI COMPOSTI, ADDITIVI, PREMISCELE)"
select * from ml8_linee_attivita_nuove_materializzata where rev=11 and codice='MG-DG-M16'

-- verifica stabilimenti che hanno la linea 
select 'update opu_relazione_stabilimento_linee_produttive set 
id_linea_produttiva_old = id_linea_produttiva,
codice_univoco_ml = ''MG-DG-M16'',
id_linea_produttiva = (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where rev=11 and codice=''MG-DG-M16''),
note_internal_use_hd_only =concat_ws('''||current_timestamp||''',note_internal_use_hd_only,''Flusso 347 ORSA: Aggiornamento id linea attivita (ex MS.090-TCT-T rev.8)'')
where id_stabilimento='||riferimento_id||' and 
id_linea_produttiva in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where rev=8 and codice=''MS.090-TCT-T'') ;'
from ricerche_anagrafiche_old_materializzata 
where id_attivita in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where rev=8 and codice='MS.090-TCT-T');

-- aggiornamento linee flusso 347 rev.10
-- nessun riferimento a ml10?

-- aggiornamento massivo di ricerca anagrafiche
delete from ricerche_anagrafiche_old_materializzata;
insert into ricerche_anagrafiche_old_materializzata (select * from ricerca_anagrafiche);



