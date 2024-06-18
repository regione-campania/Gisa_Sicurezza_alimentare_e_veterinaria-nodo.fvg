<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoModificaResidenza,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	


<%
EventoModificaResidenza eventoF = (EventoModificaResidenza) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della modifica residenza</th>

	<tr>
		<td><b><dhv:label name="">Data della modifica</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataModificaResidenza())%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Indirizzo originario</dhv:label></b>
		</td>
		<td>
		<%
			Indirizzo oldIndirizzo = eventoF.getOldIndirizzo();%>
		 <%=oldIndirizzo.toString()%></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Nuovo indirizzo </dhv:label></b></td>
		<td>
		<%
			Indirizzo newIndirizzo = eventoF.getNewIndirizzo();%>
		 <%=newIndirizzo.toString()%>
		</td>
	</tr>


</table>