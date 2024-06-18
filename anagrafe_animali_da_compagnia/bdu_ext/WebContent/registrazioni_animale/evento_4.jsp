<jsp:useBean id="tipoSoggettoSterilizz" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="listaPratiche" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<%EventoFurto eventoF = (EventoFurto) evento; %>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>

<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoFurto"%>

<script type="text/javascript">
function openDichiarazioneFurto(idAnimale, idSpecie){
	var res;
	var result;
		window.open('AnimaleAction.do?command=PrintDichiarazioneSmarrimento&idAnimale='+idAnimale+'&idSpecie='+idSpecie,'popupSelect',
		'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}
</script>

<script type="text/javascript">
function openCertificatoSmarrimento(idAnimale, idSpecie){
	var res;
	var result;
		window.open('AnimaleAction.do?command=PrintCertificatoSmarrimento&idAnimale='+idAnimale+'&idSpecie='+idSpecie,'popupSelect',
		'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}
</script>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli della registrazione di furto
-- 	 <a href="#"
		onclick="openRichiestaPDF('PrintDichiarazioneFurto', '<%=eventoF.getIdAnimale()%>','<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', '<%=eventoF.getIdEvento() %>')"
		id="" target="_self">Dichiarazione di furto</a> -- <a href="#"
				onclick="openRichiestaPDF('PrintCertificatoFurto', '<%=eventoF.getIdAnimale()%>','<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', <%=eventoF.getIdEvento() %>)"
				id="" target="_self">Certificato di furto</a>
</th>

    <tr>  <td><b><dhv:label name="">Data del furto</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(eventoF.getDataFurto()) %>&nbsp;
      </td></tr>
	<tr>  <td width="20%">
        <b><dhv:label name="">Luogo del furto</dhv:label></b>
      </td>
       <td>
       <%=(eventoF.getLuogoFurto() != null)? eventoF.getLuogoFurto() : "" %>
  
	   </td></tr>
	   
	<!-- 	SINAAF ADEGUAMENTO  -->
	<tr><td><b><dhv:label name="">Comune del Furto</dhv:label></b></td>

  	<% if (eventoF.getIdComuneFurto()!=-1 ) {%>
  		<td><%= comuniList.getSelectedValue(eventoF.getIdComuneFurto())%></td>
  	 <%}  else  {	 %>
  	 <td></td>
  	 <%}  %>
     </tr>
     
	<tr><td><b><dhv:label name="">Dati della denuncia</dhv:label></b></td>
  	<td>
  	<%=(eventoF.getDatiDenuncia() != null)? eventoF.getDatiDenuncia() : "" %>
  	</td>
     </tr>


  </table>