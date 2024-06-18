
<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoInserimentoMicrochip,org.aspcfs.modules.opu.base.*"%>
<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoInserimentoMicrochip"%>
<jsp:useBean id="tipoSoggettoSterilizz"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="veterinariChippatoriList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="veterinariChippatoriAll" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />

<%
	EventoInserimentoMicrochip eventoF = (EventoInserimentoMicrochip) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>


<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di inserimento
	microchip</th>

	<tr>
		<td><b><dhv:label name="">Data dell'inserimento</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataInserimentoMicrochip())%>&nbsp;</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Numero microchip</dhv:label></b></td>
		<td><%=eventoF.getNumeroMicrochipAssegnato()%></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Veterinario chippatore</dhv:label></b></td>
		<td>
		<%
			if(eventoF.getIdVeterinarioPrivatoInserimentoMicrochip()>0)
				out.println(veterinariChippatoriAll.getSelectedValue(eventoF.getIdVeterinarioPrivatoInserimentoMicrochip()));
			else if(eventoF.getCfVeterinarioMicrochip()!=null)
				out.println("Codice fiscale: " + eventoF.getCfVeterinarioMicrochip());
		%>
		
		</td>
	</tr>
</table>