--------------------------------- DA LANCIARE IN UFFICIALE ----------------------------------
update comuni1 set nome='SANTA MARIA LA CARITÀ' where nome ilike '%SANTA MARIA LA CARIT%';
select'update organization_address set notes=concat_ws(''-'',notes,''Aggiornamento comune. Val precedente:'||city||'''''), city=''SANTA MARIA LA CARITÀ'' where address_id='||address_id||';' 
from organization_address 
where city ilike '%SANTA MARIA LA CARIT%';
select'update organization_address set notes=concat_ws(''-'',notes,''Aggiornamento comune. Val precedente:'||city||'''), city=''SANTA MARIA LA CARITÀ'' where address_id='||address_id||';' 
from organization_address 
where city ilike '%SANTA MARIA LA CARIT%GRAVE%';
update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='SANTA MARIA LA CARITÀ'
where  comune_testo ilike 'santa maria la carita''';
/* query di verifica
select * from opu_indirizzo where comune_testo ilike 'santa maria la carita'''
select * from ricerche_anagrafiche_old_materializzata where comune ilike '%santa maria la carita''' --1
select * from ricerche_anagrafiche_old_materializzata where comune_leg ilike '%santa maria la carita''' --1

*/

update organization_address set city='SANTA MARIA LA CARITÀ' WHERE  address_id in(
1382205,
989579,
965482,
8476994);


 DROP VIEW public.comuni;

CREATE OR REPLACE VIEW public.comuni
 AS
 SELECT c1.nome AS comune,
    c1.codice,
    c1.istat AS codiceistatcomune,
    c1.cod_regione AS codiceistatregione,
    c1.codiceistatasl,
    c1.codiceistatasl_old,
    c1.codice_old,
    c1.notused,
    true AS enabled
   FROM comuni1 c1
  WHERE c1.cod_regione::text = '15'::text and c1.notused is not true;

ALTER TABLE public.comuni
    OWNER TO postgres;

+ PARTE JAVA
-------------------------------------- FINE DA LANCIARE IN UFFICIALE -----------------------------
update organization_address set notes=concat_ws('**22/11/2023**',notes,'Aggiornamento nome comune (val prec: Meta di Sorrento)'), city = 'Meta' where city ilike '%meta di sorrento%'
update organization_address set notes=concat_ws('**22/11/2023**',notes,'Aggiornamento nome comune (val prec: SANT''AGATA DE''GOTI)'), city = 'SANT''AGATA DE'' GOTI' where city ilike '%Sant''agata de''goti%'; 
update comuni1 set nome='MONTORO' where  nome ilike 'montoro';

update comuni1 set nome='TRENTOLA DUCENTA' where nome ilike '%trentola%';
update comuni1 set nome='CAPACCIO PAESTUM' where nome ilike '%capaccio%';
update comuni1 set nome='SANTA MARIA LA CARITÀ' where nome ilike '%SANTA MARIA LA CARIT%';

select'update organization_address set notes=concat_ws(''-'',notes,''Aggiornamento comune. Val precedente:'||city||'''), city=''CAPACCIO PAESTUM'' where address_id='||address_id||';' 
from organization_address 
where city ilike '%capaccio%';
select'update organization_address set notes=concat_ws(''-'',notes,''Aggiornamento comune. Val precedente:'||city||'''), city=''TRENTOLA DUCENTA'' where address_id='||address_id||';' 
from organization_address 
where city ilike '%TRENTOLA-DUCENT%';

select'update organization_address set notes=concat_ws(''-'',notes,''Aggiornamento comune. Val precedente:'||city||'''), city=''MONTORO'' where address_id='||address_id||';' 
from organization_address 
where city ilike '%montoro sup%';

select'update organization_address set notes=concat_ws(''-'',notes,''Aggiornamento comune. Val precedente:'||city||'''), city=''MONTORO'' where address_id='||address_id||';' 
from organization_address 
where city ilike '%montoro infe%';

select'update organization_address set notes=concat_ws(''-'',notes,''Aggiornamento comune. Val precedente:'||city||'''''), city=''SANTA MARIA LA CARITÀ'' where address_id='||address_id||';' 
from organization_address 
where city ilike '%SANTA MARIA LA CARIT%';

select'update organization_address set notes=concat_ws(''-'',notes,''Aggiornamento comune. Val precedente:'||city||'''), city=''SANTA MARIA LA CARITÀ'' where address_id='||address_id||';' 
from organization_address 
where city ilike '%SANTA MARIA LA CARIT%GRAVE%';

-- in demo e collaudo su tutti sn stati lanciati
select distinct lp.description, lp.cod_provincia, c.nome,
'update organization_address set notes=concat_ws(''-'',notes, ''Aggiornamento provincia con il codice preso da lookup_province(val.precedente:'||(case when (length(oa.state)=0 or length(oa.state) is null) then 'ERA VUOTO' ELSE replace(trim(upper(oa.state)),'''','''''') end)||')''), state='''||lp.cod_provincia||''' where trim(upper(city)) ilike '''||replace(trim(upper(c.nome)),'''','''''')||'''; '
from 
lookup_province lp
join comuni1 c on c.cod_provincia::integer = lp.code
join organization_address oa on trim(upper(oa.city))=trim(upper(c.nome))
--solo su acque di rete lanciato in ufficiale
--join organization o on o.org_id=oa.org_id and o.trashed_date is null and o.tipologia =14
and c.notused is not true 

DELETE FROM ricerche_anagrafiche_old_materializzata where riferimento_id_nome_tab='organization';
insert into ricerche_anagrafiche_old_materializzata (select * from ricerca_anagrafiche where riferimento_id_nome_tab='organization');

-- View: public.comuni

-- DROP VIEW public.comuni;

CREATE OR REPLACE VIEW public.comuni
 AS
 SELECT c1.nome AS comune,
    c1.codice,
    c1.istat AS codiceistatcomune,
    c1.cod_regione AS codiceistatregione,
    c1.codiceistatasl,
    c1.codiceistatasl_old,
    c1.codice_old,
    c1.notused,
    true AS enabled
   FROM comuni1 c1
  WHERE c1.cod_regione::text = '15'::text and c1.notused is not true;

ALTER TABLE public.comuni
    OWNER TO postgres;
    
/* query di verifica
select * from opu_indirizzo where comune_testo ilike 'capaccio'
select * from opu_indirizzo where comune_testo ilike 'trentola-ducenta'
select * from opu_indirizzo where comune_testo ilike 'sant''agata de''goti'
select * from opu_indirizzo where comune_testo ilike 'santa maria la carita'''

select * from ricerche_anagrafiche_old_materializzata where comune ilike '%montoro %' --440 da aggiornare in org
and tipologia_operatore <> 2
select * from ricerche_anagrafiche_old_materializzata where comune ilike '%trentola-%' --0
select * from ricerche_anagrafiche_old_materializzata where comune ilike '%capaccio' --0
select * from ricerche_anagrafiche_old_materializzata where comune ilike '%sant''agata de''goti' --0
select * from ricerche_anagrafiche_old_materializzata where comune ilike '%meta %' --0
select * from ricerche_anagrafiche_old_materializzata where comune ilike '%santa maria la carita''' --1

select * from ricerche_anagrafiche_old_materializzata where comune_leg ilike '%montoro %' --2

select * from ricerche_anagrafiche_old_materializzata where comune_leg ilike '%trentola-%' --0
select * from ricerche_anagrafiche_old_materializzata where comune_leg ilike '%capaccio' --0
select * from ricerche_anagrafiche_old_materializzata where comune_leg ilike '%sant''agata de''goti' --0
select * from ricerche_anagrafiche_old_materializzata where comune_leg ilike '%meta %' --0
select * from ricerche_anagrafiche_old_materializzata where comune_leg ilike '%santa maria la carita''' --1
*/


update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='CAPACCIO PAESTUM'
where  comune_testo ilike 'capaccio';
update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='TRENTOLA DUCENTA'
where  comune_testo ilike 'trentola-ducenta'; 
update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='SANT''AGATA DE'' GOTI'
where  comune_testo ilike 'sant''agata de''goti'; 
update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='SANTA MARIA LA CARITÀ'
where  comune_testo ilike 'santa maria la carita''';
update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='MONTORO'
where  comune_testo ='Montoro';
update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='MONTORO',
comune=1
where  comune_testo ='MONTORO INFERIORE';
update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='MONTORO',
comune=1 
where  comune_testo ='MONTORO SUPERIORE';

update organization_address set city='SANTA MARIA LA CARITÀ' WHERE  address_id in(
1382205,
989579,
965482,
8476994);

-- per opu stare attenti al comune di nascita

update opu_indirizzo set 
note_hd=concat_ws('-',note_hd,'Aggiornamento comune testo. Val precedente:'||comune_testo||''), 
comune_testo='MONTORO',
comune=1 
where id in(
--opu
346954,	
346955,
395685,	
395686,
353378,	
353379
)

-- aggiornamento per allevamenti
update aziende set 
cod_comune_azienda='64121',
note_hd=concat_ws('**29/11/2023**',note_hd,'Aggiornamento comune istat:64061')
where cod_comune_azienda ilike '64061';

update aziende set 
cod_comune_azienda='64121',
note_hd=concat_ws('**29/11/2023**',note_hd,'Aggiornamento comune istat:64062')
where cod_comune_azienda ilike '64062';

DELETE from ricerche_anagrafiche_old_materializzata;
insert into ricerche_anagrafiche_old_materializzata (select * from ricerca_anagrafiche);



 -- Modifiche JAVA
 org.aspcfs.modules.accounts.base/Comuni.java
 org.aspcfs.modules.gestioneanagrafica.utils/GestioneAnagraficaGetComuneByAsl.java
 WC/gestionecap/js/comuni2.js
 WC/javascript/gestoreCodiceFiscale.js
 WC/javascript/noscia/addNoScia.js e codiceFiscale.js
 WC/templates/template1nav.jsp e template1nav.jspPAOLO
