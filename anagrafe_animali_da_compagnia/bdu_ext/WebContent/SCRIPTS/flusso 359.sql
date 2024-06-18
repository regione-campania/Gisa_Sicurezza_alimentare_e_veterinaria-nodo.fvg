--req.1
create table blocco_sblocco_canile_log_tentativo_utilizzo(
data_operazione timestamp without time zone ,
user_id integer,
id_animale integer,
id_tipologia_registrazione integer,
id_proprietario integer
);

alter table blocco_sblocco_canile_log_tentativo_utilizzo add column microchip text;

--req.3
--update role_permission set role_edit = false where permission_id = 138 and role_id in (34,18,20);
--update role_permission set role_edit = false where permission_id = 138 and role_id in (24,37);
--update role_permission set role_delete = false where permission_id = 138 and role_id in (24,37,34,18,20);

update evento_html_fields set ordine_campo = (select max(ordine_campo) +1 from evento_html_fields t where t.id_tipologia_evento = id_tipologia_evento)   where id in (276,332,331)

insert into evento_html_fields (id_tipologia_evento, tipo_campo, label_campo, nome_campo,ordine_campo) 
values                         (47, 'text', 'Nome animale', 'nomeAnimale',(select max(ordine_campo) from evento_html_fields where id_tipologia_evento = 47) + 1);

insert into evento_html_fields (id_tipologia_evento, tipo_campo, label_campo, nome_campo,ordine_campo) 
values                         (13, 'text', 'Nome animale', 'nomeAnimale',(select max(ordine_campo) from evento_html_fields where id_tipologia_evento = 13) + 1);

insert into evento_html_fields (id_tipologia_evento, tipo_campo, label_campo, nome_campo,ordine_campo) 
values                         (19, 'text', 'Nome animale', 'nomeAnimale',(select max(ordine_campo) from evento_html_fields where id_tipologia_evento = 19) + 1);

insert into evento_html_fields (id_tipologia_evento, tipo_campo, label_campo, nome_campo,ordine_campo) 
values                         (61, 'text', 'Nome animale', 'nomeAnimale',(select max(ordine_campo) from evento_html_fields where id_tipologia_evento = 61) + 1);

insert into evento_html_fields (id_tipologia_evento, tipo_campo, label_campo, nome_campo,ordine_campo) 
values                         (67, 'text', 'Nome animale', 'nomeAnimale',(select max(ordine_campo) from evento_html_fields where id_tipologia_evento = 67) + 1);



 --Modifiche BDU chieste il 23/10
alter table blocco_sblocco_canile add column motivo_ingresso_uscita integer; 
