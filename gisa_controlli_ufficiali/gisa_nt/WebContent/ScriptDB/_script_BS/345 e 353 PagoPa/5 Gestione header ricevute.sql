alter table pagopa_pagamenti add column header_file_ricevuta text;

-- documentale
alter table storage_gisa_trasgressori add column pagamento_id integer;
alter table storage_gisa_trasgressori add column extra text;

-- FUNCTION: public.pagopa_get_info_iuv(text)

-- DROP FUNCTION IF EXISTS public.pagopa_get_info_iuv(text);

CREATE OR REPLACE FUNCTION public.pagopa_get_info_iuv(
	_iuv text)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

   DECLARE
   
_json json;

   BEGIN

SELECT row_to_json(aa) into _json FROM (
SELECT
p.identificativo_univoco_versamento as "IUV",
cu.ticketid as "ID CONTROLLO UFFICIALE",
p.id_sanzione as "ID SANZIONE",
a.ragione_sociale_nominativo as "PAGATORE",
p.importo_singolo_versamento as "IMPORTO RICHIESTO",
p.data_scadenza as "DATA SCADENZA",
p.causale_versamento as "CAUSALE VERSAMENTO",
p.stato_pagamento as "STATO PAGAMENTO",
case when p.tipo_pagamento = 'PV' then 'Processo Verbale' when p.tipo_pagamento = 'NO' then 'Numero Ordinanza' else '' end as "TIPO AVVISO",
case when p.stato_pagamento = 'PAGAMENTO COMPLETATO' then p.header_file_ricevuta else p.header_file_avviso end as "PDF AVVISO O RICEVUTA",
rt.progressivo||'\'||substring(rt.anno::text, 3, 2) as "PRESENZA REGISTRO TRASGRESSORI"

from pagopa_pagamenti p
join ticket s on s.ticketid = p.id_sanzione and s.trashed_date is null and s.tipologia = 1
join ticket cu on cu.ticketid = s.id_controllo_ufficiale::integer and cu.trashed_date is null and cu.tipologia = 3
join pagopa_anagrafica_pagatori a on a.id = p.id_pagatore
join registro_trasgressori_values rt on rt.id_sanzione = p.id_sanzione and rt.trashed_date is null

where p.identificativo_univoco_versamento = _iuv and p.trashed_date is null
) aa;

IF _json IS NULL THEN
SELECT row_to_json(bb) into _json FROM (SELECT 'Nessun IUV attivo trovato con questi dati' as "ERRORE") bb;
END IF;

return _json;

   END
$BODY$;

ALTER FUNCTION public.pagopa_get_info_iuv(text)
    OWNER TO postgres;
