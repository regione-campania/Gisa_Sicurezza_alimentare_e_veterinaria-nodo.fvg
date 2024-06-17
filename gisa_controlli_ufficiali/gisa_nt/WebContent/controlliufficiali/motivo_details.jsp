<%@page import="org.json.*"%>
<jsp:useBean id="jsonMotivi" class="java.lang.String" scope="request"/>


<%if (jsonMotivi!=null && !jsonMotivi.equals("")){%>

<table class="details">
<col width="10%"><col width="5%"><col width="45%"><col width="30%">
<tr><th>Tipo motivo</th><th>Alias</th><th>Descrizione</th><th>Per conto di</th></tr>

<% 
	JSONArray jsonMotiviArray = new JSONArray(jsonMotivi);
	for (int j = 0; j<jsonMotiviArray.length(); j++){
	JSONObject jsonMotivo = (JSONObject) jsonMotiviArray.get(j);

%>

<tr>
<td><%=jsonMotivo.get("tipo_motivo") %></td>
<td><%=jsonMotivo.get("alias_motivo") %></td>
<td><%=jsonMotivo.get("descrizione_motivo").toString().replace(">>", ">><br/>") %></td>
<td><%=jsonMotivo.get("per_conto_di")!=null && !jsonMotivo.get("per_conto_di").toString().equalsIgnoreCase("null") ? (jsonMotivo.get("per_conto_di").toString()).replace("->", "-><br/>") : "" %></td>
</tr>

<% } %>
</table>
<% } else { %>
Non sono presenti motivi.
<% } %>


