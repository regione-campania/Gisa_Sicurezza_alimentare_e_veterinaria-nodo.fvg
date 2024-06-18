ALTER TABLE public.evento_registrazione_bdu ADD microchip_madre text NULL;
ALTER TABLE public.evento_registrazione_bdu ADD id_animale_madre int4 NULL;
ALTER TABLE public.evento_registrazione_bdu ADD microchip_madre text NULL;
ALTER TABLE public.evento_registrazione_bdu ADD codice_fiscale_proprietario_provenienza text NULL;
ALTER TABLE public.evento_registrazione_bdu ADD ragione_sociale_provenienza text NULL;


drop function  public.sinaaf_iscrizione_animale_get_dati_envelope( integer);
CREATE OR REPLACE FUNCTION public.sinaaf_iscrizione_animale_get_dati_envelope(_idevento integer)
 RETURNS TABLE(anmid text, anmnome text, anmtatuaggio text, anmmicrochip text, motivoingresso text, tzacodice text, anmdtnascita text, flagdtpresuntanascita text, flagnascitacanile text, anmsesso text, 
 specodice text, razzacodice text, razzavarieta text, flagincrocio text, colcodice text, pelcodice text, tagcodice text, prpjson text, vetidfiscale text, nominativovetnonpresente text, 
 anmdtapplicazionechip text, anmflagapplchip text, anmdtiscrizione text, dtevento text, dtultimamodifica text, anmnumpassaporto text, anmdtrilasciopassaporto text, vetidfiscalepass text, 
 aslcodicepass text, anmcodicestatorilasciopass text, madreanmmicrochip text)
 LANGUAGE plpgsql
AS $function$

 BEGIN
    
   RETURN QUERY     
select distinct
ev.id_sinaaf as anmId,
case when an.nome  = '' then '-' else regexp_replace(coalesce(an.nome, '-') ,'"',' ','g')  end as anmNome, 
case
	when an.tatuaggio is not null and an.tatuaggio <> '' and length(an.tatuaggio) <> 15 then coalesce(tatuaggio, '')::text
	else ''
end as anmTatuaggio,
case
	when an.tatuaggio is not null and an.tatuaggio <> '' and length(an.tatuaggio) = 15 then coalesce(tatuaggio, '')::text
	else coalesce(an.microchip, '')::text
end as anmMicrochip,
case
    when flag_anagrafe_fr then 'ACQ' 
    when flag_anagrafe_fr is false or flag_anagrafe_fr is null then 'ISC'
    else '' end as motivoIngresso,
'Z99' as tzaCodice,
coalesce(to_char(an.data_nascita, 'dd-mm-yyyy'), '') as anmDtNascita,
case
   when flag_data_nascita_presunta then 'S'
   when flag_data_nascita_presunta is false then 'N' 
   else '' end as flagDtPresuntaNascita,
'' as flagNascitaCanile,
upper(coalesce(an.sesso,''))::text  as anmSesso ,
case 
  when an.id_specie = 1 then 'C'
  when an.id_specie = 2 then 'G' 
  when an.id_specie = 3 then 'F'
  else '' end as speCodice,
CASE
	WHEN dec_razza.codice_sinaf IS NOT NULL AND dec_razza.codice_sinaf::text <> ''::text THEN dec_razza.codice_sinaf::text
        WHEN an.id_specie = 1 THEN '999'::text
        WHEN an.id_specie = 2 THEN 'G02'::text
        WHEN an.id_specie = 3 THEN 'F04'::text
 ELSE NULL::text
END AS razzacodice,         
dec_razza.varieta_sinaf::text AS razzavarieta,
case 
  when (raz.description ilike '%METICCIO%' and an.id_specie = 1 and an.flag_incrocio = null) then 'S'
  when ( an.id_specie = 1 and an.flag_incrocio = null) then 'N'
  else '' end  as flagIncrocio,
coalesce(dec_mantello.codice_sinaf,'')::text as colCodice,
'P99' as pelCodice, --rif.: mail di brunetti del 22/02: nel manuale non era ancora aggiornato alla data della mail
case 
  when tag.code = 1 then '01'  
  when tag.code = 2 then '02' 
  when tag.code = 3 then '03' 
  when tag.code = 5 then '04' 
  else '99' end as tagCodice, --rif.: mail di brunetti del 22/02: nel manuale non era ancora aggiornato alla data della mail
 (select * from sinaaf_proprietario_get_envelope( ev.id_evento)) as prpJson,
 case
  when flag_anagrafe_fr then  ''
  when char_length(NULLIF(contact_utente_ins_microchip.codice_fiscale, ''))=16 and NULLIF(contact_utente_ins_microchip.codice_fiscale, '') not in  ('CF', 'n.d', '1111111111111111','1231231234324325','234234234234234e','test111111111111','nnnnnnnndddddddd','nddddddddddddddd','N.D.DDDDDDDDDDDD' )   then upper(NULLIF(contact_utente_ins_microchip.codice_fiscale, '99999999909'))
  when char_length(NULLIF(contact_ins_reg.codice_fiscale, ''))=16 and NULLIF(contact_ins_reg.codice_fiscale, '') not in  ('CF', 'n.d', '1111111111111111','1231231234324325','234234234234234e','test111111111111','nnnnnnnndddddddd','nddddddddddddddd','N.D.DDDDDDDDDDDD' )   then upper(NULLIF(contact_ins_reg.codice_fiscale, '99999999909'))
  else '99999999909' end as vetIdFiscale,
case
  when flag_anagrafe_fr then 'ANIMALE MICROCHIPPATO DA ALTRA REGIONE' 
  else ''
end as nominativoVetNonPresente,
  coalesce(to_char(ev_ins_microchip.data_inserimento_microchip , 'dd-mm-yyyy'),   to_char(ev_bdu.data_registrazione , 'dd-mm-yyyy'),          '')::text as anmDtApplicazioneChip,
  'S' as anmFlagApplChip,
  coalesce(to_char(ev_bdu.data_registrazione, 'dd-mm-yyyy'), '')::text as anmDtIscrizione,
      case when e_cattura.id_evento is not null then coalesce(to_char(e_cattura.data_cattura, 'dd-mm-yyyy'), '')::text 
       else coalesce(to_char(ev_bdu.data_registrazione, 'dd-mm-yyyy'), '')::text 
  end  as dtEvento,
    coalesce(to_char(ev.modified, 'dd-mm-yyyy'), '')::text as dtUltimaModifica,
p.nr_passaporto::text as anmNumPassaporto,
to_char(erp_p.data_rilascio_passaporto, 'dd-mm-yyyy') as anmDtRilascioPassaporto,
 case when c2.codice_fiscale is not null then upper(c2.codice_fiscale) 
      else 
	case when (ag.cf is not null or c.codice_fiscale is null or c.codice_fiscale = '') and p.nr_passaporto is not null and p.nr_passaporto <> ''  then '99999999909' 
	     else upper(c.codice_fiscale) 
        end 
end as vetIdFiscalePass,
case when p.nr_passaporto is not null and p.nr_passaporto <> '' then 
concat('R',p.id_asl_appartenenza) else '' end as aslCodicePass,
'I' as anmCodiceStatoRilascioPAss,
case when ev_bdu.id_animale_madre is not null and ev_bdu.id_animale_madre::text <> '-1' then
(select case when tatuaggio <> '' then tatuaggio::text else microchip::text end from animale where id=ev_bdu.id_animale_madre)
else case when ev_bdu.microchip_madre <> '' and ev_bdu.microchip_madre is not null then 
ev_bdu.microchip_madre
end
end
as
madreAnmMicrochip
 from animale an
left join evento ev on ev.id_animale = an.id and ev.id_tipologia_evento = 1 and ev.data_cancellazione is null and ev.trashed_date is null
left join evento_registrazione_bdu ev_bdu on ev_bdu.id_evento = ev.id_evento
left join evento ev2 on ev2.id_animale = an.id and ev2.id_tipologia_evento = 3 and ev2.data_cancellazione is null and ev2.trashed_date is null
left join evento_inserimento_microchip ev_ins_microchip on ev_ins_microchip.id_evento = ev2.id_evento
left join access_ utente_ins_microchip on utente_ins_microchip.user_id= ev_ins_microchip.id_veterinario_privato_inserimento_microchip
left join contact_ contact_utente_ins_microchip on contact_utente_ins_microchip.contact_id= utente_ins_microchip.contact_id
left join access_ utente_ins_reg on utente_ins_reg.user_id = ev.id_utente_inserimento  
left join contact_ contact_ins_reg on contact_ins_reg.contact_id= utente_ins_reg.contact_id 
left join lookup_razza raz on raz.code = an.id_razza and raz.enabled and raz.id_specie = an.id_specie
left join sinaff_razza_decode dec_razza on dec_razza.encicode_bdu=raz.enci_code ::text and raz.id_specie =dec_razza.id_specie 
left join lookup_taglia tag on tag.code = an.id_taglia and tag.enabled  
left join lookup_mantello mantello on mantello.code=an.id_tipo_mantello 
left join sinaff_mantello_decode dec_mantello on dec_mantello.id_specie =mantello.id_specie and mantello.code::text=dec_mantello.encicode_bdu 
left join opu_relazione_stabilimento_linee_produttive l_prop on l_prop.id =ev_bdu.id_proprietario 
left join opu_relazione_stabilimento_linee_produttive l_det on l_det.id =ev_bdu.id_detentore_registrazione_bdu 
left join evento ev_cattura on ev_cattura.id_animale = an.id and ev_cattura.id_tipologia_evento = 5 and ev_cattura.data_cancellazione is null and ev_cattura.trashed_date is null and l_prop.id_linea_produttiva in (3,7)
left join evento_cattura e_cattura on e_cattura.id_evento = ev_cattura.id_evento
--left join sinaff_mantello_decode dec_mantello on dec_mantello.id_specie =mantello.id_specie and mantello.description=dec_mantello.description 
--left join sinaff_razza_decode dec_razza on dec_razza.encicode_bdu=raz.enci_code ::text 
left join evento e_p on e_p.id_tipologia_evento in (6,48) and e_p.id_animale = an.id and e_p.trashed_date is null and e_p.data_cancellazione is null
left JOIN evento_rilascio_passaporto erp_p ON erp_p.id_evento = e_p.id_evento and erp_p.flag_passaporto_attuale
   left join passaporto p on upper(p.nr_passaporto) = upper(erp_p.numero_passaporto) and p.data_cancellazione is null
   left join access_ a on a.user_id = p.id_utente_utilizzo
   left join contact_ c on c.contact_id = a.contact_id
   left join access_ a2 on a2.user_id = erp_p.id_veterinario::integer 
   left join contact_ c2 on c2.contact_id = a2.contact_id
   left join sinaaf_veterinari_non_presenti_in_anagrafe ag on ag.cf = c.codice_fiscale
where an.data_cancellazione is null and  an.trashed_date is null and ev.id_evento = _idevento;    
 END;
$function$
;



create or replace
function public.sinaaf_iscrizione_animale_get_envelope(_idevento integer)
 returns text
 language plpgsql
 strict
as $function$
declare
	ret text;

begin

select
	concat('{"anmId": "', anmId,
'","movId": "', movId, 
'","apmId": "', apmId, 
'","traId": "', traId, 
'","ubiId,": "', ubiId, 
'","anmNome": "', anmNome, 
'","anmTatuaggio": "', anmTatuaggio, 
'","anmMicrochip": "', anmMicrochip, 
'","motivoIngresso": "', motivoIngresso, 
'","tzaCodice": "', tzaCodice, 
'","anmDtNascita": "', anmDtNascita, 
'","flagDtPresuntaNascita": "', flagDtPresuntaNascita, 
'","anmSesso": "', anmSesso, 
'","speCodice": "', speCodice, 
'","razzaCodice": "', razzaCodice, 
'","razzaVarieta": "', razzaVarieta, 
'","flagIncrocio": "', flagIncrocio,  
'","colCodice": "', colCodice, 
'","prpJson": "', prpJson,
'","vetIdFiscale": "', vetIdFiscale, 
'","anmDtApplicazioneChip": "', anmDtApplicazioneChip, 
'","anmFlagApplChip": "', anmFlagApplChip, 
'","anmDtIscrizione": "', anmDtIscrizione, 
'","dtEvento": "', dtEvento, 
'","madreAnmMicrochip": "', madreAnmMicrochip,
 '", "dtUltimaModifica": "', dtUltimaModifica, '"}')
into
	ret
from
	sinaaf_iscrizione_animale_get_dati_envelope(_idevento);

return ret;
end;

$function$
;




CREATE OR REPLACE FUNCTION public.sinaaf_iscrizione_animale_get_envelope(_idevento text)
 RETURNS text
 LANGUAGE plpgsql
 STRICT
AS $function$
DECLARE
	ret text;
BEGIN

select 
concat('{"anmId": "', anmId,
'","anmNome": "', anmNome, 
'","anmTatuaggio": "', anmTatuaggio, 
'","anmMicrochip": "', anmMicrochip, 
'","motivoIngresso": "', motivoIngresso, 
'","tzaCodice": "', tzaCodice, 
'","anmDtNascita": "', anmDtNascita, 
'","flagDtPresuntaNascita": "', flagDtPresuntaNascita, 
'","flagNascitaCanile": "', flagNascitaCanile, 
'","anmSesso": "', anmSesso, 
'","speCodice": "', speCodice, 
'","razzaCodice": "', razzaCodice, 
'","razzaVarieta": "', razzaVarieta, 
'","flagIncrocio": "', flagIncrocio,  
'","colCodice": "', colCodice, 
'","pelCodice": "', pelCodice, 
'","tagCodice": "', tagCodice, 
'","prpJson": "', prpJson,
'","vetIdFiscale": "', vetIdFiscale, 
'","nominativoVetNonPresente": "', nominativoVetNonPresente, 
'","anmDtApplicazioneChip": "', anmDtApplicazioneChip, 
'","anmFlagApplChip": "', anmFlagApplChip, 
'","anmDtIscrizione": "', anmDtIscrizione, 
'","anmNumPassaporto": "', anmNumPassaporto,
'","anmDtRilascioPassaporto": "', anmDtRilascioPassaporto,
'","vetIdFiscalePass": "', vetIdFiscalePass,
'","aslCodicePass": "', aslCodicePass,
'","anmCodiceStatoRilascioPAss": "', anmCodiceStatoRilascioPAss,
--'", "dtUltimaModifica": "', dtUltimaModifica,
'","madreAnmMicrochip": "', madreAnmMicrochip,
--'", "dtUltimaModifica": "', dtUltimaModifica, 
'","dtEvento": "', dtEvento, '"}') into ret

from sinaaf_iscrizione_animale_get_dati_envelope(_idevento::integer);

 RETURN ret;
 END;
$function$
;


--CONTIENE MODIFICA ANCHE PER IL REQ.4

drop function public.sinaaf_get_info_ws( text,  text,  text);
CREATE OR REPLACE FUNCTION public.sinaaf_get_info_ws(_identita text, entita text, method text DEFAULT NULL::text)
 RETURNS TABLE(propagazione_sinaaf boolean, nome_ws text, dbi_get_envelope text, id_tabella text, tabella text, dipendenze text, nome_campo_id_sinaaf text, presente_in_gisa text, sincronizzato boolean, id_sinaaf text, nome_campo_codice_sinaaf_get text, nome_campo_codice_sinaaf text, codice_sinaaf text, cancellato boolean, codice_semantico text)
 LANGUAGE plpgsql
AS $function$
DECLARE
propagazione_sinaaf_return boolean;
_id_tipologia_evento integer;
nome_ws_return text;
nome_ws_get_return text; --Modifica per la velocità
dbi_get_envelope_return text;
_id_linea_produttiva integer;
_id_stabilimento_gisa integer;
is_struttura_vet boolean;
is_struttura_detenzione boolean;
id_tabella_return text;
tabella_return text;
dipendenze_return text;
nome_campo_id_sinaaf_return text;
nome_campo_codice_sinaaf_get_return text;
nome_campo_codice_sinaaf_return text;
presente_in_gisa_return text;
_numero_microchip_assegnato text;
_id_proprietario_corrente integer;
_id_detentore_corrente integer;
_mc_esiste_in_sinaaf boolean;
_prop_esiste_in_sinaaf boolean;
_det_esiste_in_sinaaf boolean;
sincronizzato_to_return boolean;
id_sinaaf_to_return text;
id_sinaaf_secondario_to_return text;
codice_sinaaf_to_return text;
_id_proprietario text;
_controllo_detentore_cambiato boolean;
cancellato_return boolean;
codice_semantico_to_return text;
_cambio_proprietario boolean;
id_animale_madre_ text;
id_evento_madre text;
 BEGIN
	propagazione_sinaaf_return:=false;
	sincronizzato_to_return:=false;
	
	if(entita='proprietario') then
		_id_linea_produttiva:=(select id_linea_produttiva from opu_relazione_stabilimento_linee_produttive  where id =  _identita::integer);
		id_tabella_return:='id';
		tabella_return:='opu_relazione_stabilimento_linee_produttive';
		 if(_id_linea_produttiva=1) then
			propagazione_sinaaf_return:=true;
			nome_ws_return:='persona';
			nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
			nome_campo_id_sinaaf_return:='perId';
                        nome_campo_codice_sinaaf_get_return:='idfiscale';
			nome_campo_codice_sinaaf_return:='perIdFiscale';
			dbi_get_envelope_return:='sinaaf_persone_get_envelope';
			codice_semantico_to_return:= (select codice_fiscale from opu_operatori_denormalizzati where id_rel_stab_lp = _identita::integer);
			select * into sincronizzato_to_return, id_sinaaf_to_return,codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
		elsif(_id_linea_produttiva=8) then
			propagazione_sinaaf_return:=true;
			nome_ws_return:='canile';
			nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
			nome_campo_id_sinaaf_return:='canId';
			nome_campo_codice_sinaaf_get_return:='cancodice';
			nome_campo_codice_sinaaf_return:='canCodice';
			dbi_get_envelope_return:='sinaaf_colonie_get_envelope';
			select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
		elsif(false) then
               --elsif(_id_linea_produttiva in (4,5,6)) then
			propagazione_sinaaf_return:=true;
			nome_ws_return:='canile';
			nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
			nome_campo_id_sinaaf_return:='canId';
			nome_campo_codice_sinaaf_get_return:='cancodice';
			nome_campo_codice_sinaaf_return:='canCodice';
			dbi_get_envelope_return:='sinaaf_strutture_detenzione_get_envelope';
			select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
		end if;
	end if;

	if(entita='evento' or entita = 'animale') then
		if(entita='evento') then
			_id_tipologia_evento:= (select id_tipologia_evento from evento where id_evento = _identita::integer);
		end if;
		id_tabella_return:='id_evento';
		tabella_return:='evento';
		if(_id_tipologia_evento = 1 or entita = 'animale') then
				propagazione_sinaaf_return:=true;
				if(entita='evento') then
					select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				end if;
				nome_ws_return:='gestioneanimale';
				if(lower(method) in ('get','delete','put') or (id_sinaaf_to_return is not null and id_sinaaf_to_return <> '')) then 
					nome_ws_return:='animale';
				end if;
				nome_ws_get_return:='animale'; --Modifica per la velocità
				nome_campo_id_sinaaf_return:='anmId';
				nome_campo_codice_sinaaf_get_return:='anmmicrochip';
				nome_campo_codice_sinaaf_return:='anmMicrochip';
				dbi_get_envelope_return:='sinaaf_iscrizione_animale_get_envelope';
				_numero_microchip_assegnato := (select coalesce(ev_ins_mc_3.numero_microchip_assegnato ,ev_ins_mc_2.numero_microchip_assegnato, an.microchip) from evento ev left join evento ev2 on ev2.id_tipologia_evento = 3 and ev2.id_animale = ev.id_animale and ev2.trashed_date is null and ev2.data_cancellazione is null left join evento_inserimento_microchip ev_ins_mc_2 on ev2.id_evento = ev_ins_mc_2.id_evento left join evento ev3 on ev3.id_tipologia_evento = 38 and ev3.id_animale = ev.id_animale and ev3.trashed_date is null  and ev3.data_cancellazione is null left join evento_inserimento_microchip ev_ins_mc_3 on ev3.id_evento = ev_ins_mc_3.id_evento left join animale an on an.id = ev.id_animale where ev.id_evento::text = _identita);
				_numero_microchip_assegnato := regexp_replace(_numero_microchip_assegnato,'''', '''''') ;  				
				_mc_esiste_in_sinaaf :=(select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from microchips as t1, ws_storico_chiamate ws where ws.id_tabella = t1.microchip::text and ws.tabella = 'microchips' and ws.esito= 'OK' and t1.microchip::text = _numero_microchip_assegnato order by ws.id desc limit 1);
				if _mc_esiste_in_sinaaf is null then _mc_esiste_in_sinaaf:=false; end if;	
				if(entita='evento') then			
					_id_proprietario_corrente := (select id_proprietario_corrente from evento where id_evento = _identita::integer );
					_id_detentore_corrente    := (select id_detentore_corrente    from evento where id_evento = _identita::integer );
				end if;
				_id_linea_produttiva:=(select id_linea_produttiva from opu_relazione_stabilimento_linee_produttive  where id =  _id_detentore_corrente);
				--Modifica per la velocità
				--_prop_esiste_in_sinaaf :=(select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id = _id_proprietario_corrente order by ws.id desc limit 1);
				_prop_esiste_in_sinaaf :=(select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id = _id_proprietario_corrente order by ws.id desc limit 1);
				if _prop_esiste_in_sinaaf is null then _prop_esiste_in_sinaaf:=false; end if;
				dipendenze_return := _numero_microchip_assegnato || ';giacenza;' || _mc_esiste_in_sinaaf ;
				
			select id_animale_madre::text into id_animale_madre_  from evento_registrazione_bdu erb where id_evento =_identita::integer;
			
			
				if (id_animale_madre_ is not null) then
				select e.id_evento::text into id_evento_madre from evento e join evento_registrazione_bdu erb on e.id_evento = erb.id_evento where e.id_animale=id_animale_madre_::integer and e.id_tipologia_evento=1;
				dipendenze_return = concat(dipendenze_return,';',id_evento_madre,';evento;','false') ;
				end if;
				
				
				codice_semantico_to_return:=_numero_microchip_assegnato;
				if(entita='animale') then
					codice_semantico_to_return:=_identita::text;
				end if;
				
				if(method is null or lower(method)!='delete') then
					if(dipendenze_return is not null and dipendenze_return<>'') then dipendenze_return:=dipendenze_return ||';'; end if;
					dipendenze_return := dipendenze_return || _id_proprietario_corrente || ';proprietario;' || _prop_esiste_in_sinaaf;
				end if;
				if(_id_proprietario_corrente!=_id_detentore_corrente and _id_linea_produttiva in (1,2,8)) then
					--Modifica per la velocità
					--_det_esiste_in_sinaaf :=(select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id = _id_detentore_corrente order by ws.id desc limit 1);
					_det_esiste_in_sinaaf :=true;
					if _det_esiste_in_sinaaf is null then _det_esiste_in_sinaaf:=false; end if;
					if(dipendenze_return is not null and dipendenze_return<>'') then dipendenze_return:=dipendenze_return ||';'; end if;
					dipendenze_return := dipendenze_return || _id_detentore_corrente || ';proprietario;' || _det_esiste_in_sinaaf;
				end if;
		elsif(_id_tipologia_evento in(42,35,37,17,40,52,47,15,13,19,16,55,59,33,61,67,8,14,39)) then

				_cambio_proprietario:=true;
				if(_id_tipologia_evento=8) then
					select id_proprietario_fuori_regione <> id_vecchio_proprietario_fuori_regione into _cambio_proprietario from evento_trasferimento_fuori_regione  where id_evento::text = _identita;     
				end if;

				if(_cambio_proprietario is null) then
					_cambio_proprietario:=true;
				end if;

				
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
					

				if(_id_tipologia_evento=8 and _cambio_proprietario is false) then
					propagazione_sinaaf_return:=false;
					--nome_ws_return:='ubicazione';
					--nome_campo_id_sinaaf_return:='ubiId';
					--dbi_get_envelope_return:='sinaaf_ubicazione_animale_get_envelope';
				else
					propagazione_sinaaf_return:=true;
					nome_ws_return:='passaggio';
					nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
					nome_campo_id_sinaaf_return:='movId';
					dbi_get_envelope_return:='sinaaf_passaggi_animale_get_envelope';
					_id_proprietario:=(select * from sinaaf_get_id_proprietario(_id_tipologia_evento,_identita));
					_prop_esiste_in_sinaaf:= (select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id::text = _id_proprietario order by ws.id desc limit 1);
					if _prop_esiste_in_sinaaf is null then _prop_esiste_in_sinaaf:=false; end if;
					dipendenze_return := _id_proprietario || ';proprietario;' || _prop_esiste_in_sinaaf;
				end if;
		elsif(_id_tipologia_evento in(18,31,56,24,70)) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				nome_ws_return:='trasferimenti';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
                                nome_campo_id_sinaaf_return:='traId';
				dbi_get_envelope_return:='sinaaf_trasferimento_animale_get_envelope';
				_id_detentore_corrente:=(select * from sinaaf_get_id_proprietario(_id_tipologia_evento,_identita))::text;
				_det_esiste_in_sinaaf:= (select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id::text = _id_detentore_corrente::text order by ws.id desc limit 1);
				if _det_esiste_in_sinaaf is null then _det_esiste_in_sinaaf:=false; end if;
				dipendenze_return := _id_detentore_corrente || ';proprietario;' || _det_esiste_in_sinaaf;
		elsif(_id_tipologia_evento in(69)) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				nome_ws_return:='ubicazione';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
                                nome_campo_id_sinaaf_return:='ubiId';
				dbi_get_envelope_return:='sinaaf_ubicazione_animale_get_envelope';
	        elsif(_id_tipologia_evento in(6, 48)) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				cancellato_return:=false;
                                if(id_sinaaf_to_return is null or id_sinaaf_to_return='') then
					select e_reg_bdu.id_sinaaf into id_sinaaf_to_return from evento e join evento e_reg_bdu on e_reg_bdu.data_cancellazione is null and e_reg_bdu.trashed_date is null and e_reg_bdu.id_tipologia_evento = 1 and e_reg_bdu.id_animale = e.id_animale where e.id_evento::text = _identita ;
				end if;
				nome_ws_return:='gestionepassaporto';
				if(upper(method)='GET') then
					nome_ws_return:='animale';
				end if;
				nome_ws_get_return:='animale'; --Modifica per la velocità
				if(upper(method)='DELETE') then
					method:='PUT';
				end if;
                                nome_campo_id_sinaaf_return:='anmId';
				dbi_get_envelope_return:='sinaaf_passaporto_get_envelope';
		elsif(_id_tipologia_evento = 45) then
				_controllo_detentore_cambiato := (select id_detentore<>id_detentore_old from evento_restituzione_a_proprietario  where id_evento::text = _identita);
                               if(_controllo_detentore_cambiato or (select id_evento >0 from evento_ritrovamento where id_evento = (select id_evento_ritrovamento from evento_restituzione_a_proprietario where id_evento::text = _identita))) then
					propagazione_sinaaf_return:=true;
					select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
					nome_ws_return:='trasferimenti';
					nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
					nome_campo_id_sinaaf_return:='traId';
					dbi_get_envelope_return:='sinaaf_trasferimento_animale_get_envelope';
					_id_detentore_corrente:=(select * from sinaaf_get_id_proprietario(_id_tipologia_evento,_identita))::text;
					_det_esiste_in_sinaaf:= (select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id::text = _id_detentore_corrente::text order by ws.id desc limit 1);
					if _det_esiste_in_sinaaf is null then _det_esiste_in_sinaaf:=false; end if;
					dipendenze_return := _id_detentore_corrente || ';proprietario;' || _det_esiste_in_sinaaf;
				end if;
	        elsif(_id_tipologia_evento = 41) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				_controllo_detentore_cambiato := (select id_detentore_old_nd<>id_detentore_dopo_ritrovamento_nd from evento_ritrovamento_non_denunciato where id_evento::text = _identita);
                               if(_controllo_detentore_cambiato ) then
					nome_ws_return:='trasferimenti';
					nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
					nome_campo_id_sinaaf_return:='traId';
					dbi_get_envelope_return:='sinaaf_trasferimento_animale_get_envelope';
					_id_detentore_corrente:=(select * from sinaaf_get_id_proprietario(_id_tipologia_evento,_identita))::text;
					_det_esiste_in_sinaaf:= (select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from opu_relazione_stabilimento_linee_produttive as t1, ws_storico_chiamate ws where ws.id_tabella = t1.id::text and ws.tabella = 'opu_relazione_stabilimento_linee_produttive' and ws.esito= 'OK' and t1.id::text = _id_detentore_corrente::text order by ws.id desc limit 1);
					if _det_esiste_in_sinaaf is null then _det_esiste_in_sinaaf:=false; end if;
					dipendenze_return := _id_detentore_corrente || ';proprietario;' || _det_esiste_in_sinaaf;
				else
					nome_ws_return:='restituzionediretta';
					nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
					nome_campo_id_sinaaf_return:='redId';
					dbi_get_envelope_return:='sinaaf_restituzione_diretta_animale_get_envelope';
				end if;
		elsif(_id_tipologia_evento in(11,4)) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
                                nome_campo_id_sinaaf_return:='smaId';
				nome_ws_return:='smarrimento';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
				dbi_get_envelope_return:='sinaaf_smarrimento_animale_get_envelope';
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
		elsif(_id_tipologia_evento =23) then
				propagazione_sinaaf_return:=true;
				nome_ws_return:='reimmissioni';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
                                nome_campo_id_sinaaf_return:='reiId';
				dbi_get_envelope_return:='sinaaf_reimmissione_animale_get_envelope';
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
		elsif(_id_tipologia_evento = 12 ) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				nome_ws_return:='ritrovamento';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
                                nome_campo_id_sinaaf_return:='ritId';
				dbi_get_envelope_return:='sinaaf_ritrovamento_animale_get_envelope';
				--_controllo_detentore_cambiato := false;
                                _controllo_detentore_cambiato := (select id_detentore_dopo_ritrovamento<>id_detentore_old from evento_ritrovamento where id_evento::text = _identita);
                                if(_controllo_detentore_cambiato) then
					nome_ws_return:=nome_ws_return || ';trasferimenti';
					nome_ws_get_return:=nome_ws_return || ';trasferimenti'; --Modifica per la velocità
					nome_campo_id_sinaaf_return:= nome_campo_id_sinaaf_return || ';traId';
					dbi_get_envelope_return:=dbi_get_envelope_return || ';sinaaf_trasferimento_animale_get_envelope';
                                end if;
                                
		elsif(_id_tipologia_evento in (21,68) ) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				nome_ws_return:='morsicatura';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
                                nome_campo_id_sinaaf_return:='mrsId';
				dbi_get_envelope_return:='sinaaf_morsicatura_animale_get_envelope';
		elsif(_id_tipologia_evento = 9 ) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				nome_ws_return:='morte';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
                                nome_campo_id_sinaaf_return:='morId';
				dbi_get_envelope_return:='sinaaf_decesso_animale_get_envelope';
		elsif(_id_tipologia_evento = 38 ) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				nome_ws_return:='applicazionemicrochip';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
				_numero_microchip_assegnato := (select numero_microchip_assegnato from evento ev, evento ev2, evento_inserimento_microchip ev_ins_mc where ev.id_evento::text = _identita and ev2.id_tipologia_evento = 38 and ev2.id_animale = ev.id_animale and ev2.id_evento = ev_ins_mc.id_evento and ev2.trashed_date is null and ev2.data_cancellazione is null);
				_mc_esiste_in_sinaaf :=(select ws.data is not null and ws.data >= t1.modified_sinaaf and t1.modified_sinaaf is not null from microchips as t1, ws_storico_chiamate ws where ws.id_tabella = t1.microchip::text and ws.tabella = 'microchips' and ws.esito= 'OK' and t1.microchip::text = _numero_microchip_assegnato order by ws.id desc limit 1);
				if _mc_esiste_in_sinaaf is null then _mc_esiste_in_sinaaf:=false; end if;	
				dipendenze_return := _numero_microchip_assegnato || ';giacenza;' || _mc_esiste_in_sinaaf;
				nome_campo_id_sinaaf_return:='apmId';
				dbi_get_envelope_return:='sinaaf_applicazione_mc_animale_get_envelope';
		elsif(_id_tipologia_evento = 36 ) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				nome_ws_return:='eventisanitari';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
                                nome_campo_id_sinaaf_return:='eveId';
				dbi_get_envelope_return:='sinaaf_vaccinazione_get_envelope';
		elsif(_id_tipologia_evento = 2 ) then
				propagazione_sinaaf_return:=true;
				select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return);
				nome_ws_return:='eventisanitari';
				nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
                                nome_campo_id_sinaaf_return:='eveId';
				dbi_get_envelope_return:='sinaaf_sterilizzazione_get_envelope';
		end if;
	end if;

	if(entita='giacenza') then
		presente_in_gisa_return:=(select microchip from microchips where microchip = _identita::text and trashed_date is null);
		if presente_in_gisa_return is not null then presente_in_gisa_return:=null;
		else presente_in_gisa_return:='Propagazione non possibile. Caricare il microchip ' || _identita || ' in banca dati a priori'; 
                end if;
		id_tabella_return:='microchip';
                nome_campo_id_sinaaf_return:='micId';
		nome_campo_codice_sinaaf_get_return:='miccodice';
		nome_campo_codice_sinaaf_return:='micCodice';
		tabella_return:='microchips';
		propagazione_sinaaf_return:=(select case when ev_reg.flag_anagrafe_fr is null then true else ev_reg.flag_anagrafe_fr is false end   from evento_registrazione_bdu ev_reg, evento ev, animale a where ev_reg.id_evento = ev.id_evento and a.id = ev.id_animale and a.microchip = _identita and a.trashed_date is null and a.data_cancellazione is null and ev.data_cancellazione is null and ev.trashed_date is null);
		if(propagazione_sinaaf_return is null) then propagazione_sinaaf_return:=true; end if;
		if(propagazione_sinaaf_return) then select * into sincronizzato_to_return, id_sinaaf_to_return, codice_sinaaf_to_return, cancellato_return, id_sinaaf_secondario_to_return from sinaaf_is_sincronizzato(_identita, tabella_return,id_tabella_return); end if;
		nome_ws_return:='magazzinomicrochip';
		nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
		dbi_get_envelope_return:='sinaaf_giacenza_get_envelope';
		codice_semantico_to_return:= _identita::text;
        end if;	

        if(entita='veterinari') then
		nome_campo_id_sinaaf_return:='vetIdFiscale';
                nome_campo_codice_sinaaf_get_return:='vetidfiscale';
		nome_ws_return:='veterinario';
		nome_ws_get_return:=nome_ws_return; --Modifica per la velocità
        end if;	

	
   RETURN QUERY     
	select propagazione_sinaaf_return,nome_ws_return,dbi_get_envelope_return,id_tabella_return,tabella_return,dipendenze_return, nome_campo_id_sinaaf_return, presente_in_gisa_return,
	sincronizzato_to_return,coalesce(id_sinaaf_to_return,id_sinaaf_secondario_to_return),nome_campo_codice_sinaaf_get_return,nome_campo_codice_sinaaf_return, codice_sinaaf_to_return, 
	cancellato_return, codice_semantico_to_return;    
 END;
$function$
;
