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
when _tipopagamento = 'NO' and _rigenerato is true and _numerorate = 1 then ' - RATA UNICA NUOVA' --DI RIGENERAZIONE '||(select count(*) from pagopa_sanzioni_importo_ordinanza where id_sanzione = _idsanzione and trashed_date is null)		  
when _tipopagamento = 'NO' and _rigenerato is true and _numerorate > 1 then ' - RATA '||_indice||' NUOVA '--||(select count(*) from pagopa_sanzioni_importo_ordinanza where id_sanzione = _idsanzione and trashed_date is null)		  
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
