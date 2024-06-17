
CREATE TABLE public.import_capi_macello
(
  __codice_azienda_di_provenienza text,
  __codice_azienda_di_nascita text,
  __matricola text,
  __specie text,
  __categoria text,
  __razza text,
  __sesso text,
  __data_di_nascita text,
  __categoria_di_rischio_msr text,
  __vincolo_sanitario text,
  __qualifica_sanitaria_tbc text,
  __qualifica_sanitaria_brc text,
  __mod_4 text,
  __data_mod_4 text,
  __macell_differita_piani_risanamento text,
  __test_bse text,
  __informazioni_test_bse text,
  __data_prelievo_test_bse text,
  __data_ricezione_esito_test_bse text,
  __esito_test_bse text,
  __note_test_bse text,
  __disponibili_informazioni_catena_alimentare text,
  __data_arrivo_al_macello text,
  __data_dichiararata_dal_gestore text,
  __mezzo_di_trasporto_tipo text,
  __mezzo_di_trasporto_targa text,
  __trasporto_superiore_a_8_ore text,
  __veterinari_addetti_cd text,
  __note_cd text,
  __data_mam text,
  __luogo_di_verifica text,
  __causa text,
  __impianto_di_termodistruzione text,
  __destinazione_della_carcassa text,
  __comunicazione_a_mam text,
  __note_mam text,
  __data_vam text,
  __esito text,
  __provvedimento_adottato text,
  __comunicazione_a_vam text,
  __note_vam text,
  __tipo_macellazione text,
  __progressivo_macellazione text,
  __esito_vpm text,
  __patologie_rilevate text,
  __organi text,
  __causa_presunta_o_accertata text,
  __veterinari_addetti_vpm text,
  __destinatario_carni text,
  __motivo_c_1 text,
  __matrice_c_1 text,
  __tipo_analisi_c_1 text,
  __molecole_agente_etiologico_c_1 text,
  __molecole_agente_etiologico_altro_c_1 text,
  __esito_c_1 text,
  __data_ricezione_esito_c_1 text,
  __motivo_c_2 text,
  __matrice_c_2 text,
  __tipo_analisi_c_2 text,
  __molecole_agente_etiologico_c_2 text,
  __molecole_agente_etiologico_altro_c_2 text,
  __esito_c_2 text,
  __data_ricezione_esito_c_2 text,
  __motivo_c_3 text,
  __matrice_c_3 text,
  __tipo_analisi_c_3 text,
  __molecole_agente_etiologico_c_3 text,
  __molecole_agente_etiologico_altro_c_3 text,
  __esito_c_3 text,
  __data_ricezione_esito_c_3 text,
  __motivo_c_4 text,
  __matrice_c_4 text,
  __tipo_analisi_c_4 text,
  __molecole_agente_etiologico_c_4 text,
  __molecole_agente_etiologico_altro_c_4 text,
  __esito_c_4 text,
  __data_ricezione_esito_c_4 text,
  __motivo_c_5 text,
  __matrice_c_5 text,
  __tipo_analisi_c_5 text,
  __molecole_agente_etiologico_c_5 text,
  __molecole_agente_etiologico_altro_c_5 text,
  __esito_c_5 text,
  __data_ricezione_esito_c_5 text,
  __eseguito_t text,
  __tipo_analisi_t text,
  __metodo_distruttivo_t text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.import_capi_macello
  OWNER TO postgres;
  
  
 
CREATE OR REPLACE FUNCTION public.import_capo_macello(
    IN _id_record_capo integer)
  RETURNS text AS
$BODY$
   DECLARE
	msg text ;
	rec record;
	_id_macello integer;
	_destinatario_1_id integer;
	_destinatario_1_nome text;
	_data_sessione timestamp without time zone;
	_cd_seduta_macellazione integer;
	_stato_macellazione text;
	_id_capo integer;
	_id_tampone integer;
BEGIN

	_id_macello = 100001498;
	_destinatario_1_id = _id_macello;
	_destinatario_1_nome = 'REALBEEF S.R.L.';
	_data_sessione ='2022-09-14';
	_cd_seduta_macellazione = 1;
	_stato_macellazione ='OK';
	
	FOR rec IN
		SELECT   
		  __codice_azienda_di_provenienza ,
		  __codice_azienda_di_nascita ,
		  __matricola ,
		  __specie ,
		  __categoria ,
		  __razza ,
		  __sesso ,
		  __data_di_nascita ,
		  __categoria_di_rischio_msr ,
		  __vincolo_sanitario ,
		  __qualifica_sanitaria_tbc ,
		  __qualifica_sanitaria_brc ,
		  __mod_4 ,
		  __data_mod_4 ,
		  __macell_differita_piani_risanamento ,
		  __test_bse ,
		  __informazioni_test_bse ,
		  __data_prelievo_test_bse ,
		  __data_ricezione_esito_test_bse ,
		  __esito_test_bse ,
		  __note_test_bse ,
		  __disponibili_informazioni_catena_alimentare ,
		  __data_arrivo_al_macello ,
		  __data_dichiararata_dal_gestore ,
		  __mezzo_di_trasporto_tipo ,
		  __mezzo_di_trasporto_targa ,
		  __trasporto_superiore_a_8_ore ,
		  __veterinari_addetti_cd ,
		  __note_cd ,
		  __data_mam ,
		  __luogo_di_verifica ,
		  __causa ,
		  __impianto_di_termodistruzione ,
		  __destinazione_della_carcassa ,
		  __comunicazione_a_mam ,
		  __note_mam ,
		  __data_vam ,
		  __esito ,
		  __provvedimento_adottato ,
		  __comunicazione_a_vam ,
		  __note_vam ,
		  __tipo_macellazione ,
		  __progressivo_macellazione,
		  __esito_vpm ,
		  __patologie_rilevate ,
		  __organi ,
		  __causa_presunta_o_accertata ,
		  __veterinari_addetti_vpm ,
		  __destinatario_carni ,
		  __motivo_c_1 ,
		  __matrice_c_1 ,
		  __tipo_analisi_c_1 ,
		  __molecole_agente_etiologico_c_1 ,
		  __molecole_agente_etiologico_altro_c_1 ,
		  __esito_c_1 ,
		  __data_ricezione_esito_c_1 ,
		  __motivo_c_2 ,
		  __matrice_c_2 ,
		  __tipo_analisi_c_2 ,
		  __molecole_agente_etiologico_c_2 ,
		  __molecole_agente_etiologico_altro_c_2 ,
		  __esito_c_2 ,
		  __data_ricezione_esito_c_2 ,
		  __motivo_c_3 ,
		  __matrice_c_3 ,
		  __tipo_analisi_c_3 ,
		  __molecole_agente_etiologico_c_3 ,
		  __molecole_agente_etiologico_altro_c_3 ,
		  __esito_c_3 ,
		  __data_ricezione_esito_c_3 ,
		  __motivo_c_4 ,
		  __matrice_c_4 ,
		  __tipo_analisi_c_4 ,
		  __molecole_agente_etiologico_c_4 ,
		  __molecole_agente_etiologico_altro_c_4 ,
		  __esito_c_4 ,
		  __data_ricezione_esito_c_4 ,
		  __motivo_c_5 ,
		  __matrice_c_5 ,
		  __tipo_analisi_c_5 ,
		  __molecole_agente_etiologico_c_5 ,
		  __molecole_agente_etiologico_altro_c_5 ,
		  __esito_c_5 ,
		  __data_ricezione_esito_c_5 ,
		  __eseguito_t ,
		  __tipo_analisi_t ,
		  __metodo_distruttivo_t 
		  from import_capi_macello  where id = _id_record_capo

  LOOP

	-- inserimento in m_capi
       insert into m_capi(id_macello, cd_codice_azienda, cd_matricola, cd_specie, cd_data_nascita, 
                          cd_maschio, cd_id_razza, cd_vincolo_sanitario,cd_mod4, cd_data_mod4, 
                          cd_data_arrivo_macello, cd_info_catena_alimentare, cd_bse, cd_veterinario_1, bse_data_prelievo, 
                          bse_data_ricezione_esito, bse_esito, bse_note, vam_data, vam_provvedimenti, 
                          vam_esito, mac_tipo,vpm_data, vpm_veterinario,vpm_esito, vpm_causa_patologia, 
	 		  mavam_data, mavam_luogo, mavam_motivo,mavam_impianto_termodistruzione,cd_categoria_bovina,
			  cd_categoria_bufalina,cd_note, progressivo_macellazione, mavam_note, cd_tipo_mezzo_trasporto, --35
			  cd_targa_mezzo_trasporto, cd_trasporto_superiore8ore, mvam_destinazione_carcassa,cd_categoria_rischio, cd_data_arrivo_macello_flag_dichiarata,
			  cd_codice_azienda_provenienza,cd_seduta_macellazione, cd_piano_risanamento, cd_qualifica_sanitaria_tbc, cd_qualifica_tbc, 
			  cd_qualifica_sanitaria_brc, cd_qualifica_brc, stato_macellazione) --48
			values(_id_macello,
			rec.__codice_azienda_di_nascita,
			rec.__matricola,
			rec.__specie::integer,rec.__data_di_nascita::timestamp without time zone, rec.__sesso::boolean, rec.__razza::integer, --ok
			(case when rec.__vincolo_sanitario ='' or rec.__vincolo_sanitario is null then false else true end),rec.__mod_4,rec.__data_mod_4::timestamp without time zone, rec.__data_arrivo_al_macello::timestamp without time zone, (case when rec.__disponibili_informazioni_catena_alimentare='S' then true else false end), --ok
			(case when rec.__test_bse ='S' then 1 else 0 end),'VLLVNT63T04F839S',rec.__data_prelievo_test_bse::timestamp without time zone, rec.__data_ricezione_esito_test_bse::timestamp without time zone,coalesce(rec.__esito_test_bse::integer, -1::integer),--ok
			coalesce(rec.__note_test_bse,''),rec.__data_vam::timestamp without time zone,coalesce(rec.__provvedimento_adottato::integer, -1::integer), (case when rec.__esito ='1' then 'Favorevole' else 'Non Favorevole' end),--ok
			rec.__tipo_macellazione::integer,_data_sessione,rec.__veterinari_addetti_vpm,rec.__esito_vpm::integer,rec.__causa_presunta_o_accertata,--ok causa patologia
			rec.__data_mam::timestamp without time zone, coalesce(rec.__luogo_di_verifica::integer,-1::integer),rec.__causa,rec.__impianto_di_termodistruzione, coalesce((select bov.code from m_lookup_specie_categorie_bovine bov where upper(text_code)=rec.__categoria),-1),
			 coalesce((select buf.code from m_lookup_specie_categorie_bufaline buf where upper(text_code)=rec.__categoria),-1),rec.__note_cd,rec.__progressivo_macellazione::integer,rec.__note_mam, rec.__mezzo_di_trasporto_tipo,
			 rec.__mezzo_di_trasporto_targa, (case when rec.__trasporto_superiore_a_8_ore='S' then true else false end),rec.__destinazione_della_carcassa,rec.__categoria_di_rischio_msr::integer, (case when rec.__data_dichiararata_dal_gestore ='S' then true else false end),
			 rec.__codice_azienda_di_provenienza, _cd_seduta_macellazione, coalesce(rec.__macell_differita_piani_risanamento::integer, -1::integer), (case when rec.__qualifica_sanitaria_tbc ='1' then true else false end), coalesce(rec.__qualifica_sanitaria_tbc::integer,-1::integer), --45
			 (case when rec.__qualifica_sanitaria_brc ='1' then true else false end), coalesce(rec.__qualifica_sanitaria_brc::integer,-1::integer), (case when rec.__data_mam <> '' then 'OK-Non Macellato : Morto Prima della Macellazione.' else _stato_macellazione end)) returning id into _id_capo;
			 
	raise info 'id capo OUT%', _id_capo;
	
	if rec.__esito_vpm::integer = 3 then
		insert into m_lcso_organi(id_capo, lcso_organo) values(_id_capo, rec.__organi::integer);
	end if;
	
	if (rec.__esito_vpm::integer = 2 or rec.__esito_vpm::integer = 4) then
		insert into m_vpm_patologie_rilevate(id_capo, id_patologia) values(_id_capo, rec.__patologie_rilevate::integer);
	end if;

	if rec.__esito_vpm::integer > 0 then
		update m_capi set destinatario_1_id=_destinatario_1_id , destinatario_1_nome = _destinatario_1_nome ,destinatario_1_in_regione = true where id = _id_capo;
	end if;

	if rec.__motivo_c_1 is not null or rec.__motivo_c_1 <> '' then
		insert into m_vpm_campioni(id, id_capo, matrice, id_tipo_analisi, id_molecole, id_motivo, id_esito, note, data_ricezione_esito)
					values((select max(id)+1 from m_vpm_campioni),_id_capo, rec.__matrice_c_1::integer, rec.__tipo_analisi_c_1::integer, rec.__molecole_agente_etiologico_c_1::integer, rec.__motivo_c_1::integer, 
					rec.__esito_c_1::integer,rec.__molecole_agente_etiologico_altro_c_1,rec.__data_ricezione_esito_c_1::timestamp without time zone);
	end if;

	if rec.__eseguito_t = 'S' then
		 insert into m_vpm_tamponi(id, id_macello,data_macellazione,sessione_macellazione, piano_monitoraggio, id_tipo_ricerca, distruttivo, id_tipo_carcassa) values 
		                          (((select max(id)+1 from m_vpm_tamponi)), _id_macello, _data_sessione,_cd_seduta_macellazione,11072,rec.__tipo_analisi_t::integer,(case when rec.__metodo_distruttivo_t = 'S'  then true else false end),4) 
		                          returning id into _id_tampone;
		 raise info '_id_tampone out: %', _id_tampone;
		 insert into m_vpm_capi_tamponi  (id_m_capo, id_m_vpm_tamponi) values (_id_capo,_id_tampone);
		 insert into m_vpm_tamponi_analiti (id_tampone,id_tipo_ricerca) values(_id_tampone,rec.__tipo_analisi_t::integer);
	end if;
	
 END LOOP;
 
	return 'OK';
END
$BODY$
  LANGUAGE plpgsql VOLATILE		
  COST 100;
ALTER FUNCTION public.import_capo_macello(integer)
  OWNER TO postgres;

