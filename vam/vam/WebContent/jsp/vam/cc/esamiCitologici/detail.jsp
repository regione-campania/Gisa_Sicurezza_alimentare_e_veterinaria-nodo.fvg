<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Dettaglio Esame Citologico
</h4>		 

<br/>

<table class="tabella">
    	
        <tr>
    		<th colspan="2">
    			Esame Citologico del <fmt:formatDate type="date" value="${esame.dataRichiesta}" pattern="dd/MM/yyyy" />
    		</th>
    	</tr>
    	
    	 <tr class="odd">
    		<td style="width:30%">
    			 Numero
    		</td>
    		<td style="width:70%">  
    			 <c:out value="${esame.numero}"/>
    		</td>
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
    			 Tipo Prelievo
    		</td>
    		<td style="width:70%">  
    			${esame.tipoPrelievo }<c:if test="${esame.tipoPrelievoAltro!=null && esame.tipoPrelievoAltro!=''}">: ${esame.tipoPrelievoAltro }</c:if>
    		</td>
        </tr>
        
        <tr>
    		<td style="width:30%">
    			 Matrice
    		</td>
    		<td style="width:70%">  
    			${esame.diagnosiPadre}
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Aspetto della lesione
    		</td>
    		<td style="width:70%">  
    			${esame.aspettoLesione }
    		</td>
        </tr>
        
        <tr>
    		<td style="width:30%">
    			 Diagnosi
    		</td>
    		<td style="width:70%">  
    		<c:choose>
    			<c:when test="${esame.idDiagnosiPadre==1}">
    				Sospetto benigno<br/>
    			</c:when>
    			<c:when test="${esame.idDiagnosiPadre==2}">
    				Sospetto maligno<br/>
    			</c:when>
    			<c:when test="${esame.idDiagnosiPadre==3}">
    				Non diagnostico<br/>
    			</c:when>
    		</c:choose>
    		<c:choose>
    			<c:when test="${esame.diagnosi.padre!=null}">
    				${esame.diagnosi.padre} ->
    			</c:when>
    		</c:choose>
    			${esame.diagnosi}
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
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.esamiCitologici.ToEdit.us?idEsame=${esame.id }'}
    				}else{location.href='vam.cc.esamiCitologici.ToEdit.us?idEsame=${esame.id }'}">
	    		<input type="button" value="Lista Esami Citologici" onclick="location.href='vam.cc.esamiCitologici.List.us'">

