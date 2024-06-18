update animale set data_modifica = data_inserimento,note_internal_use_only = concat(note_internal_use_only,' -24/05/2023 Bonifica dati DATA MODIFICA --> E'' stato settato il campo DATA MODIFICA uguale al campo DATA INSERIMENTO in quanto DATA MODIFICA non era valorizzato') where data_modifica is null;

update animale set utente_modifica = utente_inserimento,note_internal_use_only = concat(note_internal_use_only,' - 24/05/2023 Bonifica dati UTENTE MODIFICA --> E'' stato settato il campo UTENTE MODIFICA uguale al campo UTENTE INSERIMENTO in quanto UTENTE MODIFICA non era valorizzato') where utente_modifica is null or utente_modifica <=0;


update evento set id_utente_modifica = id_utente_inserimento,note_internal_use_only = concat(note_internal_use_only,' 24/05/2023 Bonifica dati UTENTE MODIFICA --> E'' stato settato il campo UTENTE MODIFICA uguale al campo UTENTE INSERIMENTO in quanto UTENTE MODIFICA non era valorizzato') where id_utente_modifica is null or id_utente_modifica  <= 0;

update evento set modified = entered, note_internal_use_only = concat(note_internal_use_only,' - -24/05/2023 Bonifica dati DATA MODIFICA --> E'' stato settato il campo DATA MODIFICA uguale al campo DATA INSERIMENTO in quanto DATA MODIFICA non era valorizzato ') where modified is null;