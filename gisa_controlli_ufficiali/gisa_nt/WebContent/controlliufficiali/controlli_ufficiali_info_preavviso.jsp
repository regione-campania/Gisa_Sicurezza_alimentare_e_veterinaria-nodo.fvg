<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<tr id="preavviso"   class="containerBody">
		<td  class="formLabel">
			Effettuato Preavviso
			</td>
		<td>
		<select id= "flag_preavviso" name = "flag_preavviso" onchange="if(document.getElementById('flag_preavviso').value != '-1'&& document.getElementById('flag_preavviso').value!='N'){document.getElementById('data_preavviso_ba_tr').style.display=''}else{document.getElementById('data_preavviso_ba_tr').style.display='none';document.getElementById('data_preavviso_ba').value='';}">
		<option value = "-1" selected="selected" >Seleziona Voce</option>
		<option value = "N">Nessun Preavviso</option>
		<option value = "P">Telefono</option>
		<option value = "T">Telegramma</option>
		<option value = "A">Altro</option>
		
		</select>
		</td>
		</tr>
		
		<tr id="data_preavviso_ba_tr" class="containerBody" style="display: none">
		<td  class="formLabel">
			Data Preavviso
			</td>
		<td>
		
					<input class="date_picker" type="text" id="data_preavviso_ba" name="data_preavviso_ba" size="10" />
		
		</td>
		</tr>
<script>
$( document ).ready(function() {
	calenda('data_preavviso_ba','','0');
});
</script>