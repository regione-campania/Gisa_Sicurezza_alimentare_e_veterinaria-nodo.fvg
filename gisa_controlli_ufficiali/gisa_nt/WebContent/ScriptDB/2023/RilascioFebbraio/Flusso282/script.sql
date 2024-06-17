
update opu_relazione_stabilimento_linee_produttive set escludi_ricerca = null where escludi_ricerca=true;
 
------------------------------- NEW ----------------------
-- Function: public.clona_opu_sintesis_gins(integer, integer, integer)

-- DROP FUNCTION public.clona_opu_sintesis_gins(integer, integer, integer);
-- Function: public.clona_opu_sintesis_gins(integer, integer, integer)

-- DROP FUNCTION public.clona_opu_sintesis_gins(integer, integer, integer);

CREATE OR REPLACE FUNCTION public.clona_opu_sintesis_gins(
    _id_opu_stabilimento integer,
    _id_sintesis_stabilimento integer,
    _id_utente integer)
  RETURNS integer AS
$BODY$
DECLARE 

_id_opu_stabilimento_new integer;
_id_sintesis_indirizzo integer;
_id_asl integer;
_id_opu_indirizzo_new integer;
_id_operatore integer;
_id_toponimo integer;
_via text;
_civico text;
_id_comune integer;
_id_provincia text;
_cap text;
_lat double precision;
_lon double precision;
_alt_id integer;
_id_tipo_pratica integer;
_id_evento integer;
_numero_pratica text;
_id_causale integer;
_nota_pratica text;
_id_pratica integer;
_data_attuale timestamp without time zone;	
_num_registrazione_nuovo text;
_num_registrazione_vecchio text;
BEGIN	

_id_tipo_pratica := 1;
_numero_pratica := '';
_id_causale := 5;
_nota_pratica := 'Inserimento operatore al mercato.';

-- Salvo la data attuale
SELECT now() into _data_attuale;

-- Salvo il vecchio numero di registrazione e il vecchio operatore
select numero_registrazione, id_operatore into _num_registrazione_vecchio, _id_operatore from opu_stabilimento where id = _id_opu_stabilimento;

-- Salvo i dati SINTESIS

SELECT id_indirizzo, id_asl into _id_sintesis_indirizzo, _id_asl from sintesis_stabilimento where id = _id_sintesis_stabilimento;

-- Salvo i dati del nuovo indirizzo

select toponimo, via, civico, comune, provincia, cap, latitudine, longitudine into _id_toponimo, _via, _civico, _id_comune, _id_provincia, _cap, _lat, _lon from sintesis_indirizzo where id = _id_sintesis_indirizzo;

-- Cerco se il nuovo indirizzo esiste già in OPU, altrimenti lo inserisco
SELECT id into _id_opu_indirizzo_new FROM opu_indirizzo where toponimo = _id_toponimo and via ilike _via and civico ilike _civico and comune = _id_comune and provincia = _id_provincia and cap = _cap;

IF _id_opu_indirizzo_new is null THEN
INSERT into opu_indirizzo (toponimo, via, civico, comune, provincia, cap, latitudine, longitudine) values (_id_toponimo, _via, _civico, _id_comune, _id_provincia, _cap, _lat, _lon) returning id INTO _id_opu_indirizzo_new;
END IF;

-- Inserisco lo stabilimento

insert into opu_stabilimento (entered, modified, entered_by, id_operatore, modified_by, id_asl, id_indirizzo, categoria_rischio, stato, tipo_attivita, tipo_carattere, data_inizio_attivita, data_generazione_numero, notes_hd) select _data_attuale, _data_attuale, _id_utente, _id_operatore, _id_utente, _id_asl, _id_opu_indirizzo_new, null, 0, 1, tipo_carattere, data_inizio_attivita, data_generazione_numero, 'INSERITO TRAMITE FUNZIONALITA DI OPERATORE AL MERCATO DA UTENTE '||_id_utente||' IN DATA '||_data_attuale from opu_stabilimento where id = _id_opu_stabilimento returning id into _id_opu_stabilimento_new;
raise info 'ID STABILIMENTO INSERITO: %', _id_opu_stabilimento_new;

-- Genero il numero di registrazione

select opu_genera_numero_registrazione into _num_registrazione_nuovo from  public_functions.opu_genera_numero_registrazione(_id_opu_stabilimento_new);
update opu_stabilimento set numero_registrazione = _num_registrazione_nuovo, data_generazione_numero = _data_attuale where id = _id_opu_stabilimento_new;

-- Inserisco le linee sul nuovo stabilimento

insert into opu_relazione_stabilimento_linee_produttive (id_linea_produttiva, id_stabilimento, stato, data_inizio, modified, modifiedby, numero_registrazione, codice_ufficiale_esistente, codice_nazionale, entered, enteredby, 
codice_univoco_ml, enabled, primario, note_hd, id_linea_produttiva_old ,id_istanza_pre_trasferimento) 
select (select id_linea from master_list_flag_linee_attivita where operatore_mercato and rev=10 and trashed is null), _id_opu_stabilimento_new, 0, _data_attuale, _data_attuale, _id_utente, 
replace(numero_registrazione, _num_registrazione_vecchio, _num_registrazione_nuovo), ''::text, ''::text, _data_attuale, 
_id_utente, (select codice_univoco from master_list_flag_linee_attivita  where operatore_mercato and rev=10 and trashed is null), enabled, primario, 'INSERITA PER OPERATORE AL MERCATO DA UTENTE '||_id_utente||' IN DATA '||_data_attuale, id_linea_produttiva_old , 
id from opu_relazione_stabilimento_linee_produttive where id_stabilimento = _id_opu_stabilimento and enabled limit 1;

-- Refresh ricerca 

perform refresh_anagrafica(_id_opu_stabilimento_new, 'opu');

--modifica per Flusso 282
--perform opu_escludi_da_ricerca(_id_opu_stabilimento_new);

raise WARNING 'id finali: id stab %', _id_opu_stabilimento_new;

--gestione eventi - pratiche
select alt_id into _alt_id from opu_stabilimento where id = _id_opu_stabilimento_new;

--inserisci dati evento
insert into eventi_su_osa(id_stabilimento, alt_id, id_tipo_operazione, entered, enteredby)
values(_id_opu_stabilimento_new, _alt_id, _id_tipo_pratica, _data_attuale, _id_utente)  returning id into _id_evento;

--inserisci pratica non suap
select inserisci_pratica into _numero_pratica from inserisci_pratica(_id_utente, to_char(_data_attuale, 'dd-mm-yyyy'), _id_comune, _id_tipo_pratica, _numero_pratica, _id_causale, _nota_pratica);
		
--recupero id pratica
select id into _id_pratica from pratiche_gins 
	where numero_pratica ilike _numero_pratica and id_comune_richiedente = _id_comune and id_causale = _id_causale and trashed_date is null;

--inserisci dati relazione pratica evento
insert into rel_eventi_pratiche(id_evento,id_pratica,entered,enteredby)
values(_id_evento, _id_pratica, _data_attuale, _id_utente);

return _id_opu_stabilimento_new;
	
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.clona_opu_sintesis_gins(integer, integer, integer)
  OWNER TO postgres;


-- Function: public.update_categoria_rischio_qualitativa_mercati(integer)

-- DROP FUNCTION public.update_categoria_rischio_qualitativa_mercati(integer);
/*
CREATE OR REPLACE FUNCTION public.update_categoria_rischio_qualitativa_mercati(_id_controllo integer)
  RETURNS text AS
$BODY$
DECLARE  
 msg text;  
 tot_cu_mercato integer;
 tot_categorie_cu_mercato integer;
 tot_cu_operatori integer;
 tot_categorie_cu_operatori integer;
 media integer;
 categoria_qualitativa integer;
 id_linea integer;
 _id_stabilimento integer;
 
BEGIN 

categoria_qualitativa = -1;
id_linea = -1;
_id_stabilimento := (
	select mercatostab.alt_id
	from ticket cu
	join sintesis_operatori_mercato rel on rel.riferimento_id_operatore = cu.id_stabilimento and rel.riferimento_id_nome_tab_operatore = 'opu_stabilimento' and rel.trashed_date is null
	join sintesis_stabilimento mercatostab on mercatostab.id = rel.id_stabilimento_sintesis_mercato 
	where cu.trashed_date is null and cu.ticketid = _id_controllo
	);

-- verifico se si tratti di una linea al mercato;
id_linea := (
select ml.id_nuova_linea_attivita
from ticket t
join opu_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = t.id_stabilimento and rel.enabled
join ml8_linee_attivita_nuove_materializzata ml on ml.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on ml.id_nuova_linea_attivita = flag.id_linea
where t.ticketid = _id_controllo and flag.operatore_mercato and t.trashed_date is null);

if id_linea > 0 then 
--tot_cu_mercato : count cu in sorveglianza chiusi con categoria aggiornata sul mercato
--tot_categorie_cu_mercato : sum categoria_rischio dei cu in sorveglianza chiusi con categoria aggiornata sul mercato
--tot_cu_operatori : count cu in sorveglianza chiusi con categoria aggiornata su tutti gli operatori non cancellati associati al mercato
--tot_categorie_cu_operatori : sum categoria_rischio dei cu in sorveglianza chiusi con categoria aggiornata su tutti gli operatori non cancellati associati al mercato

	tot_cu_operatori := (select count(cu.ticketid)
	from ticket cu
	join sintesis_operatori_mercato rel on rel.riferimento_id_operatore = cu.id_stabilimento and rel.riferimento_id_nome_tab_operatore = 'opu_stabilimento' and rel.trashed_date is null
	join sintesis_stabilimento mercatostab on mercatostab.id = rel.id_stabilimento_sintesis_mercato 
	join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
	join opu_stabilimento operatorestab on operatorestab.id = rel.riferimento_id_operatore 
	join opu_operatore operatoreimpr on operatoreimpr.id = operatorestab.id_operatore
	where cu.trashed_date is null 
	and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
	and mercatostab.alt_id = _id_stabilimento);

	tot_categorie_cu_operatori :=(
	select sum(cu.categoria_rischio)
	from ticket cu
	join sintesis_operatori_mercato rel on rel.riferimento_id_operatore = cu.id_stabilimento and rel.riferimento_id_nome_tab_operatore = 'opu_stabilimento' and rel.trashed_date is null
	join sintesis_stabilimento mercatostab on mercatostab.id = rel.id_stabilimento_sintesis_mercato 
	join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
	join opu_stabilimento operatorestab on operatorestab.id = rel.riferimento_id_operatore 
	join opu_operatore operatoreimpr on operatoreimpr.id = operatorestab.id_operatore
	where cu.trashed_date is null 
	and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
	and mercatostab.alt_id = _id_stabilimento
	);

	tot_cu_mercato := (
	select count(cu.ticketid) 
	from ticket cu
	join sintesis_stabilimento mercatostab on mercatostab.alt_id = cu.alt_id 
	join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
	where cu.trashed_date is null 
	and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
	and mercatostab.alt_id = _id_stabilimento);

	tot_categorie_cu_mercato := (select sum(cu.categoria_rischio)  
	from ticket cu
	join sintesis_stabilimento mercatostab on mercatostab.alt_id = cu.alt_id 
	join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
	where cu.trashed_date is null 
	and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
	and mercatostab.alt_id = _id_stabilimento);

	raise info 'cu operatori: %',tot_cu_operatori;
	raise info 'cu mercato: %',tot_cu_mercato;
	raise info 'cat operatori: %',tot_categorie_cu_operatori;
	raise info 'cat mercato: %',tot_categorie_cu_mercato;

	media = ((tot_categorie_cu_mercato + tot_categorie_cu_operatori) / (tot_cu_mercato + tot_cu_operatori));
	raise info 'media: %', media;

	if media <=1 then
		categoria_qualitativa := 91;
	end if;

	if media > 1 and media <= 3 then
		categoria_qualitativa := 92;
	end if;

	if media >=4 then
		categoria_qualitativa := 93;
	end if;

        -- aggiorna sintesis_stabilimento (livello_rischio + note hd con categoria precedente e modifica)
	update sintesis_stabilimento  set notes_hd = concat(notes_hd,'[Utilizzo funzione di aggiornamento categoria rischio qualitativa]','Livello di rischio precedente: ',livello_rischio,'; Livello di rischio attuale:',categoria_qualitativa,'; Modificato il ',current_timestamp,'; Per chiusura cu: ',_id_controllo), livello_rischio = categoria_qualitativa where alt_id = _id_stabilimento;

end if; -- fine if sulla linea al mercato

return categoria_qualitativa;

return msg;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.update_categoria_rischio_qualitativa_mercati(integer)
  OWNER TO postgres;
*/
insert into lookup_tipo_scheda_operatore (code, description, titolo, firma_data, nome_file) values (55, 'Operatore Mercato', 'Scheda Operatore', false, 'SchedaOperatore');

update scheda_operatore_metadati set enabled = false where tipo_operatore = 55;insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','DATA INIZIO ATTIVITA''','','to_char(data_inizio_attivita, ''dd/MM/yyyy'')','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','q','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','DATA INSERIMENTO','','to_char(entered, ''dd/MM/yyyy'')','opu_stabilimento','id = #stabid#','r','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','INSERITO DA','','case when a.user_id > 0 then concat_ws('' '', c.namefirst, c.namelast) when ae.user_id > 0 then concat_ws('' '', ce.namefirst, ce.namelast) end','opu_stabilimento s
left join access_ a on a.user_id = s.entered_by
left join contact_ c on c.contact_id = a.contact_id

left join access_ext_ ae on ae.user_id = s.entered_by
left join contact_ext_ ce on ce.contact_id = ae.contact_id','s.id = #stabid#','s','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','LINEE','','concat( r.attivita, ''<br>'',''
'', rel.numero_registrazione, ''<br>'',''
Data Inizio: '', to_char(rel.data_inizio, ''dd/MM/yyyy''), 
case when rel.data_fine is not null then concat(''<br>'','' 
Data Fine: '', to_char(rel.data_fine, ''dd/MM/yyyy'')) else '''' end, ''<br>'',''
'', c.description)','ricerche_anagrafiche_old_materializzata r
join opu_relazione_stabilimento_linee_produttive rel on rel.id = r.id_linea
left join
opu_lookup_tipologia_carattere c on c.code = rel.tipo_carattere','r.riferimento_id_nome_tab = ''opu_stabilimento'' and r.riferimento_id = #stabid#
','u','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','TIPO ATTIVITA''','','tipo_attivita_descrizione','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','p','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','LISTA LINEE PRODUTTIVE','capitolo','','','','t','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','DATI IMPRESA','capitolo','','','','A','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','TIPO SOC./COOP.','','''''','ricerche_anagrafiche_old_materializzata r','r.riferimento_id_nome_tab = ''opu_stabilimento'' and r.riferimento_id = #stabid#','b','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','NOME/DITTA/RAGIONE SOCIALE/DENOMINAZIONE SOCIALE','','ragione_sociale','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','c','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','PARTITA IVA','','partita_iva','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','d','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','CODICE FISCALE','','codice_fiscale','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','e','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','TITOLARE/RAPPRESENTANTE LEGALE','','nominativo_rappresentante','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','f','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','INDIRIZZO SEDE LEGALE','','concat (t.description, '' '', concat(i.via, i.civico), '', '', r.comune_leg, '', '', r.cap_leg) ','ricerche_anagrafiche_old_materializzata r
join opu_indirizzo i on i.id = r.id_indirizzo_impresa
join lookup_toponimi t on t.code = i.toponimo','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','g','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','DATI STABILIMENTO','capitolo','','','','h','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','ASL','','asl','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','i','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','NUMERO REGISTRAZIONE GISA','','n_reg','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','l','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','INDIRIZZO STABILIMENTO','','concat (t.description, ''  '', concat(i.via,'' '', i.civico), '', '', concat(r.comune,''('', r.provincia_stab,'')''), '', '', r.cap_stab)','ricerche_anagrafiche_old_materializzata r
join opu_indirizzo i on i.id = r.id_sede_operativa
join lookup_toponimi t on t.code = i.toponimo','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','m','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','CATEGORIA DI RISCHIO','','categoria_rischio','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','n','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('55','STATO','','stato','ricerche_anagrafiche_old_materializzata','riferimento_id_nome_tab = ''opu_stabilimento'' and riferimento_id = #stabid#','o','');

update master_list_flag_linee_attivita set categorizzabili  = true where codice_univoco ilike '%merc%';

 delete from ricerche_anagrafiche_old_materializzata;
 insert into ricerche_anagrafiche_old_materializzata  (select * from ricerca_anagrafiche);

 --test 1786115 -- cu su mercato
--1786083 -- cu operatore


CREATE OR REPLACE FUNCTION public.get_tot_cu_e_categorie( _id_operatore integer)
  RETURNS TABLE(totale_cu integer, somma_categorie_rischio integer) AS
$BODY$

DECLARE
	num_cu integer;
	categoria integer;
	id_osa integer;
	res_numero_cu integer;
	res_categoria integer;
	
BEGIN
   -- inizializzo le variabili
num_cu := 0;
categoria := 0;

-- calcola gli operatori associati al mercato
for id_osa in 	
	select distinct riferimento_id_operatore from sintesis_operatori_mercato rel 
	join sintesis_stabilimento s on s.id = rel.id_stabilimento_sintesis_mercato  
	join opu_stabilimento operatorestab on operatorestab.id = rel.riferimento_id_operatore 
	join opu_operatore operatoreimpr on operatoreimpr.id = operatorestab.id_operatore
	where rel.riferimento_id_nome_tab_operatore = 'opu_stabilimento' and rel.trashed_date is null
	and s.trashed_date is null and s.alt_id = _id_operatore 
LOOP
	--raise info 'id_operatore: %', id_osa;

	res_numero_cu := (select count(cu.ticketid)::int 
	from ticket cu
	where cu.trashed_date is null 
	and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
	and cu.id_stabilimento = id_osa);
	
	num_cu = num_cu + res_numero_cu;
	--raise info 'totale num_cu %', num_cu;

	if res_numero_cu > 0 then
		res_categoria := (select cu.categoria_rischio
		from ticket cu
		where cu.trashed_date is null 
		and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
		and cu.id_stabilimento = id_osa);
		categoria = categoria + res_categoria;
		--raise info 'totale cat_totale %', categoria;
	else 
		categoria := categoria;
	end if;
	
        RETURN NEXT;
END LOOP;

	RETURN query  
	select num_cu, categoria;
	--order by 1 desc 
	--limit 1;
END;
 
$BODY$
  LANGUAGE plpgsql VOLATILE STRICT
  COST 100
  ROWS 1000;
ALTER FUNCTION public.get_tot_cu_e_categorie(integer)
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.get_altid_mercato_by_idcu(_id_controllo integer)
  RETURNS integer AS
$BODY$
DECLARE  

_id_mercato integer;

BEGIN 

_id_mercato := -1;

-- se il CU è su un mercato cu.alt_id = alt_id mercato
_id_mercato := (select mercatostab.alt_id
	from ticket cu
	join sintesis_stabilimento mercatostab on mercatostab.alt_id = cu.alt_id 
	join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
	where cu.trashed_date is null 
	and cu.ticketid = _id_controllo);

return _id_mercato;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.get_altid_mercato_by_idcu(integer)
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.get_altid_operatore_mercato_by_idcu(_id_controllo integer)
  RETURNS integer AS
$BODY$
DECLARE  

_id_operatore_mercato integer;

BEGIN 

_id_operatore_mercato := -1;
-- se il CU è su un operatore del mercato allora alt_id mercato = alt_id mercato dell'operatore
_id_operatore_mercato := (
	select mercatostab.alt_id
	from ticket cu
	join sintesis_operatori_mercato rel on rel.riferimento_id_operatore = cu.id_stabilimento and rel.riferimento_id_nome_tab_operatore = 'opu_stabilimento' and rel.trashed_date is null
	join sintesis_stabilimento mercatostab on mercatostab.id = rel.id_stabilimento_sintesis_mercato 
	where cu.trashed_date is null and cu.ticketid = _id_controllo
	);

return _id_operatore_mercato;

END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.get_altid_operatore_mercato_by_idcu(integer)
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION public.update_categoria_rischio_qualitativa_mercati(_id_controllo integer)
  RETURNS text AS
$BODY$
DECLARE  
 msg text;  
 tot_cu_mercato integer;
 tot_categorie_cu_mercato integer;
 tot_cu_operatori integer;
 tot_categorie_cu_operatori integer;
 media integer;
 categoria_qualitativa integer;

 id_linea_operatore_mercato integer;
 id_linea_mercato integer;
 _id_mercato integer;
 _id_operatore_mercato integer;
 _id_stabilimento integer;
 
BEGIN 

categoria_qualitativa = -1;
id_linea_mercato = -1;

-- verifico se si tratti di una linea al mercato;
id_linea_operatore_mercato := (
select ml.id_nuova_linea_attivita
from ticket t
join opu_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = t.id_stabilimento and rel.enabled
join ml8_linee_attivita_nuove_materializzata ml on ml.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on ml.id_nuova_linea_attivita = flag.id_linea
where t.ticketid = _id_controllo and flag.operatore_mercato and t.trashed_date is null);

id_linea_mercato :=(
select ml.id_nuova_linea_attivita
from ticket t
join sintesis_stabilimento s on s.alt_id=t.alt_id and s.trashed_date is null
join sintesis_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = s.id and rel.enabled
join ml8_linee_attivita_nuove_materializzata ml on ml.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on ml.id_nuova_linea_attivita = flag.id_linea
where t.ticketid = _id_controllo and ml.codice ilike 'MS.B-MS.B80-MS.B80.600'
);

-- se il CU è stato effettuato su un operatore al mercato o su un mercato
if (id_linea_operatore_mercato > 0 or id_linea_mercato > 0) then -- vado avanti ad individuare l'osa

          _id_mercato := (select * from public.get_altid_mercato_by_idcu(_id_controllo)); -- sintesis
          _id_operatore_mercato := (select * from public.get_altid_operatore_mercato_by_idcu(_id_controllo)); -- operatore

          if _id_mercato > 0 then -- controlli sul mercato
		_id_stabilimento := _id_mercato;
		
          end if;
          if _id_operatore_mercato > 0 then -- controlli sull'operatore del mercato
		_id_stabilimento := _id_operatore_mercato;
          end if;

	raise info 'id_stabilimento finale: %', _id_stabilimento;

	tot_cu_mercato := (
					select count(cu.ticketid) 
					from ticket cu
					join sintesis_stabilimento mercatostab on mercatostab.alt_id = cu.alt_id 
					join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
					where cu.trashed_date is null 
					and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
					and mercatostab.alt_id = _id_stabilimento
				  );
	tot_categorie_cu_mercato := (
					select sum(cu.categoria_rischio)  
					from ticket cu
					join sintesis_stabilimento mercatostab on mercatostab.alt_id = cu.alt_id 
					join sintesis_operatore mercatoimpr on mercatoimpr.id = mercatostab.id_operatore
					where cu.trashed_date is null 
					and cu.provvedimenti_prescrittivi = 5 and cu.isaggiornata_categoria
					and mercatostab.alt_id = _id_stabilimento
				);
		
		-- calcola per tutti gli operatori associati al mercato la categoria di rischio e il totale cu in sorveglianza
	tot_cu_operatori := (select max(totale_cu) from public.get_tot_cu_e_categorie(_id_stabilimento));
	tot_categorie_cu_operatori := (select max(somma_categorie_rischio) from public.get_tot_cu_e_categorie(_id_stabilimento));

	media = ((tot_categorie_cu_mercato + tot_categorie_cu_operatori) / (tot_cu_mercato + tot_cu_operatori));
	raise info 'media: %', media;

	if media <=1 then
		categoria_qualitativa := 91;
	end if;

	if media > 1 and media <= 3 then
		categoria_qualitativa := 92;
	end if;

	if media >=4 then
		categoria_qualitativa := 93;
	end if;

        -- aggiorna sintesis_stabilimento (livello_rischio + note hd con categoria precedente e modifica)
	update sintesis_stabilimento  set notes_hd = concat(notes_hd,'[Utilizzo funzione di aggiornamento categoria rischio qualitativa]','Livello di rischio precedente: ',livello_rischio,'; Livello di rischio attuale:',livello_rischio,'; Modificato il ',current_timestamp,'; Per chiusura cu: ', 
	_id_controllo), livello_rischio = categoria_qualitativa where alt_id = _id_stabilimento;

end if; -- fine if sulla linea al mercato

return categoria_qualitativa;

return msg;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.update_categoria_rischio_qualitativa_mercati(integer)
  OWNER TO postgres;
  
  
CREATE OR REPLACE FUNCTION public.insert_opu_noscia_indirizzo(
    _nazione integer,
    _id_provincia text,
    _id_comune integer,
    _comune_estero text,
    _toponimo integer,
    _via text,
    _cap text,
    _civico text DEFAULT NULL::text,
    _latitudine double precision DEFAULT NULL::double precision,
    _longitudine double precision DEFAULT NULL::double precision,
    _presso text DEFAULT NULL::text)
  RETURNS integer AS
$BODY$
DECLARE 
	_nazione_testo text;
	_comune_testo text;
	_topon text;
	_id_ind integer;
        
BEGIN	

	select description into _nazione_testo from lookup_nazioni where code = _nazione limit 1;

	--se nazione uguale italia si inserisce l'indirizzo completo
	IF _nazione = 106 THEN
	
		select nome into _comune_testo from comuni1 where id = _id_comune limit 1;
		select description into _topon from lookup_toponimi where code = _toponimo limit 1;
		
		IF _civico is null THEN
			_civico := 'SNC';
		END IF;

		-- new per flusso 282
		if _id_provincia ilike 'null' then
			_id_provincia := (select (cod_provincia::integer)::text from comuni1 where id= _id_comune);
		end if;
                -- fine new
                
		select id into _id_ind from opu_indirizzo 
			where trim(provincia) ilike _id_provincia and
			      comune = _id_comune and
			      toponimo = _toponimo and
			      trim(via) ilike _via and
			      trim(civico) ilike _civico and
			      coalesce(presso,'') ilike coalesce(_presso,'') and
			      latitudine = _latitudine and
			      longitudine = _longitudine limit 1;

		IF _id_ind is null THEN
			insert into opu_indirizzo(via, cap, provincia, nazione, latitudine, longitudine, comune, comune_testo, toponimo, civico, topon, presso)
			values(_via, _cap, _id_provincia, _nazione_testo, _latitudine, _longitudine, _id_comune, _comune_testo, _toponimo, _civico, _topon, _presso) returning id into _id_ind;
		END IF; 
	--se si tratta di un indirizzo estero si inseriscono (come testo) solo la nazione e il comune 
	ELSE
		select id into _id_ind from opu_indirizzo 
			where trim(nazione) ilike trim(_nazione_testo) and trim(comune_testo) ilike trim(_comune_estero) limit 1;
			
		IF _id_ind is null THEN	      
			insert into opu_indirizzo(nazione, comune_testo) values(_nazione_testo, _comune_estero) returning id into _id_ind;
		END IF;
		
	END IF;
	
	return _id_ind;
	      
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.insert_opu_noscia_indirizzo(integer, text, integer, text, integer, text, text, text, double precision, double precision, text)
  OWNER TO postgres;

