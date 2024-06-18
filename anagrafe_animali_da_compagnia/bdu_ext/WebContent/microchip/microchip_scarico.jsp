<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.microchip.base.*,java.text.DateFormat" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript">
</script>
<body>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
  Scarico microchip
</td>
</tr>
</table>
<%-- End Trails --%>
<form action="Microchip.do?command=EseguiScarico&auto-populate=true" method="post">


<table cellpadding="2" cellspacing="2" border="0" width="100%">
  <tr>
    <td width="100%" valign="top">
    
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	  <tr>
	    <th colspan="2">
		  <strong>Scarico Microchip a priori</strong>
		</th>
	  </tr>
	  
	  <tr class="containerBody">
	    <td nowrap class="formLabel">
	 	  Inserisci Microchip
	    </td>
	    <td>
	      <input name="microchip" type="text" size="20" maxlength="15">
	    </td>
	  </tr>
	  
	  <tr class="containerBody">
	    <td nowrap class="formLabel">
	 	  Motivazione
	    </td>
	    <td>
	      FUORI USO
	    </td>
	  </tr>

	</table>
		  
    <%= showError( request, "errore") %>
    
    <% if ( request.getAttribute("ok") != null ) { %>
    	<br>
    	<%= showAttribute( request, "ok") %>
    <% } %>
    
   </td>
  </tr>
</table>
<br />
<input type="submit" value="<dhv:label name="">Esegui Scarico</dhv:label>">
</form>
</body>