<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ include file="../../utils23/initPage.jsp"%>
<jsp:useBean id="listaPartite" class="java.util.Vector" scope="request"/>

 
 
<%@page import="org.aspcfs.modules.mu.base.PartitaUnivoca"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<script
	language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>

 <script>$(document).ready(function() {
      // Initialize Smart Wizard
      loadModalWindowUnlock();
      
    //  $('#wizard').smartWizard(); 
//       $('#wizard').smartWizard(    		  
//     		     {
//     		      divHeadPaddingLeft:  2,
//     		      divBodyPaddingLeft:   2,
//     		      fixedTypeNumber:  1
    		      			
//     		      	    }); 

      
  }); 
</script>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script type="text/javascript">
	//loadModalWindow();
	loadModalWindowCustom('<div style="color:red; font-size: 40px;">Attendere prego.... </div>');
	</script>
<html>

<body>

<table class="trails" cellspacing="0">
	<tr>
		<td>
					<a href="MacellazioneUnica.do?command=List&orgId=<%=request.getParameter("orgId")%>">Home macellazioni </a> > Lista partite
		</td>
	</tr>
</table>

<%
String param1 = "orgId=" + request.getParameter("orgId");
%>
<dhv:container name="stabilimenti_macellazioni_ungulati" selected="macellazioniuniche" object="OrgDetails" param="<%= param1 %>" >
      <input type="hidden" id="dimensioneLista" name="dimensioneLista" value="<%=listaPartite.size() %>"/>
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr> <th colspan="4"> <center>Lista partite</center> </th></tr>
  
		<tr>
			<th><strong>Numero</strong></th>
			<th><strong>Codice azienda provenienza</strong></th>
			<th><strong>Mod. 4</strong></th>
			<th><strong>Data di arrivo al macello</strong></th>
		</tr>
	
			
			<%
	
	if (listaPartite.size()>0){
		for (int i=0;i<listaPartite.size(); i++){
			PartitaUnivoca partita = (PartitaUnivoca) listaPartite.get(i); %>
			
			<tr class="row<%=i%2%>">
			<td><a href="javascript:popURL('MacellazioneUnica.do?command=DettaglioPartita&idPartita=<%=partita.getId()%>&popup=true', null, '800px', null, 'yes', 'yes')"><%=partita.getNumeroPartita() %></a></td>
			<td><%=partita.getCodiceAziendaProvenienza() %></td>
			<td><%=partita.getMod4() %></td>
			<td><%=toDateasString(partita.getDataArrivoMacello()) %></td>
			
			</tr>
			<% } } else {%>
		<tr><td colspan="8"> Non sono state trovate partite. &nbsp; </td></tr>
		
		<% } %>
		
		</table>
</dhv:container>

</body>
</html>