--Controllare le funzioni e le viste se sono allineate con ufficiale

--Schede supplementari
insert into schede_supplementari.lookup_schede_supplementari(description, num_scheda, level, enabled, return_view) values('Scheda N. 164 – Dati integrativi per caricamento SINAC Strutture di detenzione', '164',1,true,'164');
insert into schede_supplementari.lookup_schede_supplementari(description, num_scheda, level, enabled, return_view) values('Scheda N. 165 – Dati integrativi per caricamento SINAC Strutture veterinarie', '165',1,true,'165');
insert into schede_supplementari.lookup_schede_supplementari(description, num_scheda, level, enabled, return_view) values('Scheda N. 119 – Veterinario responsabile scorta farmaci', '119',1,true,'119');
update role_permission set role_view = true where role_id = 32 and permission_id = 793;

update master_list_linea_attivita set scheda_supplementare = '111,164' where scheda_supplementare ilike '%111%';
update master_list_linea_attivita set scheda_supplementare = '118,165' where scheda_supplementare ilike '%118%';



CREATE OR REPLACE FUNCTION schede_supplementari.insert_dati_generici_164(
    _id_istanza integer,
    _flag_privato boolean,
    _cf_proprietario text,
    _data_inizio_proprietario timestamp without time zone,
    _comune_proprietario integer,
    _cf_gestore text,
    _data_inizio_gestione timestamp without time zone,
    _capacita integer,
    _specie_presenti_cane boolean,
    _specie_presenti_gatto boolean,
    _specie_presenti_altro boolean,
    _telefono_fisso text,
    _telefono_mobile text,
    _fax text
   )
		
  RETURNS integer AS
$BODY$

  DECLARE ret_id integer;
  
  BEGIN
	INSERT INTO schede_supplementari.dati_generici_164(id, id_istanza, flag_privato ,cf_proprietario ,data_inizio_proprietario ,comune_proprietario ,cf_gestore ,data_inizio_gestione ,capacita ,specie_presenti_cane ,specie_presenti_gatto ,specie_presenti_altro,telefono_fisso,telefono_mobile,fax )
	 VALUES ((select nextval('schede_supplementari.dati_generici_formazione_iaa_id_seq')), _id_istanza,_flag_privato ,_cf_proprietario ,_data_inizio_proprietario ,_comune_proprietario ,_cf_gestore ,_data_inizio_gestione ,_capacita ,_specie_presenti_cane ,_specie_presenti_gatto ,_specie_presenti_altro,_telefono_fisso,_telefono_mobile,_fax)
		RETURNING id into ret_id;
		  
 RETURN ret_id;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION schede_supplementari.insert_dati_generici_164( integer, boolean, text, timestamp without time zone, integer,  text, timestamp without time zone, integer, boolean, boolean, boolean,text, text, text)
  OWNER TO postgres;


CREATE TABLE schede_supplementari.dati_generici_164
(
  id serial NOT NULL,
  flag_privato boolean,
  cf_proprietario text,
  data_inizio_proprietario timestamp without time zone,
  comune_proprietario integer,
  cf_gestore text,
  data_inizio_gestione timestamp without time zone,
  capacita integer,
  specie_presenti_cane boolean,
  specie_presenti_gatto boolean,
  specie_presenti_altro boolean,
  id_istanza integer,
  telefono_fisso text,
  telefono_mobile text,
  fax text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE schede_supplementari.dati_generici_164
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION schede_supplementari.get_dati_generici_164(_id_istanza integer)
  RETURNS SETOF schede_supplementari.dati_generici_164 AS
$BODY$
DECLARE
	
BEGIN
		return query
			select * FROM schede_supplementari.dati_generici_164 WHERE id_istanza = _id_istanza;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION schede_supplementari.get_dati_generici_164(integer)
  OWNER TO postgres;



  
CREATE OR REPLACE FUNCTION schede_supplementari.insert_dati_generici_165(
    _id_istanza integer,
    _flag_h24 boolean,
    _flag_area_degenza boolean,
    _cf_veterinario text,
    _data_inizio_nomina timestamp without time zone,
    _telefono_fisso text,
    _telefono_mobile text,
    _fax text
   )
		
  RETURNS integer AS
$BODY$

  DECLARE ret_id integer;
  
  BEGIN
	INSERT INTO schede_supplementari.dati_generici_165(id, id_istanza, flag_h24,flag_area_degenza,cf_veterinario, data_inizio_nomina, telefono_fisso , telefono_mobile, fax )
	 VALUES ((select nextval('schede_supplementari.dati_generici_formazione_iaa_id_seq')), _id_istanza,_flag_h24 , _flag_area_degenza , _cf_veterinario , _data_inizio_nomina ,_telefono_fisso , _telefono_mobile ,_fax )
		RETURNING id into ret_id;
		  
 RETURN ret_id;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION schede_supplementari.insert_dati_generici_165(  integer,boolean, boolean,text,timestamp without time zone,text, text,text)
  OWNER TO postgres;



CREATE TABLE schede_supplementari.dati_generici_165
(
  id serial NOT NULL,
  flag_h24 boolean,
  flag_area_degenza boolean,
  cf_veterinario text, 
  data_inizio_nomina timestamp without time zone, 
  telefono_fisso text, 
  telefono_mobile text, 
  fax text,
  id_istanza integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE schede_supplementari.dati_generici_165
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION schede_supplementari.get_dati_generici_165(_id_istanza integer)
  RETURNS SETOF schede_supplementari.dati_generici_165 AS
$BODY$
DECLARE
	
BEGIN
		return query
			select * FROM schede_supplementari.dati_generici_165 WHERE id_istanza = _id_istanza;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION schede_supplementari.get_dati_generici_165(integer)
  OWNER TO postgres;





CREATE OR REPLACE FUNCTION schede_supplementari.insert_dati_generici_119(
    _id_istanza integer,
    _flag_privato boolean,
    _cf_proprietario text,
    _data_inizio_proprietario timestamp without time zone,
    _comune_proprietario integer,
    _cf_gestore text,
    _data_inizio_gestione timestamp without time zone,
    _capacita integer,
    _specie_presenti_cane boolean,
    _specie_presenti_gatto boolean,
    _specie_presenti_altro boolean,
    _telefono_fisso text,
    _telefono_mobile text,
    _fax text
   )
		
  RETURNS integer AS
$BODY$

  DECLARE ret_id integer;
  
  BEGIN
	INSERT INTO schede_supplementari.dati_generici_164(id, id_istanza, flag_privato ,cf_proprietario ,data_inizio_proprietario ,comune_proprietario ,cf_gestore ,data_inizio_gestione ,capacita ,specie_presenti_cane ,specie_presenti_gatto ,specie_presenti_altro,telefono_fisso,telefono_mobile,fax )
	 VALUES ((select nextval('schede_supplementari.dati_generici_formazione_iaa_id_seq')), _id_istanza,_flag_privato ,_cf_proprietario ,_data_inizio_proprietario ,_comune_proprietario ,_cf_gestore ,_data_inizio_gestione ,_capacita ,_specie_presenti_cane ,_specie_presenti_gatto ,_specie_presenti_altro,_telefono_fisso,_telefono_mobile,_fax)
		RETURNING id into ret_id;
		  
 RETURN ret_id;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION schede_supplementari.insert_dati_generici_164( integer, boolean, text, timestamp without time zone, integer,  text, timestamp without time zone, integer, boolean, boolean, boolean,text, text, text)
  OWNER TO postgres;


CREATE TABLE schede_supplementari.dati_generici_164
(
  id serial NOT NULL,
  flag_privato boolean,
  cf_proprietario text,
  data_inizio_proprietario timestamp without time zone,
  comune_proprietario integer,
  cf_gestore text,
  data_inizio_gestione timestamp without time zone,
  capacita integer,
  specie_presenti_cane boolean,
  specie_presenti_gatto boolean,
  specie_presenti_altro boolean,
  id_istanza integer,
  telefono_fisso text,
  telefono_mobile text,
  fax text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE schede_supplementari.dati_generici_164
  OWNER TO postgres;



CREATE OR REPLACE FUNCTION schede_supplementari.get_dati_generici_164(_id_istanza integer)
  RETURNS SETOF schede_supplementari.dati_generici_164 AS
$BODY$
DECLARE
	
BEGIN
		return query
			select * FROM schede_supplementari.dati_generici_164 WHERE id_istanza = _id_istanza;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION schede_supplementari.get_dati_generici_164(integer)
  OWNER TO postgres;
