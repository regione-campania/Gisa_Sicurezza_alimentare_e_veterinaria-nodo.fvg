update dpat_indicatore_new set codice_interno_attivita_gestione_cu = '7a', codice_interno_univoco_tipo_attivita_gestione_cu = null where alias_indicatore = 'ATT B55_F' and anno = 2024 and data_scadenza is null;

SELECT * FROM refresh_motivi_cu(2024, true)