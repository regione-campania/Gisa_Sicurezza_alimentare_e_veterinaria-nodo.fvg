<%
String value 	= (String)request.getAttribute("value");

//Utile per la gestione del motivo del prelievo
%>


<form method="post"  name = "printbarcode" action="ManagePdfModules.do?command=PrintBarcode">
<input type = "hidden" name = "value" value = "<%=value %>"> 
<br>
<br>
<div align="center" style="color:#FF0000; font: bold;">
	Inserire i caratteri dell'etichetta <input type="text" name="num_verbale"><br><br>
	<input type="submit" value ="Genera barcode">	
	<input type="button" value ="Chiudi popup" onclick="window.close();">
</div>	
</form>
