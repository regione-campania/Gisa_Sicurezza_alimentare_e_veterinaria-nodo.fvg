<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoTrasferimentoFuoriStato,org.aspcfs.modules.opu.base.*"%>



<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="continentiList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
	EventoTrasferimentoFuoriStato eventoF = (EventoTrasferimentoFuoriStato) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>


<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli del trasferimento fuori stato</th>

	<tr>
		<td><b><dhv:label name="">Data del trasferimento</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataTrasferimentoFuoriStato())%>&nbsp;
		</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Continente del trasferimento</dhv:label></b>
		</td>
		<td><%=continentiList.getSelectedValue(eventoF.getIdContinente())%></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Dati del proprietario fuori stato</dhv:label></b></td>
			
			<% if (eventoF.getDatiProprietarioFuoriStato() != null && !("").equals(eventoF.getDatiProprietarioFuoriStato())){%>
		
		<td><%=	eventoF.getDatiProprietarioFuoriStato()%></td>

		<%} else {%>

			 <%
			 Operatore proprietarioFR= eventoF.getProprietarioFuoriRegione();
		  	 if (proprietarioFR != null) {
						Stabilimento stabFR = (Stabilimento) (proprietarioFR.getListaStabilimenti().get(0));
						LineaProduttiva lineaFR = (LineaProduttiva) (stabFR.getListaLineeProduttive().get(0));
				%><td> <a
					href="OperatoreAction.do?command=Details&opId=<%=lineaFR.getId()%>"><%=toHtml(proprietarioFR.getRagioneSociale())%></a></td> 
				<%
			} else {
				%> <td>--</td>  <%
					}
				%><%-- / <%=AslList.getSelectedValue(eventoF.getid())%> --%>
		
		     
		
		<% } %>
		
		
		
		
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