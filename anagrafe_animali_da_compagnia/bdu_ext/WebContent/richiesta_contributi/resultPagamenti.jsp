<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../initPage.jsp" %>


<jsp:useBean id="Asl" class="org.aspcfs.utils.web.LookupList" scope="request"/>


	<head>
		<link rel="stylesheet"  type="text/css" href="css/jmesa.css"></link>
		
		<script type="text/javascript" src="javascript/jquery-1.3.min.js"></script>
		<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
		<script type="text/javascript" src="javascript/jmesa.js"></script>
	</head>
		
	<%
		boolean resultPagamenti = (Boolean)session.getAttribute( "resultPagamenti" );
		
		
		if (resultPagamenti==true) {
		%>
		<font color="blue">
			Operazione eseguita con successo
		</font>
		<%}
		else {
		%><font color="red">
			Operazione non possibile perchè alcuni animali della lista già hanno ricevuto il pagamento
		</font>
		<%}%>
		
		
		