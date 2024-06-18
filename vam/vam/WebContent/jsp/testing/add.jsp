<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<form action="testing.AddError.us" name="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this);">
           
    <h4 class="titolopagina">
     		Dettagli dell'errore
    </h4>
   
    <table class="tabella">
    	
    	<tr class='odd'>
    		<td width="20%">
    			Descrizione errore
    		</td>
    		<td>
    			<TEXTAREA NAME="ricoveroNote" COLS=60 ROWS=3><c:out value="${cc.ricoveroNote}"></c:out></TEXTAREA>   			
    		</td>
        </tr>
        
        <tr class='even'>
    		<td width="20%">
    			Eventuale eccezione
    		</td>
    		<td>
    			<TEXTAREA NAME="ricoveroNote" COLS=60 ROWS=10><c:out value="${cc.ricoveroNote}"></c:out></TEXTAREA>   			
    		</td>
        </tr>
        
        <tr class='odd'>
        	<td width="20%">
    			Screenshot
    		</td>
    		<td> 
    		<img src="testingImages/c.jpg" height="60%" width="60%"/>
    		</td>
    	</tr>
    	
		
        <tr class='even'>
        	<td>
        	</td>
    		<td>    			
    			<input type="submit" value="Segnala errore""/>    			
    		</td>
        </tr>
	</table>
</form>