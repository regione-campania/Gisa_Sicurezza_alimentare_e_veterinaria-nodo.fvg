<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<form action="" name="form" method="post" id="form" class="marginezero">

<table class="tabella">
    	
    	
    	<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    	<h4 class="titolopagina">
     		Dettaglio Leishmaniosi
    	</h4>
    	
    	<tr>
    		<th colspan="3">
    			Dettaglio 
    		</th>
    	</tr>    
                 
        
        <tr class='even'>
    		<td>
    			Data Prelievo
    		</td>
    		<td>
    			 <fmt:formatDate type="date" value="${l.dataPrelievoLeishmaniosi}" pattern="dd/MM/yyyy" var="dataPrelievoLeishmaniosi"/>
    			 <c:out value="${dataPrelievoLeishmaniosi}"/>
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class='odd'>
    		<td>
    			Data Esito
    		</td>
    		<td>
    			 <fmt:formatDate type="date" value="${l.dataEsitoLeishmaniosi}" pattern="dd/MM/yyyy" var="dataEsitoLeishmaniosi"/>
    			 <c:out value="${dataEsitoLeishmaniosi}"/>
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class='even'>
    		<td>
    			Esito
    		</td>
    		<td>
    			 <c:out value="${l.lle.description}"/>
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class='odd'>
    		<td>
    			Ordinanza Sindaco
    		</td>
    		<td colspan="2">
    			 <c:out value="${l.ordinanzaSindaco}"/>
    			<c:if test="${l.ordinanzaSindaco!='' || l.dataOrdinanzaSindaco!=''}">
    				del 
    			</c:if>
    			<fmt:formatDate type="date" value="${l.dataOrdinanzaSindaco}" pattern="dd/MM/yyyy" var="dataOrdinanzaSindaco"/>
    			 <c:out value="${dataOrdinanzaSindaco}"/>
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
				<td>${l.enteredBy} il <fmt:formatDate value="${l.entered}" pattern="dd/MM/yyyy"/></td>
			</tr>
			<c:if test="${l.modifiedBy!=null}">
			<tr class="even">
				<td>Modificato da</td><td>${l.modifiedBy} il <fmt:formatDate value="${l.modified}" pattern="dd/MM/yyyy"/></td>
			</tr>
			</c:if>
		</table>  
        
    			<input type="button" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){attendere(), location.href='vam.cc.leishmaniosi.ToEdit.us?idLeishmaniosi=${l.id}'}
    				}else{attendere(), location.href='vam.cc.leishmaniosi.ToEdit.us?idLeishmaniosi=${l.id}'}">				
    			<input type="button" value="Lista Leishmaniosi" onclick="attendere(), location.href='vam.cc.leishmaniosi.List.us'">	
    	
</form>