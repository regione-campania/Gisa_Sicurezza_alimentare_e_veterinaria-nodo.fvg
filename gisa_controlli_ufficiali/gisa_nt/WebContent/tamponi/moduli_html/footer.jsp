<br/>
<TABLE rules="all" cellpadding="10" style="border-collapse: collapse">
<tr>
	<td style="text-align:center; width:200px; height:100px;border: 1px solid black;">
		<b>Codice<br>Quesito<br>Diagnostico</b> 
	</td>
	<td style="text-align:center; width:500px; height:100px;border: 1px solid black;">
		<% if(OrgTampone.getMotivazione() != null && !OrgTampone.getMotivazione().equals("") && 
				 OrgTampone.getBarcodeMotivazione() != null){ %>
			<img src="<%=createBarcodeImage(OrgTampone.getBarcodeMotivazione())%>" />
			<% } else { %>
				NON DISPONIBILE
			<% } %>
		
	</td>
</tr>
<tr>
	<td style="text-align:center; width:200px;height:100px;border: 1px solid black;">
		<b>Codice<br>Stabilimento</b>
	</td>
	<td style="text-align:center; width:500px;height:100px;border: 1px solid black;">
		<% if( OrgTampone.getBarcodeOSA() != null){ %>
		<img class="codeOsa" ="middle" src="<%=createBarcodeImage(OrgTampone.getBarcodeOSA())%>" />
		<% } else { %>
			NON DISPONIBILE
		<% } %>	
	</td>
</tr>
<tr>
	<td style="text-align:center; width:200px; heigth:100px;border: 1px solid black;">
		<b>Codice<br>Matrice</b> 
	</td>
	<td style="text-align:center;width:500px; height:100px;border: 1px solid black; ">
	<%	
		if(OrgTampone.getCodiciMatrice() != null && !OrgTampone.getCodiciMatrice().equals("")){
			int k = 0;
			StringTokenizer st = new StringTokenizer(OrgTampone.getCodiciMatrice(),";");
			while(st.hasMoreTokens()){
				++k;  %>
				<img align="middle" src="<%=createBarcodeImage(st.nextToken())%>"/><br><br>
				  
			<% 
			} 
		}  else { %>
			NON DISPONIBILE
		<% } %>	
		</td>   	
</tr>
</TABLE>