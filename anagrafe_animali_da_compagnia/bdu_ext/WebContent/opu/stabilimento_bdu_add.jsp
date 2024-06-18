<%@page import="org.aspcfs.modules.admin.base.User"%>
<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
 <script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/gestoreCodiceFiscale.js"></script>
	
<script>

function clearCordinate(){
	document.forms[0].latitudine.value="";
	document.forms[0].longitudine.value="";
}
function getCoordinate(address,city,prov,cap, fieldLat, fieldLong)
{
	loadModalWindowCustom("Attendere Prego...");
	var addresValue = document.getElementById(address).value;
	var cityValue   = document.getElementById(city).value;
	var provValue 	= document.getElementById(prov).value;
	var capValue 	= document.getElementById(cap).value;
	
	if (document.getElementById(city).value=='')
		{

		    	 alert('Controllare di aver inserito tutti i dati necessari.');
		}
	else
		{
				url = "GetCoordinate.do?command=Search&indirizzo=" + addresValue +"&citta="+cityValue+"&provincia="+provValue+"&cap="+capValue;
		
				var request = $.ajax({
					url : url,
					async: false,
					dataType : "json"
				});
		
				request.done(function(coordinateData) {
					coordinateJson = coordinateData;
					
					if (coordinateJson.status !='KO')
					{
						// latitudine
						$("#"+fieldLat+"").attr("value",coordinateJson.lat);
						document.getElementById(fieldLat).value=coordinateJson.lat;
						
						// longitudine
						$("#"+fieldLong+"").attr("value",coordinateJson.long);
						document.getElementById(fieldLong).value=coordinateJson.long;
						
						console.log(coordinateJson);
					}
					else
						{
							alert('Calcolo Coordinate non riuscito.');
						}
					
		
				});
				request.fail(function(jqXHR, textStatus) {
					console.log('Error');
					
				});
	}
	loadModalWindowUnlock();
			
}


function CalcolaCF() {
	
  		var nomeCalc=""; var cognomeCalc=""; var comuneCalc=""; var nascitaCalc ="";
  		var giorno=""; var mese=""; var anno=""; var sesso="";var comuneResidenza= "" ;
  
  		if ( document.forms[0].sesso[0].checked )
  			sesso = "M";
  		else
  			sesso = "F";
			
  		if ( document.forms[0].nome.value != "" ) {
  			nomeCalc =  document.forms[0].nome.value;
			nomeCalc=nomeCalc.replace(/^\s+|\s+$/g,"").replace(/'/g,"");
  		}
  	
  		if ( document.forms[0].cognome.value  != "" ) {
  			cognomeCalc = document.forms[0].cognome.value;
  			cognomeCalc=cognomeCalc.replace(/^\s+|\s+$/g,"").replace(/'/g,"");
  		}    
  
  		if ( document.forms[0].comuneNascita.value != "" ) {
  			comuneCalc = document.forms[0].comuneNascita.value;
  		}  

  		

  		
  	
  		if ( document.forms[0].dataNascita.value != "" ) {
  			nascitaCalc = document.forms[0].dataNascita.value;
  			giorno = nascitaCalc.substring(0,2);
  			mese = nascitaCalc.substring(3,5);
  			anno = nascitaCalc.substring(6,10);
  		}  
		

  	if (cognomeCalc!="" && nomeCalc!="" && giorno!= "" && mese!="" && anno!= "" && sesso!= "" && comuneCalc!=""){
  	  	codCF= CalcolaCodiceFiscaleCompleto(cognomeCalc, nomeCalc, giorno, mese, anno, sesso, comuneCalc);
  	  	if (codCF=='[Comune non presente in banca dati]')
  	  	  	alert(codCF);
  	  	else
		document.getElementById('codFiscaleSoggetto').value=codCF ;
  		}
  	else
  	  	alert('Inserire tutti i campi necessari per il calcolo del codice fiscale ed il comune di residenza');
  		
  	}
    

  
</script>
 
<script>
function checkLineaProduttiva(){
//	alert('check');
	document.forms[0].doContinueStab.value = 'false';
//	alert(document.forms[0].doContinueLp.value);
	document.forms[0].submit();
}
</script>


<input type="hidden" id ="idRelazione" name="idRelazione" value="<%=id_relazione %>"></input>
<dhv:evaluate if="<%=(id_relazione == LineaProduttiva.idAggregazioneImportatore || id_relazione == LineaProduttiva.idAggregazioneCanile || id_relazione == LineaProduttiva.IdAggregazioneOperatoreCommerciale)%>">
</br>
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Informazioni aggiuntive</dhv:label></strong></th>
	</tr>
	<dhv:evaluate if="<%=(id_relazione == LineaProduttiva.idAggregazioneImportatore || id_relazione == LineaProduttiva.IdAggregazioneOperatoreCommerciale)%>">
		<tr>
			<td class="formLabel" nowrap>AUTORIZZAZIONE</td>
			<td><input class="todisable"  type="text" size="30" maxlength="50" id="autorizzazione"
				name="autorizzazione"
				value=""></td>
		</tr>
		
		<tr>
			<td class="formLabel" nowrap>SUPERFICE DESTINATA AL RICOVERO ANIMALI</td>
			<td><input  type="text" size="30" maxlength="50" id="mqDisponibili"
				name="mqDisponibili"
				value=""></td>
		</tr>
	</dhv:evaluate>
	
	<dhv:evaluate if="<%=(id_relazione == LineaProduttiva.idAggregazioneImportatore)%>">
	<tr>
	
	<td class="formLabel"><dhv:label
				name="">Codice uvac</dhv:label></td>
		<td><input type="text" name="codiceUvac"
			id="codiceUvac" value="" /></td>
	</tr>
	</dhv:evaluate>
<dhv:evaluate if="<%=id_relazione == LineaProduttiva.idAggregazioneCanile %>">

   <tr>
		<td nowrap class="formLabel"><dhv:label name="">CANILE MUNICIPALE </dhv:label>
		</td>
		<td><input type="checkbox" id="municipale"
			name="municipale"
			>


		</td>
	</tr>
	
	
	<tr>
		<td nowrap class="formLabel"><dhv:label name="">CENTRO DI STERILIZZAZIONE </dhv:label>
		</td>
		<td><input type="checkbox"  id="centroSterilizzazione"
			name="centroSterilizzazione">


		</td>
	</tr>
	<tr>	
	<td nowrap class="formLabel"><dhv:label name="">CLINICA / OSPEDALE</dhv:label>
		</td>
		<td><input type="checkbox"  id="flagClinicaOspedale"
			name="flagClinicaOspedale">


		</td>

	</tr>
   <tr>
		<td nowrap class="formLabel"><dhv:label name="">ABUSIVO </dhv:label>
		</td>
		<td><input type="checkbox" id="abusivo"
			name="abusivo"
			>


		</td>
	</tr>
	
		<tr>
			<td class="formLabel" nowrap>SUPERFICE DESTINATA AL RICOVERO ANIMALI</td>
			<td><input  type="text" size="30" maxlength="50" id="mqDisponibili"
				name="mqDisponibili"
				value=""></td>
		</tr>
	
	<tr>
			<td class="formLabel" nowrap>AUTORIZZAZIONE</td>
			<td><input class="todisable"  type="text" size="30" maxlength="50" id="autorizzazione"
				name="autorizzazione"
				value=""></td>
		</tr>
		<tr>
			<td nowrap class="formLabel">DATA AUTORIZZAZIONE</td>
			<td><input class="todisable date_picker" type="text" id="dataAutorizzazione"
				name="dataAutorizzazione" size="10"
				value="" />
			</td>
			<script>
				calenda('dataAutorizzazione','','0');
			</script>
		</tr>
	
</dhv:evaluate>

<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.stabilimento.mail"></dhv:label></td>
		<td><input class="" type="text" size="30" maxlength="50" id="email_lp"
			name="email_lp" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.stabilimento.telefono"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="telefono1_lp"
			name="telefono1_lp" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.stabilimento.telefono2"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="telefono2_lp"
			name="telefono2_lp" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.stabilimento.fax"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="fax_lp"
			name="fax_lp" value=""></td>

	</tr>

</table>
</dhv:evaluate>
</br>
</br>
<%
	String label_stabilimento_sede = "";

	if ((id_relazione > -1)) {
		label_stabilimento_sede = "opu.stabilimento.sede_"
				+ id_relazione;
	} else {
		label_stabilimento_sede = "opu.stabilimento.sede";
	}
%>
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong><dhv:label
			name="<%=label_stabilimento_sede%>"></dhv:label></strong></th>
	</tr>

	<tr>
		<td class="formLabel"><dhv:label name="opu.stabilimento.asl">Asl</dhv:label>
		</td>
		<td><dhv:evaluate if="<%=!(User.getSiteId() > -1)%>">
			<p id="descrizioneasl"><%=newStabilimento.getSedeOperativa().getDescrizioneAsl()%></p>
<%-- 			<input type="hidden" name="idAsl" id="idAsl"
				value="<%=newStabilimento.getSedeOperativa().getIdAsl()%>"> --%>
		</dhv:evaluate> <dhv:evaluate if="<%=(User.getSiteId() > -1)%>">
			<p id="descrizioneasl"><%=AslList.getSelectedValue(User.getSiteId())%></p>
			<input type="hidden" name="idAsl" id="idAsl"
				value="<%=User.getSiteId()%>">
		</dhv:evaluate></td>
	</tr>
	
	<tr>
		<td nowrap class="formLabel">
			
		</td>
		<td>
<%
	if(id_relazione == LineaProduttiva.idAggregazioneCanile)
	{
%>		
		<a style="text-decoration:underline; color:#006b9c;" onmouseover="this.style.textDecoration='none'; this.style.color='black';" onmouseout="this.style.textDecoration='underline'; this.style.color='#006b9c';" onclick="selezionaIndirizzo('106','callbackResidenzaProprietarioInserimentoColonia','','FUORI REGIONE')">Seleziona</a>
		
	
<%		
	}
	else
	{
%>
		<a style="text-decoration:underline; color:#006b9c;" onmouseover="this.style.textDecoration='none'; this.style.color='black';" onmouseout="this.style.textDecoration='underline'; this.style.color='#006b9c';" onclick="selezionaIndirizzo('106','callbackResidenzaProprietarioInserimentoColonia','','<%=(request.getParameter("inregione").equalsIgnoreCase("no"))?("FUORI REGIONE"):("CAMPANIA")%>','<%=(User.getSiteId()>0 && !newStabilimento.isFlagFuoriRegione())?(User.getSiteId()):("-1")%>')">Seleziona</a>
<%
		
	}
	
%>
					</td>
	</tr>
	<tr>
		<td nowrap class="formLabel"><dhv:label
			name="opu.stabilimento.provincia"></dhv:label></td>
		<td><dhv:evaluate
			if="<%=(!(User.getSiteId() > -1) || newStabilimento.isFlagFuoriRegione())%>">
			<input type="text" name="searchcodeIdprovinciaSelect" id="searchcodeIdprovinciaSelect" readonly="readonly">
			<font color="red"> *</font>
			<input type="hidden" name="searchcodeIdprovinciaTesto"
				id="searchcodeIdprovinciaTesto" />
			<input type="hidden" name="searchcodeIdprovincia" id="searchcodeIdprovincia" />
		</dhv:evaluate> <dhv:evaluate
			if="<%=(User.getSiteId() > -1 && !newStabilimento.isFlagFuoriRegione())%>">
			<%=provinciaAsl.getDescrizione()%>
			<input type="hidden" name="searchcodeIdprovinciaAsl" id="searchcodeIdprovinciaAsl" value="<%=provinciaAsl.getCodice()%>" />
			<input type="hidden" name="searchcodeIdprovinciaAslDesc" id="searchcodeIdprovinciaAslDesc" value="<%=provinciaAsl.getDescrizione()%>" />
		</dhv:evaluate></td>
	</tr>
	<tr>
		<td nowrap class="formLabel" name="province" id="province"><dhv:label
			name="opu.stabilimento.comune"></dhv:label></td>
		<td>
		<%
			System.out.println(newStabilimento.getSedeOperativa().getComune());
		%><input type="text" name="searchcodeIdComuneSelect" id="searchcodeIdComuneSelect" readonly="readonly">
		  <font color="red"> *</font> <input
			type="hidden" name="searchcodeIdComuneTesto"
			id="searchcodeIdComuneTesto" />
			<input type="hidden" name="searchcodeIdComune" id="searchcodeIdComune" />
		</td>
	</tr>
	<tr>
		<td nowrap class="formLabel"><dhv:label
			name="opu.stabilimento.indirizzo"></dhv:label></td>
		<td>
			<input type="text" name="via" id="via" readonly="readonly"/>
			<input type="hidden" name="viaTesto" id="viaTesto" /><font color="red"> *</font>
		</td>
	</tr>
	<tr>
		<td nowrap class="formLabel">
			<dhv:label name="opu.stabilimento.cap"></dhv:label>
		</td>
		<td>
			<input type="text" size="28" id="cap" name="cap" maxlength="5" readonly="readonly" value="<%=newStabilimento.getSedeOperativa().getCap()%>"></td>
	</tr>
	<tr>
		<td nowrap class="formLabel"><dhv:label
			name="opu.stabilimento.co"></dhv:label></td>
		<td><input type="text" size="40" name="presso" maxlength="80"
			value="<%=""%>"></td>
	</tr>



<tr class="containerBody">
		<td class="formLabel" nowrap><dhv:label
			name="opu.stabilimento.latitudine"></dhv:label></td>
		<td><input type="text" id="latitudine" name="latitudine" readonly="readonly"
			size="30"
			value=""><font color="red"> *</font>
		</td>
	</tr>
	<tr class="containerBody">
		<td class="formLabel"><dhv:label
			name="opu.stabilimento.longitudine">Longitude</dhv:label></td>
		<td><input type="text" id="longitudine" name="longitudine" readonly="readonly"
			size="30"
			value=""><font color="red"> *</font> &nbsp;&nbsp;&nbsp;
			<input type="button" id="calcola_coord" value="CALCOLA COORDINATE" onclick="if(document.getElementById('via').value != ''){
						var prov2 = 'searchcodeIdprovinciaSelect';
						if(document.getElementById('searchcodeIdprovinciaSelect')==null)
							{
							prov2 = 'searchcodeIdprovinciaAslDesc';
							
							}
						getCoordinate('via','searchcodeIdComuneSelect',prov2,'cap','latitudine','longitudine');
			} else { alert('Attenzione! inserire prima l\'indirizzo');}">
			</td>
	</tr>
	<!-- <tr style="display: block">
		<td colspan="2"><input id="coordbutton" type="button"
			value="Calcola Coordinate"
			onclick="javascript:showCoordinate(document.getElementById('via').value, document.forms['addSede'].comune.value,document.forms['addSede'].provincia.value, document.forms['addSede'].cap.value, document.forms['addSede'].latitudine, document.forms['addSede'].longitudine);" />
		</td>
	</tr> -->	
</table>

</br>
</br>

<dhv:evaluate if="<%=false%>">
	<%
		String label_responsabile = "";
		if ((id_relazione > -1)) {
			label_responsabile = "opu.stabilimento.soggetto_fisico_"
					+ id_relazione;
		} else {
			label_responsabile = "opu.stabilimento.soggetto_fisico_operativo";
		}
	%>

	<table cellpadding="4" cellspacing="0" border="0" width="100%"
		class="details">
		<tr>
			<th colspan="2"><strong><dhv:label
				name="<%=label_responsabile%>"></dhv:label></strong></th>
		</tr>
		<tr>
			<td class="formLabel"><dhv:label
				name="opu.sede_legale.inregione"></dhv:label></td>
			<td><select class="todisable" name="inregioneRappOperativo"
				id="inregioneRappOperativo">
				<option value="si">SI</option>
				<option value="no">NO</option>
			</select></td>
		</tr>
		<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.nome"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="nome"
			name="nome" value=""><font color="red">*</font></td>
	</tr>
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.cognome"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="cognome"
			name="cognome" value=""><font color="red">*</font></td>
	</tr>
	

	<tr id="">
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.sesso"></dhv:label></td>
		<td><input class="todisable" type="radio" name="sesso" id="sesso1" value="M"
			checked="checked">M <input type="radio" name="sesso"
			id="sesso2" value="F">F</td>
	</tr>


	
	<tr>
		<td nowrap class="formLabel"><dhv:label
			name="opu.soggetto_fisico.data_nascita"></dhv:label></td>
		<td><input class="todisable date_picker" type="text" id="dataNascita"
			name="dataNascita" size="10" /></td>
			<script>
				calenda('dataNascita','','-18y');
			</script>
	</tr>
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.comune_nascita"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50"
			id="comuneNascita" name="comuneNascita" value=""> <%@ include file="openListaComuniNascita.jsp"%> </td>
	</tr>
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.provincia_nascita"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50"
			id="provinciaNascita" name="provinciaNascita" value=""></td>
	</tr>
	
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.provincia_residenza"></dhv:label></td>
			
				<td><select class="todisable" name="addressLegaleCountry" id="addressLegaleCountry">
			<option value="-1">Inserire le prime 4 lettere</option>
			
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparirà in automatico la lista delle province che iniziano con le lettere digitate)
		<font color="red">(*)</font> <%-- ComuniList.getHtmlSelect("searchcodeIdComune", -1) --%>
		<input type="hidden" name="addressLegaleCountryTesto"
			id="addressLegaleCountryTesto" /> <!--      <input type="text" size="30" maxlength="50" id = "" name="addressLegaleCountry" value="">-->
		</td>
	</tr>
	
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.comune_residenza"></dhv:label></td>
		<td><select class="todisable" name="addressLegaleCity" id="addressLegaleCity">
			<option value="-1">Inserire le prime 4 lettere</option>
			
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparirà in automatico la lista dei comuni che iniziano con le lettere digitate)
		<font color="red">(*)</font> <%-- ComuniList.getHtmlSelect("searchcodeIdComune", -1) --%>
		<input type="hidden" name="addressLegaleCityTesto"
			id="addressLegaleCityTesto" /> <!--      <input type="text" size="30" maxlength="50" id = "" name="addressLegaleCountry" value="">-->
		</td>
	</tr>


	
		
	
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.indirizzo"></dhv:label></td>
		<td><select class="todisable" name="addressLegaleLine1" id="addressLegaleLine1">
			<option value="-1" selected="selected">Inserire le prime 4 lettere</option>
			
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparirà in automatico la lista degli indirizzi che iniziano con le lettere digitate)
		<font color="red">(*)</font> <input type="hidden"
			name="addressLegaleLine1Testo" id="addressLegaleLine1Testo" /> <!--      <input type="text" size="30" maxlength="50" id = "addressLegaleLine1" name="addressLegaleLine1" value="">-->
		</td>
	</tr>

	
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.cf"></dhv:label></td>
		<td>
		<input readonly="readonly" type="text" name="codFiscaleSoggetto"
			id="codFiscaleSoggetto" />  <font color="red">(*)</font>
			<!-- %if(newStabilimento.isFlagFuoriRegione()){ %-->
			<input type = "checkbox" name = "estero" id = "estero"  onclick="if(this.checked){document.getElementById('calcoloCF').style.visibility='hidden';document.getElementById('codFiscaleSoggetto').readOnly=false;} else {document.getElementById('calcoloCF').style.visibility='visible';document.getElementById('codFiscaleSoggetto').readOnly=true;document.getElementById('codFiscaleSoggetto').value='';}" >Provenienza Estera
			<!-- %} %-->
			<input type="button" id = "calcoloCF" value="Calcola Codice Fiscale" onclick="javascript:CalcolaCF()"></input></td>
	</tr>
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.didentita"></dhv:label></td>
		<td>
		 <input class="todisable" type="text" name="documentoIdentita"
			id="documentoIdentita" value=""/> </td>
	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.mail"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="email"
			name="email" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.telefono"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="telefono1"
			name="telefono1" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.telefono2"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="telefono2"
			name="telefono2" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.fax"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="fax"
			name="fax" value=""></td>

	</tr>

	</table>
</div>
</dhv:evaluate>

<dhv:evaluate if="<%=(id_relazione == LineaProduttiva.idAggregazioneColonia)%>">
	<table cellpadding="4" cellspacing="0" border="0" width="100%"
		class="details">
		<tr>
			<th colspan="2"><strong><dhv:label name="">Informazioni colonia</dhv:label></strong>

			</th>
		</tr>
		<tr>
			<td class="formLabel" nowrap><dhv:label name="">Numero protocollo</dhv:label>
			</td>
			<td><input type="text" name="nrProtocollo" id="nrProtocollo"
				value="" /> <font color="red"> (*)</font>
			</td>
		</tr>

		<tr>
			<td class="formLabel" nowrap="nowrap">Data registrazione della
			colonia</td>
			<td><input class="date_picker" type="text" name="dataRegistrazioneColonia"
				size="10" value="" nomecampo="registrazione" id="dataRegistrazioneColonia"
				tipocontrollo="T2,T6,T7" labelcampo="Data Registrazione" />&nbsp;</td>
				<script>
					calenda('dataRegistrazioneColonia','','0');
				</script>
		</tr>
		<tr>
			<td class="formLabel" nowrap><dhv:label name="">Numero totale gatti</dhv:label>
			</td>
			<td><input type="text" name="nrGattiTotale" id="nrGattiTotale"
				value="" /> <font color="red">(*)</font> &nbsp; <input type="checkbox" name="totalePresunto"
				id="totalePresunto" />&nbsp; Tot. Presunto <!-- Aggiungere data del censimento dei gatti -->
			</td>
		</tr>
		
		<tr>
			<td class="formLabel" nowrap="nowrap">Data del censimento</td>
			<td><input class="date_picker" type="text" name="dataCensimentoTotale"
				size="10" value="" nomecampo="censimento" id="dataCensimentoTotale"
				tipocontrollo="T2,T6,T7" labelcampo="Data Censimento" />&nbsp;</td>
				<script>
					calenda('dataCensimentoTotale','','0');
				</script>
		</tr>

		<tr>
			<td class="formLabel" nowrap><dhv:label name="">Numero totale femmine</dhv:label>
			</td>
			<td><input type="text" name="nrGattiFTotale" id="nrGattiFTotale"
				value="" /> <input type="checkbox" name="totaleFPresunto"
				id="totaleFPresunto" />&nbsp; Tot. Presunto</td>
		</tr>

		<tr>
			<td class="formLabel" nowrap><dhv:label name="">Numero totale maschi</dhv:label>
			</td>
			<td><input type="text" name="nrGattiMTotale" id="nrGattiMTotale"
				value="" /> <input type="checkbox" name="totaleMPresunto"
				id="totaleMPresunto" />&nbsp; Tot. Presunto</td>
		</tr>


		<tr>
			<td class="formLabel" nowrap><dhv:label name="">Nominativo veterinario</dhv:label></td>
			<td><input type="text" size="30" maxlength="50"
				id="nomeVeterinario" name="nomeVeterinario" value=""></td>
		</tr>

	</table>

	</br>
	</br>
</dhv:evaluate>