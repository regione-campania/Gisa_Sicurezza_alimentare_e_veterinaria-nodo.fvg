<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="idCampione" class="java.lang.String" scope="request"/>

<% 
String redirect = "";
redirect = TicketDetails.getURlDettaglio()+"Campioni.do?command=TicketDetails";
redirect+="&id="+idCampione;

if (TicketDetails.getIdStabilimento()>0)
	redirect +="&stabId="+TicketDetails.getIdStabilimento();
if (TicketDetails.getOrgId()>0)	
	redirect +="&orgId="+TicketDetails.getOrgId();
if (TicketDetails.getIdApiario()>0)	
	redirect +="&stabId="+TicketDetails.getIdApiario();
if (TicketDetails.getAltId()>0)
	redirect +="&altId="+TicketDetails.getAltId();
%>

<% if (idCampione!=null && !idCampione.equals("")) { %>
	<script>
	loadModalWindow();
	window.location.href="<%=redirect%>";
	</script>
<% } else { %>

<font color="red">Campione non trovato.</font>
<% } %>