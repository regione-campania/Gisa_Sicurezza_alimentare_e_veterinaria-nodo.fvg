----------------------  Backup

CREATE TABLE sviluppo_flussi_backup as
SELECT * from sviluppo_flussi;

---------------------- Gestione referenti

CREATE TABLE public.lookup_referenti_flusso
(
  code serial primary key,
  description character varying(50) NOT NULL,
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true,
  codice_fiscale text
);

insert into lookup_referenti_flusso(description, codice_fiscale) values ('PAOLO SARNELLI', 'SRNPLA56L08F839C');
insert into lookup_referenti_flusso(description, codice_fiscale) values ('CINZIA MATONTI', 'MTNCNZ70R59I073W');
insert into lookup_referenti_flusso(description, codice_fiscale) values ('MAURIZIO DELLA ROTONDA', 'DLLMRZ60M08F839L');
insert into lookup_referenti_flusso(description, codice_fiscale) values ('GIUSEPPE DI LORIA', 'DLRGPP71M05I838S');
insert into lookup_referenti_flusso(description, codice_fiscale) values ('MARINA POMPAMEO', 'PMPMRN60B65F839D');
insert into lookup_referenti_flusso(description, codice_fiscale) values ('BERARDINO IZZO', 'ZZIBRD65R11A783K');
insert into lookup_referenti_flusso(description, codice_fiscale) values ('MARCO ESPOSITO', 'SPSMRC77P11H892Z');
insert into lookup_referenti_flusso(description, codice_fiscale) values ('GERMANA COLARUSSO', 'CLRGMN79R70A509H');
insert into lookup_referenti_flusso(description, codice_fiscale) values ('ALESSANDRA DE FELICE', 'DFLLSN84E63B963C');

alter table sviluppo_flussi add column id_referente integer;
alter table sviluppo_flussi add column note_aggiornamenti_referente text;


---------------------- Gestione Stato


CREATE TABLE public.lookup_stati_flusso
(
  code serial primary key,
  description character varying(50) NOT NULL,
  default_item boolean DEFAULT false,
  level integer DEFAULT 0,
  enabled boolean DEFAULT true
);

insert into lookup_stati_flusso (description) values ('APERTO');
insert into lookup_stati_flusso (description) values ('CONSEGNATO');
insert into lookup_stati_flusso (description) values ('COLLAUDATO');
insert into lookup_stati_flusso (description) values ('STANDBY');
insert into lookup_stati_flusso (description) values ('ANNULLATO');


alter table sviluppo_flussi add column id_stato integer;

CREATE TABLE sviluppo_stati_flusso (
id serial primary key,
entered timestamp without time zone default now(),
id_flusso integer,
id_utente integer,
id_stato integer,
data text,
note text,
note_hd text,
enabled boolean default true);


insert into sviluppo_stati_flusso (entered, data, id_flusso, id_utente, id_stato, note) 
select data_consegna, data_consegna, id_flusso, id_utente_consegna, 3, note_consegna from sviluppo_flussi where data_consegna is not null;

insert into sviluppo_stati_flusso (entered, data, id_flusso, id_utente, id_stato, note) 
select data_standby, data_standby, id_flusso, id_utente_standby, 4, note_standby from sviluppo_flussi where data_standby is not null;

insert into sviluppo_stati_flusso (entered, data, id_flusso, id_utente, id_stato, note) 
select data_annullamento, data_annullamento, id_flusso, id_utente_annullamento, 5, note_annullamento from sviluppo_flussi where data_annullamento is not null;

alter table sviluppo_flussi drop column data_consegna;
alter table sviluppo_flussi drop column id_utente_consegna;
alter table sviluppo_flussi drop column note_consegna;

alter table sviluppo_flussi drop column data_standby;
alter table sviluppo_flussi drop column id_utente_standby;
alter table sviluppo_flussi drop column note_standby;

alter table sviluppo_flussi drop column data_annullamento;
alter table sviluppo_flussi drop column id_utente_annullamento;
alter table sviluppo_flussi drop column note_annullamento;

DROP TRIGGER log_operazioni_flusso ON public.sviluppo_flussi;

update sviluppo_flussi set id_stato = null;

select 'update sviluppo_flussi set id_stato = '||id_stato||' where id_flusso = '||id_flusso||';' from sviluppo_stati_flusso ;

update sviluppo_flussi set id_stato = 1 where id_stato is null;

---------------------- Permessi

-- Permesso modifica referente

insert into permission (category_id, permission, permission_view, description)
select
category_id, 'devdoc-referente', true, 'Abilita la modifica al referente di un flusso'
from permission where permission = 'devdoc-priorita';

--HD1 e HD2
insert into role_permission(role_id, permission_id, role_view) values (1, (select permission_id from permission where permission = 'devdoc-referente'), true);
insert into role_permission(role_id, permission_id, role_view) values (32, (select permission_id from permission where permission = 'devdoc-referente'), true);

-- responsabile regione
insert into role_permission(role_id, permission_id, role_view) values (27, (select permission_id from permission where permission = 'devdoc-referente'), true);

--referente regione
insert into role_permission(role_id, permission_id, role_view) values (3374, (select permission_id from permission where permission = 'devdoc-referente'), true);

--orsa
insert into role_permission(role_id, permission_id, role_view) values (31, (select permission_id from permission where permission = 'devdoc-referente'), true);

-- Modifica stato

insert into permission (category_id, permission, permission_view, description, level)
select category_id, 'devdoc-modifica-stato-aperto', true, 'Abilita la modifica stato flusso: Aperto', 90
from permission where permission = 'devdoc-priorita';

insert into permission (category_id, permission, permission_view, description, level)
select category_id, 'devdoc-modifica-stato-consegnato', true, 'Abilita la modifica stato flusso: Consegnato', 91
from permission where permission = 'devdoc-priorita';

insert into permission (category_id, permission, permission_view, description, level)
select category_id, 'devdoc-modifica-stato-collaudato', true, 'Abilita la modifica stato flusso: Collaudato', 92
from permission where permission = 'devdoc-priorita';

insert into permission (category_id, permission, permission_view, description, level)
select category_id, 'devdoc-modifica-stato-standby', true, 'Abilita la modifica stato flusso: Standby', 93
from permission where permission = 'devdoc-priorita';

insert into permission (category_id, permission, permission_view, description, level)
select category_id, 'devdoc-modifica-stato-annullato', true, 'Abilita la modifica stato flusso: Annullato', 94
from permission where permission = 'devdoc-priorita';

--HD1 e HD2
insert into role_permission(role_id, permission_id, role_view) values (1, (select permission_id from permission where permission = 'devdoc-modifica-stato-aperto'), true);
insert into role_permission(role_id, permission_id, role_view) values (32, (select permission_id from permission where permission = 'devdoc-modifica-stato-aperto'), true);

insert into role_permission(role_id, permission_id, role_view) values (1, (select permission_id from permission where permission = 'devdoc-modifica-stato-consegnato'), true);
insert into role_permission(role_id, permission_id, role_view) values (32, (select permission_id from permission where permission = 'devdoc-modifica-stato-consegnato'), true);

insert into role_permission(role_id, permission_id, role_view) values (1, (select permission_id from permission where permission = 'devdoc-modifica-stato-standby'), true);
insert into role_permission(role_id, permission_id, role_view) values (32, (select permission_id from permission where permission = 'devdoc-modifica-stato-standby'), true);

insert into role_permission(role_id, permission_id, role_view) values (1, (select permission_id from permission where permission = 'devdoc-modifica-stato-annullato'), true);
insert into role_permission(role_id, permission_id, role_view) values (32, (select permission_id from permission where permission = 'devdoc-modifica-stato-annullato'), true);


-- Priorita

delete from role_permission where permission_id in (select permission_id from permission where permission = 'devdoc-priorita') and role_id in (1,32);

