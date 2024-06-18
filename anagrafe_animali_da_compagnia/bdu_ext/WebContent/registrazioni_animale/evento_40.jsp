<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoFuoriRegioneSoloProprietario,org.aspcfs.modules.opu.base.*"%>



<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
EventoTrasferimentoFuoriRegioneSoloProprietario eventoF = (EventoTrasferimentoFuoriRegioneSoloProprietario) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>



<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli del trasferimento fuori regione del proprietario</th>

	<tr>
		<td><b><dhv:label name="">Data del trasferimento</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataTrasferimentoFuoriRegioneProprietario ())%>&nbsp;
		</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Regione del trasferimento</dhv:label></b>
		</td>
		<td><%=regioniList.getSelectedValue(eventoF.getIdRegioneFr())%></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Proprietario - Asl prima del trasferimento</dhv:label></b></td>
		<td>
		<%
			Operatore proprietarioVecchio = eventoF.getVecchioProprietario();
			if (proprietarioVecchio != null) {
				Stabilimento stab = (Stabilimento) (proprietarioVecchio
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(proprietarioVecchio.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>/ <%=AslList.getSelectedValue(eventoF
							.getIdAslVecchioProprietario())%>
		</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Detentore - Asl prima del trasferimento</dhv:label></b></td>
		<td>
		<%
			Operatore detentoreOLD = eventoF.getVecchioDetentore();
			if (detentoreOLD != null) {
				Stabilimento stab = (Stabilimento) (detentoreOLD
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(detentoreOLD.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%> / <%=AslList.getSelectedValue(eventoF
							.getIdAslVecchioDetentore())%>
		</td>
	</tr>


</table>