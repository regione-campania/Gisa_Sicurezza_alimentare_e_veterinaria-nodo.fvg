<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:useBean id="listaDocumenti" class="java.util.ArrayList" scope="request"/>

<%@ page import="java.util.*" %>
<jsp:useBean id="tipo" class="java.lang.String" scope="request"/>



   <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
		<tr>
				<th><strong>Data creazione</strong></th>
				<th><strong>Generato da</strong></th>
				<th><strong>Recupera</strong></th>
		</tr>
	
			
			<%
	String[] split;
	if (listaDocumenti.size()>0)
		for (int i=0;i<listaDocumenti.size(); i++){
			split = listaDocumenti.get(i).toString().split(";;");
			
			
			%>
			
			<tr>
			<td><%= split[0] %></td>
			<td><%= split[2] %>
			</td> 
			<td>
			
			<a href="documentale.DownloadPdf.us?codDocumento=<%=split[5]%>&idDocumento=<%=split[6] %>"><input type="button" value="DOWNLOAD"></input></a>
			
			</td> 
		</tr>
		<%} %>
		
		</table>
	<br>

		

  <!-- dhv:pagedListControl object="AssetTicketInfo"/-->



</body>
</html>