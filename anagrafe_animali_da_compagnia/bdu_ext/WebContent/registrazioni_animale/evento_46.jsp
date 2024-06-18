<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneFuoriAsl,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	
<script type="text/javascript">
function openRichiestaAdozione(idAnimale, idEvento){
	var res;
	var result;
	window.open('AnimaleAction.do?command=PrintRichiestaAdozione&idEvento='+idEvento+'&idAnimale='+idAnimale,'popupSelect',
		'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}
</script>

<%
EventoAdozioneFuoriAsl eventoF = (EventoAdozioneFuoriAsl) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli dell'adozione -- <a href="#"
				onclick="openRichiestaPDF('PrintRichiestaAdozione', '<%=eventoF.getIdAnimale()%>', '<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', '<%=eventoF.getIdEvento()%>' )"
				id="" target="_self">Richiesta di adozione<img src="images/icons/stock_print-16.gif" width="16" height="16" border="0" align="absmiddle"></a></th>

	<tr>
		<td><b><dhv:label name="">Data della cessione</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataAdozioneFuoriAsl())%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Proprietario originario / Asl</dhv:label></b>
		</td>
		<td>
		<%
			Operatore proprietarioold = eventoF.getVecchioProprietario();
			if (proprietarioold != null) {
				Stabilimento stab = (Stabilimento) (proprietarioold
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(proprietarioold.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%> / <%=AslList.getSelectedValue(eventoF.getIdAslVecchioProprietario())%></td>
	</tr>
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
		<%
			} else {
		%> <%=eventoF.getDestinazione() %> <%
			}
		%>/ <%=AslList.getSelectedValue(eventoF.getIdAslNuovoProprietario())%>
		</td>
	</tr>


</table>