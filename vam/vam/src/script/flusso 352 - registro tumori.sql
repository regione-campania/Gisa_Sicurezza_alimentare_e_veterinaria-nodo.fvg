--BDU
CREATE OR REPLACE VIEW public.registro_tumori_dati_bdu AS 
 SELECT an.microchip,
    an.tatuaggio,
    e_dec.data_decesso,
    c.nome AS comune_detentore_attuale,
    c2.nome AS comune_decesso
   FROM animale an
     LEFT JOIN opu_operatori_denormalizzati det ON det.id_rel_stab_lp = an.id_detentore
     LEFT JOIN comuni1 c ON c.id = det.comune
     LEFT JOIN evento e ON e.trashed_date IS NULL AND e.data_cancellazione IS NULL AND e.id_tipologia_evento = 9 AND e.id_animale = an.id
     LEFT JOIN evento_decesso e_dec ON e_dec.id_evento = e.id_evento
     LEFT JOIN comuni1 c2 ON c2.id = e_dec.id_comune_decesso;

ALTER TABLE public.registro_tumori_dati_bdu
  OWNER TO postgres;


--VAM
 CREATE EXTENSION postgres_fdw
  SCHEMA public
  VERSION "1.0";
  
CREATE SERVER foreign_server_bdu
   FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (dbname 'bdu',host '127.0.0.1',port '5432');
ALTER SERVER foreign_server_bdu
  OWNER TO postgres;
  GRANT USAGE ON FOREIGN SERVER foreign_server_bdu TO postgres;


  CREATE USER MAPPING
FOR PUBLIC
SERVER foreign_server_bdu
OPTIONS (user 'postgres');


CREATE FOREIGN TABLE public.registro_tumori_dati_bdu
   (microchip text,
    tatuaggio text,
    data_decesso timestamp without time zone,
    comune_detentore_attuale text,
    comune_decesso text)
   SERVER foreign_server_bdu
   OPTIONS (schema_name 'public', table_name 'registro_tumori_dati_bdu');
ALTER FOREIGN TABLE public.registro_tumori_dati_bdu
  OWNER TO postgres;



drop function public_functions.dbi_get_registro_tumori();
  
CREATE OR REPLACE FUNCTION public_functions.dbi_get_registro_tumori()
  RETURNS TABLE( identificativo text, 
sesso text,  
data_nascita timestamp with time zone,
data_decesso timestamp with time zone,
     
 taglia_id integer,
 taglia text,
deceduto_non_anagrafe boolean,
 specie text,
specie_id integer,
razza_id integer,
razza text,
 mantello_id integer,
 mantello text,

 numero_esame text, 
data_richiesta timestamp with time zone,
sede_lesione text,
 laboratorio_destinazione text,
numero_rif_mittente text,
tipo_prelievo text,
tumori_precedenti text,
dimensione text,
interessamento_linfonodale text,

 data_esito timestamp with time zone, 
tipo_diagnosi text,
descrizione_morfologica text,
 who_classificazione text, 
				 
 cc text,
 asl_id integer,
asl text,
 clinica text,
comune_decesso text) AS
$BODY$
BEGIN
	FOR identificativo , 
sesso ,  
data_nascita ,
data_decesso,
     
 taglia_id ,
 taglia ,
deceduto_non_anagrafe ,
 specie ,
specie_id ,
razza_id ,
razza ,
 mantello_id ,
 mantello ,

 numero_esame , 
data_richiesta ,
sede_lesione ,
 laboratorio_destinazione ,
numero_rif_mittente ,
tipo_prelievo ,
tumori_precedenti ,
dimensione ,
interessamento_linfonodale ,

 data_esito , 
tipo_diagnosi ,
descrizione_morfologica ,
 who_classificazione , 
				 
 cc ,
 asl_id ,
asl ,
 clinica ,
 comune_decesso
	in


select coalesce(an.identificativo, an2.identificativo) as identificativo, 
coalesce(an.sesso, an2.sesso) as sesso,  
coalesce(an.data_nascita, an2.data_nascita)::timestamp with time zone as data_nascita,
bdu.data_decesso,
/*
CASE
            WHEN an.deceduto_non_anagrafe = true THEN an.deceduto_non_anagrafe_data_morte::timestamp without time zone
            WHEN an.deceduto_non_anagrafe = false AND an.specie in (1,2) THEN ( SELECT t1.data_decesso
               FROM dblink('host=localhost dbname=bdu user=postgres password=postgres'::text, ((('select a.data_decesso
										     from animale a 
										     where (a.microchip = '''::text || an.identificativo::text) || ''' or 
											    a.tatuaggio = '''::text) || an.identificativo::text) || ''') and 
											   a.trashed_date is null  and a.data_cancellazione is null
									             limit 1'::text) t1(data_decesso timestamp without time zone))
            WHEN an.deceduto_non_anagrafe = false AND an.specie = 3 THEN ( SELECT s.data_decesso
               FROM sinantropo s
              WHERE s.mc::text = s.mc::text OR s.numero_automatico::text = s.mc::text OR s.numero_ufficiale::text = s.mc::text
             LIMIT 1)
            ELSE NULL::timestamp without time zone
        END AS data_decesso,*/
     
coalesce(an.taglia, an2.taglia) as taglia_id,
taglia.description as taglia,
coalesce(an.deceduto_non_anagrafe, an2.deceduto_non_anagrafe) as deceduto_non_anagrafe,
specie.description as specie,
specie.id as specie_id,
coalesce(an.razza, an2.razza) as razza_id,
razza.description as razza,
coalesce(an.mantello, an2.mantello) as mantello_id,
mantello.description as mantello,

e.numero as numero_esame, 
e.data_richiesta::timestamp with time zone as data_richiesta,
sede_lesione_padre.description || ' --> ' || sede_lesione.description as sede_lesione,
sala_settoria.description as laboratorio_destinazione,
e.numero_accettazione_sigla as numero_rif_mittente ,
tipo_prelievo.description as tipo_prelievo,
tumori_precedenti.description as tumori_precedenti,
e.dimensione,
interess.description as interessamento_linfonodale,

e.data_esito::timestamp with time zone as data_esito, 
tipo_diagnosi.description as tipo_diagnosi,
e.descrizione_morfologica,
wu.description as wu_classificazione, 
				 
cc.numero as cc,
asl1.id as asl_id,
asl1.description as asl,
cl.nome as clinica,
coalesce(bdu.comune_detentore_attuale, bdu.comune_decesso) as comune_decesso
from esame_istopatologico e 
left join utenti_ u on u.id = e.entered_by 
left join animale an on an.id = e.animale and an.trashed_date is null 
left join cartella_clinica cc on cc.id = e.cartella_clinica and cc.trashed_date is null 
left join accettazione acc on acc.id = cc.accettazione
left join animale an2 on an2.id = acc.animale
left join lookup_taglie taglia on taglia.id = coalesce(an.taglia,an2.taglia)
left join lookup_razza razza on razza.code = coalesce(an.razza,an2.razza)
left join lookup_specie specie on specie.id = coalesce(an.specie,an2.specie)
left join lookup_mantello mantello on mantello.code = coalesce(an.mantello,an2.mantello)
left join lookup_esame_istopatologico_sede_lesione sede_lesione on sede_lesione.id = e.sede_lesione 
left join lookup_esame_istopatologico_sede_lesione sede_lesione_padre on sede_lesione_padre.id = sede_lesione.padre
left join lookup_esame_istopatologico_tipo_prelievo tipo_prelievo on tipo_prelievo.id = e.tipo_prelievo
left join lookup_esame_istopatologico_tumori_precedenti tumori_precedenti on tumori_precedenti.id = e.tumori_precedenti
left join lookup_esame_istopatologico_interessamento_linfonodale interess on interess.id = e.interessamento_linfonodale
left join lookup_esame_istopatologico_tipo_diagnosi tipo_diagnosi on tipo_diagnosi.id = e.tipo_diagnosi
left join lookup_esame_istopatologico_who_umana wu on wu.id = e.who_umana
LEFT JOIN clinica cl ON cl.id = u.clinica and cl.trashed_date is null
LEFT JOIN lookup_asl asl1 ON asl1.id = cl.asl
left join lookup_autopsia_sala_settoria sala_settoria on sala_settoria.id = e.sala_settoria
left join registro_tumori_dati_bdu bdu on bdu.microchip = coalesce(an.identificativo, an2.identificativo)  --or bdu.tatuaggio = an.identificativo
where e.entered_by = u.id and e.trashed_date is null and e.tipo_diagnosi = 1
order by e.data_richiesta desc
  
    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public_functions.dbi_get_registro_tumori()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public_functions.dbi_get_registro_tumori() TO public;
GRANT EXECUTE ON FUNCTION public_functions.dbi_get_registro_tumori() TO postgres;



--estrazione di esempio inviata a matonti
select * from public_functions.dbi_get_registro_tumori() where specie_id in (1,2) and deceduto_non_anagrafe is false

