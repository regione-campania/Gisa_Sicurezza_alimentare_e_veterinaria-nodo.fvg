<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="info" class="org.json.JSONObject" scope="request"/>

<script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>



<body>

<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="RegistroTrasgressori.do?command=RegistroSanzioni">Registro Trasgressori</a> > 
Cerca Avviso di Pagamento
</td>
</tr>
</table>
<%-- End Trails --%>


<form name="searchAvviso" action="RegistroTrasgressori.do?command=SearchAvviso&auto-populate=true" method="post">

<center>
<table class="details" cellpadding="10" cellspacing="10" width="80%">
<col width="30%">
<tr><th colspan="2">RICERCA AVVISO DI PAGAMENTO</th></tr>

<% for(int i = 0; i<info.names().length(); i++){%>
<tr>
<td class="formLabel"><%= info.names().getString(i)%></td>
<td>

<% if (info.names().getString(i).equalsIgnoreCase("PDF AVVISO O RICEVUTA")){ %>
<a href="#" onClick="openRichiestaDownload('<%= info.get(info.names().getString(i)) %>', '<%= info.get(info.names().getString(i)) %>', 'true'); return false;">DOWNLOAD</a>
<% } else { %>
<%=info.get(info.names().getString(i)) %>
<% } %>

</td>
</tr>
<%} %>

</table>

</center>

</form>

<br/><br/>
<center>
<a href="RegistroTrasgressori.do?command=SearchFormAvviso">Nuova ricerca</a>
</center>
<br/><br/>



</body>

</html>