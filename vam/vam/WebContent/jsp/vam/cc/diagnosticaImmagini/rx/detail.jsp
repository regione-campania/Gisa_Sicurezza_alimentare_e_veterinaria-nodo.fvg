<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>


    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    <h4 class="titolopagina">
     		Dettaglio RX
    </h4>
    
    <table class="tabella">
    	
    	<tr>
        	<th colspan="3">
        		Informazioni preliminari
        	</th>
        </tr>
    	<tr>
    		<td style="width:50%">
    			 Data Richiesta:&nbsp;
    			 <fmt:formatDate type="date" value="${rx.dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/> 		
    			 ${dataRichiesta}
    		</td>
    		<td style="width:50%">
    			 Data Esito:&nbsp;
    			 <fmt:formatDate type="date" value="${rx.dataEsito}" pattern="dd/MM/yyyy" var="dataEsito"/> 		
    			 ${dataEsito}
    		</td>
			
		</tr>
    	</table>
    	
    	<table class="tabella">
    	<tr>
        	<th colspan="3">
        		Informazioni Aggiuntive
        	</th>
        </tr>
         <tr class="odd">
			<td>Inserito da</td>
			<td>${rx.enteredBy} il <fmt:formatDate value="${rx.entered}" pattern="dd/MM/yyyy"/></td>
		</tr>
		<c:if test="${rx.modifiedBy!=null}">
			<tr class="even">
				<td>Modificato da</td><td>${rx.modifiedBy} il <fmt:formatDate value="${rx.modified}" pattern="dd/MM/yyyy"/></td>
			</tr>
		</c:if>
		<tr class="odd">
        <td style="width:50%">
				Note
		</td>
    	<td>
			${rx.note}
		</td>
		</tr>	
        <tr class='even'>
    		<td colspan="3">    			
    			<input type="button" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.diagnosticaImmagini.rx.ToEdit.us?idRx=${rx.id}'}
    				}else{location.href='vam.cc.diagnosticaImmagini.rx.ToEdit.us?idRx=${rx.id}'}">
    			<input type="button" value="Lista RX" onclick="location.href='vam.cc.diagnosticaImmagini.rx.List.us'">
    		</td>
        </tr>
	</table>
