<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoCambioUbicazione,org.aspcfs.modules.opu.base.*"%>



<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
	EventoCambioUbicazione eventoF = (EventoCambioUbicazione) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli del cambio ubicazione</th>

	<tr>
		<td><b><dhv:label name="">Data</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getData())%>&nbsp;
		</td>
	</tr>
	 
	
	


</table>