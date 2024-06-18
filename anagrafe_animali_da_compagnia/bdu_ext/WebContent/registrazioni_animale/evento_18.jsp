<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoCambioDetentore,org.aspcfs.modules.opu.base.*"%>



<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<%EventoCambioDetentore eventoF = (EventoCambioDetentore) evento; %>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>



<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli del cambio detentore</th>

    <tr>  <td><b><dhv:label name="">Data del cambio detentore</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(eventoF.getDataModificaDetentore())%>&nbsp;
      </td></tr>

	<tr><td><b><dhv:label name="">Dati vecchio detentore</dhv:label></b></td>
  	<td>
  	  	<% 
 	  
 	  Operatore detentoreO = eventoF.getOldDetentore();
 	  if (detentoreO != null) { 
        Stabilimento stab = (Stabilimento) (detentoreO.getListaStabilimenti().get(0));
        LineaProduttiva linea = (LineaProduttiva)( stab.getListaLineeProduttive().get(0));
 	  %>
			<a href="OperatoreAction.do?command=Details&opId=<%= linea.getId() %>"><%= toHtml(detentoreO.getRagioneSociale()) %></a>
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