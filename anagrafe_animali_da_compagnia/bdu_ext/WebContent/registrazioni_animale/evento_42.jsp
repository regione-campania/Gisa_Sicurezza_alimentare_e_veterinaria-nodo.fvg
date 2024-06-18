<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoRientroFuoriStato,org.aspcfs.modules.opu.base.*"%>



<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>
<jsp:useBean id="continentiList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<%EventoRientroFuoriStato eventoF = (EventoRientroFuoriStato) evento; %>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>



<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli del rientro da fuori stato</th>

    <tr>  <td><b><dhv:label name="">Data del rientro</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(eventoF.getDataRientroFuoriStato())%>&nbsp;
      </td></tr>
	<tr>  <td width="20%">
        <b><dhv:label name="">Continente di origine del rientro</dhv:label></b>
      </td>
      
      <td><%=continentiList.getSelectedValue(eventoF.getIdContinenteDa())%></td>
  
	  </tr>
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