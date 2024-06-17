<input type="hidden" id="esito_sigla" value="" >
<input type="hidden" id="user_id_call_wssigla" value="<%=User.getUserId()%>">

<script>

function ritornoDaSigla(cod_preac, id_utente){
	DwrPreaccettazione.Preaccettazione_Ritorno_Da_Sigla(cod_preac, id_utente, {callback:ritornoDaSiglaCallBack,async:false});
}
function ritornoDaSiglaCallBack(returnValue)
{
	var dati = returnValue;
	
	if(returnValue.trim() != ''){
		
		document.getElementById("esito_sigla").value = returnValue;
		var campo_esito = null;
		if(document.getElementById('esito_note_esame')){
			campo_esito = document.getElementById('esito_note_esame');
			campo_esito.value = document.getElementById('esito_sigla').value;
			campo_esito.cols = "170";
			campo_esito.removeAttribute('onkeyup');
			campo_esito.removeAttribute('onpaste');
			campo_esito.readOnly = true;
			campo_esito.style.resize = 'none';
			campo_esito.style.display = 'none';
			campo_esito.insertAdjacentHTML('afterend', '<div>' + document.getElementById('esito_sigla').value + '</div>');
		} else if(document.getElementsByName('esito_note_esame')){
			campo_esito = document.getElementsByName('esito_note_esame')[0];
			campo_esito.value = document.getElementById('esito_sigla').value;
			campo_esito.cols = "170";
			campo_esito.removeAttribute('onkeyup');
			campo_esito.removeAttribute('onpaste');
			campo_esito.readOnly = true;
			campo_esito.style.resize = 'none';
			campo_esito.style.display = 'none';
			campo_esito.insertAdjacentHTML('afterend', '<div>' + document.getElementById('esito_sigla').value + '</div>');
		}
	}
}

if(document.getElementById("rigaCodPreacc")){
	if(document.getElementById("rigaCodPreacc").style.display != 'none'){
		var user_chiamate_sigla = document.getElementById('user_id_call_wssigla').value;
		ritornoDaSigla(document.getElementById("codpreacc").innerHTML, user_chiamate_sigla);
	}
}

</script>
