<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
function detailNoSciaInserito(value) {
		loadModalWindow();
		var link = 'GestioneAnagraficaAction.do?command=Details&stabId='+value;
		//var link = 'OpuStab.do?command=Details&stabId='+value;
		   window.location.href=link;
   	}
</script>


<h2>stato operazione</h2>
<tr>
	<td>  
		<label id="inserimento_linea" name="inserimento_linea" >operazione in corso</label>    
		<input type="hidden" id="idStab" name="idStab" value="${id_stabilimento}"> 
	</td>
</tr>


<script>
  var idStabilimento = document.getElementById("idStab").value; 
  detailNoSciaInserito(idStabilimento);
</script>
