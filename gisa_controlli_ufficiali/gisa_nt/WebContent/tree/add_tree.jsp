
<%@page import="java.util.ArrayList"%>

<%
ArrayList<String> listaCombo = (ArrayList<String>)request.getAttribute("ListaCombo");
%>

<%@page import="java.sql.SQLException"%><form method = "post" action="Tree.do?command=CreateTree">
<table>
<tr>
<td>Combo di PartenzA</td>
<td>
<SELECT name = "tabella">
<option value = "-1">SELEZIONA VOCE</option>
<%
	for(String tabella : listaCombo)
	{
		%>
		<option value = "<%=tabella %>"><%=tabella %></option>
		<%
	}
%>
</SELECT>
</td>
</tr>
<tr>
<td>Nome Relazione</td>
<td>
<input type = "text" name = "nomeRelazione">
</td>
</tr>
<tr>
<td>Descrizione</td>
<td>
<textarea rows="6" cols="30" name = "descrizione" ></textarea>
</td>
</tr>
</table>
<input type = "submit" value = "Crea">
</form>

<%if(request.getAttribute("Errore")!=null) 
{
SQLException error = (SQLException) request.getAttribute("Errore");
%>
<font color="red">
Attenzione! Verificare il seguente errore : <%=error.getMessage()%>
</font>
<%}%>