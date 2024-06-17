-- FUNCTION: public.get_valori_anagrafica_dati_aggiuntivi(integer, integer)

-- DROP FUNCTION IF EXISTS public.get_valori_anagrafica_dati_aggiuntivi(integer, integer);

CREATE OR REPLACE FUNCTION public.get_valori_anagrafica_dati_aggiuntivi(
	_altid integer,
	_id_rel_stab_linea integer)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE
	_tipo_attivita integer;
	_id_stabilimento integer;
	_numero_valori_per_riga integer;
	_max_row integer;
	_row_x_column_rate integer;
	_intestazione_tabella text;
	_tabella_dati_agg text;	
BEGIN
	select id, tipo_attivita into _id_stabilimento, _tipo_attivita from opu_stabilimento where alt_id = _altid;

	_tabella_dati_agg := '';
	
	IF _tipo_attivita = 1 THEN
		--query per dati aggiuntivi fissi
		select 
			case when count(info) > 0 THEN
				concat('<table align=''center'' style=''border-collapse: collapse'' cellpadding=''5'' border=''1px solid black''>', 
					string_agg(concat('<tr><td>', info, '</td><td>', valore, '</td></tr>'), ''), '</table>')::text 
				else ''::text 
				end into _tabella_dati_agg
		from (select
		      case when tipo_campo = 'label' and label_campo is not null then '<b>'||label_campo||'</b>'
			  when tipo_campo <> 'label' and label_campo is not null then label_campo 
			  else '' 
		       end as info, 
		       case when tipo_campo = 'select' and label_campo ilike '%Specie animali%' then 
				get_description_specie_animali_campi_estesi(valore_campo) 
			    when tipo_campo = 'checkbox' and valore_campo ='true' then 
				'SI' 
			    when tipo_campo = 'checkbox' and (valore_campo <>'true' or valore_campo is null) then 
				'NO' 
			    when tipo_campo <> 'checkbox' and (label_campo ilike '%sesso%' or label_campo ilike '%sex%') and upper(valore_campo) = '0' then 
				'M' 
			    when tipo_campo <> 'checkbox' and (label_campo ilike '%sesso%' or label_campo ilike '%sex%') and upper(valore_campo) = '1' then 
				'F'
			  ELSE replace(COALESCE(valore_campo, ''), ',', '') 
			end as valore 

		from linee_mobili_html_fields f 
			join linee_mobili_fields_value v on f.id = v.id_linee_mobili_html_fields 
			join ml8_linee_attivita_nuove_materializzata o on o.id_nuova_linea_attivita = f.id_linea 

		where (v.id_rel_stab_linea in (select rs.id 
						from opu_relazione_stabilimento_linee_produttive rs 
							join opu_stabilimento s on rs.id_stabilimento = s.id 
						where s.id = _id_stabilimento and enabled) 
			or v.id_opu_rel_stab_linea in (select rs.id 
							from opu_relazione_stabilimento_linee_produttive rs 
								join opu_stabilimento s on rs.id_stabilimento = s.id 
							where s.id = _id_stabilimento and enabled) 
			) and v.enabled and f.enabled and (id_opu_rel_stab_linea = _id_rel_stab_linea or id_rel_stab_linea = _id_rel_stab_linea)
		group by o.descrizione, f.id_linea, f.label_campo, v.valore_campo, v.id , f.id 
		order by f.ordine, f.id_linea, v.indice, f.id limit 104) tab ;
		
	ELSIF _tipo_attivita = 2 THEN
		--query per dati aggiuntivi mobili
		--recupero informazioni su righe e colonne della tabella da creare
		select count(distinct info), coalesce(max(row_num)/count(distinct info), 0) into _numero_valori_per_riga, _row_x_column_rate
		from  (select 
				(row_number() OVER (ORDER BY  v.indice, f.id, f.id_linea, v.id))::integer as row_num,
			       case when label_campo is not null then 
					label_campo else '' 
			       end as info
			from linee_mobili_html_fields f 
				join linee_mobili_fields_value v on f.id = v.id_linee_mobili_html_fields 
				join ml8_linee_attivita_nuove_materializzata o on o.id_nuova_linea_attivita = f.id_linea 
				left join lookup_tipo_mobili tipomobili on tipomobili.code::text = v.valore_campo and f.tabella_lookup = 'lookup_tipo_mobili'

			where ( v.id_rel_stab_linea in (select rs.id from opu_relazione_stabilimento_linee_produttive rs join opu_stabilimento s on rs.id_stabilimento = s.id 
								where s.id = _id_stabilimento and enabled) 
				or v.id_opu_rel_stab_linea in (select rs.id from opu_relazione_stabilimento_linee_produttive rs join opu_stabilimento s on rs.id_stabilimento = s.id 
									where s.id = _id_stabilimento and enabled) 
			       ) and v.enabled and f.enabled 
			order by v.indice, f.id, f.id_linea, v.id limit 104) tab;

		--gestione verticale	
		IF _numero_valori_per_riga > 6 and _row_x_column_rate < 2 THEN 

			select 
			      concat('<table align=''center'' style=''border-collapse: collapse'' cellpadding=''5'' border=''1px solid black''>', 
				string_agg(concat('<tr><td>', info, '</td><td>', valore, '</td></tr>'), ''), '</table>')::text into _tabella_dati_agg
				 from 
			(select 
			       (row_number() OVER (ORDER BY  v.indice, f.id, f.id_linea, v.id))::integer as row_num, 
			       case when label_campo is not null then 
					label_campo else '' 
			       end as info, 
			       case when valore_campo is not null then 
					CASE WHEN ( ( label_campo is not null  and ( label_campo ilike '%sesso%' or label_campo ilike '%sex%' )) and valore_campo::text = '0' ) THEN 
						'M' 
					     WHEN ( ( label_campo is not null and (label_campo ilike '%sesso%' or label_campo ilike '%sex%' )) and valore_campo::text = '1' ) THEN 
						'F' 
					     ELSE replace(COALESCE(tipomobili.description, v.valore_campo, '') , ',', '') 
					     END 
				     else '' end as valore 

			from linee_mobili_html_fields f 
				join linee_mobili_fields_value v on f.id = v.id_linee_mobili_html_fields 
				join ml8_linee_attivita_nuove_materializzata o on o.id_nuova_linea_attivita = f.id_linea 
				left join lookup_tipo_mobili tipomobili on tipomobili.code::text = v.valore_campo and f.tabella_lookup = 'lookup_tipo_mobili'

			where ( v.id_rel_stab_linea in (select rs.id 
							from opu_relazione_stabilimento_linee_produttive rs 
								join opu_stabilimento s on rs.id_stabilimento = s.id 
							where s.id = _id_stabilimento and enabled) 
				or v.id_opu_rel_stab_linea in (select rs.id 
							       from opu_relazione_stabilimento_linee_produttive rs 
									join opu_stabilimento s on rs.id_stabilimento = s.id 
							       where s.id = _id_stabilimento and enabled) 
			       ) and v.enabled and f.enabled 
			order by v.indice, f.id, f.id_linea, v.id limit 104) tab; 

		--gestione orizzontale
		ELSIF _numero_valori_per_riga > 0 THEN

			--creo intestazione della tabella
			select 
				case when count(info) > 0 THEN
					concat('<tr><th>', string_agg(tab_2.info, '</th><th>'), '</th></tr>')::text 
				else
					''::text
				end into _intestazione_tabella 
			from
			(select
				distinct info, mod(row_num-1, _numero_valori_per_riga)
				 from 
			(select 
			       (row_number() OVER (ORDER BY  v.indice, f.id, f.id_linea, v.id))::integer as row_num, 
			       case when label_campo is not null then 
					label_campo else '' 
			       end as info

			from linee_mobili_html_fields f 
				join linee_mobili_fields_value v on f.id = v.id_linee_mobili_html_fields 
				join ml8_linee_attivita_nuove_materializzata o on o.id_nuova_linea_attivita = f.id_linea 
				left join lookup_tipo_mobili tipomobili on tipomobili.code::text = v.valore_campo and f.tabella_lookup = 'lookup_tipo_mobili'

			where ( v.id_rel_stab_linea in (select rs.id 
							from opu_relazione_stabilimento_linee_produttive rs 
								join opu_stabilimento s on rs.id_stabilimento = s.id 
							where s.id = _id_stabilimento and enabled) 
				or v.id_opu_rel_stab_linea in (select rs.id 
							       from opu_relazione_stabilimento_linee_produttive rs 
									join opu_stabilimento s on rs.id_stabilimento = s.id 
							       where s.id = _id_stabilimento and enabled) 
			       ) and v.enabled and f.enabled 
			order by v.indice, f.id, f.id_linea, v.id limit 104
			) tab order by mod(row_num-1, _numero_valori_per_riga), info ) tab_2; 
			--fine creazione intestazione della tabella
			
			--creo corpo dati della tabella
			select
			     concat(string_agg(case when mod(row_num, _numero_valori_per_riga) = 1 then 
							concat('<tr><td>', valore, '</td>')
						    when mod(row_num, _numero_valori_per_riga) = 0 then
							concat('<td>', valore, '</td></tr>')
						    when mod(row_num, _numero_valori_per_riga) > 1 then
							concat('<td>', valore, '</td>') 
						    else '' 
						end, ''))::text into _tabella_dati_agg 
				 from 
			(select 
			       (row_number() OVER (ORDER BY  v.indice, f.id, f.id_linea, v.id))::integer as row_num, 
			       case when label_campo is not null then 
					label_campo else '' 
			       end as info, 
			       case when valore_campo is not null then 
					CASE WHEN ( ( label_campo is not null  and ( label_campo ilike '%sesso%' or label_campo ilike '%sex%' )) and valore_campo::text = '0' ) THEN 
						'M' 
					     WHEN ( ( label_campo is not null and (label_campo ilike '%sesso%' or label_campo ilike '%sex%' )) and valore_campo::text = '1' ) THEN 
						'F' 
					     ELSE replace(COALESCE(tipomobili.description, v.valore_campo, '') , ',', '') 
					     END 
				     else '' end as valore 

			from linee_mobili_html_fields f 
				join linee_mobili_fields_value v on f.id = v.id_linee_mobili_html_fields 
				join ml8_linee_attivita_nuove_materializzata o on o.id_nuova_linea_attivita = f.id_linea 
				left join lookup_tipo_mobili tipomobili on tipomobili.code::text = v.valore_campo and f.tabella_lookup = 'lookup_tipo_mobili'

			where ( v.id_rel_stab_linea in (select rs.id 
							from opu_relazione_stabilimento_linee_produttive rs 
								join opu_stabilimento s on rs.id_stabilimento = s.id 
							where s.id = _id_stabilimento and enabled) 
				or v.id_opu_rel_stab_linea in (select rs.id 
							       from opu_relazione_stabilimento_linee_produttive rs 
									join opu_stabilimento s on rs.id_stabilimento = s.id 
							       where s.id = _id_stabilimento and enabled) 
			       ) and v.enabled and f.enabled 
			order by v.indice, f.id, f.id_linea, v.id limit 104) tab; 
			--fine creazione corpo dati della tabella

			--concatenazione intestazione, corpo tabella, chiusura tabella
			_tabella_dati_agg := concat('<table id=''tabella_dati_aggiuntivi'' align=''center'' style=''border-collapse: collapse'' cellpadding=''5'' border=''1px solid black''>',
							_intestazione_tabella,
							_tabella_dati_agg,
							'</table>');
		ELSE
			_tabella_dati_agg = '';
		END IF;
	ELSE 
		_tabella_dati_agg = '';
	END IF;
	
	return _tabella_dati_agg;
 END;
$BODY$;

ALTER FUNCTION public.get_valori_anagrafica_dati_aggiuntivi(integer, integer)
    OWNER TO postgres;