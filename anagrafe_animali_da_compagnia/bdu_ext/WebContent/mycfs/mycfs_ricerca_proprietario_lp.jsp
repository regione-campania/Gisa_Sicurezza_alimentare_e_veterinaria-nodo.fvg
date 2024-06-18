<%-- Trails --%>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/submit.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript"
        SRC="javascript/popCalendar.js"></script>
<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="MyCFS.do?command=Home"><dhv:label name="My Home Page" mainMenuItem="true">My Home Page</dhv:label></a> >
			<dhv:label name="">Ricerca Proprietario</dhv:label>
		</td>
	</tr>
</table>

<form id="searchForm" name="searchForm" action="MyCFS.do?command=RicercaProprietarioLP" method="post">
<%
	String errore = (String)request.getAttribute( "errore" ); 
%>
<%=(errore == null) ? ("") : (errore) %>
<br/>

Microchip 
<input type="text" name="mc" id="mc" value="" maxlength="15"/>
<input type="button" value="Ricerca" onclick="if(document.getElementById('mc').value==''){alert('Inserire il microchip da ricercare');}else{document.getElementById('searchForm').submit();}">
</form>