<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr><th colspan="2"><strong>Gestione sanitaria</strong></th>
	
	<tr>
		<td nowrap class="formLabel" > Stato classificazione</td>
		<td><%=StatiClassificazione.getSelectedValue(OrgDetails.getStatoClassificazione()) %></td>
	</tr>


<% if (OrgDetails.getStatoClassificazione()==Organization.STATO_CLASSIFICAZIONE_REVOCATO){ %>
	<tr>
		<td nowrap class="formLabel" > Data Revoca</td>
		<td><%=toDateasString(OrgDetails.getDataRevoca()) %></td>
	</tr>
	<%} %>
	<% if (OrgDetails.getStatoClassificazione()==Organization.STATO_CLASSIFICAZIONE_SOSPESO){ %>
	<tr>
		<td nowrap class="formLabel" > Data Sospensione</td>
		<td><%=toDateasString(OrgDetails.getDataSospensione()) %></td>
	</tr>
	<%} %>


<%if(OrgDetails.getDataProvvedimento()!=null)
		{
	%>
	<tr id = "zc4">
		<td nowrap class="formLabel" > Data Provvedimento</td>
		<td>
		<%if(OrgDetails.getDataProvvedimento()!=null) {
			%>
			<%=sdf.format(new Date(OrgDetails.getDataProvvedimento().getTime())) %>
			<%
		}
		%>
			
		</td>
	</tr>
	<%} %>
	
	<%if(OrgDetails.getProvvedimento()!=null && !"".equals(OrgDetails.getProvvedimento()))
		{%>
	<tr id = "zc5">
		<td nowrap class="formLabel" name="orgname1" id="orgname1"> Provvedimento restrittivo in atto </td>
		<td><%=toHtml2(OrgDetails.getProvvedimento()) %></td>
	</tr>
	<%} %>


	
	<%
	if(OrgDetails.getProvvedimentiRestrittivi()==13)
	{
	%>
	<tr>
		<td nowrap class="formLabel" >Data Rifiuto</td>
		<td>
		<%=toDateasString(OrgDetails.getDataRifiuto()) %> </td>
	</tr>
	
	<tr>
		<td nowrap class="formLabel" >Motivazione Rifiuto</td>
		<td>
		<%=RifiutoClassificazione.getSelectedValue(OrgDetails.getIdMotivazioneRifiuto()) %> </td>
	</tr>
	<%} %>
	
<!-- 	<tr> -->
<!-- 		<td nowrap class="formLabel" > Stato</td> -->
<!-- 		<td> -->
<%-- 		<%=OrgDetails.getStato() %> </td> --%>
<!-- 	</tr> -->
	
	
</table>