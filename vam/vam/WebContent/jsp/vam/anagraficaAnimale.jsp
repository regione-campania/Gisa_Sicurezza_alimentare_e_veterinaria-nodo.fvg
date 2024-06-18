<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

<tr class='odd'>
    		<td>
    			<c:if test="${(anagraficaAnimale.animale.lookupSpecie.id == specie.sinantropo)}">
					Famiglia/Genere
				</c:if>
				<c:if test="${(anagraficaAnimale.animale.lookupSpecie.id != specie.sinantropo)}">
					Razza
				</c:if>
    		</td>
    		<td colspan="4">
    			${anagraficaAnimale.razza}			   
    		</td>    		
        </tr>
        
        <tr class='even'>
    		<td>
    			Sesso
    		</td>
    		<td colspan="4">
  				${anagraficaAnimale.sesso}			      
    		</td>    		
        </tr>
        
        <c:if test="${anagraficaAnimale.animale.lookupSpecie.id==specie.cane}">
        <tr class='odd'>
    		<td>
    			Taglia
    		</td>
    		<td colspan="4">
  				${anagraficaAnimale.taglia}		
  			</td>   		
        </tr>
        </c:if>
        
        <c:if test="${anagraficaAnimale.animale.lookupSpecie.id!=specie.sinantropo}">
        <tr class='even'>
    		<td>
    			Mantello
    		</td>
    		<td colspan="4">
  				${anagraficaAnimale.mantello}	
    		</td>    		
        </tr>
        </c:if>
        
        <c:if test="${anagraficaAnimale.animale.lookupSpecie.id != specie.sinantropo}">
        <tr class='odd'>
    		<td>
    			Sterilizzazione
    		</td>
    		<td colspan="4">
    			${anagraficaAnimale.sterilizzato}
    		</td>   		
        </tr>
        
         <tr class='even'>
    		<td>
    			Stato attuale
    		</td>
    		<td colspan="4">
				${anagraficaAnimale.statoAttuale}
    		</td>   		
        </tr>
        </c:if>