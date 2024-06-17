<jsp:useBean id="url" class="java.lang.String" scope="request" />

<%
//Faccio questo perchè se il protocollo non è https, nella url non 
//compare e il browser blocco per questione di sicurezza la navigazione verso un protocollo sconosciuto
String protocollo = "";
if(url.indexOf("http")<0)
	protocollo = "http://";
%>
<script type="text/javascript">
window.location.href='<%=protocollo+url%>';
</script>