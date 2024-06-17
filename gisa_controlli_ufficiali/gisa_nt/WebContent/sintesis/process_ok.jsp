<jsp:useBean id="msg" class="java.lang.String" scope="request"/>


<table style="border: 1px solid black">

<tr><td> Import terminato. </td> </tr>

<tr> <td> Sono stati riscontrati i seguenti problemi: 
<br/><br/>

<%if (msg!=null && !msg.equals("")){ %>
<font color="red"><%= msg%></font>
<%} else { %>
<font color="green">Nessun problema riscontrato.</font>
<%} %>
</td></tr>


</table>


