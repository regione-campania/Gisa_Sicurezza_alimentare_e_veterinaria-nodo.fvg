<%@page import="org.aspcfs.modules.login.beans.UserBean"%>
<%@page import="org.aspcfs.modules.util.imports.ApplicationProperties"%>

<link rel="stylesheet" type="text/css" href="css/colore_demo.css"></link>	
<link rel="stylesheet" type="text/css" href="css/demo.css"></link>		
<link rel="stylesheet" type="text/css" href="css/custom.css"></link>	
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>
<link rel="stylesheet" type="text/css" href="css/capitalize.css"></link>		

<script src='javascript/modalWindow.js'></script>
<script src='javascript/jquerymini.js'></script>	
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
 
<script>
function wait()
{
	
setTimeout(function(){document.getElementById("goRsfavanzata").submit();}, 1000);

}
</script>
<body onload="wait()">
<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<% System.out.println("id_asl RSF: "+ User.getSiteId());
%>

<% 
String urlMatrix = "";
try {urlMatrix = ApplicationProperties.getUrlFromMon("matrix");} catch (Exception e) {e.printStackTrace();}; 
	
%>

<form name="goRsfavanzata" id="goRsfavanzata" action="<%=urlMatrix%>/tables/grid.php?id_asl=<%=(User.getSiteId() > 0) ? (User.getSiteId()) : (-1) %>" method="post">
</form>
</body> 


