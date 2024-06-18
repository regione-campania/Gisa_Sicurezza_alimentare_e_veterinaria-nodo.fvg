
<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoRilascioPassaporto"%>

<jsp:useBean id="veterinariChippatoriList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="veterinariChippatoriAll" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>

<%EventoRilascioPassaporto eventoF = (EventoRilascioPassaporto) evento; %>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>



<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli della registrazione di rilascio passaporto</th>

    <tr>  <td><b><dhv:label name="">Data di rilascio</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(eventoF.getDataRilascioPassaporto()) %>&nbsp;
      </td></tr>
      <tr>  <td><b><dhv:label name="">Data scadenza</dhv:label></b></td>
      	  <td >
      	<%=(eventoF.getDataScadenzaPassaporto() != null) ? toDateasString(eventoF.getDataScadenzaPassaporto()) : "--" %>&nbsp;
      </td></tr>
	<tr>  <td width="20%">
        <b><dhv:label name="">Numero del passaporto</dhv:label></b>
      </td>
       <td>
       <%=eventoF.getNumeroPassaporto() %>
  
	   </td></tr>
<tr>
		<td><b><dhv:label name="">Veterinario Rilascio Passaporto</dhv:label></b></td>
		<td>
<%
			if(eventoF.getIdVeterinarioPrivatoRilascioPassaporto()>0)
				out.println(veterinariChippatoriAll.getSelectedValue(eventoF.getIdVeterinarioPrivatoRilascioPassaporto()));
			else if(eventoF.getCfVeterinarioMicrochip()!=null)
				out.println("Codice fiscale: " + eventoF.getCfVeterinarioMicrochip());
%>
		</td>
	</tr>

  </table>