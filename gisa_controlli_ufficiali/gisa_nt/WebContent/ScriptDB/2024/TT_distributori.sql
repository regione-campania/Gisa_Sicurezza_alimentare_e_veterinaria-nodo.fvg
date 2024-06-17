alter table master_list_linea_attivita add column consenti_upload_file boolean default false;

-- View: public.master_list_view

DROP VIEW public.master_list_view;

CREATE OR REPLACE VIEW public.master_list_view
 AS
 SELECT master_list_macroarea.id AS id_nuova_linea_attivita,
    true AS enabled,
    master_list_macroarea.id AS id_macroarea,
    NULL::integer AS id_aggregazione,
    NULL::integer AS id_attivita,
    master_list_macroarea.codice_sezione AS codice_macroarea,
    ''::text AS codice_aggregazione,
    ''::text AS codice_attivita,
    master_list_macroarea.macroarea,
    ''::text AS aggregazione,
    ''::text AS attivita,
    master_list_macroarea.id_norma,
    master_list_macroarea.norma,
    master_list_macroarea.macroarea AS descrizione,
    1 AS livello,
    '-1'::integer AS id_padre,
    '-1'::character varying(1000) AS path_id,
    master_list_macroarea.macroarea::character varying(1000) AS path_desc,
    master_list_macroarea.codice_sezione AS codice,
    master_list_macroarea.codice_sezione::character varying(1000) AS path_codice,
    false AS consenti_valori_multipli,
	false AS consenti_upload_file,
    master_list_macroarea.codice_norma,
    '-1'::integer AS id_lookup_tipo_linee_mobili
   FROM master_list_macroarea
     LEFT JOIN opu_lookup_norme_master_list norme ON norme.code = master_list_macroarea.id_norma
  WHERE master_list_macroarea.trashed_date IS NULL AND master_list_macroarea.rev = 11
UNION ALL
 SELECT t.id AS id_nuova_linea_attivita,
    true AS enabled,
    t.id_macroarea,
    t.id AS id_aggregazione,
    NULL::integer AS id_attivita,
    rt.codice_sezione AS codice_macroarea,
    t.codice_attivita AS codice_aggregazione,
    ''::text AS codice_attivita,
    rt.macroarea,
    t.aggregazione,
    ''::text AS attivita,
    rt.id_norma,
    rt.norma,
    t.aggregazione AS descrizione,
    2 AS livello,
    t.id_macroarea AS id_padre,
    (((rt.id::text || ';'::text) || t.id))::character varying(1000) AS path_id,
    (((rt.macroarea || '->'::text) || t.aggregazione))::character varying(1000) AS path_desc,
    t.codice_attivita AS codice,
    (((rt.codice_sezione || '->'::text) || t.codice_attivita))::character varying(1000) AS path_codice,
    false AS consenti_valori_multipli,
	false AS consenti_upload_file,
    rt.codice_norma,
    '-1'::integer AS id_lookup_tipo_linee_mobili
   FROM master_list_aggregazione t
     JOIN master_list_macroarea rt ON rt.id = t.id_macroarea
     LEFT JOIN opu_lookup_norme_master_list norme2 ON norme2.code = rt.id_norma
  WHERE t.trashed_date IS NULL AND rt.trashed_date IS NULL AND rt.rev = 11 AND t.rev = 11
UNION ALL
 SELECT a.id AS id_nuova_linea_attivita,
    true AS enabled,
    rt3.id AS id_macroarea,
    rt2.id AS id_aggregazione,
    a.id AS id_attivita,
    rt3.codice_sezione AS codice_macroarea,
    rt2.codice_attivita AS codice_aggregazione,
    a.codice_prodotto_specie AS codice_attivita,
    rt3.macroarea,
    rt2.aggregazione,
    a.linea_attivita AS attivita,
    rt3.id_norma,
    norme3.codice_norma AS norma,
    a.linea_attivita AS descrizione,
    3 AS livello,
    a.id_aggregazione AS id_padre,
    ((((rt3.id::text || ';'::text) || (rt2.id::text || ';'::text)) || a.id))::character varying(1000) AS path_id,
    ((((rt3.macroarea || '->'::text) || (rt2.aggregazione || '->'::text)) || a.linea_attivita))::character varying(1000) AS path_desc,
    concat_ws('-'::text, rt3.codice_sezione, rt2.codice_attivita, a.codice_prodotto_specie) AS codice,
    ((((rt3.codice_sezione || '->'::text) || (rt2.codice_attivita || '->'::text)) || a.codice_prodotto_specie))::character varying(1000) AS path_codice,
    a.consenti_valori_multipli,
	a.consenti_upload_file,
    rt3.codice_norma,
    a.id_lookup_tipo_linee_mobili
   FROM master_list_linea_attivita a
     JOIN master_list_aggregazione rt2 ON rt2.id = a.id_aggregazione
     JOIN master_list_macroarea rt3 ON rt3.id = rt2.id_macroarea
     LEFT JOIN opu_lookup_norme_master_list norme3 ON norme3.code = rt3.id_norma
  WHERE a.trashed_date IS NULL AND rt2.trashed_date IS NULL AND rt3.trashed_date IS NULL AND a.rev = 11 AND rt2.rev = 11 AND rt3.rev = 11;

ALTER TABLE public.master_list_view
    OWNER TO postgres;


update master_list_linea_attivita set consenti_upload_file = true where codice_univoco='MS.060-MS.060.400-852IT7A301';
update master_list_linea_attivita set consenti_upload_file = true where codice_univoco='MS.060-MS.060.400-852IT7A302';
update master_list_linea_attivita set consenti_upload_file = true where codice_univoco='MS.060-MS.060.400-852IT7A303';

-- FUNCTION: public.refresh_ml_materializzata(integer)

-- DROP FUNCTION IF EXISTS public.refresh_ml_materializzata(integer);

CREATE OR REPLACE FUNCTION public.refresh_ml_materializzata(
	_id_linea integer DEFAULT NULL::integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
BEGIN

delete from ml8_linee_attivita_nuove_materializzata where 1=1 
-- solo le nuove linee 
and id_nuova_linea_attivita in (select id_nuova_linea_attivita from master_list_view)
and (_id_linea is null or id_nuova_linea_attivita = _id_linea);

insert into ml8_linee_attivita_nuove_materializzata (
 id_nuova_linea_attivita, enabled, id_macroarea, id_aggregazione, id_attivita, codice_macroarea, codice_aggregazione, codice_attivita, macroarea, aggregazione,
 attivita, id_norma, norma, codice_norma, descrizione, livello, id_padre, path_id, path_descrizione, codice, path_codice,rev, id_lookup_tipo_linee_mobili, consenti_valori_multipli,
 consenti_upload_file
) select id_nuova_linea_attivita, enabled, id_macroarea, id_aggregazione, id_attivita, codice_macroarea, codice_aggregazione, codice_attivita, macroarea, aggregazione,
 attivita, id_norma, norma, codice_norma, descrizione, livello, id_padre, path_id, path_desc, codice, path_codice, 11 as rev, id_lookup_tipo_linee_mobili, consenti_valori_multipli,
 consenti_upload_file
 from master_list_view 
 where 1=1
 and (_id_linea is null or id_nuova_linea_attivita = _id_linea);

return 1;

 END;
$BODY$;

ALTER FUNCTION public.refresh_ml_materializzata(integer)
    OWNER TO postgres;



select * from refresh_ml_materializzata(41328);
select * from refresh_ml_materializzata(40535);
select * from refresh_ml_materializzata(40355);
select * from refresh_ml_materializzata(40356);
select * from refresh_ml_materializzata(40357);
select * from refresh_ml_materializzata(40532);
select * from refresh_ml_materializzata(41329);


