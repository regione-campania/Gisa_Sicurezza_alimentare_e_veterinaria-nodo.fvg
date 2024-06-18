<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneDaCanile,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
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
	EventoAdozioneDaCanile eventoF = (EventoAdozioneDaCanile) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di adozione -- <a href="#"
				onclick="openRichiestaPDF('PrintRichiestaAdozioneVersoAssocCanili', '<%=eventoF.getIdAnimale()%>', '<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', '<%=eventoF.getIdEvento()%>')"
				id="" target="_self">Richiesta di adozione</a></th>


	<tr>
		<td><b><dhv:label name="">Data dell'adozione</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataAdozione())%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Canile di provenienza</dhv:label></b>
		</td>
		<td>
		<%
			Operatore canile = eventoF.getCanileProvenienza();
			if (canile != null) {
				Stabilimento stab = (Stabilimento) (canile
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(canile.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
		</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Sindaco proprietario precedente</dhv:label></b></td>
		<td>
		<%
			Operatore sindaco = eventoF.getSindacoProvenienza();
			if (sindaco != null) {
				Stabilimento stab = (Stabilimento) (sindaco
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(sindaco.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
		</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Proprietario</dhv:label></b></td>
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
		%> -- <%
			}
		%>
		</td>
		
		
	</tr>


</table>