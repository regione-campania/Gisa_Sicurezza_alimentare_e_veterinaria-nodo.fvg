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
			<tr  id="tr_${lista.html_name}" title="" <#if lista.html_style??>${lista.html_style}<#else></#if>>
				<td class="formLabel">${lista.html_label}</td>
				<td>
					<input type="text" id="${lista.html_name}" name="${lista.mapping_field}"  
						<#if lista.html_style??>${lista.html_style}<#else></#if>
						<#if lista.html_event??>${lista.html_event}<#else></#if>>
			</tr>
			<#elseif check == 'date'>
 			<tr>
        		<td class="formLabel">${lista.html_label}</td>
        		<td>
                	<input placeholder="Inserisci data" class="date_picker" type="text" id="${lista.html_name}" name="${lista.mapping_field}" onchange=""
                	<#if lista.html_style??>${lista.html_style}<#else></#if> autocomplete="off">
                	<span class="__req_class__" style="color:red">*</span>       
                	<script>
                		var maxDate = '0'; var onSelect = '';
                		var arr = "${lista.html_event}".replace(/\r?\n|\r/g, "");
                		var x = arr.split(','); var i = 0;
                		while (i < x.length){
                			if(x[i] != ''){
                				if(x[i].includes('maxDate:')){
                					maxDate = x[i].replace('maxDate:','');
                				}
                				if(x[i].includes('onSelect:')){
                					onSelect = x[i].replace('onSelect: function(){','');
                					onSelect = onSelect.replace(/.$/,'');
                					$('#${lista.html_name}').attr('onchange',onSelect);
                				}
                			}
                			i++;
                		}
                		calenda('${lista.html_name}','',maxDate);
                		if('${lista.html_name}'=='lineaattivita_1_data_fine_attivita'){
                			$("#${lista.html_name}").after('<span id="data_obbligatoria" style="color:red; display:none"> *</span>')
                		}
                		
                		$('#lineaattivita_1_tipo_carattere_attivita').change( function(){
                			if($('#lineaattivita_1_tipo_carattere_attivita').val() == '2'){
                				$('#data_obbligatoria').attr('style','color:red;');
                			}else{
                				$('#data_obbligatoria').attr('style','color:red; display:none');
                			}
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
        				 <form action="">
 							<div class="awesomplete">
								<input type="text" id="${lista.html_name}Label" name="${lista.mapping_field}Label" placeholder="Digitare i primi caratteri il Comune" size="50" 
								<#if lista.html_event??>${lista.html_event}<#else></#if> />
								<input type="hidden" id="${lista.html_name}" name="${lista.mapping_field}">
							</div>
						</form>
						<script>
							"use strict";
							var hidden = document.getElementById("${lista.html_name}");
							var input = document.getElementById("${lista.html_name}Label");
							new Awesomplete(input, {
    												list: cArray,
    												minChars: 2,
													maxItems: 20,
													autoFirst: true,
   													replace: function(item) {
       												input.value= item.label; 
        											hidden.value = item.value;
    												},
											filter: Awesomplete.FILTER_STARTSWITH
							});
						</script>
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
 	 			<#elseif '${lista.html_name}' == 'numero_linee_effettivo'>
 	 				<input type="hidden" id="${lista.html_name}" name="${lista.mapping_field}" ${lista.html_style} />
 	 			<#elseif '${lista.html_name}' == 'lineaattivita_1_tipo_carattere_attivita'>
 	 				<input type="hidden" id="${lista.html_name}" name="${lista.mapping_field}" <#if lista.html_style??>${lista.html_style}<#else></#if> />
 	 			<#else>
 	 				<input type="hidden" id="${lista.html_name}" name="${lista.mapping_field}" />
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
			