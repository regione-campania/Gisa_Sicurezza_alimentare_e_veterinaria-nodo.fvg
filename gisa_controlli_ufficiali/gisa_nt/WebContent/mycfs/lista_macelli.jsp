<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="org.aspcfs.modules.troubletickets.base.Ticket"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.ricercaunica.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="macelliList" class="java.util.ArrayList" scope="request"/>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../utils23/initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../utils23/initPopupMenu.jsp" %>

<center><b>Lista dai macelli associati a questa utenza</b></center>
<br/><br/>

<table cellpadding="8" cellspacing="0" border="0" style="width: 100%" class="pagedList">
<tr>
<th>RAGIONE SOCIALE</th>
<th>PARTITA IVA</th>
<th>ASL</th>
<th>APPROVAL NUMBER</th>
<th>SEDE OPERATIVA</th>
</tr>



<% for (int i = 0; i<macelliList.size(); i++) {
	RicercaOpu macello = (RicercaOpu) macelliList.get(i);
		%>

<tr>
<td><a href="StabilimentoSintesisAction.do?command=Details&altId=<%=macello.getRiferimentoId()%>"><%=macello.getRagioneSociale() %></a></td>
<td><%=macello.getPartitaIva() %></td>
<td><%=macello.getAsl() %></td>
<td><%=macello.getNumAut() %></td>
<td><%=macello.getIndirizzoSedeProduttiva() %></td>
</tr>


<% } %>
 
</table>





    

