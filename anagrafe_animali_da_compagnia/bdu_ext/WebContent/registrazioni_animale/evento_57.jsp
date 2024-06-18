<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoBloccoAnimale"%>
<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoBloccoAnimale,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
EventoBloccoAnimale eventoF = (EventoBloccoAnimale) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>


<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di blocco animale
				</th>

	<tr>
		<td><b><dhv:label name="">Data del blocco</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataBlocco())%>&nbsp;</td>
	</tr>
	
	<tr>
		<td><b><dhv:label name="">Note</dhv:label></b></td>
		<td><%=toHtml(eventoF.getNoteBlocco())%>&nbsp;</td>
	</tr>
	
<%-- 	<tr>
		<td><b><dhv:label name="">Note restituzione</dhv:label></b></td>
		<td><%=toHtml(eventoF.getNoteRestituzione())%>&nbsp;</td>
	</tr> --%>
	

</table>