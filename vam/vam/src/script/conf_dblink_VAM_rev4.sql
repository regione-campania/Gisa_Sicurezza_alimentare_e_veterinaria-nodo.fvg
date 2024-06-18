DROP SCHEMA IF EXISTS conf CASCADE;

create schema conf;

create table conf.ambiente(
	ambiente text
);

create table conf.pg_conf(
	connection text primary key,
	dbhost text,
	dbname text,
	dbuser text,
	port text,
	modified timestamp,
	trashed boolean,
	trashed_date timestamp
);

--creare file su dbserver con <ambiente>

insert into conf.pg_conf(connection, dbhost, dbname, dbuser) values
('COLLAUDOCRED_GISA','dbGISAL','gisa','gisa_owner'),
('COLLAUDOCRED_GUC','dbGUCL','guc','guc_owner'),
('COLLAUDOCRED_BDU','dbBDUL','bdu','bdu_owner'),
('COLLAUDOCRED_VAM','dbVAML','vam','vam_owner'),
('COLLAUDOCRED_STORICO','dbSTORICOL','storico','storico_owner'),
('COLLAUDOCRED_DIGEMON','report.gisacampania.it','digemon_u','digemon_u_owner'),
('COLLAUDOCRED_DOCUMENTALE','dbDOCUMENTALEL','documentale','documentale_owner'),
('COLLAUDOCRED_AUTOVALUTAZIONE','dbAUTOVALUTAZIONEL','autovalutazione','autovalutazione_owner'),
('COLLAUDOCRED_MDGM','dbMDGML','mdgm','mdgm_owner'),
('COLLAUDOCRED_RTJWT','dbRTJWTL','rtjwt','rtjwt_owner'),
('COLLAUDOCRED_SICLAV','dbSICLAVL','siclav','siclav');

create or replace function conf.get_pg_conf(connection_ text)
returns text
LANGUAGE 'plpgsql'
COST 100
VOLATILE PARALLEL UNSAFE
as $BODY$
DECLARE
host_ text;
dbname_ text;
user_ text;
port_ text;
ambiente_ text;
BEGIN

	delete from conf.ambiente ;
	copy conf.ambiente (ambiente) from '/opt/pg_ambiente/config' ;
	select * from conf.ambiente into ambiente_;
	
	select dbhost, dbname, dbuser, coalesce(port,'5432')
	from conf.pg_conf
	where connection = ambiente_||'_'||connection_
	and trashed is not true and trashed_date is null
	into host_, dbname_, user_, port_;
	
RETURN 'host='|| host_ ||' dbname='|| dbname_ ||' user='|| user_ ||' port='|| port_;
END;
$BODY$;

----------------------------

create or replace function public.dblink_get_messaggio_home(ambiente_ text, endpoint_ text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	dblink_config text;
	header_ text;
	body_ text;
	footer_ text;
	msg text;
BEGIN
	
	msg := '<center><font color=''red''><h1>';
	select * from conf.get_pg_conf('GUC') into dblink_config;

	select r.header, r.body, r.footer from dblink(dblink_config,'select header, body, footer from get_messaggio_home('''|| endpoint_ ||''')')
	as r(header text, body text, footer text) into header_, body_, footer_;

	if(header_ is not null and header_ != '') then
		msg := msg || header_ || '<br>';
	end if;
	
	if(body_ is not null and body_ != '') then
		msg := msg || body_ || '<br>';
	end if;
	
	if(footer_ is not null and footer_ != '') then
		msg := msg || footer_;
	end if;
	
		msg := msg || '</h1></font></center>';
	return msg;
END;
$$;

------------------------------

create or replace function public_functions.dbi_get_registro_tumori() RETURNS TABLE(identificativo text, sesso text, data_nascita timestamp with time zone, data_decesso timestamp with time zone, taglia_id integer, taglia text, deceduto_non_anagrafe boolean, specie text, specie_id integer, razza_id integer, razza text, mantello_id integer, mantello text, numero_esame text, data_richiesta timestamp with time zone, sede_lesione text, laboratorio_destinazione text, numero_rif_mittente text, tipo_prelievo text, tumori_precedenti text, dimensione text, interessamento_linfonodale text, data_esito timestamp with time zone, tipo_diagnosi text, descrizione_morfologica text, who_classificazione text, cc text, asl_id integer, asl text, clinica text, comune_decesso text)
    LANGUAGE plpgsql STRICT
    AS $$
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
               FROM dblink((select * from conf.get_pg_conf('BDU')), ((('select a.data_decesso
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
$$;