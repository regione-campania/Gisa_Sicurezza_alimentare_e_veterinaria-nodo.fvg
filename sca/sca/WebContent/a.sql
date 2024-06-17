-- Function: public.verifica_banca_dati_a_priori(text, integer, boolean)

-- DROP FUNCTION public.verifica_banca_dati_a_priori(text, integer, boolean);

CREATE OR REPLACE FUNCTION public.verifica_banca_dati_a_priori(
    text,
    integer,
    flag boolean)
  RETURNS esito_controllo_mc_priori AS
$BODY$
DECLARE
	cursore 				refcursor ;
	idAnimale integer;
	flagpartite boolean ;
	esito_controllo				esito_controllo_mc_priori ;
	aslCf text;
	roleId integer;
	mc  text :='';
	idasl integer;
	animaleid integer ;
	abilitato boolean ;
	noteenabled text ;
	aslmc text ;
BEGIN

	open cursore for 
SELECT role_id,
case 
when role_id = 24 then c.codice_fiscale
when role_id = 37 then 'UNINA'
else lar.short_description
end as aslcf,a.site_id
from access a
left join contact c on (a.contact_id = c.contact_id)
left join lookup_asl_rif lar on lar.code = a.site_id where a.user_id = $2	;


fetch cursore into roleId,aslCf,idasl;
	close cursore ;

raise info 'datiutente %  ', aslCf;
if (roleId=24)
	then
	open cursore for SELECT id_animale,flag_gestione_partite,enabled,note from microchips where microchip ilike $1 and asl ilike aslCf and trashed_date is null 	;
	else
	open cursore for SELECT id_animale,flag_gestione_partite,enabled,note from microchips where microchip ilike $1  and trashed_date is null ;
	end if ;

	fetch cursore into idAnimale,flagpartite,abilitato,noteenabled;
	
close cursore ;
if (abilitato =false)
then
esito_controllo.esito:=2 ;
esito_controllo.descrizione := '- Microchip Esistente in banca dati a priori ma non utilizzabile  ';
else
		if(idAnimale>0 or (flagpartite = true) )
		then
			esito_controllo.esito:=2 ;
			esito_controllo.descrizione := '- Microchip Esistente in banca dati a priori ma Assegnato' ;
		else	
			if (roleId != 24 --and roleId != 5 and roleId != 6 
			and roleId != 37)
			then

				open cursore for SELECT microchip,asl, id_animale from microchips where microchip ilike $1 and trashed_date is null;
				fetch cursore into mc,aslmc, idAnimale;
				close cursore ;
				if(mc is null or (idAnimale is null or idAnimale < 0 )--and idasl>0
				 )
				then
					open cursore for select id from animale where (microchip ilike $1 or tatuaggio ilike $1) and data_cancellazione is null;
					fetch cursore into animaleid ;
					
					if animaleid is null or animaleid<=0 then
					
					--insert into microchips values ($1,aslCf,6,-1,$2,$2,true,true,null,false,null,-1,-1,flag);
					
					esito_controllo.esito:=1 ;
		esito_controllo.descrizione:='- Microchip disponibile in banca dati a priori' ;
		else
			esito_controllo.esito:=2 ;
			esito_controllo.descrizione := '- Microchip assegnato ad altro animale' ;
			end if ;
					else
					if (aslcf != aslmc) 
					then
						esito_controllo.esito:=4 ;
						esito_controllo.descrizione := '- Microchip Esistente in banca dati ma non per la propria utenza o asl';
					else
							esito_controllo.esito:=1 ;
							esito_controllo.descrizione:='- Microchip disponibile in banca dati a priori' ;
					end if ;
					end if;	
			else
				if (roleId = 24 or roleId = 37)
				then

				open cursore for SELECT microchip,asl from microchips where microchip ilike $1 and trashed_date is null;
				fetch cursore into mc,aslmc;
				close cursore ;
				if (mc is null)
				then
					esito_controllo.esito := 3 ;
					esito_controllo.descrizione := '- Microchip Non esistente in banca dati a priori' ;
						
				else
				if(aslcf!=aslmc) 
				then
						esito_controllo.esito:=4 ;
						esito_controllo.descrizione := '- Microchip Esistente in banca dati ma non per la propria utenza o asl';
				else
				esito_controllo.esito:=1 ;
		esito_controllo.descrizione:='- Microchip disponibile in banca dati a priori' ;
				end if ;
				end if ;
				end if ;	
					
			end if ;/*fine if roleid != 24 roleID != 24*/
			
			
			
		
		end if;
		end if ;


return esito_controllo ;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100;
ALTER FUNCTION public.verifica_banca_dati_a_priori(text, integer, boolean)
  OWNER TO postgres;
