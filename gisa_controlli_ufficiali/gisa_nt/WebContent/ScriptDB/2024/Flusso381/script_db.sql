-- NUOVA tipologia struttura
insert into lookup_tipologia_nodo_oia (description, enabled) values('HUB MICOLOGICO', true);

-- 41 select * from lookup_tipologia_nodo_oia where description ilike '%HUB MICOLOGICO%' 
select * from strutture_asl where id_padre=8 and id_asl = 14 and trashed_date is null and enabled

-- inserimento crr in organigramma
insert into strutture_asl (id, id_padre, id_asl,nome, descrizione_lunga, n_livello, id_utente, entered, entered_by, tipologia_struttura,enabled, obsoleto, confermato, codice_interno_univoco, anno,stato) 
values((select max(id)+1 from strutture_asl),8,14,'HUB MICOLOGICO','HUB MICOLOGICO',1,6567,now(), 6567,40 ,true, false, true, 8, -1,2);

select * from role where enabled and description ilike '%polo didattico%'
insert into role(role_id, role, description, enteredby, entered, modified, modifiedby, role_type, super_ruolo, descrizione_super_ruolo, in_access, in_dpat, in_nucleo_ispettivo,
				enabled, enabled_as_qualifica, view_lista_utenti_nucleo_ispettivo) (select (select max(role_id) +1 from role) , 'HUB MICOLOGICO', 'HUB MICOLOGICO', enteredby, entered, modified, modifiedby, role_type, super_ruolo, descrizione_super_ruolo, in_access, in_dpat, in_nucleo_ispettivo,
				true, enabled_as_qualifica, view_lista_utenti_nucleo_ispettivo from role where role_id= 3366) returning role_id;
				
insert into rel_gruppo_ruoli(id_ruolo,id_gruppo) values(3391,12);




CREATE OR REPLACE VIEW public.lookup_qualifiche
 AS
 SELECT a.code,
    a.description,
    a.short_description,
    a.default_item,
    a.level,
    a.enabled,
    a.carico_default,
    a.peso_per_somma_ui,
    a.in_dpat,
    a.view_lista_utenti_nucleo_ispettivo,
    a.gruppo,
    a.in_nucleo_ispettivo,
    a.livello_qualifiche_dpat,
    a.origine
   FROM ( SELECT role.role_id AS code,
            role.role AS description,
            role.description AS short_description,
            false AS default_item,
                CASE
                    WHEN role.in_dpat = true THEN 1
                    WHEN role.in_dpat = false AND role.super_ruolo = 1 THEN 10
                    WHEN role.super_ruolo = 2 THEN 0
                    ELSE NULL::integer
                END AS level,
            role.enabled_as_qualifica AS enabled,
            role.carico_default,
            role.peso_per_somma_ui,
            role.in_dpat,
            role.view_lista_utenti_nucleo_ispettivo,
            false AS gruppo,
            role.in_nucleo_ispettivo,
            role.livello_qualifiche_dpat,
            10 AS origine
           FROM role
          WHERE role.role_id <> ALL (ARRAY[3365, 3366, 3367, 3368, 3369, 3370, 3373, 3375,3391])
        UNION
         SELECT role.role_id AS code,
            role.role AS description,
            role.description AS short_description,
            false AS default_item,
                CASE
                    WHEN role.in_dpat = true THEN 21
                    WHEN role.in_dpat = false AND role.super_ruolo = 21 THEN 20
                    WHEN role.super_ruolo = 22 THEN 20
                    ELSE NULL::integer
                END + 20001 AS level,
            role.enabled_as_qualifica AS enabled,
            role.carico_default,
            role.peso_per_somma_ui,
            role.in_dpat,
            role.view_lista_utenti_nucleo_ispettivo,
            false AS gruppo,
            role.in_nucleo_ispettivo,
            role.livello_qualifiche_dpat,
            30 AS origine
           FROM role
          WHERE role.role_id = ANY (ARRAY[3365, 3366, 3367, 3368, 3369, 3370, 3373, 3375,3391])
        UNION
         SELECT role.role_id AS code,
            role.role AS description,
            role.description AS short_description,
            false AS default_item,
                CASE
                    WHEN role.in_dpat = true THEN 1
                    WHEN role.in_dpat = false AND role.super_ruolo = 1 THEN 10
                    WHEN role.super_ruolo = 2 THEN 0
                    ELSE NULL::integer
                END + 10001 AS level,
            role.enabled_as_qualifica AS enabled,
            role.carico_default,
            role.peso_per_somma_ui,
            role.in_dpat,
            role.view_lista_utenti_nucleo_ispettivo,
            false AS gruppo,
            role.in_nucleo_ispettivo,
            role.livello_qualifiche_dpat,
            11 AS origine
           FROM role_ext role
          WHERE role.enabled
        UNION
         SELECT 0 AS code,
            'UTENTI ASL'::character varying(80) AS description,
            'UTENTI ASL'::character varying(255) AS short_description,
            false AS default_item,
            0 AS level,
            true AS enabled,
            NULL::integer AS carico_default,
            NULL::integer AS aspeso_per_somma_ui,
            NULL::boolean AS in_dpat,
            NULL::boolean AS view_lista_utenti_nucleo_ispettivo,
            true AS gruppo,
            true AS in_nucleo_ispettivo,
            0 AS livello_qualifiche_dpat,
            0 AS origine
        UNION
         SELECT 1 AS code,
            'UTENTI EXTRA ASL'::character varying(80) AS description,
            'UTENTI EXTRA ASL'::character varying(255) AS short_description,
            false AS default_item,
            10000 AS level,
            true AS enabled,
            NULL::integer AS carico_default,
            NULL::integer AS aspeso_per_somma_ui,
            NULL::boolean AS in_dpat,
            NULL::boolean AS view_lista_utenti_nucleo_ispettivo,
            true AS gruppo,
            true AS in_nucleo_ispettivo,
            1 AS livello_qualifiche_dpat,
            1 AS origine
        UNION
         SELECT 1 AS code,
            'CENTRI DI RIFERIMENTO REGIONALI E POLO DIDATTICO'::character varying(80) AS description,
            'CENTRI DI RIFERIMENTO REGIONALI E POLO DIDATTICO'::character varying(255) AS short_description,
            false AS default_item,
            20000 AS level,
            true AS enabled,
            NULL::integer AS carico_default,
            NULL::integer AS aspeso_per_somma_ui,
            NULL::boolean AS in_dpat,
            NULL::boolean AS view_lista_utenti_nucleo_ispettivo,
            true AS gruppo,
            true AS in_nucleo_ispettivo,
            1 AS livello_qualifiche_dpat,
            1 AS origine) a
  ORDER BY a.code;

ALTER TABLE public.lookup_qualifiche
    OWNER TO postgres;
    
-- script rev 2 di inserimento GUC
select * from dbi_insert_utente_guc('DMRVCN56P13G370T', 'D''Amore', '', true,  7, NULL, 7, 'Inserito da HD per Polo', 'Vincenzo', md5('v.damore_hub_micologico'), 'v.damore_hub_micologico',-1,
'',-1,'','-1','null',-1,-1,
'','',-1,'',0,'','','','','','','',
0, '','', 
    3391, 'HUB MICOLOGICO', -1, '', -1, '', -1, '', -1, '', -1, '',
'-1',-1,'',-1,-1,'');

select * from dbi_insert_utente_guc('CRDLSA57H18I061R', 'Cardinale', '', true, 7, NULL, 7, 'Inserito da HD per Polo', 'Luisa', md5('l.cardinale_hub_micologico'), 'l.cardinale_hub_micologico',-1,
'',-1,'','-1','null',-1,-1,
'','',-1,'',0,'','','','','','','',
0, '','', 
3391, 'HUB MICOLOGICO', -1, '', -1, '', -1, '', -1, '', -1, '',
'-1',-1,'',-1,-1,'');

select * from dbi_insert_utente_guc('CCBGPP61A27H703Z', 'Ciccibello', '', true, 7, NULL, 7, 'Inserito da HD per Polo', 'Giuseppe', md5('g.ciccibello_hub_micologico'), 'g.ciccibello_hub_micologico',-1,
'',-1,'','-1','null',-1,-1,
'','',-1,'',0,'','','','','','','',
0, '','', 
3391, 'HUB MICOLOGICO', -1, '', -1, '', -1, '', -1, '', -1, '',
'-1',-1,'',-1,-1,'');
-- script rev 2 di inserimento GISA
select * from dbi_insert_utente('v.damore_hub_micologico', md5('v.damore_hub_micologico'), 3391,7,7,'1',-1,'Vincenzo', 'D''Amore', 'DMRVCN56P13G370T','Inserito da HD per Polo','-1','null','', NULL,-1,'true','false','true');
select * from dbi_insert_utente('l.cardinale_hub_micologico', md5('l.cardinale_hub_micologico'), 3391,7,7,'1',-1,'Luisa', 'Cardinale', 'CRDLSA57H18I061R','Inserito da HD per Polo','-1','null','', NULL,-1,'true','false','true');
select * from dbi_insert_utente('g.ciccibello_hub_micologico', md5('g.ciccibello_hub_micologico'), 3391,7,7,'1',-1,'Giuseppe', 'Ciccibello', 'CCBGPP61A27H703Z','Inserito da HD per Polo','-1','null','', NULL,-1,'true','false','true');


select 'insert into role_permission(permission_id, role_id, role_view, role_add, role_edit, role_delete) 
values('||permission_id||',3391,'||role_view||','||role_add||','||role_edit||','||role_delete||');'
from role_permission where role_id=3366 and role_view
/*insert into role_permission(permission_id, role_id, role_view, role_add, role_edit, role_delete) 
values (99,3391,true,false, false, false); 
insert into role_permission(permission_id, role_id, role_view, role_add, role_edit, role_delete) 
values (755,3391,true,false, false, false); 
insert into role_permission(permission_id, role_id, role_view, role_add, role_edit, role_delete) 
values (465,3391,true,false, false, false); 
*/
