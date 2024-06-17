<jsp:useBean id="link" class="java.lang.String" scope="request"/>

<script>
window.parent.location.href='<%=link%>';
</script>