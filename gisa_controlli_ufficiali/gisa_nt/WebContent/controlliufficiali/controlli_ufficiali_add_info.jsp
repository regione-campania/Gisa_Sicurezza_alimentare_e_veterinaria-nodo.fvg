<%@page import="org.aspcfs.modules.acquedirete.actions.AcqueReteVigilanza"%>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<tr class="containerBody">
	<td nowrap class="formLabel"><dhv:label
		name="sanzionia.data_richiesta">Data Inizio Controllo</dhv:label></td>
	<td>


<input type="text" id="assignedDate" name="assignedDate" size="10" class="date_picker" onchange="$('#dataFineControllo').val('')"/>
<font color="red"><%= showError(request, "assignedDateError") %></font>
<font color="red"><%= showError(request, "dataFineControlloError") %></font>


	<dhv:permission name="cu-pregresso-view" >
		Inserimento cu Pregresso <input type = "checkbox" name = "cu_pregresso" id = "cu_pregresso" value = "1">
		<!-- A seguito di una richiesta da parte dell'ORSA di poter inserire i CU degli anni precedenti
		verrà commentato quanto riportato tra parentesi e dato il permesso.
			(non e' possibile inserire controlli per gli anni precedenti)
		 -->
	</dhv:permission>
	
	</td>
</tr>


<tr class="containerBody">
	<td nowrap class="formLabel"><dhv:label name="">Data Fine Controllo</dhv:label>
	</td>
	<td>

	
		
		<input type="text" id="dataFineControllo" name="dataFineControllo" size="10" class="date_picker" onclick="checkDataFine('assignedDate','dataFineControllo')"/>
		<%= showError(request, "dataFineControlloError") %>
		
</td>
</tr>

<tr>
	<td valign="top" class="formLabel"><dhv:label name="sanzioni.note">Note</dhv:label>
	</td>
	<td>
	<table border="0" cellspacing="0" cellpadding="0" class="empty">
		<tr>
			<td><textarea name="problem" cols="55" rows="8"><%=toString(TicketDetails.getProblem())%></textarea>
			</td>
			<td valign="top"><%=showAttribute(request, "problemError")%></td>
		</tr>
	</table>
	</td>
</tr>

<tr id="oggetto_controllo" style="display: none">
	<td valign="top" class="formLabel">Oggetto del Controllo</td>
	<td>
	<table border="0" cellspacing="0" cellpadding="0" class="empty">
		<tr>
		
		<td rowspan="3" id = "sorveglianza" style="display: none">
		<%=IspezioneMacrocategorie.getHtmlSelect("ispezione_macro",-1) %>
		<font color="red">*</font>
		</td>
		
		
			<td rowspan="3" id = "non_sorveglianza" style="display: block">
			<select name="ispezione" <%if (TipoIspezione.size()>1){ %> multiple="multiple" size="10"<%} %> id="ispezione"
				onmouseout="abilitaNoteDescrizioni();abilitaSpecieTrasportata();">
				<%
					Iterator<Integer> itLista = Ispezione.keySet().iterator();
					while (itLista.hasNext()) {
						int key = itLista.next();
				%>
				<optgroup label="<%=IspezioneMacrocategorie.getValueFromId(key)%>" style="color: blue"></optgroup>

				<%
					HashMap<Integer, String> l = (HashMap<Integer, String>) Ispezione.get(key);
						Iterator<Integer> itL = l.keySet().iterator();
						while (itL.hasNext()) {
							int code = itL.next();
							String desc = l.get(code);
							boolean sel = false;

							if (request.getAttribute("listaControlliIspezione")!=null)
							{
								ArrayList<Integer> lista = (ArrayList<Integer>) request.getAttribute("listaControlliIspezione");
								if (lista != null) {
									for (int code2 : lista) {

										if (code2 == code) {
											sel = true;
										}
									}
								}
							}
								
				%>


				<option value="<%=code%>" <%if (sel == true) {%> selected="selected"
					<%}%>><%=desc%></option>
				<%
					}

					}
				%>
			</select><font color="red">*</font></td>
			<td>&nbsp;</td>
			<td>
			<table>
				
				<tr id="desc_note2" style="display: none">
					<td><b>Macroarea: Alimentazione animale</b><br>
					<textarea rows="3" cols="20" name="ispezioni_desc2"></textarea></td>
				</tr>
				<tr id="desc_note3" style="display: none">

					<td><b>Macroarea: Benessere animale (non durante il trasporto)</b><br>

					<td><b>Settore Benessere Animale (Descrizione)</b><br>

					<textarea rows="3" cols="20" name="ispezioni_desc3"></textarea></td>
				</tr>
				<tr id="desc_note4" style="display: none">
					<td><b>Macroarea: Salute animale e igiene urbana veterinaria</b><br>
					<textarea rows="3" cols="20" name="ispezioni_desc4"></textarea></td>
				</tr>
				<tr id="desc_note5" style="display: none">
					<td><b>Macroarea: impianti/attivita' registrati o riconosciuti per M.S.R. e S.O.A.</b><br>
					<textarea rows="3" cols="20" name="ispezioni_desc5"></textarea></td>
				</tr>
				<tr id="desc_note6" style="display: none">
					<td><b>Macroarea: M.S.R., S.O.A. e Rifiuti in altri stabilimenti</b><br>
					<textarea rows="3" cols="20" name="ispezioni_desc6"></textarea></td>
				</tr>
				<tr id="desc_note7" style="display: none">
					<td><b>Macroarea: Altro</b><br>
					<textarea rows="3" cols="20" name="ispezioni_desc7"></textarea></td>
				</tr>
				<!-- COMMENTO RITA: NON GESTITO QUESTO CAMPO A LIVELLO ACTION! -->
<!-- 				<tr id="desc_note9" style="display: none"> -->
<!-- 					<td><b>Macroarea: Farmaci veterinari</b><br> -->
<!-- 					<textarea rows="3" cols="20" name="ispezioni_desc9"></textarea></td> -->
<!-- 				</tr> -->
				
			</table>
			</td>

		</tr>
	</table>
	</td>
</tr>

<tr id="specieT" style="display: none">
	<td nowrap class="formLabel">
		<dhv:label name="">Specie Animali Trasportati</dhv:label>
	</td>
	<td>
	<table border="0" cellspacing="0" cellpadding="0" class="empty">
		<tr>
			<td rowspan="3">
			
			</td>
				<%SpecieA.setJsEvent("onchange= abilitaNumCapi();"); %>
				<td><%=SpecieA.getHtmlSelect("animalitrasp",-1) %>
				&nbsp; <font color="red">*</font></td>
			
			<td>&nbsp;</td>
			<td>
			<table>
			<tr>
					<td><b>Num. docum. di accompagnam. controllati</b><br>
				<input type="text" id="num_documento_accompagnamento" name="num_documento_accompagnamento" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Documento può contenere solo valori numerici');" /></td>
			</tr>
			<tr id="num_capo1" style="display: none">
					<td><b>Num. capi Bovini</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie1" name="num_specie1" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. capi Bovini può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo2" style="display: none">
				<td><b>Num. capi Suini</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie2" name="num_specie2" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. capi Suini può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo3" style="display: none">
					<td><b>Num. capi Equidi</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie4" name="num_specie3" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. capi Equidi può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo4" style="display: none">
					<td><b>Num. capi Altre Specie </b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie6" name="num_specie4" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. capi Altre Specie può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo5" style="display: none">
					<td><b>Num. capi Bufali </b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie10" name="num_specie5" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. capi Bufali può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo6" style="display: none">
					<td><b>Num. Pesci acqua dolce</b><br>
					<input type="number" pattern="[0-9]"   min="1" id="num_specie11" name="num_specie6" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Pesci acqua dolce può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo7" style="display: none">
					<td><b>Num. Pesci Ornamentali</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie12" name="num_specie7" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Pesci Ornamentali può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo8" style="display: none">
					<td><b>Num. Oche</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie13" name="num_specie8" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Oche può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
 			<tr id="num_capo9" style="display: none">
					<td><b>Num. Conigli</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie14" name="num_specie9" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Conigli può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo10" style="display: none">
					<td><b>Num. Ovaiole</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie15" name="num_specie10" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Ovaiole può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo11" style="display: none">
					<td><b>Num. Broiler</b><br>
				<input type="number" pattern="[0-9]"   id="num_specie16" name="num_specie11" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Broiler può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo12" style="display: none">
					<td><b>Num. capi Vitelli</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie18" name="num_specie12" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. capi Vitelli può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo13" style="display: none">
					<td><b>Num. Struzzi</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie19" name="num_specie13" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Struzzi può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo14" style="display: none">
					<td><b>Num. Cani</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie20" name="num_specie14" size="5"  onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Cani può contenere solo valori numerici');"/><font color="red">*</font></td>
			</tr>
			<tr id="num_capo15" style="display: none">
					<td><b>Num. Ovicaprini</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie21" name="num_specie15" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Ovicaprini può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo22" style="display: none">
					<td><b>Num. capi di Pollame</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie22" name="num_specie22" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. capi Pollame può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo23" style="display: none">
					<td><b>Num. Pesci</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie23" name="num_specie23" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Pesci può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo24" style="display: none">
					<td><b>Num. Uccelli</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie24" name="num_specie24" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Uccelli può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo25" style="display: none">
					<td><b>Num. Rettili</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie25" name="num_specie25" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. Rettili può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
			<tr id="num_capo26" style="display: none">
					<td><b>Num. capi Altre specie</b><br>
				<input type="number" pattern="[0-9]"   min="1" id="num_specie26" name="num_specie26" size="5" onkeyup="javascript:if (isNaN(value)) alert ('Errore il campo Num. capi Altre specie può contenere solo valori numerici');" /><font color="red">*</font></td>
			</tr>
				
			</table>
			</td>

		</tr>
	</table>
	</td>
</tr>
 <input type = "hidden" id = "modificabile" name  = "modificabile" value = "yes">
<input type="hidden" name="ncrilevate" value="2" />
<!-- nucleo ispettivo -->
<%@ include file="nucleo_ispettivo_modify.jsp"%>
<%--

String codice = "" ;
if(TipoIspezione.getElementfromValue(valTipoIspezioneDefault)!=null)
	codice  = TipoIspezione.getElementfromValue(valTipoIspezioneDefault).getCodiceInterno();

if(codice.equalsIgnoreCase("2a"))
{
	int idPiano = AcqueReteVigilanza.CODICE_INTERNO_PIANO_CONTROLLO;
	String descrizionePiano = PianoMonitoraggio1.getElementfromCodiceInterno(idPiano+"").getDescription();
%>
<script>
arrayValue = new Array();
arrayDesc = new Array();
 arrayValue[0] ="<%=PianoMonitoraggio1.getElementfromCodiceInterno(idPiano+"").getCode()%>";
 arrayDesc[0]="<%=descrizionePiano%>";
clonaNelPadrePiani(arrayValue,arrayDesc);
</script>
<% 
	
}
--%>
<script>
$( document ).ready(function() {
	calenda('assignedDate','','0');
	calenda('dataFineControllo','','0');
	
	$('#assignedDate').change( function(){
		console.log('changed');
		if($('#tipoCampione').val() == 2){
			var dataSel = $('#assignedDate').datepicker('getDate');
			if (dataSel !== null) { // if any date selected in datepicker
			    dataSel instanceof Date; // -> true
			    if(dataSel.getFullYear() > new Date().getFullYear()-1){
			    	$('#assignedDate').val('');
			    	alert("Non e' possibile inserire una data dell'anno corrente.");
			    }
			}
		}
	});
	
	$('#dataFineControllo').change( function(){
		console.log('changed');
		if($('#tipoCampione').val() == 2){
			var dataSel = $('#dataFineControllo').datepicker('getDate');
			if (dataSel !== null) { // if any date selected in datepicker
			    dataSel instanceof Date; // -> true
			    if(dataSel.getFullYear() > new Date().getFullYear()-1){
			    	$('#dataFineControllo').val('');
			    	alert("Non e' possibile inserire una data dell'anno corrente.");
			    }
			}
		}
	});
	
});

</script>