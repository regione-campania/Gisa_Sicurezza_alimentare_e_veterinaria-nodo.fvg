<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <jsp:useBean id="tipo"
	class="java.lang.String" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<font color="red" size="2" face="Verdana, Arial, Helvetica, sans-serif">Non è possibile procedere: il microchip non risulta in banca dati.<br>
Per inviare la richiesta di prelievo all'istituto è necessario regolarizzare le posizioni in banca dati
<br><br>

<%if (tipo.equals("1")) {%>
<a href="GeneraBarCode.do"> <<< Torna indietro</a></font>
<%} %>
</body>
</html>