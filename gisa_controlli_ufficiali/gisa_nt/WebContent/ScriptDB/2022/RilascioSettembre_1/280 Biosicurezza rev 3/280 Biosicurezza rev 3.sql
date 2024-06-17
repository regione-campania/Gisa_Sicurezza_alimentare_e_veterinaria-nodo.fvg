insert into rel_motivi_eventi_cu (id_evento_cu, enteredby, note_hd, cod_raggrup_ind)

select 
(select code from lookup_eventi_motivi_cu where codice_evento = 'isFarmacosorveglianza'), 5885, 'Aggiunto a seguito di Flusso 280 rev 3', cod_raggruppamento

from dpat_indicatore_new 
where alias_indicatore ilike 'A14_%' 
and anno = 2022 and data_scadenza is null
and alias_indicatore not in (
select 
d.alias_indicatore
from dpat_indicatore_new d
join rel_motivi_eventi_cu r on r.cod_raggrup_ind = d.cod_raggruppamento
join lookup_eventi_motivi_cu l on l.code = r.id_evento_cu
where l.codice_evento = 'isFarmacosorveglianza' and d.anno = 2022 and d.data_scadenza is null
)
and UPPER(alias_indicatore) not in ('A14_AV', 'A14_BA', 'A14_BB', 'A14_AW', 'A14_AX', 'A14_AY', 'A14_AZ', 'A14_AAA', 'A14_AAB', 'A14_AAC', 'A14_AAD')

order by alias_indicatore asc;