<%@ include file="../initPage.jsp" %>
<%@page import="java.util.ArrayList"%>
<%@page import="org.aspcfs.modules.anagrafe_animali.base.Animale, java.util.Map.Entry"%>

<jsp:useBean id="map" class="java.util.HashMap" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="specieList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="listaPratiche" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	
	
<table class="trails" cellspacing="0" >
	<tr>
		<td width="100%">
			  <a href="AnimaleAction.do?command=LoadFileVerificaEsistenzaMicrochip"><dhv:label name="">Estrazione MC presenti in BD</dhv:label></a> >
  			  <dhv:label name="">Elenco Microchip</dhv:label>
		</td>
	</tr>
</table>

<span style="color: red"><%=toHtmlValue( (String)request.getAttribute( "messaggio" ) ) %></span>

<table class="details" cellspacing="0" cellpadding="6" border="0" >
<%
String risultatoS = "";
Animale thisAnimale = new Animale();



Iterator entries = map.entrySet().iterator();
while (entries.hasNext()) {
  Entry thisEntry = (Entry) entries.next();
  risultatoS = (String)thisEntry.getKey();
  thisAnimale = (Animale)thisEntry.getValue();
 System.out.println(risultatoS + "  " + thisAnimale.getMicrochip());

 %>
		
		<tr>
			<th> ASL </th>
			<th> MICROCHIP </th>
			<th> STATO </th>
			<th> DATA STERILIZZAZIONE </th>
			<th> CONTRIBUTO REGIONALE RICHIESTO </th>
			<th> NR. DECRETO
			<th> CONTRIBUTO REGIONALE PAGATO </th>
			<th> SPECIE </th>
		</tr>
<%if (thisAnimale.getIdAnimale() > 0){ %>
		
				<tr>
					<td>
						<%= AslList.getSelectedValue(thisAnimale.getIdAslRiferimento()) %>
					</td>
					<td>
					<%=toHtml(thisAnimale.getMicrochip()) %>
					</td>
					<td>
					<%=toHtml(risultatoS.substring(0, risultatoS.indexOf("_"))) %>
					</td>
					<td>
					<%= (thisAnimale.getDataSterilizzazione() != null) ? toDateasString(thisAnimale.getDataSterilizzazione()) : "---"%>
					</td>
										<td>
					<%=(thisAnimale.isFlagContributoRegionale()) ? "Si" : "No" %> 
					
					</td>
					<td><%=listaPratiche.getSelectedValue(thisAnimale.getIdPraticaContributi()) %></td>
					<td>
					<%=(thisAnimale.getContributoPagato()) ? "Si" : "No" %> 
					
					</td>
					<td><%=specieList.getSelectedValue(thisAnimale.getIdSpecie()) %>
				</tr>	
					
		<%}else{ %>
				<tr>
					<td>---</td>
					<td><%=toHtml(thisAnimale.getMicrochip()) %></td>
					<td><%=toHtml(risultatoS.substring(0, risultatoS.indexOf("_"))) %></td>
					<td>---</td>
					<td>---</td>
					<td>---</td>
				</tr>	
		
		<%} %>
<%} %>		

		</table>

 