-- AGGIUNGO TABELLA STORICO

CREATE TABLE pagopa_pagamenti_storico_chiamate (id SERIAL PRIMARY KEY, id_pagamento integer, entered timestamp without time zone default now(), storico text);


CREATE TABLE pagopa_sanzioni_pagatori_notifiche_storico (id SERIAL PRIMARY KEY, entered timestamp without time zone default now(), id_sanzione integer, storico text);

insert into pagopa_sanzioni_pagatori_notifiche_storico (entered, id_sanzione, storico)
select COALESCE(modified, entered), id_sanzione, note_hd from pagopa_sanzioni_pagatori_notifiche where note_hd <> '';