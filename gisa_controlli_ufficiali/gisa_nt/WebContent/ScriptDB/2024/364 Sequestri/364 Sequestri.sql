SELECT problem, tipologiasequestro, codice_articolo from ticket where ticketid in (2060133, 2060134, 2060135) order by problem asc

-- tipologia: 9
-- codice_articolo 4 amministrativo 1 penale 3 sanitario 
-- tipologiadisequestro 1 amministrativo 3 penale 2 sanitario -- e' questo qui

select * from lookup_tipologia_sequestro

-- Table: public.lookup_project_status

-- DROP TABLE IF EXISTS public.lookup_project_status;

CREATE TABLE IF NOT EXISTS public.lookup_codice_articolo
(
    code SERIAL PRIMARY KEY,
    description text,
    default_item boolean DEFAULT 'false',
    level integer DEFAULT 0,
    enabled boolean DEFAULT 'true'
)

insert into lookup_codice_articolo (code, description) values (4, upper('Art. 13 L.689/81 e dell''Art.54 Reg CE 882/04'));
insert into lookup_codice_articolo (code, description) values (3, upper('Artt. 18 e 54 Reg CE 882/04 e dell'' Art.1 L 283/62'));
insert into lookup_codice_articolo (code, description) values (1, upper('Art.354 C.P.P.'));

insert into lookup_codice_articolo (code, description) values (5, upper('art 137-138 reg. UE 2017/625, art. 5 d. lvo 27/2021'));
insert into lookup_codice_articolo (code, description) values (6, upper('Art 13 l 689/81  e art 137-138 reg. UE 2017/625, art. 5 d. lvo 27/2021'));
