<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Dettaglio Esame Coprologico
</h4>		 

<br/>

<table class="tabella">
    	
        <tr>
    		<th colspan="2">
    			Esame Coprologico del <fmt:formatDate type="date" value="${esame.dataRichiesta}" pattern="dd/MM/yyyy" />
    		</th>
    	</tr>

		<tr class="odd">
    		<td style="width:30%">
    			 Data esito
    		</td>
    		<td style="width:70%">  
    			<fmt:formatDate type="date" value="${esame.dataEsito}" pattern="dd/MM/yyyy" var="dataEsito"/>
    			 <c:out value="${dataEsito}"/>

    		</td>
        </tr>
        
		<tr>
    		<td style="width:30%">
    			 Elminti
    		</td>
    		<td style="width:70%">  
    			${esame.elminti }
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Protozoi
    		</td>
    		<td style="width:70%">  
    			${esame.protozoi }
    		</td>
        </tr>
	</table>
		<table class="tabella">
			<tr>
				<th colspan="3">
				       		Altre Informazioni
				 </th>
			 </tr> 	  
			<tr class="odd">
				<td>Inserito da</td>
				<td>${esame.enteredBy} il <fmt:formatDate value="${esame.entered}" pattern="dd/MM/yyyy"/></td>
			</tr>
			<c:if test="${esame.modifiedBy!=null}">
			<tr class="even">
				<td>Modificato da</td><td>${esame.modifiedBy} il <fmt:formatDate value="${esame.modified}" pattern="dd/MM/yyyy"/></td>
			</tr>
			</c:if>
		</table>
    	
	    		<input type="button" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.esamiCoprologici.ToEdit.us?idEsame=${esame.id }'}
    				}else{location.href='vam.cc.esamiCoprologici.ToEdit.us?idEsame=${esame.id }'}">
	    		<input type="button" value="Lista Esami Coprologici" onclick="location.href='vam.cc.esamiCoprologici.List.us'">
  		
