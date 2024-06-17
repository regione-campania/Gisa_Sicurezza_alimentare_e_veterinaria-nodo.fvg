-- aggiunta colonna header su pagopa_pagamenti

alter table pagopa_pagamenti add column header_file_avviso text;

-- Recupero pregresso

-- documentale

select header, ticket_id, replace(nome_client, '.pdf', ''), 
'update pagopa_pagamenti set header_file_avviso ='''||header||''' where identificativo_univoco_versamento = '''||replace(nome_client, '.pdf', '')||''' and trashed_date is null;'
from storage_gisa_trasgressori where tipo = 'AvvisoPagoPA';

-- lancio risultato su gisa
-----------------------------

-- verifico mancanti

select * from pagopa_pagamenti where 
trashed_date is null
and stato_pagamento <> 'PAGAMENTO COMPLETATO'
and header_file_avviso is null 
and data_scadenza::timestamp without time zone > now()
order by entered asc;

-- Lancio Servlet

/AggiornaHeaderAvvisiPagoPA
-- dopo aver lanciato Gestione Header Ricevute
-- o in alternativa puntuale da "automatismi pagopa" se sono pochissimi

-- riverifico mancanti

select * from pagopa_pagamenti where 
trashed_date is null
and stato_pagamento <> 'PAGAMENTO COMPLETATO'
and header_file_avviso is null 
and data_scadenza::timestamp without time zone > now()
order by entered asc;