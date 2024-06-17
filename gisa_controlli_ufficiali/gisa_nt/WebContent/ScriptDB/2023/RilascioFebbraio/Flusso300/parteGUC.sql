-- db gisa
-- DROP FUNCTION public.check_vincoli_utente_vet_resp_centri_e_recapiti(text, text);

CREATE OR REPLACE FUNCTION public.check_vincoli_utente_vet_resp_centri_e_recapiti(
    _num_registrazione text)
  RETURNS text AS
$BODY$
declare
 _msg text;
 _id_stabilimento integer;
BEGIN

_msg := '';
_id_stabilimento := -1;

RAISE INFO '[CHECK VINCOLI UTENTE [VETERINARIO RESPONSABILE CENTRI E RECAPITI] ] _num_registrazione: %', _num_registrazione;

-- Controlla se esiste il numero registrazione
SELECT id_stabilimento into _id_stabilimento from opu_operatori_denormalizzati_view where numero_registrazione = _num_registrazione;
RAISE INFO '[CHECK VINCOLI UTENTE [VETERINARIO RESPONSABILE CENTRI E RECAPITI] ] Check esistenza numreg _id_stabilimento: %', _id_stabilimento;
IF _id_stabilimento is null THEN
_msg := 'NUMERO REGISTRAZIONE non esistente nel sistema.';
END IF;

IF _id_stabilimento > 0 THEN
-- Controlla se il numero registrazione corrisponde a un'anagrafica di tipo produzione seme o recapiti (controllo su codice linea) = a quella della richiesta
SELECT id_stabilimento into _id_stabilimento from opu_operatori_denormalizzati_view where 
concat('', codice_macroarea,'-', codice_aggregazione,'-', codice_attivita_only) in 
('CG-NAZ-R-007', -- recapiti
'CG-NAZ-B', -- centro di produzione embrioni
'CG-NAZ-R-003' -- centro produzione materiale seminale
) -- recapiti
and numero_registrazione = _num_registrazione;

RAISE INFO '[CHECK VINCOLI UTENTE [VETERINARIO RESPONSABILE CENTRI E RECAPITI] ] Check esistenza numreg + tipo produzione seme o recapiti: %', _id_stabilimento;
IF _id_stabilimento is null THEN
_msg := 'NUMERO REGISTRAZIONE esistente nel sistema ma non associato ad anagrafica con TIPOLOGIA VETERINARIO RESPONSABILE CENTRI DI PRODUZIONE SEME O RECAPITI della richiesta.';
END IF;
END IF;

IF _id_stabilimento > 0 THEN
-- Controlla se esiste il numero registrazione su stabilimento attivo
SELECT id_stabilimento into _id_stabilimento from opu_operatori_denormalizzati_view where 
concat('', codice_macroarea,'-', codice_aggregazione,'-', codice_attivita_only) in 
('CG-NAZ-R-007', -- recapiti
'CG-NAZ-B', -- centro di produzione embrioni
'CG-NAZ-R-003' -- centro produzione materiale seminale
) -- recapiti
and numero_registrazione = _num_registrazione
and id_stato = 0;

RAISE INFO '[CHECK VINCOLI UTENTE [VETERINARIO RESPONSABILE CENTRI E RECAPITI] ] Check esistenza numreg + tipo produzione seme o recapiti attivo _id_stabilimento: %', _id_stabilimento;
IF _id_stabilimento is null THEN
_msg := 'NUMERO REGISTRAZIONE esistente nel sistema ma non associato ad anagrafica ATTIVA.';
END IF;
END IF;

RAISE INFO '[CHECK VINCOLI UTENTE [VETERINARIO RESPONSABILE CENTRI E RECAPITI] ] Esito finale (Vuoto=OK): %', _msg;

return _msg;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

--select * from check_vincoli_utente_vet_resp_centri_e_recapiti('U150027CE000976','061027') -- test ok
--select * from check_vincoli_utente_vet_resp_centri_e_recapiti('U150027CE000976','051588') -- test ko

-- guc (preparata ma non lanciata)
 
CREATE OR REPLACE FUNCTION spid.check_vincoli_ruoli_by_endpoint(
    _numero_richiesta text,
    _id_ruolo integer,
    _endpoint text)
  RETURNS text AS
$BODY$
declare
 _query text;
 _msg text;
 conta_guc integer;
 _id_tipologia_utente integer;
BEGIN

_query := '';
_msg := '';
conta_guc = 0;

RAISE INFO '[CHECK RUOLI BY ENDPOINT] _numero_richiesta: %', _numero_richiesta;
RAISE INFO '[CHECK RUOLI BY ENDPOINT] _id_ruolo: %', _id_ruolo;
RAISE INFO '[CHECK RUOLI BY ENDPOINT] _endpoint: %', _endpoint;

-- CHECK SU GUC PRELIMINARE
conta_guc := (select count(*) from spid.get_lista_ruoli_utente_guc((select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta), _endpoint, (select codice_gisa from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)) 
where id_ruolo = _id_ruolo);
    
if conta_guc > 0 then 
	_msg := 'Per il codice fiscale selezionato, esiste gia'' un account con questo ruolo.';
end if;

_id_tipologia_utente = (select id_tipologia_utente from spid.spid_registrazioni where numero_richiesta = _numero_richiesta);
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Id tipologia utente recuperato da richiesta: %', _id_tipologia_utente;

-- gestore acque
IF _id_ruolo = 10000006 and _endpoint ilike 'GISA_EXT' THEN 
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Avvio check per il ruolo GESTORE ACQUE';
-- Controlla se non c'� un'altra richiesta con lo stesso gestore e lo stesso comune

SELECT 'SELECT * from check_vincoli_richieste(''''::text,'''||('ACQUE')||'''::text, '||(select id_gestore_acque from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'::integer, 
''' || (select comune from spid.spid_registrazioni where numero_richiesta = _numero_richiesta) || '''::text, ''''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,'host=dbGISAL dbname=gisa'));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check esistenza RICHIESTE: %', _msg;

-- Controlla se il comune esiste in banca dati
-- Non faccio nulla. Il comune � gi� mappato come istat.

END IF;

--apicoltore
IF _id_ruolo = 10000002 and _endpoint ilike 'GISA_EXT' THEN
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Avvio check per il ruolo API';
-- Controlla se non c'� un'altra richiesta con lo stesso codice fiscale

SELECT 'SELECT * from check_vincoli_richieste('''||(select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text,'''||('API')||'''::text, -1, ''''::text,
'''||(select piva_numregistrazione from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,'host=dbGISAL dbname=gisa'));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check esistenza RICHIESTE: %', _msg;

IF (_msg = '' and _id_tipologia_utente = 5) THEN 
SELECT 'SELECT * from check_vincoli_utente_api('''||(select piva_numregistrazione from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,'host=dbGISAL dbname=gisa'));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check per APICOLTORE COMMERCIALE: %', _msg;


END IF;
-- Controlla se il comune esiste in banca dati
-- Non faccio nulla. Il comune � gi� mappato come istat.

END IF;

--trasportatore/distributore
IF _id_ruolo = 10000004 and _endpoint ilike 'GISA_EXT' THEN
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Avvio check per il ruolo TRASPORTATORE/DISTRIBUTORE';
-- Controlla se il CF � valido
-- Non faccio nulla. Lo fa gi� il modulo e se non lo fa lo deve fare lui e non una dbi

-- Controlla se il comune esiste in banca dati
-- Non faccio nulla. Il comune � gi� mappato come istat.

-- Controlla se esiste una richiesta con lo stesso codice fiscale e tipologia (trasporto/distr)
SELECT 'SELECT * from check_vincoli_richieste('''||(select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text,
'''||(select CASE WHEN id_tipologia_trasp_dist = 1 then 'TRASPORTATORE' WHEN id_tipologia_trasp_dist = 2 then 'DISTRIBUTORE' end from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text, -1, 
''''::text, '''||(select codice_gisa from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;
_msg := (select * from spid.esegui_query(_query, 'gisa', -1,'host=dbGISAL dbname=gisa'));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check esistenza RICHIESTE: %', _msg;

IF (_msg = '') THEN 

SELECT 'SELECT * from check_vincoli_utente_trasp_dist('''||(select codice_gisa from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text,
'''||(select id_tipologia_trasp_dist from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::integer,
'''||(select comune from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,'host=dbGISAL dbname=gisa'));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check VINCOLI: %', _msg;

END IF;

END IF;


--veterinario respnsabile centro seme o recapito 10000010
IF (_id_ruolo = 10000010 or _id_ruolo = 10000011) and _endpoint ilike 'GISA_EXT' THEN
RAISE INFO '[CHECK RUOLI BY ENDPOINT] Avvio check per il ruolo VETERINARIO RESPONSABILE CENTRO RIPRODUZIONE O RECAPITI';
-- Controlla se il CF � valido
-- Non faccio nulla. Lo fa gi� il modulo e se non lo fa lo deve fare lui e non una dbi

-- Controlla se il comune esiste in banca dati
-- Non faccio nulla. Il comune � gi� mappato come istat.

-- Controlla se esiste una richiesta con lo stesso codice fiscale?? 
SELECT 'SELECT * from check_vincoli_richieste('''||(select codice_fiscale from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text,'''||('VET_RESP_SEME_RECAPITO')||'''::text, -1, ''''::text,
'''||(select piva_numregistrazione from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,'host=dbGISAL dbname=gisa'));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check esistenza RICHIESTE: %', _msg;

IF (_msg = '') THEN 

SELECT 'SELECT * from check_vincoli_utente_vet_resp_centri_e_recapiti('''||(select codice_gisa from spid.spid_registrazioni where numero_richiesta = _numero_richiesta)||'''::text);' into _query;

_msg := (select * from spid.esegui_query(_query, 'gisa', -1,'host=dbGISAL dbname=gisa'));

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito del check VINCOLI: %', _msg;

END IF;

END IF;

RAISE INFO '[CHECK RUOLI BY ENDPOINT] Esito finale (Vuoto=OK): %', _msg;

return _msg;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION spid.check_vincoli_ruoli_by_endpoint(text, integer, text)
  OWNER TO postgres;

  -- NON MI TROVO CON QUESTA COSA
  -- QUI STAI INSERENDO GLI ID CON IL MAX+1 MA NELLE DBI DI GUC HAI USATO I VALORI 10000010 E 10000011
  -- SE IL MAX E' DISALLINEATO TRA GLI AMBIENTI NON MATCHERANNO
  -- FORSE MEGLIO DICHIARARE ESPLICITAMENTE ROLE_ID ANCHE IN QUESTI SCRIPT
  
