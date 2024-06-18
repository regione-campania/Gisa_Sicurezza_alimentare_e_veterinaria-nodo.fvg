<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoPrelievoLeishmania,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="veterinariChippatoriList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="veterinariList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	
	

<%
EventoPrelievoLeishmania eventoF = (EventoPrelievoLeishmania) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>


<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di prelievo campioni leishmania -- 
	
					<a href="#"
					onclick="openRichiestaPDF('PrintRichiestaCampioni', '<%=eventoF.getIdAnimale()%>','<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', '<%=eventoF.getIdEvento() %>');"
					id="" target="_self">Scheda invio campioni Leishmania</a> --
				</th>

	<tr>
		<td><b><dhv:label name="">Data del prelievo</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataPrelievoLeishamania())%>&nbsp;</td>
	</tr>
	
	<tr>
		<td><b><dhv:label name="">Veterinario</dhv:label></b></td>
		<td>
		<dhv:evaluate if="<%=eventoF.getIdVeterinarioAsl() > 0 %>">
			<%=veterinariChippatoriList.getSelectedValue(eventoF.getIdVeterinarioAsl())%>
		</dhv:evaluate>
		
		<dhv:evaluate if="<%=eventoF.getIdVeterinarioLLPP() > 0 %>">
		<%=veterinariList.getSelectedValue(eventoF.getIdVeterinarioLLPP())%>
		</dhv:evaluate>
		</td>
	</tr>
	

</table>