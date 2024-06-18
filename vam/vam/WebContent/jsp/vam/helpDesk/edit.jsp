<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<script language="JavaScript" type="text/javascript" src="js/vam/helpDesk/edit.js"></script>

<form action="vam.helpDesk.Edit.us" name="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this);">               
   
   <input type="hidden" name="idTicket" value="${t.id }"/>
   
   <h4 class="titolopagina">
    		Dettaglio segnalazione numero ${t.id}
   </h4>
   <table class="tabella">
   	   
   	<tr>
   		<th colspan="2">
   			Richiesta effettuata da ${t.enteredBy.nome} ${t.enteredBy.cognome} 
   			in data <fmt:formatDate type="date" value="${t.entered}" pattern="dd/MM/yyyy" var="dataRichiesta"/>
   			 <c:out value="${dataRichiesta}"/>
   		</th>
   	</tr>
   	     
       
       <tr class='even'>
   		<td>
   			Tipologia di segnalazione
   		</td>
   		<td>
   			 ${t.lookupTickets.description}
   		</td>
       </tr>
       
        <tr class='odd'>
   		<td>
   			Descrizione
   		</td>
   		<td>
   			${t.description }
   		</td>
       </tr>
       
        <tr class='even'>
   		<td>
   			Indirizzo e-mail di risposta
   		</td>
   		<td>
   			 ${t.email}
   		</td>
       </tr>
             
              
       <tr class='odd'>
   		<td>
   			Descrizione di chiusura<font color="red"> *</font>
   		</td>
   		<td>   			 
	    	<textarea name="closureDescription" rows=7 cols=63></textarea>
   		</td>
       </tr>       
	
       <tr class='even'>
       	<td>
       		<font color="red">* </font> Campi obbligatori
       	</td>
   		<td>    			
   			<input type="submit" value="Chiudi segnalazione" />
    		<input type="button" value="Annulla" onclick="attendere(), location.href='Home.us'">
   		</td>
       </tr>
	</table>
</form>
