<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<center>

<form method="post" id="form_hidden_trasferimento" action="InterfValidazioneRichieste.do?command=ValidaEConvergi">
	
	<input type="hidden" name="codice_regionale" value="${codice_regionale}"> 
	<input type="hidden" name="pIvaImpresa" value="${pIvaImpresa}"/>
	<input type="hidden" name="codiceFiscaleImpresa" value="${codiceFiscaleImpresa}"> 
	<input type="hidden" name="idRichiesta" value="${idRichiesta}"/>
	<input type="hidden" name="idTipoRichiesta" value="${idTipoRichiesta}"> 
	<input type="hidden" name="statoValidazione" value="${statoValidazione}"/>
	<input type="hidden" name="idLinea" value="${idLinea}"/>
	<input type="hidden" name="idTipoLinea" value="${idTipoLinea}"/>
	<input type="hidden" name="codiciNazionali" value="${codiciNazionali}"/>
	
</form>
	
</center>

<script>

	loadModalWindowCustom('ATTENDERE PREGO');
	document.getElementById("form_hidden_trasferimento").submit();

</script>