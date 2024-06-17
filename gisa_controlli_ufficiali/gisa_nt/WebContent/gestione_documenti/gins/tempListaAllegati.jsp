<h2>stato operazione</h2>
<tr>
	<td>  
		<label id="inserimento_linea">operazione in corso</label>    
		<input type="hidden" id="alt_id" value="${alt_id}"> 
		<input type="hidden" id="stab_id" value="${stab_id}"> 
		<input type="hidden" id="numeroPratica" value="${numeroPratica}"> 
		<input type="hidden" id="desc_operatore" value="${desc_operatore}">
		<input type="hidden" id="idComunePratica" value="${idComunePratica}">
	</td>
</tr>

<script>
	
	var stabId = document.getElementById("stab_id").value; 
	var altId = document.getElementById("alt_id").value; 
	var numeroPratica = document.getElementById("numeroPratica").value; 
	var comunePratica = document.getElementById("idComunePratica").value;
	var desc_operatore = document.getElementById("desc_operatore").value;
	
	loadModalWindow();
	window.location.href='GestioneAllegatiGins.do?command=ListaAllegati&numeroPratica=' + numeroPratica + 
			'&desc_operatore=' + desc_operatore +
			'&alt_id=' + altId + 
			'&stab_id=' + stabId + 
			'&idComunePratica=' + comunePratica;

</script>