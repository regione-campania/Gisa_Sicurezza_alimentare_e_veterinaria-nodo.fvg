<%@page import="org.aspcfs.modules.mu.operazioni.base.MorteANM"%>
<%@page import="org.aspcfs.modules.mu.operazioni.base.Macellazione"%>
<%@ include file="include.jsp" %>

<script> </script>

<%


Macellazione thisMacellazione = dettaglioCapo.getDettagliMacellazione();

MorteANM visita = (dettaglioCapo.getDettagliMacellazione()).getMorteAM();

%>
 <table width="100%" border="0" cellpadding="2" cellspacing="2"  class="details" style="border:1px solid black">
 <tr>
              <th colspan="2"><strong>Morte antecedente macellazione</strong></th>
            </tr>
            <tr class="containerBody">
              <td class="formLabel" >Data</td>
              <td>
              		<%=toDateasString(visita.getDataMorteAm()) %>
              </td>
            	
            </tr>
            
             <tr class="containerBody">
                <td class="formLabel">Luogo di verifica</td>
                
                <td>
                	                              
                	<%=LuoghiVerifica.getSelectedValue(visita.getIdLuogoVerificaMorteAm()) %>
                	
                	<td><%=visita.getDescrizioneLuogoVerificaMorteAm() %>
                </td>
                                
            </tr>
            
          <tr class="containerBody">
                <td class="formLabel">Causa</td>
                <td>
                	<%=visita.getCausaMorteAm() %>
                </td>
				
           </tr>
           
           <tr class="containerBody">
                <td class="formLabel">Impianto di termodistruzione</td>
                <td>
                	<%=visita.getImpiantoTermodistruzioneMorteAm() %>
                </td>
           </tr>
           
             <tr class="containerBody">
                <td class="formLabel">Destinazione della carcassa</td>
                <td>
                	<%=visita.getDestinazioneCarcassaMorteAm() %>
                </td>
           </tr>
           
           
           <tr class="containerBody">
            	<td class="formLabel">Comunicazione a</td>
            	<td>
            		<input 
            			type="checkbox" 
            			id="comunicazioneAslOrigineMorteAm"
            			name="comunicazioneAslOrigineMorteAm" 
            			disabled="disabled" <%=visita.isComunicazioneAslOrigineMorteAm() ? "checked" : "" %>
            			/> ASL origine <br/>
            		<input 
            			type="checkbox" 
            			id="comunicazioneProprietarioAnimaleMorteAm"
            			name="comunicazioneProprietarioAnimaleMorteAm" 
            			disabled="disabled" <%=visita.isComunicazioneProprietarioAnimaleMorteAm() ? "checked" : "" %>
            			/> Proprietario animale <br/>
            		<input 
            			type="checkbox" 
            			id="comunicazioneAziendaOrigineMorteAm"
            			name="comunicazioneAziendaOrigineMorteAm" 
            			disabled="disabled" <%=visita.isComunicazioneAziendaOrigineMorteAm() ? "checked" : "" %>
            			/> Azienda di origine <br/>
            		<input 
            			type="checkbox" 
            			id="comunicazioneProprietarioMacelloMorteAm"
            			name="comunicazioneProprietarioMacelloMorteAm" 
            			disabled="disabled" <%=visita.isComunicazioneProprietarioMacelloMorteAm() ? "checked" : "" %>
            			/> Proprietario macello <br/>
            		<input 
            			type="checkbox" 
            			id="comunicazionePifMorteAm"
            			name="comunicazionePifMorteAm" 
            			disabled="disabled" <%=visita.isComunicazionePifMorteAm() ? "checked" : "" %>
            			/> P.I.F. <br/>	
            		<input 
            			type="checkbox" 
            			id="comunicazioneUvacMorteAm"
            			name="comunicazioneUvacMorteAm" 
            			disabled="disabled" <%=visita.isComunicazioneUvacMorteAm() ? "checked" : "" %>
            			/> U.V.A.C. <br/>	
            		<input 
            			type="checkbox" 
            			id="comunicazioneRegioneMorteAm"
            			name="comunicazioneRegioneMorteAm" 
            			disabled="disabled" <%=visita.isComunicazioneRegioneMorteAm() ? "checked" : "" %>
            			/> Regione <br/>
            		<input 
            			type="checkbox"
            			id="comunicazioneAltroMorteAm" 
            			name="comunicazioneAltroMorteAm" 
            			onclick="visualizzaTextareaMavamToAltro();"
            				disabled="disabled" <%=visita.isComunicazioneAltroMorteAm() ? "checked" : "" %>
            			/> Altro <br/>
            		<%=visita.getComunicazioneAltroTestoMorteAm() %>
            			
            	</td>
            </tr>
           
           <tr class="containerBody">
                <td class="formLabel">Note</td>
                <td>
                		<%=visita.getNoteMorteAm() %>
                </td>
				
           </tr>
        </tbody>
     </table>
     </br></br>
          <div 
	        	style="/* display: none */"  id="blocco_animale_div">
	                  <table class="details" width="100%" border="0" cellpadding="4" cellspacing="0">
	          <tbody>
	            <tr>
	              <th colspan="2"><strong>Blocco Animale</strong></th>
	            </tr>
	
	            <tr class="containerBody">
	              <td class="formLabel" >Data blocco</td>
	              <td>
	              		<%=toDateasString(visita.getDataBloccoMorteAm()) %>
	              		
	              </td>
	            </tr>
	
	            <tr class="containerBody">
	              <td class="formLabel" >Data sblocco</td>
	              <td>
		              	<%=toDateasString(visita.getDataSbloccoMorteAm()) %>
	              </td>
	            </tr>
	            
	             <tr class="containerBody">
	                <td class="formLabel">Destinazione allo sblocco</td>
	                <td>
	                	<%=ProvvedimentiVAM.getSelectedValue(visita.getIdDestinazioneSbloccoMorteAm()) %>
	    			</td>                
	            </tr>
	              </tbody>
	           </table>
	         