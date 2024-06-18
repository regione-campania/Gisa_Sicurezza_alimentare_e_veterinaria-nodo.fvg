<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<form name="form" method="post" class="marginezero" >
           
    
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    <h4 class="titolopagina">
     		Diagnostica per immagini
    </h4>
	
    <table class="tabella">
    	<tr>
        	<th colspan="2">
        		Scelta tipo esame
        	</th>
        </tr>              
        
    	<tr class='odd'>
    		<td>
    			Tipo
    		</td>
    		<td>
    			<select id="diagnosticaImmagini">
					<option value="">&lt;--- Selezionare il tipo ---&gt;</option>
					<option value="ecoAddome.List.us">Eco-Addome</option>
					<option value="ecoCuore.List.us">Eco-Cuore</option>
					<option value="tac.List.us">TAC</option>
					<option value="rx.List.us">RX</option>
    			</select>
    		</td>
        </tr>
        	
        <tr class='even'>
        	<td>
        	</td>
    		<td>    			
    			<input type="button" value="Prosegui" onclick="if(document.getElementById('diagnosticaImmagini').value==''){alert('Selezionare un tipo');}else{location.href='vam.cc.diagnosticaImmagini.'+document.getElementById('diagnosticaImmagini').value;}"/>
    		</td>
        </tr>
	</table>
</form>