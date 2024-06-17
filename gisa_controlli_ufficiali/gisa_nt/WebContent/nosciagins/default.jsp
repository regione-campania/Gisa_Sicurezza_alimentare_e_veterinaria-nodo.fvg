<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<table class="trails" cellspacing="0">
<tr>
	<td>
		<a href="AltriStabilimenti.do?command=Default">ALTRI STABILIMENTI </a> 
		> GESTIONE ANAGRAFICHE NO-SCIA 
	
	</td>
</tr>
</table>


<h2>Selezionare la linea di attività</h2>
<form>
	<select id="linee" name="linee" style="max-width: 40%;">
		<c:forEach items="${listLinee}" var="linee">
			<option value="${linee.codice_univoco_ml}">${linee.desc_linea}</option>
		</c:forEach>
	</select> <input type="button" value="Avanti" onclick="getTemplate()">

</form>


<script>
function getTemplate() {
	loadModalWindow();
	   var selector = document.getElementById('linee');
	   var value = selector[selector.selectedIndex].value;

       var link = 'GisaNoSciaGINS.do?command=Choose&codice_univoco_ml='+value;
       window.location.href=link;
         

	   }
</script>


