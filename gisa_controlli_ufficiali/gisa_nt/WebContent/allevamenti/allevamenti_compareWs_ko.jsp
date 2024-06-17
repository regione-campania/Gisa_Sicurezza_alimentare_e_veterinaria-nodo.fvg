<jsp:useBean id="Messaggio" class="java.lang.String" scope="request"/>

<font color="red" size="5px">

<%if (Messaggio!=null && !Messaggio.equals("")){ %>
<%=Messaggio %>
<% } else { %>
Questa operazione non puo' essere eseguita in automatico dal sistema. <br/>
Contattare l'Help Desk.
<% } %>
</font>