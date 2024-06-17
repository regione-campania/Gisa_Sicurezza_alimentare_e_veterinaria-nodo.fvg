-- Genero permesso

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_scadi_singolo',	
'Visualizzazione bottone Scadi Singolo PagoPA (NON ASSEGNARE! IL FLUSSO NON CONSENTE LA SCADENZA DA GISA! DISPONIBILE SOLO PER COLLAUDO)',
true, false, false, false, 8);


-- Nuovo automatismo scadenza

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
from pagopa_pagamenti p left join pagopa_sanzioni_pagatori_notifiche n on p.id_sanzione = n.id_sanzione and p.id_pagatore = n.id_pagatore 
where p.trashed_date is null and n.trashed_date is null 
--and p.tipo_pagamento = 'PV' 
and p.stato_pagamento = 'PAGAMENTO NON INIZIATO' and p.data_scadenza::timestamp without time zone < now()
--and ((n.tipo_notifica='R' and n.notifica_aggiornata is NOT true))

order by p.id_sanzione asc, p.identificativo_univoco_versamento asc

    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.pagopa_get_avvisi_scaduti()
    OWNER TO postgres;
	

    DROP FUNCTION pagopa_get_due_avvisi_scaduti_ordinanza();

CREATE OR REPLACE FUNCTION public.pagopa_get_due_avvisi_scaduti_ordinanza(
	)
    RETURNS TABLE(id_sanzione_scaduta integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
r RECORD;
_r_sanzioni RECORD;
_id_sanzione_precedente integer;
_indice_precedente integer;
_sanzioni_scadute  integer[];
BEGIN

_id_sanzione_precedente := -1;
_indice_precedente := -1;

FOR _r_sanzioni IN

SELECT 
p.id_sanzione, p.indice, string_agg(distinct p.stato_pagamento, ';') as stato
from pagopa_pagamenti p
where p.trashed_date is null 
and p.tipo_pagamento = 'NO'
and p.stato_pagamento <> 'PAGAMENTO COMPLETATO'
and p.id_sanzione not in (select id_sanzione from pagopa_pagamenti where rigenerato and trashed_date is null)
group by p.id_sanzione, p.indice
order by p.id_sanzione asc, p.indice asc

LOOP
       -- RAISE INFO '[pagopa_get_due_avvisi_scaduti_ordinanza] id_sanzione|indice: %|%: %', _r_sanzioni.id_sanzione, _r_sanzioni.indice, _r_sanzioni.stato;
	
	IF _r_sanzioni.stato = 'PAGAMENTO SCADUTO' THEN
        
		IF _id_sanzione_precedente = _r_sanzioni.id_sanzione AND _indice_precedente = (_r_sanzioni.indice -1) THEN
		RAISE INFO '[pagopa_get_due_avvisi_scaduti_ordinanza] sanzione da considerare: %|%', _r_sanzioni.id_sanzione, _r_sanzioni.indice;

			SELECT array_append(_sanzioni_scadute, _r_sanzioni.id_sanzione) into _sanzioni_scadute;
		END IF;
	END IF;

_id_sanzione_precedente = _r_sanzioni.id_sanzione;
_indice_precedente = _r_sanzioni.indice;

END LOOP;
RAISE INFO '[pagopa_get_due_avvisi_scaduti_ordinanza] _sanzioni_scadute: %', _sanzioni_scadute;

FOR
id_sanzione_scaduta

in

SELECT unnest(_sanzioni_scadute)

    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

ALTER FUNCTION public.pagopa_get_due_avvisi_scaduti_ordinanza()
    OWNER TO postgres;
	
