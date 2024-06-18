<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<form action="vam.cc.anamnesiRecente.ToEdit.us" name="form" method="post" class="marginezero">
           
    
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    <h4 class="titolopagina">
     		Anamnesi recente
    </h4>
     
    <table class="tabella">
         <tr class='even'>
    		<td>
    			Tipologia di anamnesi
    		</td>
    		<td>
    			<c:choose>
    				<c:when test="${cc.anamnesiRecenteConosciuta == false}">
    					Muta - 
    				</c:when>
    				<c:otherwise>
    					Conosciuta - 
    				</c:otherwise>
    			</c:choose>
    			${cc.anamnesiRecenteDescrizione}
    		</td>
        </tr>
                
       <br>
       <br>
		
        <tr class='odd'>
        	<td>
        	</td>
    		<td>   
    			<input type="submit" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){attendere()}
    				}else{attendere()}"/>			
    		</td>
    		<td>
    		</td>
        </tr>
	</table>
</form>