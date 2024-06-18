<table class="trails" cellspacing="0">
<tr>
<td>
<a href="MyCFS.do?command=Home"><dhv:label name="My Home Page" mainMenuItem="true">La Mia Home Page</dhv:label></a> >
Post-it
</td>
</tr>
</table>

<form name="messageForm" action="PostIt.do?command=Messaggio" method="post">

<table cellpadding="2" cellspacing="2" border="0" width="100%">
	<tr>
	    <td width="50%" valign="top">
	    	<table cellpadding="4" cellspacing="0" border="0" width="50%" class="details">
	        	<tr>
	          		<th colspan="2"><strong>Post-it</dhv:label></strong></th>
	        	</tr>
		       
		        <tr>
	          		<td nowrap class="formLabel">Messaggio</td>
	          		<td><textarea cols="150" rows="4" name="messaggio"><jsp:include page="../templates/postit.txt" flush="true" /></textarea></td>
	        	</tr>
		        
				
		        
			</table>
			<input type="submit" value="Salva"></input><br/>
			<p style="color: red;"><%= request.getAttribute("mess") != null ? request.getAttribute("mess") : ""%></p>
		</td>
	</tr>
</table>

</form>