<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoCessioneImport,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
EventoCessioneImport eventoF = (EventoCessioneImport) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della cessione</th>

	<tr>
		<td><b><dhv:label name="">Data della cessione</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataCessioneImport() )%>&nbsp;</td>
	</tr>
<tr>
		<td><b><dhv:label name="">Asl di destinazione</dhv:label></b></td>
		<td>
		<%=AslList.getSelectedValue(eventoF.getIdAslNuovoProprietarioCessioneImport())%>
		</td>
	</tr>


</table>