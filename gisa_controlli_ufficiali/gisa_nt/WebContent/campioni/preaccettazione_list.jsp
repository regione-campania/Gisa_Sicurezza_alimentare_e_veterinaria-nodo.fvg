
<%@ include file="../utils23/initPage.jsp" %>

<% 
if ("true".equalsIgnoreCase(org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("abilitazione_chiamata_microservices"))) {
	String tabPreacc = "";
	tabPreacc =  DwrPreaccettazione.getCodiciPreaccettazioneAnagraficaLinea(request.getParameter("preaccLinea"));
	%>
	<% if (!"".equals(tabPreacc)) { %>
	<br/><br/>
	
	<table cellpadding="5" cellspacing="0" width="100%" class="details">
	<tr><th colspan="4">CODICI PREACCETTAZIONE GIA' GENERATI DISPONIBILI</th></tr>
	<tr><th>CODICE</th><th>QUESITO DIAGNOSTICO</th><th>MATRICE</th><th>LABORATORIO</th></tr>
	<% String righe[] = tabPreacc.split("##"); 
	for (int i = 0; i< righe.length; i++) {
		String celle[] = righe[i].split(";;");%>
		<tr>
		<td><%=toHtml(celle[0]) %></td>
		<td><%=toHtml(celle[1]) %></td>
		<td><%=toHtml(celle[2]) %></td>
		<td><%=toHtml(celle[3]) %></td>
		</tr>	
	<% } %>
	</table>
	
	<br/><br/>
	<% } 
	}%>
	