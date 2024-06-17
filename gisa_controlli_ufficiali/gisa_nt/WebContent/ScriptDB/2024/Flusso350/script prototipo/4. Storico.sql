--Controllare le funzioni e le viste se sono allineate con ufficiale
--db storico
alter table gisa_ws_storico_chiamate add column tabella text;
alter table gisa_ws_storico_chiamate add column esito text;
alter table gisa_ws_storico_chiamate add column id_tabella text;
alter table gisa_ws_storico_chiamate add column metodo text;


--db gisa
CREATE OR REPLACE FUNCTION public.ws_salva_storico_chiamate(
    _url text,
    _request text,
    _response text,
    _idutente integer,
    id_tabella_input text default null,
    tabella_input text default null,
    esito_input text default null,
    metodo_input text default null
    )
  RETURNS json AS
$BODY$
   DECLARE
   	conf_dblink text;
   	query_upd text;
_id integer;
_output json;
BEGIN

	select * from conf.get_pg_conf('STORICO') into conf_dblink;


SELECT COALESCE(_url, '') into _url;
SELECT COALESCE(_request, '') into _request;
SELECT COALESCE(_response, '') into _response;
SELECT COALESCE(_idutente, -1) into _idutente;

SELECT replace(_request, '''', '''''') into _request;
SELECT replace(_response, '''', '''''') into _response;

_id := (select * FROM dblink(conf_dblink::text, 
'insert into gisa_ws_storico_chiamate(url, request, response, id_utente, data, id_tabella, tabella, esito,metodo) values (''' ||_url||''', '''||_request||''','''||_response||''', '||_idutente ||', now(),' || 
case when id_tabella_input is null then 'null' else '''' || id_tabella_input || '''' end  || ', ' || case when tabella_input is null then 'null' else '''' || tabella_input || '''' end || ',' || case when esito_input is null then 'null' else '''' || esito_input || '''' end || ', ' || 
case when metodo_input is null then 'null' else '''' || metodo_input || '''' end || ') returning id;')  as t1(output integer));

query_upd := concat ('update ',tabella_input,' set sinaaf_invio_ws_ok = now() where id = ' , id_tabella_input);

raise info 'query_upd: %' , query_upd;

execute query_upd;


_output:= (select * FROM dblink(conf_dblink::text, 
'SELECT row_to_json (gisa_ws_storico_chiamate) from gisa_ws_storico_chiamate where id = '||_id||';') as t1(output json));

return _output;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.ws_salva_storico_chiamate(text, text, text, integer)
  OWNER TO postgres;


--db storico
CREATE TABLE public.gisa_bdu_storico_chiamate (
id serial4 NOT NULL,
url varchar NULL,
request_dbi varchar NULL,
id_utente integer,
response varchar NULL,
"data" timestamp NULL,
id_tabella varchar NULL,
tabella varchar NULL,
caller varchar NULL,
endpoint varchar NULL,
esito varchar NULL
);

CREATE TABLE public.gisa_vam_storico_chiamate (
id serial4 NOT NULL,
url varchar NULL,
request_dbi varchar NULL,
id_utente integer,
response varchar NULL,
"data" timestamp NULL,
id_tabella varchar NULL,
tabella varchar NULL,
caller varchar NULL,
endpoint varchar NULL,
esito varchar NULL
);

--db gisa
CREATE OR REPLACE FUNCTION public.gisa_bdu_salva_storico_chiamate(
    url_input text,
    _request text,
    _response text,
    _idutente integer,
    id_tabella_input text default null,
    tabella_input text default null,
    esito_input text default null,
    caller_ text default null, 
    endpoint_ text default null    
    )
	RETURNS json AS
$BODY$
   DECLARE
   	conf_dblink text;
_id integer;
_output json;
query_upd text;
BEGIN

	select * from conf.get_pg_conf('STORICO') into conf_dblink;


SELECT COALESCE(url_input, '') into url_input;
SELECT COALESCE(_request, '') into _request;
SELECT COALESCE(_response, '') into _response;
SELECT COALESCE(_idutente, -1) into _idutente;

SELECT replace(_request, '''', '''''') into _request;
SELECT replace(_response, '''', '''''') into _response;

_id := (select * FROM dblink(conf_dblink::text, 
'insert into gisa_bdu_storico_chiamate(url, request_dbi , response, data, id_utente, id_tabella, tabella, esito, caller,endpoint) values ('''||url_input||''', '''||_request||''', 
'''||_response||''', now(), '||_idutente ||', ''' || id_tabella_input || ''', ''' || tabella_input || ''',''' || esito_input || ''',''' || caller_ || ''', ''' || endpoint_   || ''') returning id;')  as t1(output integer));


query_upd := concat ('update ',tabella_input,' set bdu_invio_ok = now() where id = ' , id_tabella_input);

raise info 'query_upd: %' , query_upd;
 execute query_upd;

_output:= (select * FROM dblink('host=dbSTORICOL dbname=storico'::text, 
'SELECT row_to_json (gisa_bdu_storico_chiamate) from gisa_bdu_storico_chiamate where id = '||_id||';') as t1(output json));

return _output;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.ws_salva_storico_chiamate(text, text, text, integer)
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.gisa_vam_salva_storico_chiamate(
    url_input text,
    _request text,
    _response text,
    _idutente integer,
    id_tabella_input text default null,
    tabella_input text default null,
    esito_input text default null,
    caller_ text default null, 
    endpoint_ text  default null   
    )
	RETURNS json AS
$BODY$
   DECLARE
   	conf_dblink text;
   	_url text;
_id integer;
_output json;
query_upd text;
BEGIN

	select * from conf.get_pg_conf('STORICO') into conf_dblink;


SELECT COALESCE(url_input, '') into _url;
SELECT COALESCE(_request, '') into _request;
SELECT COALESCE(_response, '') into _response;
SELECT COALESCE(_idutente, -1) into _idutente;

SELECT replace(_request, '''', '''''') into _request;
SELECT replace(_response, '''', '''''') into _response;

_id := (select * FROM dblink(conf_dblink::text, 
'insert into gisa_vam_storico_chiamate(url, request_dbi , response, data, id_utente, id_tabella, tabella, esito, caller,endpoint) values ('''||_url||''', '''||_request||''', 
'''||_response||''', now(), '||_idutente ||',''' || id_tabella_input || ''',''' || tabella_input || ''','''  || esito_input || ''',''' || caller_ || ''', ''' || endpoint_   || ''') returning id;')  as t1(output integer));


query_upd := concat ('update ',tabella_input,' set vam_invio_ok = now() where id = ' , id_tabella_input);

raise info 'query_upd: %' , query_upd;
 execute query_upd;
 
_output:= (select * FROM dblink('host=dbSTORICOL dbname=storico'::text, 
'SELECT row_to_json (gisa_vam_storico_chiamate) from gisa_vam_storico_chiamate where id = '||_id||';') as t1(output json));

return _output;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.ws_salva_storico_chiamate(text, text, text, integer)
  OWNER TO postgres;