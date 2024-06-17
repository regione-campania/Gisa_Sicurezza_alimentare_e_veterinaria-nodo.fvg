-- Genero permesso

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_automatismi',	
'Visualizzazione Link Automatismi PagoPA (SOLO PER TEST! Gli automatismi sono automatici e non sono on demand.)',
true, false, false, false, 9);