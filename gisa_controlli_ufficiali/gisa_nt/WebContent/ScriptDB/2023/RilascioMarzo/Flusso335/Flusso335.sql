update lookup_tipo_impresa_societa set enabled=false 
where level=1;
update lookup_opu_tipo_impresa set enabled=false 
where code=1; -- rimosso ex impresa individuale
insert into lookup_opu_tipo_impresa(code, description, level, enabled, gruppo,noscia) values
(13,'IMPRESA INDIVIDUALE',0,true,false, true);
insert into lookup_tipo_impresa_societa(code, description, level, enabled, noscia,scia, default_item) values
(18,'IMPRESA INDIVIDUALE',13,true, true, true, false);

