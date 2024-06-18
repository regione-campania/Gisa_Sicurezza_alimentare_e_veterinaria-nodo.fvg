<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoPrelievoDNA,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="veterinariList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
EventoPrelievoDNA eventoF = (EventoPrelievoDNA) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>


<script type="text/javascript">
function openCertificatoPrelievoDNA(idAnimale, idSpecie){
	var res;
	var result;
		window.open('AnimaleAction.do?command=PrintCertificatoPrelievo&idAnimale='+idAnimale+'&idSpecie='+idSpecie,'popupSelect',
		'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}
</script>

<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di prelievo -- 
	
	<a href="#"
				onclick="openRichiestaPDF('PrintCertificatoPrelievo', '<%=eventoF.getIdAnimale()%>','<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', '<%=eventoF.getIdEvento() %>')"
				id="" target="_self">Certificato di prelievo</a> --
				</th>

	<tr>
		<td><b><dhv:label name="">Data del prelievo</dhv:label></b></td>
		<td><%=toDateasString(eventoF.getDataPrelievo())%>&nbsp;</td>
	</tr>
	
	<tr>
		<td><b><dhv:label name="">Veterinario</dhv:label></b></td>
		<td><%=veterinariList.getSelectedValue(eventoF.getIdVeterinario())%>&nbsp;</td>
	</tr>
	

</table>