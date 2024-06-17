<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<table class="trails" cellspacing="0">
<tr>
	<td>
		<a href="AltriStabilimenti.do?command=Default">ALTRI STABILIMENTI </a> 
		> GESTIONE NO-SCIA 
	
	</td>
</tr>
</table>


<h2>Selezionare la linea di attività</h2>
<form>
	<select id="linee" name="linee" style="max-width: 80%;">
		<c:forEach items="${listLinee}" var="linee">
			<c:if test= "${!fn:contains(linee.codice_univoco_ml, 'OPR-OPR-X')}">
				<option value="${linee.codice_univoco_ml}">${linee.desc_linea}</option>
			</c:if>
		</c:forEach>
	</select> <input type="button" value="Avanti" onclick="getTemplate()">

</form>


<script>
function getTemplate() {
	loadModalWindow();
	   var selector = document.getElementById('linee');
	   var value = selector[selector.selectedIndex].value;

       var link = 'GisaNoScia.do?command=Choose&codice_univoco_ml='+value;
       window.location.href=link;
         

	   }
</script>


