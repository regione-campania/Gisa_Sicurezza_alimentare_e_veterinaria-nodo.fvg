<%@page import="org.apache.batik.svggen.font.table.LookupList"%>
<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneAffido"%>
<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoAdozioneDaCanile,org.aspcfs.modules.opu.base.*"%>

<jsp:useBean id="associazioneAnimalistaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request" />
<script type="text/javascript">
function openRichiestaAdozioneAffidoTemporaneo(idAnimale, idEvento){
	var res;
	var result;
		window.open('AnimaleAction.do?command=PrintRichiestaAdozioneAffidoTemporaneo&idEvento='+idEvento+'&idAnimale='+idAnimale,'popupSelect',
		'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}
</script>
<%
	EventoAdozioneAffido eventoF = (EventoAdozioneAffido) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli della registrazione di adozione in affido temporaneo -- <a href="#"
				onclick="openRichiestaPDF('PrintRichiestaAdozioneAffidoTemporaneo', '<%=eventoF.getIdAnimale()%>', '<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', '<%=eventoF.getIdEvento()%>' )"
				id="" target="_self">Richiesta di adozione in affido temporaneo<img src="images/icons/stock_print-16.gif" width="16" height="16" border="0" align="absmiddle"></a></th>



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
		<td><b><dhv:label name="">Sindaco proprietario</dhv:label></b></td>
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
		<td><b><dhv:label name="">Socio affidatario</dhv:label></b></td>
		<td>
		
		<%
			Operatore socio = eventoF.getIdDetentoreDestinatarioRegistrazione();
			if (socio != null) 
			{
				Stabilimento stab = (Stabilimento) (socio.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(socio.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
		</td>
		
		
	</tr>
	
	<tr>
		<td><b><dhv:label name="">Associazione</dhv:label></b></td>
		<td>
			<%=associazioneAnimalistaList.getSelectedValue(eventoF.getIdAssociazione())%>			
		</td>
		
		
	</tr>


</table>