
create or replace view lookup_associazioni_animaliste as 
select t.code  ,    t.description  ,   t.default_item  ,  t.level , t.asl , t.enabled  ,  t.entered ,  t.modified ,  t.partita_iva , t.indirizzo , t.id_specie , t.ragione_sociale  
                  FROM dblink((select * from conf.get_pg_conf('GISA')), 'select t.code  ,    t.description  ,   t.default_item  ,  t.level , t.asl , t.enabled  ,  t.entered ,  t.modified ,  t.partita_iva , t.indirizzo , t.id_specie , t.ragione_sociale    from associazioni_view t') 
                  as t(code integer ,
    description text ,
    default_item boolean ,
    level integer ,
    asl integer ,
    enabled boolean ,
    entered timestamp without time zone ,
    modified timestamp without time zone ,
    partita_iva text ,
    indirizzo text ,
    id_specie integer ,
    ragione_sociale text )
;
