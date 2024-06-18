<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page import="java.io.*,java.util.*,org.aspcfs.utils.web.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.registrazioniAnimali.base.*"%>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" /> 
<jsp:useBean id="causeDecessoList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="neoplasieList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="diagnosiCitologiche" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="diagnosiIstologicheTumorali" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipoDiagnosiIstologiche" class="org.aspcfs.utils.web.LookupList" scope="request" />

	
<meta charset="utf-8" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<!-- <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<script language="javascript" SRC="javascript/jquery-ui.js"></script>
<script language="javascript" SRC="javascript/CalendarPopup2.js"></script>
<!--
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/dateControl.js"></script>
<script language="javascript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
</SCRIPT>
-->

<script type="text/javascript" src="dwr/interface/DwrUtil.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/Animale.js"> </script>

<script type="text/javascript">

$( document ).ready( function(){
	calenda('dataDecesso','','0');
	calenda('dataEsitoIstologico','','0');
});

function verificaMicrochip(microchip)
{
	var formTest = true;
	var message = "";

	dwr.util.useLoadingImage('images_bdu/ajax-loader.gif');
	if(!( (microchip.value.length == 15) && ( /^([0-9]+)$/.test( microchip.value )) ) )
    {
    	message += label("", "- La lunghezza del microchip deve essere di 15 caratteri numerici\r\n");
    	document.getElementById('microchip').value='';
       	formTest = false;
    }
	
	var ok = false;
	if (formTest)
	{
		Animale.verificaMc(microchip.value, {
		callback:function(data) 
		{
			if (data.idEsito == '-1')
			{
				$(microchip).focus();
				document.getElementById('microchip').value='';
				document.getElementById('sesso').innerHTML='';
				document.getElementById('specie').innerHTML='';
				document.getElementById('razza').innerHTML='';
				document.getElementById('idAnimale').value='';
				document.getElementById('datanascita').innerHTML='';
				document.getElementById('mantello').innerHTML='';
				document.getElementById('taglia').innerHTML='';
				document.getElementById('sterilizzato').innerHTML='';
				document.getElementById('indirizzo').innerHTML='';
				alert(data.descrizione);
				return false;
			}
			else
			{
				document.getElementById('sesso').innerHTML=data.sesso;
				document.getElementById('specie').innerHTML=data.specie;
				document.getElementById('razza').innerHTML=data.razza;
				document.getElementById('idAnimale').value=data.idAnimale;
				document.getElementById('datanascita').innerHTML=data.datanascita;
				document.getElementById('mantello').innerHTML=data.mantello;
				document.getElementById('taglia').innerHTML=data.taglia;
				document.getElementById('sterilizzato').innerHTML=data.sterilizzato;
				document.getElementById('indirizzo').innerHTML=data.indirizzo;
				return true;
			}
		},
		timeout:8000,
		async:false

		});
	}
	else
	{
		 alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
	     return false;
	}
}


function attivaDiagnosiIstologicaTumorale()
{
	if(document.getElementById('idTipoDiagnosiIstologica').value=='1')
	{
		document.getElementById('diagnosiIstologicaTd2').style.display="block";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('noteDiagnosiIstologicaTumorali').value="";
	}
	else if(document.getElementById('idTipoDiagnosiIstologica').value=='2')
	{
		document.getElementById('diagnosiIstologicaTd2').style.display="none";
		document.getElementById('idDiagnosiIstologicaTumorali').value="-1";
		document.getElementById('idDiagnosiIstologicaTumorali2livello').value="-1";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('noteDiagnosiIstologicaTumorali').value="";
	}
	else if(document.getElementById('idTipoDiagnosiIstologica').value=='3')
	{
		document.getElementById('diagnosiIstologicaTd2').style.display="none";
		document.getElementById('idDiagnosiIstologicaTumorali').value="-1";
		document.getElementById('idDiagnosiIstologicaTumorali2livello').value="-1";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="block";
	}
	else
	{
		document.getElementById('diagnosiIstologicaTd2').style.display="none";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('idTipoDiagnosiIstologica').value="-1";
		document.getElementById('noteDiagnosiIstologicaTumorali').value="";
	}
}

function attivaDiagnosiCitologicaIstologica()
{
	//Citologica
	if(document.getElementById('idNeoplasia').value==11)
	{
		document.getElementById('idDiagnosiCitologica').style.display="block";
	}
	
	//Istologica
	if(document.getElementById('idNeoplasia').value==13)
	{
		var idSelezionato = '-1';
		if(document.getElementById('tipoDiagnosiIstologicaTd2').style.display=="block"  /*document.getElementById('idTipoDiagnosiIstologica')!=null*/ && document.getElementById('idTipoDiagnosiIstologica').value!='-1')
			idSelezionato = document.getElementById('idTipoDiagnosiIstologica').value;
		
		var idSelezionato2 = "";
		if(document.getElementById('dataEsitoIstologicaTd2').style.display=="block"/*  document.getElementById('dataEsitoIstologico')!=null*/ && document.getElementById('dataEsitoIstologico').value!='')
			idSelezionato2 = document.getElementById('dataEsitoIstologico').value;
		
		var idSelezionato3 = "";
		if(document.getElementById('descMorfologicaIstologicaTd2').style.display=="block" /*document.getElementById('descMorfologicaIstologico')!=null*/ && document.getElementById('descMorfologicaIstologico').innerHTML!='')
			idSelezionato3 = document.getElementById('descMorfologicaIstologico').value;
		
		var idSelezionato4 = '-1';
		if(document.getElementById('diagnosiIstologicaTd2').style.display=="block" /*  document.getElementById('idDiagnosiIstologicaTumorali')!=null*/ && document.getElementById('idDiagnosiIstologicaTumorali').value!='-1')
			idSelezionato4 = document.getElementById('idDiagnosiIstologicaTumorali').value;
		
		document.getElementById('diagnosiIstologicaTd2').innerHTML='';
		document.getElementById('dataEsitoIstologicaTd2').innerHTML='';
		document.getElementById('descMorfologicaIstologicaTd2').innerHTML='';
		
		
		transport_select2=document.getElementById('idTipoDiagnosiIstologica');
		transport_select2.onchange = function(){attivaDiagnosiCitologicaIstologica();};
		
		
		if(idSelezionato!='-1')
			document.getElementById('idTipoDiagnosiIstologica').value = idSelezionato;
		if(idSelezionato2!='')
			document.getElementById('dataEsitoIstologico').value = idSelezionato2;
		if(idSelezionato3!='')
			document.getElementById('descMorfologicaIstologico').innerHTML=idSelezionato3;
		if(idSelezionato4!='-1')
			document.getElementById('idDiagnosiIstologicaTumorali').value=idSelezionato4;
		
		
		if(document.getElementById('idTipoDiagnosiIstologica')!=null && document.getElementById('idTipoDiagnosiIstologica').value=='1')
		{
		     "<font color=\"red\">*</font>" + "<br/>" +
			"<font color=\"red\">*</font>" + "<br/>";

			transport_select2=document.getElementById('idTipoDiagnosiIstologica');
			transport_select2.onchange = function(){attivaDiagnosiCitologicaIstologica();};


			transport_select3=document.getElementById('idDiagnosiIstologicaTumorali');
			transport_select3.onchange = function(){attivaDiagnosiCitologicaIstologica();};
			
			if(idSelezionato!='-1')
				document.getElementById('idTipoDiagnosiIstologica').value = idSelezionato;
			if(idSelezionato4!='-1')
				document.getElementById('idTipoDiagnosiIstologicaTumorale').value=idSelezionato4;
			
			if(document.getElementById('idDiagnosiIstologicaTumorali')!=null && document.getElementById('idDiagnosiIstologicaTumorali').value!='-1')
			{
				var idPadre = document.getElementById('idDiagnosiIstologicaTumorali').value;
				alert(idPadre);
				
				Animale.getListaDiagnosiIstologiche(idPadre, {
					callback:function(data) 
					{
						

						

						transport_select2=document.getElementById('idTipoDiagnosiIstologica');
						transport_select2.onchange = function(){attivaDiagnosiCitologicaIstologica();};


						transport_select3=document.getElementById('idDiagnosiIstologicaTumorali');
						transport_select3.onchange = function(){attivaDiagnosiCitologicaIstologica();};
						
						if(idSelezionato!='-1')
							document.getElementById('idTipoDiagnosiIstologica').value = idSelezionato;
						if(idSelezionato4!='-1')
							document.getElementById('idTipoDiagnosiIstologicaTumorale').value=idSelezionato4;
						
						
						
					},
					timeout:8000,
					async:false
					});
				
			}
		}
		else if(document.getElementById('tipoDiagnosiIstologicaTd2').style.display=="block" /*document.getElementById('idTipoDiagnosiIstologica')!=null*/ && document.getElementById('idTipoDiagnosiIstologica').value=='2')
		{
			
			
		}
		else if(document.getElementById('tipoDiagnosiIstologicaTd2').style.display=="block" /*document.getElementById('idTipoDiagnosiIstologica')!=null*/ && document.getElementById('idTipoDiagnosiIstologica').value=='3')
		{
		}
			
		
	}
	 
}



function attivaTipoDiagnosiIstologica()
{
	//Citologica
	if(document.getElementById('idNeoplasia').value==11)
	{
		document.getElementById('diagnosiCitologicaTd2').style.display="block";
		document.getElementById('tipoDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('idTipoDiagnosiIstologica').value="-1";
		document.getElementById('diagnosiIstologicaTd2').style.display="none";
		document.getElementById('idDiagnosiIstologicaTumorali').value="-1";
		document.getElementById('idDiagnosiIstologicaTumorali2livello').value="-1";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('noteDiagnosiIstologicaTumorali').value="";
		document.getElementById('dataEsitoIstologicaTd2').style.display="none";
		document.getElementById('dataEsitoIstologico').value="";
		document.getElementById('descMorfologicaIstologicaTd2').style.display="none";
		document.getElementById('descMorfologicaIstologico').value="";
	}
	
	//Istologica
	else if(document.getElementById('idNeoplasia').value==13)
	{
		document.getElementById('tipoDiagnosiIstologicaTd2').style.display="block";
		document.getElementById('diagnosiIstologicaTd2').style.display="none";
		document.getElementById('idDiagnosiIstologicaTumorali').value="-1";
		document.getElementById('idDiagnosiIstologicaTumorali2livello').value="-1";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('noteDiagnosiIstologicaTumorali').value="";
		document.getElementById('dataEsitoIstologicaTd2').style.display="block";
		document.getElementById('descMorfologicaIstologicaTd2').style.display="block";
		document.getElementById('diagnosiCitologicaTd2').style.display="none";
		document.getElementById('idDiagnosiCitologica').value="-1";
		
	}
	else
	{
		document.getElementById('tipoDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('idTipoDiagnosiIstologica').value="-1";
		document.getElementById('diagnosiIstologicaTd2').style.display="none";
		document.getElementById('idDiagnosiIstologicaTumorali').value="-1";
		document.getElementById('idDiagnosiIstologicaTumorali2livello').value="-1";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('noteDiagnosiIstologicaTumorali').value="";
		document.getElementById('dataEsitoIstologicaTd2').style.display="none";
		document.getElementById('dataEsitoIstologico').value="";
		document.getElementById('descMorfologicaIstologicaTd2').style.display="none";
		document.getElementById('descMorfologicaIstologico').value="";
		document.getElementById('diagnosiCitologicaTd2').style.display="none";
		document.getElementById('idDiagnosiCitologica').value="-1";
	}
	
}



function attivaDiagnosiDiNeoplasia()
{
	if(document.getElementById('idCausaDecesso').value==172)
	{
		document.getElementById('diagnosiDiNeoplasiaTd2').style.display="block";
		document.getElementById('tipoDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('idTipoDiagnosiIstologica').value="-1";
		document.getElementById('diagnosiIstologicaTd2').style.display="none";
		document.getElementById('idDiagnosiIstologicaTumorali').value="-1";
		document.getElementById('idDiagnosiIstologicaTumorali2livello').value="-1";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('noteDiagnosiIstologicaTumorali').value="";
		document.getElementById('dataEsitoIstologicaTd2').style.display="none";
		document.getElementById('dataEsitoIstologico').value="";
		document.getElementById('descMorfologicaIstologicaTd2').style.display="none";
		document.getElementById('descMorfologicaIstologico').value="";
		document.getElementById('diagnosiCitologicaTd2').style.display="none";
		document.getElementById('idDiagnosiCitologica').value="-1";
	}
	else
	{
		document.getElementById('diagnosiDiNeoplasiaTd2').style.display="none";
		document.getElementById('idNeoplasia').value="-1";
		document.getElementById('tipoDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('idTipoDiagnosiIstologica').value="-1";
		document.getElementById('diagnosiIstologicaTd2').style.display="none";
		document.getElementById('idDiagnosiIstologicaTumorali').value="-1";
		document.getElementById('idDiagnosiIstologicaTumorali2livello').value="-1";
		document.getElementById('noteDiagnosiIstologicaTd2').style.display="none";
		document.getElementById('noteDiagnosiIstologicaTumorali').value="";
		document.getElementById('dataEsitoIstologicaTd2').style.display="none";
		document.getElementById('dataEsitoIstologico').value="";
		document.getElementById('descMorfologicaIstologicaTd2').style.display="none";
		document.getElementById('descMorfologicaIstologico').value="";
		document.getElementById('diagnosiCitologicaTd2').style.display="none";
		document.getElementById('idDiagnosiCitologica').value="-1";
	}
	
	if( document.getElementById('idCausaDecesso').value== 194 || document.getElementById('idCausaDecesso').value== 195 || document.getElementById('idCausaDecesso').value== 16 || document.getElementById('idCausaDecesso').value== 39 || document.getElementById('idCausaDecesso').value== 59 || document.getElementById('idCausaDecesso').value== 82 || document.getElementById('idCausaDecesso').value== 108  || document.getElementById('idCausaDecesso').value== 123  || document.getElementById('idCausaDecesso').value== 143
        || document.getElementById('idCausaDecesso').value== 158 || document.getElementById('idCausaDecesso').value== 170)
	{
		document.getElementById('noteCausaDecesso').style.display="block";
	}
	else
	{
		document.getElementById('noteCausaDecesso').style.display="none";
		document.getElementById('noteCausaDecesso').value="";
	}
	 
}


function attivaDiagnosiIstologicaTumorale2Livello()
{
	var idPadre = document.getElementById('idDiagnosiIstologicaTumorali').value;
	
	
	Animale.getListaDiagnosiIstologiche(idPadre, {
		callback:function(data) 
		{
			document.getElementById('idDiagnosiIstologicaTumorali2livello').innerHTML=data;
		
		},
		timeout:8000,
		async:false
		});
}



function checkForm(form)
{

	 formTest = true;
	 message = "";
	
	 if(microchip.value=='')
	 {
		
		message += "- Microchip richiesto\n";
	 	formTest =  false;
	 }
	 
	if (microchip.value!='')
	{
				
	Animale.verificaMc(microchip.value, {
		callback:function(data) {
		if (data.idEsito == '-1')
		{
			$(microchip).focus();
			$(microchip).css('background-color', 'red');
			message = data.descrizione;
			formTest =  false;
		}
		else
		{
			$(microchip).css('background-color', 'white');
			formTest =  true;
		}
		},
		timeout:8000,
		async:false

		});
	}
	
	
	

	if(document.getElementById('dataDecesso').value=='')
	{
		
		message += "- Data decesso richiesta\n";
		formTest =  false;
	}
	
	if(document.getElementById('idCausaDecesso').disabled==false && document.getElementById('idCausaDecesso').value==-1)
	{
		
		message += "- Campo 'Causa decesso' richiesto\n";
		formTest =  false;
	}
	
	if(document.getElementById('diagnosiDiNeoplasiaTd2').style.display=="block"/*document.getElementById('idNeoplasia').disabled==false */ && document.getElementById('idNeoplasia').value==-1)
	{
		
		message += "- Campo 'Diagnosi di Neoplasia' richiesto\n";
		formTest =  false;
	}
	
	if(document.getElementById('diagnosiCitologicaTd2').style.display=="block" /*document.getElementById('idDiagnosiCitologica').disabled==false*/ && document.getElementById('idDiagnosiCitologica').value==-1)
	{
		
		message += "- Campo 'Diagnosi citologica' richiesto\n";
		formTest =  false;
	}
	
	if(document.getElementById('diagnosiDiNeoplasiaTd2').style.display=="block"/*document.getElementById('idNeoplasia').disabled==false*/ && document.getElementById('idNeoplasia').value==13 && document.getElementById('dataEsitoIstologico').value=='')
	{
		
		message += "- Campo 'Data esito istologico' richiesto\n";
		formTest =  false;
	}
	
	
	if(document.getElementById('diagnosiDiNeoplasiaTd2').style.display=="block" && document.getElementById('idNeoplasia').value==13 && document.getElementById('idTipoDiagnosiIstologica').value=='-1')
	{
		
		message += "- Campo 'Tipo Diagnosi istologico' richiesto\n";
		formTest =  false;
	}
	
	
	if(document.getElementById('diagnosiDiNeoplasiaTd2').style.display=="block" && document.getElementById('idNeoplasia').value==13  && document.getElementById('idTipoDiagnosiIstologica').value=='1' && (document.getElementById('idDiagnosiIstologicaTumorali').value=='-1' || document.getElementById('idDiagnosiIstologicaTumorali2livello').value=='-1'))
	{
		
		message += "- Campo 'Diagnosi istologica' richiesto\n";
		formTest =  false;
	}
	
	if(document.getElementById('diagnosiDiNeoplasiaTd2').style.display=="block" && document.getElementById('idNeoplasia').value==13  && document.getElementById('idTipoDiagnosiIstologica').value=='3' && (document.getElementById('noteDiagnosiIstologicaTumorali').value==null || document.getElementById('noteDiagnosiIstologicaTumorali').value=='') )
	{
		
		message += "- Campo 'Note Diagnosi istologica' richiesto\n";
		formTest =  false;
	}
	

    if (formTest == false) 
    {
  	  alert(label("check.form", "Non puoi proseguire:\r\n\r\n") + message);
      return false;
    }
    else
    {
	   return true;
    }
}



dwr.util.useLoadingImage = function useLoadingImage(imageSrc) {
	//alert(imageSrc);
	  var loadingImage;
	  if (imageSrc) loadingImage = imageSrc;
	  else loadingImage = "images/c9_ajax-loader.gif";
	  dwr.engine.setPreHook(function() {
	    var disabledImageZone = dwr.util.byId('disabledImageZone');
	  //  alert(disabledImageZone);
	    if (!disabledImageZone) {
		//    alert('not');
	      disabledImageZone = document.createElement('div');
	      disabledImageZone.setAttribute('id', 'disabledImageZone');
	      disabledImageZone.style.position = "absolute";
	      disabledImageZone.style.zIndex = "1000";
	      disabledImageZone.style.left = "0px";
	      disabledImageZone.style.top = "0px";
	      disabledImageZone.style.width = "100%";
	      disabledImageZone.style.height = "100%";
	      var imageZone = document.createElement('img');
	      imageZone.setAttribute('id','imageZone');
	      imageZone.setAttribute('src','c9_ajax-loader.gif');
	      imageZone.src='c9_ajax-loader.gif';
	      imageZone.style.position = "absolute";
	      imageZone.style.top = "0px";
	      imageZone.style.right = "0px";
	      disabledImageZone.appendChild(imageZone);
	      document.body.appendChild(disabledImageZone);
	    }
	    else {
	     $('#imageZone').attr('src',imageSrc);	    
	      disabledImageZone.style.visibility = 'visible';

	    }
	  });
	  dwr.engine.setPostHook(function() {
		  disabledImageZone.style.visibility = 'hidden';
	  });
	}
	
</script>


<%@ include file="../initPage.jsp"%>
<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td width="100%"><a href="ProfilassiRabbia.do"><dhv:label
				name="">Scheda decesso</dhv:label></a> > <dhv:label name="">Inserisci</dhv:label>
				
			</td>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>
<body>

<font color="red">ATTENZIONE!!! I dati inseriti in questo modulo hanno lo scopo di inviare una notiifca all'ASL. <br/>
NON sar&agrave; inserita nessuna registrazione di decesso e non sar&agrave; fatta alcuna variazione allo stato dell'animale fintanto che l'ASL non provveder&agrave; ad inserire la registrazione</font>

<form name="add" id="idForm" action="SchedaDecesso.do?command=Insert&auto-populate=true" method="post"></br>

<input type="hidden" name="idAnimale" id="idAnimale">

<span id="datireg" class="datireg">
<table cellpadding="2" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Anagrafica animale</dhv:label></strong>
		</th>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Microchip</dhv:label></td>
		<td><input type="text" name="microchip" id="microchip" value="" maxlength="15"  onchange="javascript:verificaMicrochip(this);" />
			&nbsp;<font color="red">*</font><div id="disabledImageZone" style="visibility: hidden; color: red;">Verifica microchip in corso <br><img id="imageZone" src="" name="imageZone" /></div>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Specie</dhv:label></td>
		<td id="specie">
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Razza</dhv:label></td>
		<td id="razza">
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Data nascita</dhv:label></td>
		<td id="datanascita">
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Sesso</dhv:label></td>
		<td id="sesso">
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Mantello</dhv:label></td>
		<td id="mantello">
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Taglia</dhv:label></td>
		<td id="taglia">
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Sterilizzato</dhv:label></td>
		<td id="sterilizzato">
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Indirizzo</dhv:label></td>
		<td id="indirizzo">
		</td>
	</tr>
	</table>
<br/>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Informazioni sul decesso</dhv:label></strong>
		</th>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Data decesso</dhv:label></td>
		<td>
			<input class="date_picker" type="text" name="dataDecesso" id="dataDecesso" size="10" value="" nomecampo="dataDecesso" tipocontrollo="T2,T11" labelcampo="Data Decesso" />&nbsp; 
			  <font color="red">*</font>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Causa decesso</dhv:label></td>
		<td>
			<%=causeDecessoList.getHtmlSelect("idCausaDecesso", -1)%> <font color="red">*</font>
			<input style="display: none;" type="text" name="noteCausaDecesso" id="noteCausaDecesso" value=""/> 
		</td>
	</tr>
	
	
	
	<tr id="diagnosiDiNeoplasiaTr">
		<td id="diagnosiDiNeoplasiaTd1" class="formLabel"><dhv:label name="">Diagnosi di neoplasia</dhv:label></td>
		<td id="diagnosiDiNeoplasiaTd2" style="display:none" ><%=neoplasieList.getHtmlSelect("idNeoplasia", -1) %> <font id="idNeoplasiaRed" color="red"> *</font> <input type="text" name="noteNeoplasia" id="noteNeoplasia" value=""/>
		</td>
	</tr>
	
	<tr>
		<th colspan="2"><strong><dhv:label name="">Diagnosi citologica</dhv:label></strong>
		</th>
	</tr>
	
	<tr id="diagnosiCitologicaTr"  >
		<td id="diagnosiCitologicaTd1"   class="formLabel"><dhv:label name="">Diagnosi citologica</dhv:label></td>
		<td id="diagnosiCitologicaTd2" style="display:none;" ><%=diagnosiCitologiche.getHtmlSelect("idDiagnosiCitologica", -1) %> <font color="red"> *</font>	</td>
	</tr>
	
	<tr>
		<th colspan="2"><strong><dhv:label name="">Diagnosi istologica</dhv:label></strong>
		</th>
	</tr>
	
	<tr id="dataEsitoIstologicaTr"  >
		<td id="dataEsitoIstologicaTd1"   class="formLabel"><dhv:label name="">Data esito</dhv:label></td>
		<td id="dataEsitoIstologicaTd2"  style="display:none;"  ><input class="date_picker" type="text" name="dataEsitoIstologico" id="dataEsitoIstologico" size="10" value="" nomecampo="dataEsitoIstologico" tipocontrollo="T2,T11" labelcampo="Data Esito" /><font color="red"> *</font>
		</td>
	</tr>
	
	<tr id="descMorfologicaIstologicaTr"  >
		<td id="descMorfologicaIstologicaTd1"   class="formLabel"><dhv:label name="">Descrizione morfologica</dhv:label></td>
		<td id="descMorfologicaIstologicaTd2"   style="display:none;"><textarea style="width:450px; height: 50px;" name="descMorfologicaIstologico" id="descMorfologicaIstologico" value="" nomecampo="descMorfologicaIstologico" ></textarea> 
		</td>
	</tr>
	
	<tr id="tipoDiagnosiIstologicaTr"  >
		<td id="tipoDiagnosiIstologicaTd1"   class="formLabel"><dhv:label name="">Tipo Diagnosi</dhv:label></td>
		<td id="tipoDiagnosiIstologicaTd2"  style="display:none;"  ><%=tipoDiagnosiIstologiche.getHtmlSelect("idTipoDiagnosiIstologica", -1) %> <font color="red"> * </font>
		</td>
	</tr>
	
	
	<tr id="diagnosiIstologicaTr"  >
		<td id="diagnosiIstologicaTd1"   class="formLabel"><dhv:label name="">Diagnosi</dhv:label></td>
		<td id="diagnosiIstologicaTd2"  style="display:none;"  ><%=diagnosiIstologicheTumorali.getHtmlSelect("idDiagnosiIstologicaTumorali", -1) %>	 <font color="red"> *</font> <br/>
																<select name="idDiagnosiIstologicaTumorali2livello" id="idDiagnosiIstologicaTumorali2livello"></select> <font color="red"> *</font>	</td>
	</tr>
	
	<tr id="noteDiagnosiIstologicaTr"  >
		<td id="noteDiagnosiIstologicaTd1"   class="formLabel"><dhv:label name="">Note Diagnosi</dhv:label></td>
		<td id="noteDiagnosiIstologicaTd2"  style="display:none;"  ><textarea style="width:450px; height: 50px;" id="noteDiagnosiIstologicaTumorali" name="noteDiagnosiIstologicaTumorali" ></textarea> <font color="red"> *</font>
		</td>
	</tr>
	
	
	
							
</table>


<br/>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
			<tr>
				<th colspan="2"><strong>Medico veterinario</strong>
				</th>
			</tr>
			<tr class="containerBody">
				<td nowrap class="formLabel">Nome e cognome</td>
				<td><%=User.getContact().getNameFull()%>&nbsp;</td>
			</tr>
			<tr class="containerBody">
				<td nowrap class="formLabel">Codice fiscale</td>
				<td><%=User.getContact().getCodiceFiscale()%>&nbsp;</td>
			</tr>
		</table>
</span> <br/> <br/>

<input type="button" onclick="if(checkForm(document.getElementById('idForm'))){document.getElementById('idForm').submit();}" value="Inserisci" id="invia" />
</form>

<script type="text/javascript">
	//document.getElementById('idTipoDiagnosiIstologica').disabled="disabled";
	//document.getElementById('idDiagnosiIstologicaTumorali').disabled="disabled";
	//document.getElementById('dataEsitoIstologico').disabled="disabled";
	//document.getElementById('descMorfologicaIstologico').disabled="disabled";
	//document.getElementById('idDiagnosiCitologica').disabled="disabled";
	//document.getElementById('idNeoplasia').disabled="disabled";
	//document.getElementById('noteNeoplasia').disabled="disabled";
	
</script>