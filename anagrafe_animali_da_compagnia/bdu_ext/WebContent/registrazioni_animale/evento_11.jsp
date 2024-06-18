
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<jsp:useBean id="tipoSoggettoSterilizz" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="listaPratiche" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoSmarrimento,org.aspcfs.modules.opu.base.*"%>
<%EventoSmarrimento eventoF = (EventoSmarrimento) evento; %>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>

<script type="text/javascript">
function openDichiarazioneSmarrimento(idAnimale, idSpecie){
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
<th colspan="2">Dettagli della registrazione di smarrimento -- 	 <a href="#"
		onclick="openRichiestaPDF('PrintDichiarazioneSmarrimento', '<%=eventoF.getIdAnimale()%>','<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', '<%=eventoF.getIdEvento() %>')"
		id="" target="_self">Dichiarazione di smarrimento</a> -- <a href="#"
				onclick="openRichiestaPDF('PrintCertificatoSmarrimento', '<%=eventoF.getIdAnimale()%>','<%=eventoF.getSpecieAnimaleId()%>', '-1', '-1', <%=eventoF.getIdEvento() %>)"
				id="" target="_self">Certificato di smarrimento</a>
				</th></th>

    <tr>  <td><b><dhv:label name="">Data dello smarrimento</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(eventoF.getDataSmarrimento()) %>&nbsp;
      </td></tr>
	<tr>  <td width="20%">
        <b><dhv:label name="">Luogo dello smarrimento</dhv:label></b>
      </td>
       <td>
       <%=(eventoF.getLuogoSmarrimento() != null) ? eventoF.getLuogoSmarrimento() : "---"%>
  
	   </td></tr>
	   
	   
	
  	<!-- 	SINAAF ADEGUAMENTO  -->
	<tr><td><b><dhv:label name="">Comune di smarrimento</dhv:label></b></td>

  	<% if (eventoF.getIdComuneSmarrimento()!=-1 ) {%>
  		<td><%= comuniList.getSelectedValue(eventoF.getIdComuneSmarrimento())%></td>
  	 <%}  else  {	 %>
  	 <td></td>
  	 <%}  %>
     </tr>
    
    
	   
	<tr><td><b><dhv:label name="">Presenza importo per lo smarrimento</dhv:label></b></td>
  	<td>
  	 <%=(eventoF.isFlagPresenzaImportoSmarrimento())? "Si" : "No" %>
  	</td>
     </tr>
     
     	<tr><td><b><dhv:label name="">Importo per lo smarrimento</dhv:label></b></td>
  	<td>
  	 <%=(eventoF.getImportoSmarrimento()) %>
  	</td>
     </tr>


  </table>