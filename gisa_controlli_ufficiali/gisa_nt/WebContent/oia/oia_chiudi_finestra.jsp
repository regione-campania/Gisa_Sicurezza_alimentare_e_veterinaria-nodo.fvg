<script type="text/javascript">
	function chiudi_e_aggiorna_chiamante() {
		//alert('OK');
		//window.opener.location.reload ();
		//window.opener.location.reload ();
		//window.close();

		window.resizeBy(100, 100);  
		
	}
</script>

<body onLoad="javascript:chiudi_e_aggiorna_chiamante()">

<%
	if (Boolean.parseBoolean( request.getAttribute("bOperazioneOK").toString() )) { %>
			<font color="green"><%= request.getAttribute("sMessaggioOperazione") %></font>
<%	} else { 	%>
			<font color="red"><%= request.getAttribute("sMessaggioOperazione") %></font>
<%	} %>

</body>