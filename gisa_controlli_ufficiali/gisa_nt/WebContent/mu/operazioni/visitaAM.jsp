<%@ include file="include.jsp" %>
<table width="100%" border="0" cellpadding="2" cellspacing="2"  class="details" style="border:1px solid black">
   <tr>
              <th colspan="2"><strong>Visita Ante Mortem </strong></th>
            </tr>

            <tr class="containerBody">
              <td class="formLabel" >Data</td>
              <td>
					<input readonly required="true" label="Data visita AM" type="text" id="dataVisitaAm" name="dataVisitaAm" onfocus="riportaDataArrivoMacello(this);gestisciObbligatorietaVisitaAnteMortem();" size="10" value="" />&nbsp;  
			        <font color="red" id="dataVisitaAnteMortem" style="display: none;">*</font>
			        <a href="#" onClick="cal19.select(document.forms[0].dataVisitaAm,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
			 		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
			 		<a href="#" style="cursor: pointer;" onclick="svuotaData(document.forms[0].dataVisitaAm);"><img src="images/delete.gif" align="absmiddle"/></a>
              </td>
            </tr>
           
            <tr class="containerBody">
                <td class="formLabel">Esito</td>
                <td>
                <%Iterator i = esitoVisitaAm.iterator();
                	while (i.hasNext()){
                		LookupElement element = (LookupElement) i.next();
                		if (element.getCode() > 0){
                	%>
						<input 
							type=radio 
							onclick="if(this.checked==true) document.getElementById('vam_tabella_non_conformita').style.display='none';gestisciObbligatorietaVisitaAnteMortem();" 
							id= "idEsitoAm" 
							name="idEsitoAm" 
							value="<%=element.getCode()%>"><%=element.getDescription() %><br/>
<%}
                		}%>
							
							<p>
							</p>
				</td>               
            </tr>
			
            
            <tr class="containerBody">
                <td class="formLabel">Provvedimento adottato</td>
                <td>
					<%
						ProvvedimentiVAM.setJsEvent("onChange=\"javascript:displayAbbattimento();gestisciObbligatorietaVisitaAnteMortem();\"");
					%>                               
                	
	               	<%=ProvvedimentiVAM.getHtmlSelect( "idProvvedimentoAdottatoVisitaAm", -1 ) %>
	               	<font color="red" id="provvedimentoVisitaAnteMortem" style="display: none;">*</font>
                </td>
            </tr>
            
            
            <tr class="containerBody">
            	<td class="formLabel">Comunicazione a</td>
   
            	<td>
            		<p id="comunicazioneA" align="center" style="display: none;"><font color="red" >*</font></p>
            		<input 
            			type="checkbox" 
            			id="comunicazioneAslOrigineVisitaAm"
            			name="comunicazioneAslOrigineVisitaAm" 
            			onclick=""
            			/> ASL origine <br/>
            		<input 
            			type="checkbox" 
            			id="comunicazioneProprietarioAnimaleVisitaAm"
            			name="comunicazioneProprietarioAnimaleVisitaAm" 
            			onclick=""
            			/> Proprietario animale <br/>
            		<input 
            			type="checkbox" 
            			id="comunicazioneAziendaOrigineVisitaAm"
            			name="comunicazioneAziendaOrigineVisitaAm" 
            			onclick=""
            			/> Azienda di origine <br/>
            		<input 
            			type="checkbox" 
            			id="comunicazioneProprietarioMacelloVisitaAm"
            			name="comunicazioneProprietarioMacelloVisitaAm" 
            			onclick=""
            			/> Proprietario macello <br/>
            		<input 
            			type="checkbox" 
            			id="comunicazionePifVisitaAm"
            			name="comunicazionePifVisitaAm" 
            			onclick=""
            			/> P.I.F. <br/>	
            		<input 
            			type="checkbox" 
            			id="comunicazioneUvacVisitaAm"
            			name="comunicazioneUvacVisitaAm" 
            			onclick=""
            			/> U.V.A.C. <br/>	
            		<input 
            			type="checkbox" 
            			id="comunicazioneRegioneVisitaAm"
            			name="comunicazioneRegioneVisitaAm" 
            			onclick=""
            			/> Regione <br/>
            		<input 
            			type="checkbox"
            			id="comunicazioneAltroVisitaAm" 
            			name="comunicazioneAltroVisitaAm" 
            			onclick="visualizzaTextareaCAslToAltro();"
            			/> Altro <br/>
         <textarea id="comunicazioneAltroTestoVisitaAm" name="comunicazioneAltroTestoVisitaAm" rows="2" cols="40" style="display:none;" ></textarea>
            			
            	</td>
            </tr>   
            		
            			
            	</td>
            </tr>
            
              <tr class="containerBody">
		 		<td class="formLabel">Note</td>
		 		<td><textarea rows="2" cols="40" name="noteVisitaAm"></textarea></td>
			  </tr>
            
                 </table>
              