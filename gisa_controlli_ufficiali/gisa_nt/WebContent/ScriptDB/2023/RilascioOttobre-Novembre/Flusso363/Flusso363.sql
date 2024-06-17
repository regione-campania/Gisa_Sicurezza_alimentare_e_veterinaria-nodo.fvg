-- FUNCTION: public.refresh_ml_materializzata(integer)

-- DROP FUNCTION IF EXISTS public.refresh_ml_materializzata(integer);

CREATE OR REPLACE FUNCTION public.refresh_ml_materializzata(
	_id_linea integer DEFAULT NULL::integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
BEGIN

delete from ml8_linee_attivita_nuove_materializzata where 1=1 
-- solo le nuove linee 
and id_nuova_linea_attivita in (select id_nuova_linea_attivita from master_list_view)
and (_id_linea is null or id_nuova_linea_attivita = _id_linea);

insert into ml8_linee_attivita_nuove_materializzata (
 id_nuova_linea_attivita, enabled, id_macroarea, id_aggregazione, id_attivita, codice_macroarea, codice_aggregazione, codice_attivita, macroarea, aggregazione,
 attivita, id_norma, norma, codice_norma, descrizione, livello, id_padre, path_id, path_descrizione, codice, path_codice,rev
) select id_nuova_linea_attivita, enabled, id_macroarea, id_aggregazione, id_attivita, codice_macroarea, codice_aggregazione, codice_attivita, macroarea, aggregazione,
 attivita, id_norma, norma, codice_norma, descrizione, livello, id_padre, path_id, path_desc, codice, path_codice, 11 as rev from master_list_view 
 where 1=1
 and (_id_linea is null or id_nuova_linea_attivita = _id_linea);

return 1;

 END;
$BODY$;

ALTER FUNCTION public.refresh_ml_materializzata(integer)
    OWNER TO postgres;
	
--- RQ 1

UPDATE
sintesis_relazione_stabilimento_linee_produttive set id_linea_produttiva = (SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-46-INTP' and rev = 11), note_internal_use_hd_only = concat(note_internal_use_hd_only, ';', '[Flusso 363] Linea mappata. Vecchia linea: ', id_linea_produttiva) 
where id_linea_produttiva in (
SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-1-COLL' and rev <> 11)
and id_stabilimento not in (select id from sintesis_stabilimento where approval_number = 'ABP 5323');

UPDATE
sintesis_relazione_stabilimento_linee_produttive set id_linea_produttiva = (SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-47-INTP' and rev = 11), note_internal_use_hd_only = concat(note_internal_use_hd_only, ';', '[Flusso 363] Linea mappata. Vecchia linea: ', id_linea_produttiva) 
where id_linea_produttiva in (
SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-2-COLL' and rev <> 11)
and id_stabilimento not in (select id from sintesis_stabilimento where approval_number = 'ABP 5323');

UPDATE
sintesis_relazione_stabilimento_linee_produttive set id_linea_produttiva = (SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-48-INTP' and rev = 11), note_internal_use_hd_only = concat(note_internal_use_hd_only, ';', '[Flusso 363] Linea mappata. Vecchia linea: ', id_linea_produttiva) 
where id_linea_produttiva in (
SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-3-COLL' and rev <> 11)
and id_stabilimento not in (select id from sintesis_stabilimento where approval_number = 'ABP 5323');


UPDATE
sintesis_relazione_stabilimento_linee_produttive set id_linea_produttiva = (SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-43-COLL' and rev = 11), note_internal_use_hd_only = concat(note_internal_use_hd_only, ';', '[Flusso 363] Linea mappata. Vecchia linea: ', id_linea_produttiva) 
where id_linea_produttiva in (
SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-1-STORP_T' and rev <> 11)
and id_stabilimento not in (select id from sintesis_stabilimento where approval_number = 'ABP 5323');

UPDATE
sintesis_relazione_stabilimento_linee_produttive set id_linea_produttiva = (SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-44-COLL' and rev = 11), note_internal_use_hd_only = concat(note_internal_use_hd_only, ';', '[Flusso 363] Linea mappata. Vecchia linea: ', id_linea_produttiva) 
where id_linea_produttiva in (
SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-2-STORP_T' and rev <> 11)
and id_stabilimento not in (select id from sintesis_stabilimento where approval_number = 'ABP 5323');

UPDATE
sintesis_relazione_stabilimento_linee_produttive set id_linea_produttiva = (SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-45-COLL' and rev = 11), note_internal_use_hd_only = concat(note_internal_use_hd_only, ';', '[Flusso 363] Linea mappata. Vecchia linea: ', id_linea_produttiva) 
where id_linea_produttiva in (
SELECT id_nuova_linea_attivita FROM ml8_linee_attivita_nuove_materializzata where codice = '1069-R-3-STORP_T' and rev <> 11)
and id_stabilimento not in (select id from sintesis_stabilimento where approval_number = 'ABP 5323');

--- RQ 2

SELECT 
'update master_list_linea_attivita 
set linea_attivita = trim('''||nuova_descrizione||'''), 
note_hd = concat(note_hd, '';'', ''[Flusso 363] Vecchia descrizione: '', linea_attivita) where id = '||id||'; select * from refresh_ml_materializzata('||id||');' 

FROM (
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)' as nuova_descrizione FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-4-STORP' and m.codice_sezione = '1069-R' and a.codice_attivita = '4' and l.codice_prodotto_specie = 'STORP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-5-STORP' and m.codice_sezione = '1069-R' and a.codice_attivita = '5' and l.codice_prodotto_specie = 'STORP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-6-STORP' and m.codice_sezione = '1069-R' and a.codice_attivita = '6' and l.codice_prodotto_specie = 'STORP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OCAFTB COMBUSTIONE DI GRASSO ANIMALE IN UNA CALDAIA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-13-OCAFTB' and m.codice_sezione = '1069-R' and a.codice_attivita = '13' and l.codice_prodotto_specie = 'OCAFTB' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OMSCHY IDROTRATTAMENTO CATALITICO A PIÙ FASI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-13-OMSCHY' and m.codice_sezione = '1069-R' and a.codice_attivita = '13' and l.codice_prodotto_specie = 'OMSCHY' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OCAFTB COMBUSTIONE DI GRASSO ANIMALE IN UNA CALDAIA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-14-OCAFTB' and m.codice_sezione = '1069-R' and a.codice_attivita = '14' and l.codice_prodotto_specie = 'OCAFTB' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OEFP INSILAGGIO DI MATERIALI DI ORIGINE ITTICA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-14-OEFP' and m.codice_sezione = '1069-R' and a.codice_attivita = '14' and l.codice_prodotto_specie = 'OEFP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OLTPPM TRATT. CON CALCE PER IL LETAME DI SUINI E POLLAME' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-14-OLTPPM' and m.codice_sezione = '1069-R' and a.codice_attivita = '14' and l.codice_prodotto_specie = 'OLTPPM' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OMSCHY IDROTRATTAMENTO CATALITICO A PIU FASI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-14-OMSCHY' and m.codice_sezione = '1069-R' and a.codice_attivita = '14' and l.codice_prodotto_specie = 'OMSCHY' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OMSCP PROCESSO CATALITICO A PIÙ FASI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-14-OMSCP' and m.codice_sezione = '1069-R' and a.codice_attivita = '14' and l.codice_prodotto_specie = 'OMSCP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OTMB PRODUZIONE TERMO-MECCANICO DI BIOCOMBUSTIBILE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-14-OTMB' and m.codice_sezione = '1069-R' and a.codice_attivita = '14' and l.codice_prodotto_specie = 'OTMB' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OCAFTB COMBUSTIONE DI GRASSO ANIMALE IN UNA CALDAIA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-15-OCAFTB' and m.codice_sezione = '1069-R' and a.codice_attivita = '15' and l.codice_prodotto_specie = 'OCAFTB' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OEFP INSILAGGIO DI MATERIALI DI ORIGINE ITTICA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-15-OEFP' and m.codice_sezione = '1069-R' and a.codice_attivita = '15' and l.codice_prodotto_specie = 'OEFP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OMSCHY IDROTRATTAMENTO CATALITICO A PIU FASI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-15-OMSCHY' and m.codice_sezione = '1069-R' and a.codice_attivita = '15' and l.codice_prodotto_specie = 'OMSCHY' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OMSCP PROCESSO CATALITICO A PIÙ FASI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-15-OMSCP' and m.codice_sezione = '1069-R' and a.codice_attivita = '15' and l.codice_prodotto_specie = 'OMSCP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OTMB PRODUZIONE TERMO-MECCANICO DI BIOCOMBUSTIBILE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-15-OTMB' and m.codice_sezione = '1069-R' and a.codice_attivita = '15' and l.codice_prodotto_specie = 'OTMB' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  PETPR PETFOOD CHE USA SOLO SOA FRESCHI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-27-PETPR' and m.codice_sezione = '1069-R' and a.codice_attivita = '27' and l.codice_prodotto_specie = 'PETPP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  PETPP PETFOOD CHE USA SOLO SOA TRASFORMATI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-27-PETPP' and m.codice_sezione = '1069-R' and a.codice_attivita = '27' and l.codice_prodotto_specie = 'PETPR' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  TECH PROD TECNICI DIVERSI DA QUELLI SPECIFICATI ALTROVE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-29-TECH' and m.codice_sezione = '1069-R' and a.codice_attivita = '29' and l.codice_prodotto_specie = 'TECH' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  CONTMT USO DI METODI DI CONTENIMENTO' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-30-CONTMT' and m.codice_sezione = '1069-R' and a.codice_attivita = '30' and l.codice_prodotto_specie = 'CONTMT' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  TECH PROD TECNICI DIVERSI DA QUELLI SPECIFICATI ALTROVE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-30-TECH' and m.codice_sezione = '1069-R' and a.codice_attivita = '30' and l.codice_prodotto_specie = 'TECH' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  UEXART UTILIZZO PER MOSTRE E/O ATTIVITA ARTISTICHE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-31-UEXART' and m.codice_sezione = '1069-R' and a.codice_attivita = '31' and l.codice_prodotto_specie = 'UEXART' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  UDOG UTILIZZO PER CANILI E GATTILI O BRANCHI DI SEGUGI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-32-UDOG' and m.codice_sezione = '1069-R' and a.codice_attivita = '32' and l.codice_prodotto_specie = 'UDOG' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  UEXART UTILIZZO PER MOSTRE E/O ATTIVITA ARTISTICHE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-32-UEXART' and m.codice_sezione = '1069-R' and a.codice_attivita = '32' and l.codice_prodotto_specie = 'UEXART' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  UDOG UTILIZZO PER CANILI E GATTILI O BRANCHI DI SEGUGI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-33-UDOG' and m.codice_sezione = '1069-R' and a.codice_attivita = '33' and l.codice_prodotto_specie = 'UDOG' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  UEXART UTILIZZO PER MOSTRE E/O ATTIVITA ARTISTICHE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-33-UEXART' and m.codice_sezione = '1069-R' and a.codice_attivita = '33' and l.codice_prodotto_specie = 'UEXART' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OTHER ALTRE ATTIVITÀ' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-37-OTHER' and m.codice_sezione = '1069-R' and a.codice_attivita = '37' and l.codice_prodotto_specie = 'OTHER' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  PHAR ATTIVITÀ FARMACEUTICHE (INCLUSI I DISPOSITIVI MEDICI)' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-37-PHAR' and m.codice_sezione = '1069-R' and a.codice_attivita = '37' and l.codice_prodotto_specie = 'PHAR' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  TRADE COMMERCIANTI REGISTRATI E SPEDIZIONIERI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-37-TRADE' and m.codice_sezione = '1069-R' and a.codice_attivita = '37' and l.codice_prodotto_specie = 'TRADE' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  TRANS TRASPORTATORI DI SOA E PRODOTTI DERIVATI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-37-TRANS' and m.codice_sezione = '1069-R' and a.codice_attivita = '37' and l.codice_prodotto_specie = 'TRANS' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OFSIBU DISTRIBUTORI DI FERTILIZZANTI ORGANICI O AMMENDANTI SFUSI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-38-OFSIBU' and m.codice_sezione = '1069-R' and a.codice_attivita = '38' and l.codice_prodotto_specie = 'OFSIBU' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OFSIPA DISTRIBUTORI DI FERTILIZZANTI ORGANICI O AMMENDANTI CONFEZIONATI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-38-OFSIPA' and m.codice_sezione = '1069-R' and a.codice_attivita = '38' and l.codice_prodotto_specie = 'OFSIPA' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OTHER ALTRE ATTIVITÀ' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-38-OTHER' and m.codice_sezione = '1069-R' and a.codice_attivita = '38' and l.codice_prodotto_specie = 'OTHER' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  PHAR ATTIVITÀ FARMACEUTICHE (INCLUSI I DISPOSITIVI MEDICI)' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-38-PHAR' and m.codice_sezione = '1069-R' and a.codice_attivita = '38' and l.codice_prodotto_specie = 'PHAR' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  TRADE COMMERCIANTI REGISTRATI E SPEDIZIONIERI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-38-TRADE' and m.codice_sezione = '1069-R' and a.codice_attivita = '38' and l.codice_prodotto_specie = 'TRADE' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  TRANS TRASPORTATORI DI SOA E PRODOTTI DERIVATI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-38-TRANS' and m.codice_sezione = '1069-R' and a.codice_attivita = '38' and l.codice_prodotto_specie = 'TRANS' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  FEEDP MANGIMIFICI CHE UTLIZZANO PROTEINE ANIMALI TRASFORMATE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-39-FEEDP' and m.codice_sezione = '1069-R' and a.codice_attivita = '39' and l.codice_prodotto_specie = 'FEEDP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OFSIBU DISTRIBUTORI DI FERTILIZZANTI ORGANICI O AMMENDANTI SFUSI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-39-OFSIBU' and m.codice_sezione = '1069-R' and a.codice_attivita = '39' and l.codice_prodotto_specie = 'OFSIBU' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OFSIPA DISTRIBUTORI DI FERTILIZZANTI ORGANICI O AMMENDANTI CONFEZIONATI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-39-OFSIPA' and m.codice_sezione = '1069-R' and a.codice_attivita = '39' and l.codice_prodotto_specie = 'OFSIPA' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OTHER ALTRE ATTIVITÀ' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-39-OTHER' and m.codice_sezione = '1069-R' and a.codice_attivita = '39' and l.codice_prodotto_specie = 'OTHER' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  PHAR ATTIVITÀ FARMACEUTICHE (INCLUSI I DISPOSITIVI MEDICI)' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-39-PHAR' and m.codice_sezione = '1069-R' and a.codice_attivita = '39' and l.codice_prodotto_specie = 'PHAR' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  RETAIL COMMERCIANTI AL DETTAGLIO' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-39-RETAIL' and m.codice_sezione = '1069-R' and a.codice_attivita = '39' and l.codice_prodotto_specie = 'RETAIL' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  TRADE COMMERCIANTI REGISTRATI E SPEDIZIONIERI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-39-TRADE' and m.codice_sezione = '1069-R' and a.codice_attivita = '39' and l.codice_prodotto_specie = 'TRADE' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  TRANS TRASPORTATORI DI SOA E PRODOTTI DERIVATI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-39-TRANS' and m.codice_sezione = '1069-R' and a.codice_attivita = '39' and l.codice_prodotto_specie = 'TRANS' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OFSIPP FERTILIZZANTI ORG. O AMMENDANTI DA PROD. DERIVATI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-41-OFSIPP' and m.codice_sezione = '1069-R' and a.codice_attivita = '41' and l.codice_prodotto_specie = 'OFSIPP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  OFSIPP FERTILIZZANTI ORG. O AMMENDANTI DA PROD. DERIVATI' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-42-OFSIPP' and m.codice_sezione = '1069-R' and a.codice_attivita = '42' and l.codice_prodotto_specie = 'OFSIPP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COLL RACCOLTA DI SOA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-43-COLL' and m.codice_sezione = '1069-R' and a.codice_attivita = '43' and l.codice_prodotto_specie = 'COLL' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COLL RACCOLTA DI SOA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-44-COLL' and m.codice_sezione = '1069-R' and a.codice_attivita = '44' and l.codice_prodotto_specie = 'COLL' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COLL RACCOLTA DI SOA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-45-COLL' and m.codice_sezione = '1069-R' and a.codice_attivita = '45' and l.codice_prodotto_specie = 'COLL' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  INTP ATTIVITÀ INTERMEDIE DOPO LA RACCOLTA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-46-INTP' and m.codice_sezione = '1069-R' and a.codice_attivita = '46' and l.codice_prodotto_specie = 'INTP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  INTP ATTIVITÀ INTERMEDIE DOPO LA RACCOLTA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-47-INTP' and m.codice_sezione = '1069-R' and a.codice_attivita = '47' and l.codice_prodotto_specie = 'INTP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  INTP ATTIVITÀ INTERMEDIE DOPO LA RACCOLTA' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-48-INTP' and m.codice_sezione = '1069-R' and a.codice_attivita = '48' and l.codice_prodotto_specie = 'INTP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COIP COINCENERITORE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-49-COIP' and m.codice_sezione = '1069-R' and a.codice_attivita = '49' and l.codice_prodotto_specie = 'COIP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COMBP COMBUSTIONE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-49-COMBP' and m.codice_sezione = '1069-R' and a.codice_attivita = '49' and l.codice_prodotto_specie = 'COMBP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  INCP INCENERITORE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-49-INCP' and m.codice_sezione = '1069-R' and a.codice_attivita = '49' and l.codice_prodotto_specie = 'INCP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COIP COINCENERITORE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-50-COIP' and m.codice_sezione = '1069-R' and a.codice_attivita = '50' and l.codice_prodotto_specie = 'COIP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COMBP COMBUSTIONE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-50-COMBP' and m.codice_sezione = '1069-R' and a.codice_attivita = '50' and l.codice_prodotto_specie = 'COMBP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  INCP INCENERITORE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-50-INCP' and m.codice_sezione = '1069-R' and a.codice_attivita = '50' and l.codice_prodotto_specie = 'INCP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COIP COINCENERITORE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-51-COIP' and m.codice_sezione = '1069-R' and a.codice_attivita = '51' and l.codice_prodotto_specie = 'COIP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  COMBP COMBUSTIONE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-51-COMBP' and m.codice_sezione = '1069-R' and a.codice_attivita = '51' and l.codice_prodotto_specie = 'COMBP' UNION 
SELECT l.id, m.macroarea, a.aggregazione, l.linea_attivita, l.codice_univoco, '  INCP INCENERITORE' FROM master_list_linea_attivita l join master_list_aggregazione a on a.id = l.id_aggregazione join master_list_macroarea m on m.id = a.id_macroarea  where l.rev = 11  and l.codice_univoco = '1069-R-51-INCP' and m.codice_sezione = '1069-R' and a.codice_attivita = '51' and l.codice_prodotto_specie = 'INCP' 
	) aa

-- integrazione 17/10 a seguito di collaudo esterno
select 'update master_list_linea_attivita set 
note_hd='';[Flusso 363] Vecchia descrizione: '||linea_attivita||''',
linea_attivita=''STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)'' 
where linea_attivita ilike ''%MAGAZZINAGGIO PRODOTTI DERIVATI%'' and rev <> 11;select * from refresh_ml_materializzata('||id||');'
from master_list_linea_attivita where linea_attivita ilike '%STORP MAGAZZINAGGIO PRODOTTI DERIVATI%' and rev <> 11;

-- Refresh totale

--select * from master_list_linea_attivita where linea_attivita ilike '%storp magazzinaggio%'

update ml8_linee_attivita_nuove_materializzata set 
descrizione='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
attivita='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION II -MAGAZZINAGGIO CAT. 1->STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)'
where id_nuova_linea_attivita = 40837;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
attivita='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION II -MAGAZZINAGGIO CAT. 2->STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)'
where id_nuova_linea_attivita = 40841;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
attivita='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION II -MAGAZZINAGGIO CAT. 3->STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)'
where id_nuova_linea_attivita = 40843;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
attivita='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION II -Magazzinaggio Cat. 1->STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)'
where id_nuova_linea_attivita = 40211;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
attivita='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION II -Magazzinaggio Cat. 2->STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)'
where id_nuova_linea_attivita = 40216;

update ml8_linee_attivita_nuove_materializzata set 
descrizione='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
attivita='STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)',
path_descrizione='SOTTOPRODOTTI DI ORIGINE ANIMALE E PRODOTTI DERIVATI NON DESTINATI AL CONSUMO UMANO->SECTION II -Magazzinaggio Cat. 3->STORP MAGAZZINAGGIO PRODOTTI DERIVATI (obsoleto)'
where id_nuova_linea_attivita = 40218;

delete from ricerche_anagrafiche_old_materializzata;
insert into ricerche_anagrafiche_old_materializzata (select * from ricerca_anagrafiche);



