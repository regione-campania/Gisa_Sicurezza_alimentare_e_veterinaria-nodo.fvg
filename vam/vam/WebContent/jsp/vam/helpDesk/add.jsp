<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<script language="JavaScript" type="text/javascript" src="js/vam/helpDesk/add.js"></script>


<form action="vam.helpDesk.Add.us" name="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this);">
               
    <h4 class="titolopagina">
     		Nuova segnalazione
    </h4>
    <table class="tabella">
    	   
    	<tr>
    		<th colspan="2">
    			Richiesta effettuata da ${utente.nome} ${utente.cognome} 
    			in data <fmt:formatDate type="date" value="${dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/>
    			 <c:out value="${dataRichiesta}"/>
    		</th>
    	</tr>
    	     
        
        <tr class='even'>
    		<td>
    			Tipologia di segnalazione<font color="red"> *</font>
    		</td>
    		<td>
    			 <select style="width:98%" name="tipologiaTicket" id="tipologiaTicket"">
						<option value="0">&lt;----------&gt;</option>	 						
			        	 <c:forEach items="${tipologieTickets}" var="tt" >	
			        	 	<option value="${tt.id }">${tt.description }</option>	        	 				
						</c:forEach>
		     
    			</select>
    		</td>
        </tr>
        
         <tr class='odd'>
    		<td>
    			Descrizione<font color="red"> *</font>
    		</td>
    		<td>    			
	    		<textarea name="description" rows=7 cols=63></textarea>
    		</td>
        </tr>
        
         <tr class='even'>
    		<td>
    			Indirizzo e-mail (in caso si desideri ricevere una risposta) <font color="red"> *</font>
    		</td>
    		<td>
    			 <input type="text" name="email" maxlength="250" size="35"/>
    		</td>
        </tr>
                 
		
        <tr class='odd'>
        	<td>
        		<font color="red">* </font> Campi obbligatori
        	</td>
    		<td>    			
    			<input type="submit" value="Aggiungi" />
    			<input type="button" value="Annulla" onclick="attendere(), location.href='Home.us'">
    			
    		</td>
        </tr>
	</table>
</form>