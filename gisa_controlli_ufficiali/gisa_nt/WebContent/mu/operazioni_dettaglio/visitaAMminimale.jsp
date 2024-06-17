<%@page import="org.aspcfs.modules.mu.operazioni.base.VisitaAMSemplificata"%>
<%@page import="org.aspcfs.modules.mu.operazioni.base.MacellazioneLiberoConsumo"%>
<%@page import="org.aspcfs.modules.mu.operazioni.base.Macellazione"%>
<%@ include file="include.jsp" %>
<table width="100%" border="0" cellpadding="2" cellspacing="2"  class="details" style="border:1px solid black">
   <tr>
              <th colspan="2"><strong>Visita Ante Mortem </strong></th>
            </tr>

            <tr class="containerBody">
              <td class="formLabel" >Data</td>
              <td>
              <%
              Macellazione thisMacellazione = dettaglioCapo.getDettagliMacellazione();
              
              
              
              VisitaAMSemplificata visita = (dettaglioCapo.getDettagliMacellazione()).getVa();
              %>
					<%=toDateasString(visita.getDataVisitaAm()) %>
              </td>
            </tr>
           
            <tr class="containerBody">
                <td class="formLabel">Esito</td>
                <td> <%=esitoVisitaAm.getSelectedValue(visita.getIdEsitoAm()) %><br/>
							
							<p>
							</p>
				</td>               
            </tr>
			
            
            
                 </table>
              