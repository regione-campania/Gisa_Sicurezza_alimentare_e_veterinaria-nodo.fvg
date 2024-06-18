--creazione ruolo "Forze dell'Ordine" (role)

SELECT public.dbi_insert_ruolo(
	'Forze dell''Ordine', 
	'Forze dell''Ordine', 
	33
);

--rimozione permessi

delete from role_permission where role_id = 38 and(
permission_id = 130 or permission_id = 131 or permission_id = 134 or permission_id = 135 or permission_id = 154
or permission_id = 560 or permission_id = 589 or permission_id = 592 or permission_id = 593 or permission_id = 140
or permission_id = 12 or permission_id = 563 or permission_id = 561);

--aggiornamento permessi a sola visione

update role_permission
set role_add = false,
role_edit = false,
role_delete = false
where role_id = 38;