<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
function detailOpuInserito(value) {
	
	loadModalWindowCustom('');
	var link = 'OpuStab.do?command=Details&stabId='+value;
	   window.location.href=link;
}
</script>

<center>
	<br><br><br><br><br>
	<b><font size="10">ATTENDERE PREGO</font></b>
	<br><br><br><br><br>  
	<input type="hidden" id="idStab" name="idStab" value="${id_stabilimento}">
</center>



<script>
  var idStabilimento = document.getElementById("idStab").value; 
  detailOpuInserito(idStabilimento);
</script>
