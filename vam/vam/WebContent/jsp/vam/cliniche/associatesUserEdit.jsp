<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<script language="JavaScript" type="text/javascript" src="js/vam/cliniche/associatesUser.js"></script>

<form action="vam.cliniche.AssociatesUser.us" name="form" method="post" class="marginezero">

 <input type="hidden" name="categorieSelezionate" value=""/>
    
    <h4 class="titolopagina">
     		Associazione Utente/Clinica
    </h4>
    <table class="tabella">
    	<tr>
        	<th>
        		Utente
        	</th>
        	<th>
        		Cliniche
        	</th>
        </tr>
        
        <tr>
    		<td>
    			<input type="hidden" value="${utenteSelezionato.id}" name="idUtente" />
           		<c:out value="${utenteSelezionato.username}"/>: <c:out value="${utenteSelezionato.nome}"/> <c:out value="${utenteSelezionato.cognome}"/>
    		</td>
    		
    		<td>
    			<select name="clinica" id="clinica">
    				<option value="">&lt;--- Selezionare Clinica ---&gt;</option>
    				<c:forEach var="clinica" items="${elencoCliniche}">
    					<option value="${clinica.id}"
    						<c:if test="${clinica.id==utenteSelezionato.clinica.id}">
								selected=selected
							</c:if>    						
    					>${clinica.nome}</option>
    				</c:forEach>
    			</select>
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<input type="button" value="Associa" onclick="javascript:checkform();"/>
    			<input type="button" value="Annulla" onclick="javascript: attendere(); location.href='vam.cliniche.ToAssociatesUser.us';"/>
    		</td>
        </tr>
        
	</table>
</form>