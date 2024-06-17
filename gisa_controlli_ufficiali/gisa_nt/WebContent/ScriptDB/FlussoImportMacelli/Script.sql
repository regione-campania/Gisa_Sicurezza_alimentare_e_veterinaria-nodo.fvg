CREATE OR REPLACE FUNCTION public.import_capo_macello(_id_record_capo integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
   declare
	msg text ;

rec record;

prova text;

_id_macello integer;

_destinatario_1_id integer;

_destinatario_1_nome text;

_data_sessione timestamp without time zone;

_cd_seduta_macellazione integer;

_stato_macellazione text;

_id_capo integer;

_id_tampone integer;

vet1 text;

vet2 text;

vet3 text;

vpm_vet1 text;

vpm_vet2 text;

vpm_vet3 text;

_progressivo int;

nome text;

cognome text;

nome2 text;

cognome2 text;

nome3 text;

cognome3 text;

pat1 text;

pat2 text;

pat3 text;

org1 text;

org2 text;

org3 text;

id_asl text;

data_sessione text;

data1 text;

data2 text;

data3 text;

controllo text;

begin
--_destinatario_1_nome = 'REALBEEF S.R.L.';
	
	_stato_macellazione ='OK.';
	
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
		  __metodo_distruttivo_t,
		  __id_macello,
		  __destinatario_1_id,
		  __data_sessione,
		  __cd_seduta_macellazione,
		  __data_import,
		  id_import 
		  from import_capi_macello  where id = _id_record_capo and __data_import is null

  loop
  
  		rec.__codice_azienda_di_provenienza= trim(rec.__codice_azienda_di_provenienza) ;
		rec.__codice_azienda_di_nascita  = trim(rec.__codice_azienda_di_nascita);
		rec.__matricola  = trim(rec.__matricola) ;
		rec.__specie = trim( rec.__specie) ;
		rec.__categoria  = trim(rec.__categoria) ;
		rec.__razza = trim( rec.__razza) ;
		rec.__sesso = trim( rec.__sesso) ;
		rec.__data_di_nascita  = trim(rec.__data_di_nascita) ;
		rec.__categoria_di_rischio_msr = trim( rec.__categoria_di_rischio_msr) ;
		rec.__vincolo_sanitario  = trim(rec.__vincolo_sanitario) ;
		rec.__qualifica_sanitaria_tbc  = trim(rec.__qualifica_sanitaria_tbc) ;
		rec.__qualifica_sanitaria_brc = trim( rec.__qualifica_sanitaria_brc );
		rec.__mod_4 = trim( rec.__mod_4 );
		rec.__data_mod_4 = trim( rec.__data_mod_4 );
		 rec.__macell_differita_piani_risanamento = trim(rec.__macell_differita_piani_risanamento );
		rec.__test_bse = trim( rec.__test_bse );
		rec.__informazioni_test_bse = trim( rec.__informazioni_test_bse );
		rec.__data_prelievo_test_bse = trim( rec.__data_prelievo_test_bse );
		rec.__data_ricezione_esito_test_bse = trim( rec.__data_ricezione_esito_test_bse );
		rec.__esito_test_bse = trim( rec.__esito_test_bse );
		rec.__note_test_bse = trim( rec.__note_test_bse );
		rec.__disponibili_informazioni_catena_alimentare = trim( rec.__disponibili_informazioni_catena_alimentare );
		rec.__data_arrivo_al_macello = trim( rec.__data_arrivo_al_macello );
		rec.__data_dichiararata_dal_gestore = trim( rec.__data_dichiararata_dal_gestore );
		rec.__mezzo_di_trasporto_tipo = trim( rec.__mezzo_di_trasporto_tipo );
		rec.__mezzo_di_trasporto_targa = trim( rec.__mezzo_di_trasporto_targa );
		rec.__trasporto_superiore_a_8_ore = trim( rec.__trasporto_superiore_a_8_ore );
		rec.__veterinari_addetti_cd = trim( rec.__veterinari_addetti_cd );
		 rec.__note_cd = trim(rec.__note_cd );
		 rec.__data_mam = trim(rec.__data_mam );
		rec.__luogo_di_verifica  = trim(rec.__luogo_di_verifica );
		rec.__causa = trim( rec.__causa );
		rec.__impianto_di_termodistruzione = trim( rec.__impianto_di_termodistruzione );
		rec.__destinazione_della_carcassa = trim( rec.__destinazione_della_carcassa );
		rec.__comunicazione_a_mam = trim( rec.__comunicazione_a_mam );
		rec.__note_mam = trim( rec.__note_mam );
		rec.__data_vam = trim( rec.__data_vam );
		rec.__esito = trim( rec.__esito );
		rec.__provvedimento_adottato = trim( rec.__provvedimento_adottato );
		rec.__comunicazione_a_vam = trim( rec.__comunicazione_a_vam );
		rec.__note_vam = trim( rec.__note_vam );
		rec.__tipo_macellazione  = trim(rec.__tipo_macellazione );
		rec.__progressivo_macellazione  = trim(rec.__progressivo_macellazione);
		rec.__esito_vpm  = trim(rec.__esito_vpm );
		rec.__patologie_rilevate  = trim(rec.__patologie_rilevate );
		 rec.__organi = trim(rec.__organi );
		rec.__causa_presunta_o_accertata  = trim(rec.__causa_presunta_o_accertata );
		 rec.__veterinari_addetti_vpm = trim(rec.__veterinari_addetti_vpm );
		rec.__destinatario_carni  = trim(rec.__destinatario_carni );
		rec.__motivo_c_1  = trim(rec.__motivo_c_1 );
		rec.__matrice_c_1  = trim(rec.__matrice_c_1 );
		rec.__tipo_analisi_c_1  = trim(rec.__tipo_analisi_c_1 );
		rec.__molecole_agente_etiologico_c_1  = trim(rec.__molecole_agente_etiologico_c_1 );
		rec.__molecole_agente_etiologico_altro_c_1  = trim(rec.__molecole_agente_etiologico_altro_c_1 );
		rec.__esito_c_1  = trim(rec.__esito_c_1 );
		rec.__data_ricezione_esito_c_1  = trim(rec.__data_ricezione_esito_c_1 );
		 rec.__motivo_c_2 = trim(rec.__motivo_c_2 );
		rec.__matrice_c_2  = trim(rec.__matrice_c_2 );
		rec.__tipo_analisi_c_2  = trim(rec.__tipo_analisi_c_2 );
		 rec.__molecole_agente_etiologico_c_2 = trim(rec.__molecole_agente_etiologico_c_2 );
		rec.__molecole_agente_etiologico_altro_c_2  = trim(rec.__molecole_agente_etiologico_altro_c_2 );
		rec.__esito_c_2  = trim(rec.__esito_c_2 );
		rec.__data_ricezione_esito_c_2  = trim(rec.__data_ricezione_esito_c_2 );
		 rec.__motivo_c_3 = trim(rec.__motivo_c_3 );
		rec.__matrice_c_3  = trim(rec.__matrice_c_3 );
		rec.__tipo_analisi_c_3  = trim(rec.__tipo_analisi_c_3 );
		rec.__molecole_agente_etiologico_c_3  = trim(rec.__molecole_agente_etiologico_c_3 );
		rec.__molecole_agente_etiologico_altro_c_3  = trim(rec.__molecole_agente_etiologico_altro_c_3 );
		rec.__esito_c_3  = trim(rec.__esito_c_3 );
		 rec.__data_ricezione_esito_c_3 = trim(rec.__data_ricezione_esito_c_3 );
		 rec.__motivo_c_4 = trim(rec.__motivo_c_4 );
		rec.__matrice_c_4  = trim(rec.__matrice_c_4 );
		rec.__tipo_analisi_c_4  = trim(rec.__tipo_analisi_c_4 );
		 rec.__molecole_agente_etiologico_c_4 = trim(rec.__molecole_agente_etiologico_c_4 );
		rec.__molecole_agente_etiologico_altro_c_4  = trim(rec.__molecole_agente_etiologico_altro_c_4 );
		rec.__esito_c_4  = trim(rec.__esito_c_4 );
		rec.__data_ricezione_esito_c_4  = trim(rec.__data_ricezione_esito_c_4 );
		rec.__motivo_c_5  = trim(rec.__motivo_c_5 );
		 rec.__matrice_c_5 = trim(rec.__matrice_c_5 );
		 rec.__tipo_analisi_c_5 = trim(rec.__tipo_analisi_c_5 );
		rec.__molecole_agente_etiologico_c_5  = trim(rec.__molecole_agente_etiologico_c_5 );
		 rec.__molecole_agente_etiologico_altro_c_5 = trim(rec.__molecole_agente_etiologico_altro_c_5 );
		 rec.__esito_c_5 = trim(rec.__esito_c_5 );
		 rec.__data_ricezione_esito_c_5 = trim(rec.__data_ricezione_esito_c_5 );
		 rec.__eseguito_t = trim(rec.__eseguito_t );
		 rec.__tipo_analisi_t = trim(rec.__tipo_analisi_t );
		 rec.__metodo_distruttivo_t = trim(rec.__metodo_distruttivo_t);
		 rec.__id_macello = trim(rec.__id_macello);
		 rec.__destinatario_1_id = trim(rec.__destinatario_1_id);
		 rec.__data_sessione = trim(rec.__data_sessione);
		 rec.__cd_seduta_macellazione = trim(rec.__cd_seduta_macellazione);
		 rec.__data_import = trim(rec.__data_import);
  
  
  
  
  
  
  
	nome='';
	cognome ='';
  	vet1='';
    vet2='';
   	vet3='';
   	pat1='';
    pat2='';
    pat3='';
   	org1='';
    org2='';
    org3='';
  
    select distinct ragione_sociale,asl_rif into _destinatario_1_nome,id_asl from ricerche_anagrafiche_old_materializzata where riferimento_id = rec.__id_macello::integer; 
	
   
      rec.__disponibili_informazioni_catena_alimentare='s';

   
   
	SELECT split_part(rec.__veterinari_addetti_cd, '/',1) into vet1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__veterinari_addetti_cd, '/',2) into vet2
	FROM  import_capi_macello;  
	raise info 'vet:%', vet1;

	SELECT split_part(rec.__veterinari_addetti_cd, '/',3) into vet3
	FROM  import_capi_macello;  





		SELECT split_part(rec.__veterinari_addetti_vpm, '/',1) into vpm_vet1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__veterinari_addetti_vpm, '/',2) into vpm_vet2
	FROM  import_capi_macello;  

	SELECT split_part(rec.__veterinari_addetti_vpm, '/',3) into vpm_vet3
	FROM  import_capi_macello;  

	


		SELECT split_part(rec.__data_sessione, '/',1) into data1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__data_sessione, '/',2) into data2
	FROM  import_capi_macello;  

	SELECT split_part(rec.__data_sessione, '/',3) into data3
	FROM  import_capi_macello;  

	data_sessione = concat(data3,'/',data2,'/',data1);



SELECT split_part(rec.__patologie_rilevate, '/',1) into pat1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__patologie_rilevate, '/',2) into pat2
	FROM  import_capi_macello;  

	SELECT split_part(rec.__patologie_rilevate, '/',3) into pat3
	FROM  import_capi_macello;  

	SELECT split_part(rec.__organi, '/',1) into org1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__organi, '/',2) into org2
	FROM  import_capi_macello;  

	SELECT split_part(rec.__organi, '/',3) into org3
	FROM  import_capi_macello;  

	if vet1 <> '' then
	select namelast,namefirst into cognome,nome from access 
	join contact on access.contact_id = contact.contact_id where codice_fiscale = vet1 and access.role_id ='43' and contact.site_id = id_asl::integer;
	vet1 = CONCAT(cognome,' ',nome);
	raise info 'nome:%', nome;
	raise info 'cognome:%', cognome;
	if vet1 = ' ' then
	vet1 = '';
    end if;
	else
	vet1 = '';
	
    end if;
	raise info 'vet:%', vet1;
	
	if vet2 <> '' then
	select namelast,namefirst into cognome2,nome2 from access 
	join contact on access.contact_id = contact.contact_id where codice_fiscale = vet2 and access.role_id ='43' and contact.site_id = id_asl::integer; 
	vet2 = CONCAT(cognome2,' ',nome2);
	raise info 'nome:%', nome2;
	raise info 'cognome:%', cognome2;
	if vet2 = ' ' then
	vet2 = '';
    end if;
	else
	vet2 = '';
	
    end if;
	raise info 'vet:%', vet2;


	if vet3 <> '' then
	select namelast,namefirst into cognome3,nome3 from access 
	join contact on access.contact_id = contact.contact_id where codice_fiscale = vet3 and access.role_id ='43' and contact.site_id = id_asl::integer; 	vet3 = CONCAT(cognome3,' ',nome3);
	raise info 'nome:%', nome3;
	raise info 'cognome:%', cognome3;
	if vet3 = ' ' then
	vet3 = '';
    end if;
	else
	vet3 = '';
	
    end if;
	raise info 'vet:%', vet3;



    
   
   
  	nome='';
  	cognome='';
  	nome2='';
  	cognome2='';
  	nome3='';
  	cognome3='';
   
   
  
  	

	if vpm_vet1 <> '' then
	select namelast,namefirst into cognome,nome from access 
	join contact on access.contact_id = contact.contact_id where codice_fiscale = vpm_vet1 and access.role_id ='43' and contact.site_id = id_asl::integer; 
	vpm_vet1 = CONCAT(cognome,' ',nome);
	raise info 'nome:%', nome;
	raise info 'cognome:%', cognome;
	if vpm_vet1 = ' ' then
	vpm_vet1 = '';
    end if;
	else
	vpm_vet1 = '';
	
    end if;
	raise info 'vet:%', vpm_vet1;
	
	if vpm_vet2 <> '' then
	select namelast,namefirst into cognome2,nome2 from access 
	join contact on access.contact_id = contact.contact_id where codice_fiscale = vpm_vet2 and access.role_id ='43' and contact.site_id = id_asl::integer; 
	vpm_vet2 = CONCAT(cognome2,' ',nome2);
	raise info 'nome:%', nome2;
	raise info 'cognome:%', cognome2;
	if vpm_vet2 = ' ' then
	vpm_vet2 = '';
    end if;
	else
	vpm_vet2 = '';
	
    end if;
	raise info 'vet:%', vpm_vet2;


	if vpm_vet3 <> '' then
	select namelast,namefirst into cognome3,nome3 from access 
	join contact on access.contact_id = contact.contact_id where codice_fiscale = vpm_vet3 and access.role_id ='43' and contact.site_id = id_asl::integer; 
	vpm_vet3 = CONCAT(cognome3,' ',nome3);
	raise info 'nome:%', nome3;
	raise info 'cognome:%', cognome3;
	if vpm_vet3 = ' ' then
	vpm_vet3 = '';
    end if;
	else
	vpm_vet3 = '';
	
    end if;
	raise info 'vet:%', vpm_vet3;

 raise info 'data mod11%',rec.__data_arrivo_al_macello::timestamp;

raise info 'vpm_vet1 13  : %', vpm_vet1;




   
   
   if vet1 = '' and vet2 = '' and vet3 = '' then 
   vet1 ='';
   vet2 = '';
   vet3 = '';
   else if vet1 = '' then
   vet1 = (case when vet2 ='' then vet3 else vet2 end);
   vet2='';
   vet3='';

   end if;
   end if;
  
  if trim(vet1) = '' then
  vet1 = '';
 end if;
   
   
   if vpm_vet1 = '' and vpm_vet2 = '' and vpm_vet3 = '' then 
   vpm_vet1= '';
   vpm_vet2 = '';
   vpm_vet3 = '';
  else if vpm_vet1 = '' then
  vpm_vet1 = (case when vpm_vet2 ='' then vpm_vet3 else vpm_vet2 end);
   vpm_vet2='';
   vpm_vet3='';

   end if;
   end if;
  
  
  
  
  
  
  
  raise info 'vpm_vet13  : %', vpm_vet1;
  
   if trim(upper(rec.__sesso)) = 'TRUE' then
   rec.__sesso = rec.__sesso::boolean;
   else
   if trim(upper(rec.__sesso)) = 'FALSE' then
   rec.__sesso = rec.__sesso::boolean;
   else
   return 'KO: Sesso';
  end if;
 end if;
   
	 
  
  if rec.__specie != '1' and rec.__specie != '5' then 
  		rec.__categoria = null;
  		rec.__test_bse = null;
  		rec.__informazioni_test_bse='-1';
		rec.__data_prelievo_test_bse='';
		rec.__data_ricezione_esito_test_bse='';
		  rec.__esito_test_bse='-1';
		  rec.__note_test_bse ='';
  	RAISE NOTICE 'specie';
  	end if;

  if rec.__specie != '1'  then 
  		rec.__razza = null;
  	  	RAISE NOTICE 'specie 2';

  	end if;
  
 if UPPER(rec.__test_bse) != 'S' then 
  		rec.__informazioni_test_bse = null;
		rec.__data_prelievo_test_bse='';
		rec.__data_ricezione_esito_test_bse='';
		  rec.__esito_test_bse='-1';
		  rec.__note_test_bse ='';
   else 
  
  	if trim(rec.__esito_test_bse)::integer = 1 then 
  	   rec.__esito_test_bse = 'POSITIVO AL TEST';
  	   else 
  	   if trim(rec.__esito_test_bse)::integer = 2 then
  	   rec.__esito_test_bse = 'NEGATIVO AL TEST';
  	  else rec.__esito_test_bse = '';
  	  end if;
	end if;
  	end if;

  
  if rec.__esito_vpm != '2' and rec.__esito_vpm != '4' then 
    rec.__patologie_rilevate = null;
   	RAISE NOTICE 'esito1';

   end if;
  
  if rec.__esito_vpm != '3' then 
    rec.__organi = null;
   	RAISE NOTICE 'esito2';
   end if;
  
  if rec.__molecole_agente_etiologico_c_1 != '262' and rec.__tipo_analisi_c_1 != '5' then 
  rec.__molecole_agente_etiologico_c_1 = null;
  RAISE NOTICE 'c1';

   end if;
  
  if rec.__molecole_agente_etiologico_c_2 != '262' and rec.__tipo_analisi_c_2 != '5' then 
  
  rec.__molecole_agente_etiologico_c_2 = null;
  RAISE NOTICE 'c2';

   end if;
  
  
  if rec.__molecole_agente_etiologico_c_3 != '262'
and rec.__tipo_analisi_c_3 != '5' then 
  
  rec.__molecole_agente_etiologico_c_3 = null;

raise notice 'c3';
end if;

if rec.__molecole_agente_etiologico_c_4 != '262'
and rec.__tipo_analisi_c_4 != '5' then 
  
  rec.__molecole_agente_etiologico_c_4 = null;

raise notice 'c4';
end if;

if rec.__molecole_agente_etiologico_c_5 != '262'
and rec.__tipo_analisi_c_5 != '5' then 
  
  rec.__molecole_agente_etiologico_c_5 = null;

raise notice 'c5';
end if;



 
	-- inserimento in m_capi
      insert into m_capi(id_macello, cd_codice_azienda, cd_matricola, cd_specie, cd_data_nascita, 
                          cd_maschio, cd_id_razza, cd_vincolo_sanitario,cd_piano_risanamento,cd_vincolo_sanitario_motivo,cd_vincolo_sanitario_piano,cd_mod4, cd_data_mod4, 
                          cd_data_arrivo_macello, cd_info_catena_alimentare,bse_esito , cd_veterinario_1,cd_veterinario_2,cd_veterinario_3, bse_data_prelievo, 
                          bse_data_ricezione_esito, cd_bse, bse_note,vam_data, vam_provvedimenti, 
                          vam_esito, mac_tipo, 
	 		  cd_categoria_bovina,
			  cd_categoria_bufalina,cd_note,  cd_tipo_mezzo_trasporto, --35
			  cd_targa_mezzo_trasporto, cd_trasporto_superiore8ore, cd_categoria_rischio, cd_data_arrivo_macello_flag_dichiarata,
			  cd_codice_azienda_provenienza,cd_seduta_macellazione, cd_qualifica_sanitaria_tbc, cd_qualifica_tbc, 
			  cd_qualifica_sanitaria_brc, cd_qualifica_brc,vam_to_asl_origine,vam_to_proprietario_animale, vam_to_azienda_origine, 
			  vam_to_proprietario_macello, vam_to_pif, vam_to_uvac, vam_to_regione, vam_to_altro,stato_macellazione,destinatario_1_id,destinatario_1_in_regione, destinatario_1_nome,destinatario_2_id,destinatario_2_nome,destinatario_3_id,destinatario_4_id,id_import,vpm_data,progressivo_macellazione,vpm_veterinario) --48
			values(rec.__id_macello::integer,
			rec.__codice_azienda_di_nascita,
			trim(rec.__matricola),
			rec.__specie::integer,trim(rec.__data_di_nascita)::timestamp without time zone, rec.__sesso::boolean, rec.__razza::integer, --ok
			(case when rec.__vincolo_sanitario ='' or rec.__vincolo_sanitario is null or rec.__vincolo_sanitario in ('1','2','3') then false else true end),(case when rec.__vincolo_sanitario in ('1','2','3') then rec.__vincolo_sanitario::integer end),(case when rec.__vincolo_sanitario ='' or rec.__vincolo_sanitario is null or rec.__vincolo_sanitario in ('1','2','3') then '' else rec.__vincolo_sanitario end),(case when rec.__vincolo_sanitario in ('1','2','3') then true else false end),
			rec.__mod_4,trim(rec.__data_mod_4)::timestamp without time zone,trim(rec.__data_arrivo_al_macello)::timestamp without time zone, (case when UPPER(rec.__disponibili_informazioni_catena_alimentare)='S' then true else false end), --ok
			(case when upper(rec.__test_bse) = 'S' then rec.__esito_test_bse else '-1' end),vet1,vet2,vet3,(case when upper(rec.__test_bse) = 'S' then case when trim(rec.__data_prelievo_test_bse) <>'' then trim(rec.__data_prelievo_test_bse)::timestamp without time zone else null end else null end ),(case when trim(rec.__data_ricezione_esito_test_bse) <>'' then trim(rec.__data_ricezione_esito_test_bse)::timestamp without time zone else null end) ,rec.__informazioni_test_bse::integer,--ok
			coalesce(rec.__note_test_bse,''),(case when trim(rec.__data_vam) <>'' then trim(rec.__data_vam)::timestamp without time zone else null end),coalesce(rec.__provvedimento_adottato::integer, -1::integer), (case when rec.__esito ='1' then 'Favorevole' else case when rec.__esito ='2'then 'Favorevole con riserva' else case when rec.__esito ='3' then 'Non Favorevole' else '' end end end),--ok
			rec.__tipo_macellazione::integer,--ok causa patologia
			  coalesce((select bov.code from m_lookup_specie_categorie_bovine bov where upper(text_code)=rec.__categoria),-1),
			 coalesce((select buf.code from m_lookup_specie_categorie_bufaline buf where upper(text_code)=rec.__categoria),-1),rec.__note_cd, rec.__mezzo_di_trasporto_tipo,
			 rec.__mezzo_di_trasporto_targa, (case when UPPER(rec.__trasporto_superiore_a_8_ore)='S' then true else false end),(case when rec.__categoria_di_rischio_msr::integer = -1 then 0 end), (case when UPPER(rec.__data_dichiararata_dal_gestore) ='S' then true else false end),
			 rec.__codice_azienda_di_provenienza, rec.__cd_seduta_macellazione::integer, (case when rec.__qualifica_sanitaria_tbc ='1' then true else false end), coalesce(rec.__qualifica_sanitaria_tbc::integer,-1::integer), --45
			 (case when rec.__qualifica_sanitaria_brc ='1' then true else false end), coalesce(rec.__qualifica_sanitaria_brc::integer,-1::integer),(case when rec.__comunicazione_a_vam = '1' then true else false end), (case when rec.__comunicazione_a_vam = '2' then true else false end),(case when rec.__comunicazione_a_vam = '3' then true else false end),
			(case when rec.__comunicazione_a_vam = '4' then true else false end),(case when UPPER(rec.__comunicazione_a_vam) = '5' then true else false end),(case when rec.__comunicazione_a_vam = '6' then true else false end),(case when rec.__comunicazione_a_vam = '7' then true else false end),
			(case when rec.__comunicazione_a_vam = '8' then true else false end),_stato_macellazione,rec.__destinatario_1_id::integer,true,_destinatario_1_nome::text,-1,'',-1,-1,rec.id_import,rec.__data_sessione::timestamp without time zone,trim(rec.__progressivo_macellazione)::integer,vpm_vet1) returning id into _id_capo;
			 
		
		
		
		
		
	raise info 'id capo OUT%', _id_capo;
	
		if rec.__data_ricezione_esito_test_bse <> '' and rec.__esito_test_bse = '' then
		  update m_capi set stato_macellazione = 'Incompleto: Inseriti solo i dati sul controllo documentale, Mancanza esito del Test BSE' where id = _id_capo;
		 _stato_macellazione = 'KO';
		end if;
		 
	
	
	if trim(rec.__data_mam) <> '' then 
		if rec.__luogo_di_verifica = '-1' or rec.__causa = '' then 
		return 'KO: mam_obb';
	else
		update m_capi set mavam_data = rec.__data_mam::timestamp without time zone,mavam_luogo = coalesce(rec.__luogo_di_verifica::integer,-1::integer),mavam_note = rec.__note_mam ,mavam_motivo = rec.__causa,mavam_impianto_termodistruzione = rec.__impianto_di_termodistruzione,mvam_destinazione_carcassa = rec.__destinazione_della_carcassa,
		mavam_to_asl_origine = (case when rec.__comunicazione_a_mam = '1' then true else false end),mavam_to_proprietario_animale = (case when rec.__comunicazione_a_mam = '2' then true else false end),mavam_to_azienda_origine = (case when rec.__comunicazione_a_mam = '3' then true else false end),mavam_to_proprietario_macello = (case when rec.__comunicazione_a_mam = '4' then true else false end),mavam_to_pif = (case when rec.__comunicazione_a_mam = '5' then true else false end),
		mavam_to_uvac = (case when rec.__comunicazione_a_mam = '6' then true else false end),mavam_to_regione = (case when rec.__comunicazione_a_mam = '7' then true else false end),mavam_to_altro = (case when rec.__comunicazione_a_mam = '8' then true else false end),stato_macellazione = 'OK-Non Macellato : Morto Prima della Macellazione' where id = _id_capo;
	end if;
end if;
	
	if trim(rec.__data_mam) <> '' and rec.__esito_vpm::integer > 0  then 
	
	return 'KO: mam_vpm';
	 end if;

		




	if rec.__esito_vpm::integer = 3 then
		if org1 <> '' then
		insert into m_lcso_organi(id_capo, lcso_organo,enabled) values(_id_capo, org1::integer,true);
		end if;
	if org2 <> '' then
		insert into m_lcso_organi(id_capo, lcso_organo,enabled) values(_id_capo, org2::integer,true);
		end if;
	if org3 <> '' then
		insert into m_lcso_organi(id_capo, lcso_organo,enabled) values(_id_capo, org3::integer,true);
		end if;
	

	end if;
	


	if (rec.__esito_vpm::integer = 2 or rec.__esito_vpm::integer = 4) then
		if pat1 <> '' then
		insert into m_vpm_patologie_rilevate(id_capo, id_patologia) values(_id_capo, pat1::integer);
	end if;
			if pat2 <> '' then
		insert into m_vpm_patologie_rilevate(id_capo, id_patologia) values(_id_capo, pat2::integer);
	end if;
			if pat3 <> '' then
		insert into m_vpm_patologie_rilevate(id_capo, id_patologia) values(_id_capo, pat3::integer);
	end if;
	end if;


if rec.__esito_vpm::integer > 0 then
		update m_capi set vpm_esito=rec.__esito_vpm::integer, vpm_causa_patologia= rec.__causa_presunta_o_accertata where id = _id_capo;
end if;
/*
	if rec.__esito_vpm::integer > 0 then
		update m_capi set destinatario_1_id=rec.__destinatario_1_id::integer,vpm_data = rec.__data_sessione::timestamp without time zone, destinatario_1_nome = _destinatario_1_nome ,destinatario_1_in_regione = true,vpm_veterinario = vpm_vet1,vpm_veterinario_2 = vpm_vet2,vpm_veterinario_3 = vpm_vet3,vpm_esito=rec.__esito_vpm::integer, vpm_causa_patologia= rec.__causa_presunta_o_accertata, stato_macellazione = (case when rec.__data_mam <> '' then 'OK-Non Macellato : Morto Prima della Macellazione.' else _stato_macellazione end) where id = _id_capo;
		 if vet1 <> 'VETERINARIO MANCANTE' and vpm_vet1 <> 'VETERINARIO MANCANTE'
	then
	if rec.__progressivo_macellazione = -1 or rec.__progressivo_macellazione = 0 or rec.__progressivo_macellazione = '' or rec.__progressivo_macellazione is NULL  then
	select max(progressivo_macellazione)  into _progressivo from m_capi mc where vpm_data = rec.__data_sessione::timestamp without time zone and cd_seduta_macellazione =rec.__cd_seduta_macellazione::integer;
		if _progressivo is null then
			raise info 'prog%',_progressivo;
		_progressivo = 1;
	end if;
	_progressivo = _progressivo::integer + 1;
	raise info 'prog%',_progressivo;
		update m_capi set progressivo_macellazione = _progressivo where id = _id_capo;
end if;
end if;
end if;
*/

	if rec.__motivo_c_1 <> '-1' and rec.__motivo_c_1 <> '' then
		insert into m_vpm_campioni(id, id_capo, matrice, id_tipo_analisi, id_molecole, id_motivo, id_esito, note, data_ricezione_esito)
					values((select max(id)+1 from m_vpm_campioni),_id_capo, rec.__matrice_c_1::integer, rec.__tipo_analisi_c_1::integer, rec.__molecole_agente_etiologico_c_1::integer, rec.__motivo_c_1::integer, 
					rec.__esito_c_1::integer,rec.__molecole_agente_etiologico_altro_c_1,rec.__data_ricezione_esito_c_1::timestamp without time zone);
				if rec.__esito_c_1 <= '0' and rec.__motivo_c_1 <> '-1' then
						  update m_capi set stato_macellazione = 'Incompleto: Presenti campioni senza esito' where id = _id_capo;
						 _stato_macellazione = 'KO';
				end if;
	end if;



if rec.__motivo_c_2 <> '-1' and rec.__motivo_c_2 <> '' then
		insert into m_vpm_campioni(id, id_capo, matrice, id_tipo_analisi, id_molecole, id_motivo, id_esito, note, data_ricezione_esito)
					values((select max(id)+1 from m_vpm_campioni),_id_capo, rec.__matrice_c_2::integer, rec.__tipo_analisi_c_2::integer, rec.__molecole_agente_etiologico_c_2::integer, rec.__motivo_c_2::integer, 
					rec.__esito_c_2::integer,rec.__molecole_agente_etiologico_altro_c_2,rec.__data_ricezione_esito_c_2::timestamp without time zone);
					if rec.__esito_c_2 <= '0' and rec.__motivo_c_2 <> '-1' then
						  update m_capi set stato_macellazione = 'Incompleto: Presenti campioni senza esito' where id = _id_capo;
									 _stato_macellazione = 'KO';
		
				end if;
	end if;


if rec.__motivo_c_3 <> '-1' and rec.__motivo_c_3 <> '' then
		insert into m_vpm_campioni(id, id_capo, matrice, id_tipo_analisi, id_molecole, id_motivo, id_esito, note, data_ricezione_esito)
					values((select max(id)+1 from m_vpm_campioni),_id_capo, rec.__matrice_c_3::integer, rec.__tipo_analisi_c_3::integer, rec.__molecole_agente_etiologico_c_3::integer, rec.__motivo_c_3::integer, 
					rec.__esito_c_3::integer,rec.__molecole_agente_etiologico_altro_c_3,rec.__data_ricezione_esito_c_3::timestamp without time zone);
						if rec.__esito_c_3 <= '0' and rec.__motivo_c_3 <> '-1' then
						  update m_capi set stato_macellazione = 'Incompleto: Presenti campioni senza esito' where id = _id_capo;
									 _stato_macellazione = 'KO';
			
					end if;

	end if;



if rec.__motivo_c_4 <> '-1' and rec.__motivo_c_4 <> '' then
		insert into m_vpm_campioni(id, id_capo, matrice, id_tipo_analisi, id_molecole, id_motivo, id_esito, note, data_ricezione_esito)
					values((select max(id)+1 from m_vpm_campioni),_id_capo, rec.__matrice_c_4::integer, rec.__tipo_analisi_c_4::integer, rec.__molecole_agente_etiologico_c_4::integer, rec.__motivo_c_4::integer, 
					rec.__esito_c_4::integer,rec.__molecole_agente_etiologico_altro_c_4,rec.__data_ricezione_esito_c_4::timestamp without time zone);
				if rec.__esito_c_4 <= '0' and rec.__motivo_c_4 <> '-1' then
						  update m_capi set stato_macellazione = 'Incompleto: Presenti campioni senza esito' where id = _id_capo;
									 _stato_macellazione = 'KO';

						 end if;
				
			end if;



if rec.__motivo_c_5 <> '-1' and rec.__motivo_c_5 <> '' then
		insert into m_vpm_campioni(id, id_capo, matrice, id_tipo_analisi, id_molecole, id_motivo, id_esito, note, data_ricezione_esito)
					values((select max(id)+1 from m_vpm_campioni),_id_capo, rec.__matrice_c_5::integer, rec.__tipo_analisi_c_5::integer, rec.__molecole_agente_etiologico_c_5::integer, rec.__motivo_c_5::integer, 
					rec.__esito_c_5::integer,rec.__molecole_agente_etiologico_altro_c_5,rec.__data_ricezione_esito_c_5::timestamp without time zone);
						if rec.__esito_c_5 <= '0' and rec.__motivo_c_5 <> '-1' then
						  update m_capi set stato_macellazione = 'Incompleto: Presenti campioni senza esito' where id = _id_capo;
										 _stato_macellazione = 'KO';

						 end if;
					
			end if;

		/* if _destinatario_1_nome = '' and rec.__data_mam = '' then
		 if _stato_macellazione = 'OK' or _stato_macellazione = 'OK.' then
				 update m_capi set stato_macellazione = 'Incompleto: Mancanza Destinatari Carni' where id = _id_capo;
		 		_stato_macellazione = 'KO';

				else
		   		 update m_capi set stato_macellazione = concat(stato_macellazione,', Mancanza Destinatari Carni') where id = _id_capo;
		  end if;
		 end if;
		*/
		
			if _destinatario_1_nome = '' and rec.__data_mam <> '' then
				 update m_capi set stato_macellazione = 'OK-Non Macellato : Morto Prima della Macellazione' where id = _id_capo;
		 		_stato_macellazione = 'KO';
		 end if;
		
		
		
		
		if 	rec.__provvedimento_adottato = '5'  then
		 if _stato_macellazione = 'OK' or _stato_macellazione = 'OK.' then
				 update m_capi set stato_macellazione = 'Incompleto : In visita AM il provvedimento adottato e'''' Isolamento''' where id = _id_capo;
				_stato_macellazione = 'KO';
		  else
		   		 update m_capi set stato_macellazione = concat(stato_macellazione,', In visita AM il provvedimento adottato e'''' Isolamento''') where id = _id_capo;
		  end if;
		 end if;

		
		--		if( capo.getVpm_esito() == 4 && capo.getLcpr_data_effettiva_liber() == null )



	if UPPER(rec.__eseguito_t) = 'S' then
		 insert into m_vpm_tamponi(id, id_macello,data_macellazione,sessione_macellazione, piano_monitoraggio, id_tipo_ricerca, distruttivo, id_tipo_carcassa) values 
		                          (((select max(id)+1 from m_vpm_tamponi)), _id_macello::integer, rec.__data_sessione::timestamp without time zone,rec.__cd_seduta_macellazione::integer,11072,rec.__tipo_analisi_t::integer,(case when UPPER(rec.__metodo_distruttivo_t) = 'S'  then true else false end),4) 
		                          returning id into _id_tampone;
		 raise info '_id_tampone out: %', _id_tampone;
		 insert into m_vpm_capi_tamponi  (id_m_capo, id_m_vpm_tamponi) values (_id_capo,_id_tampone);
		 insert into m_vpm_tamponi_analiti (id_tampone,id_tipo_ricerca) values(_id_tampone,rec.__tipo_analisi_t::integer);
	end if;
	

if vet1 ='VETERINARIO MANCANTE' or vpm_vet1 = 'VETERINARIO MANCANTE' then
update m_capi set stato_macellazione = 'Incompleto: Veterinario mancante' where id = _id_capo;
end if;
 raise info 'vpm_vet1 123123  : %', vpm_vet1;

if rec.__data_mam <> ''  then
update m_capi set stato_macellazione = 'OK-Non Macellato : Morto Prima della Macellazione', vpm_data = null,destinatario_1_id = -1,destinatario_1_nome = '',destinatario_2_id = -1,destinatario_2_nome = '', vpm_data_esito =null,vpm_esito =-1,vpm_note ='',vpm_causa_patologia ='',vam_provvedimenti_note ='',mac_progressivo =-1,mac_tipo =-1 where id = _id_capo;
end if;

if 	rec.__data_prelievo_test_bse <> '' and rec.__esito_test_bse = '-1' then
		 if _stato_macellazione = 'OK' or _stato_macellazione = 'OK.' then
		  else
		   		 update m_capi set stato_macellazione = concat(stato_macellazione,', Mancanza esito del Test BSE') where id = _id_capo;
		  end if;
		 end if;

 --select * into prova from  import_capo_macello_stato(_id_capo) ;
		
		
UPDATE import_capi_macello set __data_import = CURRENT_TIMESTAMP WHERE id = _id_record_capo::integer;
 END LOOP;
 
	return 'OK';
END
$function$
;















CREATE OR REPLACE FUNCTION public.import_capo_macello_control(_id_record_capo integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
   DECLARE
	rec record;
   check_ text;
   org1 text;
     org2 text;
    org3 text;
	pat1 text;
	pat2 text;
	pat3 text;
vet1 text;
vet2 text;
vet3 text;
vpm_vet1 text;
vpm_vet2 text;
vpm_vet3 text;
nome text;
cognome text;
nome2 text;
cognome2 text;
nome3 text;
cognome3 text;
id_asl text;
data_sessione text;
data1 text;
data2 text;
data3 text;
_id_macello integer;
_destinatario_1_id integer;
_destinatario_1_nome text;
_data_sessione timestamp without time zone;
_cd_seduta_macellazione integer;
_stato_macellazione text;
_id_capo integer;
_id_tampone integer;
matr integer;
progress integer;
sql1 text;
	BEGIN


	
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
		  __metodo_distruttivo_t,
		  __id_macello,
		  __destinatario_1_id,
		  __data_sessione,
		  __cd_seduta_macellazione,
		  __data_import
		  from import_capi_macello  where id = _id_record_capo and __data_import is null

  loop
  
  		rec.__codice_azienda_di_provenienza= trim(rec.__codice_azienda_di_provenienza) ;
		rec.__codice_azienda_di_nascita  = trim(rec.__codice_azienda_di_nascita);
		rec.__matricola  = trim(rec.__matricola) ;
		rec.__specie = trim( rec.__specie) ;
		rec.__categoria  = trim(rec.__categoria) ;
		rec.__razza = trim( rec.__razza) ;
		rec.__sesso = trim( rec.__sesso) ;
		rec.__data_di_nascita  = trim(rec.__data_di_nascita) ;
		rec.__categoria_di_rischio_msr = trim( rec.__categoria_di_rischio_msr) ;
		rec.__vincolo_sanitario  = trim(rec.__vincolo_sanitario) ;
		rec.__qualifica_sanitaria_tbc  = trim(rec.__qualifica_sanitaria_tbc) ;
		rec.__qualifica_sanitaria_brc = trim( rec.__qualifica_sanitaria_brc );
		rec.__mod_4 = trim( rec.__mod_4 );
		rec.__data_mod_4 = trim( rec.__data_mod_4 );
		 rec.__macell_differita_piani_risanamento = trim(rec.__macell_differita_piani_risanamento );
		rec.__test_bse = trim( rec.__test_bse );
		rec.__informazioni_test_bse = trim( rec.__informazioni_test_bse );
		rec.__data_prelievo_test_bse = trim( rec.__data_prelievo_test_bse );
		rec.__data_ricezione_esito_test_bse = trim( rec.__data_ricezione_esito_test_bse );
		rec.__esito_test_bse = trim( rec.__esito_test_bse );
		rec.__note_test_bse = trim( rec.__note_test_bse );
		rec.__disponibili_informazioni_catena_alimentare = trim( rec.__disponibili_informazioni_catena_alimentare );
		rec.__data_arrivo_al_macello = trim( rec.__data_arrivo_al_macello );
		rec.__data_dichiararata_dal_gestore = trim( rec.__data_dichiararata_dal_gestore );
		rec.__mezzo_di_trasporto_tipo = trim( rec.__mezzo_di_trasporto_tipo );
		rec.__mezzo_di_trasporto_targa = trim( rec.__mezzo_di_trasporto_targa );
		rec.__trasporto_superiore_a_8_ore = trim( rec.__trasporto_superiore_a_8_ore );
		rec.__veterinari_addetti_cd = trim( rec.__veterinari_addetti_cd );
		 rec.__note_cd = trim(rec.__note_cd );
		 rec.__data_mam = trim(rec.__data_mam );
		rec.__luogo_di_verifica  = trim(rec.__luogo_di_verifica );
		rec.__causa = trim( rec.__causa );
		rec.__impianto_di_termodistruzione = trim( rec.__impianto_di_termodistruzione );
		rec.__destinazione_della_carcassa = trim( rec.__destinazione_della_carcassa );
		rec.__comunicazione_a_mam = trim( rec.__comunicazione_a_mam );
		rec.__note_mam = trim( rec.__note_mam );
		rec.__data_vam = trim( rec.__data_vam );
		rec.__esito = trim( rec.__esito );
		rec.__provvedimento_adottato = trim( rec.__provvedimento_adottato );
		rec.__comunicazione_a_vam = trim( rec.__comunicazione_a_vam );
		rec.__note_vam = trim( rec.__note_vam );
		rec.__tipo_macellazione  = trim(rec.__tipo_macellazione );
		rec.__progressivo_macellazione  = trim(rec.__progressivo_macellazione);
		rec.__esito_vpm  = trim(rec.__esito_vpm );
		rec.__patologie_rilevate  = trim(rec.__patologie_rilevate );
		 rec.__organi = trim(rec.__organi );
		rec.__causa_presunta_o_accertata  = trim(rec.__causa_presunta_o_accertata );
		 rec.__veterinari_addetti_vpm = trim(rec.__veterinari_addetti_vpm );
		rec.__destinatario_carni  = trim(rec.__destinatario_carni );
		rec.__motivo_c_1  = trim(rec.__motivo_c_1 );
		rec.__matrice_c_1  = trim(rec.__matrice_c_1 );
		rec.__tipo_analisi_c_1  = trim(rec.__tipo_analisi_c_1 );
		rec.__molecole_agente_etiologico_c_1  = trim(rec.__molecole_agente_etiologico_c_1 );
		rec.__molecole_agente_etiologico_altro_c_1  = trim(rec.__molecole_agente_etiologico_altro_c_1 );
		rec.__esito_c_1  = trim(rec.__esito_c_1 );
		rec.__data_ricezione_esito_c_1  = trim(rec.__data_ricezione_esito_c_1 );
		 rec.__motivo_c_2 = trim(rec.__motivo_c_2 );
		rec.__matrice_c_2  = trim(rec.__matrice_c_2 );
		rec.__tipo_analisi_c_2  = trim(rec.__tipo_analisi_c_2 );
		 rec.__molecole_agente_etiologico_c_2 = trim(rec.__molecole_agente_etiologico_c_2 );
		rec.__molecole_agente_etiologico_altro_c_2  = trim(rec.__molecole_agente_etiologico_altro_c_2 );
		rec.__esito_c_2  = trim(rec.__esito_c_2 );
		rec.__data_ricezione_esito_c_2  = trim(rec.__data_ricezione_esito_c_2 );
		 rec.__motivo_c_3 = trim(rec.__motivo_c_3 );
		rec.__matrice_c_3  = trim(rec.__matrice_c_3 );
		rec.__tipo_analisi_c_3  = trim(rec.__tipo_analisi_c_3 );
		rec.__molecole_agente_etiologico_c_3  = trim(rec.__molecole_agente_etiologico_c_3 );
		rec.__molecole_agente_etiologico_altro_c_3  = trim(rec.__molecole_agente_etiologico_altro_c_3 );
		rec.__esito_c_3  = trim(rec.__esito_c_3 );
		 rec.__data_ricezione_esito_c_3 = trim(rec.__data_ricezione_esito_c_3 );
		 rec.__motivo_c_4 = trim(rec.__motivo_c_4 );
		rec.__matrice_c_4  = trim(rec.__matrice_c_4 );
		rec.__tipo_analisi_c_4  = trim(rec.__tipo_analisi_c_4 );
		 rec.__molecole_agente_etiologico_c_4 = trim(rec.__molecole_agente_etiologico_c_4 );
		rec.__molecole_agente_etiologico_altro_c_4  = trim(rec.__molecole_agente_etiologico_altro_c_4 );
		rec.__esito_c_4  = trim(rec.__esito_c_4 );
		rec.__data_ricezione_esito_c_4  = trim(rec.__data_ricezione_esito_c_4 );
		rec.__motivo_c_5  = trim(rec.__motivo_c_5 );
		 rec.__matrice_c_5 = trim(rec.__matrice_c_5 );
		 rec.__tipo_analisi_c_5 = trim(rec.__tipo_analisi_c_5 );
		rec.__molecole_agente_etiologico_c_5  = trim(rec.__molecole_agente_etiologico_c_5 );
		 rec.__molecole_agente_etiologico_altro_c_5 = trim(rec.__molecole_agente_etiologico_altro_c_5 );
		 rec.__esito_c_5 = trim(rec.__esito_c_5 );
		 rec.__data_ricezione_esito_c_5 = trim(rec.__data_ricezione_esito_c_5 );
		 rec.__eseguito_t = trim(rec.__eseguito_t );
		 rec.__tipo_analisi_t = trim(rec.__tipo_analisi_t );
		 rec.__metodo_distruttivo_t = trim(rec.__metodo_distruttivo_t);
		 rec.__id_macello = trim(rec.__id_macello);
		 rec.__destinatario_1_id = trim(rec.__destinatario_1_id);
		 rec.__data_sessione = trim(rec.__data_sessione);
		 rec.__cd_seduta_macellazione = trim(rec.__cd_seduta_macellazione);
		 rec.__data_import = trim(rec.__data_import);
  
  
  
  
  
  
  
  
  
  
  

	nome='';
	cognome ='';
  	vet1='';
    vet2='';
   	vet3='';
   	pat1='';
    pat2='';
    pat3='';
   	org1='';
    org2='';
    org3='';
  
    select distinct ragione_sociale,asl_rif into _destinatario_1_nome,id_asl from ricerche_anagrafiche_old_materializzata where riferimento_id = rec.__id_macello::integer; 
	
    select count(*) into matr from m_capi mc where cd_matricola = rec.__matricola and trashed_date is null;
   
    if matr > 0 then
    return 'KO: matri_dupl';
   end if;
   
	SELECT split_part(rec.__veterinari_addetti_cd, '/',1) into vet1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__veterinari_addetti_cd, '/',2) into vet2
	FROM  import_capi_macello;  
	raise info 'vet:%', vet1;

	SELECT split_part(rec.__veterinari_addetti_cd, '/',3) into vet3
	FROM  import_capi_macello;  





		SELECT split_part(rec.__veterinari_addetti_vpm, '/',1) into vpm_vet1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__veterinari_addetti_vpm, '/',2) into vpm_vet2
	FROM  import_capi_macello;  

	SELECT split_part(rec.__veterinari_addetti_vpm, '/',3) into vpm_vet3
	FROM  import_capi_macello;  

	


		SELECT split_part(rec.__data_sessione, '/',1) into data1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__data_sessione, '/',2) into data2
	FROM  import_capi_macello;  

	SELECT split_part(rec.__data_sessione, '/',3) into data3
	FROM  import_capi_macello;  

	data_sessione = concat(data3,'/',data2,'/',data1);



SELECT split_part(rec.__patologie_rilevate, '/',1) into pat1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__patologie_rilevate, '/',2) into pat2
	FROM  import_capi_macello;  

	SELECT split_part(rec.__patologie_rilevate, '/',3) into pat3
	FROM  import_capi_macello;  

	SELECT split_part(rec.__organi, '/',1) into org1
	FROM  import_capi_macello;  

	SELECT split_part(rec.__organi, '/',2) into org2
	FROM  import_capi_macello;  

	SELECT split_part(rec.__organi, '/',3) into org3
	FROM  import_capi_macello;  


   
  if trim(rec.__progressivo_macellazione) <> '' and trim(rec.__data_mam) = '' then 
   begin
  perform rec.__progressivo_macellazione::integer;
exception when others then
  return 'NO: progressivo macellazione';
end;
end if;
  	

	
  
  
  
        raise info ' progressivo22 %',rec.__progressivo_macellazione;


  select count(*) into progress from m_capi mc where vpm_data = rec.__data_sessione::timestamp without time zone and cd_seduta_macellazione = rec.__cd_seduta_macellazione::integer and progressivo_macellazione = trim(rec.__progressivo_macellazione)::integer and trashed_date is null and destinatario_1_id = rec.__destinatario_1_id::integer;
      raise info ' progressivo%',progress;

  sql1 = concat('select count(*) from m_capi mc where vpm_data = ',rec.__data_sessione::timestamp without time zone,' and cd_seduta_macellazione = ',rec.__cd_seduta_macellazione::integer,' and progressivo_macellazione = ',rec.__progressivo_macellazione::integer); 
       raise info ' progressivo % ',sql1;

  if progress > 1 then 
  
  
  raise info ' progressivo % ',sql1;
  return 'KO: progress';
  end if;
  
 
 
 
 
  
  if trim(rec.__progressivo_macellazione) = '' and trim(rec.__data_mam) = '' then
  
  return 'KO: progress';
 end if;
  
  
  
  
  
  
  if trim(rec.__data_mam) <> '' then 
		if trim(rec.__luogo_di_verifica) = '-1' or trim(rec.__causa) = '' then 
		return 'KO: mam_obb';
	end if;
end if;

if trim(rec.__luogo_di_verifica) <> '-1' then 
		if trim(rec.__data_mam) = '' or trim(rec.__causa) = '' then 
		return 'KO: mam_obb';
	end if;
end if;

if trim(rec.__causa)<> '' then 
		if trim(rec.__data_mam) = '' or trim(rec.__luogo_di_verifica) = '-1' then 
		return 'KO: mam_obb';
	end if;
end if;


	if trim(rec.__data_mam) <> '' and rec.__esito_vpm::integer > 0  then 
	
	return 'KO: mam_vpm';
	 end if;
  
   if trim(upper(rec.__sesso)) = 'TRUE' then
   rec.__sesso = rec.__sesso::boolean;
   else
   if trim(upper(rec.__sesso)) = 'FALSE' then
   rec.__sesso = rec.__sesso::boolean;
   else
   return 'KO: Sesso';
  end if;
 end if;
   
	 if rec.__specie != '1' and rec.__specie != '5' and rec.__specie != '4' and rec.__specie != '24' and rec.__specie != '26' then 
	 return 'KO: specie_null';
	end if;
  
  if rec.__specie != '1' and rec.__specie != '5' then 
  		rec.__categoria = null;
  		rec.__test_bse = null;
  	RAISE NOTICE 'specie';
  	end if;

  if rec.__specie != '1'  then 
  		rec.__razza = null;
  	  	RAISE NOTICE 'specie 2';

  	end if;
  
  if (trim(rec.__esito_test_bse)::integer in(-1, 1, 2)) then
else
  return ('NO: esito test bse');

end if;
  
  
  if rec.__esito_vpm != '2' and rec.__esito_vpm != '4' then 
    rec.__patologie_rilevate = null;
   	RAISE NOTICE 'esito1';

   end if;
  
  if rec.__esito_vpm != '3' then 
    rec.__organi = null;
   	RAISE NOTICE 'esito2';
   end if;
  
  
  
  
  if trim(rec.__data_prelievo_test_bse) <> '' then
 begin
  perform rec.__data_prelievo_test_bse::timestamp without time zone;
exception when others then
  return 'NO: data prelievo test bse';
end;
end if;

  
 if trim(rec.__data_ricezione_esito_test_bse) <> '' then
   begin
  perform rec.__data_ricezione_esito_test_bse::timestamp without time zone;
exception when others then
  return 'NO: data ricezione esito test bse';
end;
end if;  
  
  
  
  if trim(rec.__tipo_macellazione) <> '' then 
   begin
  perform rec.__tipo_macellazione::integer;
exception when others then
  return 'NO: tipo macellazione';
end;
end if;


  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  if rec.__molecole_agente_etiologico_c_1 != '262' and rec.__tipo_analisi_c_1 != '5' then 
  rec.__molecole_agente_etiologico_c_1 = null;
  RAISE NOTICE 'c1';

   end if;
  
  if rec.__molecole_agente_etiologico_c_2 != '262' and rec.__tipo_analisi_c_2 != '5' then 
  
  rec.__molecole_agente_etiologico_c_2 = null;
  RAISE NOTICE 'c2';

   end if;
  
  
  if rec.__molecole_agente_etiologico_c_3 != '262'
and rec.__tipo_analisi_c_3 != '5' then 
  
  rec.__molecole_agente_etiologico_c_3 = null;

raise notice 'c3';
end if;

if rec.__molecole_agente_etiologico_c_4 != '262'
and rec.__tipo_analisi_c_4 != '5' then 
  
  rec.__molecole_agente_etiologico_c_4 = null;

raise notice 'c4';
end if;

if rec.__molecole_agente_etiologico_c_5 != '262'
and rec.__tipo_analisi_c_5 != '5' then 
  
  rec.__molecole_agente_etiologico_c_5 = null;

raise notice 'c5';
end if;

		
if rec.__data_mod_4::timestamp > data_sessione::timestamp then
		raise info 'data mod %',rec.__data_mod_4::timestamp;

return 'KO: datamod';
end if;
--data nascita
  if rec.__data_mod_4::timestamp < rec.__data_di_nascita::timestamp  then
  		return 'KO: data nascita';
	end if;
  
--

  if rec.__data_arrivo_al_macello::timestamp > data_sessione::timestamp or rec.__data_arrivo_al_macello::timestamp < rec.__data_mod_4::timestamp then
  		RAISE NOTICE 'data mod2';

  return 'KO: dataMac';
  end if;
  
  
  
  
   select code into check_ from m_lookup_specie mls where code = rec.__specie::integer and enabled is true;
  	if check_ is null then
  	  return 'NO: specie';	
     end if;
    
  
  	if rec.__specie::integer = 1 then
     if trim(upper(rec.__categoria)) in ('MAN','TOR','VRI','VPR','VIT','VTN') then
     else
  	 	 return 'NO: categoria';	
   	  	 end if;
   	  end if;
     if rec.__specie::integer = 5 then
    if trim(upper(rec.__categoria)) in ('BRI','BPR','TBF','VBF','ATA','ATO') then 
     else
  	 	 return 'NO: categoria';	
   	  	 end if;
   	  	end if;
    raise info 'info3: %',rec.__categoria;

    if rec.__razza <> '-1' then
	if rec.__specie ='1' then
	select code into check_ from m_lookup_razze where code = rec.__razza::integer and enabled is true;
if check_ is null then
  	 	 return 'NO: razza';	
   	  	 end if;
end if;
end if;

  if upper(rec.__sesso) = 'TRUE' or upper(rec.__sesso) = 'FALSE' then 
  	else 
  	 return 'NO: sesso';	
  	end if;
  
  if trim(rec.__categoria_di_rischio_msr)::integer = '-1'::integer or trim(rec.__categoria_di_rischio_msr) = '' then
  rec.__categoria_di_rischio_msr = '0';
 end if;
 if rec.__categoria_di_rischio_msr in ('0','6','7','8')
  then
  else
  return ('NO: categoria di rischio');
  end if;
 
  if rec.__qualifica_sanitaria_tbc in ('-1','1','2','3') then
 else
 return ('NO: qualifica sanitaria tbc');
  end if;
 
   if rec.__qualifica_sanitaria_brc in ('-1','1','2') then
   else
   return ('NO: qualifica sanitaria brc');
   end if;
 
 
  if rec.__macell_differita_piani_risanamento in ('-1','1','2','3') then
  else
  return ('NO: macell differita');
  
  end if;
 
 
 if (upper(rec.__test_bse) <> 'S' and upper(rec.__test_bse) <> 'N') and rec.__test_bse <> '' then 
 return 'NO: test bse';
end if;

if (upper(rec.__disponibili_informazioni_catena_alimentare) <> 'S' and upper(rec.__disponibili_informazioni_catena_alimentare) <> 'N') and rec.__disponibili_informazioni_catena_alimentare <> '' then 
 return 'NO: disponibili informazioni catena alimentare';
end if;

if (upper(rec.__data_dichiararata_dal_gestore) <> 'S' and upper(rec.__data_dichiararata_dal_gestore) <> 'N') and rec.__data_dichiararata_dal_gestore <> '' then 
 return 'NO: data dichiararata dal gestore';
end if;

 if (upper(rec.__trasporto_superiore_a_8_ore) <> 'S' and upper(rec.__trasporto_superiore_a_8_ore) <> 'N') and rec.__trasporto_superiore_a_8_ore <> '' then 
 return 'NO: trasporto superiore a 8 ore';
end if;

 
  if rec.__informazioni_test_bse::integer in (-1,1,2,3,4,5,6,7)
  then
  else
  return ('NO: Informazioni test bse');
  end if;


 
if rec.__comunicazione_a_mam <> '' then 
   begin
  perform rec.__comunicazione_a_mam::integer;
exception when others then
  return 'NO: comunicazione a mam';
end;
end if;



if rec.__luogo_di_verifica > '3' or rec.__luogo_di_verifica::integer < '-1'::integer or rec.__luogo_di_verifica = '0'
 then 
 return 'NO: luogo di verifica';
 end if;
if rec.__comunicazione_a_mam::integer > '8'::integer or rec.__comunicazione_a_mam::integer < '-1'::integer or rec.__comunicazione_a_mam::integer = '0'::integer
 then 
  return ('NO: comunicazione a mam');

 end if;







  if rec.__esito <> '' then 
   begin
  perform rec.__tipo_macellazione::integer;
exception when others then
  return 'NO: esito vam';
end;
end if;


 
if rec.__esito::integer > '3'::integer or rec.__esito::integer < '-1'::integer or rec.__esito = '0'
 then 
  return ('NO: esito vam');

 end if;
 
if rec.__data_vam <> '' then
if rec.__provvedimento_adottato::integer = -1 or rec.__esito = '-1' then
return ('KO: datavam_provv');
end if;
end if;

 
if rec.__provvedimento_adottato::integer <> -1 then
if trim( rec.__data_vam) = '' or rec.__esito = '-1' then
return ('KO: datavam_provv');
end if;
end if;

if rec.__esito::integer <> -1 then
if trim( rec.__data_vam) = '' or rec.__provvedimento_adottato::integer = -1 then
return ('KO: datavam_provv');
end if;
end if;


if rec.__provvedimento_adottato > '5' or rec.__provvedimento_adottato::integer < '-1'::integer or rec.__provvedimento_adottato = '0'
 then 
   return ('NO: provvedimento adottato');

 end if;
 

if rec.__comunicazione_a_vam <> '' then 
   begin
  perform rec.__comunicazione_a_vam::integer;
exception when others then
  return 'NO: comunicazione a vam';
end;
end if;

if rec.__comunicazione_a_vam > '8' or rec.__comunicazione_a_vam::integer < '-1'::integer or rec.__comunicazione_a_vam = '0'
 then 
   return ('NO: comunicazione a vam');

 end if;
	
if rec.__tipo_macellazione > '5' or rec.__tipo_macellazione::integer < '-1'::integer or rec.__tipo_macellazione = '0'
 then 
   return ('NO: tipo macellazione');

 end if;

if rec.__esito_vpm > '7' or rec.__esito_vpm::integer < '-1'::integer or rec.__esito_vpm::integer = '0'::integer
 then 
   return ('NO: esito vpm');

 end if;




    pat1 = split_part(rec.__patologie_rilevate, '/',1);
	pat2 = split_part(rec.__patologie_rilevate, '/',2);
	pat3 = split_part(rec.__patologie_rilevate, '/',3);

	pat1= trim(pat1);
	pat2= trim(pat2);
	pat3= trim(pat3);

if trim(pat1) <> '' or trim(pat2) <> '' or trim(pat3) <> '' then
		
if trim(pat1) <> '' then 
   begin
  perform pat1::integer;
exception when others then
  return 'NO: patologia 1';
end;
end if;


if pat2 <> '' then 
   begin
  perform pat2::integer;
exception when others then
  return 'NO: patologia 2';
end;
end if; 

if pat3 <> '' then 
   begin
  perform pat3::integer;
exception when others then
  return 'NO: patologia 3';
end;
end if;



if pat1= '' then
else
if pat1::integer > '53'::integer or pat1::integer < '-1'::integer or pat1::integer = '0'::integer or pat1::integer = '19'::integer or pat1::integer = '20'::integer
 then 
     return ('NO: patologia 1');

end if;
end if;

if pat2= '' then
else
if pat2::integer > '53'::integer or pat2::integer < '-1'::integer or pat2::integer = '0'::integer or pat2::integer = '19'::integer or pat2::integer = '20'::integer
 then 
      return ('NO: patologia 2');

end if;
end if;

if pat3= '' then
else
if pat3::integer > '53'::integer or pat3::integer < '-1'::integer or pat3::integer = '0'::integer or pat3::integer = '19'::integer or pat3::integer = '20'::integer
 then 
      return ('NO: patologia 3');

end if;
end if;
 end if;
		



    org1 = split_part(rec.__organi, '/',1);
	org2 = split_part(rec.__organi, '/',2);
	org3 = split_part(rec.__organi, '/',3);

 	org1= trim(org1);
	org2= trim(org2);
	org3= trim(org3);

if org1 <> '' or org2 <> '' or org3 <> '' then


 if org1 <> '' then 
   begin
  perform org1::integer;
exception when others then
  return 'NO: organo 1';
end;
end if;

if org2 <> '' then 
   begin
  perform org2::integer;
exception when others then
  return 'NO: organo 2';
end;
end if;

if org3 <> '' then 
   begin
  perform org3::integer;
exception when others then
  return 'NO: organo 3';
end;
end if;


if org1= '' then
else
if org1 in(-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27)
 then 
      return ('NO: organo 1');
  end if;
 end if;

 if org2= '' then
 else
if org2 in(-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27)
 then 
      return ('NO: organo 2');
  end if;
  end if;
 
 if org3= '' then
 else
if org3 in(-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27)
 then 
      return ('NO: organo 3');
end if;
 end if;
	 

 end if;
		
if rec.__esito_c_1::integer  > '3'::integer  or rec.__esito_c_1::integer < '-1'::integer or rec.__esito_c_1::integer  = '0'::integer 
 then 
      return ('NO: esito campione 1');

 end if;

if rec.__motivo_c_1::integer > '10'::integer or rec.__motivo_c_1::integer < '-1'::integer or rec.__motivo_c_1::integer = '0'::integer
 then 
      return ('NO: motivo campione 1');

 end if;

if rec.__matrice_c_1::integer  > '36'::integer  or rec.__matrice_c_1::integer < '-1'::integer or rec.__matrice_c_1::integer  = '0'::integer 
 then 
      return ('NO: matrice campione 1');

 end if;
		
if rec.__tipo_analisi_c_1::integer  > '6'::integer  or rec.__tipo_analisi_c_1::integer < '-1'::integer or rec.__tipo_analisi_c_1::integer  = '0'::integer 
 then 
      return ('NO: tipo_analisi campione 1');

 end if;
		


if rec.__molecole_agente_etiologico_c_1::integer  = '259'::integer  or rec.__molecole_agente_etiologico_c_1::integer  = '261'::integer  or (rec.__molecole_agente_etiologico_c_1::integer  > '266'::integer  and rec.__molecole_agente_etiologico_c_1::integer  < '290'::integer ) or rec.__molecole_agente_etiologico_c_1::integer  > '290'::integer  or rec.__molecole_agente_etiologico_c_1::integer < '-1'::integer or rec.__molecole_agente_etiologico_c_1::integer  = '0'::integer 
 then 
      return ('NO: __molecole_agente_etiologico campione 1');

 end if;	











-- 		  __molecole_agente_etiologico_c_1 ,

	if rec.__esito_c_2::integer  > '3'::integer  or rec.__esito_c_2::integer < '-1'::integer or rec.__esito_c_2::integer  = '0'::integer 
 then 
      return ('NO: esito campione 2');

 end if;	

if rec.__motivo_c_2::integer  > '10'::integer  or rec.__motivo_c_2::integer < '-1'::integer or rec.__motivo_c_2::integer  = '0'::integer 
 then 
      return ('NO: motivo campione 2');

 end if;

if rec.__matrice_c_2::integer  > '36'::integer  or rec.__matrice_c_2::integer < '-1'::integer or rec.__matrice_c_2::integer  = '0'::integer 
 then 
      return ('NO: matrice campione 2');

 end if;
		
if rec.__tipo_analisi_c_2::integer  > '6'::integer  or rec.__tipo_analisi_c_2::integer < '-1'::integer or rec.__tipo_analisi_c_2::integer  = '0'::integer 
 then  
      return ('NO: tipo_analisi campione 2');

 end if;


if rec.__molecole_agente_etiologico_c_2::integer  = '259'::integer  or rec.__molecole_agente_etiologico_c_2::integer  = '261'::integer  or (rec.__molecole_agente_etiologico_c_2::integer  > '266'::integer  and rec.__molecole_agente_etiologico_c_2::integer  < '290'::integer ) or rec.__molecole_agente_etiologico_c_2::integer  > '290'::integer  or rec.__molecole_agente_etiologico_c_2::integer < '-1'::integer or rec.__molecole_agente_etiologico_c_2::integer  = '0'::integer 
 then 
      return ('NO: __molecole_agente_etiologico campione 2');

 end if;	
		
-- 		  __molecole_agente_etiologico_c_1 ,

	

if rec.__motivo_c_3::integer  > '10'::integer  or rec.__motivo_c_3::integer < '-1'::integer or rec.__motivo_c_3::integer  = '0'::integer 
 then 
      return ('NO: motivo campione 3');

 end if;

if rec.__matrice_c_3::integer  > '36'::integer  or rec.__matrice_c_3::integer < '-1'::integer or rec.__matrice_c_3::integer  = '0'::integer 
 then 
      return ('NO: matrice campione 3');

 
 end if;
		
if rec.__tipo_analisi_c_3::integer  > '6'::integer  or rec.__tipo_analisi_c_3::integer < '-1'::integer or rec.__tipo_analisi_c_3::integer  = '0'::integer 
 then 
       return ('NO: tipo_analisi campione 3');

 end if;
		


if rec.__molecole_agente_etiologico_c_3::integer  = '259'::integer  or rec.__molecole_agente_etiologico_c_3::integer  = '261'::integer  or (rec.__molecole_agente_etiologico_c_3::integer  > '266'::integer  and rec.__molecole_agente_etiologico_c_3::integer  < '290'::integer ) or rec.__molecole_agente_etiologico_c_3::integer  > '290'::integer  or rec.__molecole_agente_etiologico_c_3::integer < '-1'::integer or rec.__molecole_agente_etiologico_c_3::integer  = '0'::integer 
 then 
      return ('NO: __molecole_agente_etiologico campione 3');

 end if;	
-- 		  __molecole_agente_etiologico_c_1 ,

	if rec.__esito_c_3::integer  > '3'::integer  or rec.__esito_c_3::integer < '-1'::integer or rec.__esito_c_3::integer  = '0'::integer 
 then 
       return ('NO: esito campione 3');

 end if;	
		  
if rec.__motivo_c_4::integer  > '10'::integer  or rec.__motivo_c_4::integer < '-1'::integer or rec.__motivo_c_4::integer  = '0'::integer 
 then 
       return ('NO: motivo campione 4');

 end if;

if rec.__matrice_c_4::integer  > '36'::integer  or rec.__matrice_c_4::integer < '-1'::integer or rec.__matrice_c_4::integer  = '0'::integer 
 then 
       return ('NO: matrice campione 4');

 end if;
		
if rec.__tipo_analisi_c_4::integer  > '6'::integer  or rec.__tipo_analisi_c_4::integer < '-1'::integer or rec.__tipo_analisi_c_4::integer  = '0'::integer 
 then 
       return ('NO: tipo_analisi campione 4');

 end if;
		


if rec.__molecole_agente_etiologico_c_4::integer  = '259'::integer  or rec.__molecole_agente_etiologico_c_4::integer  = '261'::integer  or (rec.__molecole_agente_etiologico_c_4::integer  > '266'::integer  and rec.__molecole_agente_etiologico_c_4::integer  < '290'::integer ) or rec.__molecole_agente_etiologico_c_4::integer  > '290'::integer  or rec.__molecole_agente_etiologico_c_4::integer < '-1'::integer or rec.__molecole_agente_etiologico_c_4::integer  = '0'::integer 
 then 
      return ('NO: __molecole_agente_etiologico campione 4');

 end if;	
-- 		  __molecole_agente_etiologico_c_1 ,

	if rec.__esito_c_4::integer  > '3'::integer  or rec.__esito_c_4::integer < '-1'::integer or rec.__esito_c_4::integer  = '0'::integer 
 then 
       return ('NO: esito campione 4');

 end if;			

		if rec.__motivo_c_5::integer  > '10'::integer  or rec.__motivo_c_5::integer < '-1'::integer or rec.__motivo_c_5::integer  = '0'::integer 
 then 
       return ('NO: motivo campione 5');

 end if;

if rec.__matrice_c_5::integer  > '36'::integer  or rec.__matrice_c_5::integer < '-1'::integer or rec.__matrice_c_5::integer  = '0'::integer 
 then 
       return ('NO: matrice campione 5');

 end if;
		
if rec.__tipo_analisi_c_5::integer  > '6'::integer  or rec.__tipo_analisi_c_5::integer < '-1'::integer or rec.__tipo_analisi_c_5::integer  = '0'::integer 
 then 
       return ('NO: tipo_analisi campione 5');

 end if;


if rec.__molecole_agente_etiologico_c_5::integer  = '259'::integer  or rec.__molecole_agente_etiologico_c_5::integer  = '261'::integer  or (rec.__molecole_agente_etiologico_c_5::integer  > '266'::integer  and rec.__molecole_agente_etiologico_c_5::integer < '290'::integer ) or rec.__molecole_agente_etiologico_c_5::integer  > '290'::integer  or rec.__molecole_agente_etiologico_c_5::integer < '-1'::integer or rec.__molecole_agente_etiologico_c_5::integer  = '0'::integer 
 then 
      return ('NO: __molecole_agente_etiologico campione 5');

 end if;	
		
-- 		  __molecole_agente_etiologico_c_1 ,

	if rec.__esito_c_5::integer  > '3'::integer  or rec.__esito_c_5::integer < '-1'::integer or rec.__esito_c_5::integer  = '0'::integer 
 then 
       return ('NO: esito campione 5');

 end if;	 

		 
 if (upper(trim(rec.__eseguito_t)) <> 'S' and upper(trim(rec.__eseguito_t)) <> 'N') and trim(rec.__eseguito_t) <> '' then 
 return 'NO: tampone eseguito';
end if;

if rec.__tipo_analisi_t::integer  > '3'::integer  or rec.__tipo_analisi_t::integer < '-1'::integer or rec.__tipo_analisi_t::integer  = '0'::integer 
 then 
       return ('NO: tipo analisi tampone');

 end if;


if (upper(trim(rec.__metodo_distruttivo_t)) <> 'S' and upper(trim(rec.__metodo_distruttivo_t)) <> 'N') and trim(rec.__metodo_distruttivo_t) <> '' then 
 return 'NO: metodo distruttivo tampone';
end if;



	--	  __eseguito_t ,
		--  __tipo_analisi_t ,
		--  __metodo_distruttivo_t,
--







  
	end loop;
 return 'OK';
END
$function$
;













select * from dbi_insert_utente('g.marano', md5('g.marano'), 1, 6567, 6567, true, -1, 'giuseppe', 'marano', 'MRNGPP00R09F839B', '', '', 'g.marano', 'g.marano@usmail.it', null, -1, 'true', 'true', 'true', '') 

insert into permission (category_id,permission,permission_view,permission_add,permission_edit,permission_delete,description , level,enabled,active)
values (65,'importmassivomacelli',true,true,true,true,'NUOVA GESTIONE IMPORT MACELLI MASSIVO',10,true,true);
INSERT INTO ROLE_PERMISSION(role_id, permission_id, role_view, role_add, role_edit) values (1, 851,true, true, false);
INSERT INTO ROLE_PERMISSION(role_id, permission_id, role_view, role_add, role_edit) values (32, 851,true, true, false);

INSERT INTO public.access_
(user_id, username, "password", contact_id, role_id, manager_id, startofday, endofday, locale, timezone, last_ip, last_login, enteredby, entered, modifiedby, modified, expires, alias, assistant, enabled, currency, "language", webdav_password, hidden, site_id, allow_webdav_access, allow_httpapi_access, role_id_old, roleid_old, last_interaction_time, "action", command, object_id, table_name, asl_old, access_position_lat, access_position_lon, access_position_err, trashed_date, in_dpat, in_nucleo_ispettivo, in_access, codice_suap, data_scadenza, note_hd, cessato, pec_suap, callback_suap, id_struttura_asl_complessa, callback_suap_ko)
VALUES(42382, 'g.marano1', '6a36c9befab24531cc0c8af532f4db9a', 39628, 1, -1, 8, 18, NULL, 'Europe/Berlin', '127.0.0.1', '2023-01-18 16:44:23.714', 964, '2023-01-18 16:09:29.252', 964, '2023-01-18 16:39:13.546', NULL, -1, -1, true, 'EUR', 'it_IT', NULL, false, NULL, true, true, NULL, NULL, '2023-01-18 17:17:23.573', 'MacellazioniImportSintesis', 'ImportDaFile2', -1, NULL, NULL, 0.0, 0.0, '', NULL, NULL, NULL, true, NULL, NULL, NULL, false, NULL, NULL, NULL, NULL);
