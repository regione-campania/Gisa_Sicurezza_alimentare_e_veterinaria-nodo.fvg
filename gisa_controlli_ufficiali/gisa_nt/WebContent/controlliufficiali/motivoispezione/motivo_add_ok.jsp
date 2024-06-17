<jsp:useBean id="idControlloUfficiale" class="java.lang.String" scope="request"/>

<script>
alert('Operazione eseguita.');
window.opener.location.href="Vigilanza.do?command=TicketDetails&id=<%=idControlloUfficiale%>";
window.close();
</script>



