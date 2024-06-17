select chk.description, string_agg(UPPER(ind.alias_indicatore), ', ')
from rel_indicatore_chk_bns rel
join dpat_indicatore_new ind on ind.cod_raggruppamento = rel.codice_raggruppamento
join lookup_chk_bns_mod chk on chk.code = rel.id_lookup_chk_bns
where ind.anno = 2023 and chk.enabled and chk.end_date > '2999-01-01' and ind.data_scadenza is null
group by chk.description


