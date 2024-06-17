<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
function detailInserito() {
	
	var idStabilimento = document.getElementById("idStab").value;
	var url_redirect_finale = document.getElementById("url_redirect_ok").value;
	if (url_redirect_finale == ''){
			loadModalWindowCustom('ATTENDERE PREGO');
			var link = 'GestioneAnagraficaAction.do?command=Details&stabId='+idStabilimento;
			//var link = 'OpuStab.do?command=Details&stabId='+idStabilimento;
		    window.location.href=link;
	    } else {
			loadModalWindowCustom('ATTENDERE PREGO');
			var link = url_redirect_finale + idStabilimento;
		    window.location.href=link;
	    }	
   	}
</script>

<center>
	<input type="hidden" id="idStab" name="idStab" value="${id_stabilimento}"> 
	<input type="hidden" id="url_redirect_ok" value="${url_redirect_ok}"/>
</center>

<script> 
  detailInserito();
</script>