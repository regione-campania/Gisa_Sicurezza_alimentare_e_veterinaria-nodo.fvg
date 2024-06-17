insert into permission_category (category, description, level, enabled, active, constant) values ('Gestione PagoPA', 'Gestione PagoPA', 2000, true, true, 3);

update permission set category_id = (select category_id from permission_category where category = 'Gestione PagoPA') where permission_id in (select permission_id from permission where permission = 'gestione_pagopa');

update permission set permission = 'pagopa_gestione', description = 'Visualizzazione bottone Gestione PagoPA', level = 0 where permission = 'gestione_pagopa';

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_genera_processo_verbale',	
'Visualizzazione bottone generazione avvisi di pagamento PagoPA per Processo Verbale',
true, false, false, false, 1);

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_genera_numero_ordinanza',	
'Visualizzazione bottone generazione avvisi di pagamento PagoPA per Numero Ordinanza',
true, false, false, false, 2);

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_modifica_notifica',
'Visualizzazione bottone modifica modalita'' di notifica',
true, false, false, false, 3);

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_annulla_tutto',	
'Visualizzazione bottone Annulla Tutto PagoPA',
true, false, false, false, 4);

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_annulla_singolo',	
'Visualizzazione bottone Annulla Singolo PagoPA (NON ASSEGNARE! IL FLUSSO NON CONSENTE L''ANNULLAMENTO SINGOLO! DISPONIBILE SOLO PER RISOLUZIONE TICKET)',
true, false, false, false, 5);

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_rigenera',	
'Visualizzazione bottone Rigenera PagoPA',
true, false, false, false, 6);

update permission set permission_add = false, permission_edit = false, permission_delete = false where permission_id in (select permission_id from permission where permission = 'pagopa_gestione');


insert into role_permission (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission where permission in ('pagopa_genera_processo_verbale')), true, false, false, false
from role_permission where permission_id in (select permission_id from permission where permission = 'pagopa_gestione') order by role_id asc;

insert into role_permission (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission where permission in ('pagopa_genera_numero_ordinanza')), true, false, false, false
from role_permission where permission_id in (select permission_id from permission where permission = 'pagopa_gestione') order by role_id asc;
				 
insert into role_permission (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission where permission in ('pagopa_modifica_notifica')), true, false, false, false
from role_permission where permission_id in (select permission_id from permission where permission = 'pagopa_gestione') order by role_id asc;
				 
insert into role_permission (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission where permission in ('pagopa_annulla_tutto')), true, false, false, false
from role_permission where permission_id in (select permission_id from permission where permission = 'pagopa_gestione') order by role_id asc;				 

insert into role_permission (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission where permission in ('pagopa_rigenera')), true, false, false, false
from role_permission where permission_id in (select permission_id from permission where permission = 'pagopa_gestione') order by role_id asc;		

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_elimina_singolo',	
'Visualizzazione bottone Elimina Singolo PagoPA (NON ASSEGNARE! IL FLUSSO NON CONSENTE L''ELIMINAZIONE! DISPONIBILE SOLO PER RISOLUZIONE TICKET)',
true, false, false, false, 7);

-- ext

insert into permission_category_ext (category, description, level, enabled, active, constant) values ('Gestione PagoPA', 'Gestione PagoPA', 2000, true, true, 3);

update permission_ext set category_id = (select category_id from permission_category_ext where category = 'Gestione PagoPA') where permission_id in (select permission_id from permission_ext where permission = 'gestione_pagopa');

update permission_ext set permission = 'pagopa_gestione', description = 'Visualizzazione bottone Gestione PagoPA', level = 0 where permission = 'gestione_pagopa';

insert into permission_ext 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category_ext where category = 'Gestione PagoPA'),
'pagopa_genera_processo_verbale',	
'Visualizzazione bottone generazione avvisi di pagamento PagoPA per Processo Verbale',
true, false, false, false, 1);

insert into permission_ext
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category_ext where category = 'Gestione PagoPA'),
'pagopa_genera_numero_ordinanza',	
'Visualizzazione bottone generazione avvisi di pagamento PagoPA per Numero Ordinanza',
true, false, false, false, 2);

insert into permission_ext 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category_ext where category = 'Gestione PagoPA'),
'pagopa_modifica_notifica',
'Visualizzazione bottone modifica modalita'' di notifica',
true, false, false, false, 3);

insert into permission_ext 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category_ext where category = 'Gestione PagoPA'),
'pagopa_annulla_tutto',	
'Visualizzazione bottone Annulla Tutto PagoPA',
true, false, false, false, 4);

insert into permission_ext 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category_ext where category = 'Gestione PagoPA'),
'pagopa_annulla_singolo',	
'Visualizzazione bottone Annulla Singolo PagoPA (NON ASSEGNARE! IL FLUSSO NON CONSENTE L''ANNULLAMENTO SINGOLO! DISPONIBILE SOLO PER RISOLUZIONE TICKET)',
true, false, false, false, 5);

insert into permission_ext 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category_ext where category = 'Gestione PagoPA'),
'pagopa_rigenera',	
'Visualizzazione bottone Rigenera PagoPA',
true, false, false, false, 6);

update permission_ext set permission_add = false, permission_edit = false, permission_delete = false where permission_id in (select permission_id from permission_ext where permission = 'pagopa_gestione');


insert into role_permission_ext (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission_ext where permission in ('pagopa_genera_processo_verbale')), true, false, false, false
from role_permission_ext where permission_id in (select permission_id from permission_ext where permission = 'pagopa_gestione') order by role_id asc;

insert into role_permission_ext (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission_ext where permission in ('pagopa_genera_numero_ordinanza')), true, false, false, false
from role_permission_ext where permission_id in (select permission_id from permission_ext where permission = 'pagopa_gestione') order by role_id asc;
				 
insert into role_permission_ext (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission_ext where permission in ('pagopa_modifica_notifica')), true, false, false, false
from role_permission_ext where permission_id in (select permission_id from permission_ext where permission = 'pagopa_gestione') order by role_id asc;
				 
insert into role_permission_ext (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission_ext where permission in ('pagopa_annulla_tutto')), true, false, false, false
from role_permission_ext where permission_id in (select permission_id from permission_ext where permission = 'pagopa_gestione') order by role_id asc;				 

insert into role_permission_ext (role_id, permission_id, role_view, role_add, role_edit, role_delete)
select role_id, (select permission_id from permission_ext where permission in ('pagopa_rigenera')), true, false, false, false
from role_permission_ext where permission_id in (select permission_id from permission_ext where permission = 'pagopa_gestione') order by role_id asc;		

insert into permission_ext 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category_ext where category = 'Gestione PagoPA'),
'pagopa_elimina_singolo',	
'Visualizzazione bottone Elimina Singolo PagoPA (NON ASSEGNARE! IL FLUSSO NON CONSENTE L''ELIMINAZIONE! DISPONIBILE SOLO PER RISOLUZIONE TICKET)',
true, false, false, false, 7);