<%@page import="it.us.web.bean.vam.AltreDiagnosi"%>
<%@page import="it.us.web.constants.SpecieAnimali"%>
<%@page import="it.us.web.bean.vam.Animale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@page import="java.util.Date"%>


<%
	Animale animale = (Animale)request.getAttribute("animale");
	String proprietarioCognome			= (String)request.getAttribute("proprietarioCognome");
	String proprietarioNome 			= (String)request.getAttribute("proprietarioNome");
	String proprietarioCodiceFiscale	= (String)request.getAttribute("proprietarioCodiceFiscale");
	String proprietarioDocumento		= (String)request.getAttribute("proprietarioDocumento");
	String proprietarioIndirizzo 		= (String)request.getAttribute("proprietarioIndirizzo");
	String proprietarioCap 				= (String)request.getAttribute("proprietarioCap");
	String proprietarioComune 			= (String)request.getAttribute("proprietarioComune");
	String proprietarioProvincia 		= (String)request.getAttribute("proprietarioProvincia");
	String proprietarioTelefono 		= (String)request.getAttribute("proprietarioTelefono");
	String proprietarioTipo 			= (String)request.getAttribute("proprietarioTipo");
	String nomeColonia 					= (String)request.getAttribute("nomeColonia");
	Boolean randagio 					= (Boolean)request.getAttribute("randagio");
	if(randagio==null)
		randagio = false;
	SpecieAnimali specie				= (SpecieAnimali)request.getAttribute("specie");
	Integer specieAnimale				= (Integer)request.getAttribute("specieAnimale");
	
	AltreDiagnosi a = (AltreDiagnosi)request.getAttribute("a");
%>

<form action="vam.altreDiagnosi.AddLLPP.us" id="myform" name="form" method="post" class="marginezero">    

  <input type="hidden" name="idAnimale" id="idAnimale" value="${animale.id }"/>

    
	  <h4 class="titolopagina">
		Diagnosi BASE 1/2/3
    </h4>  
    
    <table class="tabella">
    
    
    <tr>
    	<th colspan="2">
    		Anagrafica Animale
    	</th>
    </tr>
    <tr class='even'>
    		<td>
    			Tipologia
    		</td>
    		<td> 
    				<%=animale.getLookupSpecie().getDescription() %>
    		</td>  
    		<td>
    		</td>  		
        </tr>
        
	<tr class='even'>
		<td>
			Identificativo
		</td>
		<td>
			<%=animale.getIdentificativo()%>
		</td>
	</tr>
	<tr class='even'>
		<td>
			Tatuaggio / II MC
		</td>
		<td>
<%				
			if(animale.getTatuaggio()!=null)
			{
%> 
				<%=animale.getTatuaggio()%> 
<%
			}
%>
		</td>
	</tr>
	<c:choose>
		<c:when test="<%=specieAnimale==specie.getSinantropo()%>">
			<fmt:formatDate type="date" value="<%=animale.getDataNascita()%>" pattern="dd/MM/yyyy" var="dataNascita" />
			<tr class='odd'>
				<td>
					Et&agrave;
				</td>
				<td>
					${animale.eta.description}
					<c:if test="<%=animale.getDataNascita()!=null %>">
						(<%=animale.getDataNascita() %>)
					</c:if>
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<fmt:formatDate type="date" value="<%=animale.getDataNascita()%>" pattern="dd/MM/yyyy" var="dataNascita"/>
			<tr class='odd'>
				<td>
					Data nascita
				</td>
				<td>
<%
				if (animale.getDataNascita()!=null)
				{
%>
					<%=animale.getDataNascita()%>
<%
				} 
%>
				</td>
			</tr>
		</c:otherwise>
	</c:choose>
	
<!--  	<c:set scope="request" var="anagraficaAnimale" value="${anagraficaAnimale}"/> -->
    <c:import url="../vam/richiesteIstopatologici/anagraficaAnimaleDetail.jsp"/>
	
		
		<c:if test="${animale.dataMorte!=null || res.dataEvento!=null}">
        	<tr class='even'>
   				<td>
   					Data del decesso
   				</td>
   				<td> 
					${dataMorte} - 
					<c:choose>
						<c:when test="<%=animale.getDecedutoNonAnagrafe()==true %>">
							<%=animale.getDataMorteCertezza()%>
						</c:when>
						<c:otherwise>
							${res.dataMorteCertezza}
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
    				<c:when test="<%=animale.getDecedutoNonAnagrafe()%>">
<% 
					if (animale.getCausaMorte().getDescription()!=null)
					{ 
%>
						<%=animale.getCausaMorte().getDescription()%>
<%
					} 
					else 
					{
%>
    					<%=""%>
<%
					}
%>
    				</c:when>
    				<c:otherwise>
    					${res.decessoValue}
    				</c:otherwise>
    				</c:choose>	        	        
        		</td>
       		</tr>
       	</c:if>

	<!--  c:if test="${!animale.decedutoNonAnagrafe }" -->
		
    
    	<tr class='even'>
    		<td>
    			Peso dell'animale (in Kg)
    		</td>
    		<td>
    			 <%=a.getPeso() %>
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class="odd">
    		<td >
    			 Stato generale
    		</td>
    		<td style="width:70%">  
    			 ${a.statoGeneraleLookup}
    		</td>
        </tr>  
                
        <tr class='odd'>
    		<td>
    			Habitat 
    		</td>
    		<td>
    		
    			<c:forEach items="${lh}" var="h">
						
						${h.description} - 							
		    					      											
				</c:forEach>	
				 
    		
    		</td>
    		<td>
    		</td>
        </tr>
        
         <tr class="even">
    		<td style="width:30%">
    			 Alimentazioni
    		</td>
    		<td style="width:70%">  
    		
    			<c:forEach items="${la}" var="a">
						${a.description}						
				</c:forEach>
				
				<c:forEach items="${listAlimentazioniQualita}" var="aq" >									
							${aq.description} 	
				</c:forEach> 
				
				
									
    		   		
    			
    		</td>
        </tr> 
        
        
        <tr>
        	<th colspan="2">
        		Diagnosi
        	</th>
        </tr>
        
        <tr class="even">
    		<td style="text-align: left;">
    			Data 
    		</td>
			<td style="text-align: left;">
				 <fmt:formatDate type="date" value="${a.dataDiagnosi}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>
        
        <tr class="even">
    		<td style="text-align: left;">
    			Prima diagnosi 
    		</td>
			<td style="text-align: left;">
				 <fmt:formatDate type="date" value="${a.dataPrimaDiagnosi}" pattern="dd/MM/yyyy" /> 
    			 
    			 
    		</td>
        </tr>
        
        <%
        
        if(a.getAltraDiagnosi()==1)
        {
        %>
    	 <tr class="even">
    		<td style="text-align: left;">
    			Tipo 
    		</td>
			<td style="text-align: left;">
				 <b>BASE 1 Clinica/anamnestica </b> <br/>
				 Note: <%= a.getNoteBase1()%>
    			 
    			 
    		</td>
        </tr>
      <%
        }
      %> 
      
      
      
      <%
        
        if(a.getAltraDiagnosi()==2)
        {
        %>
    	 <tr class="even">
    		<td style="text-align: left;">
    			Tipo 
    		</td>
			<td style="text-align: left;">
				 <b>BASE 2 Esami ematochimici </b> <br/>
    			 Note: <%= a.getNoteBase2()%>
    			 
    		</td>
        </tr>
      <%
        }
      %> 
      
      
       <%
        
        if(a.getAltraDiagnosi()==3 && a.getBase3Eco()!= null && a.getBase3Eco())
        {
        %>
    	 <tr class="even">
    		<td style="text-align: left;">
    			Tipo 
    		</td>
			<td style="text-align: left;">
				 <b>BASE 3 - Eco </b> <br/>
    			 Note: <%= a.getNoteBase3Eco()%>
    			 
    		</td>
        </tr>
      <%
        }
      %> 
      
      <%
        
        if(a.getAltraDiagnosi()==3 && a.getBase3Tac()!= null && a.getBase3Tac())
        {
        %>
    	 <tr class="even">
    		<td style="text-align: left;">
    			Tipo 
    		</td>
			<td style="text-align: left;">
				 <b>BASE 3 - Tac </b> <br/>
    			 Note: <%= a.getNoteBase3Tac()%>
    			 
    		</td>
        </tr>
      <%
        }
      %> 
      
      <%
        
        if(a.getAltraDiagnosi()==3 && a.getBase3RM()!= null && a.getBase3RM())
        {
        %>
    	 <tr class="even">
    		<td style="text-align: left;">
    			Tipo 
    		</td>
			<td style="text-align: left;">
				 <b>BASE 3 - RM </b> <br/>
    			 Note: <%= a.getNoteBase3Rm()%>
    			 
    		</td>
        </tr>
      <%
        }
      %> 
      
      <%
        
        if(a.getAltraDiagnosi()==3 && a.getBase3Rx()!= null && a.getBase3Rx())
        {
        %>
    	 <tr class="even">
    		<td style="text-align: left;">
    			Tipo 
    		</td>
			<td style="text-align: left;">
				 <b>BASE 3 - Rx </b> <br/>
    			 Note: <%= a.getNoteBase3Rx()%>
    			 
    		</td>
        </tr>
      <%
        }
      %> 
        
        
	</table>
</form>