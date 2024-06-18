<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<form action="" name="form" method="post" id="form" class="marginezero">

<table class="tabella">
    	
    	
    	<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    	<h4 class="titolopagina">
     		Dettaglio Rickettsiosi
    	</h4>
    	
    	<tr>
    		<th colspan="3">
    			Dettaglio 
    		</th>
    	</tr>    
                 
        
        <tr class='even'>
    		<td>
    			Data Richiesta:&nbsp;
    			 <fmt:formatDate type="date" value="${r.dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/>
    			 <c:out value="${dataRichiesta}"/>
    		</td>
    		<td>
    			Data Esito:&nbsp;
    			 <fmt:formatDate type="date" value="${r.dataEsito}" pattern="dd/MM/yyyy" var="dataEsito"/>
    			 <c:out value="${dataEsito}"/>
    		</td>
        </tr>
        
        <tr class='odd'>
    		<td>
    			Esito
    		</td>
    		<td>
    			 <c:out value="${r.lre.description}"/>
    		</td>
    		<td>
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
				<td>${r.enteredBy} il <fmt:formatDate value="${r.entered}" pattern="dd/MM/yyyy"/></td>
			</tr>
			<c:if test="${r.modifiedBy!=null}">
			<tr class="even">
				<td>Modificato da</td><td>${r.modifiedBy} il <fmt:formatDate value="${r.modified}" pattern="dd/MM/yyyy"/></td>
			</tr>
			</c:if>
		</table>
    			<input type="button" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){attendere(), location.href='vam.cc.rickettsiosi.ToEdit.us?idRickettsiosi=${r.id}'}
    				}else{attendere(), location.href='vam.cc.rickettsiosi.ToEdit.us?idRickettsiosi=${r.id}'}">				
    			<input type="button" value="Lista Rickettsiosi" onclick="attendere(), location.href='vam.cc.rickettsiosi.List.us'">				
    	
</form>