<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>


<tr class='even'>
	<td>
		<c:if test="${(animale.lookupSpecie.id == specie.sinantropo)}">
			Famiglia/Genere:
		</c:if>
		<c:if test="${(animale.lookupSpecie.id != specie.sinantropo)}">
			Razza:
		</c:if>
	</td>
	<td>					  
		${anagraficaAnimale.razza}				
	</td>
</tr>
<tr class='odd'>
	<td>
		Sesso:
	</td>
	<td>
		${anagraficaAnimale.sesso}
	</td>
</tr>
	<c:if test="${animale.lookupSpecie.id==specie.cane}">
	<tr class='even'>
		<td>
			Taglia:
		</td>
		<td>
			${anagraficaAnimale.taglia}
		</td>
	</tr>
	</c:if>
	<c:if test="${animale.lookupSpecie.id!=specie.sinantropo}">
	<tr class='odd'>
		<td>
			Mantello:
		</td>
		<td>
			${anagraficaAnimale.mantello}
		</td>
	</tr>
	</c:if>	
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