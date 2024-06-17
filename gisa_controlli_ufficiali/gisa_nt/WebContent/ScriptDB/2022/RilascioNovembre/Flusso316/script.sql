drop TABLE public.log_rettifica_campione;
CREATE TABLE public.log_rettifica_campione
(
  id serial,
  id_campione integer,
  id_motivazione_campione integer,
  id_piano_motivazione_campione integer,
  id_matrice_foglia integer,
  id_analiti_foglie text,
  entered timestamp,
  id_utente integer
)
WITH (
  OIDS=FALSE
);


CREATE OR REPLACE FUNCTION public.rettifica_campione(
_id_campione integer,
_id_motivazione integer, 
_id_motivazione_piano integer,
_id_matrice integer,
_id_analiti text,
_id_utente integer
    )
  RETURNS text AS
$BODY$
   DECLARE
msg text ;
cammino_matrice text;
cammino_analita text;
id_analiti text;
r int;
arr_split_analiti int[];
id_log integer;
 
   BEGIN
   	id_analiti := (select replace(replace(_id_analiti,'[',''),']',''));
	raise info 'lista analiti: %', id_analiti;
	--scrivo nel log
	insert into log_rettifica_campione(id_campione,
					   id_motivazione_campione,
					   id_piano_motivazione_campione,
	                                   id_matrice_foglia, 
	                                   id_analiti_foglie, 
	                                   entered, 
	                                   id_utente) values
	                                   (_id_campione,
	                                   (select motivazione_campione from ticket where ticketid = _id_campione), 
	                                   (select motivazione_piano_campione from ticket where ticketid = _id_campione), 
	                                   (select id_matrice from matrici_campioni where id_campione =  _id_campione), 
	                                   (select string_agg(analiti_id::text,',') from analiti_campioni where id_campione = _id_campione), 
	                                    current_timestamp, 
	                                    _id_utente) returning id into id_log;
	                                    
	raise info 'inserito record di log con id: %', id_log;
	--aggiornamento motivo campione
	update ticket set modifiedby = _id_utente,  note_internal_use_only= concat_ws('***',note_internal_use_only,'Aggiornamento motivo campione per funzione Rettifica Campione (valori precedenti:'||motivazione_piano_campione||'(piano),'||motivazione_campione||'(motivo))'),  
	motivazione_campione= _id_motivazione , motivazione_piano_campione = _id_motivazione_piano, modified = current_timestamp where ticketid = _id_campione;

	--aggiorno matrici e analiti
	cammino_matrice := (select path_descrizione from matrici_view where matrice_id = _id_matrice);
	raise info 'matrice: %', cammino_matrice;
	delete from matrici_campioni where id_campione = _id_campione;
	insert into matrici_campioni(id_campione, id_matrice, cammino, note) values (_id_campione, _id_matrice, cammino_matrice, 'Inserimento record per rettifica campione');
	delete from analiti_campioni where id_campione = _id_campione;
	-- inserimento analiti multipli
	arr_split_analiti := (select regexp_split_to_array(id_analiti,',')::int[]);
	FOREACH r IN ARRAY arr_split_analiti
	LOOP
		raise info 'analita:%', r;
		cammino_analita := (select concat(c.nome, '->', b.nome, '->', a.nome) from analiti a left join analiti b on a.id_padre = b.analiti_id
				    left join analiti c on b.id_padre = c.analiti_id
			            where a.analiti_id = r);
		insert into analiti_campioni (id_campione, analiti_id, cammino, note) values (_id_campione,r, cammino_analita, 'Inserimento record per rettifica campione');
	END LOOP;
	
    msg = 'OK. Modifica eseguita';
	
    RETURN msg;
   END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.rettifica_campione(integer, integer, integer, integer, text, integer)
  OWNER TO postgres;

insert into permission(category_id, permission, permission_view, description, level, enabled, active) values(35,'campioni-rettifica',true, 'Rettifica campione per Germana Colarusso', 11, true, true)
insert into role_permission (role_id, permission_id, role_view) values (31,838,true);

--select * from log_rettifica_campione 
--select * from matrici_campioni where id_campione = 1710790
--select * from analiti_campioni where id_campione = 1710790
--select motivazione_campione from ticket where ticketid = 1710790
-- Function: public.verifica_campione_rettificabile(integer)

-- DROP FUNCTION public.verifica_campione_rettificabile(integer);

CREATE OR REPLACE FUNCTION public.verifica_campione_rettificabile(_id_campione integer)
  RETURNS text AS
$BODY$
DECLARE
	msg text;
	codice_preaccettazione text;
	esito_analiti text;
	anno_campione double precision;
BEGIN
	msg :='';
	esito_analiti := (select string_agg(esito_id::text, ',') from analiti_campioni  where id_campione=_id_campione);
	anno_campione := (select date_part('year', assigned_date) from ticket where ticketid = _id_campione);
	codice_preaccettazione := (
					select 
					concat(cp.prefix, cp.anno, cp.progres)
					from 
					ticket campione 
					left join preaccettazione.associazione_preaccettazione_entita apa on apa.riferimento_entita = campione.ticketid::text and apa.tipo_entita = 'C' and apa.trashed_date is null
					left join preaccettazione.stati_preaccettazione sp on sp.id = apa.id_stati and sp.trashed_date is null
					left join preaccettazione.codici_preaccettazione cp on cp.id = sp.id_preaccettazione and cp.trashed_date is null
					where campione.tipologia = 2 and campione.trashed_date is null
					and campione.ticketid = _id_campione
				);
	raise info '%', length(codice_preaccettazione);
	raise info '%', esito_analiti;
	raise info '%', length(esito_analiti);
	if(anno_campione != (select date_part('year', current_date))) then
		msg = 'ATTENZIONE. PER CAMPIONI PREGRESSI LA RETTIFICA NON PUO'' ESSERE EFFETTUATA. ';
		else if (codice_preaccettazione is null or codice_preaccettazione = '') then
			raise info 'entro qui';
			msg = concat_ws('', msg, 'ATTENZIONE. PER MANCANZA DI PREACCETTAZIONE LA RETTIFICA DEL CAMPIONE NON PUO'' ESSERE EFFETTUATA. ');
		else 
			msg = concat('',msg,'');
		end if;

		if (esito_analiti is not null and length(esito_analiti) > 0) then 
			msg = concat_ws('', msg, 'ATTENZIONE. IN PRESENZA DI ESITI SUGLI ANALITI, LA RETTIFICA DEL CAMPIONE NON PUO'' ESSERE EFFETTUATA. ');
		else
			msg = concat('',msg,'');
		end if;
		
	end if;

 RETURN msg;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;
ALTER FUNCTION public.verifica_campione_rettificabile(integer)
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.get_lista_motivazione_piano_campione(IN _id_campione integer)
  RETURNS TABLE(code integer, description text, default_item boolean, level integer, enabled boolean) AS
  $BODY$
BEGIN
	return query
	select lp.code, lp.description::text, lp.default_item, lp.level, lp.enabled 
	from ticket campione 
	join ticket cu on campione.id_controllo_ufficiale::integer = cu.ticketid and campione.tipologia=2 and cu.tipologia=3
	join tipocontrolloufficialeimprese tcu on tcu.idcontrollo = cu.ticketid
	join lookup_piano_monitoraggio lp on lp.code = tcu.pianomonitoraggio and tcu.enabled 
	where campione.ticketid = _id_campione and cu.trashed_date is null;
		
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;

  
  CREATE TABLE cf_permission
(id serial PRIMARY KEY,
codice_fiscale text,
permission text, -- In alternativa, usiamo lo stesso nome del permesso in permission? Es. "campioni-rettifica"
enabled boolean default true,
entered timestamp without time zone default now(),
note_hd text);

insert into cf_permission(codice_fiscale, permission) values ('CLRGMN79R70A509H', 'campioni-rettifica-view');

-- bonifica per uniformità con registro trasgressori
insert into cf_permission(codice_fiscale, permission) values ('BRRVCN85M19A024K', 'sanzioni_modifica_trasgressori-view');
insert into cf_permission(codice_fiscale, permission) values ('VRZMDA62R14E506G', 'sanzioni_modifica_trasgressori-view');


CREATE OR REPLACE FUNCTION public.has_cf_permission(
    _cf text,
    _permission text)
  RETURNS boolean AS
$BODY$
DECLARE  
_id integer;
BEGIN 

select id into _id from cf_permission where trim(_cf) ilike trim(codice_fiscale) and trim(_permission) ilike trim(permission) and enabled limit 1;

IF _id > 0 THEN
return true;
ELSE
return false;
END IF;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

- Function: public.get_lista_motivazione_campione()

-- DROP FUNCTION public.get_lista_motivazione_campione();

CREATE OR REPLACE FUNCTION public.get_lista_motivazione_campione()
  RETURNS TABLE(code integer, description text, default_item boolean, level integer, enabled boolean) AS
$BODY$
BEGIN
	return query
	select 
	l.code,
	case when l.enabled then l.description else l.description || '(X)' end as description, l.default_item, l.level, true from lookup_tipo_ispezione l
	where 
	(lower(l.codice_interno) in ('22a', '24a', '41a', '42a', '43a'))
	or (lower(l.codice_interno) = '2a' and l.enabled)
	order by level asc, l.description asc;
	
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_lista_motivazione_campione()
  OWNER TO postgres;

