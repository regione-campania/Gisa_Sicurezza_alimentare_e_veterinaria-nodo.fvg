<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/diagnosticaImmagini/rx/edit.js"></script>
<script language="JavaScript" type="text/javascript" src="js/azionijavascript.js"></script>

<form action="vam.cc.diagnosticaImmagini.rx.Edit.us?idRx=${rx.id}" name="form" id="form" method="post" class="marginezero">
           
    
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    <h4 class="titolopagina">
     		Modifica RX
    </h4>
	
    <table class="tabella">
    	
    	<tr>
        	<th colspan="3">
        		Informazioni preliminari
        	</th>
        </tr>
    	<tr>
    		<td style="width:50%">
    			 Data Richiesta<font color="red"> *</font>
    			 <fmt:formatDate type="date" value="${rx.dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/> 		
    			 <input type="text" id="dataRichiesta" name="dataRichiesta" maxlength="32" size="50" readonly="readonly" style="width:246px;" value="${dataRichiesta}" />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataRichiesta",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_1",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>   
    		</td>
    		<td style="width:50%">
    			 Data Esito
    			 <fmt:formatDate type="date" value="${rx.dataEsito}" pattern="dd/MM/yyyy" var="dataEsito"/> 		
    			 <input type="text" id="dataEsito" name="dataEsito" maxlength="32" size="50" readonly="readonly" style="width:246px;" value="${dataEsito}" />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_2" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataEsito",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_2",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>   
    		</td>
        </tr>
        </table>
        
       <table class="tabella">
        <tr>
        	<th colspan="3">
        		Informazioni Aggiuntive
        	</th>
        </tr>
        <tr>
        	<td style="width:20%">
        		Note	
        	</td>
        	<td>
		        <TEXTAREA NAME="note" COLS="40" ROWS="6"><c:out value="${rx.note}"></c:out></TEXTAREA>        
        	</td>
        </tr>
        <tr class='even'>
    		<td colspan="3"> 
    			<font color="red">* </font> Campi obbligatori
				<br/>   			
    			<input type="button" value="Modifica" onclick="checkform(document.getElementById('form'))"/>
    			<input type="button" value="Annulla" onclick="location.href='vam.cc.diagnosticaImmagini.rx.List.us'">
    		</td>
        </tr>
	</table>
</form>