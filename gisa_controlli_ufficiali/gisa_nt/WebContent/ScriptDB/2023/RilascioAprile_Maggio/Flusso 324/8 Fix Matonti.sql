-- FUNCTION: public.pagopa_genera_pagamento(integer, integer, text, text, text, text, integer, integer, boolean, integer)

-- DROP FUNCTION IF EXISTS public.pagopa_genera_pagamento(integer, integer, text, text, text, text, integer, integer, boolean, integer);

CREATE OR REPLACE FUNCTION public.pagopa_genera_pagamento(
	_idsanzione integer,
	_idpagatore integer,
	_importo text,
	_datascadenza text,
	_tipopagamento text,
	_tiporiduzione text,
	_indice integer,
	_numerorate integer,
	_rigenerato boolean,
	_idutente integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE  
idInserito integer;
_causale text;
_datispecifici text;
_identificativotipodovuto text;
_tipoversamento text;
_iud text;
BEGIN 

idInserito:= -1;

IF (_indice<0) THEN
select  COALESCE(max(indice), 0)+1 into _indice from pagopa_pagamenti where id_sanzione = _idsanzione and id_pagatore = _idpagatore and trashed_date is null;
END IF;

_tipoversamento = 'ALL';
_datispecifici = '9/8711980576';
--_identificativotipodovuto = '2040'; --era 1001
SELECT l.codice_tariffa into _identificativotipodovuto from norme_violate_sanzioni n join lookup_norme l on l.code = n.id_norma where n.idticket = _idsanzione;

select concat('PV N. ', t.tipo_richiesta, ' - ', CASE WHEN nucleo.in_dpat THEN 'ASL '::text || asl.description::text ELSE nucleo.description::text END, 

case when _tipopagamento = 'PV' then ' - RATA UNICA' 
when _tipopagamento = 'NO' and _rigenerato is not true and _numerorate = 1 then ' - RATA UNICA'
when _tipopagamento = 'NO' and _rigenerato is not true and _numerorate > 1 then ' - RATA '||_indice||' di '||_numerorate
when _tipopagamento = 'NO' and _rigenerato is true and _numerorate = 1 then ' - RATA UNICA di REGEN '||(select count(*) from pagopa_sanzioni_importo_ordinanza where id_sanzione = _idsanzione and trashed_date is null)		  
when _tipopagamento = 'NO' and _rigenerato is true and _numerorate > 1 then ' - RATA '||_indice||' di REGEN '||(select count(*) from pagopa_sanzioni_importo_ordinanza where id_sanzione = _idsanzione and trashed_date is null)		  
else '' end) 

into _causale from ticket t
left join ticket controllo on controllo.ticketid = t.id_controllo_ufficiale::integer
LEFT JOIN lookup_site_id asl ON asl.code = controllo.site_id
LEFT JOIN nucleo_ispettivo_mv mv_nucleo ON mv_nucleo.id_controllo_ufficiale = controllo.ticketid
LEFT JOIN lookup_qualifiche nucleo ON nucleo.description::text = mv_nucleo.nucleo_ispettivo::text
where t.ticketid = _idsanzione;

select pagopa_genera_identificativo_dovuto into _iud from pagopa_genera_identificativo_dovuto(_idsanzione);

insert into pagopa_pagamenti(id_sanzione, id_pagatore, data_scadenza, importo_singolo_versamento, entered_by, indice, numero_rate, tipo_pagamento, tipo_riduzione, tipo_versamento, identificativo_univoco_dovuto, identificativo_tipo_dovuto, causale_versamento, dati_specifici_riscossione, rigenerato, stato_pagamento)
values (_idsanzione, _idpagatore, _datascadenza, _importo, _idutente, _indice, _numerorate,_tipopagamento, _tiporiduzione, _tipoversamento, _iud, _identificativotipodovuto, _causale, _datispecifici, _rigenerato, 'PAGAMENTO NON INIZIATO') returning id into idInserito;

return '{"idInserito" : '||idInserito||', "IUD" : "'||_iud||'"}';

END 
$BODY$;

ALTER FUNCTION public.pagopa_genera_pagamento(integer, integer, text, text, text, text, integer, integer, boolean, integer)
    OWNER TO postgres;
    
    -- FUNCTION: public.get_pagopa_importi_totali_ordinanza(integer)

-- DROP FUNCTION IF EXISTS public.get_pagopa_importi_totali_ordinanza(integer);

CREATE OR REPLACE FUNCTION public.get_pagopa_importi_totali_ordinanza(
	_id_sanzione integer)
    RETURNS TABLE(importo_totale_richiesto double precision, importo_totale_versato double precision, importo_totale_residuo double precision) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 

importoTotaleRichiesto double precision;
importoTotaleVersato double precision;
importoTotaleResiduo double precision;

begin

importoTotaleRichiesto := 0.0;
importoTotaleVersato := 0.0;
importoTotaleResiduo := 0.0;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] Calcolo importi totali sanzione: %', _id_sanzione;

SELECT importo_totale_versamento into importoTotaleRichiesto from pagopa_sanzioni_importo_ordinanza where id_sanzione = _id_sanzione and trashed_date is null and principale;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleRichiesto: %', importoTotaleRichiesto;

SELECT COALESCE(sum(importo_singolo_versamento::double precision), 0.0) into importoTotaleVersato from pagopa_pagamenti where id_sanzione = _id_sanzione and trashed_date is null and stato_pagamento = 'PAGAMENTO COMPLETATO';

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleVersato: %', importoTotaleVersato;

SELECT (importoTotaleRichiesto-importoTotaleVersato) into importoTotaleResiduo;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleResiduo: %', importoTotaleResiduo;

IF importoTotaleResiduo < 1 THEN
importoTotaleVersato := importoTotaleRichiesto;
importoTotaleResiduo := 0;
RAISE INFO '[get_pagopa_importi_totali_ordinanza] FORZO RESIDUO 0 ESSENDO INFERIORE A 1 EURO';
RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleRichiesto: %', importoTotaleRichiesto;
RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleResiduo: %', importoTotaleResiduo;
END IF;

return query SELECT round(importoTotaleRichiesto::numeric, 2)::double precision, round(importoTotaleVersato::numeric, 2)::double precision, round(importoTotaleResiduo::numeric, 2)::double precision;

end; 
$BODY$;

ALTER FUNCTION public.get_pagopa_importi_totali_ordinanza(integer)
    OWNER TO postgres;

insert into permission 
(category_id, permission, description, permission_view, permission_add, permission_edit, permission_delete, level)
values (
(select category_id from permission_category where category = 'Gestione PagoPA'),
'pagopa_paga_singolo',	
'Visualizzazione bottone Paga Singolo PagoPA (NON ASSEGNARE! IL FLUSSO NON CONSENTE IL PAGAMENTO DA GISA! DISPONIBILE SOLO PER COLLAUDO)',
true, false, false, false, 7);

CREATE OR REPLACE FUNCTION public.pagopa_get_due_avvisi_scaduti_ordinanza()
    RETURNS TABLE(id_sanzione_scaduta integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE STRICT PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

DECLARE
r RECORD;
_r_sanzioni RECORD;
_r_indici RECORD;
_lista_sanzioni text;
_indice_precedente integer;
BEGIN
_lista_sanzioni := '';
_indice_precedente := -1;

FOR _r_sanzioni IN

select
p.id_sanzione, string_agg(p.indice::text, ';' order by p.indice asc) as scaduti
FROM (
SELECT distinct id_sanzione, indice
from pagopa_pagamenti 
where trashed_date is null 
and tipo_pagamento = 'NO' 
and stato_pagamento = 'PAGAMENTO NON INIZIATO' 
and data_scadenza::timestamp without time zone < now()
) p
group by p.id_sanzione

LOOP
        RAISE INFO '[pagopa_get_due_avvisi_scaduti_ordinanza] id_sanzione: %', _r_sanzioni.id_sanzione;
		RAISE INFO '[pagopa_get_due_avvisi_scaduti_ordinanza] scaduti: %', _r_sanzioni.scaduti;
		_indice_precedente := -1;
		FOR _r_indici IN
		SELECT * from unnest(string_to_array(_r_sanzioni.scaduti, ';')) as indice
		LOOP
				RAISE INFO '[pagopa_get_due_avvisi_scaduti_ordinanza] indice: %', _r_indici.indice;
				IF _r_indici.indice::integer = (_indice_precedente +1) THEN
					RAISE INFO '[pagopa_get_due_avvisi_scaduti_ordinanza] due indici consecutivi scaduti!';
					_lista_sanzioni := _lista_sanzioni ||_r_sanzioni.id_sanzione||';';
				END IF;
				EXIT WHEN _r_indici.indice::integer = (_indice_precedente +1);
				_indice_precedente := _r_indici.indice;
	END LOOP;
		
END LOOP;
RAISE INFO '[pagopa_get_due_avvisi_scaduti_ordinanza] lista_sanzioni: %', _lista_sanzioni;

FOR
id_sanzione_scaduta

in

SELECT * from(
SELECT * from unnest(string_to_array(_lista_sanzioni, ';'))
) l where l.unnest <> ''	

    LOOP
        RETURN NEXT;
     END LOOP;
     RETURN;
 END;
$BODY$;

alter table pagopa_sanzioni_importo_ordinanza add column possibilita_rigenera boolean default true;

 drop FUNCTION public.get_pagopa_importi_totali_ordinanza(
	_id_sanzione integer);
	
CREATE OR REPLACE FUNCTION public.get_pagopa_importi_totali_ordinanza(
	_id_sanzione integer)
    RETURNS TABLE(importo_totale_richiesto double precision, importo_totale_versato double precision, importo_totale_residuo double precision, possibilita_rigenera boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 

importoTotaleRichiesto double precision;
importoTotaleVersato double precision;
importoTotaleResiduo double precision;
possibilitaRigenera boolean;

begin

importoTotaleRichiesto := 0.0;
importoTotaleVersato := 0.0;
importoTotaleResiduo := 0.0;
possibilitaRigenera := true;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] Calcolo possibilita rigenera sanzione: %', _id_sanzione;

SELECT o.possibilita_rigenera into possibilitaRigenera from pagopa_sanzioni_importo_ordinanza o where o.id_sanzione = _id_sanzione and o.trashed_date is null and o.principale;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] Calcolo importi totali sanzione: %', _id_sanzione;

SELECT importo_totale_versamento into importoTotaleRichiesto from pagopa_sanzioni_importo_ordinanza where id_sanzione = _id_sanzione and trashed_date is null and principale;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleRichiesto: %', importoTotaleRichiesto;

SELECT COALESCE(sum(importo_singolo_versamento::double precision), 0.0) into importoTotaleVersato from pagopa_pagamenti where id_sanzione = _id_sanzione and trashed_date is null and stato_pagamento = 'PAGAMENTO COMPLETATO';

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleVersato: %', importoTotaleVersato;

SELECT (importoTotaleRichiesto-importoTotaleVersato) into importoTotaleResiduo;

RAISE INFO '[get_pagopa_importi_totali_ordinanza] importoTotaleResiduo: %', importoTotaleResiduo;

return query SELECT round(importoTotaleRichiesto::numeric, 2)::double precision, round(importoTotaleVersato::numeric, 2)::double precision, round(importoTotaleResiduo::numeric, 2)::double precision, possibilitaRigenera;

end; 
$BODY$;



