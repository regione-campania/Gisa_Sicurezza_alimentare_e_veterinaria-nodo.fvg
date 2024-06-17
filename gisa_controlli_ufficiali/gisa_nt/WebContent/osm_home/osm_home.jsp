<% if (1==1) { %>
<%@ include file="/ricercaunica/ricercaDismessa.jsp" %>
<%} else { %>

<%--Pagina JSP creata da Alberto --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>

<%@ include file="../utils23/initPage.jsp" %>
<body>

<table class="trails" >
	<tr > 
		<td width="100%">
			Seleziona operazione 
		</td> 
	</tr>
</table>

<form name="scelta" action="" method="post">
	<table >
	  <tr>
	   <td>
	    	<input	type="submit"
      				name="OSM Riconosciuti"
	      			value="OSM Riconosciuti"
    	  			onclick="javascript:this.form.action='Osm.do?command=Dashboard'"
      		/>
	    </td>
	  
	  
	    <td>
	    	<input type="submit" 
	    		   name="OSM Registrati" 
	    		   value="OSM Registrati - Produttori Primari"
    	  		   onclick="javascript:this.form.action='OsmRegistrati.do?command=Dashboard'"
        	/>
	    </td>
	  </tr>
	
	</table>
</form>

<br/>

</body>


<% } %>