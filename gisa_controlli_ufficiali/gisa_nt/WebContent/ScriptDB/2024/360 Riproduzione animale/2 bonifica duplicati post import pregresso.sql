SELECT 

count, concat, 'update linee_mobili_fields_value set enabled = false where 
concat(id_linee_mobili_html_fields, ''_'', coalesce(id_opu_rel_stab_linea, -1), ''_'', coalesce(id_rel_stab_linea, -1), ''_'', indice) = '''||concat||''' and enabled and id not in (select min(id) from linee_mobili_fields_value where concat(id_linee_mobili_html_fields, ''_'', coalesce(id_opu_rel_stab_linea, -1), ''_'', coalesce(id_rel_stab_linea, -1), ''_'', indice) = '''||concat||''' and enabled);'  

FROM (

select 
count(concat(id_linee_mobili_html_fields, '_', coalesce(id_opu_rel_stab_linea, -1), '_', coalesce(id_rel_stab_linea, -1), '_', indice)), 

concat(id_linee_mobili_html_fields, '_', coalesce(id_opu_rel_stab_linea, -1), '_', coalesce(id_rel_stab_linea, -1), '_', indice) 

from linee_mobili_fields_value where enabled and id_linee_mobili_html_fields > 0

group by (concat(id_linee_mobili_html_fields, '_', coalesce(id_opu_rel_stab_linea, -1), '_', coalesce(id_rel_stab_linea, -1), '_', indice))

having count(concat(id_linee_mobili_html_fields, '', coalesce(id_opu_rel_stab_linea, -1), '_', coalesce(id_rel_stab_linea, -1), '_', indice)) > 1

order by count(concat(id_linee_mobili_html_fields, '_', coalesce(id_opu_rel_stab_linea, -1), '_', coalesce(id_rel_stab_linea, -1), '_', indice)) desc

) aa;
