update lookup_priorita_flusso set enabled = false where code = 1;

update sviluppo_flussi set id_priorita =2 where id_priorita=1

ALTER TABLE public.sviluppo_flussi ADD ambito text NULL;

update sviluppo_flussi set ambito='GISA' where ambito is null or ambito = ''


ALTER TABLE public.sviluppo_flussi ADD giornate_stimate_effort int4 NULL;
ALTER TABLE public.sviluppo_flussi ADD giornate_stimate_elapsed int4 NULL;
ALTER TABLE public.sviluppo_flussi ADD data_inizio_sviluppo timestamp NULL;
ALTER TABLE public.sviluppo_flussi ADD data_previsto_collaudo timestamp NULL;

INSERT INTO public.lookup_stati_flusso
(code, description, default_item, "level", enabled)
VALUES(7, 'SVILUPPO IN CORSO', false, 0, true);

"Giornate stimate effort", "Giornate stimate elapsed", "Data Inizio Sviluppo" e "Data Previsto Collaudo"