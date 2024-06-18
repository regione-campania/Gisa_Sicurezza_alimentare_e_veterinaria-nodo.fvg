DROP FUNCTION public.get_schede_decesso(integer, integer, integer, integer);


CREATE OR REPLACE FUNCTION public.get_schede_decesso(
    IN id_input integer,
    IN id_animale_input integer,
    IN user_id integer,
    IN asl_input integer,
    IN microchip_ text default null,
    IN data_da timestamp without time zone default null,
    IN data_a timestamp without time zone default null,
    IN flag_decesso_ boolean default null)
  RETURNS TABLE(id integer, id_animale integer, entered timestamp without time zone, modified timestamp without time zone, entered_by integer, modified_by integer, data_decesso timestamp without time zone, id_causa integer, id_neoplasia integer, id_diagnosi_citologica integer, id_diagnosi_istologica integer, note_causa_decesso text, note_neoplasia text, microchip text, id_specie integer, id_razza integer, data_nascita timestamp without time zone, sesso text, id_tipo_mantello integer, id_taglia integer, flag_sterilizzazione boolean, data_sterilizzazione timestamp without time zone, ubicazione text, data_esito_istologico timestamp without time zone, desc_morfologica_stologico text, id_tipo_dagnosi_istologica integer, note_diagnosi_istologica_tumorali text) AS
$BODY$
DECLARE
BEGIN
	RETURN QUERY     
	select sc.id,sc.id_animale,sc.entered,sc.modified,sc.entered_by ,sc.modified_by ,sc.data_decesso ,sc.id_causa , sc.id_neoplasia , sc.id_diagnosi_citologica, sc.id_diagnosi_istologica, sc.note_causa_decesso, sc.note_neoplasia, an.microchip::text,an.id_specie, an.id_razza, an.data_nascita, an.sesso::text, an.id_tipo_mantello, an.id_taglia,an.flag_sterilizzazione,an.data_sterilizzazione ,
ind.via || ' - ' || c.nome as ubicazione, sc.data_esito_istologico , sc.desc_morfologica_stologico, sc.id_tipo_dagnosi_istologica , sc.note_diagnosi_istologica_tumorali 
from scheda_decesso sc
left join animale an on an.id = sc.id_animale
left join opu_relazione_stabilimento_linee_produttive rel on rel.id = an.id_proprietario
left join opu_stabilimento stab on stab.id = rel.id_stabilimento
left join opu_indirizzo ind on ind.id = stab.id_indirizzo
left join comuni1 c on c.id = ind.comune
where (sc.id = id_input or id_input = -1) and
      (sc.id_animale = id_animale_input or id_animale_input = -1) and
      (an.id_asl_riferimento = asl_input or asl_input = -1) and
      (an.microchip = microchip_ or an.tatuaggio = microchip_ or microchip_ is null) and
      (sc.data_decesso >= data_da or data_da is null) and
      (sc.data_decesso <= data_a or data_a is null) and
      (an.flag_decesso = flag_decesso_ or flag_decesso_ is null) and
      (sc.entered_by = user_id or user_id = -1)
order by sc.entered desc;    
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_schede_decesso(integer, integer, integer, integer, text, timestamp without time zone,timestamp without time zone,boolean)
  OWNER TO postgres;
