CREATE TABLE pagopa_sanzioni_importo_ordinanza (id serial primary key, id_sanzione integer, importo_totale_versamento text, numero_rate integer, data_notifica text, principale boolean, note_hd text, entered timestamp without time zone default now(), enteredby integer, trashed_date timestamp without time zone );

insert into pagopa_sanzioni_importo_ordinanza (id_sanzione, importo_totale_versamento, numero_rate, entered, enteredby, principale, note_hd)

select 
id_sanzione,
sum(importo_singolo_versamento::double precision) as importo_totale_versamento,
max(numero_rate) as numero_rate,
min(entered) as entered,
min(entered_by),
true,
'INSERITO DA HD PER BONIFICA PREGRESSO FLUSSO 324'

from pagopa_pagamenti where tipo_pagamento = 'NO' and trashed_date is null
group by id_sanzione
order by id_sanzione;



