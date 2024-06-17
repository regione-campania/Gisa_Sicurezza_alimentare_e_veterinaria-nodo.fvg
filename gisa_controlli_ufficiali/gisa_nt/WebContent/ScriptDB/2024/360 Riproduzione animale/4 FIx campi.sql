update linee_mobili_html_fields set ordine_campo = ordine where id_linea in (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where codice = 'CG-NAZ-V-0127' and rev = 11) and enabled ;

