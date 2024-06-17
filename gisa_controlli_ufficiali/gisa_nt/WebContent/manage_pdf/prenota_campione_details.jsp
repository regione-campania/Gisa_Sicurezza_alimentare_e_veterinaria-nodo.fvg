<%@ include file="../utils23/initPage.jsp" %>

<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.campioni.base.Ticket" scope="request"/>
<jsp:useBean id="orgId" class="java.lang.String" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="DestinatarioCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<%@page import="org.aspcfs.modules.campioni.base.Analita"%>

<table class="trails" cellspacing="0" >
<tr>
<td>
<a href="OsaSearch.do">Operatori</dhv:label></a> > 
<a href="OsaSearch.do?command=Search"><dhv:label name=" ">Ricerca Operaoti</dhv:label></a> >
<a href="PrintModulesHTML.do?command=Prenota&orgId=<%=orgId%>"><dhv:label name=" ">Prenotazione Campione</dhv:label></a> >
<dhv:label name=" ">Dettaglio Campione Prenotato</dhv:label></a> 
</td>
</tr>
</table>

<table cellpadding="4" cellspacing="0" width="100%" class="details">
	<tr>
    <th colspan="2">
      <strong><dhv:label name="">Dettaglio Campione Prenotato</dhv:label></strong>
    </th>
	</tr>
  
     <%@ include file="/campioni/campioni_view.jsp" %>
  
</table> <!--  chiusura tabella generale -->
