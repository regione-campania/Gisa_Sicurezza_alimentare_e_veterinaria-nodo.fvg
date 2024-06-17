

--select * from access where role_id = 19

update access_ set username='m.dalcin' , password = md5('marta') where username='a.guarnieri'; -- contact_id 20257
update contact_ set namelast='Dal Cin', namefirst='Marta', codice_fiscale='' where contact_id = 20257;

update access_ set username='f.pinardi' , password = md5('franco') where username='a.petitto'; -- contact_id 15161
update contact_ set namelast='Pinardi', namefirst='Franco', codice_fiscale='' where contact_id = 15161;

update access_ set username='d.berton' , password = md5('damiano') where username='c.carbone'; -- contact_id 13990
update contact_ set namelast='Berton', namefirst='Damiano', codice_fiscale='' where contact_id = 13990;

--select * from access where role_id = 43

update access_ set username='n.disanto' , password = md5('nunziatina') where username='a.cascone'; -- contact_id 15123
update contact_ set namelast='Di Santo', namefirst='Nunziatina', codice_fiscale='' where contact_id = 15123;

update access_ set username='s.cito' , password = md5('sara') where username='afrancesca'; -- contact_id 15016
update contact_ set namelast='Cito', namefirst='Sara', codice_fiscale='' where contact_id = 15016;

-- TPAL 41
--select * from access where role_id =41
update access_ set username='a.taiariol' , password = md5('angelo') where username='abbatef'; -- contact_id 14837
update contact_ set namelast='Taiariol', namefirst='Angelo', codice_fiscale='' where contact_id = 14837;


update access_ set username='i.brumat', password = md5('irene') where user_id = 1230; --14966
update contact_ set namelast='Brumat', namefirst='Irene', codice_fiscale='' where contact_id = 14966;

update access_ set username='g.dibenedetto', password = md5('gioia') where user_id = 40442; --38262
update contact_ set namelast='Di Benedetto', namefirst='Gioia', codice_fiscale='' where contact_id = 38262;

-- referente regione 27
update role set role='Referente Regione' where role ilike 'responsabile regione'
--select * from access where role_id = 44

update access_ set username='i.poli', password = md5('ivan') where user_id = 40278; --20489
update contact_ set namelast='Poli', namefirst='Ivan', codice_fiscale='' where contact_id = 20489;

update access_ set username='a.peresson', password = md5('andrea') where user_id = 1543; --15308
update contact_ set namelast='Peresson', namefirst='Andrea', codice_fiscale='' where contact_id = 15308;

update access_ set username='m.ricci', role_id = 27, password = md5('martina') where user_id = 6521; --20321
update contact_ set namelast='Ricci', namefirst='Martina', codice_fiscale='' where contact_id = 20321;

update access_ set username='a.savoia', role_id = 27, password = md5('aldo') where user_id = 1588; --15362
update contact_ set namelast='Savoia', namefirst='Aldo', codice_fiscale='' where contact_id = 15362;

update access_ set username='s.zuttion', role_id = 27, password = md5('silvia') where user_id = 40007; --38033
update contact_ set namelast='Zuttion', namefirst='Silvia', codice_fiscale='' where contact_id = 38033;

update access_ set username='m.cainero', role_id = 27, password = md5('martina') where user_id = 39970; --38011
update contact_ set namelast='Cainero', namefirst='Martina', codice_fiscale='' where contact_id = 38011;

update access_ set username='g.giovanatto', role_id = 27, password = md5('graziano') where user_id = 39965; --38008
update contact_ set namelast='Giovanatto', namefirst='Graziano', codice_fiscale='' where contact_id = 38011;

update access_ set username='a.deianni', role_id = 27, password = md5('antonio') where user_id = 40187; --19930
update contact_ set namelast='Deianni', namefirst='Antonio', codice_fiscale='' where contact_id = 19930;

update access_ set username='p.busdon', password = md5('paolo') where user_id = 1188; --14922
update contact_ set namelast='Busdon', namefirst='Paolo', codice_fiscale='' where contact_id = 14922;

update access_ set username='m.bortolosso', password = md5('michela') where user_id = 39567; --37833
update contact_ set namelast='Bortolosso', namefirst='Michela', codice_fiscale='' where contact_id = 37833;

-- Medico veterinario 43
update access_ set username='m.nairi', password = md5('mirko') where user_id = 40402; --38235
update contact_ set namelast='Nairi', namefirst='Mirko', codice_fiscale='' where contact_id = 38235;

update access_ set username='r.riu', password = md5('raffaela') where user_id = 40433; --38235
update contact_ set namelast='Riu', namefirst='Raffaela', codice_fiscale='' where contact_id = 38257;

update access_ set username='d.davanzo', password = md5('domenico') where user_id = 1054; --38235
update contact_ set namelast='Davanzo', namefirst='Domenico', codice_fiscale='' where contact_id = 14782;

-- Medico
update access_ set username='p.delgiudice', role_id=42, password = md5('pietro') where user_id = 1594; --15368
update contact_ set namelast='Del Giudice', namefirst='Pietro', codice_fiscale='' where contact_id = 15368;


