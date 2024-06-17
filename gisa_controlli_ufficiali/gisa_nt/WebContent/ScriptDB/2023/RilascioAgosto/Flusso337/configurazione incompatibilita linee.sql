select concat ('update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, '','', ', (select id_nuova_linea_attivita from ml8_linee_attivita_nuove_materializzata where   rev = 11 and codice =  (case 
     when POSITION('PU' in flag.codice_univoco ) >0 then 
        replace(flag.codice_univoco, 'PU', 'PR')
     else 
         replace(flag.codice_univoco, 'PR', 'PU')
end)) ,') where id_linea = ' || flag.id_linea ||';' ),  ml.id_nuova_linea_attivita, codice_univoco, flag.rev
from master_list_flag_linee_attivita flag
join ml8_linee_attivita_nuove_materializzata ml on ml.id_nuova_linea_attivita = flag.id_linea 
where upper(attivita) in ('PUBBLICO', 'PRIVATO')
order by  codice_univoco, rev 

update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40997) where id_linea = 40050;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40997) where id_linea = 40773;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40997) where id_linea = 40996;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40996) where id_linea = 40051;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40996) where id_linea = 40774;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40996) where id_linea = 40997;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41000) where id_linea = 40054;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41000) where id_linea = 40775;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41000) where id_linea = 40999;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40999) where id_linea = 40055;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40999) where id_linea = 40776;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 40999) where id_linea = 41000;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41003) where id_linea = 40057;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41003) where id_linea = 40779;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41003) where id_linea = 41002;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41002) where id_linea = 40058;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41002) where id_linea = 40780;
update master_list_flag_linee_attivita set incompatibilita = concat(incompatibilita, ',', 41002) where id_linea = 41003;
