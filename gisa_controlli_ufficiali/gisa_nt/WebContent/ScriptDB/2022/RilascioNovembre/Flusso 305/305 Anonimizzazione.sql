CREATE TABLE anon_num_reg(id serial primary key, num_reg_orig text, num_reg_anon text);

CREATE OR REPLACE FUNCTION public.anon_get_num_registrazione(_num_reg text)
  RETURNS text AS
$BODY$
DECLARE  

 _num_reg_anon text;  
 _id_num_reg integer;
 
BEGIN 

SELECT num_reg_anon INTO _num_reg_anon FROM anon_num_reg where num_reg_orig ilike _num_reg;

IF _num_reg_anon <> '' THEN
RETURN _num_reg_anon;
END IF;

INSERT INTO anon_num_reg (num_reg_orig) values (_num_reg) returning id into _id_num_reg;

_num_reg_anon = _id_num_reg || (SELECT array_to_string(array(select substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',((random()*(36-1)+1)::integer),1) from generate_series(1,15)),''));

_num_reg_anon := LPAD(_num_reg_anon, 20, '0');

UPDATE anon_num_reg set num_reg_anon = _num_reg_anon where id = _id_num_reg;

RETURN _num_reg_anon;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE TABLE anon_num_ric(id serial primary key, num_ric_orig text, num_ric_anon text);

CREATE OR REPLACE FUNCTION public.anon_get_num_riconoscimento(_num_ric text)
  RETURNS text AS
$BODY$
DECLARE  

 _num_ric_anon text;  
 _id_num_ric integer;
 
BEGIN 

SELECT num_ric_anon INTO _num_ric_anon FROM anon_num_ric where num_ric_orig ilike _num_ric;

IF _num_ric_anon <> '' THEN
RETURN _num_ric_anon;
END IF;

INSERT INTO anon_num_ric (num_ric_orig) values (_num_ric) returning id into _id_num_ric;

_num_ric_anon = _id_num_ric || (SELECT array_to_string(array(select substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',((random()*(36-1)+1)::integer),1) from generate_series(1,15)),''));

_num_ric_anon := LPAD(_num_ric_anon, 20, '0');

UPDATE anon_num_ric set num_ric_anon = _num_ric_anon where id = _id_num_ric;

RETURN _num_ric_anon;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE TABLE anon_comune(id serial primary key, comune_orig integer, comune_anon text);

CREATE OR REPLACE FUNCTION public.anon_get_comune(_comune integer)
  RETURNS text AS
$BODY$
DECLARE  

 _comune_anon text;  
 _id_comune integer;
 
BEGIN 

SELECT comune_anon INTO _comune_anon FROM anon_comune where comune_orig = _comune;

IF _comune_anon <> '' THEN
RETURN _comune_anon;
END IF;

INSERT INTO anon_comune (comune_orig) values (_comune) returning id into _id_comune;

_comune_anon = _id_comune || (SELECT array_to_string(array(select substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',((random()*(36-1)+1)::integer),1) from generate_series(1,15)),''));

_comune_anon := LPAD(_comune_anon, 6, '0');

UPDATE anon_comune set comune_anon = _comune_anon where id = _id_comune;

RETURN _comune_anon;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

  CREATE TABLE anon_controllo(id serial primary key, controllo_orig integer, controllo_anon text);

CREATE OR REPLACE FUNCTION public.anon_get_controllo(_controllo integer, _asl integer)
  RETURNS text AS
$BODY$
DECLARE  

 _controllo_anon text;  
 _asl_anon text;
 _id_controllo integer;
 
BEGIN 

SELECT controllo_anon INTO _controllo_anon FROM anon_controllo where controllo_orig = _controllo;

IF _controllo_anon <> '' THEN
RETURN _controllo_anon;
END IF;

INSERT INTO anon_controllo (controllo_orig) values (_controllo) returning id into _id_controllo;

_controllo_anon = reverse(_controllo::text);
_asl_anon = reverse(_asl::text);

_controllo_anon = 
substring(_controllo_anon, 0,3) || substring(_asl_anon, 0,2) ||
substring(_controllo_anon, 3,2) || substring(_asl_anon, 2,1) ||
substring(_controllo_anon, 5,2) || substring(_asl_anon, 3,5) ||
substring(_controllo_anon, 7,length(_controllo_anon)); 

UPDATE anon_controllo set controllo_anon = _controllo_anon where id = _id_controllo;

RETURN _controllo_anon;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
  -- Function: digemon.get_checklist_sorveglianza_new()

-- DROP FUNCTION digemon.get_checklist_sorveglianza_new();

CREATE OR REPLACE FUNCTION digemon.get_checklist_sorveglianza_new()
  RETURNS TABLE(id integer, id_controllo integer, is_principale boolean, stato text, livello_rischio integer, tipo_check integer, num_chk integer) AS
$BODY$
DECLARE

BEGIN
RETURN QUERY

	select a.id, a.id_controllo::integer, a.is_principale, a.stato, a.livello_rischio, a.tipo_check, lc.num_chk
	from audit a 
	left join lookup_org_catrischio lc on lc.code = a.tipo_check
	where a.trashed_date is null order by 2;

   
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION digemon.get_checklist_sorveglianza_new()
  OWNER TO postgres;
