--Controllare le funzioni e le viste se sono allineate con ufficiale

CREATE OR REPLACE FUNCTION public.sinaaf_is_linea_bloccata(IN _identita text, IN _entita text, IN nomeidtabella text)
 RETURNS  boolean AS
$BODY$
DECLARE
bloccato_return boolean;
id_rel_stab_lp integer;
 begin

 for 
id_rel_stab_lp
 IN
select id 
from opu_relazione_stabilimento_linee_produttive rel 
where rel.id_stabilimento=_identita::integer and enabled and trashed_date is null

LOOP
	
	bloccato_return := (select sincronizzato =2 from sinaaf_is_sincronizzato( id_rel_stab_lp::text , _entita , nomeidtabella )  ) and   (select * from sinaaf_get_propagabilita( id_rel_stab_lp::text , _entita  )  );

	if(bloccato_return) then
		return true;
	end if;
	

END LOOP;

return false;
 END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.sinaaf_is_linea_bloccata(text,text,text)
  OWNER TO postgres;

