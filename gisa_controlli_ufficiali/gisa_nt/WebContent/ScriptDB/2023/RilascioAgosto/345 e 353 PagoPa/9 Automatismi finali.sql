-- FUNCTION: public.pagopa_get_avvisi_in_scadenza_processo_verbale()

DROP FUNCTION IF EXISTS public.pagopa_get_avvisi_in_scadenza();

DROP FUNCTION IF EXISTS public.pagopa_get_avvisi_in_scadenza_processo_verbale();

CREATE OR REPLACE FUNCTION public.pagopa_get_avvisi_in_scadenza_processo_verbale(
	)
    RETURNS TABLE(id_pagamento integer, id_sanzione integer, data_scadenza text, importo_singolo_versamento text, identificativo_univoco_versamento text, stato_pagamento text, tipo_riduzione text, trasgressore_obbligato text, id_trasgressore integer, tipo_notifica_trasgressore text, data_notifica_trasgressore text, notifica_aggiornata_trasgressore text, id_obbligato integer, tipo_notifica_obbligato text, data_notifica_obbligato text, notifica_aggiornata_obbligato text, operazione text) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
r RECORD;	
BEGIN
FOR 

id_pagamento, id_sanzione, data_scadenza, importo_singolo_versamento, identificativo_univoco_versamento, stato_pagamento, tipo_riduzione, trasgressore_obbligato, id_trasgressore, tipo_notifica_trasgressore, data_notifica_trasgressore, notifica_aggiornata_trasgressore, id_obbligato, tipo_notifica_obbligato, data_notifica_obbligato, notifica_aggiornata_obbligato, operazione

in

SELECT * FROM (

select distinct
p.id, 
p.id_sanzione, 
p.data_scadenza, 
p.importo_singolo_versamento, 
p.identificativo_univoco_versamento, 
p.stato_pagamento, 
p.tipo_riduzione,
case
when p.id_pagatore = mapt.id_pagatore then mapt.trasgressore_obbligato
when p.id_pagatore = mapo.id_pagatore then mapo.trasgressore_obbligato
end as trasgressore_obbligato,

nott.id_pagatore as id_tragressore, 
nott.tipo_notifica as tipo_notifica_trasgressore, 
nott.data_notifica as data_notifica_trasgressore,
nott.notifica_aggiornata as notifica_aggiornata_trasgressore,
noto.id_pagatore as id_obbligato,
noto.tipo_notifica as tipo_notifica_obbligato, 
noto.data_notifica as data_notifica_obbligato, 
noto.notifica_aggiornata as notifica_aggiornata_obbligato,

case 
when p.id_pagatore = mapo.id_pagatore and nott.tipo_notifica in ('I', 'P') and noto.tipo_notifica in ('R') and noto.notifica_aggiornata is not true then 'PROROGA DA DATA NOTIFICA TRASGRESSORE'
when p.id_pagatore = mapt.id_pagatore and  nott.tipo_notifica in ('R') and noto.tipo_notifica in ('I', 'P') and nott.notifica_aggiornata is not true then 'PROROGA DA DATA NOTIFICA OBBLIGATO'
when nott.tipo_notifica in ('R') and noto.tipo_notifica in ('R') and nott.notifica_aggiornata is not true and noto.notifica_aggiornata is not true then 'PROROGA DA PROPRIA DATA NOTIFICA'
when p.id_pagatore = mapo.id_pagatore and nott.tipo_notifica in ('R') and noto.tipo_notifica in ('R') and nott.notifica_aggiornata is true and noto.notifica_aggiornata is not true then 'ANNULLA'
when p.id_pagatore = mapt.id_pagatore and nott.tipo_notifica in ('R') and noto.tipo_notifica in ('R') and nott.notifica_aggiornata is not true and noto.notifica_aggiornata is true then 'ANNULLA' end as operazione

from pagopa_pagamenti p 
LEFT JOIN pagopa_mapping_sanzioni_pagatori mapt on mapt.id_sanzione = p.id_sanzione and mapt.trasgressore_obbligato = 'T' and mapt.trashed_date is null
LEFT JOIN pagopa_mapping_sanzioni_pagatori mapo on mapo.id_sanzione = p.id_sanzione and mapo.trasgressore_obbligato = 'O' and mapo.trashed_date is null
LEFT JOIN pagopa_sanzioni_pagatori_notifiche nott on p.id_sanzione = nott.id_sanzione and mapt.id_pagatore = nott.id_pagatore and nott.trashed_date is null
LEFT JOIN pagopa_sanzioni_pagatori_notifiche noto on p.id_sanzione = noto.id_sanzione and mapo.id_pagatore = noto.id_pagatore and noto.trashed_date is null

where p.trashed_date is null 
and p.tipo_pagamento = 'PV' 
and p.stato_pagamento = 'PAGAMENTO NON INIZIATO' 
and p.data_scadenza::timestamp without time zone <= now() 
and mapt.id > 0 and mapo.id > 0
order by p.id_sanzione asc, p.identificativo_univoco_versamento asc
) avvisi where avvisi.operazione <> ''

LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.pagopa_get_avvisi_in_scadenza_processo_verbale()
    OWNER TO postgres;

select * from pagopa_get_avvisi_in_scadenza_processo_verbale();


-- Lanciare:

/ControllaPagamentiPagoPA -- NON IN COLLAUDO, GLI AVVISI NON ESISTONO
/ControllaScadenzePagoPA -- IN COLLAUDO VERIFICARE PRIMA SE select * from pagopa_get_avvisi_in_scadenza(); RESTITUISCE VUOTO, ALTRIMENTI MODIFICARLA PER FAR RESTITUIRE VUOTO
