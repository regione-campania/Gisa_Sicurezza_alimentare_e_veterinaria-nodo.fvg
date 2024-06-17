-- FUNCTION: public.insert_registro_trasgressori_sanzione(integer, integer, text, integer, text, text, text, timestamp without time zone, integer)

-- DROP FUNCTION IF EXISTS public.insert_registro_trasgressori_sanzione(integer, integer, text, integer, text, text, text, timestamp without time zone, integer);

CREATE OR REPLACE FUNCTION public.insert_registro_trasgressori_sanzione(
	_id_ente_accertato integer,
	_tipo_ente_accertato integer,
	_ente_accertato text,
	_id_asl integer,
	_trasgressore text,
	_obbligato text,
	_pv text,
	_data_accertamento timestamp without time zone,
	_user_id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE
idSanzione integer;
idTrasgressione integer;
noteHd text;
annoSanzione integer;
noteSanzione text;
maxTicketId integer;
maxProgressivo integer;

BEGIN

noteHd := 'RECORD GENERATO AUTOMATICAMENTE PER INSERIMENTO SANZIONE FORZATA NEL REGISTRO TRASGRESSORI';
noteSanzione := 'SANZIONE INSERITA NEL REGISTRO TRAMITE FUNZIONE DI INSERIMENTO SANZIONE FORZATA';
select date_part('year', _data_accertamento) into annoSanzione;
select max(ticketid)+1 into maxTicketId from ticket where ticketid<10000000;

insert into ticket(ticketid, tipologia, site_id, trasgressore, obbligatoinsolido, tipo_richiesta, assigned_date, enteredby, modifiedby, note_internal_use_only, problem)
values (maxTicketId, 1, _id_asl, _trasgressore, _obbligato, _pv, _data_accertamento, _user_id, _user_id, noteHd, noteSanzione) returning ticketid into idSanzione;

select COALESCE(max(progressivo), 0)+1 into maxProgressivo from registro_trasgressori_values where anno = annoSanzione;

insert into registro_trasgressori_values(id_sanzione, anno, progressivo, note_internal_use_only_hd, note1, competenza_regionale) values (idSanzione,annoSanzione, maxProgressivo, noteHd, noteSanzione, true) returning id into idTrasgressione;

return idTrasgressione;

 END;
$BODY$;

ALTER FUNCTION public.insert_registro_trasgressori_sanzione(integer, integer, text, integer, text, text, text, timestamp without time zone, integer)
    OWNER TO postgres;
