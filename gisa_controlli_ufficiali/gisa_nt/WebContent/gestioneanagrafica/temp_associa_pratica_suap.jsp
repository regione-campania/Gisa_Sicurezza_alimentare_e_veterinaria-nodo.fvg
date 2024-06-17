<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
function completaOperazione() {
	
	var alt_id = document.getElementById("altId").value;
	loadModalWindowCustom('ATTENDERE PREGO');
	var link = 'GestionePraticheAction.do?command=StoricoPratiche&altId='+alt_id;
    window.location.href=link;
	    
}
</script>

<center>
	<input type="hidden" id="altId" name="altId" value="${altId}">
</center>


<script> 
  completaOperazione();
</script>