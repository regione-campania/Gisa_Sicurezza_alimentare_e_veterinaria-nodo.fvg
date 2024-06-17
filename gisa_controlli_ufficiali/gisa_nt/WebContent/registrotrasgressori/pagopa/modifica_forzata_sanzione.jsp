<jsp:useBean id="SanzioneDettaglio" class="org.aspcfs.modules.sanzioni.base.Ticket" scope="request"/>
<jsp:useBean id="Trasgressore" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>
<jsp:useBean id="Obbligato" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>
<jsp:useBean id="messaggio" class="java.lang.String" scope="request"/>
<jsp:useBean id="PagatoreDefault" class="org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore" scope="request"/>

<jsp:useBean id="Trasgressione" class="org.aspcfs.modules.registrotrasgressori.base.Trasgressione" scope="request"/>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>


<%@ include file="../../utils23/initPage.jsp" %>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

  <%! public static String fixString(String nome)
  {
	  String toRet = "";
	  if (nome == null)
		  return nome;
	  
	  toRet = nome.replaceAll("'", "");
	  toRet = toRet.replaceAll("\"", "");
	  return toRet;
	  
  }%>

<script>
function checkForm(form){
	
	var msg = '';
	
	if (!form.ModificaRT.checked && !form.ModificaPagatori.checked)
		msg += ' - Indicare almeno una modifica.\r\n';
	
	if (form.ModificaPagatori.checked) {
		if (form.nomeT.value.trim() == '')
			msg += ' - Il trasgressore non può essere vuoto.\r\n';
		if (form.nomeO.value.trim() == '')
			msg += ' - Indicare Obbligato o selezionare Nessuno.\r\n';
		if (form.tipoPagatoreT.value == '')
			msg += '- Inserire tipo pagatore Trasgressore. \r\n';
		if (form.tipoPagatoreO.value == ''&& form.nomeO.value.trim()!='' && form.nomeO.value!='Nessuno')
			msg += '- Inserire tipo pagatore Obbligato. \r\n';
//		if (form.nomeT.value.toUpperCase().trim() != form.nomePagatoreDefault.value.toUpperCase().trim() && form.nomeO.value.toUpperCase().trim() != form.nomePagatoreDefault.value.toUpperCase().trim())
//			msg += ' - Almeno uno tra trasgressore ed obbligato deve coincidere con operatore sottoposto a controllo.\r\n';
		if (form.nomeT.value.toUpperCase().trim() == form.nomePagatoreDefault.value.toUpperCase().trim() && form.nomeO.value.toUpperCase().trim() == form.nomePagatoreDefault.value.toUpperCase().trim())
			msg += ' - Solo uno tra trasgressore ed obbligato deve coincidere con operatore sottoposto a controllo.\r\n';
		if ((form.tipoPagatoreT.value=='F' && form.pivaT.value.length!=16) || (form.tipoPagatoreT.value=='G' && form.pivaT.value.length!=11)) 
			msg += "- Inserire tipo pagatore Trasgressore coerente con il valore indicato in Partita IVA/Codice fiscale.\r\n";
		if ((form.tipoPagatoreO.value=='F' && form.pivaO.value.length!=16) || (form.tipoPagatoreO.value=='G' && form.pivaO.value.length!=11)) 
			msg += "- Inserire tipo pagatore Obbligato coerente con il valore indicato in Partita IVA/Codice fiscale.\r\n";
		if (form.provinciaT.value.length>0 && form.provinciaT.value.length!=2)
			msg += "- Il campo Cod Provincia Trasgressore deve contenere la sigla della provincia ed essere di 2 caratteri.\r\n";
		if (form.provinciaO.value.length>0 && form.provinciaO.value.length!=2)
			msg += "- Il campo Cod Provincia Obbligato deve contenere la sigla della provincia ed essere di 2 caratteri.\r\n";
		if (form.nazioneT.value.length>0 && form.nazioneT.value.length!=2) 
			msg += "- Il campo Nazione Trasgressore deve contenere la sigla della nazione ed essere di 2 caratteri.\r\n";
		if (form.nazioneO.value.length>0 && form.nazioneO.value.length!=2) 
			msg += "- Il campo Nazione Obbligato deve contenere la sigla della nazione ed essere di 2 caratteri.\r\n";
	}
	
	if (form.ModificaRT.checked) {
		if (!form.rtPvOblatoR.checked && !form.rtPvOblatoU.checked) 
			msg += "- Indicare PV Oblato in misura ridotta o ultraridotta.\r\n";
		if (form.rtPvData.value=="") 
			msg += "- Indicare Data Pagamento PV.\r\n";
		
	}
	
	if (msg!=''){
		alert(msg);
		return false;
	}
	
	if (confirm('Salvare le modifiche?')){
		loadModalWindow();
		form.submit();
	}
		
}

function gestisciPagatore(form, val, trasgressoreObbligato){

	if (val == 'Nessuno'){
		
		form.tipoPagatoreO.value="";		form.tipoPagatoreO.disabled="disabled";
		form.pivaO.value = "";		form.pivaO.disabled="disabled";
		form.nomeO.value="Nessuno";  form.nomeO.readOnly = true; 
		form.indirizzoO.value = "";		form.indirizzoO.disabled="disabled";
		form.civicoO.value = "";		form.civicoO.disabled="disabled";
		form.capO.value = "";		form.capO.disabled="disabled";
		form.comuneO.value = "";		form.comuneO.disabled="disabled";
		form.provinciaO.value = "";		form.provinciaO.disabled="disabled";
		form.nazioneO.value = "";		form.nazioneO.disabled="disabled";
		form.mailO.value = "";		form.mailO.disabled="disabled";
		form.telefonoO.value = "";		form.telefonoO.disabled="disabled";


		
	} else {
		
	form.tipoPagatoreO.disabled="";
	form.pivaO.disabled="";
	form.nomeO.readOnly = false; 
	form.indirizzoO.disabled="";
	form.civicoO.disabled="";
	form.capO.disabled="";
	form.comuneO.disabled="";
	form.provinciaO.disabled="";
	form.nazioneO.disabled="";
	form.mailO.disabled="";
	form.telefonoO.disabled="";
		
	if (trasgressoreObbligato == 'T') {
		if (val == '<%= fixString(PagatoreDefault.getRagioneSocialeNominativo())%>'){
			
			form.tipoPagatoreT.value = '<%= PagatoreDefault.getTipoPagatore()!=null ? fixString(PagatoreDefault.getTipoPagatore()) : ""%>';
			form.nomeT.value = '<%= PagatoreDefault.getRagioneSocialeNominativo()!=null ? fixString(PagatoreDefault.getRagioneSocialeNominativo()) : ""%>';
	    	form.pivaT.value = '<%= PagatoreDefault.getPartitaIvaCodiceFiscale()!=null ? PagatoreDefault.getPartitaIvaCodiceFiscale() : ""%>';
	    	form.indirizzoT.value = '<%= PagatoreDefault.getIndirizzo()!=null ? PagatoreDefault.getIndirizzo() : ""%>';
	    	form.civicoT.value = '<%= PagatoreDefault.getCivico()!=null ? PagatoreDefault.getCivico() : ""%>';
	    	form.comuneT.value = '<%= PagatoreDefault.getComune()!=null ? PagatoreDefault.getComune() : ""%>';
	    	form.capT.value = '<%= PagatoreDefault.getCap()!=null ? PagatoreDefault.getCap() : ""%>';
	    	form.provinciaT.value = '<%= PagatoreDefault.getCodProvincia()!=null ? PagatoreDefault.getCodProvincia() : ""%>';
	    	form.nazioneT.value = '<%= PagatoreDefault.getNazione()!=null ? PagatoreDefault.getNazione() : ""%>';
	    	form.mailT.value = '<%= PagatoreDefault.getDomicilioDigitale()!=null ? PagatoreDefault.getDomicilioDigitale() : ""%>';
	    	form.telefonoT.value = '<%= PagatoreDefault.getTelefono()!=null ? PagatoreDefault.getTelefono() : ""%>';
	    	form.nomeT.readOnly = false;
	    	form.pivaT.readOnly = false;
	    	form.ricercaT.style.display = "none";
		} else {
			form.tipoPagatoreT.value = '';
			form.nomeT.value = '';
	    	form.pivaT.value = '';
	    	form.indirizzoT.value = '';
	    	form.civicoT.value = '';
	    	form.comuneT.value = '';
	    	form.capT.value = '';
	    	form.provinciaT.value = '';
	    	form.nazioneT.value = '';
	    	form.mailT.value = '';
	    	form.telefonoT.value = '';
	    	form.nomeT.readOnly = false;
	    	form.pivaT.readOnly = false;
	    	form.ricercaT.style.display = "block";
		}
	} 
	
	if (trasgressoreObbligato == 'O') {
		if (val == '<%= fixString(PagatoreDefault.getRagioneSocialeNominativo())%>'){
			form.tipoPagatoreO.value = '<%= PagatoreDefault.getTipoPagatore()!=null ? fixString(PagatoreDefault.getTipoPagatore()) : ""%>';
			form.nomeO.value = '<%= PagatoreDefault.getRagioneSocialeNominativo()!=null ? fixString(PagatoreDefault.getRagioneSocialeNominativo()) : ""%>';
	    	form.pivaO.value = '<%= PagatoreDefault.getPartitaIvaCodiceFiscale()!=null ? PagatoreDefault.getPartitaIvaCodiceFiscale() : ""%>';
	    	form.indirizzoO.value = '<%= PagatoreDefault.getIndirizzo()!=null ? PagatoreDefault.getIndirizzo() : ""%>';
	    	form.civicoO.value = '<%= PagatoreDefault.getCivico()!=null ? PagatoreDefault.getCivico() : ""%>';
	    	form.comuneO.value = '<%= PagatoreDefault.getComune()!=null ? PagatoreDefault.getComune() : ""%>';
	    	form.capO.value = '<%= PagatoreDefault.getCap()!=null ? PagatoreDefault.getCap() : ""%>';
	    	form.provinciaO.value = '<%= PagatoreDefault.getCodProvincia()!=null ? PagatoreDefault.getCodProvincia() : ""%>';
	    	form.nazioneO.value = '<%= PagatoreDefault.getNazione()!=null ? PagatoreDefault.getNazione() : ""%>';
	    	form.mailO.value = '<%= PagatoreDefault.getDomicilioDigitale()!=null ? PagatoreDefault.getDomicilioDigitale() : ""%>';
	    	form.telefonoO.value = '<%= PagatoreDefault.getTelefono()!=null ? PagatoreDefault.getTelefono() : ""%>';
	    	form.nomeO.readOnly = false;
	    	form.pivaO.readOnly = false;
	    	form.ricercaO.style.display = "none";

		} else {
			form.tipoPagatoreO.value = '';
			form.nomeO.value = '';
	    	form.pivaO.value = '';
	    	form.indirizzoO.value = '';
	    	form.civicoO.value = '';
	    	form.comuneO.value = '';
	    	form.capO.value = '';
	    	form.provinciaO.value = '';
	    	form.nazioneO.value = '';
	    	form.mailO.value = '';
	    	form.telefonoO.value = '';
	    	form.nomeO.readOnly = false;
	    	form.pivaO.readOnly = false;
	    	form.ricercaO.style.display = "block";
		}
	}
	
}
}

function showHideModifica(cb){
	
	if (cb.checked){
		document.getElementById("table_"+cb.name).style.display="table-row";
	}
	else {
		document.getElementById("table_"+cb.name).style.display="none";
	}
}
</script>


<% if (messaggio!=null && !messaggio.equals("")){ %>
<script>
alert('<%=messaggio%>');

<% if (!messaggio.startsWith("OK")){ %>
	window.close();
<%}%>

</script>
<%} %>

<center>

<form name="formSanzione" id="formSanzione" action="GestionePagoPa.do?command=UpdateForzataSanzione" method="post">

<table class="details" id = "tablesanzione" cellpadding="10" cellspacing="10" style="border-collapse: collapse">

<tr><th colspan="3" style="background:yellow">MODIFICA FORZATA SANZIONE</th></tr>

<tr><th colspan="4">DETTAGLIO SANZIONE</th></tr>

<tr>
<th>Id controllo ufficiale</th>  
<td colspan="2"><%=SanzioneDettaglio.getIdControlloUfficiale() %></td></tr>
<tr>
<th>Id sanzione</th>  
<td colspan="2"><%=SanzioneDettaglio.getId() %></td></tr>
<tr>
<th>Operatore sottoposto a controllo</th>  
<td colspan="2"><%=fixString(PagatoreDefault.getRagioneSocialeNominativo()) %></td></tr>

<tr>
<th>Modifiche da eseguire</th>
<td colspan="2">

<input type="checkbox" value="true" id="ModificaRT" name="ModificaRT" onClick="showHideModifica(this)" <%= Trasgressione.getId()<=0 ? "disabled" : "" %>/> Modifica Registro Trasgressori<br/>
<input type="checkbox" value="true" id="ModificaPagatori" name="ModificaPagatori" onClick="showHideModifica(this)"/> Modifica Trasgressore/Obbligato in solido
</td></tr>

</table>

<br/><br/>

<table class="details" id = "table_ModificaRT" cellpadding="10" cellspacing="10" style="border-collapse: collapse; display:none">

<tr><th colspan="3" style="background:yellow">INFORMAZIONI REGISTRO TRASGRESSORI</th></tr>

<tr>
<th>Num. progressivo</th>
<td colspan="2"><%=Trasgressione.getProgressivo() %>\<%=Trasgressione.getAnnoYY()%></td>
</tr>

<tr>
<th>PV Oblato in misura ridotta</th>
<td colspan="2"><input type="radio" name="rtPvOblato" id="rtPvOblatoR" <%=Trasgressione!=null && Trasgressione.isPagopaPvOblatoRidotta() ? "checked" : "" %> value="R"/></td>
</tr>

<tr>
<th>PV Oblato in misura ultraridotta</th>
<td colspan="2"><input type="radio" name="rtPvOblato" id="rtPvOblatoU" <%=Trasgressione!=null && Trasgressione.isPagopaPvOblatoUltraRidotta() ? "checked" : "" %> value="U"/></td>
</tr>

<tr>
<th>Data Pagamento PV</th>
<td colspan="2"><input type="date" name="rtPvData" id="rtPvData" value="<%=Trasgressione!=null  ? toDateasStringWithFormat(Trasgressione.getPagopaPvDataPagamento(), "yyyy-MM-dd") : "" %>"/></td>
</tr>

</table>

<br/><br/>

<table class="details" id = "table_ModificaPagatori" cellpadding="10" cellspacing="10" style="border-collapse: collapse; display:none">
 
<tr><th colspan="3" style="background:yellow">INFORMAZIONI TRASGRESSORI </th></tr>

<tr>
<td></td>
<th>TRASGRESSORE</th>
<th>OBBLIGATO IN SOLIDO</th>
</tr>

<tr>
<td></td>
<td>
<select name="trasgressore" id="trasgressore" onchange="gestisciPagatore(this.form, this.value, 'T')">
<option value="<%=fixString(PagatoreDefault.getRagioneSocialeNominativo())%>" <%= fixString(PagatoreDefault.getRagioneSocialeNominativo()).equals(fixString(SanzioneDettaglio.getTrasgressore())) ? "selected" : "" %>><%=fixString(PagatoreDefault.getRagioneSocialeNominativo())%></option>
<option value="Altro" <%= !fixString(PagatoreDefault.getRagioneSocialeNominativo()).equals(fixString(SanzioneDettaglio.getTrasgressore())) ? "selected" : "" %>>Altro</option>
</select>
<input type="button" id="ricercaT" name="ricercaT" style="<%= !fixString(PagatoreDefault.getRagioneSocialeNominativo()).equals(fixString(SanzioneDettaglio.getTrasgressore())) ? "" : "display:none"%>" onClick="window.open('GestionePagoPa.do?command=SearchFormPagatore&trasgressoreObbligato=T', 'cercaPagatore',  'height=400px,width=1280px,toolbar=no, scrollbars=yes,resizable=yes ,modal=yes')" value="RICERCA"/>
<input type="text" style="display:none" id ="trasgressorealtro" name="trasgressorealtro"/>
</td>

<td>
<select name="obbligato" id="obbligato" onchange="gestisciPagatore(this.form, this.value, 'O')">
<option value="<%=fixString(PagatoreDefault.getRagioneSocialeNominativo())%>" <%= fixString(PagatoreDefault.getRagioneSocialeNominativo()).equals(fixString(SanzioneDettaglio.getObbligatoinSolido())) ? "selected" : "" %>><%=fixString(PagatoreDefault.getRagioneSocialeNominativo())%></option>
<option value="Nessuno" <%= "Nessuno".equals(fixString(SanzioneDettaglio.getObbligatoinSolido())) ? "selected" : "" %>>Nessuno</option>
<option value="Altro" <%= !fixString(PagatoreDefault.getRagioneSocialeNominativo()).equals(fixString(SanzioneDettaglio.getObbligatoinSolido())) && !"Nessuno".equals(fixString(SanzioneDettaglio.getObbligatoinSolido())) ? "selected" : "" %>>Altro</option>
</select>
<input type="button" id="ricercaO" name="ricercaO" style="<%= !fixString(PagatoreDefault.getRagioneSocialeNominativo()).equals(fixString(SanzioneDettaglio.getObbligatoinSolido())) && !"Nessuno".equals(fixString(SanzioneDettaglio.getObbligatoinSolido())) ? "" : "display:none" %>" onClick="window.open('GestionePagoPa.do?command=SearchFormPagatore&trasgressoreObbligato=O', 'cercaPagatore',  'height=400px,width=1280px,toolbar=no, scrollbars=yes,resizable=yes ,modal=yes')" value="RICERCA"/>
<input type="text" style="display:none" id ="obbligatoinSolidoAltro" name="obbligatoinSolidoAltro"/>
</td>

</tr>

<tr>
<th>Tipo pagatore</th> 
<td>
<select id="tipoPagatoreT" name="tipoPagatoreT">
<option value="G" <%=toHtml(Trasgressore.getTipoPagatore()).equals("G") ? "selected" : ""%>>Società di persone/Associazioni</option>
<option value="F" <%=toHtml(Trasgressore.getTipoPagatore()).equals("F") ? "selected" : ""%>>Persona Fisica</option>
</select> 
</td>
<td>
<select id="tipoPagatoreO" name="tipoPagatoreO">
<option value="G" <%=toHtml(Obbligato.getTipoPagatore()).equals("G") ? "selected" : ""%>>Persona Giuridica</option>
<option value="F" <%=toHtml(Obbligato.getTipoPagatore()).equals("F") ? "selected" : ""%>>Persona Fisica</option>
</select>
</td>
</tr>

<tr>
<th>Partita IVA / Codice fiscale</th>
<td><input type="text" name="pivaT" id="pivaT" value="<%=toHtml(Trasgressore.getPartitaIvaCodiceFiscale())%>" size="16" maxlength="16"/></td>
<td><input type="text" name="pivaO" id="pivaO" value="<%=toHtml(Obbligato.getPartitaIvaCodiceFiscale())%>" size="16" maxlength="16"/></td>
</tr>

<tr>
<th>Ragione sociale / Nominativo</th>
<td><input type="text" name="nomeT" id="nomeT" size="50" value="<%=toHtml(fixString(Trasgressore.getRagioneSocialeNominativo()))%>"/></td>
<td><input type="text" name="nomeO" id="nomeO" size="50" value="<%=toHtml(fixString(Obbligato.getRagioneSocialeNominativo()))%>"/></td>
</tr>

<tr>
<th>Indirizzo</th>
<td><input type="text" name="indirizzoT" id="indirizzoT" size="50" value="<%=toHtml(Trasgressore.getIndirizzo())%>"/></td>
<td><input type="text" name="indirizzoO" id="indirizzoO" size="50" value="<%=toHtml(Obbligato.getIndirizzo())%>"/></td>
</tr>

<tr>
<th>Civico</th>
<td><input type="text" name="civicoT" id="civicoT" size="5" value="<%=toHtml(Trasgressore.getCivico())%>"/></td>
<td><input type="text" name="civicoO" id="civicoO" size="5" value="<%=toHtml(Obbligato.getCivico())%>"/></td>
</tr>

<tr>
<th>CAP</th>
<td><input type="text" name="capT" id="capT" size="5" value="<%=toHtml(Trasgressore.getCap())%>"/></td>
<td><input type="text" name="capO" id="capO" size="5" value="<%=toHtml(Obbligato.getCap())%>"/></td>
</tr>

<tr>
<th>Comune</th>
<td><input type="text" name="comuneT" id="comuneT" value="<%=toHtml(Trasgressore.getComune())%>"/></td>
<td><input type="text" name="comuneO" id="comuneO" value="<%=toHtml(Obbligato.getComune())%>"/></td>
</tr>

<tr>
<th>Cod Provincia</th>
<td><input type="text" name="provinciaT" id="provinciaT" size="3" maxlength="3" value="<%=toHtml(Trasgressore.getCodProvincia())%>"/></td>
<td><input type="text" name="provinciaO" id="provinciaO" size="3" maxlength="3" value="<%=toHtml(Obbligato.getCodProvincia())%>"/></td>
</tr>

<tr>
<th>Nazione</th>
<td><input type="text" name="nazioneT" id="nazioneT" size="2" maxlength="2" value="<%=toHtml(Trasgressore.getNazione()).toUpperCase()%>"/></td>
<td><input type="text" name="nazioneO" id="nazioneO" size="2" maxlength="2" value="<%=toHtml(Obbligato.getNazione()).toUpperCase()%>"/></td>
</tr>

<tr>
<th>Email</th>
<td><input type="text" name="mailT" id="mailT" size="40" value="<%=toHtml(Trasgressore.getDomicilioDigitale())%>"/></td>
<td><input type="text" name="mailO" id="mailO" size="40" value="<%=toHtml(Obbligato.getDomicilioDigitale())%>"/></td>
</tr>

<tr>
<th>Telefono</th>
<td><input type="text" name="telefonoT" id="telefonoT" size="40" value="<%=toHtml(Trasgressore.getTelefono())%>"/></td>
<td><input type="text" name="telefonoO" id="telefonoO" size="40" value="<%=toHtml(Obbligato.getTelefono())%>"/></td>
</tr>

</table>

<br/><br/>

<table class="details" id = "table_Bottoni" cellpadding="10" cellspacing="10" style="border-collapse: collapse">

<tr><th colspan="3">
<center>
<br/>
<input type="button" style="font-size: 20px;" id="invia" value="SALVA" onClick="checkForm(this.form)"/>
<br/>
</center>
</th></tr>

<tr><th colspan="3">
<center>
<br/>
<input type="button" style="font-size: 20px; background-color: red !important" value="CHIUDI E RICARICA" onClick="window.opener.loadModalWindow(); window.opener.location.reload(false); window.close();"/>
<br/>
</center>
</th></tr>

</table>

<input type="hidden" id="idSanzione" name="idSanzione" value="<%=SanzioneDettaglio.getId()%>"/>
<input type="hidden" id="nomePagatoreDefault" name="nomePagatoreDefault" value="<%=fixString(PagatoreDefault.getRagioneSocialeNominativo())%>"/>

</form>

</center>

<script>
if (document.getElementById("obbligato").value.toUpperCase() == "NESSUNO")
gestisciPagatore(document.getElementById("formSanzione"), document.getElementById("obbligato").value, 'O');
</script>

