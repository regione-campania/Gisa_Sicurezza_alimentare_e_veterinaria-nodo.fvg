<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa" %>
<%@page import="it.us.web.bean.vam.Autopsia"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="it.us.web.bean.vam.lookup.LookupAutopsiaEsitiEsami"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="it.us.web.bean.vam.lookup.LookupAutopsiaOrgani"%>
<%@page import="it.us.web.bean.vam.lookup.LookupAutopsiaTipiEsami"%>

<script language="JavaScript" type="text/javascript" src="js/vam/cc/autopsie/detail.js"></script>

<%
	Autopsia a 									                      = (Autopsia)request.getAttribute("a");
	ArrayList<LookupAutopsiaOrgani> listOrganiAutopsia	              = (ArrayList<LookupAutopsiaOrgani>)request.getAttribute("listOrganiAutopsia");
	ArrayList<LookupAutopsiaTipiEsami> listTipiAutopsia 			  = (ArrayList<LookupAutopsiaTipiEsami>)request.getAttribute("listTipiAutopsia");
	HashMap<String, Set<LookupAutopsiaEsitiEsami>> allOrganiTipiEsiti = (HashMap<String, Set<LookupAutopsiaEsitiEsami>>)request.getAttribute("allOrganiTipiEsiti");
%>


<h4 class="titolopagina">
		Fascicolo Sanitario
</h4>   

<br>
<table class="tabella">
    	    	
    	<tr></tr>   	
        
         <tr>
        	<th colspan="5">
        		Dati del fascicolo
        	</th>        	
        </tr>
        
        <tr class='even'>
    		<td>
    			Numero
    		</td>
    		<td colspan="4">
    			 <c:out value="${fascicoloSanitario.numero}"/>
    		</td>
        </tr>
        
         <tr class='odd'>
    		<td>
    			Data Apertura
    		</td>
    		<td colspan="4">	    			
				<fmt:formatDate type="date" value="${fascicoloSanitario.dataApertura}" pattern="dd/MM/yyyy" var="dataApertura"/>
  				<c:out value="${dataApertura}"/>					
    		</td>
        </tr>
                
         <tr class='even'>
    		<td>
    			<c:choose>
    				<c:when test="${fascicoloSanitario.dataChiusura==null}">
    					Data Chiusura
    				</c:when>
    				<c:otherwise>
    					<b>Data Chiusura</b>
    				</c:otherwise>
    			</c:choose>
    		</td>
    		<td colspan="4">	    			
				<fmt:formatDate type="date" value="${fascicoloSanitario.dataChiusura}" pattern="dd/MM/yyyy" var="dataChiusura"/>
  				<b><c:out value="${dataChiusura}"/></b>			
    		</td>
        </tr>
        
        <tr>
        	<th colspan="5">
        		Dati dell'animale
        	</th>        	
        </tr>
		<tr class='even'>
			<td>
				Identificativo
			</td>
			<td colspan="4">
				${fascicoloSanitario.animale.identificativo }
			</td>
		</tr>
		<tr class='odd'>
			<c:choose>
				<c:when test="${fascicoloSanitario.animale.lookupSpecie.id==3}">
					<td>
						Et&agrave;
					</td>
					<td colspan="4">
						<fmt:formatDate type="date" value="${fascicoloSanitario.animale.dataNascita }" pattern="dd/MM/yyyy" />
						${fascicoloSanitario.animale.eta} <c:if test="${dataNascita}">(${dataNascita})</c:if>
					</td>
				</c:when>
				<c:otherwise>
					<td>
						Data nascita 
					</td>
					<td colspan="4">
						<fmt:formatDate type="date" value="${fascicoloSanitario.animale.dataNascita }" pattern="dd/MM/yyyy" />
  						${dataNascita}
					</td>
				</c:otherwise>
			</c:choose>
		</tr>
		
		<c:set scope="request" var="anagraficaAnimale" value="${anagraficaAnimale}"/>
        <c:import url="../vam/anagraficaAnimale.jsp"/>
		
		<c:if test="${fascicoloSanitario.animale.dataMorte!=null || res.dataEvento!=null}">
       	<c:choose>
        	<c:when test="${fascicoloSanitario.animale.decedutoNonAnagrafe == true}">						
				<fmt:formatDate type="date" value="${fascicoloSanitario.animale.dataMorte}" pattern="dd/MM/yyyy" var="dataMorte"/>
			</c:when>
			<c:otherwise>
				<fmt:formatDate type="date" value="${res.dataEvento}" pattern="dd/MM/yyyy" var="dataMorte"/>
			</c:otherwise>	
		</c:choose>	 
        <tr class='even'>
   			<td>
   				Data del decesso
   			</td>
   			<td colspan="4">
				${dataMorte} - 
				<c:choose>
					<c:when test="${fascicoloSanitario.animale.decedutoNonAnagrafe == true}">						
						${fascicoloSanitario.animale.dataMorteCertezza}
					</c:when>
					<c:otherwise>
						${res.dataMorteCertezza}
					</c:otherwise>	
				</c:choose>	 
        	</td>
   		</tr>
    	
   		<tr class='odd'>
      	  <td>
    			Probabile causa di morte
   			</td>
   			<td colspan="4">    
   				<c:choose>
    				<c:when test="${fascicoloSanitario.animale.decedutoNonAnagrafe}">
    					${fascicoloSanitario.animale.causaMorte.description}
    				</c:when>
    				<c:otherwise>
    					${res.decessoValue}
    				</c:otherwise>
    			</c:choose>	        	        
        	</td>
       	</tr>
       	</c:if>
	
        <tr>
        	<th colspan="5">
        		Cartelle cliniche associate
        	</th>        	
        </tr>
        
       	<tr>
        	<th>
        		Numero
        	</th>   
        	<th>
        		Clinica
        	</th>      	
        	<th>
        		Data Apertura
        	</th>        	
        	<th>
        		Data Chiusura
        	</th> 
        	<th>
        		Evento
        	</th>       	
        </tr>
        
        <c:set var="i" value='1'/>	
        <c:forEach items="${fascicoloSanitario.cartellaClinicas}" var="ccCurr" >
        	<tr class="${i % 2 == 0 ? 'odd' : 'even'}">
    			<td>
    				 <a href="vam.cc.Detail.us?idCartellaClinica=${ccCurr.id }" onclick="attendere()">${ccCurr.numero }</a>
    			</td>
    			<td>
    				 ${ccCurr.enteredBy.clinica.nome }
    			</td>
    			<td>
    				 <fmt:formatDate type="date" value="${ccCurr.dataApertura}" pattern="dd/MM/yyyy" var="dataApertura"/>
  					 <c:out value="${dataApertura}"/>
    			</td>
    			<td>
    				 <fmt:formatDate type="date" value="${ccCurr.dataChiusura}" pattern="dd/MM/yyyy" var="dataChiusura"/>
  					 <c:out value="${dataChiusura}"/>
    			</td>
    			<td>
    				${ccCurr.eventoApertura}
    			</td>
    		</tr>
    		<c:set var="i" value='${i+1}'/>
        </c:forEach>
	</table>