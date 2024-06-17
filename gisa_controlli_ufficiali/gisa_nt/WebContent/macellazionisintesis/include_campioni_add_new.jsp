<script>
function aggiungiCampioneMacelli(){
	var matricola = document.getElementById("cd_matricola").value;
	var dataPrelievo =  document.getElementById("vpm_data").value;
	var altId = document.getElementById("id_macello").value;
	
	if (document.getElementById("cd_matricola").value=="") {
		alert("Inserire prima la matricola!");
		return false;
	} else if (document.getElementById("vpm_data").value=="") {
		alert("Inserire prima la data di macellazione!");
		return false;
	
	} else {
	
		document.getElementById("cd_matricola").readOnly = true;
		window.open('StabilimentoSintesisActionCampioni.do?command=AddCapoMacello&matricola='+matricola+'&dataPrelievo='+dataPrelievo+'&altId='+altId,'popupSelectCampioniMacelli',
     'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}

}

</script>




<table class="details" width="100%" border="0" cellpadding="10" cellspacing="0" id="listaCampioni" name="listaCampioni" style="background:white !important">
<tr><th colspan="6">Campioni</th></tr>
<tr><th>Data Prelievo</th><th>Motivazione</th><th>Matrice</th><th>Analiti</th><th>Note</th><th>Operazioni</th></tr>
<tr><td colspan="6"><input type="button" value="Aggiungi Campione" onClick="aggiungiCampioneMacelli()"/></td></tr>
</table>
