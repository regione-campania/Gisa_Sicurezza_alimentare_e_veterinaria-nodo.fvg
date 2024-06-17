<input type="hidden" id="esito_laboratorio" value="" >
<input type="hidden" id="user_id_call_wslaboratorio" value="<%=User.getUserId()%>">

<script>

function ritornoDaLaboratorio(cod_preac, id_utente, id_laboratorio){
	DwrPreaccettazione.Preaccettazione_Ritorno_Da_Laboratorio(cod_preac, id_utente, id_laboratorio, {callback:ritornoDaLaboratorioCallBack,async:false});
}
function ritornoDaLaboratorioCallBack(returnValue)
{
	var dati = returnValue;
	
	if(returnValue.trim() != ''){
		
		document.getElementById("esito_laboratorio").value = returnValue;
		var campo_esito = null;
		if(document.getElementById('esito_note_esame')){
			campo_esito = document.getElementById('esito_note_esame');
			campo_esito.value = document.getElementById('esito_laboratorio').value;
			campo_esito.cols = "170";
			campo_esito.removeAttribute('onkeyup');
			campo_esito.removeAttribute('onpaste');
			campo_esito.readOnly = true;
			campo_esito.style.resize = 'none';
			campo_esito.style.display = 'none';
			campo_esito.insertAdjacentHTML('afterend', '<div>' + document.getElementById('esito_laboratorio').value + '</div>');
		} else if(document.getElementsByName('esito_note_esame')){
			campo_esito = document.getElementsByName('esito_note_esame')[0];
			campo_esito.value = document.getElementById('esito_laboratorio').value;
			campo_esito.cols = "170";
			campo_esito.removeAttribute('onkeyup');
			campo_esito.removeAttribute('onpaste');
			campo_esito.readOnly = true;
			campo_esito.style.resize = 'none';
			campo_esito.style.display = 'none';
			campo_esito.insertAdjacentHTML('afterend', '<div>' + document.getElementById('esito_laboratorio').value + '</div>');
		}
	}
}

if(document.getElementById("rigaCodPreacc")){
	if(document.getElementById("rigaCodPreacc").style.display != 'none'){
		
		var cod_preacc = document.getElementById("codpreacc").innerHTML;
		var user_chiamate_laboratorio = document.getElementById('user_id_call_wslaboratorio').value;
		var id_laboratorio = document.getElementsByName("destinatarioCampione")[0].value;
		ritornoDaLaboratorio(cod_preacc, user_chiamate_laboratorio, id_laboratorio);
	}
}

</script>
