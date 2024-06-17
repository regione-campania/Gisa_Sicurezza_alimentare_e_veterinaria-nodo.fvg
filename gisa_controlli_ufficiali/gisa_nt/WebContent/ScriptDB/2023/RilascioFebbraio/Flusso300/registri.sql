
CREATE TABLE public.lookup_codici_specie_centri_riproduzione
(
  code serial,
  description character varying,
  short_description character varying,
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_codici_specie_centri_riproduzione
  OWNER TO postgres;

insert into lookup_codici_specie_centri_riproduzione(description, short_description) values ('BOVINO','C4');
insert into lookup_codici_specie_centri_riproduzione(description, short_description) values ('SUINO', 'C7');
insert into lookup_codici_specie_centri_riproduzione(description, short_description) values ('EQUINO','C0');
insert into lookup_codici_specie_centri_riproduzione(description, short_description) values ('ASINO','C8');--da capire quale sia lo short_description

CREATE TABLE public.lookup_razze_bovini_centri_riproduzione
(
  code serial,
  description character varying,
  short_description character varying,
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_razze_bovini_centri_riproduzione
  OWNER TO postgres;

insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('BRUNA','01');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('FISONA ITALIANA','02');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('VALDOSTANA PEZZATA ROSSA','03');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PEZZATA ROSSA ITALIANA','04');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PIEMONTESE','05');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('BIANCA VAL PADANA','06');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('REGGIANA','07');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('MODICANA','08');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('OROPA PEZZATA','09');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('RENDENA','10');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('GRIGIA ALPINA','11');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('TARINA','12');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('ROSSA DANESE','13');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PINZGAU','14');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('JERSEY','15');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('ABBUNDANCE','16');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('CALVANA','17');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('VALDOSTANA PEZZATA NERA','18');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('BURLINA','19');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('CHAROLAISE','50');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('MARCHIGIANA','51');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('CHIANINA','52');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('LlMOUSINE','53');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('ROMAGNOLA','54');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('MAREMMANA','55');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PODOLICA','56');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('ANGLER','57');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('GARFAGNINA','58');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PONTREMOLESE','59');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('SARDA','60');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('CASTANA','61');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('CABANNINA','62');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('AGEROLESE','63');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PISANA','64');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PEZZATA NERA POLACCA','65');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PEZZATA ROSSA JUGOSLAVA','66');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('VARZESE OTTONESE','67');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('BLUE BELGA','68');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('SARDA MODICANA','69');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('PUSTERTALER','77');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('MEONTEBELIARD','88');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('CINISARA','96');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('GARONNAISE','99');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('ABERDEEN ANGUS','AN');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('BLONDE D''AQUITAINE','BA');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('GALLOWAY','GW');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('SARDO BRUNA','SB');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('ROTBUNDE DA FRISONA','X1');
insert into lookup_razze_bovini_centri_riproduzione(description, short_description) values ('ROTBUNDE IMPORTATO','X2');

CREATE TABLE public.lookup_razze_suini_centri_riproduzione
(
  code serial,
  description character varying,
  short_description character varying,
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_razze_suini_centri_riproduzione
  OWNER TO postgres;

insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('LARGE WHITE','80');
insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('LANDRACE','81');
insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('LANDRACE BELGA','82');
insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('HAMPSHIRE','83');
insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('PI ETRAI N','84');
insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('SPOTTED POLAND','85');
insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('DUROC','86');
insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('IBRIDO','87');
insert into lookup_razze_suini_centri_riproduzione(description, short_description) values ('CINTA SENESE','CS');



CREATE TABLE public.lookup_razze_equini_centri_riproduzione
(
  code serial,
  description character varying,
  short_description character varying,
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_razze_equini_centri_riproduzione
  OWNER TO postgres;
  
  insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Avelignese','E1');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Bardigiano','E6');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Maremmano','E5');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Agricolo Italiano T.P.R.','E2');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Lipizzano','E7');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Trottatore','E4');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Puro sangue Inglese','E3');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Cavallo del Ventasso','E8');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Norico','E9');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Cavallo del Catria','E0');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Pony di Esperia','B1');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Salernitano','B2');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Persano','B3');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Sanfratellano','B4');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Cavallino della Giara','B5');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Murgese','B6');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Samolaco','B7');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Tolfetano','B8');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Cavallino di Monterufoli','B9');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Puro sangue arabo','D5');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Puro sangue orientale','D6');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Puro sangue anglo orientale','D7');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Anglo Arabo','D8');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Anglo arabo sardo','D9');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Anglo Normanno','D0');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Sella Italiano','H1');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Sella Francese','H2');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Hannover','H3');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Holstein','H4');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Westfalia','H5');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('ldenburg','H6');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Sella Belga','H7');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Sella Irlandese','H8');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Sella Olandese','H9');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Sella Spagnolo','H0');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Wurttemberg','J1');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Hessen','J2');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Bayer','J3');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Trakehner','J4');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Arabo Tersk','J5');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Andaluso','J6');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Lusitano','J7');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Camargue delta','J8');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Franches Montagnes','J9');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Bretone','J0');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Cavallo di Merens','K1');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Quarter Horse','K2');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Appaloosa','K3');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Paint Horse','K4');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Morgan','K5');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Achal Tech�','K6');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Budyonny','K7');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Pony Connemara','K8');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Pony Welsh','K9');
insert into lookup_razze_equini_centri_riproduzione(description, short_description) values ('Pony Shetland','K0');

CREATE TABLE public.lookup_tipo_seme_embrioni
(
  code serial,
  description character varying,
  short_description character varying,
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_tipo_seme_embrioni
  OWNER TO postgres;
  
  insert into lookup_tipo_seme_embrioni(description, short_description) values ('SEME FRESCO','SF');
insert into lookup_tipo_seme_embrioni(description, short_description) values ('SEME REFRIGERATO','SR');
insert into lookup_tipo_seme_embrioni(description, short_description) values ('SEME CONGELATO','SC');
insert into lookup_tipo_seme_embrioni(description, short_description) values ('EMBRIONE CONGELATO','EC');

CREATE OR REPLACE FUNCTION public.get_info_registro_carico_scarico(
    IN _id_registro integer)
  RETURNS TABLE(riferimento_id integer, riferimento_id_nome_tab text, ragione_sociale text, numero_registrazione text, id_tipologia integer) AS
$BODY$
DECLARE  

BEGIN 

	if _id_registro > 0 then 
		return query 
			    select distinct r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale::text, r.n_reg::text, ist.id_tipologia_registro
			    from registro_carico_scarico_istanze ist
	                    left join ricerche_anagrafiche_old_materializzata r on r.n_reg = ist.num_registrazione_stab
	                    where ist.id = _id_registro and ist.trashed_date is null;
	else 
		return query 
				select -1, '-1','-1', '-1', -1;
	end if;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_info_registro_carico_scarico(integer)
  OWNER TO postgres;
  

  -- 2 nuovi ruoli
insert into role_ext(role_id, role, description, enteredby, entered, modifiedby, modified, enabled, role_type, super_ruolo, descrizione_super_ruolo,
in_access, in_dpat, in_nucleo_ispettivo, view_lista_utenti_nucleo_ispettivo) values
((select max(role_id)+1 from role_ext),'Veterinario responsabile centro produzione seme','Veterinario responsabile centro produzione seme', 291, now(), 291, now(), true,0,2, 'GRUPPO_ALTRE_AUTORITA',
true, false, true, false) returning role_id; --10000010

insert into role_ext(role_id, role, description, enteredby, entered, modifiedby, modified, enabled, role_type, super_ruolo, descrizione_super_ruolo,
in_access, in_dpat, in_nucleo_ispettivo, view_lista_utenti_nucleo_ispettivo) values
((select max(role_id)+1 from role_ext), 'Responsabile dei recapiti','Responsabile dei recapiti', 291, now(), 291, now(), true,0,2, 'GRUPPO_ALTRE_AUTORITA',
true, false, true, false) returning role_id;;--10000011


insert into permission_ext(category_id, permission, permission_view, permission_add, permission_edit, permission_delete, description, level, enabled, active) values (118,'registro_carico_scarico_seme',true, true, true, true, 'Gestione Registro Carico/Scarico per produzione seme',1,true,true) 
returning permission_id;--44
insert into permission_ext(category_id, permission, permission_view, permission_add, permission_edit, permission_delete, description, level, enabled, active) values (118,'registro_carico_scarico_recapiti',true, true, true, true, 'Gestione Registro Carico/Scarico per Recapito',2,true,true)
returning permission_id;--45
insert into permission_ext(category_id, permission, permission_view, permission_add, permission_edit, permission_delete, description, level, enabled, active) values (118,'registro_carico_scarico',true, false, false, false, 'Gestione Registro Carico/Scarico',2,true,true)
returning permission_id;--46

--i due ruoli devono avere 
--99;"myhomepage-dashboard"
--465;"documentale_documents"
--10000033;"system-access"
-- + i nuovi
/*
PERMESSO REGISTRI (solo view) 10000046;118;"registro_centri"

seme -> si
recapiti -> si

PERMESSO REGISTRO SEME --10000044;118;"registro_seme"

seme -> view, add, edit, delete
recapiti -> view

PERMESSO REGISTRI RECAPITI 10000045;118;"registro_recapiti"

seme -> view, add, edit, delete 
recapiti -> view, add, edit, delete 
*/

insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (10000044,10000010,true,true, true, true); --seme
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (10000045,10000010,true,true, true, true); --recapiti per seme 
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (10000046,10000010,true,false, false, false); --centri per seme
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (99,10000010,true,true, true, false); --
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (10000033,10000010,true,true, true, false); --
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (465,10000010,true,true, true, false); --

insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (10000044,10000011,true,false, false, false); --seme per recapiti
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (10000046,10000011,true,false, false, false); --centri per recapiti
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (10000045,10000011,true,true, true, true); --recapito
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (99,10000011,true,true, true, false); --
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (10000033,10000011,true,true, true, false); --
insert into role_permission_ext (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (465,10000011,true,true, true, false); --

insert into permission(category_id, permission, permission_view, permission_add, permission_edit, permission_delete, description, level, enabled, active) values (118,'registro_carico_scarico',true, false, false, false, 'Gestione Registro Carico/Scarico',3,true,true)
returning permission_id;--840

insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (840,1,true,true, true, true); --per HD tutto
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (840,31,true,false, false, false); --per orsa solo view
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (840,32,true,true, true, true); --per HD tutto
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (840,43,true,false, false, false); --per orsa solo view


insert into permission(category_id, permission, permission_view, permission_add, permission_edit, permission_delete, description, level, enabled, active) values (118,'registro_carico_scarico_seme',true, true, true, true, 'Gestione Registro Carico/Scarico per produzione seme',1,true,true)
returning permission_id;
insert into permission(category_id, permission, permission_view, permission_add, permission_edit, permission_delete, description, level, enabled, active) values (118,'registro_carico_scarico_recapiti',true, true, true, true, 'Gestione Registro Carico/Scarico per Recapito',2,true,true)
returning permission_id;;

insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (841,1,true,true, true, true); --per HD 
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (841,31,true,false, false, false); --per  ORSA solo view
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (841,32,true,true, true, true); --per HD
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (841,43,true,false, false, false); --per  Medico Veterinario solo view

insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (842,1,true,true, true, true); --per HD
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (842,31,true,false, false, false); --per ORSA solo view
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (842,43,true,false, false, false); --per Medc solo view
insert into role_permission (permission_id, role_id, role_view, role_add, role_edit, role_delete) values (842,32,true,true, true, true); --per HD 


create table lookup_tipologia_registro_carico_scarico (
code serial,
description character varying,
short_description character varying,
level integer,
enabled boolean
) 

insert into lookup_tipologia_registro_carico_scarico (description, short_description, level, enabled) values ('Registro seme', 'Registro seme',0, true);
insert into lookup_tipologia_registro_carico_scarico (description, short_description, level, enabled) values ('Registro recapiti', 'Registro recapiti',1, true);

-- istanze
CREATE TABLE
registro_carico_scarico_istanze
(id serial primary key,
id_tipologia_registro integer,
num_registrazione_stab text,
entered timestamp without time zone default now(),
enteredby integer,
note_hd text,
trashed_date timestamp without time zone,
trashedby integer)


CREATE TABLE public.lookup_razze_asini_centri_riproduzione
(
  code serial,
  description character varying,
  short_description character varying,
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.lookup_razze_asini_centri_riproduzione
  OWNER TO postgres;

insert into lookup_razze_asini_centri_riproduzione (description, short_description, level, enabled) values ('Asino dell''Amiata','B0',0,true);
insert into lookup_razze_asini_centri_riproduzione (description, short_description, level, enabled) values ('Asino Ragusano','D1',0,true);
insert into lookup_razze_asini_centri_riproduzione (description, short_description, level, enabled) values ('Asino dell''Asinara','D2',0,true);
insert into lookup_razze_asini_centri_riproduzione (description, short_description, level, enabled) values ('Asino Sardo','D3',0,true);
insert into lookup_razze_asini_centri_riproduzione (description, short_description, level, enabled) values ('Asino di Martina Franca','D4',0,true);

--------------------------------------------------------------------------------------- vedi gisa_--------------------------------------------------

CREATE TABLE public.registro_carico_seme
(
  id serial,
  id_registro integer,
  entered timestamp without time zone DEFAULT now(),
  enteredby integer,
  note_hd text,
  trashed_date timestamp without time zone,
  trashedby integer,
  indice integer DEFAULT 0,
  num_registrazione text,
  nome_capo text,
  documento_trasporto_entrata text,
  data_produzione text,
  codice_mittente text,
  id_specie integer,
  id_razza integer,
  matricola_riproduttore_maschio text,
  identificazione_partita text,
  id_tipo_seme integer,
  dosi_prodotte integer,
  dosi_acquistate integer,
  enabled boolean DEFAULT true,
  CONSTRAINT registro_carico_seme_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.registro_carico_seme
  OWNER TO postgres;


CREATE TABLE public.registro_scarico_seme
(
  id serial,
  id_carico integer,
  entered timestamp without time zone DEFAULT now(),
  enteredby integer,
  note_hd text,
  trashed_date timestamp without time zone,
  trashedby integer,
  indice integer DEFAULT 0,
  documento_trasporto_uscita text,
  codice_destinatario text,
  dosi_vendute integer,
  dosi_distrutte integer,
  data_vendita text,
  enabled boolean DEFAULT true,
  num_registrazione text,
  CONSTRAINT registro_scarico_seme_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.registro_scarico_seme
  OWNER TO postgres;


CREATE TABLE public.registro_carico_recapito
(
  id serial,
  entered timestamp without time zone DEFAULT now(),
  enteredby integer,
  note_hd text,
  trashed_date timestamp without time zone,
  trashedby integer,
  indice integer DEFAULT 0,
  num_registrazione text,
  data_registrazione_entrata text,
  nome_capo text,
  codice_mittente text,
  id_specie integer,
  id_razza integer,
  matricola_riproduttore_maschio text,
  matricola_riproduttore_femmina text,
  identificazione_partita text,
  id_tipo_seme integer,
  dosi_acquistate integer,
  documento_commerciale_entrata text,
  enabled boolean DEFAULT true,
  id_registro integer,
  CONSTRAINT registro_carico_recapito_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.registro_carico_recapito
  OWNER TO postgres;


CREATE TABLE public.registro_scarico_recapito
(
  id serial,
  id_carico integer,
  entered timestamp without time zone DEFAULT now(),
  enteredby integer,
  note_hd text,
  trashed_date timestamp without time zone,
  trashedby integer,
  indice integer DEFAULT 0,
  data_registrazione_uscita text,
  codice_destinatario text,
  dosi_vendute integer,
  dosi_distrutte integer,
  documento_commerciale_uscita text,
  enabled boolean DEFAULT true,
  num_registrazione text,
  CONSTRAINT registro_scarico_recapito_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.registro_scarico_recapito
  OWNER TO postgres;


-- funzioni
CREATE OR REPLACE FUNCTION public.delete_registro_carico_recapiti(
    _id integer,
    _user_id integer)
  RETURNS integer AS
$BODY$

DECLARE
 
BEGIN
	
	UPDATE public.registro_carico_recapito
	SET note_hd='CANCELLAZIONE EFFETTUATA NEL REGISTRO DI CARICO RECAPITO TRAMITE DBI', 
        trashed_date=now(), trashedby = _user_id
        WHERE id = _id;

	RETURN _id;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


CREATE OR REPLACE FUNCTION public.delete_registro_carico_seme(
    _id integer,
    _user_id integer)
  RETURNS integer AS
$BODY$

DECLARE
 
BEGIN

	UPDATE public.registro_carico_seme
	SET note_hd='CANCELLAZIONE EFFETTUATA NEL REGISTRO DI CARICO SEME TRAMITE DBI', 
        trashed_date=now(), trashedby = _user_id
        WHERE id = _id;

	RETURN _id;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


CREATE OR REPLACE FUNCTION public.delete_registro_scarico_seme(
    _id integer,
    _user_id integer)
  RETURNS integer AS
$BODY$

DECLARE
 
BEGIN

	UPDATE public.registro_scarico_seme
	SET note_hd='CANCELLAZIONE EFFETTUATA NEL REGISTRO DI SCARICO SEME TRAMITE DBI', 
        trashed_date=now(), trashedby = _user_id
        WHERE id = _id;

	RETURN _id;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


CREATE OR REPLACE FUNCTION public.delete_registro_scarico_recapiti(
    _id integer,
    _user_id integer)
  RETURNS integer AS
$BODY$

DECLARE
 
BEGIN

	UPDATE public.registro_scarico_recapito
	SET note_hd='CANCELLAZIONE EFFETTUATA NEL REGISTRO DI SCARICO SEME TRAMITE DBI', 
        trashed_date=now(), trashedby = _user_id
        WHERE id = _id;

	RETURN _id;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- Function: public.upsert_registro_scarico_seme(integer, integer, integer, text, text, integer, integer, text)

-- DROP FUNCTION public.upsert_registro_scarico_seme(integer, integer, integer, text, text, integer, integer, text);


CREATE OR REPLACE FUNCTION public.upsert_registro_carico_seme(
    _id integer,
    _id_registro integer,
    _num_registrazione_stab text,
    _user_id integer,
    _data_produzione text,
    _codice_mittente text,
    _id_specie integer,
    _id_razza integer,
    _nome_capo text,
    _matricola_riproduttore_maschio text,
    _identificazione_partita text,
    _id_tipo_seme integer,
    _dosi_prodotte integer,
    _dosi_acquistate integer,
    _documento_trasporto_entrata text)
  RETURNS integer AS
$BODY$

DECLARE

 note_hd text;
 indice integer;
 id_registro_out integer;
 _num_registrazione text;
 id_registro_carico integer;
 nreg text;
 
BEGIN
--select * from registro_carico_scarico_istanze 
note_hd := 'RECORD GENERATO PER INSERIMENTO RECORD NEL REGISTRO DI CARICO SEME TRAMITE DBI';
indice := (select coalesce(max(r.indice)+1,0) from registro_carico_scarico_istanze  i 
                                                   join registro_carico_seme r on i.id = r.id_registro
                                                   where i.num_registrazione_stab = _num_registrazione_stab and i.trashed_date is null and i.id_tipologia_registro=1
           );
           	
if _id_registro = -1 then

	insert into registro_carico_scarico_istanze(id_tipologia_registro, num_registrazione_stab, entered, enteredby, note_hd) 
	values (1, _num_registrazione_stab, current_timestamp, _user_id, 'RECORD GENERATO TRAMITE DBI DI INSERIMENTO REGISTRO CARICO SEME') returning id into id_registro_out;

else 
	id_registro_out := _id_registro;
end if;

raise info 'id istanza %', id_registro_out;


if _id > 0 then

	_num_registrazione := (select num_registrazione from public.registro_carico_seme  where id = _id and trashed_date is null);
	
	UPDATE public.registro_carico_seme
	SET note_hd='CANCELLAZIONE EFFETTUATA PER MODIFICA NEL REGISTRO DI CARICO SEME TRAMITE DBI', 
	trashed_date=now(), trashedby = _user_id
	WHERE id = _id;
else
	
	 nreg := (select max(substring(num_registrazione,5,10)) from registro_carico_seme);
	 raise info 'val nreg%', nreg;
	 if nreg is null or nreg = '' then
		_num_registrazione := (select concat('S', substring(date_part('year',current_timestamp)::text,3),'C', lpad('1', 6, '0')));
	else
		_num_registrazione := (select concat('S', substring(date_part('year',current_timestamp)::text,3),'C', lpad((max(substring(num_registrazione,5,10)::integer)+1)::text , 6, '0'))
	                              from registro_carico_seme );
	end if;
	
end if;


INSERT INTO public.registro_carico_seme(
entered, enteredby, note_hd, nome_capo, id_registro,
indice, num_registrazione, data_produzione, codice_mittente, id_specie, id_razza, matricola_riproduttore_maschio, 
identificazione_partita, id_tipo_seme, dosi_prodotte, dosi_acquistate, documento_trasporto_entrata)
	
VALUES (current_timestamp, _user_id, note_hd, _nome_capo, id_registro_out,
	indice, _num_registrazione, _data_produzione, _codice_mittente,
        _id_specie, _id_razza, _matricola_riproduttore_maschio,
	_identificazione_partita, _id_tipo_seme, _dosi_prodotte, _dosi_acquistate, _documento_trasporto_entrata) returning id into id_registro_carico;


return id_registro_carico;


 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.upsert_registro_carico_seme(integer, integer, text, integer, text, text, integer, integer, text, text, text, integer, integer, integer, text)
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.upsert_registro_scarico_seme(
    _id integer,
    _id_carico integer,
    _user_id integer,
    _data_vendita text,
    _codice_destinatario text,
    _dosi_vendute integer,
    _dosi_distrutte integer,
    _documento_trasporto_uscita text)
  RETURNS integer AS
$BODY$

DECLARE

 note_hd text;
 indice integer;
 id_registro integer;
 _num_registrazione text;
 nreg text;
 
BEGIN

note_hd := 'RECORD GENERATO PER INSERIMENTO RECORD NEL REGISTRO DI SCARICO SEME TRAMITE DBI';
indice := (select coalesce(max(r.indice)+1,0) from registro_scarico_seme r 
                                              where r.id_carico = _id_carico and r.trashed_date is null
           );

if _id > 0 then

	_num_registrazione := (select num_registrazione from registro_scarico_seme where id = _id and trashed_date is null);
	indice := (select r.indice from registro_scarico_seme r where r.id = _id and r.trashed_date is null);
	
	UPDATE public.registro_scarico_seme
	SET note_hd='CANCELLAZIONE EFFETTUATA PER MODIFICA NEL REGISTRO DI SCARICO SEME TRAMITE DBI', 
        trashed_date=now(), trashedby = _user_id
        WHERE id = _id;
else
	-- _num_registrazione:= (select concat('S', substring(date_part('year',current_timestamp)::text,3),'S', max(substring(num_registrazione,5,10)::integer+1) , 6, '0')));
	 nreg := (select max(substring(num_registrazione,5,10)) from registro_scarico_seme);
	 raise info 'val nreg%', nreg;
	 if nreg is null or nreg = '' then
		_num_registrazione := (select concat('S', substring(date_part('year',current_timestamp)::text,3),'S', lpad('1', 6, '0')));
	else
		_num_registrazione := (select concat('S', substring(date_part('year',current_timestamp)::text,3),'S', lpad((max(substring(num_registrazione,5,10)::integer)+1)::text , 6, '0'))
	                              from registro_scarico_seme );
	end if;
end if;

INSERT INTO public.registro_scarico_seme(entered, enteredby, note_hd, num_registrazione,
        indice, id_carico,  codice_destinatario, dosi_vendute, dosi_distrutte, data_vendita, documento_trasporto_uscita)
VALUES ( current_timestamp, _user_id, note_hd, _num_registrazione,
	indice, _id_carico, _codice_destinatario, _dosi_vendute, _dosi_distrutte, _data_vendita, _documento_trasporto_uscita) returning id into id_registro;

return id_registro;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.upsert_registro_scarico_seme(integer, integer, integer, text, text, integer, integer, text)
  OWNER TO postgres;

-- Function: public.upsert_registro_carico_recapiti(integer, integer, text, integer, text, text, integer, integer, text, text, text, text, integer, integer, text)

-- DROP FUNCTION public.upsert_registro_carico_recapiti(integer, integer, text, integer, text, text, integer, integer, text, text, text, text, integer, integer, text);

CREATE OR REPLACE FUNCTION public.upsert_registro_carico_recapiti(
    _id integer,
    _id_registro integer,
    _num_registrazione_stab text,
    _user_id integer,
    _data_registrazione_entrata text,
    _codice_mittente text,
    _id_specie integer,
    _id_razza integer,
    _nome_capo text,
    _matricola_riproduttore_maschio text,
    _matricola_riproduttore_femmina text,
    _identificazione_partita text,
    _id_tipo_seme integer,
    _dosi_acquistate integer,
    _documento_commerciale_entrata text)
  RETURNS integer AS
$BODY$

DECLARE
 note_hd text;
 indice integer;
 id_registro_out integer;
 _num_registrazione text;
 id_registro_recapiti integer;
 nreg text;
BEGIN

note_hd := 'RECORD GENERATO PER INSERIMENTO RECORD NEL REGISTRO DI CARICO/SCARICO RECAPITO TRAMITE DBI';
indice := (select coalesce(max(r.indice)+1,0) from registro_carico_scarico_istanze  i 
                                                   join registro_carico_recapito r on i.id = r.id_registro
                                                   where i.num_registrazione_stab = _num_registrazione_stab and i.trashed_date is null and i.id_tipologia_registro=2
	  );

if _id_registro = -1 then

	insert into registro_carico_scarico_istanze(id_tipologia_registro, num_registrazione_stab, entered, enteredby, note_hd) 
	values (2, _num_registrazione_stab, current_timestamp, _user_id, 'RECORD GENERATO TRAMITE DBI DI INSERIMENTO REGISTRO CARICO RECAPITI') returning id into id_registro_out;
	
else 
	id_registro_out := _id_registro;
end if;

if _id > 0 then

	_num_registrazione := (select num_registrazione from registro_carico_recapito  where id = _id and trashed_date is null);

	UPDATE public.registro_carico_recapito
	SET note_hd='CANCELLAZIONE EFFETTUATA PER MODIFICA NEL REGISTRO DI CARICO/SCARICO RECAPITO TRAMITE DBI', 
        trashed_date=now(), trashedby = _user_id
        WHERE id = _id;

else
	 nreg := (select max(substring(num_registrazione,5,10)) from registro_carico_recapito );
	 raise info 'val nreg%', nreg;
	 if nreg is null or nreg = '' then
		_num_registrazione := (select concat('R', substring(date_part('year',current_timestamp)::text,3),'C', lpad('1', 6, '0')));
	else
		_num_registrazione := (select concat('R', substring(date_part('year',current_timestamp)::text,3),'C', lpad((max(substring(num_registrazione,5,10)::integer)+1)::text , 6, '0'))
	                              from registro_carico_recapito  );
	end if;

end if;

INSERT INTO public.registro_carico_recapito(
	entered, enteredby, note_hd, id_registro, 
        indice, num_registrazione, data_registrazione_entrata, codice_mittente, 
	id_specie, id_razza, matricola_riproduttore_maschio, nome_capo,
	identificazione_partita, id_tipo_seme, dosi_acquistate, matricola_riproduttore_femmina, documento_commerciale_entrata)
VALUES (current_timestamp, _user_id, note_hd, id_registro_out,
	indice, _num_registrazione, _data_registrazione_entrata, _codice_mittente,
	_id_specie, _id_razza, _matricola_riproduttore_maschio, _nome_capo,
	_identificazione_partita, _id_tipo_seme, _dosi_acquistate, _matricola_riproduttore_femmina, _documento_commerciale_entrata) returning id into id_registro_recapiti;

return id_registro_recapiti;

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.upsert_registro_carico_recapiti(integer, integer, text, integer, text, text, integer, integer, text, text, text, text, integer, integer, text)
  OWNER TO postgres;


-- Function: public.upsert_registro_scarico_recapiti(integer, integer, integer, text, text, integer, integer, text)

-- DROP FUNCTION public.upsert_registro_scarico_recapiti(integer, integer, integer, text, text, integer, integer, text);

CREATE OR REPLACE FUNCTION public.upsert_registro_scarico_recapiti(
    _id integer,
    _id_carico integer,
    _user_id integer,
    _data_registrazione_uscita text,
    _codice_destinatario text,
    _dosi_vendute integer,
    _dosi_distrutte integer,
    _documento_commerciale_uscita text)
  RETURNS integer AS
$BODY$

DECLARE
 note_hd text;
 indice integer;
 id_registro integer;
 _num_registrazione text;
 nreg text;
BEGIN
note_hd := 'RECORD GENERATO PER INSERIMENTO RECORD NEL REGISTRO DI SCARICO RECAPITO TRAMITE DBI';
indice := (select coalesce(max(r.indice)+1,0) from registro_scarico_recapito r 
                                          where r.trashed_date is null --and i.id_tipologia_registro=1
                                          and r.id_carico = _id_carico
	  );

if _id > 0 then

	_num_registrazione := (select num_registrazione from registro_scarico_recapito  where trashed_date is null and id = _id);
	indice :=(select r.indice from registro_scarico_recapito r where r.id = _id);

	UPDATE public.registro_scarico_recapito
	SET note_hd='CANCELLAZIONE EFFETTUATA PER MODIFICA NEL REGISTRO DI SCARICO RECAPITO TRAMITE DBI', 
        trashed_date=now(), trashedby = _user_id
        WHERE id = _id;

else
	-- _num_registrazione:= (select concat('S', substring(date_part('year',current_timestamp)::text,3),'S', max(substring(num_registrazione,5,10)::integer+1) , 6, '0')));
	 nreg := (select max(substring(num_registrazione,5,10)) from registro_scarico_recapito);
	 raise info 'val nreg%', nreg;
	 if nreg is null or nreg = '' then
		_num_registrazione := (select concat('R', substring(date_part('year',current_timestamp)::text,3),'S', lpad('1', 6, '0')));
	else
		_num_registrazione := (select concat('R', substring(date_part('year',current_timestamp)::text,3),'S', lpad((max(substring(num_registrazione,5,10)::integer)+1)::text , 6, '0'))
	                              from registro_scarico_recapito  );
	end if;

end if;

INSERT INTO public.registro_scarico_recapito(
	entered, enteredby, note_hd, id_carico, num_registrazione,
        indice,codice_destinatario, dosi_vendute, dosi_distrutte, documento_commerciale_uscita, data_registrazione_uscita)
VALUES (current_timestamp, _user_id, note_hd, _id_carico, _num_registrazione,
	indice, _codice_destinatario, _dosi_vendute, _dosi_distrutte, _documento_commerciale_uscita, _data_registrazione_uscita) 
returning id into id_registro;

return id_registro;

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.upsert_registro_scarico_recapiti(integer, integer, integer, text, text, integer, integer, text)
  OWNER TO postgres;

-- Function: public.get_registro_carico_scarico_seme_excel(integer, text, text)

-- DROP FUNCTION public.get_registro_carico_scarico_seme_excel(integer, text, text);

CREATE OR REPLACE FUNCTION public.get_registro_carico_scarico_seme_excel(
    IN _id_registro integer,
    IN _data_inizio text,
    IN _data_fine text)
  RETURNS TABLE(num_registrazione text, data_produzione text, codice_mittente text, id_specie integer, id_razza integer, nome_capo text, matricola_riproduttore_maschio text, identificazione_partita text, id_tipo_seme integer, dosi_prodotte integer, dosi_acquistate integer, data_vendita text, documento_trasporto_entrata text, codice_destinatario text, dosi_vendute integer, dosi_distrutte integer, documento_trasporto_uscita text) AS
$BODY$
DECLARE
	r RECORD;
BEGIN
		if _data_inizio = '' and _data_fine ='' then
			return query
				select a.num_registrazione, a.data_produzione, a.codice_mittente, a.id_specie, a.id_razza, a.nome_capo, a.matricola_riproduttore_maschio, a.identificazione_partita,
				       a.id_tipo_seme, a.dosi_prodotte, a.dosi_acquistate, a.data_vendita, a.documento_trasporto_entrata, a.codice_destinatario, a.dosi_vendute, a.dosi_distrutte, a.documento_trasporto_uscita
				       from 
					(      
					      select s.num_registrazione, s.data_produzione , s.codice_mittente, s.id_specie, s.id_razza, s.nome_capo, s.matricola_riproduttore_maschio, s.id as id_carico,
					       s.identificazione_partita, s.id_tipo_seme, s.dosi_prodotte, s.dosi_acquistate, ''::text as data_vendita, s.documento_trasporto_entrata,
					       ''::text as codice_destinatario, 0 as dosi_vendute, 0 as dosi_distrutte, ''::text as documento_trasporto_uscita
						from registro_carico_seme s 
						where s.id_registro = _id_registro 
						and s.trashed_date is null and s.enabled

						union
			
						select sc.num_registrazione, ''::text , ''::text, -1,-1, ''::text, ''::text, sc.id_carico,
					       ''::text, -1, 0, 0, sc.data_vendita, ''::text,
						sc.codice_destinatario, sc.dosi_vendute, sc.dosi_distrutte, sc.documento_trasporto_uscita
						from registro_scarico_seme sc 
						join registro_carico_seme ca on ca.id = sc.id_carico
						where ca.id_registro = _id_registro		
						and sc.enabled and sc.trashed_date is null
					
					)a order by id_carico;
			
		
		else

			return query
			(      
				select s.num_registrazione, s.data_produzione , s.codice_mittente, s.id_specie, s.id_razza, s.nome_capo, s.matricola_riproduttore_maschio,
			       s.identificazione_partita, s.id_tipo_seme, s.dosi_prodotte, s.dosi_acquistate, ''::text, s.documento_trasporto_entrata,
			       ''::text, 0, 0, ''::text
			        from registro_carico_seme s 
				where s.id_registro = _id_registro 
				and s.trashed_date is null and s.enabled
				and to_date(s.data_produzione,'yyyy-mm-dd') >= to_date(_data_inizio,'yyyy-mm-dd') and to_date(s.data_produzione,'yyyy-mm-dd') <= to_date(_data_fine,'yyyy-mm-dd') 
				order by s.num_registrazione, s.indice
			)
			union
		
			(
				select sc.num_registrazione, ''::text , ''::text, -1,-1, ''::text, ''::text,
				       ''::text, -1, 0, 0, sc.data_vendita, ''::text,
				       sc.codice_destinatario, sc.dosi_vendute, sc.dosi_distrutte, sc.documento_trasporto_uscita
				from registro_scarico_seme sc 
				join registro_carico_seme ca on ca.id = sc.id_carico
				where ca.id_registro = _id_registro		
				and sc.enabled and sc.trashed_date is null
				and to_date(sc.data_vendita,'yyyy-mm-dd') >= to_date(_data_inizio,'yyyy-mm-dd') and to_date(sc.data_vendita,'yyyy-mm-dd') <= to_date(_data_fine,'yyyy-mm-dd') 
				order by sc.id_carico, sc.num_registrazione, sc.indice
			);
		end if;
		
		
		

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_registro_carico_scarico_seme_excel(integer, text, text)
  OWNER TO postgres;






CREATE OR REPLACE FUNCTION public.get_registro_carico_scarico_giacenza(IN _id_registro integer)
  RETURNS TABLE(nome_capo text, matricola text, id_tipo_seme integer, dosi_prodotte integer, dosi_acquistate integer, dosi_vendute integer, dosi_distrutte integer, giacenza integer) AS
$BODY$
DECLARE  
	tipo_registro integer;
	
BEGIN 
	tipo_registro := -1;		
	tipo_registro := (select id_tipologia_registro from registro_carico_scarico_istanze ist where ist.id = _id_registro);
	
	if tipo_registro > 0 then 

		if (tipo_registro = 1) then -- seme

			return query 
		
				SELECT 
				g.nome_capo,
				g.matricola, 
				g.id_tipo_seme, 
				sum(g.dosi_prodotte)::integer as dosi_prodotte, 
				sum(g.dosi_acquistate)::integer as dosi_acquistate, 
				sum(g.dosi_vendute)::integer as dosi_vendute, 
				sum(g.dosi_distrutte)::integer as dosi_distrutte,
				((sum(g.dosi_prodotte) + sum(g.dosi_acquistate)) - (sum(g.dosi_vendute) + sum(g.dosi_distrutte)))::integer as giacenza

				FROM (

					select 

					c.id, c.matricola_riproduttore_maschio as matricola, c.nome_capo, c.id_tipo_seme as id_tipo_seme, c.dosi_prodotte as dosi_prodotte, c.dosi_acquistate as dosi_acquistate, 0 as dosi_vendute, 0 as dosi_distrutte

					from registro_carico_seme c

					where c.id_registro = _id_registro and c.trashed_date is null and c.enabled

					UNION

					select 
					s.id, c.matricola_riproduttore_maschio, c.nome_capo, c.id_tipo_seme, 0, 0, s.dosi_vendute, s.dosi_distrutte

					from registro_scarico_seme s
					join registro_carico_seme c on c.id = s.id_carico
					where c.id_registro = _id_registro and s.trashed_date is null and s.enabled
					and c.trashed_date is null and c.enabled
					and s.trashed_date is null and s.enabled 
					order by matricola, id_tipo_seme, dosi_prodotte desc, dosi_acquistate desc, dosi_vendute desc, dosi_distrutte desc
					) g
					group by g.matricola, g.nome_capo, g.id_tipo_seme;
		
		else -- recapiti
			return query
			
				
				SELECT 
				g.nome_capo,
				g.matricola, 
				g.id_tipo_seme, 
				sum(g.dosi_prodotte)::integer as dosi_prodotte, 
				sum(g.dosi_acquistate)::integer as dosi_acquistate, 
				sum(g.dosi_vendute)::integer as dosi_vendute, 
				sum(g.dosi_distrutte)::integer as dosi_distrutte,
				((sum(g.dosi_prodotte) + sum(g.dosi_acquistate)) - (sum(g.dosi_vendute) + sum(g.dosi_distrutte)))::integer as giacenza

				FROM (

						select 

						c.id, c.nome_capo as nome_capo, coalesce(c.matricola_riproduttore_maschio, c.matricola_riproduttore_femmina) as matricola, c.id_tipo_seme as id_tipo_seme, 0, 0 as dosi_prodotte,
						c.dosi_acquistate as dosi_acquistate, 0 as dosi_vendute, 0 as dosi_distrutte
						
						from registro_carico_recapito c

						where c.id_registro = _id_registro and c.trashed_date is null and c.enabled

						UNION
						
						select c.id, c.nome_capo as nome_capo, coalesce(c.matricola_riproduttore_maschio, c.matricola_riproduttore_femmina), c.id_tipo_seme, 0, 0, 
						0 as dosi_prodotte, s.dosi_vendute, s.dosi_distrutte
						from registro_carico_recapito c
						join registro_scarico_recapito s on s.id_carico = c.id
						where c.id_registro = _id_registro and c.trashed_date is null and c.enabled
						and s.trashed_date is null and s.enabled
				      ) g
				group by g.matricola, g.nome_capo, g.id_tipo_seme;

		end if;
		
	end if;
	
		
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_registro_carico_scarico_giacenza(integer)
  OWNER TO postgres;


-- Function: public.get_info_registro_carico_scarico_anagrafica(integer, text, integer)

-- DROP FUNCTION public.get_info_registro_carico_scarico_anagrafica(integer, text, integer);

  
CREATE OR REPLACE FUNCTION public.get_info_registro_carico_scarico_capo(
    IN _matricola text,
    IN _id_registro integer)
  RETURNS TABLE(matricola text, nome_capo text, id_specie integer, id_razza integer) AS
$BODY$
DECLARE  
	tipo_registro integer;
	
BEGIN 
	tipo_registro := -1;
	tipo_registro := (select distinct ist.id_tipologia_registro 
					from registro_carico_scarico_istanze ist 
					where ist.trashed_date is null and ist.id = _id_registro);
	if tipo_registro > 0 then 

		if (tipo_registro = 1) then -- seme

			return query 
		
select 
r.matricola_riproduttore_maschio, r.nome_capo, r.id_specie, r.id_razza
from registro_carico_seme r where r.id_registro = _id_registro and r.matricola_riproduttore_maschio ilike _matricola
and r.enabled and r.trashed_date is null limit 1;

		else -- recapiti
			return query
			
select 
COALESCE(r.matricola_riproduttore_maschio, r.matricola_riproduttore_femmina) as matricola, r.nome_capo, r.id_specie , r.id_razza
from registro_carico_recapito r where r.id_registro = _id_registro 
and (r.matricola_riproduttore_maschio ilike _matricola or  r.matricola_riproduttore_femmina ilike _matricola)
and r.enabled and r.trashed_date is null limit 1;

		end if;
		
	end if;
	
		
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_info_registro_carico_scarico_capo(text, integer)
  OWNER TO postgres;
  
-----------------------------------------
  
select * from public.dbi_insert_utente_ext(
    'test_registro'::character varying,
    md5('test_registro')::character varying,
    10000011,
    6567,
    6567 ,
    true,
    -1,
    'Test'::character varying,
    'Registro'::character varying,
    'RGSTST86H78F839K'::character varying,
    ''::text ,
    ''::text,
    ''::character varying,
    ''::character varying,
    null::timestamp with time zone,
    'true',
    'false',
    'U150102AV000019',
    -1,
    '',
    '',
    -1,
    '',
    '',
    -1,
    '',
    '',
    '')
  
select * from public.dbi_insert_utente_ext(
    'test_registro2'::character varying,
    md5('test_registro2')::character varying,
    10000010,
    6567,
    6567 ,
    true,
    -1,
    'Test'::character varying,
    'Registro2'::character varying,
    'RGSTST66H78F839B'::character varying,
    ''::text ,
    ''::text,
    ''::character varying,
    ''::character varying,
    null::timestamp with time zone,
    'true',
    'false',
    'U150102AV000019',
    -1,
    '',
    '',
    -1,
    '',
    '',
    -1,
    '',
    '',
    '')

-- Function: public_functions.suap_stabilimenti_trasportatori_distributori_per_proprietario(text)

-- DROP FUNCTION public_functions.suap_stabilimenti_trasportatori_distributori_per_proprietario(text);

CREATE OR REPLACE FUNCTION public_functions.get_centri_riproduzione_per_numero_registrazione(IN numreg text)
  RETURNS TABLE(partita_iva text, ragione_sociale text, codice_fiscale_proprietario text, nome_proprietario text, cognome_proprietario text, id_stabilimento integer, id_operatore integer, sede_legale text, numero_registrazione text, codice_ufficiale_esistente text, 
  sede_operativa text, id_stato integer) AS
$BODY$
DECLARE

idStabilimento integer;

BEGIN

select o.id_stabilimento into idStabilimento
from opu_operatori_denormalizzati_view o
left join opu_stabilimento st on st.id = o.id_stabilimento
where st.numero_registrazione_precedente ilike trim(numreg) and o.id_stato !=4;

IF idStabilimento is null or idStabilimento<= 0 THEN

select o.id_stabilimento into idStabilimento
from opu_operatori_denormalizzati_view o
where o.numero_registrazione ilike trim(numreg) or o.codice_ufficiale_esistente ilike trim(numreg)
and o.id_stato !=4;

END IF;

FOR partita_iva, ragione_sociale,codice_fiscale_proprietario ,nome_proprietario ,cognome_proprietario ,
   id_stabilimento ,id_operatore  ,sede_legale ,numero_registrazione ,codice_ufficiale_esistente , sede_operativa ,id_stato
IN

select distinct o.partita_iva ,o.ragione_sociale,o.cf_rapp_sede_legale,o.nome_rapp_sede_legale,o.cognome_rapp_sede_legale
,o.id_stabilimento,o.id_opu_operatore,
case when stab_id_attivita = 2 and impresa_id_tipo_impresa = 1 then trim(indirizzo_rapp_sede_legale)
when stab_id_attivita = 2 and impresa_id_tipo_impresa != 1 then trim(indirizzo_sede_legale)
when stab_id_attivita = 1 then trim(indirizzo_sede_legale) end ,
o.numero_registrazione,
o.codice_ufficiale_esistente,
case when stab_id_attivita = 2 and impresa_id_tipo_impresa = 1 then trim(indirizzo_rapp_sede_legale)
when stab_id_attivita = 2 and impresa_id_tipo_impresa != 1 then trim(indirizzo_sede_legale)
when stab_id_attivita = 1 then trim(indirizzo_stab) end as sede_stabilimento,o.id_stato
from opu_operatori_denormalizzati_view o
where o.id_stabilimento = idStabilimento

LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public_functions.get_centri_riproduzione_per_numero_registrazione(text)
  OWNER TO postgres;

  -- Function: public.get_info_registro_carico_scarico_anagrafica(integer, text, integer)

-- DROP FUNCTION public.get_info_registro_carico_scarico_anagrafica(integer, text, integer);

CREATE OR REPLACE FUNCTION public.get_info_registro_carico_scarico_anagrafica(
    IN _riferimento_id integer,
    IN _riferimento_id_nome_tab text,
    IN _tipologia_registro integer)
  RETURNS TABLE(riferimento_id integer, riferimento_id_nome_tab text, ragione_sociale text, numero_registrazione text, id_tipologia text) AS
$BODY$
DECLARE  
 id_tipo_anagrafica integer;  
 id_recapito integer;
 id_centro_seme integer;
BEGIN 

id_tipo_anagrafica = -1;
id_recapito = -1;
id_centro_seme = -1;

id_recapito := (select distinct r.riferimento_id
from ricerche_anagrafiche_old_materializzata r
where r.riferimento_id = _riferimento_id and r.riferimento_id_nome_tab = _riferimento_id_nome_tab
and concat('', r.codice_macroarea,'-', r.codice_aggregazione,'-', r.codice_attivita) in 
('CG-NAZ-R-007')); -- recapiti

id_centro_seme := (select distinct r.riferimento_id
from ricerche_anagrafiche_old_materializzata r 
where r.riferimento_id = _riferimento_id and r.riferimento_id_nome_tab = _riferimento_id_nome_tab
and concat('', r.codice_macroarea,'-', r.codice_aggregazione,'-', r.codice_attivita) in 
('CG-NAZ-B', -- centro di produzione embrioni
'CG-NAZ-R-003' -- centro produzione materiale seminale
)); 

if (id_centro_seme > 0 and id_recapito is null) then
	return query select distinct r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale::text, r.n_reg::text, '1' from ricerche_anagrafiche_old_materializzata r where 
	                    r.riferimento_id = _riferimento_id and r.riferimento_id_nome_tab = _riferimento_id_nome_tab;
elsif (id_recapito > 0 and id_centro_seme is null) then
	return query select distinct r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale::text, r.n_reg::text, '2' from ricerche_anagrafiche_old_materializzata r where 
	                    r.riferimento_id = _riferimento_id and r.riferimento_id_nome_tab = _riferimento_id_nome_tab;
elsif (id_recapito > 0 and id_centro_seme > 0) then
	return query select distinct r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale::text, r.n_reg::text, '1,2' from ricerche_anagrafiche_old_materializzata r where 
	                    r.riferimento_id = _riferimento_id and r.riferimento_id_nome_tab = _riferimento_id_nome_tab;
else
	return query select distinct r.riferimento_id, r.riferimento_id_nome_tab, r.ragione_sociale::text, r.n_reg::text, '-1' from ricerche_anagrafiche_old_materializzata r where 
	                    r.riferimento_id = _riferimento_id and r.riferimento_id_nome_tab = _riferimento_id_nome_tab;					
end if;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_info_registro_carico_scarico_anagrafica(integer, text, integer)
  OWNER TO postgres;

 CREATE OR REPLACE FUNCTION public.get_registro_carico_scarico_recapiti_excel(
    IN _id_registro integer,
    IN _data_inizio text,
    IN _data_fine text)
  RETURNS TABLE(num_registrazione text, data_registrazione_entrata text, codice_mittente text, id_specie integer, id_razza integer, nome_capo text, matricola_riproduttore_maschio text, matricola_riproduttore_femmina text, identificazione_partita text, id_tipo_seme integer, dosi_acquistate integer, documento_commerciale_entrata text, data_registrazione_uscita text, codice_destinatario text, dosi_vendute integer, dosi_distrutte integer, documento_commerciale_uscita text) AS
$BODY$
DECLARE
	r RECORD;
BEGIN
		if _data_inizio = '' and _data_fine ='' then
			return query
				select a.num_registrazione, a.data_registrazione_entrata, a.codice_mittente, a.id_specie, a.id_razza, a.nome_capo, a.matricola_riproduttore_maschio, a.matricola_riproduttore_femmina, 
				a.identificazione_partita, a.id_tipo_seme, a.dosi_acquistate, a.documento_commerciale_entrata,  a.data_registrazione_uscita, a.codice_destinatario, a.dosi_vendute, a.dosi_distrutte, a.documento_commerciale_uscita
				       from 
					(      
					       select s.num_registrazione, s.data_registrazione_entrata , s.codice_mittente, s.id_specie, s.id_razza, s.nome_capo, s.matricola_riproduttore_maschio, s.matricola_riproduttore_femmina, s.id as id_carico,
					       s.identificazione_partita, s.id_tipo_seme, s.dosi_acquistate, s.documento_commerciale_entrata, '' as data_registrazione_uscita,
					       ''::text as codice_destinatario, 0 as dosi_vendute, 0 as dosi_distrutte, ''::text as documento_commerciale_uscita
						from registro_carico_recapito s 
						where s.id_registro = _id_registro 
						and s.trashed_date is null and s.enabled

						union
						
						select sc.num_registrazione, ''::text , ''::text, -1,-1, '', '', '', sc.id_carico,
					        '',  -1, 0, '', sc.data_registrazione_uscita,
						sc.codice_destinatario, sc.dosi_vendute, sc.dosi_distrutte, sc.documento_commerciale_uscita
						from registro_scarico_recapito sc 
						join registro_carico_recapito ca on ca.id = sc.id_carico
						where ca.id_registro = _id_registro		
						and sc.enabled and sc.trashed_date is null
					
					)a order by id_carico;
			
		
		else
			return query
				select a.num_registrazione, a.data_registrazione_entrata, a.codice_mittente, a.id_specie, a.id_razza, a.nome_capo, a.matricola_riproduttore_maschio, a.matricola_riproduttore_femmina, 
				a.identificazione_partita, a.id_tipo_seme, a.dosi_acquistate, a.documento_commerciale_entrata,  a.data_registrazione_uscita, a.codice_destinatario, a.dosi_vendute, a.dosi_distrutte, a.documento_commerciale_uscita
				       from 
					(      
					       select s.num_registrazione, s.data_registrazione_entrata , s.codice_mittente, s.id_specie, s.id_razza, s.nome_capo, s.matricola_riproduttore_maschio, s.matricola_riproduttore_femmina, s.id as id_carico,
					       s.identificazione_partita, s.id_tipo_seme, s.dosi_acquistate, s.documento_commerciale_entrata, '' as data_registrazione_uscita,
					       ''::text as codice_destinatario, 0 as dosi_vendute, 0 as dosi_distrutte, ''::text as documento_commerciale_uscita
						from registro_carico_recapito s 
						where s.id_registro = _id_registro 
						and to_date(s.data_registrazione_entrata,'yyyy-mm-dd') >= to_date(_data_inizio,'yyyy-mm-dd') 
						and to_date(s.data_registrazione_entrata,'yyyy-mm-dd') <= to_date(_data_fine,'yyyy-mm-dd') 
						and s.trashed_date is null and s.enabled

						union
						
						select sc.num_registrazione, ''::text , ''::text, -1,-1, '', '', '', sc.id_carico,
					        '',  -1, 0, '', sc.data_registrazione_uscita,
						sc.codice_destinatario, sc.dosi_vendute, sc.dosi_distrutte, sc.documento_commerciale_uscita
						from registro_scarico_recapito sc 
						join registro_carico_recapito ca on ca.id = sc.id_carico
						where ca.id_registro = _id_registro	
						and to_date(sc.data_registrazione_uscita,'yyyy-mm-dd') >= to_date(_data_inizio,'yyyy-mm-dd') 
						and to_date(sc.data_registrazione_uscita,'yyyy-mm-dd') <= to_date(_data_fine,'yyyy-mm-dd') 
						and sc.enabled and sc.trashed_date is null
						and ca.trashed_date is null and ca.enabled
					
					)a order by id_carico;
		
				
		end if;
		
		
		

 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_registro_carico_scarico_recapiti_excel(integer, text, text)
  OWNER TO postgres
  
-- FIX DESCRIZIONI  
  
update lookup_razze_equini_centri_riproduzione set description = upper(description);
update lookup_razze_equini_centri_riproduzione set description = 'ACHAL TEKE' where description ilike '%Achal%';

-- lanciare per verifica
alter table registro_carico_recapito drop column num_registrazione_stab