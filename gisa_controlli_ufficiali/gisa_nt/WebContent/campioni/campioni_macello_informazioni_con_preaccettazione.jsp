<jsp:useBean id="CampioneCapoMatricola" class="java.lang.String" scope="request"/>
<jsp:useBean id="CampioneCapoSedutaData" class="java.lang.String" scope="request"/>
<jsp:useBean id="CampioneCapoSedutaNumero" class="java.lang.String" scope="request"/>

<% if (CampioneCapoMatricola!=null && !"".equals(CampioneCapoMatricola)){ %>
	
	<% String preaccAnagraficaId= CU.getAltId() + "altIdsintesis_stabilimento"+CU.getId_imprese_linee_attivita()+"2000";%>
	<jsp:include page="../campioni/preaccettazione_add.jsp">
	    <jsp:param name="preaccCampioneId" value="<%=TicketDetails.getId() %>" />
	    <jsp:param name="preaccEnteId" value="1" />
	    <jsp:param name="preaccLaboratorioId" value="<%=TicketDetails.getDestinatarioCampione()  %>" />
	    <jsp:param name="preaccAnagraficaId" value="<%=preaccAnagraficaId%>" />
	    <jsp:param name="preaccUserId" value="<%=User.getUserId() %>" />
	</jsp:include>
	
	<table class="details" cellpadding="10" cellspacing="10">
	<tr><th colspan="2">INFORMAZIONI CAMPIONE ASSOCIATO A CAPO IN SEDUTA DI MACELLAZIONE</th></tr>
	<tr><td class="formLabel">Matricola</td><td><%= CampioneCapoMatricola%></td></tr>
	<tr><td class="formLabel">Seduta</td><td><%=toDateasStringfromString(CampioneCapoSedutaData) %>-<%= CampioneCapoSedutaNumero%></td></tr>
	</table>
<br/>
<% } %>