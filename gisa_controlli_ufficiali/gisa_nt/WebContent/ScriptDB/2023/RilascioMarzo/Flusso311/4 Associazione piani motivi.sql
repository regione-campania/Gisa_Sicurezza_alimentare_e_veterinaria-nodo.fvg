select max(code) from lookup_eventi_motivi_cu; --assicurarsi che sia 27

-- Inserisco nuovi eventi 

insert into lookup_eventi_motivi_cu(code, description, codice_evento) values (
28, 
'Biosicurezza SUINI stabulati ALTA', 
'isBioSicurezzaSuiniStabulatiAlta');

insert into lookup_eventi_motivi_cu(code, description, codice_evento) values (
29, 
'Biosicurezza SUINI stabulati BASSA', 
'isBioSicurezzaSuiniStabulatiBassa');

insert into lookup_eventi_motivi_cu(code, description, codice_evento) values (
30, 
'Biosicurezza SUINI semibradi ALTA', 
'isBioSicurezzaSuiniSemibradiAlta');

insert into lookup_eventi_motivi_cu(code, description, codice_evento) values (
31, 
'Biosicurezza SUINI semibradi BASSA', 
'isBioSicurezzaSuiniSemibradiBassa');

select * from rel_motivi_eventi_cu where id_evento_cu = 20;

-- Elimino vecchie relazioni inserite per questo flusso

delete from rel_motivi_eventi_cu where id_evento_cu = 20 and entered > '2023-01-01';

-- Inserisco nuove relazioni

insert into rel_motivi_eventi_cu(id_indicatore, id_evento_cu, enteredby, note_hd, cod_raggrup_ind) values (
(select id from dpat_indicatore_new where alias_indicatore ilike 'b2_H' and anno = 2023),
(select code from lookup_eventi_motivi_cu where codice_evento = 'isBioSicurezzaSuiniStabulatiAlta'),
5885,
'Relazione inserita per flusso 311',
(select cod_raggruppamento from dpat_indicatore_new where alias_indicatore ilike 'b2_H' and anno = 2023)
);


insert into rel_motivi_eventi_cu(id_indicatore, id_evento_cu, enteredby, note_hd, cod_raggrup_ind) values (
(select id from dpat_indicatore_new where alias_indicatore ilike 'b2_g' and anno = 2023),
(select code from lookup_eventi_motivi_cu where codice_evento = 'isBioSicurezzaSuiniStabulatiBassa'),
5885,
'Relazione inserita per flusso 311',
(select cod_raggruppamento from dpat_indicatore_new where alias_indicatore ilike 'b2_g' and anno = 2023)
);


insert into rel_motivi_eventi_cu(id_indicatore, id_evento_cu, enteredby, note_hd, cod_raggrup_ind) values (
(select id from dpat_indicatore_new where alias_indicatore ilike 'b2_L' and anno = 2023),
(select code from lookup_eventi_motivi_cu where codice_evento = 'isBioSicurezzaSuiniSemibradiAlta'),
5885,
'Relazione inserita per flusso 311',
(select cod_raggruppamento from dpat_indicatore_new where alias_indicatore ilike 'b2_L' and anno = 2023)
);


insert into rel_motivi_eventi_cu(id_indicatore, id_evento_cu, enteredby, note_hd, cod_raggrup_ind) values (
(select id from dpat_indicatore_new where alias_indicatore ilike 'b2_i' and anno = 2023),
(select code from lookup_eventi_motivi_cu where codice_evento = 'isBioSicurezzaSuiniSemibradiBassa'),
5885,
'Relazione inserita per flusso 311',
(select cod_raggruppamento from dpat_indicatore_new where alias_indicatore ilike 'b2_i' and anno = 2023)
);

-- Solo se devo ripulire errori precedenti
delete from rel_motivi_eventi_cu where id_evento_cu in (28,29,30,31) 

-- Test
select * from has_evento_motivo_cu('isBioSicurezzaSuiniSemibradiBassa', 12260, -1)



