--Controllare le funzioni e le viste se sono allineate con ufficiale
insert into permission(category_id, permission_view, permission, enabled, description) values (12, true, 'cooperazione_SINAC', true, 'cooperazione_SINAC') returning permission_id;
insert into role_permission(role_id, role_view, permission_id) values (1,  true, 856);
insert into role_permission(role_id, role_view, permission_id) values (32, true, 856);