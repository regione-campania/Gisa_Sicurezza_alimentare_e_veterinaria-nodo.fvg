<script>
function aggiungiCampioneMacelli(){
	var matricola = document.getElementById("cd_matricola").value;
	var dataPrelievo =  document.getElementById("vpm_data").value;
	var altId = document.getElementById("id_macello").value;
	var idCapo = document.getElementById("id_capo").value;

	if (document.getElementById("cd_matricola").value=="") {
		alert("Inserire prima la matricola!");
		return false;
	} else if (document.getElementById("vpm_data").value=="") {
		alert("Inserire prima la data di macellazione!");
		return false;
	
	} else {
	 window.open('StabilimentoSintesisActionCampioni.do?command=AddCapoMacello&matricola='+matricola+'&dataPrelievo='+dataPrelievo+'&altId='+altId+"&idCapo="+idCapo,'popupSelectCampioniMacelli',
     'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}
}

</script> 


<table cellpadding="4" cellspacing="0" width="100%" class="details">

<tr><th colspan="6"><strong>Campioni</strong></th></tr>

<tr>
<th>Numero verbale</th>
<th>Data Prelievo</th>
<th>Motivazione</th>
<th>Matrice</th>
<th>Analiti</th>
<th>Note</th>
</tr>

<% for (int i = 0; i<CampioniNew.size(); i++) {
	CampioneNew c = (CampioneNew) CampioniNew.get(i);	%>

<tr>
<td><a href="<%=(c.getIdCampione() > 0) ? "Vigilanza.do?command=CampioneDetails&id="+c.getIdCampione() : "#" %>" parent="_blank"><%=c.getNumeroVerbale() %></a></td>
<td><%=c.getDataPrelievo() %></td>
<td><%=toHtml(c.getDescrizioneMotivo()) %></td>
<td><%=c.getDescrizioneMatrice() %></td>
<td><%=c.getDescrizioneAnalisi() %></td>
<td><%=c.getNote() %></td>
</tr>

<% } %>

</table> 

<table class="details" width="100%" border="0" cellpadding="10" cellspacing="0" id="listaCampioni" name="listaCampioni" style="background:white !important">
<tr><th>Data Prelievo</th><th>Motivazione</th><th>Matrice</th><th>Analiti</th><th>Note</th><th>Operazioni</th></tr>
<tr><td colspan="6"><input type="button" value="Aggiungi Campione" onClick="aggiungiCampioneMacelli()"/></td></tr>
</table>
