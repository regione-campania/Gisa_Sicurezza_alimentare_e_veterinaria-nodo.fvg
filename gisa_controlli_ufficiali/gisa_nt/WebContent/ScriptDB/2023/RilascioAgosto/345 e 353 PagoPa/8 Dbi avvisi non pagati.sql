-- FUNCTION: public.pagopa_get_avvisi_non_pagati()

-- DROP FUNCTION IF EXISTS public.pagopa_get_avvisi_non_pagati();

CREATE OR REPLACE FUNCTION public.pagopa_get_avvisi_non_pagati(
	)
    RETURNS TABLE(id_pagamento integer, id_sanzione integer, data_scadenza text, importo_singolo_versamento text, identificativo_univoco_versamento text, stato_pagamento text, tipo_riduzione text, tipo_notifica text, data_notifica text, notifica_aggiornata text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
r RECORD;	
BEGIN
FOR 

id_pagamento, id_sanzione, data_scadenza, importo_singolo_versamento, identificativo_univoco_versamento, stato_pagamento, tipo_riduzione, tipo_notifica, data_notifica, notifica_aggiornata

in

select 
p.id, p.id_sanzione, p.data_scadenza, p.importo_singolo_versamento, p.identificativo_univoco_versamento, p.stato_pagamento, p.tipo_riduzione, n.tipo_notifica, n.data_notifica, n.notifica_aggiornata
from pagopa_pagamenti p 
join pagopa_sanzioni_pagatori_notifiche n on p.id_sanzione = n.id_sanzione and p.id_pagatore = n.id_pagatore 
where p.trashed_date is null and n.trashed_date is null and p.stato_pagamento not in ('PAGAMENTO COMPLETATO', 'PAGAMENTO SCADUTO') 

order by p.id_sanzione asc, p.identificativo_univoco_versamento asc

    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.pagopa_get_avvisi_non_pagati()
    OWNER TO postgres;

    
    -- FUNCTION: public.pagopa_get_avvisi_scaduti()

-- DROP FUNCTION IF EXISTS public.pagopa_get_avvisi_scaduti();

CREATE OR REPLACE FUNCTION public.pagopa_get_avvisi_scaduti(
	)
    RETURNS TABLE(id_pagamento integer, id_sanzione integer, data_scadenza text, importo_singolo_versamento text, identificativo_univoco_versamento text, stato_pagamento text, tipo_riduzione text, tipo_notifica text, data_notifica text, notifica_aggiornata text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
r RECORD;   
BEGIN
FOR

id_pagamento, id_sanzione, data_scadenza, importo_singolo_versamento, identificativo_univoco_versamento, stato_pagamento, tipo_riduzione, tipo_notifica, data_notifica, notifica_aggiornata

in

select
p.id, p.id_sanzione, p.data_scadenza, p.importo_singolo_versamento, p.identificativo_univoco_versamento, p.stato_pagamento, p.tipo_riduzione, n.tipo_notifica, n.data_notifica, n.notifica_aggiornata
from pagopa_pagamenti p 
left join pagopa_sanzioni_pagatori_notifiche n on p.id_sanzione = n.id_sanzione and p.id_pagatore = n.id_pagatore 
where p.trashed_date is null 
and n.trashed_date is null 
and p.stato_pagamento not in ('PAGAMENTO COMPLETATO', 'PAGAMENTO SCADUTO') 
and p.data_scadenza::timestamp without time zone < to_char(now(), 'yyyy-mm-dd')::timestamp without time zone

order by p.id_sanzione asc, p.identificativo_univoco_versamento asc

    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.pagopa_get_avvisi_scaduti()
    OWNER TO postgres;
	

