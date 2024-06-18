<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

    <h4 class="titolopagina">
     		Dettaglio Clinica
    </h4>
    <table class="tabella">
        <tr>
        	<th colspan="2">
        		Dati Generali
        	</th>
        </tr>
        
    	<tr class="odd">
    		<td>
    			Asl
    		</td>
    		<td>
    			<c:out value="${clinica.lookupAsl.description}"/>
    		</td>
        </tr>
        
        <tr>
    		<td>
    			Nome
    		</td>
    		<td>
    			 <c:out value="${clinica.nome}"/>
    		</td>
        </tr>
        
        <tr class="odd">
    		<td>
    			Comune
    		</td>
    		<td>
    			 <c:out value="${clinica.lookupComuni.description}"/>
    		</td>
        </tr>
        
        <tr>
    		<td>
    			 Indirizzo
    		</td>
    		<td>
    			 <c:out value="${clinica.indirizzo}"/>
    		</td>
        </tr>
        
        <tr class="odd">
    		<td>
    			 Telefono
    		</td>
    		<td>
    			 <c:out value="${clinica.telefono}"/>
    		</td>
        </tr>
        
        <tr>
    		<td>
    			 Fax
    		</td>
    		<td>
    			 <c:out value="${clinica.fax}"/>
    		</td>
        </tr>
        
        <tr class="odd">
    		<td>
    			 Email
    		</td>
    		<td>
    			 <c:out value="${clinica.email}"/>
    		</td>
        </tr>
        
        <tr>
    		<td>
    			 Note
    		</td>
    		<td>
    			 <c:out value="${clinica.note}"/>
    		</td>
        </tr>
        
        <tr>
			<td>
				&nbsp;
			</td>
		</tr>
        <tr>
        	<th colspan="2">
        		Strutture Cliniche
        	</th>
        </tr>
        <tr>
        	<th>
        		Tipo
        	</th>
        	<th>
        		Denominazione
        	</th>
        </tr>
        
        <c:set var="i" value="1"/>
        <c:forEach var="struttura" items="${clinica.strutturaClinicas}">
			<tr class="${i% 2 == 0 ? 'odd' : 'even'}">
				<td><c:out value="${struttura.lookupTipiStruttura.description}" /></td>
				<td style="width:50%;"><c:out value="${struttura.denominazione}" /></td>
			</tr>
			<c:set var="i" value="${i+1}"/>
		</c:forEach>
        
         <tr>
			<td>
				&nbsp;
			</td>
		</tr>
		
		<tr>
			<td>
				<input type="button" value="Chiudi" onclick="window.close()"/>
			</td>
			<td>
			</td>
		</tr>
		
		
        <tr>
			<td>
				&nbsp;
			</td>
		</tr>
	</table>