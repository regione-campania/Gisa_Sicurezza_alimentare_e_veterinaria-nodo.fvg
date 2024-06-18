<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoRientroFuoriRegione,org.aspcfs.modules.opu.base.*"%>



<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>
<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<%EventoRientroFuoriRegione eventoF = (EventoRientroFuoriRegione) evento; %>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>



<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli del rientro da fuori regione</th>

    <tr>  <td><b><dhv:label name="">Data del rientro</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(eventoF.getDataRientroFR())%>&nbsp;
      </td></tr>
	<tr>  <td width="20%">
        <b><dhv:label name="">Regione di origine del rientro</dhv:label></b>
      </td>
       <td>
       <%=regioniList.getSelectedValue(eventoF.getIdRegioneDa()) %>
  
	   </td></tr>
	<tr><td><b><dhv:label name="">Dati del nuovo proprietario</dhv:label></b></td>
  	<td>
  	  	<% 
 	  
 	  Operatore proprietario = eventoF.getProprietario();
 	  if (proprietario != null) { 
        Stabilimento stab = (Stabilimento) (proprietario.getListaStabilimenti().get(0));
        LineaProduttiva linea = (LineaProduttiva)( stab.getListaLineeProduttive().get(0));
 	  %>
			<a href="OperatoreAction.do?command=Details&opId=<%= linea.getId() %>"><%= toHtml(proprietario.getRagioneSociale()) %></a>
	<%}else{ %>
	--
	<%} %>
  	</td>
     </tr>
     <tr><td><b><dhv:label name="">Dati del nuovo detentore</dhv:label></b></td>
  	<td>
  	<% 
 	  
 	  Operatore detentore = eventoF.getDetentore();
 	  if (detentore != null) { 
        Stabilimento stab = (Stabilimento) (detentore.getListaStabilimenti().get(0));
        LineaProduttiva linea = (LineaProduttiva)( stab.getListaLineeProduttive().get(0));
 	  %>
			<a href="OperatoreAction.do?command=Details&opId=<%= linea.getId() %>"><%= toHtml(detentore.getRagioneSociale()) %></a>
	<%}else{ %>
	--
	<%} %>
	  </td>
     </tr>
    


  </table>