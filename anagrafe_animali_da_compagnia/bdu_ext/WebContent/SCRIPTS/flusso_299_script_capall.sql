alter table comuni1
add column cod_nazione integer default 106;

CREATE OR REPLACE FUNCTION public.get_comuni(
	_id integer,
	_nome character varying,
	_cod_regione character varying,
	_id_provincia integer,
	_id_asl integer)
    RETURNS TABLE(id integer, cod_comune character varying, cod_regione character varying, cod_provincia integer, nome character varying, istat character varying, cap character varying, cod_nazione integer, id_asl integer) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

 SELECT id,
    cod_comune, 
    cod_regione, 
    cod_provincia::integer,
    nome,
    istat,
    cap,
    cod_nazione,
    codiceistatasl::integer as _id_asl
from public.comuni1 c
where 
    (_id is null or c.id = _id) 
    and (_nome is null or c.nome ilike _nome || '%')
    and (_cod_regione is null or c.cod_regione ilike _cod_regione || '%')
    and (cod_provincia::integer is null or c.cod_provincia::integer = _id_provincia or _id_provincia is null)
    and (_id_asl is null or c.codiceistatasl::integer = _id_asl)
    and c.trashed is not true

order by nome 
$BODY$;