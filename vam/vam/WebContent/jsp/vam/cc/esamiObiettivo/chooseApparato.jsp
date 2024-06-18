<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<form action="vam.cc.esamiObiettivo.ToDetailSpecifico.us" name="form" method="post" class="marginezero">
           
   
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>

 	 <h4 class="titolopagina">
     		Scelta dell'apparato
    </h4>
    
    <table class="tabella">
    	<tr>
        	<th colspan="2">
        		Scegli apparato da analizzare
        	</th>
        </tr>              
        
    	<tr class='odd'>
    		<td>
    			Apparato
    		</td>
    		<td>
    			<select name="idApparato">
					<option value="">&lt;--- Selezionare l'apparato ---&gt;</option>
    				<c:forEach var="leoa" items="${leoa}">
            			<option value="<c:out value="${leoa.id}"/>">
            				${leoa.description}
    					</option>
            		</c:forEach>
    			</select>
    		</td>
        </tr>
        	
        <tr class='even'>
        	<td>
        	</td>
    		<td>    			
    			<input type="submit" value="Prosegui" onclick="attendere()"/>
    		</td>
        </tr>
	</table>
</form>