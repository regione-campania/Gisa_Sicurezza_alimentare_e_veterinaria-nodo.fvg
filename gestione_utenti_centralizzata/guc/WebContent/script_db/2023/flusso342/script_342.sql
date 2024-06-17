create schema opzioni;

create table opzioni.lookup_qualifiche(
	id serial primary key,
	codice text,
	descrizione text,
	enabled boolean default true
);

insert into opzioni.lookup_qualifiche( codice, descrizione)
values ('1','Dirigente Unita'' Operativa Complessa'),
('2','Dirigente Unita'' Operativa Semplice'),
('3','Dirigente Unita'' Operativa Semplice Dipartimentale'),
('4','Dirigente'),
('5','Specialista ambulatoriale'),
('6','Tecnico della Prevenzione'),
('7','Tecnologo Alimentare');
('8','Amministrativo');

create table opzioni.lookup_profili_professionali(
	id serial primary key,
	codice text,
	descrizione text,
	enabled boolean default true
);

insert into opzioni.lookup_profili_professionali(codice, descrizione)
values ('1','Medico Veterinario'),
('2','Medico'),
('3','Biologo'),
('4','Chimico'),
('5','Tecnologo alimentare'),
('6','Tecnico della Prevenzione'),
('7','Altro'),
('8','Amministrativo');

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION opzioni.get_lista_qualifiche(
	codice_ text DEFAULT NULL::text)
    RETURNS TABLE(id integer, codice text, descrizione text)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
BEGIN

return query
select lq.id, lq.codice, lq.descrizione from opzioni.lookup_qualifiche lq
where codice_ is null or codice_ = '' or codice_ = lq.codice
and enabled = 'true';

END;
$BODY$;

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION opzioni.get_lista_profili_professionali(
	codice_ text DEFAULT NULL::text)
    RETURNS TABLE(id integer, codice text, descrizione text)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
BEGIN

return query
select lpp.id, lpp.codice, lpp.descrizione from opzioni.lookup_profili_professionali lpp
where codice_ is null or codice_ = '' or codice_ = lpp.codice
and enabled = 'true';

END;
$BODY$;

----------------------------------------------------------------

create table opzioni.utente_qualifica (
	id serial primary key,
	numero_richiesta text,
	user_id int,
	id_qualifica int,
	enabled boolean default true
);

create table opzioni.utente_profilo_professionale (
	id serial primary key,
	numero_richiesta text,
	user_id int,
	id_profilo_professionale int,
	altro_profilo text,
	enabled boolean default true
);

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION opzioni.insert_utente_qualifica(
	user_id_ int, id_qualifica_ int)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
	
AS $BODY$

DECLARE
BEGIN
	
	insert into opzioni.utente_qualifica( user_id, id_qualifica )
	values (user_id_, id_qualifica_);
	
	return 'OK';

END;
$BODY$;

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION opzioni.insert_utente_profilo_professionale(
	user_id_ int, id_profilo_professionale_ int)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
	
AS $BODY$

DECLARE
BEGIN
	
	insert into opzioni.utente_profilo_professionale( user_id, id_profilo_professionale )
	values (user_id_, id_profilo_professionale_);
	
	return 'OK';

END;
$BODY$;

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION opzioni.insert_richiesta_qualifica(
	numero_richiesta_ text, id_qualifica_ int)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
	
AS $BODY$

DECLARE
BEGIN
	
	insert into opzioni.utente_qualifica( numero_richiesta, id_qualifica )
	values (numero_richiesta_, id_qualifica_);
	
	return 'OK';

END;
$BODY$;

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION opzioni.insert_richiesta_profilo_professionale(numero_richiesta_ text, id_profilo_professionale_ integer, altro_profilo_ text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE
BEGIN
	
	insert into opzioni.utente_profilo_professionale( numero_richiesta, id_profilo_professionale, altro_profilo)
	values (numero_richiesta_, id_profilo_professionale_, altro_profilo_);
	
	return 'OK';

END;
$function$
;

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION opzioni.get_info_utente(
	codice_fiscale_ text,
	endpoint_ text,
	ruolo_ integer,
	asl_ integer)
    RETURNS TABLE(id_qualifica integer, qualifica text, id_profilo_professionale integer, profilo_professionale text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
	user_id_ int;
	query_ text;
BEGIN
	
	query_ := 'select distinct u.id ' 
			||'from guc_utenti u '
			||'join asl a on u.asl_id = a.id '
			||'left join listaruoli gr on (gr.id_utente = u.id and gr.endpoint ilike ''gisa'') '
			||'left join listaruoli br on (br.id_utente = u.id and br.endpoint ilike ''bdu'') '
			||'left join listaruoli vr on (vr.id_utente = u.id and vr.endpoint ilike ''vam'') '
			||'where u.enabled = ''1'' '
			||'and (gr.ruolo_integer > 0 or br.ruolo_integer > 0 or vr.ruolo_integer > 0 ) and u.username not like ''_cni_%'' '
			||'and codice_fiscale = $1';
			
	IF endpoint_ ilike '%gisa%' THEN
		query_ := query_ || ' and gr.ruolo_integer = $2';
	END IF;
	
	IF endpoint_ ilike '%bdu%' THEN
		query_ := query_ || ' and br.ruolo_integer = $2';
	END IF;
	
	IF endpoint_ ilike '%vam%' THEN
		query_ := query_ || ' and vr.ruolo_integer = $2';
	END IF;
	
	query_ := query_ || ' and a.id = $3';
	
	execute query_
	into user_id_
	using codice_fiscale_, ruolo_, asl_;
	
	return query
	select q.id_qualifica
	, lq.descrizione
	, p.id_profilo_professionale
	, case when p.id_profilo_professionale != 7 then lp.descrizione
		else p.altro_profilo
	  end	from opzioni.utente_qualifica q
	join opzioni.utente_profilo_professionale p on p.user_id = q.user_id
	join opzioni.lookup_qualifiche lq on lq.id = q.id_qualifica
	join opzioni.lookup_profili_professionali lp on lp.id = p.id_profilo_professionale
	where q.user_id = user_id_
	and q.enabled = 'true'
	and p.enabled = 'true';

END;
$BODY$;

--------------------------------------------------------------------

CREATE OR REPLACE FUNCTION opzioni.get_info_richiesta(
	numero_richiesta_ text)
    RETURNS TABLE(id_qualifica integer, qualifica text, id_profilo_professionale integer, profilo_professionale text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
BEGIN

	return query
	select q.id_qualifica
	, lq.descrizione
	, p.id_profilo_professionale
	, case when p.id_profilo_professionale != 7 then lp.descrizione
		else p.altro_profilo
	  end
	from opzioni.utente_qualifica q
	join opzioni.utente_profilo_professionale p on p.numero_richiesta = q.numero_richiesta
	join opzioni.lookup_qualifiche lq on lq.id = q.id_qualifica
	join opzioni.lookup_profili_professionali lp on lp.id = p.id_profilo_professionale
	where q.numero_richiesta = numero_richiesta_;

END;
$BODY$;

--------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.login_get_endpoint_by_cf_3(
	_cf text)
    RETURNS TABLE(endpoint text, ruolo_id int, ruolo_string text, asl_id int, asl text, username text, num_registrazione_stab text, piva text, canilebdu_description text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
BEGIN

FOR 
endpoint, ruolo_id, ruolo_string, asl_id, asl, username, num_registrazione_stab, piva, canilebdu_description 
IN

WITH q as (
select 
case when gu.asl_id = 201 then 'AVELLINO' 
when gu.asl_id = 202 then 'BENEVENTO' 
when gu.asl_id = 203 then 'CASERTA'        
when gu.asl_id = 204 then 'NAPOLI 1 CENTRO'        
when gu.asl_id = 205 then 'NAPOLI 2 NORD' 
when gu.asl_id = 206 then 'NAPOLI 3 SUD' 
when gu.asl_id = 207 then 'SALERNO' 
ELSE 'TUTTE' end as asl,
gr.endpoint as ep,
gr.ruolo_integer as ruolo_id,
gu.asl_id as asl_int,
* 

from guc_ruoli gr 
join guc_utenti gu on gr.id_utente = gu.id  
left join extended_option ext on ext.user_id = gr.id_utente and ext.key=concat(gr.endpoint , '_access') and ext.endpoint=gr.endpoint where gr.ruolo_string not in ( 'GIAVA' ) and ((ext.endpoint in ('Gisa', 'Gisa_ext') and ext.val='true') or ext.val is null) and gr.ruolo_integer > 0 and gr.trashed is null 

and id_utente  in ( SELECT id FROM GUC_UTENTI WHERE ENABLED AND upper(CODICE_FISCALE) = upper(_cf) ) 

and (

(gr.endpoint not in ('Gisa', 'Gisa_ext')) 
OR
((gr.endpoint, gr.id_utente) in (select e.endpoint, e.user_id from extended_option e where e.key = e.endpoint||'_access' and e.val = 'true')
)
)
order by gr.endpoint, gr.ruolo_string) 

select distinct on (q.ep,q.ruolo_id,q.ruolo_string,q.asl_int,q.asl,q.user_id,q.canilebdu_description,q.num_registrazione_stab,q.piva) ep as endpoint, q.ruolo_id, q.ruolo_string, q.asl_int, q.asl, q.username, q.num_registrazione_stab,q.piva,q.canilebdu_description from q order by ep
			
					 
LOOP
     RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

----------------------------------------

CREATE OR REPLACE FUNCTION opzioni.processa_info(
	numero_richiesta_ text,
	user_id_ integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE
BEGIN
	
	update opzioni.utente_qualifica
	set enabled = false
	where user_id = user_id_;
	
	update opzioni.utente_qualifica
	set user_id = user_id_,
	enabled = true
	where numero_richiesta = numero_richiesta_;
	
	update opzioni.utente_profilo_professionale
	set enabled = false
	where user_id = user_id_;
	
	update opzioni.utente_profilo_professionale
	set user_id = user_id_,
	enabled = true
	where numero_richiesta = numero_richiesta_;
	
	return 'OK';

END;
$BODY$;

-------------------------------------

CREATE OR REPLACE FUNCTION opzioni.get_info_utente_by_username(
	username_ text,
	endpoint_ text,
	ruolo_ integer,
	asl_ integer)
    RETURNS TABLE(id_qualifica integer, qualifica text, id_profilo_professionale integer, profilo_professionale text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
	user_id_ int;
	query_ text;
BEGIN
	
	query_ := 'select distinct u.id ' 
			||'from guc_utenti u '
			||'join asl a on u.asl_id = a.id '
			||'left join listaruoli gr on (gr.id_utente = u.id and gr.endpoint ilike ''gisa'') '
			||'left join listaruoli br on (br.id_utente = u.id and br.endpoint ilike ''bdu'') '
			||'left join listaruoli vr on (vr.id_utente = u.id and vr.endpoint ilike ''vam'') '
			||'where u.enabled = ''1'' '
			||'and (gr.ruolo_integer > 0 or br.ruolo_integer > 0 or vr.ruolo_integer > 0 ) and u.username not like ''_cni_%'' '
			||'and username = $1';
			
	IF endpoint_ ilike '%gisa%' THEN
		query_ := query_ || ' and gr.ruolo_integer = $2';
	END IF;
	
	IF endpoint_ ilike '%bdu%' THEN
		query_ := query_ || ' and br.ruolo_integer = $2';
	END IF;
	
	IF endpoint_ ilike '%vam%' THEN
		query_ := query_ || ' and vr.ruolo_integer = $2';
	END IF;
	
	query_ := query_ || ' and a.id = $3';
	
	execute query_
	into user_id_
	using username_, ruolo_, asl_;
	
	return query
	select q.id_qualifica
	, lq.descrizione
	, p.id_profilo_professionale
	, case when p.id_profilo_professionale != 7 then lp.descrizione
		else p.altro_profilo
	  end
	from opzioni.utente_qualifica q
	join opzioni.utente_profilo_professionale p on p.user_id = q.user_id
	join opzioni.lookup_qualifiche lq on lq.id = q.id_qualifica
	join opzioni.lookup_profili_professionali lp on lp.id = p.id_profilo_professionale
	where q.user_id = user_id_
	and q.enabled = 'true'
	and p.enabled = 'true';

END;
$BODY$;

---------------------------------------

CREATE OR REPLACE FUNCTION opzioni.collega_info(
	numero_richiesta_ text,
	username_ text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE
	qualifica_ text;
	profilo_professionale_ text;
	contact_id_ int;
	n int;
BEGIN
	select * from dblink((select * from conf.get_pg_conf('GISA')),'select contact_id from access_ where username = ''' || username_ || ''' ') as t1 (contact_id int) into contact_id_;
	select * from dblink((select * from conf.get_pg_conf('GISA')),'select count(*) from lista_utenti_centralizzata where contact_id = ''' || contact_id_ || ''' ') as t1( n int) into n;
	IF (n = 1) THEN
	--recupara info della richiesta
		select qualifica, profilo_professionale from opzioni.get_info_richiesta(numero_richiesta_)
		into qualifica_ , profilo_professionale_;
	--dblink update access_dati GISA where username_
		perform dblink((select * from conf.get_pg_conf('GISA')), 'update access_dati set qualifica = '''|| qualifica_ ||''', profilo_professionale = '''|| profilo_professionale_ ||''' where user_id = (select user_id from access_ where username ='''|| username_ ||''')');
		return 'OK';
	ELSE
	--recupera info pregresse
		select * from dblink((select * from conf.get_pg_conf('GISA')),'select qualifica, profilo_professionale from lista_utenti_centralizzata where contact_id = ''' || contact_id_ || ''' order by username')
		as t1(qualifica_ text, profilo_professionale_ text) into qualifica_, profilo_professionale_;
	--dblink update access_dati GISA where username_
		perform dblink((select * from conf.get_pg_conf('GISA')), 'update access_dati set qualifica = '''|| qualifica_ ||''', profilo_professionale = '''|| profilo_professionale_ ||''' where user_id = (select user_id from access_ where username ='''|| username_ ||''')');
		return 'OK';
	END IF;
	

END;
$BODY$;

-----------------------------------------

CREATE OR REPLACE FUNCTION opzioni.modifica_info(
	numero_richiesta_ text,
	username_ text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE
	qualifica_ text;
	profilo_professionale_ text;
	lista_username_ text;
BEGIN
	--recupare tutti gli username
		select '('||string_agg(''''||username||'''',','::text)||')' from guc_utenti where codice_fiscale = (select codice_fiscale from guc_utenti where username = username_) into lista_username_;
	--recupara info della richiesta
		select qualifica, profilo_professionale from opzioni.get_info_richiesta(numero_richiesta_)
		into qualifica_ , profilo_professionale_;
	--dblink update access_dati GISA where username_
		perform dblink((select * from conf.get_pg_conf('GISA')), 'update access_dati set qualifica = '''|| qualifica_ ||''', profilo_professionale = '''|| profilo_professionale_ ||''' where user_id in (select user_id from access_ where username in '|| lista_username_ ||')');
		return 'OK';
	

END;
$BODY$;