
CREATE OR REPLACE FUNCTION public.get_pagopa_importi_totali_ordinanza(
	_id_sanzione integer)
    RETURNS TABLE(importo_totale_richiesto double precision, importo_totale_versato double precision, importo_totale_residuo double precision) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 

importoTotaleRichiesto double precision;
importoTotaleVersato double precision;
importoTotaleResiduo double precision;

begin

importoTotaleRichiesto := 0.0;
importoTotaleVersato := 0.0;
importoTotaleResiduo := 0.0;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] Calcolo importi totali sanzione: %', _id_sanzione;

SELECT importo_totale_versamento into importoTotaleRichiesto from pagopa_sanzioni_importo_ordinanza where id_sanzione = _id_sanzione and trashed_date is null and principale;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleRichiesto: %', importoTotaleRichiesto;

SELECT COALESCE(sum(importo_singolo_versamento::double precision), 0.0) into importoTotaleVersato from pagopa_pagamenti where id_sanzione = _id_sanzione and trashed_date is null and stato_pagamento = 'PAGAMENTO COMPLETATO';

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleVersato: %', importoTotaleVersato;

SELECT (importoTotaleRichiesto-importoTotaleVersato) into importoTotaleResiduo;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleResiduo: %', importoTotaleResiduo;

return query SELECT round(importoTotaleRichiesto::numeric, 2)::double precision, round(importoTotaleVersato::numeric, 2)::double precision, round(importoTotaleResiduo::numeric, 2)::double precision;

end; 
$BODY$;

