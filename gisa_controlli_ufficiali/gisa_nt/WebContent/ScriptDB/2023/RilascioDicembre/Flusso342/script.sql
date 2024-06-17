-- creazione nuove ruoli

-- 1. BIOLOGO - RESPONSABILE STRUTTURA COMPLESSA
select * from public.dbi_insert_ruolo(
	'BIOLOGO - RESPONSABILE STRUTTURA COMPLESSA',
	'BIOLOGO - RESPONSABILE STRUTTURA COMPLESSA',
	19, -- ruolo medico vet-responsabile struttura complessa
	true,
	true,
	true,
	true,
	true);

	select * from public.dbi_insert_ruolo(
	'CHIMICO - RESPONSABILE STRUTTURA COMPLESSA',
	'CHIMICO - RESPONSABILE STRUTTURA COMPLESSA',
	19, -- ruolo medico vet-responsabile struttura complessa
	true,
	true,
	true,
	true,
	true);	
	
select * from public.dbi_insert_ruolo(
	'ALTRO - RESPONSABILE STRUTTURA COMPLESSA',
	'ALTRO - RESPONSABILE STRUTTURA COMPLESSA',
	19, -- ruolo medico vet-responsabile struttura complessa
	true,
	true,
	true,
	true,
	true);

SELECT * from role where role ilike '%complessa%' and enabled
select * from public.dbi_insert_ruolo(
	'BIOLOGO - RESPONSABILE STRUTTURA SEMPLICE',
	'BIOLOGO - RESPONSABILE STRUTTURA SEMPLICE',
	46, -- ruolo medico vet-responsabile struttura SEMPLICE
	true,
	true,
	true,
	true,
	true);

select * from public.dbi_insert_ruolo(
	'CHIMICO - RESPONSABILE STRUTTURA SEMPLICE',
	'CHIMICO - RESPONSABILE STRUTTURA SEMPLICE',
	46, -- ruolo medico vet-responsabile struttura SEMPLICE
	true,
	true,
	true,
	true,
	true);
	
select * from public.dbi_insert_ruolo(
	'ALTRO - RESPONSABILE STRUTTURA SEMPLICE',
	'ALTRO - RESPONSABILE STRUTTURA SEMPLICE',
	46, -- ruolo medico vet-responsabile struttura complessa
	true,
	true,
	true,
	true,
	true);

select * from public.dbi_insert_ruolo(
	'BIOLOGO - RESPONSABILE STRUTTURA SEMPLICE DIPARTIMENTALE',
	'BIOLOGO - RESPONSABILE STRUTTURA SEMPLICE DIPARTIMENTALE',
	98, -- ruolo medico vet-responsabile struttura dipartimentale
	true,
	true,
	true,
	true,
	true);

select * from public.dbi_insert_ruolo(
	'CHIMICO - RESPONSABILE STRUTTURA SEMPLICE DIPARTIMENTALE',
	'CHIMICO - RESPONSABILE STRUTTURA SEMPLICE DIPARTIMENTALE',
	98, -- ruolo medico vet-responsabile struttura dipartimentale
	true,
	true,
	true,
	true,
	true);
	
select * from public.dbi_insert_ruolo(
	'ALTRO - RESPONSABILE STRUTTURA SEMPLICE DIPARTIMENTALE',
	'ALTRO - RESPONSABILE STRUTTURA SEMPLICE DIPARTIMENTALE',
	98, -- ruolo medico vet-responsabile struttura dipartimentale
	true,
	true,
	true,
	true,
	true);

	select * from public.dbi_insert_ruolo(
	'BIOLOGO',
	'BIOLOGO',
	43, -- ruolo medico vet-
	true,
	true,
	true,
	true,
	true);	

select * from public.dbi_insert_ruolo(
	'CHIMICO',
	'CHIMICO',
	43, -- ruolo medico vet-
	true,
	true,
	true,
	true,
	true);

		
select * from public.dbi_insert_ruolo(
	'ALTRO DIRIGENTE',
	'ALTRO DIRIGENTE',
	43, -- ruolo medico vet-
	true,
	true,
	true,
	true,
	true);	
	
select * from public.dbi_insert_ruolo(
	'TECNOLOGO',
	'TECNOLOGO',
	41, -- ruolo tpal-
	true,
	true,
	true,
	true,
	true);	
	
-- gruppo ASL
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3378,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3379,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3380,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3381,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3382,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3383,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3384,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3385,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3386,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3387,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3388,11);
insert into rel_gruppo_ruoli(id_ruolo, id_gruppo) values (3389,11);	
	
-- FINE: ReloadUtentiFinale da lanciare sull'applicativo