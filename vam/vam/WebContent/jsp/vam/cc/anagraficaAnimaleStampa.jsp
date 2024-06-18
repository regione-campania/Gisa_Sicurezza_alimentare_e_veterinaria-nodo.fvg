<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<td><c:if
		test="${anagraficaAnimale.animale.lookupSpecie.id!=specie.sinantropo}">
		<h3>MANTELLO</h3>
	</c:if></td>
<td><c:if
		test="${anagraficaAnimale.animale.lookupSpecie.id!=specie.sinantropo}">
  					${anagraficaAnimale.mantello} 
    			</c:if></td>

<td><c:if
		test="${anagraficaAnimale.animale.lookupSpecie.id==specie.cane}">
		<h3>TAGLIA</h3>
	</c:if></td>
<td>${anagraficaAnimale.taglia}</td>
<c:if
	test="${anagraficaAnimale.animale.lookupSpecie.id != specie.sinantropo}">
	<tr><td>
		<h3>Sterilizzazione</h3></td>
		<td>${anagraficaAnimale.sterilizzato}</td>
	</tr>
</c:if>