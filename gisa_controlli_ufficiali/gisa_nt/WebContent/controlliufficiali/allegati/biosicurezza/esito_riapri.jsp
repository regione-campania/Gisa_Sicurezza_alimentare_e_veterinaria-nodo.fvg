<jsp:useBean id="idControllo" class="java.lang.String" scope="request"/>

<center>
<font size="5px">
La checklist e' stata riaperta.<br/>
E' ora possibile modificarla e re-inviarla.
</font>
 </center>

<script>
window.opener.loadModalWindow();
window.opener.location.href="Vigilanza.do?command=TicketDetails&id=<%=idControllo%>";
</script>