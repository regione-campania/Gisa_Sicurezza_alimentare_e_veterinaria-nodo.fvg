<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@page import="it.us.web.bean.vam.Autopsia"%>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
    Dettaglio Decesso
</h4>
	


<form action="" name="form" method="post" id="form" class="marginezero">

<table class="tabella">
    	    	   	
    	
    	<tr class='even'>
    		<td>
    			Data del decesso
    		</td>
    		<td>							
				<c:choose>
	    			<c:when test="${cc.accettazione.animale.decedutoNonAnagrafe}">
	    				<fmt:formatDate type="date" value="${cc.accettazione.animale.dataMorte}" pattern="dd/MM/yyyy" var="dataMorte"/>
	    			</c:when>
	    			<c:otherwise>
	    				<fmt:formatDate type="date" value="${res.dataEvento}" pattern="dd/MM/yyyy" var="dataMorte"/>
	    			</c:otherwise>
	    		</c:choose>
				<c:out value="${dataMorte}"/>
				<input type="hidden" name="dataMorte" value="<c:out value="${dataMorte}"/>"/>
			</td>
			<td>			
				<c:choose>
	    			<c:when test="${cc.accettazione.animale.decedutoNonAnagrafe}">
	    				${cc.accettazione.animale.dataMorteCertezza}
	    			</c:when>
	    			<c:otherwise>
	    				<c:choose>
	    					<c:when test="${res.dataDecessoPresunta}">					
						 		Presunta	   		 
							</c:when>
							<c:otherwise>
								Certa
							</c:otherwise>	
						</c:choose>
	    			</c:otherwise>
	    		</c:choose>
	        </td>
    	</tr>
    	
    	
	    	<tr class='odd'>
		        <td>
		    		Probabile causa del decesso
	    		</td>
	    		<td>  
	    			<c:choose>
	    				<c:when test="${cc.accettazione.animale.decedutoNonAnagrafe}">
	    					${cc.accettazione.animale.causaMorte.description}
	    				</c:when>
	    				<c:otherwise>
	    					${res.decessoValue}
	    				</c:otherwise>
	    			</c:choose>
		        </td>
		        <td>
		        </td>
	        </tr>
       
       
       
        <tr class='odd'> 
			<td align="center">    		   			
				<input type="button" value="Modifica" onclick=" if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){attendere(), location.href='vam.cc.decessi.ToEdit.us'}
					}else{attendere(), location.href='vam.cc.decessi.ToEdit.us'} ">
				<input type="button" value="Annulla" onclick="attendere(), location.href='vam.cc.Detail.us'">
			</td>
			<td>
	        </td>
	        <td>
	        </td>				
		</tr>
        
        </table>
</form>