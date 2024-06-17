update scheda_operatore_metadati set enabled = false where tipo_operatore = 32;insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','CATEGORIA DI RISCHIO QUALITATIVA SOA','','cat.description','sintesis_stabilimento s left join lookup_categoria_rischio cat on cat.code= s.livello_rischio','s.alt_id=#altid# and s.id in (select s.id from sintesis_relazione_stabilimento_linee_produttive rel
join sintesis_stabilimento s on s.id = rel.id_stabilimento
join ml8_linee_attivita_nuove_materializzata linee on linee.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on linee.id_nuova_linea_attivita = flag.id_linea
join opu_lookup_norme_master_list norme on norme.code = linee.id_norma
where (norme.codice_norma ilike ''1069-09'' or flag.mercato) and s.alt_id = #altid# limit 1)','NC','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','ASL','asl','asl.description','sintesis_stabilimento s join lookup_site_id asl on asl.code = s.id_asl','s.alt_id=#altid#','NN','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Lista prodotti','','concat_ws('' -> '', ''<b>''||tit_scheda||''<b/>'', lista_prodotti) from(
select distinct s.tit_scheda, string_agg(s.nome || case when p.valore_prodotto <>'''' then ''(''||p.valore_prodotto||'')'' else '''' end, ''; '') as lista_prodotti','master_list_sk_elenco s
join sintesis_prodotti p on s.id = p.id_prodotto
join sintesis_relazione_stabilimento_linee_produttive rel on rel.id = p.id_linea
join sintesis_stabilimento st on st.id = rel.id_stabilimento','st.alt_id = #altid# and p.unchecked_date is null
group by tit_scheda
) aa
','R','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Dati Impresa','capitolo','','','','A','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Ragione sociale impresa','','o.ragione_sociale','sintesis_stabilimento s join sintesis_operatore o on s.id_operatore = o.id','s.alt_id=#altid#','AA','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Tipo Impresa','','i.description','sintesis_stabilimento s join sintesis_operatore o on s.id_operatore = o.id join lookup_opu_tipo_impresa i on o.tipo_impresa = i.code','s.alt_id=#altid#','b','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Tipo Societa','','i.description','sintesis_stabilimento s join sintesis_operatore o on s.id_operatore = o.id join lookup_opu_tipo_impresa_societa i on o.tipo_societa = i.code','s.alt_id=#altid#','c','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Partita IVA','','o.partita_iva','sintesis_stabilimento s join sintesis_operatore o on s.id_operatore = o.id','s.alt_id=#altid#','d','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Domicilio digitale','','o.domicilio_digitale','sintesis_stabilimento s join sintesis_operatore o on s.id_operatore = o.id','s.alt_id=#altid#','f','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Rappresentante legale','',' concat_ws('' '', sogg.nome, sogg.cognome, sogg.codice_fiscale, ''<br/>'', top.description, ind.via, ind.civico, com.nome, prov.description)',' sintesis_stabilimento s join sintesis_operatore o on s.id_operatore = o.id join sintesis_rel_operatore_soggetto_fisico rel on rel.id_operatore = o.id and rel.enabled and rel.data_fine is null left join sintesis_soggetto_fisico sogg on sogg.id = rel.id_soggetto_fisico left join sintesis_indirizzo ind on ind.id = sogg.indirizzo_id
 left join lookup_toponimi top on top.code = ind.toponimo
  left join comuni1 com on com.id = ind.comune
  left join lookup_province prov on prov.code::text = ind.provincia','s.alt_id=#altid#','h','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Dati Stabilimento','capitolo','','','','i','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Denominazione','','s.denominazione','sintesis_stabilimento s','s.alt_id=#altid#','l','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Stato','','stati.description','lookup_stato_stabilimento_sintesis stati left join sintesis_stabilimento s on s.stato = stati.code','s.alt_id=#altid#','m','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Approval number','barcode','s.approval_number','sintesis_stabilimento s','s.alt_id=#altid#','n','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Indirizzo','','concat(
top.description, 
'' '',
ind.via, 
'',  '',
ind.civico, 
'', '',
com.nome, 
'' ('',
prov.description, 
'') '',
ind.cap, 
''; Lat:  '',
ind.latitudine, 
'' Lon:  '',
ind.longitudine)','  sintesis_stabilimento s join sintesis_indirizzo ind on ind.id = s.id_indirizzo
  left join lookup_toponimi top on top.code = ind.toponimo
  left join comuni1 com on com.id = ind.comune
  left join lookup_province prov on prov.code::text = ind.provincia','s.alt_id=#altid#','o','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Lista linee produttive','capitolo','','','','p','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Codice Fiscale Impresa','','o.codice_fiscale_impresa','sintesis_stabilimento s join sintesis_operatore o on s.id_operatore = o.id','s.alt_id=#altid#','e','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','CUN SINVSA','','c.cun_sinvsa',' sintesis_stabilimento s inner join cun_amr c on c.numero_registrazione ilike s.approval_number','s.alt_id=#altid#','N0','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','CATEGORIA DI RISCHIO QUANTITATIVA MERCATO','','coalesce(categoria_rischio,3)','sintesis_stabilimento s','s.alt_id=#altid# and s.id in (select s.id from sintesis_relazione_stabilimento_linee_produttive rel
join sintesis_stabilimento s on s.id = rel.id_stabilimento
join ml8_linee_attivita_nuove_materializzata linee on linee.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on linee.id_nuova_linea_attivita = flag.id_linea
where flag.mercato)','NA','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Indirizzo sede legale','',' concat_ws('' '', top.description, ind.via, ind.civico, com.nome, prov.description)','  sintesis_stabilimento s join sintesis_operatore o on s.id_operatore = o.id join sintesis_indirizzo ind on ind.id = o.id_indirizzo
  left join lookup_toponimi top on top.code = ind.toponimo
  left join comuni1 com on com.id = ind.comune
  left join lookup_province prov on prov.code::text = ind.provincia','s.alt_id=#altid#','g','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','DATA PROSSIMO CONTROLLO ','','''NON PREVISTA''','sintesis_stabilimento s','s.alt_id=#altid# and s.id in (select s.id from sintesis_relazione_stabilimento_linee_produttive rel
join sintesis_stabilimento s on s.id = rel.id_stabilimento
join ml8_linee_attivita_nuove_materializzata linee on linee.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on linee.id_nuova_linea_attivita = flag.id_linea
join opu_lookup_norme_master_list norme on norme.code = linee.id_norma
where (norme.codice_norma ilike ''1069-09'') and s.alt_id = #altid# limit 1)','ND','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Linee produttive ','','concat(ml8.macroarea, ''-><br/>  '', ml8.aggregazione, ''-><br/>    '', ml8.attivita, ''<br/>Stato: <b>'', stati.description, ''</b>'', 
case 
	   when rel.id_ultimo_controllo_sorveglianza > 0 then concat(''<br/>Categoria di rischio: <b>'', sorv.categoria_rischio, ''</b> CATEGORIZZATO DA CU: <b><a style="text-decoration: none" href="Vigilanza.do?command=TicketDetails&id='',sorv.ticketid , ''">'' ,sorv.ticketid, ''</a></b>'') 
	   when rel.id_ultimo_controllo_sorveglianza is null then concat(''<br/>Categoria di rischio: <b>'', flag.categoria_rischio_default, ''</b>'') 
	   end)','sintesis_relazione_stabilimento_linee_produttive rel join sintesis_stabilimento s on s.id = rel.id_stabilimento 
join ml8_linee_attivita_nuove_materializzata ml8 on ml8.id_nuova_linea_attivita = rel.id_linea_produttiva
join master_list_flag_linee_attivita flag on ml8.id_nuova_linea_attivita = flag.id_linea
left join lookup_stato_attivita_sintesis stati on stati.code = rel.stato
left join ticket sorv on sorv.ticketid = rel.id_ultimo_controllo_sorveglianza','s.alt_id=#altid# and rel.enabled and s.alt_id not in (select r.riferimento_id from ricerche_anagrafiche_old_materializzata r join opu_lookup_norme_master_list norme on norme.code = r.id_norma where riferimento_id_nome_tab = ''sintesis_stabilimento'' and norme.codice_norma ilike  ''1069-09'')
and s.alt_id not in (select r.riferimento_id from ricerche_anagrafiche_old_materializzata r join master_list_flag_linee_attivita flag on r.id_attivita = flag.id_linea where r.riferimento_id_nome_tab = ''sintesis_stabilimento'' and flag.mercato)

order by ml8.id_nuova_linea_attivita asc','QQ','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','Linee produttive','','mac.macroarea || ''->'' || agg.aggregazione || ''->'' || linea.linea_attivita  || '' ['' || stati.description || '']''','sintesis_relazione_stabilimento_linee_produttive rel join sintesis_stabilimento s on s.id = rel.id_stabilimento 
join master_list_linea_attivita linea on linea.id = rel.id_linea_produttiva
join master_list_aggregazione agg on linea.id_aggregazione = agg.id
join master_list_macroarea mac on agg.id_macroarea = mac.id
left join lookup_stato_attivita_sintesis stati on stati.code = rel.stato','s.alt_id=#altid# and rel.enabled and (s.alt_id in (select r.riferimento_id from ricerche_anagrafiche_old_materializzata r join opu_lookup_norme_master_list norme on norme.code = r.id_norma where riferimento_id_nome_tab = ''sintesis_stabilimento'' and norme.codice_norma ilike  ''1069-09'')
or s.alt_id in (select r.riferimento_id from ricerche_anagrafiche_old_materializzata r join master_list_flag_linee_attivita flag on r.id_attivita = flag.id_linea where r.riferimento_id_nome_tab = ''sintesis_stabilimento'' and flag.mercato))','q','');insert into scheda_operatore_metadati(tipo_operatore, label, attributo, sql_campo, sql_origine, sql_condizione, ordine, destinazione) values ('32','CATEGORIA DI RISCHIO QUALITATIVA','','cat.categoria_qualitativa','sintesis_stabilimento s
join cl_23.sorv_parametrizzazioni_categoria cat on cat.id = s.categoria_qualitativa','s.alt_id=#altid# and s.alt_id not in (select r.riferimento_id from ricerche_anagrafiche_old_materializzata r join opu_lookup_norme_master_list norme on norme.code = r.id_norma where riferimento_id_nome_tab = ''sintesis_stabilimento'' and norme.codice_norma ilike  ''1069-09'')
and s.alt_id not in (select r.riferimento_id from ricerche_anagrafiche_old_materializzata r join master_list_flag_linee_attivita flag on r.id_attivita = flag.id_linea where r.riferimento_id_nome_tab = ''sintesis_stabilimento'' and flag.mercato)','NAA','');

-- aggiornamento di tutto il pregresso opu
    with cte_ext as (
	with cte_int as	(
		 select t.assigned_date, t.ticketid as id_controllo,
			t.categoria_rischio, (select description from lookup_categoria_rischio where code = t.livello_rischio) as livello_rischio, t.data_prossimo_controllo,
			case 	when t.alt_id > 0 then t.alt_id
				when t.id_stabilimento > 0 then t.id_stabilimento
				when t.id_apiario > 0 then t.id_apiario
				when t.org_id > 0 then t.org_id end as riferimento_id ,
		      case 	when t.alt_id > 0 then (select return_nome_tabella from gestione_id_alternativo(t.alt_id,-1))
				when t.id_stabilimento > 0 then 'opu_stabilimento'
				when t.id_apiario > 0 then 'apicoltura_imprese'
				when t.org_id > 0 then 'organization' end as
			riferimento_nome_tab
		 from ticket t
		 where t.tipologia=3 and trashed_date is null and t.provvedimenti_prescrittivi=5 and t.closed is not null
		 --group by ticketid , riferimento_id, riferimento_nome_tab
		 order by riferimento_id, riferimento_nome_tab, assigned_date desc
	)
	      select distinct on (riferimento_id, riferimento_nome_tab)
	        id_controllo,
	        riferimento_id,
	        riferimento_nome_tab,
	        data_prossimo_controllo,
	        assigned_date,
		categoria_rischio,
		livello_rischio,
		id_controllo as id_controllo_ultima_categorizzazione,
		assigned_date as data_controllo_ultima_categorizzazione,
		case when id_controllo is null then 'EX ANTE' ELSE 'CATEGORIZZATO DA CU' end as tipo_categorizzazione
		from cte_int
	) 
    select distinct -- aggiunta della distinct 
	'update opu_relazione_stabilimento_linee_produttive set 
	note_internal_use_hd_only= concat_ws(''-'',note_internal_use_hd_only,''Flusso 329: aggiornamento pregresso della categorizzazione su linea dello stabilimento.''), 
	id_ultimo_controllo_sorveglianza='||l.id_controllo||' where id_stabilimento='||v.riferimento_id||';
	update opu_stabilimento set notes_hd=concat_ws(''-'',notes_hd,''Flusso 329: aggiornamento pregresso della categorizzazione su linea dello stabilimento.''), 
	categoria_qualitativa='||case when l.id_controllo is null then coalesce(l.categoria_rischio,v.categoria_rischio) else l.categoria_rischio end ||' where id= '||v.riferimento_id||';',
	v.riferimento_id ,
	v.riferimento_id_nome_tab ,
	case when l.id_controllo is null then coalesce(l.categoria_rischio,v.categoria_rischio) else l.categoria_rischio end as categoria_rischio, -- integrazione per gestione categoria di rischio EX ANTE
	l.data_prossimo_controllo as prossimo_controllo,
	l.id_controllo as id_controllo_ultima_categorizzazione,
	l.assigned_date as data_controllo_ultima_categorizzazione,
        case when l.id_controllo is null then 'EX ANTE' ELSE 'CATEGORIZZATO DA CU' end as tipo_categorizzazione,
        v.data_inserimento,
        l.livello_rischio
    from ricerche_anagrafiche_old_materializzata v 
        left join cte_ext l on l.riferimento_id  = v.riferimento_id and l.riferimento_nome_tab = v.riferimento_id_nome_tab
    where v.data_inserimento between '1990-01-01' and '2023-12-31'
	and tipo_categorizzazione <> 'EX ANTE'
	and riferimento_id_nome_tab='opu_stabilimento';
	--	and v.riferimento_id not in (select id from opu_stabilimento where categoria_qualitativa > 0) --149828 aggiornati


-- aggiornamento sintesis
with cte_ext as (
	with cte_int as	(
		 select t.assigned_date, t.ticketid as id_controllo,
			t.categoria_rischio, (select description from lookup_categoria_rischio where code = t.livello_rischio) as livello_rischio, t.data_prossimo_controllo,
			case 	when t.alt_id > 0 then t.alt_id
				when t.id_stabilimento > 0 then t.id_stabilimento
				when t.id_apiario > 0 then t.id_apiario
				when t.org_id > 0 then t.org_id end as riferimento_id ,
		      case 	when t.alt_id > 0 then (select return_nome_tabella from gestione_id_alternativo(t.alt_id,-1))
				when t.id_stabilimento > 0 then 'opu_stabilimento'
				when t.id_apiario > 0 then 'apicoltura_imprese'
				when t.org_id > 0 then 'organization' end as
			riferimento_nome_tab
		 from ticket t
		 where t.tipologia=3 and trashed_date is null and t.provvedimenti_prescrittivi=5 and t.closed is not null
		 --group by ticketid , riferimento_id, riferimento_nome_tab
		 order by riferimento_id, riferimento_nome_tab, assigned_date desc
	)
	      select distinct on (riferimento_id, riferimento_nome_tab)
	        id_controllo,
	        riferimento_id,
	        riferimento_nome_tab,
	        data_prossimo_controllo,
	        assigned_date,
		categoria_rischio,
		livello_rischio,
		id_controllo as id_controllo_ultima_categorizzazione,
		assigned_date as data_controllo_ultima_categorizzazione,
		case when id_controllo is null then 'EX ANTE' ELSE 'CATEGORIZZATO DA CU' end as tipo_categorizzazione
		from cte_int
	) 
    select distinct -- aggiunta della distinct 
	'update sintesis_relazione_stabilimento_linee_produttive set 
	note_internal_use_hd_only= concat_ws(''-'',note_internal_use_hd_only,''Flusso 329: aggiornamento pregresso della categorizzazione su linea dello stabilimento.''), 
	id_ultimo_controllo_sorveglianza='||l.id_controllo||' where id_stabilimento='||(select return_id from public.gestione_id_alternativo(v.riferimento_id,-1))||';
	update sintesis_stabilimento set notes_hd=concat_ws(''-'',notes_hd,''Flusso 329: aggiornamento pregresso della categorizzazione su linea dello stabilimento.''), 
	categoria_qualitativa='||case when l.id_controllo is null then coalesce(l.categoria_rischio,v.categoria_rischio) else l.categoria_rischio end ||' where alt_id= '||v.riferimento_id||';',
	v.riferimento_id ,
	v.riferimento_id_nome_tab ,
	v.norma,
	case when l.id_controllo is null then coalesce(l.categoria_rischio,v.categoria_rischio) else l.categoria_rischio end as categoria_rischio, -- integrazione per gestione categoria di rischio EX ANTE
	l.data_prossimo_controllo as prossimo_controllo,
	l.id_controllo as id_controllo_ultima_categorizzazione,
	l.assigned_date as data_controllo_ultima_categorizzazione,
        case when l.id_controllo is null then 'EX ANTE' ELSE 'CATEGORIZZATO DA CU' end as tipo_categorizzazione,
        v.data_inserimento,
        l.livello_rischio
    from ricerche_anagrafiche_old_materializzata v 
        left join cte_ext l on l.riferimento_id  = v.riferimento_id and l.riferimento_nome_tab = v.riferimento_id_nome_tab
    where v.data_inserimento between '1990-01-01' and '2023-12-31'
	and tipo_categorizzazione <> 'EX ANTE'
	and riferimento_id_nome_tab='sintesis_stabilimento'
	and norma <> 'REG CE 1069-09';


delete from ricerche_anagrafiche_old_materializzata;
insert into ricerche_anagrafiche_old_materializzata (select * from ricerca_anagrafiche);

-- query per effettuare update massivo su categoria qualitativa OPU
--stabilimenti con linee categorizzabili (143817 opu)
select distinct r.riferimento_id
,'update opu_stabilimento set notes_hd=concat_ws(''-'',notes_hd,''Flusso 329: aggiornamento pregresso della categorizzazione qualitativa dello stabilimento.''), 
	categoria_qualitativa='||(select  case when c.id = 9 then 2 when c.id=10 then 4 when c.id=11 then 5 else 2 end from 
								sorv_categoria_qualitativa(riferimento_id, riferimento_id_nome_tab) s
								left join cl_23.sorv_parametrizzazioni_categoria_qualitativa c on c.categoria = s.categoria_qualitativa)||' 
								where id= '||riferimento_id||';'
from ricerche_anagrafiche_old_materializzata r
join master_list_flag_linee_attivita m on m.id_linea = r.id_attivita and m.categorizzabili
where riferimento_id_nome_tab='opu_stabilimento' 
and r.riferimento_id not in (select id_stabilimento from ticket
							where trashed_date is null and provvedimenti_prescrittivi=5 and closed is not null
							and tipologia=3 and id_stabilimento > 0)
							
--stabilimenti con linee categorizzabili (672 sintesis)
select distinct r.riferimento_id
,'update sintesis_stabilimento set notes_hd=concat_ws(''-'',notes_hd,''Flusso 329: aggiornamento pregresso della categorizzazione qualitativa dello stabilimento.''), 
categoria_qualitativa='||(select  case when c.id = 9 then 2 when c.id=10 then 4 when c.id=11 then 5 else 2 end from 
							sorv_categoria_qualitativa(riferimento_id, riferimento_id_nome_tab) s
								left join cl_23.sorv_parametrizzazioni_categoria_qualitativa c on c.categoria = s.categoria_qualitativa)||' 
							where alt_id= '||riferimento_id||';'
from ricerche_anagrafiche_old_materializzata r
join master_list_flag_linee_attivita m on m.id_linea = r.id_attivita and m.categorizzabili
where riferimento_id_nome_tab='sintesis_stabilimento'
and r.riferimento_id not in (select alt_id from ticket
							where trashed_date is null and provvedimenti_prescrittivi=5 and closed is not null
							and tipologia=3 and alt_id > 0)
		