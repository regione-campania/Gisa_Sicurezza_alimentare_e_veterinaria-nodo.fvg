	<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
	<%@page import ="org.aspcfs.modules.suap.utils.CodiciRisultatiRichiesta" %>
	<%@page import ="org.aspcfs.modules.opu.base.OperatorePerDuplicati" %>
	<%@page import ="java.util.ArrayList, java.util.HashMap,org.aspcfs.modules.suap.base.CodiciRisultatoFrontEnd, org.aspcfs.modules.suap.base.Stabilimento" %>
	<%@page import ="org.json.JSONObject" %>
						<tr>
						<th>ID STAB.</th> <th> RAGIONE SOCIALE</th> <th> P.IVA</th> <th>CF </th> <th>N. REG</th> <th>COMUNE LEGALE</th> <th>IND. LEGALE</th> <th>COMUNE SEDE OP.</th> <th>IND. SEDE OP.</th>
						 
						
						 
						</tr>
						<!-- devo stampare la lista dei candidati da scegliere -->
						<%HashMap<Integer,Stabilimento> candidati = (HashMap<Integer,Stabilimento>)request.getAttribute("lista_candidati"); 
						  boolean primo = true;
						  for(Integer idStab : candidati.keySet() )
						  {
							    Stabilimento candidato = candidati.get(idStab);
							    
						  		String ragioneSociale = candidato.getRagioneSociale();
						  		String partitaIva = candidato.getPartitaIva();
						  		String cfRappresentante = candidato.getCfRappresentante();
						  		String numeroRegistrazione = candidato.getNumeroRegistrazione();
						  		String comuneSedeLegale = candidato.getComuneSedeLegale();
						  		String indirizzoSedeLegale = candidato.getIndirizzoSedeLegale();
						  		String comuneSedeOperativa = candidato.getComuneSedeOperativa();
						  		String indirizzoSedeOperativa = candidato.getIndirizzoSedeOperativa();
						  		
						  %>
								
							<tr> <!-- il primo è checked di default -->
									<td><input type="radio" name="candidato_scelto" value="<%=idStab %>" <%=primo ? "checked=\"checked\"" : "" %>></td>	<td><%=idStab %></td><td><%= ragioneSociale %></td>	<td><%= partitaIva %></td><td><%= cfRappresentante %></td> <td><%= comuneSedeLegale %></td> <td><%= indirizzoSedeLegale %></td> <td><%= comuneSedeOperativa %></td> <td><%= indirizzoSedeOperativa %></td>
							</tr>
							
						 <%
						 	 primo = false;
						  }%>
						  
						  <tr>
						  <td colspan="9" id ="tdMsg" style="background-color: yellow; visibility: hidden" >
						
						 	DUPLICATI IN OPU: SCEGLIERE CANDIDATO
						  </td>
						  </tr>
						  <script>
							$("#tdMsg").css("visibility","visible");
						  </script>