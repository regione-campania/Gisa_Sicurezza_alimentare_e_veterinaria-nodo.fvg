<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>

		<h4 class="titolopagina">
     		Dettaglio Rinvenimento 
    	</h4>
     	
    	<jsp:include page="/jsp/sinantropi/menuCatture.jsp"/>   		 
		<script type="text/javascript">
				ddtabmenu.definemenu("ddtabs2",1);	
		</script> 
		   	
<table class="tabella">
    	

    	       
        <tr>
        	<th colspan="3">
        		Dettaglio Rinvenimento
        	</th>        	
        </tr>
        
         <tr class='odd'>
    		<td>
    			Data
    		</td>
    		<td>
				<fmt:formatDate type="date" value="${c.dataCattura}" pattern="dd/MM/yyyy" var="dataCattura"/>
  				<c:out value="${dataCattura}"/>
    		</td>
    		<td>				
    		</td>
        </tr>
           
        
        <tr class='even'>
    		<td>
    			Provincia e Comune Rinvenimento
    		</td>
    		<td>				
  				<c:choose>			
					<c:when test="${c.comuneCattura.bn == true}">
						<c:out value="Benevento"></c:out>	
					</c:when>
					<c:when test="${c.comuneCattura.na == true}">
						<c:out value="Napoli"></c:out>	
					</c:when>
					<c:when test="${c.comuneCattura.sa == true}">
						<c:out value="Salerno"></c:out>	
					</c:when>
					<c:when test="${c.comuneCattura.av == true}">
						<c:out value="Avellino"></c:out>	
					</c:when>
					<c:when test="${c.comuneCattura.ce == true}">
						<c:out value="Caserta"></c:out>	
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
    		</td>
    		<td>
    			<c:out value="${c.comuneCattura.description}"/>				
    		</td>
        </tr>
        
        <tr class='odd'>
    		<td>
    			Luogo di detenzione
    		</td>
    		<td>				
  				<c:out value="${c.luogoCattura}"/>
    		</td>
    		<td>				
    		</td>
        </tr>
                
        <tr class='even'>
    		<td>
    			Note relative al Rinvenimento
    		</td>
    		<td>				
  				<c:out value="${c.noteCattura}"/>
    		</td>
    		<td>				
    		</td>
        </tr>
        
		
        <tr class='odd'>
        	<td>
        	</td>
    		<td>    			
    			<input type="button" value="Modifica Scheda" onclick="attendere(), location.href='sinantropi.catture.ToEdit.us?idCattura=${c.id}'">
	    	</td>
    		<td>
        	</td>
        	<td>
        	</td>
        </tr>
	</table>