<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<li>
	<b>
		<c:if test="${(animale.lookupSpecie.id == specie.sinantropo)}">
				Famiglia/Genere:
		</c:if>
		<c:if test="${(animale.lookupSpecie.id != specie.sinantropo)}">
			Razza:
		</c:if>
	</b> 
	${anagraficaAnimale.razza}					
</li>
<li>
	<b>
		Sesso:
	</b>
	${anagraficaAnimale.sesso}		
</li>
		
<c:if test="${animale.lookupSpecie.id==specie.cane}">
	<li>
		<b>
			Taglia:
		</b> 
		${anagraficaAnimale.taglia}
	</li>
</c:if>
			
<c:if test="${animale.lookupSpecie.id!=specie.sinantropo}">
	<li>
		<b>
			Mantello:
		</b> 
		${anagraficaAnimale.mantello}
	</li>
</c:if>

<li>
	<b>
		Stato attuale:
	</b> 
	${anagraficaAnimale.statoAttuale }
</li>

<c:if test="${animale.lookupSpecie.id != specie.sinantropo}">
	<li>
		<b>
			Sterilizzazione:
		</b> 
		<c:if test="${anagraficaAnimale.sterilizzato}">
		Sterilizzato
		</c:if>
	</li>
</c:if>