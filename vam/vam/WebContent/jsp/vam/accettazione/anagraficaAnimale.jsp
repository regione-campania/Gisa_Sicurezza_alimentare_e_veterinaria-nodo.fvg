<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<li>	
	<b>
		<c:if test="${(anagraficaAnimale.animale.lookupSpecie.id == specie.sinantropo)}">
			Famiglia/Genere
		</c:if>
		<c:if test="${(anagraficaAnimale.animale.lookupSpecie.id != specie.sinantropo)}">
			Razza
		</c:if>
	</b> 
	${anagraficaAnimale.razza}
</li>
<li>
	<b>
		Sesso:
	</b>${anagraficaAnimale.sesso}
</li>
<c:if test="${anagraficaAnimale.animale.lookupSpecie.id!=specie.sinantropo}">
	<li>
		<b>
			Mantello:
		</b> 
		${anagraficaAnimale.mantello}
	</li>
</c:if>
<c:if test="${anagraficaAnimale.animale.lookupSpecie.id==specie.cane}">
	<li>
		<b>
			Taglia:
		</b> 
		${anagraficaAnimale.taglia}
	</li>
</c:if>
<li>
	Stato attuale: ${anagraficaAnimale.statoAttuale}
</li>