<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoSbloccoAnimale,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
EventoSbloccoAnimale eventoF = (EventoSbloccoAnimale) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli dello sblocco</th>

	<tr>
		<td><b><dhv:label name="">Data dello sblocco</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataSblocco())%>&nbsp;</td>
	</tr>

<dhv:evaluate if ="<%=(eventoF.isFlagRipristinaStatoPrecendente()) %>">

	<tr>
		<td><b><dhv:label name="">Nuovo proprietario / Asl</dhv:label></b></td>
		<td>
		<%
			Operatore proprietario = eventoF.getNuovoProprietario();
			if (proprietario != null) {
				Stabilimento stab = (Stabilimento) (proprietario
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(proprietario.getRagioneSociale())%></a>
		/ <%=AslList.getSelectedValue(stab.getIdAsl())%><%
			} 
		%>
		</td>
	</tr>
	
		<tr>
		<td><b><dhv:label name="">Nuovo detentore / Asl</dhv:label></b></td>
		<td>
		<%
			Operatore detentore = eventoF.getNuovoDetentore();
			if (detentore != null) {
				Stabilimento stabDet = (Stabilimento) (detentore
						.getListaStabilimenti().get(0));
				LineaProduttiva lineaD = (LineaProduttiva) (stabDet
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=lineaD.getId()%>"><%=toHtml(detentore.getRagioneSociale())%></a>
		 / <%=AslList.getSelectedValue(stabDet.getIdAsl())%> <%
			} %>
		</td>
	</tr>
	
</dhv:evaluate>	


</table>