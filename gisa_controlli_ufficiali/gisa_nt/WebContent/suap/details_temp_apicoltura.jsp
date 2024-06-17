<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<center>
	<input type="hidden" id="idStab" name="idStab" value="${id_stabilimento}"> 
</center>

<script> 
	var idStabilimentoApicoltura = document.getElementById("idStab").value;
	loadModalWindowCustom('ATTENDERE PREGO');
	window.location.href = 'ApicolturaApiari.do?command=Details&stabId='+idStabilimentoApicoltura;
</script>