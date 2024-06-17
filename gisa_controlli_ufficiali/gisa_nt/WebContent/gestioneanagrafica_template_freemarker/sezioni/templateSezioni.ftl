
<#assign check = '${lista.html_type}'>
			<#if check == 'nome_sezione'>
				<tr  id="tr_${lista.html_name}">
					<th colspan="2">${lista.html_label_sezione} 
					<#if lista.html_label??>
						<#if lista.html_label == 'input_text'>
							<input type="text" id="${lista.html_name}" name="${lista.mapping_field}" <#if lista.sql_campo??>${lista.sql_campo}<#else></#if>
							<#if lista.html_style??>${lista.html_style}<#else></#if>
							<#if lista.html_event??>${lista.html_event}<#else></#if>>
						<#elseif lista.html_label == 'input_button'>
							<input type="button" id="${lista.html_name}" value="<#if lista.sql_campo??>${lista.sql_campo}<#else></#if>"  
							<#if lista.html_style??>${lista.html_style}<#else></#if>
							<#if lista.html_event??>${lista.html_event}<#else></#if> />
						</#if>
					<#else></#if>
					</th>
				</tr>
			<#elseif check == 'text'>
			<tr  id="tr_${lista.html_name}"  title="" <#if lista.html_style??>${lista.html_style}<#else></#if> >
				<td class="formLabel">${lista.html_label}</td>
				<td>
					<input type="text" id="${lista.html_name}" name="${lista.mapping_field}" value="" 
						<#if lista.html_style??>${lista.html_style}<#else></#if>
						<#if lista.html_event??>${lista.html_event}<#else></#if>>
			</tr>
			<#elseif check == 'date'>
 			<tr>
        		<td class="formLabel">${lista.html_label}</td>
        		<td>
                	<input placeholder="Inserisci data" type="text" id="${lista.html_name}" name="${lista.mapping_field}" class="date_picker"
                	<#if lista.html_style??>${lista.html_style}<#else></#if> autocomplete="off">                
                	<script>
                	$( '#${lista.html_name}' ).datepicker({
						 	closeText: "Chiudi",
						 	prevText: "Prec",
		          		 	nextText: "Succ",
						  	currentText: "Oggi",
							monthNames: [ "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno",
										"Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre" ],
							monthNamesShort: [ "Gen", "Feb", "Mar", "Apr", "Mag", "Giu",
										"Lug", "Ago", "Set", "Ott", "Nov", "Dic" ],
							dayNames: [ "Domenica", "Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato" ],
							dayNamesShort: [ "Dom", "Lun", "Mar", "Mer", "Gio", "Ven", "Sab" ],
							dayNamesMin: [ "Do", "Lu", "Ma", "Me", "Gi", "Ve", "Sa" ],
							weekHeader: "Sm",
							dateFormat: "dd/mm/yy",
							firstDay: 1,
							isRTL: false,
							showMonthAfterYear: false,
							yearSuffix: "",
							yearRange: "-100:+10",
							changeMonth: true,
	    					changeYear: true,				
						  	<#if lista.html_event??>${lista.html_event}<#else></#if>                                                
						});
                	</script>
        		</td>
        	</tr>
        	
        	<#elseif check == 'gruppo_calcolato'>
 				<#assign elementigruppo = lista.listaLookup>
				<tr id="${lista.html_name}">
				<td class="formLabel">${lista.html_label}</td>	
				<td>
        					<#list elementigruppo as e> 
        					<#if '${e.html_type}' == 'text'>		
								<input type="text" id="${e.html_name}" name="${e.mapping_field}" placeholder="${e.html_label}"  value ="" 
								<#if e.html_style??>${e.html_style}<#else></#if>
								<#if e.html_event??>${e.html_event}<#else></#if>
								>
							<#elseif '${e.html_type}' == 'button'>
					 			<input type="button" id="${e.html_name}" value="${e.html_label}" ${e.html_event} <#if e.html_style??>${e.html_style}<#else></#if> />     
							</#if>
							</#list>
        		</td>
				</tr>
				
        		<#elseif check == 'gruppo_campi_estesi'>
	 				<#assign elementigruppo = lista.listaLookup>
					<tr id="${lista.html_name}">
					<td class="formLabel">${lista.html_label}</td>	
					<td>
						<#list elementigruppo as e> 
						
							<#if '${e.html_type}' == 'text'>		
								<b>${e.html_label}</b> <input type="text" id="${e.html_name}" name="${e.mapping_field}" placeholder="${e.html_label}"  value ="" 
								<#if e.html_style??>${e.html_style}<#else></#if>
								<#if e.html_event??>${e.html_event}<#else></#if>
								>
							<#elseif '${e.html_type}' == 'select'>
								<#assign lookup = e.listaLookup>
									<b>${e.html_label}</b>
									<select name="${e.mapping_field}" id="${e.html_name}" 
										<#if e.html_style??>${e.html_style}<#else></#if>
										<#if e.html_event??>${e.html_event}<#else></#if>>
			                			<#list lookup as t>
			                    			<option value="${t.code}" <#if ('${t.code}' == '106')&& '${t.description}'=='Italia'> selected="selected"</#if>>${t.description}</option>                 
			                			</#list>
			            			</select>
							<#elseif '${e.html_type}' == 'button'>
					 			<input type="button" id="${e.html_name}" value="${e.html_label}" ${e.html_event} <#if e.html_style??>${e.html_style}<#else></#if> />     
							</#if>
							<br>
						</#list>
	        		</td>
					</tr>
			<#-- 		
			<#elseif check == 'select'>
 				<#assign lookup = lista.listaLookup>
 				<tr id="tr_${lista.html_name}" <#if lista.html_style??>${lista.html_style}<#else></#if>>
    				<td class="formLabel">${lista.html_label}</td>
        			<td>
            			<select name="${lista.mapping_field}" id="${lista.html_name}" <#if lista.html_event??>${lista.html_event}<#else></#if> <#if lista.html_style??>${lista.html_style}<#else></#if>>
                			<option></option>
                			<#list lookup as t>
                    			<option value="${t.code}" <#if ('${t.code}' == '106')&& '${t.description}'=='Italia'> selected="selected"</#if>>${t.description}</option>                 
                			</#list>
            			</select>
        			</td>
 				</tr>
			 -->
			
			<#elseif check == 'select' && lista.html_name != 'comune_nascita_rapp_legale'>
 				<#assign lookup = lista.listaLookup>
 				<tr id="tr_${lista.html_name}" <#if lista.html_style??>${lista.html_style}<#else></#if>>
    				<td class="formLabel">${lista.html_label}</td>
        			<td>
            			<select name="${lista.mapping_field}" id="${lista.html_name}" <#if lista.html_event??>${lista.html_event}<#else></#if> <#if lista.html_style??>${lista.html_style}<#else></#if>>
                			<option></option>
                			<#list lookup as t>
                    			<option value="<#if t.code??>${t.code}<#else></#if>" 
                    				<#if ('${t.code}' == '106') && '${t.description}'=='Italia'> selected="selected"</#if>>${t.description}</option>                 
                			</#list>
            			</select>
        			</td>
 				</tr>
 			 
 			<#elseif check == 'select' && lista.html_name == 'comune_nascita_rapp_legale'>
				<tr id="tr_${lista.html_name}" <#if lista.html_style??>${lista.html_style}<#else></#if>>
    				<td class="formLabel">${lista.html_label}</td>
    				<td>
						<div>
							<input class="awesomplete" id="${lista.html_name}Label" name="${lista.mapping_field}Label"
							onfocus="initAwesomplete({inputId: '${lista.html_name}Label'}, {hiddenId: '${lista.html_name}'})" 
							placeholder="Digitare i primi caratteri del Comune" size="50" 
							<#if lista.html_event??>${lista.html_event}<#else></#if> />
							<input type="hidden" id="${lista.html_name}" name="${lista.mapping_field}">
						</div>
					</td>
 				</tr>
 
 			<#elseif check == 'dati_linea_attivita'>
 				<#assign lookup = lista.listaLookup>
 				<tr id="tr_${lista.html_name}" <#if lista.html_style??>${lista.html_style}<#else></#if>>
    				<td class="formLabel">${lista.html_label}</td>
                		<#list lookup as t>
            				<td id="${lista.html_name}" name="${lista.mapping_field}" value="${t.code}">${t.description}</td>
            			</#list>        			
 				</tr>
 			<#elseif check == 'hidden'>
 				<#if '${lista.html_name}' == 'lineaattivita_1_codice_univoco_ml'>
 	 				<input type="hidden" id="${lista.html_name}" name="${lista.mapping_field}" value="${lista.codice_univoco_ml}"/>
 	 			<#else>
 	 				<#--  <input type="hidden" id="${lista.html_name}" name="${lista.mapping_field}" /> -->
 	 				<input type="hidden" id="${lista.html_name}" name="${lista.mapping_field}" <#if lista.html_style??>${lista.html_style}<#else></#if> />	
 	 			</#if>
 	 		<#elseif check == 'textarea'>
 	 			<td class="formLabel"> ${lista.html_label}</td>
            	<td>
                    <${lista.html_type} id="${lista.html_name}" name="${lista.mapping_field}" ></${lista.html_type}>
            	</td>
			</#if>


		<#if check == 'checkbox'>
			<tr  id="tr_${lista.html_name}" title="" <#if lista.html_style??>${lista.html_style}<#else></#if>>
				<td class="formLabel">${lista.html_label}</td>
				<td>
					<input type="${lista.html_type}" id="${lista.html_name}" name="${lista.mapping_field}"  
						<#if lista.html_style??>${lista.html_style}<#else></#if>
						<#if lista.html_event??>${lista.html_event}<#else></#if>>
			</tr>
			
			</#if>



		<#if check == 'number'>
			<tr  id="tr_${lista.html_name}" title="" <#if lista.html_style??>${lista.html_style}<#else></#if>>
				<td class="formLabel">${lista.html_label}</td>
				<td>
					<input type="${lista.html_type}" id="${lista.html_name}" name="${lista.mapping_field}"  
						<#if lista.html_style??>${lista.html_style}<#else></#if>
						<#if lista.html_event??>${lista.html_event}<#else></#if>>
			</tr>
			
			</#if>



<script src="javascript/noscia/fix_awesomplete.js"></script>
			