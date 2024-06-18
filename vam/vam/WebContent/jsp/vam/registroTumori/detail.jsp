<%@page import="it.us.web.util.properties.Application"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

 <c:if test = "${fn:contains(esame, 'IST')}">   
       
<input type="button" value="Immagini Istopatologico" onclick="javascript:avviaPopup( 'vam.cc.esamiIstopatologici.GestioneImmagini.us?id=${esame.id }&cc=${cc.id}' );" />

</c:if>

<c:if test="${esame.outsideCC==false}">
	<input type="button" value="Necroscopia/Vedi CC" onclick="javascript:if(${esame.cartellaClinica.autopsia!=null}){avviaPopup( 'vam.cc.autopsie.DetailDaIsto.us?idCc=${esame.cartellaClinica.id}' );}else{avviaPopup( 'vam.cc.DetailDaIsto.us?idCc=${esame.cartellaClinica.id}' );}" />			
</c:if>
<c:if test="${param['flagAnagrafe'] == null }">
	<input type="button" value="Chiudi" onclick="window.close();" />
</c:if>
				
<h4 class="titolopagina">
     		Dettaglio Esame
</h4>

<table class="tabella">
    	
    	<tr>
    		<th colspan="3">
    			Anagrafica Animale
    		</th>
    		
    	</tr>
    	
    	<tr class='even'>
    		<td>
    			Tipologia
    		</td>
    		<td> 
    		<c:choose>
    			<c:when test="${esame.outsideCC}">
    				<c:out value="${esame.animale.lookupSpecie.description}"/>
    			</c:when> 
    			<c:otherwise>
    				<c:out value="${esame.cartellaClinica.accettazione.animale.lookupSpecie.description}"/>
    			</c:otherwise>
    		</c:choose>
    		</td>  
    		<td>
    		</td>  		
        </tr>
    	
    	<tr class='odd'>
    		<td>
    			Identificativo
    		</td>
    		<td>
    			<c:choose>
    			<c:when test="${esame.outsideCC}">
    				<c:out value="${esame.animale.identificativo}"/>
    			</c:when> 
    			<c:otherwise>
    				<c:out value="${esame.cartellaClinica.accettazione.animale.identificativo}"/>
    			</c:otherwise>
    		</c:choose>
    		</td>  
    		<td>
    		</td>  		
        </tr>
        
        <!-- tr class='even'>
    		<td>
    			Razza
    		</td>
    		<td>
    			<c:if test="${(esame.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.cane or esame.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.gatto) && esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==false}">${razza}</c:if>
							  <c:if test="${esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==true}">${esame.cartellaClinica.accettazione.animale.razza}</c:if>
						      <c:if test="${esame.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.sinantropo && esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==false}">${esame.cartellaClinica.accettazione.animale.specieSinantropoString} - ${esame.cartellaClinica.accettazione.animale.razzaSinantropo}</c:if>	</td>    
    		<td>
    		</td>		
        </tr-->
        
        <tr class='odd'>
    		<td>
    			Sesso
    		</td>
    		<td>
						      <c:choose>
    			<c:when test="${esame.outsideCC}">
    					<c:if test="${(esame.animale.lookupSpecie.id == specie.cane || esame.animale.lookupSpecie.id == specie.gatto) && esame.animale.decedutoNonAnagrafe==false}">${esame.animale.sesso}</c:if>
							  <c:if test="${esame.animale.decedutoNonAnagrafe==true}">${esame.animale.sesso}</c:if>
						      <c:if test="${esame.animale.lookupSpecie.id == specie.sinantropo && esame.animale.decedutoNonAnagrafe==false}">${esame.animale.sesso}</c:if>
						      
    			</c:when> 
    			<c:otherwise>
    			<c:if test="${(esame.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.cane || esame.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.gatto) && esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==false}">${esame.cartellaClinica.accettazione.animale.sesso}</c:if>
							  <c:if test="${esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==true}">${esame.cartellaClinica.accettazione.animale.sesso}</c:if>
						      <c:if test="${esame.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.sinantropo && esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe==false}">${esame.cartellaClinica.accettazione.animale.sesso}</c:if>
						      
    			</c:otherwise>
    		</c:choose>
    		
    		
    		
    		</td> 
    		<td>
    		</td>   		
        </tr>
        
        <tr class='even'>
			<c:choose>
    			<c:when test="${esame.outsideCC}">
    				 <c:choose>
				<c:when test="${esame.animale.lookupSpecie.id==3}">
					<td>
						Et&agrave;
					</td>
					<td>
						<fmt:formatDate type="date" value="${esame.animale.dataNascita }" pattern="dd/MM/yyyy" />
						${esame.animale.eta} <c:if test="${dataNascita}">(${dataNascita})</c:if>
					</td>
				</c:when>
				<c:otherwise>
					<td>
						Data nascita 
					</td>
					<td>
						<fmt:formatDate type="date" value="${esame.animale.dataNascita }" pattern="dd/MM/yyyy" />
  						${dataNascita}
					</td>
				</c:otherwise>
			</c:choose>
    			</c:when> 
    			<c:otherwise>
    				 
			
			
			<c:choose>
				<c:when test="${esame.cartellaClinica.accettazione.animale.lookupSpecie.id==3}">
					<td>
						Et&agrave;
					</td>
					<td>
						<fmt:formatDate type="date" value="${esame.cartellaClinica.accettazione.animale.dataNascita }" pattern="dd/MM/yyyy" />
						${esame.cartellaClinica.accettazione.animale.eta} <c:if test="${dataNascita}">(${dataNascita})</c:if>
					</td>
				</c:when>
				<c:otherwise>
					<td>
						Data nascita 
					</td>
					<td>
						<fmt:formatDate type="date" value="${esame.cartellaClinica.accettazione.animale.dataNascita }" pattern="dd/MM/yyyy" />
  						${dataNascita}
					</td>
				</c:otherwise>
			</c:choose>
    			</c:otherwise>
    		</c:choose>
    		
    		
    		 
    		<td>
    		</td> 		
        </tr>
        
        
        
        
        
        
        
        <tr class='odd'>
    		<td>
    		
        
        
        
       <c:choose>
    			<c:when test="${esame.outsideCC}">
    				
    				
    				
    				<c:if test="${(esame.animale.lookupSpecie.id == specie.sinantropo)}">
			Famiglia/Genere
		</c:if>
		<c:if test="${(esame.animale.lookupSpecie.id != specie.sinantropo)}">
			Razza
		</c:if>
		
		
		
    			</c:when> 
    			<c:otherwise>
    				
    				<c:if test="${(esame.cartellaClinica.accettazione.animale.lookupSpecie.id == specie.sinantropo)}">
			Famiglia/Genere:
		</c:if>
		<c:if test="${(esame.cartellaClinica.accettazione.animale.lookupSpecie.id != specie.sinantropo)}">
			Razza:
		</c:if>
    			</c:otherwise>
    		</c:choose>
        
        
        
        
        
        </td>
    		<td>
    			${anagraficaAnimale.razza}	
    		</td>  
    		<td>
    		</td>  		
        </tr>
        
        
        
	
	
	
    			<c:choose>
    			<c:when test="${esame.outsideCC}">
    				<c:if test="${esame.animale.lookupSpecie.id==specie.cane}">
	<tr class='even'>
		<td>
			Taglia
		</td>
		<td>
			${anagraficaAnimale.taglia}
		</td>
	</tr>
	</c:if>
	
    			</c:when> 
    			<c:otherwise>
    				<c:if test="${esame.cartellaClinica.accettazione.animale.lookupSpecie.id==specie.cane}">
	<tr class='even'>
		<td>
			Taglia
		</td>
		<td>
			${anagraficaAnimale.taglia}
		</td>
	</tr>
	</c:if>
    			</c:otherwise>
    		</c:choose>
    		
    		
    		
    		<c:choose>
    			<c:when test="${esame.outsideCC}">
    				<c:if test="${esame.animale.lookupSpecie.id!=specie.sinantropo}">
	<tr class='even'>
		<td>
			Mantello
		</td>
		<td>
			${anagraficaAnimale.mantello}
		</td>
	</tr>
	</c:if>
	
    			</c:when> 
    			<c:otherwise>
    				<c:if test="${esame.cartellaClinica.accettazione.animale.lookupSpecie.id!=specie.sinantropo}">
	<tr class='even'>
		<td>
			Mantello
		</td>
		<td>
			${anagraficaAnimale.mantello}
		</td>
	</tr>
	</c:if>
    			</c:otherwise>
    		</c:choose>
	
	<tr class='even'>
		<td>
			Stato attuale:
		</td>
		<td>${anagraficaAnimale.statoAttuale }
		</td>
	</tr>
	
	
	<c:if test="${anagraficaAnimale.animale.lookupSpecie.id != specie.sinantropo}">
	<tr class='odd'>
		<td>
			Sterilizzazione:
		</td>
		<td>
			${anagraficaAnimale.sterilizzato }
		</td>
	</tr>
	</c:if>
	
        <c:choose>
    			<c:when test="${esame.outsideCC==false && (esame.cartellaClinica.accettazione.animale.dataMorte!=null || res.dataEvento!=null)}">
	      			 <c:choose>
	        			<c:when test="${esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe == true}">						
							<fmt:formatDate type="date" value="${esame.cartellaClinica.accettazione.animale.dataMorte}" pattern="dd/MM/yyyy" var="dataMorte"/>
						</c:when>
						<c:otherwise>
							<fmt:formatDate type="date" value="${res.dataEvento}" pattern="dd/MM/yyyy" var="dataMorte"/>
						</c:otherwise>	
					</c:choose>	
    			</c:when> 
    			<c:when test="${esame.animale.dataMorte!=null || res.dataEvento!=null}">
       				<c:choose>
        				<c:when test="${esame.animale.decedutoNonAnagrafe == true}">						
							<fmt:formatDate type="date" value="${esame.animale.dataMorte}" pattern="dd/MM/yyyy" var="dataMorte"/>
						</c:when>
						<c:otherwise>
							<fmt:formatDate type="date" value="${res.dataEvento}" pattern="dd/MM/yyyy" var="dataMorte"/>
						</c:otherwise>	
					</c:choose>	
    			</c:when>
    		</c:choose>
    		
    		
    		
        
       
        <tr class='odd'>
   			<td>
   				Data del decesso
   			</td>
   			<td>
				${dataMorte}
			</td>
			<td>			
				
				<c:choose>
    			<c:when test="${esame.outsideCC}">
    					<c:choose>
					<c:when test="${esame.animale.decedutoNonAnagrafe == true}">						
						${esame.animale.dataMorteCertezza}
					</c:when>
					<c:otherwise>
						${res.dataMorteCertezza}
					</c:otherwise>	
				</c:choose>		 
    			</c:when> 
    			<c:otherwise>
				<c:choose>
					<c:when test="${esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe == true}">						
						${cc.accettazione.animale.dataMorteCertezza}
					</c:when>
					<c:otherwise>
						${res.dataMorteCertezza}
					</c:otherwise>	
				</c:choose>	 
    			</c:otherwise>
    		</c:choose>
        	</td>
   		</tr>
    	
   		<tr class='even'>
      	  <td>
    			Probabile causa del decesso
   			</td>
   			<td>    
    			<c:choose>
    			<c:when test="${esame.outsideCC}">
    				
    				<c:choose>
    				<c:when test="${esame.animale.decedutoNonAnagrafe}">
    					${esame.animale.causaMorte.description}
    				</c:when>
    				<c:otherwise>
    					${res.decessoValue}
    				</c:otherwise>
    			</c:choose>	
    			</c:when> 
    			<c:otherwise>
    			
    			<c:choose>
    				<c:when test="${esame.cartellaClinica.accettazione.animale.decedutoNonAnagrafe}">
    					${esame.cartellaClinica.accettazione.animale.causaMorte.description}
    				</c:when>
    				<c:otherwise>
    					${res.decessoValue}
    				</c:otherwise>
    			</c:choose>	
    			
    			
    			</c:otherwise>
    		</c:choose>
    		
    		       	        
        	</td>
       		<td>
        	</td>
       	</tr>
       	
       	
       	
       	
       	
       	
       	<tr class='odd'>
    		<td>
    			Peso dell'animale (in Kg)
    		</td>
    		<td>
    			 <c:choose>
					<c:when test="${esame.outsideCC}">
						${esame.peso}
					</c:when>
					<c:otherwise>
						${esame.cartellaClinica.peso}
					</c:otherwise>   
				</c:choose>
    		</td>
    		<td>
    		</td>
        </tr>

        <tr class='even'>
    		<td>
    			Habitat 
    		</td>
    		<td>
				<c:choose>
					<c:when test="${esame.outsideCC}">
						${esame.lookupHabitats}
					</c:when>
					<c:otherwise>
						${esame.cartellaClinica.lookupHabitats}
					</c:otherwise>   
				</c:choose>
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr class='odd'>
    		<td>
    			Alimentazione
    		</td>
    		<td>
    			<c:choose>
					<c:when test="${esame.outsideCC}">
						${esame.lookupAlimentazionis} - ${esame.lookupAlimentazioniQualitas}
					</c:when>
					<c:otherwise>
						${esame.cartellaClinica.lookupAlimentazionis} - ${esame.cartellaClinica.lookupAlimentazioniQualitas}
					</c:otherwise>   
				</c:choose>
    		</td>
    		<td>
    		</td>
        </tr>
        
        <tr>
    		<th colspan="2">
    			Esame numero ${esame.numero } , richiesto 
    			in data <fmt:formatDate type="date" value="${esame.dataRichiesta}" pattern="dd/MM/yyyy" />
    			. Diagnosi ricevuta in data <fmt:formatDate type="date" value="${esame.dataEsito}" pattern="dd/MM/yyyy" />
    		</th>
    	</tr>
    	
<c:if test = "${fn:contains(esame, 'IST')}">

      
      
        	
    	<tr class='odd'>
    		<td>
    			 Laboratorio di destinazione
    		</td>
    		<td>
    			 ${esame.lass.description}
    			 <c:if test="${esame.lass.id==19}">
    			 	: ${esame.laboratorioPrivato} 
    			 </c:if> 
    		</td>
    		<td>
    		</td>
        </tr>
        
             

		<tr class="even">
    		<td>
    			 Numero rif. Mittente
    		</td>
    		<td>
				 ${esame.numeroAccettazioneSigla}
    		</td>
    		<td>
    		</td>
        </tr>
        
         </c:if>

		<tr class="odd">
    		<td style="width:30%">
    			 Tipo Prelievo
    		</td>
    		<td style="width:70%">  
    		
    		<c:choose>
    			<c:when test = "${fn:contains(esame, 'IST')}">
    				${esame.tipoPrelievo.description }
    			</c:when>
    			<c:otherwise>
    				${esame.tipoPrelievo.descrizione }
    			</c:otherwise>
    		</c:choose>
    		</td>
        </tr> 
        <c:if test = "${fn:contains(esame, 'IST')}">
        <tr class="odd">
    		<td style="width:30%">
    			 Tumore
    		</td>
    		<td style="width:70%">  
    			${esame.tumore.description }
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Sede Lesione e Sottospecifica
    		</td>
    		<td style="width:70%">  
    			${esame.sedeLesione }  
    		</td>
        </tr> 
        
        </c:if>
          
        <%
        //Abilitazione 287
		if(Application.get("flusso_287").equals("true"))
		{
		%>


         
        <c:if test = "${fn:contains(esame, 'IST')}">
        <tr class="odd">
    		<td style="width:30%">
    			 Trattamenti ormonali
    		</td>
    		<td style="width:70%">  
    			${esame.trattOrm}
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Stato generale
    		</td>
    		<td style="width:70%">  
    			${esame.statoGenerale} ${esame.statoGeneraleLookup}
    		</td>
        </tr>  
        
        </c:if>
        <%
}
%>


<c:if test = "${fn:contains(esame, 'IST')}">
        <tr>
    		<td style="width:30%">
    			 Tumori Precedenti
    		</td>
    		<td style="width:70%"> 
    			${esame.tumoriPrecedenti.description }  
    		</td>
        </tr>    
        
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t || esame.n || esame.m || esame.dataDiagnosi!=null || esame.diagnosiPrecedente)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente}
    		</td>
        </tr>  
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m }  
    		</td>
        </tr> 
    </c:if>
    
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t1 || esame.n1 || esame.m1 || esame.dataDiagnosi1!=null || esame.diagnosiPrecedente1)}">
         <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi1}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente1}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t1 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n1 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m1 }  
    		</td>
        </tr> 
    </c:if>
    
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t2 || esame.n2 || esame.m2 || esame.dataDiagnosi2!=null || esame.diagnosiPrecedente2)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi2}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente2}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t2 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n2 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m2 }  
    		</td>
        </tr> 
    </c:if>
    
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t3 || esame.n3 || esame.m3 || esame.dataDiagnosi3!=null || esame.diagnosiPrecedente3)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi3}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente3}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t3 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n3 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m3 }  
    		</td>
        </tr> 
    </c:if>
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t4 || esame.n4 || esame.m4 || esame.dataDiagnosi4!=null || esame.diagnosiPrecedente4)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi4}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente4}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t4 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n4 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m4 }  
    		</td>
        </tr> 
    </c:if>
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t5 || esame.n5 || esame.m5 || esame.dataDiagnosi5!=null || esame.diagnosiPrecedente5)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi5}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente5}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t5 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n5 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m5 }  
    		</td>
        </tr> 
    </c:if>
        
        <tr class="odd">
    		<td style="width:30%" >
    			 Dimensione (centimetri)
    		</td>
    		<td style="width:70%"> 
    			${esame.dimensione }
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Interessamento Linfonodale
    		</td>
    		<td style="width:70%">  
    			${esame.interessamentoLinfonodale.description }  
    		</td>
        </tr> 
        
        <tr>
        	<th colspan="2">
        		RISULTATO
        	</th>
        </tr>
        <tr>
    		<td style="width:30%">
    			 Descrizione Morfologica
    		</td>
    		<td style="width:70%">  
    			${esame.descrizioneMorfologica }  
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi
    		</td>
    		<td style="width:70%">  
    			${esame.tipoDiagnosi.description }: ${esame.whoUmana } ${esame.diagnosiNonTumorale } 
    		</td>
        </tr> 
        
        </c:if>
        
        
        
     <c:if test = "${fn:contains(esame, 'CIT')}">   
        
        
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
        
        </c:if>
        
   	</table>
   	 <c:if test = "${fn:contains(esame, 'IST')}">  
   		<input type="button" value="Immagini Istopatologico" onclick="javascript:avviaPopup( 'vam.cc.esamiIstopatologici.GestioneImmagini.us?id=${esame.id }&cc=${cc.id}' );" />
	</c:if>
	
	<c:if test="${esame.outsideCC==false}">
		<input type="button" value="Necroscopia/Vedi CC" onclick="javascript:if(${esame.cartellaClinica.autopsia!=null}){avviaPopup( 'vam.cc.autopsie.DetailDaIsto.us?idCc=${esame.cartellaClinica.id}' );}else{avviaPopup( 'vam.cc.DetailDaIsto.us?idCc=${esame.cartellaClinica.id}' );}" />			
 	</c:if>
 	<c:if test="${param['flagAnagrafe'] == null }">
		<input type="button" value="Chiudi" onclick="window.close();" />
	</c:if>
