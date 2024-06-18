<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<form action="vam.cc.ricoveri.ToEdit.us" name="form" method="post" class="marginezero">
       
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    <h4 class="titolopagina">
     		Dettagli del ricovero
    </h4>
   
    <table class="tabella">
    	
    	<tr class='even'>
    		<td>
    			 Data del ricovero
    		</td>
    		<td>
    			<fmt:formatDate value="${cc.ricoveroData}" pattern="dd/MM/yyyy" var="data"/>
	   			${data}
    		</td>
        </tr>
        
        <tr class='odd'>
    		<td colspan="3">
    			Ricoverato in ${cc.strutturaClinica.denominazione}, Numero ${cc.ricoveroBox}
    		</td>
        </tr>   
                
        <tr class='even'>
    		<td>
    			Motivo del ricovero
    		</td>
    		<td>
    			${cc.ricoveroMotivo}	    			
    		</td>
    		<td>
    		</td>
        </tr>
        
         <tr class='odd'>
    		<td>
    			Sintomatologia
    		</td>
    		<td>
    			${cc.ricoveroSintomatologia}	    			
    		</td>
    		<td>
    		</td>
        </tr>
                
        <tr class='even'>
    		<td>
    			Note
    		</td>
    		<td>
    			${cc.ricoveroNote}  			
    		</td>
    		<td>
    		</td>
        </tr>
        	<tr class='odd'>
    			<td colspan="2">    						
    				<input type="button" value="Modifica" 
    					onclick="if(${cc.dataChiusura!=null})
    							{ 
        							if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?'))
        							{
        								location.href='vam.cc.ricoveri.ToEdit.us';
        							}
								}
								else
								{
									location.href='vam.cc.ricoveri.ToEdit.us';
								}"/>    			
    			</td>
    			<td>
    			</td>
        	</tr>
	</table>
</form>