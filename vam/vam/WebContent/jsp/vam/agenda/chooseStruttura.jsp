<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/vam/agenda/chooseStruttura.js"></script>

<form action="vam.agenda.ToDetail.us" name="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this);">
          
    <h4 class="titolopagina">
     		Scelta della struttura da prenotare
    </h4>
   
    <table class="tabella">
    	        
    	<tr class='odd'>
    		<td>
    			Struttura
    		</td>
    		<td>
    			<select name="idStrutturaClinica">
					<option value="-1">&lt;--- Selezionare la struttura ---&gt;</option>
    				<c:forEach var="s" items="${sp}">
            			<option value="<c:out value="${s.id}"/>">
            				${s.denominazione}
    					</option>
            		</c:forEach>
    			</select>
    		</td>
    		
        </tr>   
       		
        <tr class='even'>
        	<td>
        	</td>
    		<td>    			
    			<input type="submit" value="Dettaglio"/>    			
    		</td>
        </tr>
	</table>
</form>