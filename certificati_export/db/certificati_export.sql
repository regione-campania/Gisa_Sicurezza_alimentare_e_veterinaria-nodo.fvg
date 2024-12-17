--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: anagrafica; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA anagrafica;


ALTER SCHEMA anagrafica OWNER TO postgres;

--
-- Name: bck; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA bck;


ALTER SCHEMA bck OWNER TO postgres;

--
-- Name: conf; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA conf;


ALTER SCHEMA conf OWNER TO postgres;

--
-- Name: log; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA log;


ALTER SCHEMA log OWNER TO postgres;

--
-- Name: logs; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA logs;


ALTER SCHEMA logs OWNER TO postgres;

--
-- Name: srv; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA srv;


ALTER SCHEMA srv OWNER TO postgres;

--
-- Name: srv_functions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA srv_functions;


ALTER SCHEMA srv_functions OWNER TO postgres;

--
-- Name: tmp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tmp;


ALTER SCHEMA tmp OWNER TO postgres;

--
-- Name: types; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA types;


ALTER SCHEMA types OWNER TO postgres;

--
-- Name: ui; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ui;


ALTER SCHEMA ui OWNER TO postgres;

--
-- Name: um; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA um;


ALTER SCHEMA um OWNER TO postgres;

--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


--
-- Name: ag_result_type; Type: TYPE; Schema: types; Owner: postgres
--

CREATE TYPE types.ag_result_type AS (
	esito boolean,
	valore text,
	msg character varying,
	info character varying,
	err_msg character varying
);


ALTER TYPE types.ag_result_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: result_type; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.result_type (
    esito boolean,
    valore bigint,
    msg character varying,
    info character varying
);


ALTER TABLE types.result_type OWNER TO postgres;

--
-- Name: del_lista(character varying, bigint); Type: FUNCTION; Schema: anagrafica; Owner: postgres
--

CREATE FUNCTION anagrafica.del_lista(v character varying, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;   
	proc_name varchar;  
	v_j json;
	n integer;
	c integer;

	begin
	proc_name:='anagrafica.lista';
	raise notice '%', v;
 
	v_j:=v::json;
	raise notice 'id: %', v_j->>'id';

  	select count(*) into c from public.modulo_campi mc where   id_anagrafica_lista = (v_j->>'id')::bigint;
  
  	raise notice '%', c;
 	if c > 0 then
    	 
    	ret.esito:=false;
		ret.msg:='Anagrafica associata ad un certificato';

	else
		delete from anagrafica.lista	where id= (v_j->>'id')::bigint;
		GET DIAGNOSTICS n = ROW_COUNT;
		if n > 0 then
    		ret.esito:=true;	
    		ret.msg:='Cancellazione avvenuta con successo';
		else
			ret.esito:=false;
			ret.msg:='Nessuna lista cancellata';
		end if;
	 	
		ret:=ui.build_ret(ret,proc_name,(v_j->>'id')::bigint);
	
	end if;
  
	
	return ret;
	end;
END
$$;


ALTER FUNCTION anagrafica.del_lista(v character varying, idtransazione bigint) OWNER TO postgres;

--
-- Name: delete_lista_record(json, bigint); Type: FUNCTION; Schema: anagrafica; Owner: postgres
--

CREATE FUNCTION anagrafica.delete_lista_record(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	proc_name varchar;
	ret  types.result_type;
	idlista bigint;
    
	begin
		proc_name:='anagrafica.delete_lista_record';
		idlista:=(v->>'id_lista')::bigint;
	    
		
	 
	    delete from anagrafica.lista_valori  
	    where id_lista=idlista and --id=ANY(v->'lista');--in  json_array_elements(v->>'lista')    ;
		id in (
			select  (value::varchar)::bigint from 
			json_array_elements(v->'lista') );
		--update agenda.lista_import set dt=current_timestamp where id=idlista;
		ret.esito:=true;
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION anagrafica.delete_lista_record(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_gestori_liste(json, bigint); Type: FUNCTION; Schema: anagrafica; Owner: postgres
--

CREATE FUNCTION anagrafica.get_gestori_liste(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; 
	proc_name varchar;
	rt json;
 

	begin
		proc_name:='anagrafica.gestori_liste';
	
		select json_agg(row_to_json(c.*)) into rt  from (select * from  anagrafica.gestore  ) c;

		raise notice '%',rt;	
		if rt is null then
			ret.esito:=false;	
    	    ret:=ag_ui.build_ret(ret,proc_name, 'Valori non trovati');
    		ret.info:=null; 
    	else
    		ret.esito:=true;
 			ret.msg:=null; 		 		
 			ret.info:=rt;

		end if;
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION anagrafica.get_gestori_liste(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_liste(json, bigint); Type: FUNCTION; Schema: anagrafica; Owner: postgres
--

CREATE FUNCTION anagrafica.get_liste(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
    tipo_gestore varchar;
	proc_name varchar;
	condizione_where varchar;
	rt json;

	begin
		proc_name:='anagrafica.lista';
	raise notice '%', v_j->>'id_asl';

	    if(v_j->>'id_asl') is null then
	    	select json_agg(row_to_json(c.*)) into rt from (
		     select *   from  anagrafica.vw_liste t where  t.tipo_gestore ='OSA'
		    ) c;
		else 
	    	select json_agg(row_to_json(c.*)) into rt from (
		     select *   from  anagrafica.vw_liste t 
		    ) c;
		end if;
		 
 
	
		raise notice '%', json_array_length(rt);
 
	    if rt is null then
			ret.esito:=false;	
    	    ret:=ui.build_ret(ret,proc_name, 'Valori non trovati');
    		ret.info:=null; 
    	else
    		ret.esito:=true;
 			ret.msg:=null; 		
 			ret.info:=rt;
 		

		end if;
		
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION anagrafica.get_liste(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_valori_by_id_lista(json, bigint); Type: FUNCTION; Schema: anagrafica; Owner: postgres
--

CREATE FUNCTION anagrafica.get_valori_by_id_lista(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	 
	proc_name varchar;
	rt json;
 
	begin
		proc_name:='anagrafica.get_valori_by_id_lista';
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		 
	
		select json_agg(row_to_json(c.*)) into rt from (
			select * from anagrafica.vw_liste_valori where (id_lista = (v_j->>'id_lista')::bigint or v_j->>'id_lista' is null) 
			and (id_stabilimento=(v_j->>'id_stabilimento')::bigint  or v_j->>'id_stabilimento' is null)
		) c;
	
		raise notice '%', json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='Nessuna valore nella lista';
    		ret.info:='[]'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION anagrafica.get_valori_by_id_lista(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: ins_lista(character varying, bigint); Type: FUNCTION; Schema: anagrafica; Owner: postgres
--

CREATE FUNCTION anagrafica.ins_lista(v character varying, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
 
declare
	ret types.result_type%ROWTYPE;
	proc_name varchar;
	R  anagrafica.lista%ROWTYPE; 
	v_j json;
	n bigint;
	
	begin
	proc_name:='anagrafica.ins_lista';
	raise notice '%', v;
	v_j:=v::json;
	R.id             := nextval('public.lista_id_seq');
	R.descr  := v_j->>'descr';
	R.gestore:=v_j->>'gest';
	R.rif_tipo_prodotto:=v_j->>'legatoTipoProd';
 
    raise notice 'gestore=%',R.gestore;
    raise notice 'rifTipoProdotto=%',R.rif_tipo_prodotto;
    raise notice 'descr=%',R.descr;
    raise notice 'id=%',R.id;
    insert into anagrafica.lista  values (R.*);
   	GET DIAGNOSTICS n = ROW_COUNT;

	if n > 0 then
	 	 ret.esito:=true;	
    	 ret:=ui.build_ret(ret,proc_name,R.id);
         ret.info='0';
	 else
	  	raise notice 'if errore';
	 	ret.esito:=false;
	 	ret.msg:='Nessuna lista inserita';
 	end if;

 
	return ret;
	end;
END
$$;


ALTER FUNCTION anagrafica.ins_lista(v character varying, idtransazione bigint) OWNER TO postgres;

--
-- Name: load_import_lista(json, bigint); Type: FUNCTION; Schema: anagrafica; Owner: postgres
--

CREATE FUNCTION anagrafica.load_import_lista(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	proc_name varchar;
	ret  types.result_type;
	idlista bigint;
	begin
		proc_name:='anagrafica.load_import_lista';
		idlista:=(v->>'id_lista')::bigint;
		delete from anagrafica.lista_valori where id_lista=idlista;
		raise notice '%', v;

	    insert into anagrafica.lista_valori (id,id_lista, valore,traduzione)
		 select nextval('anagrafica.lista_valori_id_seq'),idlista,valore,traduzione from 
			
			(select valore,traduzione from 
			  (select * from 
			    json_populate_recordset(null::record,v->'lista') as   (valore varchar,traduzione varchar)
			  ) a 
		    ) b;
		
		--update agenda.lista_import set dt=current_timestamp where id=idlista;
		ret.esito:=true;
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION anagrafica.load_import_lista(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: load_import_record(json, bigint); Type: FUNCTION; Schema: anagrafica; Owner: postgres
--

CREATE FUNCTION anagrafica.load_import_record(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	proc_name varchar;
	ret  types.result_type;
	idlista bigint;
    idStab bigint;

	begin
	proc_name:='anagrafica.load_import_record';
	idlista:=(v->>'id_lista')::bigint;
	idStab:=(v->>'id_stabilimento')::bigint;
	
	raise notice '%', (v->>'lista');
		raise notice '%', v;

	    insert into anagrafica.lista_valori (id,id_lista, valore,traduzione,id_node_denominazione_prodotto,id_stabilimento)
		 select nextval('anagrafica.lista_valori_id_seq'),
		 idlista,valore,traduzione,tipoprodotto,idStab from 
			
			(select valore,traduzione ,tipoprodotto from 
			  (select * from 
			    json_populate_recordset(null::record,v->'lista') as   (valore varchar,traduzione varchar,tipoprodotto bigint)
			  ) a 
		    ) b;
		
		--update agenda.lista_import set dt=current_timestamp where id=idlista;
		ret.esito:=true;
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION anagrafica.load_import_record(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: end_op(character varying, bigint, character varying); Type: FUNCTION; Schema: log; Owner: postgres
--

CREATE FUNCTION log.end_op(pname character varying, idtransazione bigint, v character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
begin
	declare 
	begin
		insert into log.call_logs   values (nextval('log.call_logs_id_seq'),idtransazione,pname,'END',CLOCK_TIMESTAMP(),v);
		if length(v)>0 then
			update log.operazioni set ret=v,ts_end=CLOCK_TIMESTAMP()
			where id_transazione=idtransazione and ret is null and procedura=pname;
		else
			update log.operazioni set ret=v,ts_end=CLOCK_TIMESTAMP()
			where id_transazione=idtransazione and ret is null and procedura=pname;
		end if;
		return(currval('log.operazioni_id_seq'));
	end;
END
$$;


ALTER FUNCTION log.end_op(pname character varying, idtransazione bigint, v character varying) OWNER TO postgres;

--
-- Name: get_id_transazione(bigint); Type: FUNCTION; Schema: log; Owner: postgres
--

CREATE FUNCTION log.get_id_transazione(iduser bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
begin
	declare R_T log.transazioni%ROWTYPE;
	begin
		R_T.id=nextval('log.transazioni_id_seq');
		R_T.id_user=iduser;
		R_T.ts:=current_timestamp;
		insert into log.transazioni values (R_T.*);
		return R_T.id;
	end;
END
$$;


ALTER FUNCTION log.get_id_transazione(iduser bigint) OWNER TO postgres;

--
-- Name: get_id_transazione(bigint, character varying); Type: FUNCTION; Schema: log; Owner: postgres
--

CREATE FUNCTION log.get_id_transazione(iduser bigint, titolo character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
begin
	declare R_T log.transazioni%ROWTYPE;
	begin
		R_T.id=nextval('log.transazioni_id_seq');
		R_T.id_user=iduser;
		R_T.ts:=current_timestamp;
		R_T.descr:=titolo;
		insert into log.transazioni values (R_T.*);
		return R_T.id;
	end;
END
$$;


ALTER FUNCTION log.get_id_transazione(iduser bigint, titolo character varying) OWNER TO postgres;

--
-- Name: op(character varying, bigint, character varying, json, timestamp without time zone, bigint, character varying); Type: FUNCTION; Schema: log; Owner: postgres
--

CREATE FUNCTION log.op(pname character varying, idtransazione bigint, param character varying, v json, tsstart timestamp without time zone, idtrattato bigint DEFAULT '-1'::integer, tipooperazione character varying DEFAULT ''::character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
begin
	declare 
	begin
		--insert into gds_log.call_logs   values (nextval('gds_log.call_logs_id_seq'),idtransazione,pname,'START',CLOCK_TIMESTAMP(),param);
		insert into log.operazioni  
			(id,id_transazione,procedura,fase,ts_start,ts_end,ts_transazione,val,id_trattato,ret) 
		values 
			(nextval('log.operazioni_id_seq'),idtransazione,pname,tipooperazione,tsstart,CLOCK_TIMESTAMP(),current_timestamp,param,idtrattato,
    		v::varchar);

    	return(currval('log.operazioni_id_seq'));
	end;
END
$$;


ALTER FUNCTION log.op(pname character varying, idtransazione bigint, param character varying, v json, tsstart timestamp without time zone, idtrattato bigint, tipooperazione character varying) OWNER TO postgres;

--
-- Name: start_op(character varying, bigint, character varying, bigint); Type: FUNCTION; Schema: log; Owner: postgres
--

CREATE FUNCTION log.start_op(pname character varying, idtransazione bigint, param character varying, idtrattato bigint DEFAULT '-1'::integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
begin
	declare 
	begin
		insert into log.call_logs   values (nextval('log.call_logs_id_seq'),idtransazione,pname,'START',CLOCK_TIMESTAMP(),param);
		insert into log.operazioni  (id,id_transazione,procedura,fase,ts_start,ts_transazione,val,id_trattato) values 
	(nextval('log.operazioni_id_seq'),idtransazione,pname,'START',CLOCK_TIMESTAMP(),current_timestamp,param,idtrattato);
		return(currval('log.operazioni_id_seq'));
	end;
END
$$;


ALTER FUNCTION log.start_op(pname character varying, idtransazione bigint, param character varying, idtrattato bigint) OWNER TO postgres;

--
-- Name: get_utente_info_from_gisa(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_utente_info_from_gisa(_username text, _password text, _codice_fiscale text DEFAULT NULL::text) RETURNS TABLE(nome text, ruolo text, id_ruolo bigint, id_utente bigint, username text, codice_interno_struttura bigint, id_asl integer)
    LANGUAGE plpgsql
    AS $$
begin
	return QUERY
	select t.nome, t.ruolo, t.id_ruolo, t.id_utente, t.username, t.codice_interno_struttura, t.id_asl from 
	   public.dblink('dbname=gisa_fvg'||(select valore from conf.conf where descr = 'postfix_ambiente' )||'
					port=5432 
					host=127.0.0.1
					user=postgres'::text, format('select * from public.get_utente_info where (username=%L and (password=md5(%L) or password=%L)) or md5(''GISA-''||codice_fiscale)=%L ', _username, _password , _password, _codice_fiscale)) t(nome text, ruolo text, id_ruolo bigint, id_utente bigint, username text, codice_interno_struttura bigint, id_asl integer, "password" text, codice_fiscale text);
END
$$;


ALTER FUNCTION public.get_utente_info_from_gisa(_username text, _password text, _codice_fiscale text) OWNER TO postgres;

--
-- Name: get_dati(character varying, character varying, bigint, json); Type: PROCEDURE; Schema: srv; Owner: postgres
--

CREATE PROCEDURE srv.get_dati(IN operazione character varying, IN v character varying, IN idutente bigint, INOUT joutput json)
    LANGUAGE plpgsql
    AS $$
begin
	declare
		proc_name varchar;
	begin
				raise notice '=====V %',v;
		proc_name:='srv.get_dati';
		call srv_functions.get_dati(operazione,v,idutente,joutput);
	end;
END
$$;


ALTER PROCEDURE srv.get_dati(IN operazione character varying, IN v character varying, IN idutente bigint, INOUT joutput json) OWNER TO postgres;

--
-- Name: get_id_transazione(bigint); Type: FUNCTION; Schema: srv; Owner: postgres
--

CREATE FUNCTION srv.get_id_transazione(iduser bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
begin
	declare R_T log.transazioni%ROWTYPE;
	proc_name varchar;
	id_op bigint;

	begin
		proc_name:='srv.get_id_transazione';
	    R_T.id:=log.get_id_transazione(iduser);
		id_op:=log.start_op(proc_name, R_T.id ,'');
		id_op:=log.end_op(proc_name, R_T.id , '');
		return R_T.id;

	end;
END
$$;


ALTER FUNCTION srv.get_id_transazione(iduser bigint) OWNER TO postgres;

--
-- Name: ins_evento(character varying, bigint); Type: FUNCTION; Schema: srv; Owner: postgres
--

CREATE FUNCTION srv.ins_evento(v character varying, idtransazione bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
	declare
	proc_name varchar;
	ret types.result_type%ROWTYPE;
	id_op bigint;
	rt character varying;
		text_msg1 varchar;	
		text_msg2 varchar;	
		text_msg3 varchar;	
		text_msg4 varchar;
begin
	proc_name:='srv.ins_evento';
	id_op:=log.start_op(proc_name,idtransazione ,v);
	ret:= agenda.ins_evento(v,idtransazione) ;
	ret:=ui.build_ret(ret,proc_name, ret.valore);
	rt:=row_to_json(ret);
	id_op:=log.end_op(proc_name,idtransazione ,rt::varchar);
	return rt;
		exception when others then
			GET STACKED DIAGNOSTICS text_msg1 = MESSAGE_TEXT,
                          			text_msg2 = PG_EXCEPTION_DETAIL,
                          			text_msg3 = PG_EXCEPTION_HINT,
                         			text_msg4 = PG_EXCEPTION_CONTEXT;
			ret.esito:=false;
			ret.valore:= null;
			ret.msg:=coalesce(text_msg1,'')|| chr(10) ||coalesce(text_msg2,'')|| chr(10)  ||coalesce(text_msg3,'')|| chr(10)  ||coalesce(text_msg4,'');
			rt:=row_to_json(ret);
			id_op:=log.end_op(proc_name,idtransazione ,rt);
			return rt;
end;
end
$$;


ALTER FUNCTION srv.ins_evento(v character varying, idtransazione bigint) OWNER TO postgres;

--
-- Name: upd_dati(character varying, character varying, bigint, json); Type: PROCEDURE; Schema: srv; Owner: postgres
--

CREATE PROCEDURE srv.upd_dati(IN operazione character varying, IN v character varying, IN idutente bigint, INOUT joutput json)
    LANGUAGE plpgsql
    AS $$

	declare
		proc_name varchar;
		text_msg1 varchar;	
	text_msg2 varchar;	
	text_msg3 varchar;	
	text_msg4 varchar;
	ret types.result_type;
	begin
		proc_name:='srv.upd_dati';
		call srv_functions.upd_dati(operazione,v,idutente,joutput);

	end;

$$;


ALTER PROCEDURE srv.upd_dati(IN operazione character varying, IN v character varying, IN idutente bigint, INOUT joutput json) OWNER TO postgres;

--
-- Name: close_attivita_tariffazione(character varying); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.close_attivita_tariffazione(_input character varying) RETURNS types.ag_result_type
    LANGUAGE plpgsql
    AS $$
	declare 
		ret types.ag_result_type;
		_id_evento bigint;
		v json;
	begin
		v := _input::json;
		
		raise notice 'select * from agenda.upd_rilevazione_attivita(%::varchar, 1)', _input;
	
	 	select * into ret from 
        dblink('dbname=mdgm_fvg'||(select valore from conf.conf where descr = 'postfix_ambiente' )||' port=5432 host=127.0.0.1 user=postgres'::text, 
        'select * from trf.upd_rilevazione_attivita('''||_input||'''::json, 1)') 
        t(esito boolEAN , Valore text ,msg varchar ,info varchar ,err_msg varchar);
	  
        select * into ret from 
        dblink('dbname=mdgm_fvg'||(select valore from conf.conf where descr = 'postfix_ambiente' )||' port=5432 host=127.0.0.1 user=postgres'::text, 
        'select * from trf.upd_att_close(''{"id_attivita": ['||(v->>'id_trf_attivita')::bigint||']}''::json, 1)') 
        t(esito boolEAN , Valore text ,msg varchar ,info varchar ,err_msg varchar);
       
       raise notice 'ret %', ret;
       return ret;
        
	END;
$$;


ALTER FUNCTION srv_functions.close_attivita_tariffazione(_input character varying) OWNER TO postgres;

--
-- Name: close_evento_agenda(bigint, boolean); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.close_evento_agenda(_id_certificato bigint, effettuata boolean DEFAULT true) RETURNS types.ag_result_type
    LANGUAGE plpgsql
    AS $$
	declare 
		inizio timestamp;
		fine timestamp;
		ret types.ag_result_type;
		_id_evento bigint;
		v json;
	begin
		
		select coalesce(upper(orario_controllo), upper(orario_proposto)) into fine from public.certificati_compilati cc where id = _id_certificato;
		select coalesce(lower(orario_controllo), lower(orario_proposto)) into inizio from public.certificati_compilati cc where id = _id_certificato;
		select id_evento_calendario into _id_evento from public.certificati_compilati cc where id = _id_certificato;
		
		raise notice 'inizio %', inizio;
		raise notice 'fine %', fine;
		raise notice '_id_evento %', _id_evento;

	   raise notice 'select * from agenda.upd_evento(''{"id": %, "inizio": "%", "fine": "%", "extendedProps": {"effettuata": true} }''::varchar, 1)',_id_evento, inizio, fine;
	
        select * into ret from 
        dblink('dbname=mdgm_fvg'||(select valore from conf.conf where descr = 'postfix_ambiente' )||' port=5432 host=127.0.0.1 user=postgres'::text, 
        'select * from agenda.upd_evento(''{"id": '|| _id_evento ||', "start": "'|| inizio ||'", "end": "'|| fine ||'", "extendedProps": {"effettuata": '||(effettuata)::text||'} }''::varchar, 1)') 
        t(esito boolEAN , Valore text ,msg varchar ,info varchar ,err_msg varchar);
       
       raise notice 'ret %', ret;
       return ret;
        
        
        
	END;
$$;


ALTER FUNCTION srv_functions.close_evento_agenda(_id_certificato bigint, effettuata boolean) OWNER TO postgres;

--
-- Name: del_access_stabilimento(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.del_access_stabilimento(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; -- START
	id_op bigint;   
	proc_name varchar; -- END
	n integer;
	idaccessstabilimento integer;
	begin
	proc_name:='srv_functions.del_access_stabilimento';

	raise notice '%', v_j;
	--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
	raise notice 'id_cal: %', v_j->>'id_access_stabilimento';

	delete from um.access_stabilimenti
		where id = (v_j->>'id_access_stabilimento')::bigint
		and lower(validita) > current_timestamp;
	
	GET DIAGNOSTICS n = ROW_COUNT;

	if n > 0 then
    	ret.esito:=true;	

	else
		ret.esito:=false;
		ret.msg:='Nessuna delega cancellata';
	end if;
 	
	ret:=ui.build_ret(ret,proc_name,(v_j->>'id_access_stabilimento')::bigint);
	return ret;
	end;
END
$$;


ALTER FUNCTION srv_functions.del_access_stabilimento(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: del_denominazione_prodotti(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.del_denominazione_prodotti(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; 
	id_op bigint;   
	proc_name varchar;
	rt json;
	R_T public.vw_tree_nodes_up_denominazione_prodotti%ROWTYPE;

	begin
		proc_name:='srv_functions.del_denominazione_prodotti';
	
	
--		delete from tree_nodes where id_tree = (v->>'id_tree')::bigint and id = (v->>'id_node')::bigint;

	    update   tree_nodes  set data_scadenza =now() 
		where id in(	   		    
		    select id from tree_nodes    where
		    (id_tree = (v->>'id_tree')::bigint and id= (v->>'id_node')::bigint ) or 
		    (id_tree = (v->>'id_tree')::bigint and id_node_parent  = (v->>'id_node')::bigint )
		);
		
    	ret.esito:=true;
 		ret.msg:=null;
	 	ret.info:=null;

	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.del_denominazione_prodotti(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: delete_evento_agenda(bigint); Type: FUNCTION; Schema: srv_functions; Owner: gisa_fvg
--

CREATE FUNCTION srv_functions.delete_evento_agenda(_id_certificato bigint) RETURNS types.ag_result_type
    LANGUAGE plpgsql
    AS $$
	declare 
		inizio timestamp;
		fine timestamp;
		ret types.ag_result_type;
		_id_evento bigint;
		v json;
	begin
		
		select id_evento_calendario into _id_evento from public.certificati_compilati cc where id = _id_certificato;
		
		raise notice '_id_evento %', _id_evento;

	   raise notice 'select * from agenda.upd_ev_elimina(''{"id_evento": [%]}''::json, 1)',_id_evento;
	
        select * into ret from 
        dblink('dbname=mdgm_fvg'||(select valore from conf.conf where descr = 'postfix_ambiente' )||' port=5432 host=127.0.0.1 user=postgres'::text, 
        'select * from agenda.upd_ev_elimina(''{"id_evento": ['|| _id_evento ||']}''::json, 1)') 
        t(esito boolEAN , Valore text ,msg varchar ,info varchar ,err_msg varchar);
       
       raise notice 'ret %', ret;
       return ret;
        
        
        
	END;
$$;


ALTER FUNCTION srv_functions.delete_evento_agenda(_id_certificato bigint) OWNER TO gisa_fvg;

--
-- Name: duplica_certificato(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.duplica_certificato(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; -- START
	idcertificato bigint;
	idcertificato_new bigint;
	proc_name text;
	begin
	proc_name:='srv_functions.upd_access_stabilimento';

	raise notice '%', v_j;
	idcertificato = v_j->>'id_certificato';

	raise notice 'idcertificato da duplicare: %', idcertificato;
	
	insert into public.certificati_compilati (id_access, id_modulo, id_stabilimento, id_stato_certificato_compilato, descr, file)
	select id_access, id_modulo, id_stabilimento, (select id from types.stati_certificato_compilato where is_bozza),
	descr||'_dup', file from public.certificati_compilati where id = idcertificato
	returning id into idcertificato_new;

	insert into public.campo_valori(id_certificato_compilato, id_campo, valore, id_campo_ref, "index", id_tipo_prodotto, riporta_tipo_prodotto)
	select idcertificato_new, id_campo, valore, id_campo_ref, "index" , id_tipo_prodotto, riporta_tipo_prodotto 
	from public.campo_valori 
	where id_certificato_compilato = idcertificato;

	ret.esito:=true;
	ret.info := '{"id_nuovo_certificato": '||idcertificato_new||'}';
	ret.msg:='Nessuna delega inserita';

	return ret;
	end;
END
$$;


ALTER FUNCTION srv_functions.duplica_certificato(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: elimina_certificato(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.elimina_certificato(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	proc_name varchar;
	ret types.result_type%ROWTYPE;
	rt character varying;
	id_op bigint;
	text_msg1 varchar;	
	text_msg2 varchar;	
	text_msg3 varchar;	
	text_msg4 varchar;
begin
	
	update public.certificati set validita = tsrange(lower(validita)::timestamp, current_timestamp::timestamp) 
	where id = (v->>'id_certificato')::bigint;
	
	ret.esito:=true;
	ret.valore:= null;
	rt:=row_to_json(ret);
	id_op:=log.end_op(proc_name,idtransazione ,rt::varchar);
	return ret;
		exception when others then
			GET STACKED DIAGNOSTICS text_msg1 = MESSAGE_TEXT,
                          			text_msg2 = PG_EXCEPTION_DETAIL,
                          			text_msg3 = PG_EXCEPTION_HINT,
                         			text_msg4 = PG_EXCEPTION_CONTEXT;
			ret.esito:=false;
			ret.valore:= null;
			ret.msg:=coalesce(text_msg1,'')|| chr(10) ||coalesce(text_msg2,'')|| chr(10)  ||coalesce(text_msg3,'')|| chr(10)  ||coalesce(text_msg4,'');
			rt:=row_to_json(ret);
			id_op:=log.end_op(proc_name,idtransazione ,rt);
			return ret;
end;
end
$$;


ALTER FUNCTION srv_functions.elimina_certificato(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_access_stabilimenti(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_access_stabilimenti(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; 
	id_op bigint;   
	idstabilimento bigint;
	proc_name varchar;
	rt json;

	begin
		proc_name:='srv_functions.get_access_stabilimenti';
		raise notice 'V_J %',v_j;
		raise notice 'USER_INFO %',v_j->>'user_info';
		idstabilimento:=v_j->'id_stabilimento';
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		raise notice 'idaccess: %', idstabilimento;
		select json_agg(row_to_json(a.*)) into rt from (
			select * from um.vw_access_stabilimenti  a
			where id_stabilimento =idstabilimento
			and id_access_delegato != id_access_responsabile
			order by valido_da
		) a;
	
		raise notice '%',json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='accessi non trovati';
    		ret.info:='{}'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_access_stabilimenti(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_certificati(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_certificati(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	proc_name varchar;
	rt json;
	idcountry bigint;
	begin
		proc_name:='srv_functions.get_certificati';
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		raise notice 'V=%',v;
		idcountry:=v->'id_country';
		raise notice 'IDCOUNTRY %',idcountry;
		select json_agg(row_to_json(c.*)) into rt from (
			select * from public.vw_certificati where id_country=idcountry and upper_inf(validita) 
		) c;
	
		raise notice '%', json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='certificati non esistenti';
    		ret.info:='{}'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_certificati(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_contacts(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_contacts(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	proc_name varchar;
	rt json;

	begin
		proc_name:='srv_functions.get_contacts';
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		
		select json_agg(row_to_json(c.*)) into rt from (
			select c.nome, c.cognome, c.codice_fiscale, a.id as id_access
			from um.contact c
			join um."access" a on a.id_contact = c.id
			join um.role r on r.id = a.id_role
			where r.descr = 'OPERATORE_OSA'
		) c;
	
		raise notice '%', json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='Contatti non esistenti';
    		ret.info:='{}'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_contacts(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_countries(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_countries(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	proc_name varchar;
	rt json;

	begin
		proc_name:='srv_functions.get_countries';
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		
		select json_agg(row_to_json(c.*)) into rt from (
			select * from public.vw_countries
		) c;
	
		raise notice '%', json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='Paesi non esistenti';
    		ret.info:='{}'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_countries(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_dati(character varying, character varying, bigint, json); Type: PROCEDURE; Schema: srv_functions; Owner: postgres
--

CREATE PROCEDURE srv_functions.get_dati(IN operazione character varying, IN v character varying, IN idutente bigint, INOUT joutput json)
    LANGUAGE plpgsql
    AS $$

declare 	
	idtransazione bigint;
	proc_name varchar;
	id_op bigint;  
	id_risorsa bigint;
	ret types.result_type;
	ret_2 types.result_type;
	ret_3 types.result_type;

	ret_eventi types.result_type;
	ret_calendari types.result_type;
	retj json;
	text_msg1 varchar;	
	text_msg2 varchar;	
	text_msg3 varchar;	
	text_msg4 varchar;
	str_conf varchar;
	ts timestamp;
id bigint;
	fallito bool;
j_user_info json;
begin 
			raise notice '=====V %',v;
	ts:=CLOCK_TIMESTAMP();
	proc_name:='srv_functions.get_dati';
	idtransazione:= log.get_id_transazione(idutente,proc_name);
	id_op:=log.op(proc_name,idtransazione,v,null,ts,-1,operazione);
	--select row_to_json(public.get_utente_info_from_gisa(idutente)) into j_user_info;
	raise notice 'idutente %', idutente;
	select row_to_json(a.*) into j_user_info from
		(
			select  a.id_access,a.nome  ,a.cognome,json_agg( p.descr_permission) permessi from um.vw_access a 
													join um.vw_role_permission p on p.id_role=a.id_role
			where a.id_access=idutente
			group by 1,2,3
		) a;
	raise notice 'j_user_info %', j_user_info;
	if j_user_info is not null then
		raise notice '=====V %',v;
		if v is null or v='' or v='{}' then
			v:= '{"user_info":'||j_user_info||'}';
		else
			v:= substring(v,1,length(v)-1)||',"user_info":'||j_user_info||'}';
		end if;
	end if;
	raise notice 'USER_DATA %', v;
	id_op:=log.op(proc_name,idtransazione,v,null,ts,-1,operazione);
   	COMMIT;
 
	begin 
	fallito:=false;


	case operazione
		when 'get_user_info' then
			if v is not null then
				ret.esito = true;
				ret.info := v;
			end if;
		when 'get_access_stabilimenti' then
			ret:=srv_functions.get_access_stabilimenti(v::json, idtransazione);
		when 'get_countries' then
			ret:=srv_functions.get_countries(v::json, idtransazione); 
			when 'get_certificati' then
			ret:=srv_functions.get_certificati(v::json, idtransazione); 
		when 'get_contacts' then
			ret:=srv_functions.get_contacts(v::json, idtransazione); 
		when 'get_stabilimenti_sintesis' then
			ret:=srv_functions.get_stabilimenti_sintesis(v::json, idtransazione);
		when 'get_utenti_da_validare' then
			ret:=srv_functions.get_utenti_da_validare(v::json, idtransazione);
		when 'get_liste' then
			ret:=anagrafica.get_liste(v::json, idtransazione);
		when 'get_valori_by_id_lista' then
			ret:=anagrafica.get_valori_by_id_lista(v::json, idtransazione);
	    when 'get_gestori_liste' then
			ret:=anagrafica.get_gestori_liste(v::json, idtransazione);		
		when 'get_tree_denominazione_prodotti' then
			ret:=srv_functions.get_tree_denominazione_prodotti(v::json, idtransazione);
		when 'get_tipi_campo' then 
			ret:=srv_functions.get_tipi_campo(v::json, idtransazione);
		when 'get_query' then 
			ret:=srv_functions.get_query(v::json, idtransazione);
 		else
 			ret.esito := false;
 			ret.info  := 'CASO NON PREVISTO';
 			raise notice 'ELSE CASE';
	end case;

	RAISE notice 'srv_functions.get_dati ret.esito: %', ret.esito;
	   
	if ret.esito=false then 
		RAISE notice 'srv_functions.get_dati if su ret.esito=false';
		fallito=true;
		RAISE notice 'srv_functions.get_dati ROLLBACK a seguito di ret.esito=false';
	end if;
	str_conf:= ui.get_ui_definition(''::varchar,operazione,((j_user_info->'id_struttura_root')::varchar)::int8,idtransazione);
	raise notice 'STR_CONF=%',str_conf;
	raise notice 'j_user_info=%',j_user_info;
	raise notice 'ret.info = %', ret.info;
	if str_conf is not null and str_conf != '' then
		-- ret.info:='{'||str_conf||','||right(ret.info,length(ret.info)-1);
	 	ret.info:='{'||str_conf||', "dati": '|| ret.info || '}';
	end if;

	exception when others then
		fallito:=true;
		RAISE notice 'agenda.get_dati ROLLBACK a seguito di exception';
		GET STACKED diagnostics
			text_msg1=MESSAGE_TEXT, text_msg2=PG_EXCEPTION_DETAIL,text_msg3=PG_EXCEPTION_HINT,text_msg4 = PG_EXCEPTION_CONTEXT;
		ret.esito:=false;
		ret.valore:= null;
		ret.msg:=coalesce(text_msg1,'')|| chr(10) ||coalesce(text_msg2,'')|| chr(10)  ||coalesce(text_msg3,'')|| chr(10)  ||coalesce(text_msg4,'');
   end;
  
  	if fallito=true then 
		rollback;
	end if;

	joutput:=row_to_json(ret);
	id_op:=log.op(proc_name,idtransazione,v,joutput,ts,-1,operazione);
commit;
end;
$$;


ALTER PROCEDURE srv_functions.get_dati(IN operazione character varying, IN v character varying, IN idutente bigint, INOUT joutput json) OWNER TO postgres;

--
-- Name: get_query(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_query(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	proc_name varchar;
	rt json;

	begin
		proc_name:='srv_functions.get_query';
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		
		select json_agg(row_to_json(c.*)) into rt from (
			select id, label from public.query tc 
		) c;
	
		raise notice '%', json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='Nessun record';
    		ret.info:='{}'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_query(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_stabilimenti_sintesis(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_stabilimenti_sintesis(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; 
	id_op bigint;   
	proc_name varchar;
	rt json;

	begin
		proc_name:='srv_functions.get_stabilimenti_sintesis';
		raise notice 'V_J %',v_j;
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		select json_agg(row_to_json(a.*)) into rt from (
			select * from public.vw_get_stabilimenti  a
		where riferimento_id_nome_tab = 'sintesis_stabilimento'
		) a;
	
		raise notice '%',json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='accessi non trovati';
    		ret.info:='{}'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_stabilimenti_sintesis(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_tipi_campo(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_tipi_campo(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	proc_name varchar;
	rt json;

	begin
		proc_name:='srv_functions.get_tipi_campo';
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		
		select json_agg(row_to_json(c.*)) into rt from (
			select * from types.tipo_campo tc 
		) c;
	
		raise notice '%', json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='Tipi campi non esistenti';
    		ret.info:='{}'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_tipi_campo(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_tree_denominazione_prodotti(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_tree_denominazione_prodotti(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; 
	id_op bigint;   
	proc_name varchar;
	rt json;
	R_T public.vw_tree_nodes_up_denominazione_prodotti%ROWTYPE;

	begin
		proc_name:='srv_functions.get_tree_denominazione_prodotti';
	select json_agg(row_to_json(c.*)) into rt  from 
		(select *, descr as descrizione, descr as descrizione_breve from
		vw_tree_nodes_up_denominazione_prodotti) c;

		raise notice '%',json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=false;	
    	    ret:=ag_ui.build_ret(ret,proc_name, 'denominazioni non trovate');
    		ret.info:=null; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;

	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_tree_denominazione_prodotti(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_utenti_da_validare(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.get_utenti_da_validare(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	proc_name varchar;
	rt json;
	
	begin
		proc_name:='srv_functions.get_utenti_da_validare';
		--id_op:=gds_log.start_op(proc_name, idtransazione, '');
	
		select json_agg(row_to_json(c.*)) into rt from (
			select as2.id, as2.id_access, c.nome, c.cognome, c.codice_fiscale, c.email, s.ragione_sociale, s.asl, s.comune, s.indirizzo
			from um.access_stabilimenti as2
			join um."access" a on a.id = as2.id_access
			join um.contact c on c.id = a.id_contact
			join vw_get_stabilimenti s on s.id = as2.id_stabilimento
			where as2.validato_data is null
			and as2.validato_da is null
			and as2.rifiutato_data is null
			and as2.id_responsabile is null
		) c;
	
		raise notice '%', json_array_length(rt);
	
		if json_array_length(rt) is null then
			ret.esito:=true;	
    		ret.msg:='Non sono presenti utenti.';
    		ret.info:='{}'; 
    	else
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;
		end if;
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.get_utenti_da_validare(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: ins_access_stabilimento(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.ins_access_stabilimento(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
		ret types.result_type; -- START
		id_op bigint;
		_username varchar;
		_password varchar;
		_nome varchar;
		_cognome varchar;
		proc_name varchar; -- END
		n integer;
		dataa timestamp;
		datada timestamp;
		idaccessstabilimento integer;
		R um.access_stabilimenti%ROWTYPE;
		contacts record;
		idContact um.contact.id%TYPE;
		-- idContact bigint;
		idAccess integer;
		idAccessGisa bigint;
		idRuolo bigint;
		idAsl int;
	begin
		proc_name:='srv_functions.upd_access_stabilimento';
	
		raise notice '%', v_j;
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
	
		-- Check se esiste già il contatto
		select * into contacts from um.contact c
		where c.nome = v_j->>'nome'
		and c.cognome = v_j->>'cognome'
		and c.codice_fiscale = v_j->>'codice_fiscale';
	
		_nome:=LOWER(replace(((v_j->>'nome')::varchar), ' ', ''));
		_cognome:=LOWER(replace(((v_j->>'cognome')::varchar), ' ', ''));
	
		raise notice 'Contacts: %', contacts;
	
		_username:= _nome || '_' || _cognome;
		_password:='password';
	
		idAccessGisa:=v_j->>'id_access_gisa';
		idAsl:=v_j->>'id_asl';

		raise notice 'Username: %', _username;
		raise notice 'Password: %', _password;
	
		raise notice 'idAccessGisa: %', idAccessGisa;
		raise notice 'idAsl: %', idAsl;
	
		-- Se non esiste lo inserisce come nuovo e crea anche l'accesso
		if contacts is null then
			raise notice 'contacts is null!';
			insert into um.contact values (nextval('um.contact_id_seq'), v_j->>'nome', v_j->>'cognome', v_j->>'codice_fiscale', CURRENT_TIMESTAMP, v_j->>'email')
			returning id into idContact;
	
			select id into idRuolo from um."role" r where descr = 'OPERATORE_OSA';
			if idAccessGisa is not null then
				select id into idRuolo from um."role" r where descr = 'OPERATORE_ASL';
			end if;
		
			if v_j->>'registrazione_responsabile' then
				select id into idRuolo from um."role" r where descr = 'RESPONSABILE_OSA';
			end if;
			
			insert into um."access" (id, id_contact, username, password, id_role, entered, id_asl, id_access_gisa)
			values (nextval('um.access_id_seq'), idContact, _username, _password, idRuolo, CURRENT_TIMESTAMP, idAsl, idAccessGisa)
			returning id into idAccess;
		
			raise notice 'idContact: %', idContact;
			raise notice 'idAccess: %', idAccess;
		end if;
	
		if idAccess is null then
			select id into idAccess from um."access" a where id_contact = contacts.id;
		end if;
	
		-- Inserisce la delega
		if idAccess is null then
			R.id_access := v_j->>'id_access';
		else
			R.id_access := idAccess;
		end if;
	
	
		raise notice 'idAsl prima dell idf: %', idAsl;
		if idAsl is null then
			R.id_stabilimento:=v_j->>'id_stabilimento';
			R.id_responsabile:=v_j->>'id_responsabile';
			R.validita:=tsrange((v_j->>'data_da')::timestamp, (v_j->>'data_a')::timestamp,'[)');
			R.dt:=current_timestamp;
			R.id:=nextval('um.access_stabilimenti_id_seq');
			R.superuser:=v_j->>'superuser';
	
			raise notice 'R: %', R;
		
			insert into um.access_stabilimenti values (R.*);
		end if;
		GET DIAGNOSTICS n = ROW_COUNT;
		if n > 0 then
			ret.esito:=true;
		else
			ret.esito:=false;
			ret.msg:='Nessuna delega inserita';
		end if;
	
		ret:=ui.build_ret(ret,proc_name,R.id);
		return ret;
	end;
END
$$;


ALTER FUNCTION srv_functions.ins_access_stabilimento(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: ins_certificato(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.ins_certificato(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	proc_name varchar;
	ret types.result_type%ROWTYPE;
	id_op bigint;
	R_C public.certificati;
	R_M public.moduli;
	R_COUNTRY public.countries;
	rt character varying;
	text_msg1 varchar;	
	text_msg2 varchar;	
	text_msg3 varchar;	
	text_msg4 varchar;
begin
	--proc_name:='srv.ins_certificato';
	--id_op:=log.start_op(proc_name,idtransazione ,v::varchar);
	R_COUNTRY.descr:=v->>'paese';
	select * into R_COUNTRY from vw_countries where descr=R_COUNTRY.descr;
	if R_COUNTRY.id is null then
		raise notice 'Inserimento Nazione';
		R_COUNTRY.descr:=v->>'paese';
		R_COUNTRY.id:= nextval('public.countries_id_seq');
		insert into public.countries values (R_COUNTRY.*);
	end if;
	R_C.id_country:= R_COUNTRY.id;
	R_C.id:=nextval('public.certificati_id_seq');
	R_C.descr:= v->>'descrizione';
	R_C.descr_estera:= v->>'descrizione_estera';
	R_M.id:=nextval('public.moduli_id_seq');
	R_C.id_modulo_corrente:=R_M.id;
	insert into public.certificati values (R_C.*);
	raise notice 'Inserito certificato';

	R_M.id_certificato:=R_C.id;
	R_M.codice:=v->>'codice';
	R_M.nota:=v->>'nota';
	R_M.url:=v->>'url';
	insert into public.moduli values(R_M.*);
	raise notice 'INSERITO MODULO';
				ret.esito:=true;
			ret.valore:= null;
	rt:=row_to_json(ret);
	id_op:=log.end_op(proc_name,idtransazione ,rt::varchar);
	return ret;
		exception when others then
			GET STACKED DIAGNOSTICS text_msg1 = MESSAGE_TEXT,
                          			text_msg2 = PG_EXCEPTION_DETAIL,
                          			text_msg3 = PG_EXCEPTION_HINT,
                         			text_msg4 = PG_EXCEPTION_CONTEXT;
			ret.esito:=false;
			ret.valore:= null;
			ret.msg:=coalesce(text_msg1,'')|| chr(10) ||coalesce(text_msg2,'')|| chr(10)  ||coalesce(text_msg3,'')|| chr(10)  ||coalesce(text_msg4,'');
			rt:=row_to_json(ret);
			id_op:=log.end_op(proc_name,idtransazione ,rt);
			return ret;
end;
end
$$;


ALTER FUNCTION srv_functions.ins_certificato(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: ins_denominazione_prodotti(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.ins_denominazione_prodotti(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; 
	id_op bigint;   
	proc_name varchar;
	rt json;
	R_T public.vw_tree_nodes_up_denominazione_prodotti%ROWTYPE;

	begin
		proc_name:='srv_functions.ins_denominazione_prodotti';
	
	

		insert into tree_nodes (id_tree, descr, id_node_parent, ordinamento)
		select (v->>'id_tree')::bigint, (v->>'descrizione')::text, (v->>'id_node')::bigint,
		coalesce(max(ordinamento)) + 1 from tree_nodes where id_node_parent = (v->>'id_node')::bigint;
	
		
    		ret.esito:=true;
 			ret.msg:=null;
	 		ret.info:=rt;

	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.ins_denominazione_prodotti(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: ins_evento_agenda(text); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.ins_evento_agenda(_input text) RETURNS types.ag_result_type
    LANGUAGE plpgsql
    AS $$
	declare 
		id_ns bigint;
		_id_piano bigint;
		_id_linea bigint;
		ret types.ag_result_type;
		v json;
	begin
		v = _input::json;
		select id_nominativo_struttura into id_ns from um.access where id = (select id from um.get_user where codice_fiscale = (select sd_vet_cf from vw_get_stabilimenti where id = (v->>'id_stabilimento')::bigint));
		select id into _id_piano from conf.get_id_piano limit 1;
		select id_linea into _id_linea from vw_get_stabilimenti where id = (v->>'id_stabilimento')::bigint;
		
		raise notice 'id_ns %', id_ns;
		raise notice 'id_piano %', _id_piano;
		raise notice 'id_linea %', _id_linea;

	   raise notice 'select * from agenda.ins_evento(''{"id_ns": %, "inizio": "%", "fine": "%", "id_linea":%, "id_piano": %}''::varchar, 1)',id_ns,v->>'inizio',v->>'fine', _id_linea , _id_piano;
	
        select * into ret from 
        dblink('dbname=mdgm_fvg'||(select valore from conf.conf where descr = 'postfix_ambiente' )||' port=5432 host=127.0.0.1 user=postgres'::text, 
        'select * from agenda.ins_evento(''{"id_ns": '||id_ns||', "inizio": "'||(v->>'inizio')||'", "fine": "'||(v->>'fine')||'", "id_linea": '||_id_linea||', "id_piano": '||_id_piano||'}''::varchar, 1)') 
        t(esito boolEAN , Valore text ,msg varchar ,info varchar ,err_msg varchar);
       
       raise notice 'ret %', ret;
       return ret;
        
        
        
	END;
$$;


ALTER FUNCTION srv_functions.ins_evento_agenda(_input text) OWNER TO postgres;

--
-- Name: insert_modulo_campi(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.insert_modulo_campi(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	proc_name varchar;
	rt json;
	idcertificato bigint;
	idmodulo_new bigint;
	tipo_certificato bigint;
	i int;
	campo record;
	begin
		proc_name:='srv_functions.upd_certificato_modulo';
	
		i := 0;
		idcertificato := (v_j->>'id_certificato')::bigint;
	
	
		if idcertificato = -1 then
			insert into certificati (descr, id_country, validita)
			values (v_j->>'nuovo_nome', (v_j->>'paese')::bigint, '["1900-01-01",]') returning id into idcertificato;
		end if;
	
		select id into tipo_certificato from "types".tipo_modulo tm where descr = 'statico';
		if (v_j->>'tipo_certificato')::text = 'allegato' then
			select id into tipo_certificato from "types".tipo_modulo tm where descr = 'statico_allegato';
		end if;
	
		insert into moduli (id_tipo_modulo, filename_template, id_certificato)
		values (tipo_certificato, (v_j->>'filename'), idcertificato)
		returning id into idmodulo_new;
		
		for campo in select * from json_populate_recordset(null::public.modulo_campi, v_j->'campi') loop
			raise notice 'campo %', campo;
			
			if campo.id_query is not null then
				campo.id_anagrafica_lista = null;
				campo.id_tipo_campo = (select id from "types".tipo_campo tc where descr = 'text');
			end if;
		
			insert into modulo_campi (id_modulo, nome_campo, id_tipo_campo, ord, id_anagrafica_lista, obbligatorio, id_query,
			label, font_size, campo_traduzione)
			values
			(idmodulo_new, campo.nome_campo, coalesce(campo.id_tipo_campo, 1), campo.ord, campo.id_anagrafica_lista, campo.obbligatorio, campo.id_query,
			campo.label, campo.font_size, campo.campo_traduzione);
			
			i= i + 1;
			
		end loop;
	
		update modulo_campi m set id_campo_traduzione = t.id
		from modulo_campi t 
		where m.campo_traduzione = t.label and t.id_modulo = m.id_modulo and m.id_modulo = idmodulo_new
		and m.campo_traduzione is not null;
	
		
	
		update certificati set id_modulo_corrente = idmodulo_new where id = idcertificato;
	
		ret.esito:=true;	
		ret.msg:=null;
		ret.info:=null; 
 
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.insert_modulo_campi(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: upd_access_stabilimento(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.upd_access_stabilimento(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; -- START
	id_op bigint;   
	proc_name varchar; -- END
	n integer;
	data_a timestamp;
	data_da timestamp;
	cf text;
	idaccessstabilimento integer;
	R record;
	begin
	proc_name:='srv_functions.upd_access_stabilimento';

	raise notice '%', v_j;
	--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
	idaccessstabilimento := v_j->>'id_access_stabilimento';
	data_da := v_j->>'data_da';
	data_a := v_j->>'data_a';
	cf := v_j->>'cf';

	raise notice 'id_access_stabilimento: %', idaccessstabilimento;
	raise notice 'data_da: %', data_da;
	raise notice 'data_a: %', data_a;
	select * into R from um.vw_access_stabilimenti vas where id_access_stabilimento = idaccessstabilimento;

	ret.esito:=false;
	n:=0;
	/*if R.valido_da > CURRENT_TIMESTAMP then
		update um.access_stabilimenti set validita=tsrange(data_da,data_a,'[)')
		where id=idaccessstabilimento;
		GET DIAGNOSTICS n = ROW_COUNT;
		ret.msg:='Date modificate';
	elsif R.valido_a > CURRENT_TIMESTAMP then
		update um.access_stabilimenti set validita=tsrange(lower(validita),data_a,'[)')
		where id=idaccessstabilimento;
		GET DIAGNOSTICS n = ROW_COUNT;
		ret.msg:='Data modificata';
	else
		ret.msg:='Elemento non modificabile';
	end if;*/

	update um.access_stabilimenti set validita=tsrange(data_da,data_a,'[)')
		where id=idaccessstabilimento;
		GET DIAGNOSTICS n = ROW_COUNT;
		ret.msg:='Date modificate';

	update um.contact 
	set 
	codice_fiscale = upper(cf),
	nome  = upper(v_j->>'nome'),
	cognome = upper(v_j->>'cognome')
	where id = (select id_contact from um."access" 
					where id = (select id_access_delegato 
						from um.vw_access_stabilimenti 
						where id = idaccessstabilimento
					)
				);

    ret.esito:=true;	

 	
	ret:=ui.build_ret(ret,proc_name,(v_j->>'id_access_stabilimento')::bigint);
	return ret;
	end;
END
$$;


ALTER FUNCTION srv_functions.upd_access_stabilimento(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: upd_dati(character varying, character varying, bigint, json); Type: PROCEDURE; Schema: srv_functions; Owner: postgres
--

CREATE PROCEDURE srv_functions.upd_dati(IN operazione character varying, IN v character varying, IN idutente bigint, INOUT joutput json)
    LANGUAGE plpgsql
    AS $$
declare 
	idtransazione bigint;
	proc_name varchar;
	id_op bigint;  
	ret types.result_type;
	text_msg1 varchar;	
	text_msg2 varchar;	
	text_msg3 varchar;	
	text_msg4 varchar;
	ts timestamp;
	fallito bool;
	j_user_info json;
	n integer;
v_j json;
begin
	ts:=CLOCK_TIMESTAMP();
	proc_name:='srv_functions.upd_dati';
	idtransazione:= log.get_id_transazione(idutente,proc_name);
	--select row_to_json(public.get_utente_info_from_gisa(idutente)) into j_user_info;
	select row_to_json(a.*) into j_user_info from
		(
			select a.id_contact,a.nome  ,a.cognome,json_agg( p.descr_permission) permessi from um.vw_access a 
													join um.vw_role_permission p on p.id_role=a.id_role
			where a.id_access=idutente
			group by 1,2,3
		) a;
	if j_user_info is not null then
		if v is null or v='' or v='{}' then
			v:= '{"user_info":'||j_user_info||'}';
		else
			v:= substring(v,1,length(v)-1)||',"user_info":'||j_user_info||'}';
		end if;
	end if;
	id_op:=log.start_op(proc_name,idtransazione ,v);


--commit;
 
   	--begin
	   	fallito:=false;
	   	case operazione
	   		when 'upd_access_stabilimento' then
	   			ret:=srv_functions.upd_access_stabilimento(v::json, idtransazione);
	   		when 'ins_certificato' then
	   			v_j:=v::json;
	   			ret:=srv_functions.ins_certificato(v_j, idtransazione);
	   		when 'del_access_stabilimento' then
	   			ret:=srv_functions.del_access_stabilimento(v::json, idtransazione);
	   		when 'ins_access_stabilimento' then
	   			ret:=srv_functions.ins_access_stabilimento(v::json, idtransazione);
	   		when 'duplica_certificato' then
	   			ret:=srv_functions.duplica_certificato(v::json, idtransazione);
	   		when 'upd_valida_utenti' then
	   			ret:=srv_functions.upd_valida_utenti(v::json, idtransazione);
	   		when 'ins_denominazione_prodotti' then
	   			ret:=srv_functions.ins_denominazione_prodotti(v::json, idtransazione);
	   		when 'del_denominazione_prodotti' then
	   			ret:=srv_functions.del_denominazione_prodotti(v::json, idtransazione);
	   		when 'ins_lista' then
	   	  		ret:=anagrafica.ins_lista(v, idtransazione::int8);
			when 'del_lista' then
	   			ret:=anagrafica.del_lista(v, idtransazione::int8);
	   		when 'load_import_lista' then
	   			ret:=anagrafica.load_import_lista(v::json, idtransazione::int8);
	   		when 'load_import_record' then
	   			ret:=anagrafica.load_import_record(v::json, idtransazione::int8);
	        when 'delete_lista_record' then
	   			ret:=anagrafica.delete_lista_record(v::json, idtransazione::int8);
	   		when 'insert_modulo_campi' then
	   			ret:=srv_functions.insert_modulo_campi(v::json, idtransazione);
	   		when 'update_modulo_campi' then
	   			ret:=srv_functions.update_modulo_campi(v::json, idtransazione);
	   		when 'elimina_certificato' then
	   			ret:=srv_functions.elimina_certificato(v::json, idtransazione);
			else
 			ret.esito := false;
 			ret.info  := 'CASO NON PREVISTO';
	   	end case;
		
	    RAISE notice 'srv_functions.upd_evento ret.esito: %', ret.esito;
	   
   		if ret.esito=false then 
   			RAISE notice 'srv_functions.upd_evento if su ret.esito=false';
   			fallito=true;
	   		RAISE notice 'srv_functions.upd_evento ROLLBACK a seguito di ret.esito=false';
   		end if;
		

	--end;
	
	--if fallito=true then 
		--rollback;
	--end if;

	joutput:=row_to_json(ret);
	id_op:=log.op(proc_name,idtransazione,v,joutput,ts,-1,operazione);

	exception when others then
		fallito:=true;
		RAISE notice 'gds.upd_dati ROLLBACK a seguito di exception';
		GET STACKED DIAGNOSTICS text_msg1 = MESSAGE_TEXT,
                          			text_msg2 = PG_EXCEPTION_DETAIL,
                          			text_msg3 = PG_EXCEPTION_HINT,
                         			text_msg4 = PG_EXCEPTION_CONTEXT;
			ret.esito:=false;
			ret.valore:= null;
			ret.msg:=coalesce(text_msg1,'')|| chr(10) ||coalesce(text_msg2,'')|| chr(10)  ||coalesce(text_msg3,'')|| chr(10)  ||coalesce(text_msg4,'');
			RAISE notice '%', ret;
		--rollback;
	end;
--	joutput:=row_to_json(ret);
--	id_op:=log.op(proc_name,idtransazione,v,joutput,ts,-1,operazione);
--commit;

--end;
$$;


ALTER PROCEDURE srv_functions.upd_dati(IN operazione character varying, IN v character varying, IN idutente bigint, INOUT joutput json) OWNER TO postgres;

--
-- Name: upd_evento_agenda(text); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.upd_evento_agenda(_input text) RETURNS types.ag_result_type
    LANGUAGE plpgsql
    AS $$
	declare 
		ret types.ag_result_type;
		v json;
	begin
		v = _input::json;
			
        select * into ret from 
        dblink('dbname=mdgm_fvg'||(select valore from conf.conf where descr = 'postfix_ambiente' )||' port=5432 host=127.0.0.1 user=postgres'::text, 
        'select * from agenda.upd_evento(''{"id": '||(v->>'id')||', "start": "'||(v->>'inizio')||'", "end": "'||(v->>'fine')||'"}''::varchar, 1)') 
        t(esito boolEAN , Valore text ,msg varchar ,info varchar ,err_msg varchar);
       
       raise notice 'ret %', ret;
       return ret;
        
        
        
	END;
$$;


ALTER FUNCTION srv_functions.upd_evento_agenda(_input text) OWNER TO postgres;

--
-- Name: upd_valida_utenti(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.upd_valida_utenti(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
		ret types.result_type; -- START
		id_op bigint;   
		proc_name varchar; -- end
		id_access_responsabile bigint;
		id_utenti_da_validare int[];
		id_user int;
		operazione text;
	begin
		ret.esito = false;
		proc_name:='srv_functions.upd_valida_utenti';
		raise notice 'v_j: %', v_j;
		operazione = v_j->>'operazione';
	
		id_access_responsabile = v_j->>'id_access_responsabile';
		raise notice 'id_access_responsabile: %', id_access_responsabile;
	
		id_utenti_da_validare:=array(select * from json_array_elements(v_j->'id_utenti_da_validare'));
		raise notice 'id_utenti_da_validare: %', v_j->'id_utenti_da_validare';
	 	
		foreach id_user in array id_utenti_da_validare
		loop
			if operazione = 'rifiuta' then 
				update um.access_stabilimenti
				set rifiutato_data = now(), validato_da = id_access_responsabile
				where id = id_user;
			else 
				update um.access_stabilimenti
				set validato_data = now(), validato_da = id_access_responsabile
				where id = id_user;
			end if;
		end loop;
		
		ret.esito = true;
		ret:=ui.build_ret(ret, proc_name, null);
		return ret;
	end;
END
$$;


ALTER FUNCTION srv_functions.upd_valida_utenti(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: update_modulo_campi(json, bigint); Type: FUNCTION; Schema: srv_functions; Owner: postgres
--

CREATE FUNCTION srv_functions.update_modulo_campi(v_j json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type;
	id_op bigint;
	proc_name varchar;
	rt json;
	idcertificato bigint;
	idmodulo bigint;
	i int;
	campo record;
	begin
		proc_name:='srv_functions.update_modulo_campi';
	
		i := 0;
		idcertificato := (v_j->>'id_certificato')::bigint;
	
		idmodulo = (select id_modulo_corrente from public.certificati where id = idcertificato);
	
		delete from modulo_campi where id_modulo = idmodulo;
		
		for campo in select * from json_populate_recordset(null::public.modulo_campi, v_j->'campi') loop
			raise notice 'campo %', campo;
			
			if campo.id_query is not null then
				campo.id_anagrafica_lista = null;
				campo.id_tipo_campo = (select id from "types".tipo_campo tc where descr = 'text');
			end if;
		
			insert into modulo_campi (id_modulo, nome_campo, id_tipo_campo, ord, id_anagrafica_lista, obbligatorio, id_query,
			label, font_size, campo_traduzione)
			values
			(idmodulo, campo.nome_campo, coalesce(campo.id_tipo_campo, 1), campo.ord, campo.id_anagrafica_lista, campo.obbligatorio, campo.id_query,
			campo.label, campo.font_size, campo.campo_traduzione);
			
			i= i + 1;
			
		end loop;
	
	
		
		ret.esito:=true;	
		ret.msg:=null;
		ret.info:=null; 
 
	
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION srv_functions.update_modulo_campi(v_j json, idtransazione bigint) OWNER TO postgres;

--
-- Name: build_ret(types.result_type, character varying, bigint); Type: FUNCTION; Schema: ui; Owner: postgres
--

CREATE FUNCTION ui.build_ret(r types.result_type, pname character varying, val bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare 
	begin
		r.valore:= val;
		if not r.esito then
			--r.msg:=coalesce(r.msg,'') || ' ('|| coalesce(r.valore,-1)||')' ;
			r.msg:=coalesce(r.msg,'')||' '||CHR(13)||ui.get_proc_msg(pname,r.valore)||' ['||coalesce(pname,'PROC UNDEFINED')||' ('||val||') ] ';
		end if;
		return r;
	end;
END
$$;


ALTER FUNCTION ui.build_ret(r types.result_type, pname character varying, val bigint) OWNER TO postgres;

--
-- Name: get_menu(json, bigint); Type: FUNCTION; Schema: ui; Owner: postgres
--

CREATE FUNCTION ui.get_menu(v json, idtransazione bigint) RETURNS types.result_type
    LANGUAGE plpgsql
    AS $$
begin
	declare
	ret types.result_type; 
	id_op bigint;   
	proc_name varchar;
	v_mn varchar;
	rt json;
	lv integer;

	begin
		proc_name:='ui.get_menu';
		raise notice 'v=%',v;
		v_mn:=replace((v->'menu')::varchar,'"','');
	
		if v_mn is null then
			ret.esito:=false;
			ret.msg:='parametro menu non specificato';
			ret.info:=rt;
			return ret;
		end if;
		
		lv:=v->'user_info'->'livello';
		raise notice 'lv -> %', lv;
	
		raise notice 'v_mn=%',v_mn;	
		--id_op:=gds_log.start_op(proc_name,idtransazione ,'');
		select json_agg(row_to_json(a.*)) into rt from (
		select * from (
					select distinct on (mi.cod)  mi.cod ,mm.lev,ord,mi.descr, mm.modality from ui.menu m join ui.menu_items mi on m.id=mi.id_menu 
				join ui.menu_item_modes mm on mm.id_menu_item =mi.id
			where m.cod = v_mn and mm.lev>=lv order by mi.cod , mm.lev,ord
		) b order by b.ord) a;
	
		--ret.valore:= id_record;
	
	
	
		/*	select json_agg(row_to_json(a.*))  from (
		select * from (
					select distinct on (mi.cod)  mi.cod ,mm.lev,ord,mi.descr, mm.modality from ui.menu m join ui.menu_items mi on m.id=mi.id_menu 
				join ui.menu_item_modes mm on mm.id_menu_item =mi.id
			where m.cod = 'config' and mm.lev>=2 order by mi.cod , mm.lev,ord
		) b order by b.ord) a*/
	
		raise notice '%',json_array_length(rt);

    	ret.esito:=true;
 		ret.msg:=null;
	 	ret.info:=rt;
	 	return ret;
	end;
end;
$$;


ALTER FUNCTION ui.get_menu(v json, idtransazione bigint) OWNER TO postgres;

--
-- Name: get_proc_msg(character varying, bigint); Type: FUNCTION; Schema: ui; Owner: postgres
--

CREATE FUNCTION ui.get_proc_msg(proc character varying, cod bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
	declare n integer;
	R_msg ui.messaggi_ui%ROWTYPE;
begin
	select * into R_msg from ui.messaggi_ui where procedura=proc and valore=cod;
	if R_msg.id is not null then
		return coalesce(R_msg.msg,'');
	end if;
	if cod < 0 then
		return 'ERRORE GENERICO ';
	end if;

	if cod = 0 then
		return 'DATI SALVATI';
	end if;
	return 'ERRORE ' ;
end;
end
$$;


ALTER FUNCTION ui.get_proc_msg(proc character varying, cod bigint) OWNER TO postgres;

--
-- Name: get_ui_definition(character varying, character varying, bigint, bigint); Type: FUNCTION; Schema: ui; Owner: postgres
--

CREATE FUNCTION ui.get_ui_definition(type_info character varying, fnct character varying, id_ns bigint, idtransazione bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
begin
	declare
	R_GD ui.grid_definition;
	proc_name varchar;
	begin
		proc_name:='ui.get_ui_definition';

		case type_info
			when  'grid' then
			
				select * into R_GD from ui.grid_definition gd --join matrix.vw_tree_nodes_down t on t.id_node_ref=gd.id_user
					where /*t.id_node=id_ns and */ funct=fnct and (id_user is null or id_user=id_ns); -- order by dist_node limit 1;
				/*select * into R_GD from ui.grid_definition gd where gd.id_user =id_ns  and funct=fnct;
				if R_GD.id_user is null then
					select * into R_NS from matrix.vw_nominativi_struttura ns where id=id_ns;
	
					select * into R_GD from ui.grid_definition gd join matrix.vw_tree_nodes_down t on t.id_node_ref=gd.id_user
					where t.id_node=R_NS.id_node_struttura and funct=fnct order by dist_node limit 1;
				end if;*/
			else
							select * into R_GD from ui.grid_definition gd --join matrix.vw_tree_nodes_down t on t.id_node_ref=gd.id_user
					where /*t.id_node=id_ns and*/ funct=fnct and (id_user is null or id_user=id_ns); --order by dist_node limit 1;
		end case;
		return R_GD.str_conf;
	end;
end;
$$;


ALTER FUNCTION ui.get_ui_definition(type_info character varying, fnct character varying, id_ns bigint, idtransazione bigint) OWNER TO postgres;

--
-- Name: gestore; Type: TABLE; Schema: anagrafica; Owner: postgres
--

CREATE TABLE anagrafica.gestore (
    id bigint NOT NULL,
    descr character varying NOT NULL,
    abilitatoimport boolean DEFAULT true NOT NULL
);


ALTER TABLE anagrafica.gestore OWNER TO postgres;

--
-- Name: gestore_id_seq; Type: SEQUENCE; Schema: anagrafica; Owner: postgres
--

CREATE SEQUENCE anagrafica.gestore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE anagrafica.gestore_id_seq OWNER TO postgres;

--
-- Name: gestore_id_seq; Type: SEQUENCE OWNED BY; Schema: anagrafica; Owner: postgres
--

ALTER SEQUENCE anagrafica.gestore_id_seq OWNED BY anagrafica.gestore.id;


--
-- Name: lista; Type: TABLE; Schema: anagrafica; Owner: postgres
--

CREATE TABLE anagrafica.lista (
    id bigint NOT NULL,
    descr character varying NOT NULL,
    gestore integer,
    rif_tipo_prodotto boolean
);


ALTER TABLE anagrafica.lista OWNER TO postgres;

--
-- Name: lista_id_seq; Type: SEQUENCE; Schema: anagrafica; Owner: postgres
--

CREATE SEQUENCE anagrafica.lista_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE anagrafica.lista_id_seq OWNER TO postgres;

--
-- Name: lista_id_seq; Type: SEQUENCE OWNED BY; Schema: anagrafica; Owner: postgres
--

ALTER SEQUENCE anagrafica.lista_id_seq OWNED BY anagrafica.lista.id;


--
-- Name: lista_valori; Type: TABLE; Schema: anagrafica; Owner: postgres
--

CREATE TABLE anagrafica.lista_valori (
    id bigint NOT NULL,
    id_lista bigint NOT NULL,
    valore character varying NOT NULL,
    id_stabilimento bigint,
    id_node_denominazione_prodotto bigint,
    traduzione character varying
);


ALTER TABLE anagrafica.lista_valori OWNER TO postgres;

--
-- Name: lista_valori_id_seq; Type: SEQUENCE; Schema: anagrafica; Owner: postgres
--

CREATE SEQUENCE anagrafica.lista_valori_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE anagrafica.lista_valori_id_seq OWNER TO postgres;

--
-- Name: lista_valori_id_seq; Type: SEQUENCE OWNED BY; Schema: anagrafica; Owner: postgres
--

ALTER SEQUENCE anagrafica.lista_valori_id_seq OWNED BY anagrafica.lista_valori.id;


--
-- Name: vw_liste; Type: VIEW; Schema: anagrafica; Owner: postgres
--

CREATE VIEW anagrafica.vw_liste AS
 SELECT l.id,
    l.descr,
    g.descr AS tipo_gestore,
    g.abilitatoimport,
    l.rif_tipo_prodotto
   FROM (anagrafica.lista l
     JOIN anagrafica.gestore g ON ((g.id = l.gestore)));


ALTER TABLE anagrafica.vw_liste OWNER TO postgres;

--
-- Name: tree_nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tree_nodes (
    id bigint NOT NULL,
    id_tree bigint,
    descr character varying,
    id_node_parent bigint,
    ordinamento integer,
    data_scadenza timestamp without time zone
);


ALTER TABLE public.tree_nodes OWNER TO postgres;

--
-- Name: trees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trees (
    id bigint NOT NULL,
    descr character varying
);


ALTER TABLE public.trees OWNER TO postgres;

--
-- Name: vw_tree_nodes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_tree_nodes AS
 SELECT t.descr AS name_tree,
    n.id AS id_node,
    n.id_tree,
    n.id_node_parent,
    n.ordinamento,
    n.descr,
    n.data_scadenza
   FROM (public.tree_nodes n
     LEFT JOIN public.trees t ON ((n.id_tree = t.id)));


ALTER TABLE public.vw_tree_nodes OWNER TO postgres;

--
-- Name: vw_tree_nodes_up; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_tree_nodes_up AS
 WITH RECURSIVE vw_tree_nodes_up(name_tree, id_node, id_tree, id_node_parent, path) AS (
         SELECT vw_tree_nodes.name_tree,
            vw_tree_nodes.id_node,
            vw_tree_nodes.id_tree,
            vw_tree_nodes.id_node_parent,
            (vw_tree_nodes.id_node)::text AS path,
            lpad((vw_tree_nodes.id_node)::text, 5, '0'::text) AS path_ord,
            vw_tree_nodes.descr AS path_descr,
            0 AS lv,
            vw_tree_nodes.ordinamento,
            vw_tree_nodes.descr,
            vw_tree_nodes.data_scadenza
           FROM public.vw_tree_nodes
          WHERE (vw_tree_nodes.id_node_parent IS NULL)
        UNION ALL
         SELECT n.name_tree,
            n.id_node,
            n.id_tree,
            n.id_node_parent,
            ((up.path || '/'::text) || n.id_node),
            ((up.path_ord || '/'::text) || lpad((n.id_node)::text, 5, '0'::text)),
            (((up.path_descr)::text || '/'::text) || (n.descr)::text),
            (up.lv + 1) AS lv,
            n.ordinamento,
            n.descr,
            n.data_scadenza
           FROM (vw_tree_nodes_up up
             JOIN public.vw_tree_nodes n ON ((up.id_node = n.id_node_parent)))
        )
 SELECT vw_tree_nodes_up.name_tree,
    vw_tree_nodes_up.id_node,
    vw_tree_nodes_up.id_tree,
    vw_tree_nodes_up.id_node_parent,
    vw_tree_nodes_up.path,
    vw_tree_nodes_up.path_ord,
    vw_tree_nodes_up.path_descr,
    vw_tree_nodes_up.lv,
    vw_tree_nodes_up.ordinamento,
    vw_tree_nodes_up.descr,
    vw_tree_nodes_up.data_scadenza
   FROM vw_tree_nodes_up
  ORDER BY vw_tree_nodes_up.path;


ALTER TABLE public.vw_tree_nodes_up OWNER TO postgres;

--
-- Name: vw_tree_nodes_up_denominazione_prodotti; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_tree_nodes_up_denominazione_prodotti AS
 SELECT vw_tree_nodes_up.name_tree,
    vw_tree_nodes_up.id_node,
    vw_tree_nodes_up.id_tree,
    vw_tree_nodes_up.id_node_parent,
    vw_tree_nodes_up.path,
    vw_tree_nodes_up.path_ord,
    vw_tree_nodes_up.path_descr,
    vw_tree_nodes_up.lv,
    vw_tree_nodes_up.ordinamento,
    vw_tree_nodes_up.descr,
    vw_tree_nodes_up.data_scadenza
   FROM public.vw_tree_nodes_up
  WHERE (((vw_tree_nodes_up.name_tree)::text = 'Denominzione prodotti'::text) AND (vw_tree_nodes_up.data_scadenza IS NULL))
  ORDER BY vw_tree_nodes_up.path_ord;


ALTER TABLE public.vw_tree_nodes_up_denominazione_prodotti OWNER TO postgres;

--
-- Name: vw_liste_valori; Type: VIEW; Schema: anagrafica; Owner: postgres
--

CREATE VIEW anagrafica.vw_liste_valori AS
 SELECT l.descr,
    lv.id,
    lv.id_lista,
    lv.valore,
    lv.traduzione,
    lv.id_stabilimento,
    lv.id_node_denominazione_prodotto,
    g.abilitatoimport,
    l.rif_tipo_prodotto,
    COALESCE(prod.descr, ''::character varying) AS prodotto_descr
   FROM (((anagrafica.lista l
     JOIN anagrafica.lista_valori lv ON ((l.id = lv.id_lista)))
     JOIN anagrafica.gestore g ON ((g.id = l.gestore)))
     LEFT JOIN public.vw_tree_nodes_up_denominazione_prodotti prod ON ((prod.id_node = lv.id_node_denominazione_prodotto)));


ALTER TABLE anagrafica.vw_liste_valori OWNER TO postgres;

--
-- Name: asl_sedi; Type: TABLE; Schema: conf; Owner: postgres
--

CREATE TABLE conf.asl_sedi (
    id_asl integer,
    cod_esterno character varying,
    nome character varying,
    indirizzo character varying,
    cap character varying,
    istat_comune character varying,
    piva character varying
);


ALTER TABLE conf.asl_sedi OWNER TO postgres;

--
-- Name: conf; Type: TABLE; Schema: conf; Owner: postgres
--

CREATE TABLE conf.conf (
    descr character varying,
    valore character varying
);


ALTER TABLE conf.conf OWNER TO postgres;

--
-- Name: get_id_piano; Type: VIEW; Schema: conf; Owner: postgres
--

CREATE VIEW conf.get_id_piano AS
 SELECT t.id,
    t.anno
   FROM public.dblink('dbname=mdgm_fvg port=5432 host=127.0.0.1 user=postgres'::text, ('select id, anno from matrix.struttura_piani where anno = (select value from "Analisi_dev".config where descr = ''ANNO CORRENTE'')::int and cod_raggruppamento = '::text || (( SELECT conf.valore
           FROM conf.conf
          WHERE ((conf.descr)::text = 'cod_raggruppamento_piano'::text)))::text)) t(id bigint, anno text);


ALTER TABLE conf.get_id_piano OWNER TO postgres;

--
-- Name: call_logs; Type: TABLE; Schema: log; Owner: postgres
--

CREATE TABLE log.call_logs (
    id bigint NOT NULL,
    id_transazione bigint,
    procedura character varying,
    fase character varying,
    ts timestamp without time zone,
    val character varying
);


ALTER TABLE log.call_logs OWNER TO postgres;

--
-- Name: call_logs_id_seq; Type: SEQUENCE; Schema: log; Owner: postgres
--

CREATE SEQUENCE log.call_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log.call_logs_id_seq OWNER TO postgres;

--
-- Name: call_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: log; Owner: postgres
--

ALTER SEQUENCE log.call_logs_id_seq OWNED BY log.call_logs.id;


--
-- Name: operazioni; Type: TABLE; Schema: log; Owner: postgres
--

CREATE TABLE log.operazioni (
    id bigint NOT NULL,
    id_transazione bigint,
    procedura character varying,
    fase character varying,
    ts_start timestamp without time zone,
    ts_transazione timestamp without time zone,
    val character varying,
    ts_end timestamp without time zone,
    ret character varying,
    id_trattato bigint
);


ALTER TABLE log.operazioni OWNER TO postgres;

--
-- Name: operazioni_id_seq; Type: SEQUENCE; Schema: log; Owner: postgres
--

CREATE SEQUENCE log.operazioni_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log.operazioni_id_seq OWNER TO postgres;

--
-- Name: operazioni_id_seq; Type: SEQUENCE OWNED BY; Schema: log; Owner: postgres
--

ALTER SEQUENCE log.operazioni_id_seq OWNED BY log.operazioni.id;


--
-- Name: transazioni; Type: TABLE; Schema: log; Owner: postgres
--

CREATE TABLE log.transazioni (
    id bigint NOT NULL,
    id_user bigint NOT NULL,
    ts timestamp without time zone NOT NULL,
    descr character varying
);


ALTER TABLE log.transazioni OWNER TO postgres;

--
-- Name: transazioni_id_seq; Type: SEQUENCE; Schema: log; Owner: postgres
--

CREATE SEQUENCE log.transazioni_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log.transazioni_id_seq OWNER TO postgres;

--
-- Name: transazioni_id_seq; Type: SEQUENCE OWNED BY; Schema: log; Owner: postgres
--

ALTER SEQUENCE log.transazioni_id_seq OWNED BY log.transazioni.id;


--
-- Name: certificato_compilato; Type: TABLE; Schema: logs; Owner: postgres
--

CREATE TABLE logs.certificato_compilato (
    id bigint NOT NULL,
    info character varying
);


ALTER TABLE logs.certificato_compilato OWNER TO postgres;

--
-- Name: certificato_compilato_id_seq; Type: SEQUENCE; Schema: logs; Owner: postgres
--

CREATE SEQUENCE logs.certificato_compilato_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE logs.certificato_compilato_id_seq OWNER TO postgres;

--
-- Name: certificato_compilato_id_seq; Type: SEQUENCE OWNED BY; Schema: logs; Owner: postgres
--

ALTER SEQUENCE logs.certificato_compilato_id_seq OWNED BY logs.certificato_compilato.id;


--
-- Name: campo_valori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campo_valori (
    id bigint NOT NULL,
    id_certificato_compilato bigint,
    id_campo bigint,
    valore character varying,
    id_campo_ref bigint,
    index integer,
    id_tipo_prodotto bigint,
    riporta_tipo_prodotto boolean,
    valore_statistico integer
);


ALTER TABLE public.campo_valori OWNER TO postgres;

--
-- Name: campo_valori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.campo_valori_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campo_valori_id_seq OWNER TO postgres;

--
-- Name: campo_valori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.campo_valori_id_seq OWNED BY public.campo_valori.id;


--
-- Name: certificati; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificati (
    id bigint NOT NULL,
    descr character varying,
    id_country integer,
    id_tipo_prodotto integer,
    id_modulo_corrente integer,
    validita tsrange DEFAULT tsrange((CURRENT_TIMESTAMP)::timestamp without time zone, NULL::timestamp without time zone),
    descr_estera character varying
);


ALTER TABLE public.certificati OWNER TO postgres;

--
-- Name: certificati_compilati; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificati_compilati (
    id bigint NOT NULL,
    file bytea,
    id_access bigint,
    id_modulo bigint,
    entered timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_stato_certificato_compilato bigint,
    data_proposta timestamp without time zone,
    data_controllo timestamp without time zone,
    descr character varying,
    id_stabilimento bigint,
    motivo_integrazione character varying,
    presa_in_carico boolean DEFAULT false,
    orario_proposto tsrange,
    num_certificato character varying,
    id_node_denominazione_prodotto bigint,
    id_access_sblocco bigint,
    id_evento_calendario bigint,
    id_trf_attivita bigint,
    id_country_generico bigint,
    data_accettazione timestamp without time zone,
    orario_controllo tsrange,
    motivo_annullamento character varying,
    file_accettato bytea,
    id_evento_accorpato bigint
);


ALTER TABLE public.certificati_compilati OWNER TO postgres;

--
-- Name: certificati_compilati_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.certificati_compilati_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.certificati_compilati_id_seq OWNER TO postgres;

--
-- Name: certificati_compilati_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.certificati_compilati_id_seq OWNED BY public.certificati_compilati.id;


--
-- Name: certificati_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.certificati_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.certificati_id_seq OWNER TO postgres;

--
-- Name: certificati_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.certificati_id_seq OWNED BY public.certificati.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id bigint NOT NULL,
    descr character varying
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_id_seq OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: fine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fine (
    upper timestamp without time zone
);


ALTER TABLE public.fine OWNER TO postgres;

--
-- Name: lista_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lista_id_seq
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lista_id_seq OWNER TO postgres;

--
-- Name: lista_valori__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lista_valori__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lista_valori__id_seq OWNER TO postgres;

--
-- Name: moduli; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moduli (
    id bigint NOT NULL,
    id_tipo_modulo integer,
    descr character varying,
    filename_template character varying,
    codice character varying,
    nota character varying,
    validita tsrange,
    url character varying,
    id_certificato bigint
);


ALTER TABLE public.moduli OWNER TO postgres;

--
-- Name: moduli_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.moduli_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moduli_id_seq OWNER TO postgres;

--
-- Name: moduli_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.moduli_id_seq OWNED BY public.moduli.id;


--
-- Name: modulo_campi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modulo_campi (
    id bigint NOT NULL,
    id_modulo bigint,
    nome_campo character varying,
    id_tipo_campo bigint,
    multiple boolean DEFAULT false,
    id_modulo_campo_ref bigint,
    id_query bigint,
    ord real,
    id_anagrafica_lista bigint,
    obbligatorio boolean DEFAULT false,
    id_campo_traduzione bigint,
    dipende_tipo_certificato boolean DEFAULT false NOT NULL,
    label character varying,
    font_size integer DEFAULT 10,
    campo_traduzione character varying
);


ALTER TABLE public.modulo_campi OWNER TO postgres;

--
-- Name: modulo_campi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modulo_campi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modulo_campi_id_seq OWNER TO postgres;

--
-- Name: modulo_campi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modulo_campi_id_seq OWNED BY public.modulo_campi.id;


--
-- Name: num_certificato; Type: SEQUENCE; Schema: public; Owner: gisa_fvg
--

CREATE SEQUENCE public.num_certificato
    START WITH 55
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.num_certificato OWNER TO gisa_fvg;

--
-- Name: query; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.query (
    id bigint NOT NULL,
    query character varying,
    params character varying,
    label character varying,
    calcolo_a_posteriori boolean DEFAULT false NOT NULL,
    numero_certificato boolean DEFAULT false NOT NULL
);


ALTER TABLE public.query OWNER TO postgres;

--
-- Name: query_campo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.query_campo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.query_campo_id_seq OWNER TO postgres;

--
-- Name: query_campo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.query_campo_id_seq OWNED BY public.query.id;


--
-- Name: ret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ret (
    esito boolean,
    valore text,
    msg character varying,
    info character varying,
    err_msg character varying
);


ALTER TABLE public.ret OWNER TO postgres;

--
-- Name: tree_nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tree_nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tree_nodes_id_seq OWNER TO postgres;

--
-- Name: tree_nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tree_nodes_id_seq OWNED BY public.tree_nodes.id;


--
-- Name: trees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trees_id_seq OWNER TO postgres;

--
-- Name: trees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trees_id_seq OWNED BY public.trees.id;


--
-- Name: tipo_modulo; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.tipo_modulo (
    id bigint NOT NULL,
    descr character varying
);


ALTER TABLE types.tipo_modulo OWNER TO postgres;

--
-- Name: vw_certificati; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_certificati AS
 SELECT c.id AS id_certificato,
    c.id,
    c.descr,
    c.id_country,
    c.id_tipo_prodotto,
    c.id_modulo_corrente,
    c.validita,
    c.descr_estera,
    m.filename_template,
    m.nota,
    m.url,
    m.codice,
    m.descr AS descr_modulo,
    m.id_tipo_modulo,
    tm.descr AS descr_tipo_modulo
   FROM ((public.certificati c
     JOIN public.moduli m ON ((c.id_modulo_corrente = m.id)))
     JOIN types.tipo_modulo tm ON ((m.id_tipo_modulo = tm.id)))
  ORDER BY c.descr;


ALTER TABLE public.vw_certificati OWNER TO postgres;

--
-- Name: vw_countries; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_countries AS
 SELECT c.id AS id_country,
    c.id,
    c.descr,
    count(DISTINCT cc.id) AS n_moduli_compilati
   FROM (public.countries c
     LEFT JOIN public.certificati cc ON (((cc.id_country = c.id) AND (cc.id_modulo_corrente IS NOT NULL) AND upper_inf(cc.validita))))
  GROUP BY c.id, c.descr
  ORDER BY c.id;


ALTER TABLE public.vw_countries OWNER TO postgres;

--
-- Name: tipo_campo; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.tipo_campo (
    id bigint NOT NULL,
    descr character varying,
    configurabile_statico boolean,
    label character varying
);


ALTER TABLE types.tipo_campo OWNER TO postgres;

--
-- Name: vw_get_certificato_compilato_valori; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_get_certificato_compilato_valori AS
 SELECT mc.id,
    mc.id_modulo,
    mc.nome_campo,
    mc.id_tipo_campo,
    tc.descr,
    cv.valore,
    cc.id AS id_certificato_compilato,
    mc.id_modulo_campo_ref,
    cv.index,
    mc.id_anagrafica_lista,
    l.descr AS anagrafica,
    mc.id_campo_traduzione,
    mc.obbligatorio,
    cv.id_tipo_prodotto,
    l.rif_tipo_prodotto AS dipende_tipo_certificato,
    tn.descr AS descr_tipo_prodotto,
    q.calcolo_a_posteriori,
    c.descr AS descr_modulo,
    mc.label,
    mc.font_size,
    cv.riporta_tipo_prodotto,
    cv.valore_statistico,
    cc.id_stabilimento,
    cc.id_access
   FROM ((((((((public.certificati_compilati cc
     JOIN public.campo_valori cv ON ((cv.id_certificato_compilato = cc.id)))
     JOIN public.modulo_campi mc ON ((cv.id_campo = mc.id)))
     JOIN types.tipo_campo tc ON ((tc.id = mc.id_tipo_campo)))
     LEFT JOIN anagrafica.lista l ON ((l.id = mc.id_anagrafica_lista)))
     LEFT JOIN public.tree_nodes tn ON ((tn.id = cv.id_tipo_prodotto)))
     LEFT JOIN public.query q ON ((q.id = mc.id_query)))
     JOIN public.moduli m ON ((m.id = mc.id_modulo)))
     JOIN public.certificati c ON ((c.id = m.id_certificato)))
  WHERE (mc.id_modulo_campo_ref IS NULL)
  ORDER BY cv.index, mc.ord;


ALTER TABLE public.vw_get_certificato_compilato_valori OWNER TO postgres;

--
-- Name: vw_get_comuni; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_get_comuni AS
 SELECT t.id,
    t.cod_comune,
    t.cod_regione,
    t.cod_provincia,
    t.nome,
    t.istat,
    t.codiceistatasl,
    t.codice,
    t.codice_old,
    t.codiceistatasl_old,
    t.cap,
    t.notused,
    t.cod_nazione,
    t.codiceasl_bdn,
    t.codice_nuovo,
    t.codice_nuovo_,
    t.istat_comune_provincia,
    t.cap_,
    t.istat_pre,
    t.note_hd,
    t.reverse_cap,
    t.codice_catastale,
    t.denominazione_it
   FROM public.dblink((('dbname=gisa_fvg'::text || (( SELECT conf.valore
           FROM conf.conf
          WHERE ((conf.descr)::text = 'postfix_ambiente'::text)))::text) || ' port=5432 host=127.0.0.1 user=postgres'::text), 'select * from public.comuni1'::text) t(id integer, cod_comune character varying, cod_regione character varying, cod_provincia character varying, nome character varying, istat character varying, codiceistatasl character varying, codice character varying, codice_old character varying, codiceistatasl_old character varying, cap text, notused boolean, cod_nazione integer, codiceasl_bdn text, codice_nuovo text, codice_nuovo_ text, istat_comune_provincia character varying, cap_ character varying, istat_pre character varying, note_hd text, reverse_cap text, codice_catastale character varying, denominazione_it character varying)
  WHERE ((t.notused = false) OR (t.notused IS NULL));


ALTER TABLE public.vw_get_comuni OWNER TO postgres;

--
-- Name: access; Type: TABLE; Schema: um; Owner: postgres
--

CREATE TABLE um.access (
    id bigint NOT NULL,
    id_contact bigint,
    username character varying,
    password character varying,
    id_role bigint,
    id_stato_registrazione bigint,
    entered timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    trashed timestamp without time zone,
    id_asl integer,
    id_access_gisa bigint,
    responsabile_asl boolean,
    id_nominativo_struttura bigint
);


ALTER TABLE um.access OWNER TO postgres;

--
-- Name: contact; Type: TABLE; Schema: um; Owner: postgres
--

CREATE TABLE um.contact (
    id bigint NOT NULL,
    nome character varying,
    cognome character varying,
    codice_fiscale character varying,
    entered timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    email character varying
);


ALTER TABLE um.contact OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: um; Owner: postgres
--

CREATE TABLE um.role (
    id bigint NOT NULL,
    descr character varying,
    label character varying
);


ALTER TABLE um.role OWNER TO postgres;

--
-- Name: get_user; Type: VIEW; Schema: um; Owner: postgres
--

CREATE VIEW um.get_user AS
 SELECT a.id,
    a.id_contact,
    a.id_role,
    c.nome,
    c.cognome,
    c.codice_fiscale,
    r.descr AS role_descr,
    r.label AS role_label,
    c.email,
    a.id_asl,
    a.id_access_gisa
   FROM ((um.contact c
     JOIN um.access a ON ((c.id = a.id_contact)))
     JOIN um.role r ON ((r.id = a.id_role)));


ALTER TABLE um.get_user OWNER TO postgres;

--
-- Name: vw_get_veterinari_stab; Type: VIEW; Schema: um; Owner: postgres
--

CREATE VIEW um.vw_get_veterinari_stab AS
 SELECT DISTINCT t.az_cod_aziendale,
    t.sd_vet_cf
   FROM public.dblink('dbname=gisa_fvg port=5432 host=127.0.0.1 user=postgres'::text, 'select az_cod_aziendale, sd_vet_cf from conf_ext.fvg_gisa_imprese'::text) t(az_cod_aziendale text, sd_vet_cf text)
  WHERE (upper(t.sd_vet_cf) IN ( SELECT upper((get_user.codice_fiscale)::text) AS upper
           FROM um.get_user
          WHERE ((get_user.role_descr)::text = 'OPERATORE_ASL'::text)));


ALTER TABLE um.vw_get_veterinari_stab OWNER TO postgres;

--
-- Name: vw_get_stabilimenti; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_get_stabilimenti AS
 SELECT t.id_stabilimento,
    t.id,
    t.ragione_sociale,
    t.indirizzo,
    t.comune,
    t.provincia_stab,
    t.id_linea,
    t.cod_aziendale,
    t.asl_rif,
    t.partita_iva,
    t.asl,
    v.az_cod_aziendale,
    v.sd_vet_cf
   FROM (public.dblink((('dbname=mdgm_fvg'::text || (( SELECT conf.valore
           FROM conf.conf
          WHERE ((conf.descr)::text = 'postfix_ambiente'::text)))::text) || ' port=5432 host=127.0.0.1 user=postgres'::text), '
select 
distinct on(s.id) s.id as id_stabilimento,
s.id,
nome as ragione_sociale,
indirizzo_luogo as indirizzo, 
comune,
siglaprovincia as provincia_stab,
l.id_linea,
trim(s.sd_cod_regionale) as cod_aziendale,
s.id_asl as asl_rif,
piva_impresa as partita_iva,
a.descrizione as asl
from cu_anag.vw_stabilimenti s
join cu_anag.vw_linee l on s.id_stabilimento = l.id_stabilimento
join matrix.struttura_asl a on a.id_asl = s.id_asl and n_livello = 1 and anno = 2023
'::text) t(id_stabilimento bigint, id bigint, ragione_sociale text, indirizzo text, comune text, provincia_stab text, id_linea bigint, cod_aziendale text, asl_rif integer, partita_iva text, asl text)
     JOIN um.vw_get_veterinari_stab v ON ((replace(upper(t.cod_aziendale), ' '::text, ''::text) = replace(upper(v.az_cod_aziendale), ' '::text, ''::text))))
  WHERE ((t.comune ~~* 'SAN DANIELE%'::text) OR (replace(t.cod_aziendale, ' '::text, ''::text) ~~* 'CEIT9172L'::text));


ALTER TABLE public.vw_get_stabilimenti OWNER TO postgres;

--
-- Name: stati_certificato_compilato; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.stati_certificato_compilato (
    id bigint NOT NULL,
    descr character varying,
    iniziale boolean DEFAULT false,
    finale boolean DEFAULT false,
    id_permission bigint,
    icon character varying,
    modificabile boolean DEFAULT false,
    descr_azione character varying,
    is_bozza boolean DEFAULT false,
    ask_data_proposta boolean DEFAULT false,
    ask_data_controllo boolean DEFAULT false,
    ask_durata_controllo boolean DEFAULT false,
    ask_conferma_controllo boolean DEFAULT false,
    is_annulla boolean DEFAULT false,
    send_email_eliminazione boolean DEFAULT false,
    delete_prestazione boolean DEFAULT false,
    preaccettazione boolean DEFAULT false
);


ALTER TABLE types.stati_certificato_compilato OWNER TO postgres;

--
-- Name: vw_get_lista_certificati; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_get_lista_certificati AS
 SELECT cc.id AS id_certificato_compilato,
    m.id AS id_modulo,
    c.id AS id_certificato,
    c.descr AS descr_certificato,
    m.descr AS descr_modulo,
    cc.id_stato_certificato_compilato,
    scc.descr AS descr_stato_certificato_compilato,
    cc.id_access,
    cc.entered,
    cc.data_proposta,
    cc.data_controllo,
    cc.descr AS descr_certificato_compilato,
    cc.id_stabilimento,
    cc.num_certificato,
    s.ragione_sociale,
    cc.data_accettazione,
    COALESCE(c3.descr, c2.descr) AS paese
   FROM ((((((public.certificati_compilati cc
     LEFT JOIN public.moduli m ON ((cc.id_modulo = m.id)))
     JOIN public.certificati c ON ((c.id = m.id_certificato)))
     LEFT JOIN types.stati_certificato_compilato scc ON ((scc.id = cc.id_stato_certificato_compilato)))
     JOIN public.vw_get_stabilimenti s ON ((cc.id_stabilimento = s.id)))
     LEFT JOIN public.countries c2 ON ((c2.id = c.id_country)))
     LEFT JOIN public.countries c3 ON ((c3.id = cc.id_country_generico)));


ALTER TABLE public.vw_get_lista_certificati OWNER TO postgres;

--
-- Name: vw_get_voci_tariffa; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_get_voci_tariffa AS
 SELECT t.id_attivita,
    t.id_tariffa,
    t.sigla_tariffa,
    t.descr_tariffa,
    t.descr_voce,
    t.id_voce
   FROM public.dblink((('dbname=mdgm_fvg'::text || (( SELECT conf.valore
           FROM conf.conf
          WHERE ((conf.descr)::text = 'postfix_ambiente'::text)))::text) || ' port=5432 host=127.0.0.1 user=postgres'::text), 'select 
  a.id as id_attivita,
  t.id as id_tariffa,
  t.sigla as sigla_tariffa, 
  t.descr as descr_tariffa,
  tn.node_descr as descr_voce,
  tn.id as id_voce
  from 
  trf.trf_attivita a 
  join trf.tariffe t on t.id = a.id_tariffa 
  join matrix.tree_nodes tn on tn.id_parent = t.id and tn.id_tree = (select id from matrix.trees t2 where name = ''Tariffario'')
'::text) t(id_attivita bigint, id_tariffa bigint, sigla_tariffa character varying, descr_tariffa character varying, descr_voce character varying, id_voce bigint);


ALTER TABLE public.vw_get_voci_tariffa OWNER TO postgres;

--
-- Name: tipo_eventi; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.tipo_eventi (
    id bigint NOT NULL,
    descr character varying,
    modifica_inizio boolean,
    modifica_durata boolean,
    elimina boolean,
    inserisci boolean,
    sigla character varying
);


ALTER TABLE types.tipo_eventi OWNER TO postgres;

--
-- Name: vw_tipo_eventi; Type: VIEW; Schema: types; Owner: postgres
--

CREATE VIEW types.vw_tipo_eventi AS
 SELECT tipo_eventi.id,
    tipo_eventi.descr,
    tipo_eventi.modifica_inizio,
    tipo_eventi.modifica_durata,
    tipo_eventi.elimina,
    tipo_eventi.inserisci,
    tipo_eventi.sigla
   FROM types.tipo_eventi;


ALTER TABLE types.vw_tipo_eventi OWNER TO postgres;

--
-- Name: vw_tipo_eventi; Type: VIEW; Schema: srv; Owner: postgres
--

CREATE VIEW srv.vw_tipo_eventi AS
 SELECT vw_tipo_eventi.id,
    vw_tipo_eventi.descr,
    vw_tipo_eventi.sigla
   FROM types.vw_tipo_eventi;


ALTER TABLE srv.vw_tipo_eventi OWNER TO postgres;

--
-- Name: access_stabilimenti_19_01; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.access_stabilimenti_19_01 (
    id bigint,
    id_access bigint,
    id_stabilimento bigint,
    validita tsrange,
    id_responsabile bigint,
    dt timestamp without time zone,
    superuser boolean,
    validato_data timestamp without time zone,
    validato_da bigint
);


ALTER TABLE tmp.access_stabilimenti_19_01 OWNER TO postgres;

--
-- Name: certificati_compilati_19_01; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.certificati_compilati_19_01 (
    id bigint,
    file bytea,
    id_access bigint,
    id_modulo bigint,
    entered timestamp without time zone,
    id_stato_certificato_compilato bigint,
    data_proposta timestamp without time zone,
    data_controllo timestamp without time zone,
    descr character varying,
    id_stabilimento bigint,
    motivo_integrazione character varying,
    presa_in_carico boolean,
    orario_proposto tsrange,
    num_certificato character varying,
    id_node_denominazione_prodotto bigint,
    id_access_sblocco bigint,
    id_evento_calendario bigint,
    id_trf_attivita bigint,
    id_country_generico bigint,
    data_accettazione timestamp without time zone,
    orario_controllo tsrange,
    motivo_annullamento character varying
);


ALTER TABLE tmp.certificati_compilati_19_01 OWNER TO postgres;

--
-- Name: lista_valori_19_01; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.lista_valori_19_01 (
    id bigint,
    id_lista bigint,
    valore character varying,
    id_stabilimento bigint,
    id_node_denominazione_prodotto bigint,
    traduzione character varying
);


ALTER TABLE tmp.lista_valori_19_01 OWNER TO postgres;

--
-- Name: modulo_campi_2024_06_17; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.modulo_campi_2024_06_17 (
    id bigint,
    id_modulo bigint,
    nome_campo character varying,
    id_tipo_campo bigint,
    multiple boolean,
    id_modulo_campo_ref bigint,
    id_query bigint,
    ord integer,
    id_anagrafica_lista bigint,
    obbligatorio boolean,
    id_campo_traduzione bigint,
    dipende_tipo_certificato boolean,
    label character varying,
    font_size integer,
    campo_traduzione character varying
);


ALTER TABLE tmp.modulo_campi_2024_06_17 OWNER TO postgres;

--
-- Name: modulo_campi_2024_06_17_2; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.modulo_campi_2024_06_17_2 (
    id bigint,
    id_modulo bigint,
    nome_campo character varying,
    id_tipo_campo bigint,
    multiple boolean,
    id_modulo_campo_ref bigint,
    id_query bigint,
    ord real,
    id_anagrafica_lista bigint,
    obbligatorio boolean,
    id_campo_traduzione bigint,
    dipende_tipo_certificato boolean,
    label character varying,
    font_size integer,
    campo_traduzione character varying
);


ALTER TABLE tmp.modulo_campi_2024_06_17_2 OWNER TO postgres;

--
-- Name: modulo_campi_2024_07_27; Type: TABLE; Schema: tmp; Owner: gisa_fvg
--

CREATE TABLE tmp.modulo_campi_2024_07_27 (
    id bigint,
    id_modulo bigint,
    nome_campo character varying,
    id_tipo_campo bigint,
    multiple boolean,
    id_modulo_campo_ref bigint,
    id_query bigint,
    ord real,
    id_anagrafica_lista bigint,
    obbligatorio boolean,
    id_campo_traduzione bigint,
    dipende_tipo_certificato boolean,
    label character varying,
    font_size integer,
    campo_traduzione character varying
);


ALTER TABLE tmp.modulo_campi_2024_07_27 OWNER TO gisa_fvg;

--
-- Name: stati_certificato_compilato; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.stati_certificato_compilato (
    id bigint,
    descr character varying,
    iniziale boolean,
    finale boolean,
    id_permission bigint,
    icon character varying,
    modificabile boolean,
    descr_azione character varying,
    is_bozza boolean,
    ask_data_proposta boolean,
    ask_data_controllo boolean,
    ask_durata_controllo boolean,
    ask_conferma_controllo boolean
);


ALTER TABLE tmp.stati_certificato_compilato OWNER TO postgres;

--
-- Name: stati_certificato_compilato_prossimo; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.stati_certificato_compilato_prossimo (
    id bigint,
    id_stato_attuale bigint,
    id_stato_prossimo bigint
);


ALTER TABLE tmp.stati_certificato_compilato_prossimo OWNER TO postgres;

--
-- Name: tree_nodes_2024_03_05; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.tree_nodes_2024_03_05 (
    id bigint,
    id_tree bigint,
    descr character varying,
    id_node_parent bigint,
    ordinamento integer,
    data_scadenza timestamp without time zone
);


ALTER TABLE tmp.tree_nodes_2024_03_05 OWNER TO postgres;

--
-- Name: vw_get_stabilimenti_old; Type: TABLE; Schema: tmp; Owner: postgres
--

CREATE TABLE tmp.vw_get_stabilimenti_old (
    id bigint,
    riferimento_id integer,
    riferimento_id_nome_tab text,
    ragione_sociale text,
    asl_rif integer,
    asl text,
    codice_fiscale text,
    codice_fiscale_rappresentante text,
    partita_iva text,
    n_reg text,
    nominativo_rappresentante text,
    comune text,
    provincia_stab text,
    indirizzo text,
    cap_stab text,
    comune_leg text,
    provincia_leg text,
    indirizzo_leg text,
    cap_leg text,
    latitudine_stab double precision,
    longitudine_stab double precision,
    categoria_rischio integer,
    prossimo_controllo timestamp without time zone,
    id_controllo_ultima_categorizzazione integer,
    data_controllo_ultima_categorizzazione timestamp without time zone,
    tipo_categorizzazione text,
    data_inserimento timestamp without time zone,
    livello_rischio text,
    riferimento_id_impresa integer,
    riferimento_nome_tab_impresa text,
    id_impresa bigint,
    approval_number text,
    sd_vet_cf text,
    id_linea bigint
);


ALTER TABLE tmp.vw_get_stabilimenti_old OWNER TO postgres;

--
-- Name: az_lookup_comuni; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.az_lookup_comuni (
    id integer,
    com_id integer,
    istat integer,
    descrizione character varying,
    cap integer,
    id_fiscale character varying,
    superficie real,
    id_provincia integer,
    ref_id integer,
    utente_id integer,
    latitudine_min real,
    latitudine_max real,
    longitudine_min real,
    longitudine_max real,
    id_comune integer,
    dt_timerange character varying
);


ALTER TABLE types.az_lookup_comuni OWNER TO postgres;

--
-- Name: ml; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.ml (
    id bigint,
    att character varying,
    sez character varying
);


ALTER TABLE types.ml OWNER TO postgres;

--
-- Name: stati_certificato_compilato_id_seq; Type: SEQUENCE; Schema: types; Owner: postgres
--

CREATE SEQUENCE types.stati_certificato_compilato_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types.stati_certificato_compilato_id_seq OWNER TO postgres;

--
-- Name: stati_certificato_compilato_id_seq; Type: SEQUENCE OWNED BY; Schema: types; Owner: postgres
--

ALTER SEQUENCE types.stati_certificato_compilato_id_seq OWNED BY types.stati_certificato_compilato.id;


--
-- Name: stati_certificato_compilato_prossimo; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.stati_certificato_compilato_prossimo (
    id bigint NOT NULL,
    id_stato_attuale bigint,
    id_stato_prossimo bigint
);


ALTER TABLE types.stati_certificato_compilato_prossimo OWNER TO postgres;

--
-- Name: stati_certificato_compilato_prossimo_id_seq; Type: SEQUENCE; Schema: types; Owner: postgres
--

CREATE SEQUENCE types.stati_certificato_compilato_prossimo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types.stati_certificato_compilato_prossimo_id_seq OWNER TO postgres;

--
-- Name: stati_certificato_compilato_prossimo_id_seq; Type: SEQUENCE OWNED BY; Schema: types; Owner: postgres
--

ALTER SEQUENCE types.stati_certificato_compilato_prossimo_id_seq OWNED BY types.stati_certificato_compilato_prossimo.id;


--
-- Name: stato_eventi; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.stato_eventi (
    id bigint NOT NULL,
    descr character varying NOT NULL,
    colore character varying,
    id_tipo_evento bigint,
    effettuata boolean,
    scaduta boolean
);


ALTER TABLE types.stato_eventi OWNER TO postgres;

--
-- Name: stato_eventi_id_seq; Type: SEQUENCE; Schema: types; Owner: postgres
--

CREATE SEQUENCE types.stato_eventi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types.stato_eventi_id_seq OWNER TO postgres;

--
-- Name: stato_eventi_id_seq; Type: SEQUENCE OWNED BY; Schema: types; Owner: postgres
--

ALTER SEQUENCE types.stato_eventi_id_seq OWNED BY types.stato_eventi.id;


--
-- Name: tipi_certificato; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.tipi_certificato (
    id integer NOT NULL,
    descr character varying
);


ALTER TABLE types.tipi_certificato OWNER TO postgres;

--
-- Name: tipi_certificato_id_seq; Type: SEQUENCE; Schema: types; Owner: postgres
--

CREATE SEQUENCE types.tipi_certificato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types.tipi_certificato_id_seq OWNER TO postgres;

--
-- Name: tipi_certificato_id_seq; Type: SEQUENCE OWNED BY; Schema: types; Owner: postgres
--

ALTER SEQUENCE types.tipi_certificato_id_seq OWNED BY types.tipi_certificato.id;


--
-- Name: tipo_campo_id_seq; Type: SEQUENCE; Schema: types; Owner: postgres
--

CREATE SEQUENCE types.tipo_campo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types.tipo_campo_id_seq OWNER TO postgres;

--
-- Name: tipo_campo_id_seq; Type: SEQUENCE OWNED BY; Schema: types; Owner: postgres
--

ALTER SEQUENCE types.tipo_campo_id_seq OWNED BY types.tipo_campo.id;


--
-- Name: tipo_eventi_id_seq; Type: SEQUENCE; Schema: types; Owner: postgres
--

CREATE SEQUENCE types.tipo_eventi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types.tipo_eventi_id_seq OWNER TO postgres;

--
-- Name: tipo_eventi_id_seq; Type: SEQUENCE OWNED BY; Schema: types; Owner: postgres
--

ALTER SEQUENCE types.tipo_eventi_id_seq OWNED BY types.tipo_eventi.id;


--
-- Name: tipo_modulo_id_seq; Type: SEQUENCE; Schema: types; Owner: postgres
--

CREATE SEQUENCE types.tipo_modulo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types.tipo_modulo_id_seq OWNER TO postgres;

--
-- Name: tipo_modulo_id_seq; Type: SEQUENCE OWNED BY; Schema: types; Owner: postgres
--

ALTER SEQUENCE types.tipo_modulo_id_seq OWNED BY types.tipo_modulo.id;


--
-- Name: tipo_prodotto; Type: TABLE; Schema: types; Owner: postgres
--

CREATE TABLE types.tipo_prodotto (
    id bigint NOT NULL,
    descr character varying
);


ALTER TABLE types.tipo_prodotto OWNER TO postgres;

--
-- Name: tipo_prodotto_id_seq; Type: SEQUENCE; Schema: types; Owner: postgres
--

CREATE SEQUENCE types.tipo_prodotto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE types.tipo_prodotto_id_seq OWNER TO postgres;

--
-- Name: tipo_prodotto_id_seq; Type: SEQUENCE OWNED BY; Schema: types; Owner: postgres
--

ALTER SEQUENCE types.tipo_prodotto_id_seq OWNED BY types.tipo_prodotto.id;


--
-- Name: permission; Type: TABLE; Schema: um; Owner: postgres
--

CREATE TABLE um.permission (
    id bigint NOT NULL,
    permission text
);


ALTER TABLE um.permission OWNER TO postgres;

--
-- Name: vw_stato_certificato_compilato_prossimo; Type: VIEW; Schema: types; Owner: postgres
--

CREATE VIEW types.vw_stato_certificato_compilato_prossimo AS
 SELECT scc.id AS id_stato_attuale,
    scc.descr AS descr_stato_attuale,
    scc2.id AS id_stato_prossimo,
    scc2.descr AS descr_stato_prossimo,
    scc.iniziale AS iniziale_stato_attuale,
    scc.finale AS finale_stato_attuale,
    scc2.iniziale AS iniziale_stato_prossimo,
    scc2.finale AS finale_stato_prossimo,
    scc.icon AS icona_stato_attuale,
    scc2.icon AS icona_stato_prossimo,
    scc2.id_permission,
    p.permission,
    scc.modificabile AS modificabile_stato_attuale,
    scc2.modificabile AS modificabile_stato_prossimo,
    scc.descr_azione AS descr_azione_stato_attuale,
    scc2.descr_azione AS descr_azione_stato_prossimo,
    scc.is_bozza AS is_bozza_stato_attuale,
    scc2.is_bozza AS is_bozza_stato_prossimo,
    scc.ask_data_proposta AS ask_data_proposta_stato_attuale,
    scc2.ask_data_proposta AS ask_data_proposta_stato_prossimo,
    scc.ask_data_controllo AS ask_data_controllo_stato_attuale,
    scc2.ask_data_controllo AS ask_data_controllo_stato_prossimo,
    scc.ask_durata_controllo AS ask_durata_controllo_stato_attuale,
    scc2.ask_durata_controllo AS ask_durata_controllo_stato_prossimo,
    scc.ask_conferma_controllo AS ask_conferma_controllo_stato_attuale,
    scc2.ask_conferma_controllo AS ask_conferma_controllo_stato_prossimo,
    scc.is_annulla AS is_annulla_stato_attuale,
    scc2.is_annulla AS is_annulla_stato_prossimo,
    scc.send_email_eliminazione AS send_email_eliminazione_stato_attuale,
    scc2.send_email_eliminazione AS send_email_eliminazione_stato_prossimo,
    scc2.delete_prestazione AS delete_prestazione_stato_prossimo,
    scc.preaccettazione AS preaccettazione_stato_attuale,
    scc2.preaccettazione AS preaccettazione_stato_prossimo
   FROM (((types.stati_certificato_compilato scc
     JOIN types.stati_certificato_compilato_prossimo sccp ON ((scc.id = sccp.id_stato_attuale)))
     JOIN types.stati_certificato_compilato scc2 ON ((scc2.id = sccp.id_stato_prossimo)))
     LEFT JOIN um.permission p ON ((p.id = scc2.id_permission)))
  ORDER BY scc2.finale, scc2.id;


ALTER TABLE types.vw_stato_certificato_compilato_prossimo OWNER TO postgres;

--
-- Name: vw_stato_eventi; Type: VIEW; Schema: types; Owner: postgres
--

CREATE VIEW types.vw_stato_eventi AS
 SELECT ase.id,
    ase.descr,
    ase.colore,
    ase.id_tipo_evento,
    ase.effettuata,
    ase.scaduta
   FROM types.stato_eventi ase;


ALTER TABLE types.vw_stato_eventi OWNER TO postgres;

--
-- Name: grid_definition; Type: TABLE; Schema: ui; Owner: postgres
--

CREATE TABLE ui.grid_definition (
    id bigint NOT NULL,
    funct character varying,
    id_user bigint,
    type_user character varying,
    str_conf character varying,
    note character varying
);


ALTER TABLE ui.grid_definition OWNER TO postgres;

--
-- Name: grid_definition_id_seq; Type: SEQUENCE; Schema: ui; Owner: postgres
--

CREATE SEQUENCE ui.grid_definition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ui.grid_definition_id_seq OWNER TO postgres;

--
-- Name: grid_definition_id_seq; Type: SEQUENCE OWNED BY; Schema: ui; Owner: postgres
--

ALTER SEQUENCE ui.grid_definition_id_seq OWNED BY ui.grid_definition.id;


--
-- Name: menu; Type: TABLE; Schema: ui; Owner: postgres
--

CREATE TABLE ui.menu (
    id integer NOT NULL,
    cod character varying
);


ALTER TABLE ui.menu OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: ui; Owner: postgres
--

CREATE SEQUENCE ui.menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ui.menu_id_seq OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: ui; Owner: postgres
--

ALTER SEQUENCE ui.menu_id_seq OWNED BY ui.menu.id;


--
-- Name: menu_item_modes; Type: TABLE; Schema: ui; Owner: postgres
--

CREATE TABLE ui.menu_item_modes (
    id integer NOT NULL,
    id_menu_item integer,
    lev integer,
    modality character varying
);


ALTER TABLE ui.menu_item_modes OWNER TO postgres;

--
-- Name: menu_item_modes_id_seq; Type: SEQUENCE; Schema: ui; Owner: postgres
--

CREATE SEQUENCE ui.menu_item_modes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ui.menu_item_modes_id_seq OWNER TO postgres;

--
-- Name: menu_item_modes_id_seq; Type: SEQUENCE OWNED BY; Schema: ui; Owner: postgres
--

ALTER SEQUENCE ui.menu_item_modes_id_seq OWNED BY ui.menu_item_modes.id;


--
-- Name: menu_item_roles; Type: TABLE; Schema: ui; Owner: postgres
--

CREATE TABLE ui.menu_item_roles (
    id bigint NOT NULL,
    id_menu_item bigint NOT NULL,
    id_role bigint NOT NULL
);


ALTER TABLE ui.menu_item_roles OWNER TO postgres;

--
-- Name: menu_item_roles_id_seq; Type: SEQUENCE; Schema: ui; Owner: postgres
--

CREATE SEQUENCE ui.menu_item_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ui.menu_item_roles_id_seq OWNER TO postgres;

--
-- Name: menu_item_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: ui; Owner: postgres
--

ALTER SEQUENCE ui.menu_item_roles_id_seq OWNED BY ui.menu_item_roles.id;


--
-- Name: menu_items; Type: TABLE; Schema: ui; Owner: postgres
--

CREATE TABLE ui.menu_items (
    id integer NOT NULL,
    id_menu integer NOT NULL,
    descr character varying,
    cod character varying,
    ord integer
);


ALTER TABLE ui.menu_items OWNER TO postgres;

--
-- Name: menu_items_id_seq; Type: SEQUENCE; Schema: ui; Owner: postgres
--

CREATE SEQUENCE ui.menu_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ui.menu_items_id_seq OWNER TO postgres;

--
-- Name: menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: ui; Owner: postgres
--

ALTER SEQUENCE ui.menu_items_id_seq OWNED BY ui.menu_items.id;


--
-- Name: messaggi_ui; Type: TABLE; Schema: ui; Owner: postgres
--

CREATE TABLE ui.messaggi_ui (
    id bigint NOT NULL,
    procedura character varying,
    valore bigint,
    msg character varying
);


ALTER TABLE ui.messaggi_ui OWNER TO postgres;

--
-- Name: vw_email_info; Type: VIEW; Schema: ui; Owner: postgres
--

CREATE VIEW ui.vw_email_info AS
SELECT
    NULL::text AS ragione_sociale,
    NULL::text AS indirizzo,
    NULL::text AS comune,
    NULL::text AS provincia_stab,
    NULL::timestamp without time zone AS data_proposta,
    NULL::character varying AS paese,
    NULL::text AS prodotti,
    NULL::bigint AS id_certificato_compilato,
    NULL::character varying AS email,
    NULL::tsrange AS orario_proposto,
    NULL::bytea AS file;


ALTER TABLE ui.vw_email_info OWNER TO postgres;

--
-- Name: access_id_seq; Type: SEQUENCE; Schema: um; Owner: postgres
--

CREATE SEQUENCE um.access_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE um.access_id_seq OWNER TO postgres;

--
-- Name: access_id_seq; Type: SEQUENCE OWNED BY; Schema: um; Owner: postgres
--

ALTER SEQUENCE um.access_id_seq OWNED BY um.access.id;


--
-- Name: access_stabilimenti; Type: TABLE; Schema: um; Owner: postgres
--

CREATE TABLE um.access_stabilimenti (
    id bigint NOT NULL,
    id_access bigint,
    id_stabilimento bigint,
    validita tsrange,
    id_responsabile bigint,
    dt timestamp without time zone,
    superuser boolean DEFAULT false,
    validato_data timestamp without time zone,
    validato_da bigint,
    rifiutato_data timestamp without time zone
);


ALTER TABLE um.access_stabilimenti OWNER TO postgres;

--
-- Name: access_stabilimenti_id_seq; Type: SEQUENCE; Schema: um; Owner: postgres
--

CREATE SEQUENCE um.access_stabilimenti_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE um.access_stabilimenti_id_seq OWNER TO postgres;

--
-- Name: access_stabilimenti_id_seq; Type: SEQUENCE OWNED BY; Schema: um; Owner: postgres
--

ALTER SEQUENCE um.access_stabilimenti_id_seq OWNED BY um.access_stabilimenti.id;


--
-- Name: contact_id_seq; Type: SEQUENCE; Schema: um; Owner: postgres
--

CREATE SEQUENCE um.contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE um.contact_id_seq OWNER TO postgres;

--
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: um; Owner: postgres
--

ALTER SEQUENCE um.contact_id_seq OWNED BY um.contact.id;


--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: um; Owner: postgres
--

CREATE SEQUENCE um.permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE um.permission_id_seq OWNER TO postgres;

--
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: um; Owner: postgres
--

ALTER SEQUENCE um.permission_id_seq OWNED BY um.permission.id;


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: um; Owner: postgres
--

CREATE SEQUENCE um.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE um.role_id_seq OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: um; Owner: postgres
--

ALTER SEQUENCE um.role_id_seq OWNED BY um.role.id;


--
-- Name: role_permission; Type: TABLE; Schema: um; Owner: postgres
--

CREATE TABLE um.role_permission (
    id bigint NOT NULL,
    id_role bigint,
    id_permission bigint
);


ALTER TABLE um.role_permission OWNER TO postgres;

--
-- Name: role_permission_id_seq; Type: SEQUENCE; Schema: um; Owner: postgres
--

CREATE SEQUENCE um.role_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE um.role_permission_id_seq OWNER TO postgres;

--
-- Name: role_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: um; Owner: postgres
--

ALTER SEQUENCE um.role_permission_id_seq OWNED BY um.role_permission.id;


--
-- Name: vw_contact; Type: VIEW; Schema: um; Owner: postgres
--

CREATE VIEW um.vw_contact AS
 SELECT contact.id,
    contact.id AS id_contact,
    contact.nome,
    contact.cognome,
    contact.codice_fiscale
   FROM um.contact;


ALTER TABLE um.vw_contact OWNER TO postgres;

--
-- Name: vw_access; Type: VIEW; Schema: um; Owner: postgres
--

CREATE VIEW um.vw_access AS
 SELECT a.id,
    a.id AS id_access,
    a.id_contact,
    a.username,
    a.id_role,
    c.nome,
    c.cognome,
    c.codice_fiscale
   FROM (um.access a
     JOIN um.vw_contact c ON ((a.id_contact = c.id_contact)));


ALTER TABLE um.vw_access OWNER TO postgres;

--
-- Name: vw_access_stabilimenti; Type: VIEW; Schema: um; Owner: postgres
--

CREATE VIEW um.vw_access_stabilimenti AS
 SELECT a_s.id,
    a_s.id AS id_access_stabilimento,
    a_s.validita,
    lower(a_s.validita) AS valido_da,
    upper(a_s.validita) AS valido_a,
    a_s.dt,
    r.id_access AS id_access_responsabile,
    r.nome AS nome_responsabile,
    r.cognome AS cognome_responabile,
    d.id_access AS id_access_delegato,
    d.nome AS nome_delegato,
    d.cognome AS cognome_delegato,
    s.ragione_sociale,
    s.comune,
    s.id AS id_stabilimento,
    (lower(a_s.validita) > CURRENT_TIMESTAMP) AS cancellabile,
    (upper(a_s.validita) > CURRENT_TIMESTAMP) AS modificabile,
    d.codice_fiscale,
    a_s.superuser,
    a_s.validato_data,
    a_s.validato_da
   FROM (((um.access_stabilimenti a_s
     JOIN um.vw_access d ON ((a_s.id_access = d.id_access)))
     JOIN um.vw_access r ON ((r.id_access = a_s.id_responsabile)))
     JOIN public.vw_get_stabilimenti s ON ((s.id = a_s.id_stabilimento)));


ALTER TABLE um.vw_access_stabilimenti OWNER TO postgres;

--
-- Name: vw_role_permission; Type: VIEW; Schema: um; Owner: postgres
--

CREATE VIEW um.vw_role_permission AS
 SELECT rp.id_role,
    rp.id_permission,
    r.descr AS descr_role,
    p.permission AS descr_permission
   FROM ((um.role r
     JOIN um.role_permission rp ON ((r.id = rp.id_role)))
     JOIN um.permission p ON ((p.id = rp.id_permission)));


ALTER TABLE um.vw_role_permission OWNER TO postgres;

--
-- Name: vw_user_stabilimenti; Type: VIEW; Schema: um; Owner: postgres
--

CREATE VIEW um.vw_user_stabilimenti AS
 SELECT u.id_contact,
    u.id_role,
    u.nome,
    u.cognome,
    u.codice_fiscale AS codice_fiscale_contact,
    u.role_descr,
    u.role_label,
    a.id_access,
    s.id_stabilimento,
    s.id,
    s.ragione_sociale,
    s.indirizzo,
    s.comune,
    s.provincia_stab,
    s.id_linea,
    s.cod_aziendale,
    s.asl_rif,
    s.partita_iva,
    s.asl,
    s.az_cod_aziendale,
    s.sd_vet_cf,
    a.superuser
   FROM ((um.get_user u
     JOIN um.access_stabilimenti a ON ((u.id = a.id_access)))
     JOIN public.vw_get_stabilimenti s ON ((s.id = a.id_stabilimento)))
  WHERE ((a.validato_data IS NOT NULL) OR (a.id_responsabile IS NOT NULL))
  ORDER BY s.partita_iva, a.id_access;


ALTER TABLE um.vw_user_stabilimenti OWNER TO postgres;

--
-- Name: gestore id; Type: DEFAULT; Schema: anagrafica; Owner: postgres
--

ALTER TABLE ONLY anagrafica.gestore ALTER COLUMN id SET DEFAULT nextval('anagrafica.gestore_id_seq'::regclass);


--
-- Name: lista id; Type: DEFAULT; Schema: anagrafica; Owner: postgres
--

ALTER TABLE ONLY anagrafica.lista ALTER COLUMN id SET DEFAULT nextval('anagrafica.lista_id_seq'::regclass);


--
-- Name: lista_valori id; Type: DEFAULT; Schema: anagrafica; Owner: postgres
--

ALTER TABLE ONLY anagrafica.lista_valori ALTER COLUMN id SET DEFAULT nextval('anagrafica.lista_valori_id_seq'::regclass);


--
-- Name: call_logs id; Type: DEFAULT; Schema: log; Owner: postgres
--

ALTER TABLE ONLY log.call_logs ALTER COLUMN id SET DEFAULT nextval('log.call_logs_id_seq'::regclass);


--
-- Name: operazioni id; Type: DEFAULT; Schema: log; Owner: postgres
--

ALTER TABLE ONLY log.operazioni ALTER COLUMN id SET DEFAULT nextval('log.operazioni_id_seq'::regclass);


--
-- Name: transazioni id; Type: DEFAULT; Schema: log; Owner: postgres
--

ALTER TABLE ONLY log.transazioni ALTER COLUMN id SET DEFAULT nextval('log.transazioni_id_seq'::regclass);


--
-- Name: certificato_compilato id; Type: DEFAULT; Schema: logs; Owner: postgres
--

ALTER TABLE ONLY logs.certificato_compilato ALTER COLUMN id SET DEFAULT nextval('logs.certificato_compilato_id_seq'::regclass);


--
-- Name: campo_valori id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campo_valori ALTER COLUMN id SET DEFAULT nextval('public.campo_valori_id_seq'::regclass);


--
-- Name: certificati id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificati ALTER COLUMN id SET DEFAULT nextval('public.certificati_id_seq'::regclass);


--
-- Name: certificati_compilati id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificati_compilati ALTER COLUMN id SET DEFAULT nextval('public.certificati_compilati_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: moduli id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moduli ALTER COLUMN id SET DEFAULT nextval('public.moduli_id_seq'::regclass);


--
-- Name: modulo_campi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo_campi ALTER COLUMN id SET DEFAULT nextval('public.modulo_campi_id_seq'::regclass);


--
-- Name: query id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.query ALTER COLUMN id SET DEFAULT nextval('public.query_campo_id_seq'::regclass);


--
-- Name: tree_nodes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tree_nodes ALTER COLUMN id SET DEFAULT nextval('public.tree_nodes_id_seq'::regclass);


--
-- Name: trees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trees ALTER COLUMN id SET DEFAULT nextval('public.trees_id_seq'::regclass);


--
-- Name: stati_certificato_compilato id; Type: DEFAULT; Schema: types; Owner: postgres
--

ALTER TABLE ONLY types.stati_certificato_compilato ALTER COLUMN id SET DEFAULT nextval('types.stati_certificato_compilato_id_seq'::regclass);


--
-- Name: stati_certificato_compilato_prossimo id; Type: DEFAULT; Schema: types; Owner: postgres
--

ALTER TABLE ONLY types.stati_certificato_compilato_prossimo ALTER COLUMN id SET DEFAULT nextval('types.stati_certificato_compilato_prossimo_id_seq'::regclass);


--
-- Name: stato_eventi id; Type: DEFAULT; Schema: types; Owner: postgres
--

ALTER TABLE ONLY types.stato_eventi ALTER COLUMN id SET DEFAULT nextval('types.stato_eventi_id_seq'::regclass);


--
-- Name: tipi_certificato id; Type: DEFAULT; Schema: types; Owner: postgres
--

ALTER TABLE ONLY types.tipi_certificato ALTER COLUMN id SET DEFAULT nextval('types.tipi_certificato_id_seq'::regclass);


--
-- Name: tipo_campo id; Type: DEFAULT; Schema: types; Owner: postgres
--

ALTER TABLE ONLY types.tipo_campo ALTER COLUMN id SET DEFAULT nextval('types.tipo_campo_id_seq'::regclass);


--
-- Name: tipo_eventi id; Type: DEFAULT; Schema: types; Owner: postgres
--

ALTER TABLE ONLY types.tipo_eventi ALTER COLUMN id SET DEFAULT nextval('types.tipo_eventi_id_seq'::regclass);


--
-- Name: tipo_modulo id; Type: DEFAULT; Schema: types; Owner: postgres
--

ALTER TABLE ONLY types.tipo_modulo ALTER COLUMN id SET DEFAULT nextval('types.tipo_modulo_id_seq'::regclass);


--
-- Name: tipo_prodotto id; Type: DEFAULT; Schema: types; Owner: postgres
--

ALTER TABLE ONLY types.tipo_prodotto ALTER COLUMN id SET DEFAULT nextval('types.tipo_prodotto_id_seq'::regclass);


--
-- Name: grid_definition id; Type: DEFAULT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.grid_definition ALTER COLUMN id SET DEFAULT nextval('ui.grid_definition_id_seq'::regclass);


--
-- Name: menu id; Type: DEFAULT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu ALTER COLUMN id SET DEFAULT nextval('ui.menu_id_seq'::regclass);


--
-- Name: menu_item_modes id; Type: DEFAULT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu_item_modes ALTER COLUMN id SET DEFAULT nextval('ui.menu_item_modes_id_seq'::regclass);


--
-- Name: menu_item_roles id; Type: DEFAULT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu_item_roles ALTER COLUMN id SET DEFAULT nextval('ui.menu_item_roles_id_seq'::regclass);


--
-- Name: menu_items id; Type: DEFAULT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu_items ALTER COLUMN id SET DEFAULT nextval('ui.menu_items_id_seq'::regclass);


--
-- Name: access id; Type: DEFAULT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.access ALTER COLUMN id SET DEFAULT nextval('um.access_id_seq'::regclass);


--
-- Name: access_stabilimenti id; Type: DEFAULT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.access_stabilimenti ALTER COLUMN id SET DEFAULT nextval('um.access_stabilimenti_id_seq'::regclass);


--
-- Name: contact id; Type: DEFAULT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.contact ALTER COLUMN id SET DEFAULT nextval('um.contact_id_seq'::regclass);


--
-- Name: permission id; Type: DEFAULT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.permission ALTER COLUMN id SET DEFAULT nextval('um.permission_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.role ALTER COLUMN id SET DEFAULT nextval('um.role_id_seq'::regclass);


--
-- Name: role_permission id; Type: DEFAULT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.role_permission ALTER COLUMN id SET DEFAULT nextval('um.role_permission_id_seq'::regclass);


--
-- Name: gestore gestore_pk; Type: CONSTRAINT; Schema: anagrafica; Owner: postgres
--

ALTER TABLE ONLY anagrafica.gestore
    ADD CONSTRAINT gestore_pk PRIMARY KEY (id);


--
-- Name: lista lista_pk; Type: CONSTRAINT; Schema: anagrafica; Owner: postgres
--

ALTER TABLE ONLY anagrafica.lista
    ADD CONSTRAINT lista_pk PRIMARY KEY (id);


--
-- Name: conf conf_un; Type: CONSTRAINT; Schema: conf; Owner: postgres
--

ALTER TABLE ONLY conf.conf
    ADD CONSTRAINT conf_un UNIQUE (descr);


--
-- Name: call_logs call_logs_pk; Type: CONSTRAINT; Schema: log; Owner: postgres
--

ALTER TABLE ONLY log.call_logs
    ADD CONSTRAINT call_logs_pk PRIMARY KEY (id);


--
-- Name: operazioni operazioni_pk; Type: CONSTRAINT; Schema: log; Owner: postgres
--

ALTER TABLE ONLY log.operazioni
    ADD CONSTRAINT operazioni_pk PRIMARY KEY (id);


--
-- Name: certificati_compilati certificati_compilati_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificati_compilati
    ADD CONSTRAINT certificati_compilati_pk PRIMARY KEY (id);


--
-- Name: certificati_compilati certificati_compilati_un; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificati_compilati
    ADD CONSTRAINT certificati_compilati_un UNIQUE (num_certificato);


--
-- Name: tree_nodes tree_nodes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tree_nodes
    ADD CONSTRAINT tree_nodes_pk PRIMARY KEY (id);


--
-- Name: menu_item_modes menu_item_modes_pk; Type: CONSTRAINT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu_item_modes
    ADD CONSTRAINT menu_item_modes_pk PRIMARY KEY (id);


--
-- Name: menu_items menu_items_pk; Type: CONSTRAINT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu_items
    ADD CONSTRAINT menu_items_pk PRIMARY KEY (id);


--
-- Name: menu menu_pk; Type: CONSTRAINT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu
    ADD CONSTRAINT menu_pk PRIMARY KEY (id);


--
-- Name: messaggi_ui messaggi_ui_pk; Type: CONSTRAINT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.messaggi_ui
    ADD CONSTRAINT messaggi_ui_pk PRIMARY KEY (id);


--
-- Name: access access_pk; Type: CONSTRAINT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.access
    ADD CONSTRAINT access_pk PRIMARY KEY (id);


--
-- Name: access_stabilimenti access_stabilimenti_pk; Type: CONSTRAINT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.access_stabilimenti
    ADD CONSTRAINT access_stabilimenti_pk PRIMARY KEY (id);


--
-- Name: contact contact_pk; Type: CONSTRAINT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.contact
    ADD CONSTRAINT contact_pk PRIMARY KEY (id);


--
-- Name: vw_email_info _RETURN; Type: RULE; Schema: ui; Owner: postgres
--

CREATE OR REPLACE VIEW ui.vw_email_info AS
 SELECT s.ragione_sociale,
    s.indirizzo,
    s.comune,
    s.provincia_stab,
    cc.data_proposta,
    p.descr AS paese,
    COALESCE(string_agg(DISTINCT (t.descr)::text, ','::text), '(Nessun prodotto selezionato)'::text) AS prodotti,
    cc.id AS id_certificato_compilato,
    ((((c2.email)::text || ', '::text) || string_agg(DISTINCT (c3.email)::text, ', '::text)))::character varying AS email,
    cc.orario_proposto,
    cc.file
   FROM (((((((((public.certificati_compilati cc
     JOIN public.moduli m ON ((cc.id_modulo = m.id)))
     JOIN public.certificati c ON ((c.id_modulo_corrente = m.id)))
     JOIN public.vw_get_stabilimenti s ON ((s.id = cc.id_stabilimento)))
     JOIN public.vw_countries p ON ((p.id = c.id_country)))
     LEFT JOIN public.campo_valori cv ON (((cv.id_certificato_compilato = cc.id) AND (cv.id_tipo_prodotto IS NOT NULL))))
     LEFT JOIN public.vw_tree_nodes t ON (((t.id_node = cv.id_tipo_prodotto) AND ((t.name_tree)::text = 'Denominzione prodotti'::text))))
     JOIN um.contact c2 ON (((c2.codice_fiscale)::text = s.sd_vet_cf)))
     JOIN um.access a ON ((a.responsabile_asl AND (s.asl_rif = a.id_asl))))
     JOIN um.contact c3 ON (((c3.id = a.id_contact) AND (c3.email IS NOT NULL))))
  GROUP BY s.ragione_sociale, s.indirizzo, s.comune, s.provincia_stab, cc.data_proposta, p.descr, cc.id, c2.email, cc.orario_proposto;


--
-- Name: lista lista_fk; Type: FK CONSTRAINT; Schema: anagrafica; Owner: postgres
--

ALTER TABLE ONLY anagrafica.lista
    ADD CONSTRAINT lista_fk FOREIGN KEY (gestore) REFERENCES anagrafica.gestore(id);


--
-- Name: lista_valori lista_valori_fk; Type: FK CONSTRAINT; Schema: anagrafica; Owner: postgres
--

ALTER TABLE ONLY anagrafica.lista_valori
    ADD CONSTRAINT lista_valori_fk FOREIGN KEY (id_lista) REFERENCES anagrafica.lista(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tree_nodes tree_nodes_id_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tree_nodes
    ADD CONSTRAINT tree_nodes_id_parent_fk FOREIGN KEY (id_node_parent) REFERENCES public.tree_nodes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu_item_modes menu_item_modes_fk; Type: FK CONSTRAINT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu_item_modes
    ADD CONSTRAINT menu_item_modes_fk FOREIGN KEY (id_menu_item) REFERENCES ui.menu_items(id);


--
-- Name: menu_items menu_items_fk; Type: FK CONSTRAINT; Schema: ui; Owner: postgres
--

ALTER TABLE ONLY ui.menu_items
    ADD CONSTRAINT menu_items_fk FOREIGN KEY (id_menu) REFERENCES ui.menu(id);


--
-- Name: access access_fk; Type: FK CONSTRAINT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.access
    ADD CONSTRAINT access_fk FOREIGN KEY (id_contact) REFERENCES um.contact(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: access_stabilimenti access_stabilimenti_fk; Type: FK CONSTRAINT; Schema: um; Owner: postgres
--

ALTER TABLE ONLY um.access_stabilimenti
    ADD CONSTRAINT access_stabilimenti_fk FOREIGN KEY (id_access) REFERENCES um.access(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

