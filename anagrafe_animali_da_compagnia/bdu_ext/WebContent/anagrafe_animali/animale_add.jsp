<%@page import="java.util.Date"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page import="java.io.*,java.util.*,org.aspcfs.utils.web.*"%>
<%@page import="org.aspcfs.modules.anagrafe_animali.base.Animale"%>
<%@page import="org.aspcfs.modules.system.base.SiteList"%>
<%@page import="org.aspcfs.modules.opu.base.StabilimentoList"%>
<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
<%@page import="org.aspcfs.modules.system.base.SiteList"%>
<%@page import="org.aspcfs.modules.base.Constants"%>
<%@page import="org.aspcfs.utils.ApplicationProperties"%>

<%
	String currentDate = "";
	if(request.getAttribute("currentDate")!=null)
		currentDate = (String)request.getAttribute("currentDate");
%>


<link rel="stylesheet"	href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<!-- <script src="https://code.jquery.com/jquery-1.8.2.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.9.1/jquery-ui.js"></script> -->

<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<jsp:useBean id="Cane"	class="org.aspcfs.modules.anagrafe_animali.base.Cane" scope="request" />
<jsp:useBean id="Gatto" class="org.aspcfs.modules.anagrafe_animali.base.Gatto" scope="request" />
<jsp:useBean id="Furetto" class="org.aspcfs.modules.anagrafe_animali.base.Furetto"	scope="request" />
<jsp:useBean id="origine" class="java.lang.String" scope="request"/>
<jsp:useBean id="opId" class="java.lang.String" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="specieList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="razzaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tagliaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="mantelloList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="esitoList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="comuniList_asl" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="nazioniList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="comuniList_all" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="provinceList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="veterinariList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="veterinariPrivatiList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/Animale.js"> </script>

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/gestoreCodiceFiscale.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/dateControl.js"></script>
<script type="text/javascript" src="dwr/interface/DwrUtil.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/PraticaList.js"> </script>
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/LineaProduttiva.js"> </script>
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/EventoRilascioPassaporto.js"> </script>
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/Stabilimento.js"> </script>
<script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script>

<style>
.ui-combobox {
	position: relative;
	display: inline-block;
}

.ui-combobox-toggle {
	position: absolute;
	top: 0;
	bottom: 0;
	margin-left: -1px;
	padding: 0;
	/* adjust styles for IE 6/7 */ *
	height: 1.7em; *
	top: 0.1em;
}

.ui-combobox-input {
	margin: 0;
	padding: 0.3em;
}
</style>


<script>
var verificaMc=true;
function nascondiVetChippatore(campo,campoVetChip)
{
	if(campo.checked)
	{
		campoVetChip.value="-1";
		document.getElementById('trVeterinarioChippatura').innerHTML="";
	}
	else
	{
		document.getElementById('trVeterinarioChippatura').innerHTML=innerHTMLtrVeterinarioChippatura;
		document.getElementById('dialogAggiuntaVetChippatore').style.display='none';
		initDiv();
	}
}


function pulisciCampo(input){
  //Inserire le prime 4 lettere
  if(input.value=='Inserire le prime 4 lettere'){
    input.value='';
  }
}

function ripristinaCampo(input){
  if(input.value==''){
    input.value='Inserire le prime 4 lettere';
  }
}

var arrayItem ;    	
var text = '' ;
var trovato = false ;

(function( $ ) {
  $.widget( "ui.combobox", {
    _create: function() {
      var input,
      that = this,
      select = this.element.hide(),
      selected = select.children( ":selected" ),
      value = selected.val() ? selected.text() : "",
      wrapper = this.wrapper = $( "<span>" ).addClass( "ui-combobox" ).insertAfter( select );
      function removeIfInvalid(element) {
        var value = $( element ).val(),
        matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( value ) + "$", "i" ),
        valid = false;
        select.children( "option" ).each(function() {
          if ( matcher.test(this.text) ) {
            this.selected = valid = true;
            return false;
          }
        });
        if ( valid==false ) {
          $( element ).val( "" ).attr( "title", value + " nessuna voce trovata" ).tooltip( "open" );
          select.val( "" );
          setTimeout(function() {
            input.tooltip( "close" ).attr( "title", "" );
          }, 2500 );
          input.data( "autocomplete" ).term = "";
		  select.append('<option value=-1 selected >Seleziona Voce</option>');
          return false;
        }
      }
      var input1;
      input1 = $( "<input id='"+select[0].id+"input' onclick='pulisciCampo(this)' onmouseout='ripristinaCampo(this)'>" );
      input = input1.appendTo( wrapper ).val( value ).attr( "title", "" ).addClass( "ui-state-default ui-combobox-input" ).autocomplete({
        delay: 0,
        minLength: 3,
        source:  function( request, response ) {
        idprovincia = '-1';
        idcomune = '-1';
        inregione = 'si';
        if(select[0].id =='comune_ritrovamento' || select[0].id =='provincia_ritrovamento'){
          if ($("#provincia_ritrovamento").length > 0){
            idprovincia =document.getElementById("provincia_ritrovamento").value ;
          }
          idcomune =  document.getElementById("comune_ritrovamento").value;
          
          if($("input[name=origine_da]:checked").val()=="in_regione")
            inregione = 'si';
          else
        	inregione = 'no';  
        }
        $.ajax({
          url:  "./ServletComuni?nome="+request.term+"&combo="+select[0].id+"&idProvincia="+idprovincia+"&idComune="+idcomune+"&inRegione="+inregione+"&idAsl=-1",
          dataType: "json",
          data: {
            style: "full",
            maxRows: 12,
            name_startsWith: request.term
          },
          success:function( data ) {
            arrayItem = new Array() ; 
			if (select[0].id=='comune_ritrovamento'){
		      response( $.map( data, function( item ) {
        	    item.descrizione=item.descrizione.replace('&agrave;', "à" ).replace('&egrave;', "è" ).replace('&igrave;', "ì" ).replace('&ograve;', "ò" ).replace('&ugrave;', "ù" );
	            select.append('<option value='+item.codice+'>'+item.descrizione+'</option>');
	            return {
	              label: item.descrizione.replace(
	                new RegExp("(?![^&;]+;)(?!<[^<>]*)(" +
	                $.ui.autocomplete.escapeRegex(request.term) +
	                ")(?![^<>]*>)(?![^&;]+;)", "gi"
	                ), "<strong>$1</strong>" ),
	              value: item.descrizione ,
	              idAsl: item.idAsl ,
	              descrizioneAsl : item.descrizioneAsl
	            }
	          }));
	        }else{
              response( $.map( data, function( item ) {
        	    select.append('<option value='+item.codice+'>'+item.descrizione+'</option>');
                return {
                  label: item.descrizione.replace(
                    new RegExp("(?![^&;]+;)(?!<[^<>]*)(" +
                    $.ui.autocomplete.escapeRegex(request.term) +
                    ")(?![^<>]*>)(?![^&;]+;)", "gi"
                    ), "<strong>$1</strong>" ),
                  value: item.descrizione 
                }
              }));
            }
          }
        });
      },
      select: function( event, ui ) {
        if(select[0].id=='comune_ritrovamento'){
          //document.getElementById('idAsl').value = ui.item.idAsl;
          //document.getElementById('descrAsl').value = ui.item.descrizioneAsl;
        }
        select.children( "option" ).each(function() {
          if ( $( this ).text().match( ui.item.value ) ) {
            trovato = true ;
            this.selected =  true;
            return false;
          }
        }
      );
    },
    change: function( event, ui ) {
      if ( !ui.item )
         return removeIfInvalid( this );
    }
  }).addClass( "ui-widget ui-widget-content ui-corner-left" );
  input.data( "autocomplete" )._renderItem = function( ul, item ) {
    return $( "<li>" ).data( "item.autocomplete", item ).append( "<a>" + item.label + "</a>" ).appendTo( ul );
  };
  $( "<a>" )
    .attr( "tabIndex", -1 )
    .attr( "title", "Mostra tutti" )
    .tooltip()
    .appendTo( wrapper )
    .button({
      icons: {
        primary: "ui-icon-triangle-1-s"
      },
      text: false
    })
    .removeClass( "ui-corner-all" )
    .addClass( "ui-corner-right ui-combobox-toggle" )
    .click(function() {
      // close if already visible
      if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
        input.autocomplete( "close" );
        removeIfInvalid( input );
        return;
      }
  // work around a bug (likely same cause as #5265)
  $( this ).blur();
  // pass empty string as value to search for, displaying all results
  input.autocomplete( "search", "" );
  input.focus();
  });
  input.tooltip({
    position: {
      of: this.button
    },
    tooltipClass: "ui-state-highlight"
    });
  },
  destroy: function() {
    this.wrapper.remove();
    this.element.show();
    $.Widget.prototype.destroy.call( this );
  }
  });
})( jQuery );
 
$(function() {
  $( "#provincia_ritrovamento" ).combobox();
  $( "#comune_ritrovamento" ).combobox();
});

</script>

<%
	Animale animale = Cane;
	if (Furetto.getIdSpecie() == 3) {
		animale = (Animale) Furetto;
	} else if (Gatto.getIdSpecie() == 2) {
		animale = (Animale) Gatto;
	} else {
		animale = (Animale) Cane;
	}
%>


<script>

function checkVeterinarioMicrochip()
{
	var message="";
   
	
    
    if(
    		((document.addAnimale.idVeterinarioMicrochip!=null && 
    		document.addAnimale.idVeterinarioMicrochip.value!='' &&
    		document.addAnimale.idVeterinarioMicrochip.value!='-1') ))
    {

    	loadModalWindow();
			
		var cfVeterinario = checkCfVeterinarioSinaaf(document.addAnimale.idVeterinarioMicrochip.value,'','<%=User.getUserId()%>');
		if(cfVeterinario!=null)
		{
			if(document.forms[0].ruolo.value=='24' || document.forms[0].ruolo.value=='37')
				message += label("", "- Il proprio codice fiscale " + cfVeterinario +  " non e' verificabile sul portale nazionale.\r\n");
			else
				message += label("", "- Il codice fiscale " + cfVeterinario +  " del veterinario chippatura  non e' verificabile sul portale nazionale.\r\n");
		
			alert(label("Verifica Veterinario", "\r\n\r\n") + message);
			document.getElementById('idVeterinarioMicrochip').value ='-1';
			
		}
	
		loadModalWindowUnlock();
    }
    document.getElementById('modalWindow').style.display = 'none';
	return true;
	
}

function checkCfVeterinarioSinaaf(idVeterinario,cf,userId)
{
	
		var controlloCf;

		Animale.checkCfVeterinarioSinaaf(idVeterinario,cf,userId, {
			callback:function(data) {
			if (data != null){
				controlloCf =  data;
			}
			},
			timeout:8000,
			async:false

			});
		
		return controlloCf;
}
	
	
  var campo ;
  var win;
  function openDivSterilizzazione(){
  	if (document.addAnimale.flagSterilizzazione.checked==true) { 
	  document.getElementById('divster').style.display='' 
	}else{
  	  document.getElementById('divster').style.display='none'
	}
  }
  
  
  
  
  
  
  
  function getDatiAnimaleSinaaf(campoIn)
  {
	  Animale.getAnimale(campoIn.value,<%=User.getUserId()%>,getDatiAnimaleSinaafCallBack);
  }
  
  
  function getAnimale(campoIn)
  {
	  Animale.cercaAnimale(campoIn.value, getAnimaleCallBack);
  }

  
  
  
  function getAnimaleCallBack(value)
  {
	  if(value!=null)
	  {
	    alert(value);
	  	return false;
	  }
	  return true;
  }
  
  
  
  
  function getDatiAnimaleSinaafCallBack(value)
  {
	  
	  if(value!=null && value[0])
	  {
		  
		  var msg = "Attenzione! Sul portale nazionale sono stati riscontrati i seguenti dati relativi al microchip inserito: ";
		  
		  
		  if(value[10] !=null && value[10] != ""&& value[15] != null)
		  {
		   
			  
			  if(value!=null && value[14]!=null)
			  		msg+="\n- Regione: " + value[14];
			  if(value!=null && value[11]!=null)
			  		msg+="\n- Asl: " + value[11];
			  if(value!=null && value[20]!=null && value!=null && value[15]!=null)
			  		msg+="\n- Veterinario: " + value[20] +" (CF: "+value[15]+")";
			  if(value!=null && value[17]!=null)
			  		msg+="\n- Data Inserimento: " + value[17];
			  
		  }
		  msg += "\n\nMc applicato all'animale con i seguenti dati: ";
		  
		  
		  if(value!=null && value[0]!=null)
		  		msg+="\n- Data nascita: " + value[0];
		  if(value!=null && value[1]!=null)
		  		msg+="\n- Nome: " + value[1];
		  if(value!=null && value[3]!=null)
		  		msg+="\n- Sesso: " + value[3];
		  if(value!=null && value[2]!=null)
		  		msg+="\n- Data chippatura: " + value[2];
		 
		  if(value!=null && value[16]!=null && value!=null && value[19]!=null)
		  		msg+="\n- Veterinario chippatore: " + value[19]+ " (CF: "+value[16]+")";
		 
		  
		  
		  alert(msg);

		  //msg+="\nSi desidera acquisirli nella maschera di inserimento?"
		 
				if(value!=null && value[0]!=null)
					{
			  		   document.addAnimale.dataNascita.value=value[0];
			  		   document.getElementById('datanascitaDiv').style.display="none";
					}
			  	if(value!=null && value[1]!=null)
			  		{
			  		document.addAnimale.nome.value=value[1];
			  		document.addAnimale.nome.readOnly="readonly";
			  		}
			  	if(value!=null && value[2]!=null)
			  		document.addAnimale.dataMicrochip.value=value[2];
			  	if(value!=null && value[3]!=null)
			  		document.addAnimale.sesso.value=value[3];
	  }
	  else
		  {
		  if((value[10] !=null && value[10] != "") || (value[15] != null && value[15] != ""))
		  {
		   var msg = "Attenzione! Sul portale nazionale sono stati riscontrati i seguenti dati relativi al microchip inserito: ";
		   
			  if(value!=null && value[14]!=null)
			  		msg+="\n- Regione: " + value[14];
			  if(value!=null && value[11]!=null)
			  		msg+="\n- Asl: " + value[11];
			  if(value!=null && value[20]!=null && value!=null && value[15]!=null)
			  		msg+="\n- Veterinario: " + value[20] +" (CF: "+value[15]+")";
			  if(value!=null && value[17]!=null)
			  		msg+="\n- Data Inserimento: " + value[17];
				  
			  
			  alert(msg);

		  }
		  
		  document.addAnimale.nome.readOnly=false;
		  document.getElementById('datanascitaDiv').style.display="block";
		  
		  }
	  
	 
	  
  }
  
  
  
  
  
  
  

  function verificaInserimentoAnimale (campoIn){
	
	campo = campoIn ;
  
  if(  document.forms[0].tatuaggio != null  && document.forms[0].microchip!=null  &&
		document.forms[0].microchip.value==document.forms[0].tatuaggio.value && document.forms[0].microchip.value!=''  && document.forms[0].tatuaggio.value!='' ){
		alert( "Il Microchip e il 2° MC non possono essere uguali");
		campo.value="";
		return;
	}
	if(campo.value.length==15 && (document.getElementById('flagFuoriRegione')==null || document.getElementById('flagFuoriRegione').checked==false) )
	  DwrUtil.verificaInserimentoAnimale(campo.value,<%=User.getUserId()%>,verificaInserimentoAnimaleCallBack);
	else if(campo.value.length==15)
	{
		if(verificaMc==true)
		{
			if(getAnimale(campoIn.value)!=null)
			{
				verificaMc = false;
				campo.value="";
			}
		}
		
		if(verificaMc==true)
		{
			if(verificaStatoInserimentoAnimale(campoIn.value,<%=User.getUserId()%>)!=null)
			{
				verificaMc = false;
				campo.value="";
			}
		}
		
		if(verificaMc==true)
			getDatiAnimaleSinaaf(document.forms[0].microchip);
	}
	
	
	
	
	
  const prefixMc = ["040",	 "688","643", "191",	  "208",	  "250",	  "276",	  "280",	  "308",	  "320",	  "348",	  "350",	  "380",	  "384",	  "388",	  "389",	  "390",
	  "480",	  "528",	  "680",	  "724",	  "756",	  "826",	  "830",	  "882",	  "895",	  "900",	  "934",	  "937",	  "938",	  "939",	  "941",	  "944",
	  "945",	  "947",	  "952",	  "953",	  "956",	  "959",	  "967",	  "968",	  "968",	  "972",	  "977",	  "978",	  "980",	  "981",	  "982",	  "985",
	  "987",	  "992"	
];
  
  
   if(campo.value.length==15 && (document.getElementById('flagFuoriRegione')!=null && document.getElementById('flagFuoriRegione').checked==true) )
   {
	   if(false)
	 //if(!prefixMc.includes(campo.value.substring(0,3)))
		 {
		 	alert( "Il Microchip ha un prefisso non valido");
		 	campo.value="";
		 	verificaMc=false;
		 }
	}
   
   
  }
  
  
  function verificaStatoInserimentoAnimale(mc, userId)
	{
			var controlloMc;

			DwrUtil.verificaStatoInserimentoAnimale(mc, userId, {
				callback:function(data) {
				if (data != null){
					if (data.idEsito!='2' && data.idEsito!='5'){
						controlloMc =  "Microchip presente in banca dati a priori";
						alert(controlloMc);
						}
				}
				},
				timeout:8000,
				async:false

				});
			
			return controlloMc;
	}
	
	
	
	function getAnimale(mc)
	{
			var controlloMc;

			Animale.cercaAnimale(mc, {
				callback:function(data) {
				if (data != null){
					controlloMc =  data;
					alert(controlloMc);
				}
				},
				timeout:8000,
				async:false

				});
			
			return controlloMc;
	}
	
  function verificaInserimentoAnimaleSalva(campoIn)
  {
  	campo = campoIn ;
  	  
      if(  document.forms[0].tatuaggio != null  && document.forms[0].microchip!=null  &&
  		document.forms[0].microchip.value==document.forms[0].tatuaggio.value && document.forms[0].microchip.value!=''  && document.forms[0].tatuaggio.value!='' ){
  		alert( "Il Microchip e il 2° MC non possono essere uguali");
  		campo.value="";
  		return null;
  	}
  	
  	
  	if(campo.value.length==15 && (document.getElementById('flagFuoriRegione')==null || document.getElementById('flagFuoriRegione').checked==false) )
  		DwrUtil.verificaInserimentoAnimale(campo.value,<%=User.getUserId()%>,verificaInserimentoAnimaleCallBackSalva);
  }

  function verificaInserimentoAnimaleCallBackSalva(value)
  {
  	if (value.idEsito=='-1' )
  	{
  		
  		alert(value.descrizione);
  		campo.value="";
  		return value.idEsito;
  	}

  	
  	
  	if (value.idEsito=='2' )
  	{
  		
  		alert(value.descrizione);
  		campo.value="";
  		return value.idEsito;
  	}
  	if ( value.idEsito=='4'){
  		
  		
  			
  			alert( value.descrizione);
  			campo.value="";
  			return value.idEsito;
  	}
  	if (value.idEsito=='3' )
  	{
  			
  			alert( value.descrizione);
  			campo.value="";
  			return value.idEsito;
  	}
  	if (value.idEsito=='6' ){
  		 loadModalWindow();
  		 win= window.open('Microchip.do?command=Carico&popup=true&mc='+campo.value+'','','scrollbars=1,width=800,height=600');
  		 if (win != null) { 
  			  var timer = setInterval(function() { 
  				  if(win.closed) {
  					
  					  if(document.forms[0].closeOKPopMC.value!='true'){
  					
  						  campo.value="";
  				      }
  					  document.forms[0].closeOKPopMC.value='';
  					  clearInterval(timer); 
  					  loadModalWindowUnlock(); 
  				   } 
  				  }, 1000
  				  ); 
  		 }
  		 return value.idEsito;

  		  
  	}
  	
  	return null;
  	
  }
  
  
  function verificaInserimentoAnimaleCallBack(value){

    if (value.idEsito=='-1' ){
	  alert(value.descrizione);
	  campo.value="";
	  verificaMc=false;
	}
	if (value.idEsito=='2' ){
	  alert(value.descrizione);
	  campo.value="";
	  verificaMc=false;
	}
	if ( value.idEsito=='4'){
	  
		alert( value.descrizione);
		campo.value="";
		verificaMc=false;
	}
	if (value.idEsito=='3' ){
	    alert( value.descrizione);
		campo.value="";
		verificaMc=false;
	}
	if (value.idEsito=='6' ){
		verificaMc=false;
		 loadModalWindow();
		 win= window.open('Microchip.do?command=Carico&popup=true&mc='+campo.value+'','','scrollbars=1,width=800,height=600');
		 if (win != null) { 
			  var timer = setInterval(function() { 
				  if(win.closed) {
					/*   if(document.forms[0].closeOKPopMC.value!='' && document.forms[0].closeOKPopMC.value='false'){
				    	  document.forms[0].closeOKPopMC.value='';
				    	  document.forms[0].microchip.value='';
				  		
				      } */
				     // alert(document.forms[0].closeOKPopMC.value!='true');
					  if(document.forms[0].closeOKPopMC.value!='true'){
						//  document.getElementById('microchip').value='';
						  //alert("sono qui");
						  campo.value="";
				      }
					  document.forms[0].closeOKPopMC.value='';
					  clearInterval(timer); 
					  loadModalWindowUnlock(); 
				   } 
				  }, 1000
				  ); 
		 }

		  
	}
	
	if(verificaMc==true)
		getDatiAnimaleSinaaf(document.forms[0].microchip);
	verificaMc=true;
  }
  
  
  
  
  function verificaInserimentoAnimaleInserimentoFuoriRegioneCallBack(value){

	  if (value.idEsito!='2' && value.idEsito!='5'){
		  alert("Microchip presente in banca dati a priori");
		  campo.value="";
		  verificaMc=false;
		}
		
	  }
	  
	  
  
  
  

  formTest = true;
  message = "";

function checkForm(form) {
	formTest = true;
	message = "";
	var nessuna_origine=false;
	
  if($("#abilita_origine").val()=="true")
  {
	   // CONTROLLO ORIGINE ANIMALE: SE FUORI REGIONE I DATI SONO SEMPRE OBBLIGATORI
	  if (form.origine_da != null &&  form.origine_da.value!="")
	  {
		   if (form.tipo_origine != null &&  form.tipo_origine.value!="")
		   {
		  		if($("input[name=tipo_origine]:checked").val() == "ritrovamento")
		  		{
		    		if(form.provincia_ritrovamento.value==""  || form.comune_ritrovamento.value=="" || 
		       		form.indirizzo_ritrovamento.value=="" ||  form.data_ritrovamento.value=="")
		    		{
		    			
						 message += label("","- Attenzione, inserire tutti i dati inerenti al luogo di ritrovamento.\r\n");
			       		formTest = false;
					}
		  		}
		  		else
		  		{
		    		if(form.idProprietarioProvenienza.value=="-1" && document.getElementById("nome_proprietario_provenienza").innerHTML =="")
		    		{
		    			message += label("","- Attenzione, inserire il proprietario di origine.\r\n");
		       			formTest = false;	  
					}
		  		}
		   }
		   else if($("input[name=origine_da]:checked").val() == "nazione_estera")
		   {
			   if (form.idNazioneProvenienza.value=="-1" )
			   {
				    message += label("","- Attenzione, inserire la Nazione di provenienza estera.\r\n");
					formTest = false;	  
				}
				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
			   if (document.getElementById("nome_proprietario_provenienza").innerHTML ==""){
				   message += label("","- Attenzione, inserire il proprietario di origine.\r\n");
	       			formTest = false;
			   }
			   <%}%>
			   // CONTROLLO CAMPO NOTE --> size>10 se scritto
				/*if (form.idNazioneProvenienza.value!="-1" ){
					if(form.noteNazioneProvenienza.value.length>0 && form.noteNazioneProvenienza.value.length<10){
						message += label("","- Attenzione, il campo 'Note' del flag 'Provenienza da nazione estera' deve avere almeno 10 caratteri se inizializzato.\r\n");
						formTest = false;	  
					}
				} */ 
		   }
		   else
		   {
				message += label("","- Attenzione, inserire i dati inerenti all'origine dell'animale.\r\n");
			    formTest = false; 
		   }
	   }
	
	
		if (form.flagFuoriRegione != null &&  form.flagFuoriRegione.checked && form.idRegioneProvenienza.value=="-1" ){
		    message += label("","- Attenzione, inserire la regione dell'anagrafe di provenienza.\r\n");
			formTest = false;	  
		} // CONTROLLO CAMPO NOTE --> size>10 se scritto
		/*if (form.flagFuoriRegione!= null &&  form.flagFuoriRegione.checked && form.flagFuoriRegione.value!="-1" ){ 
			if(form.noteAnagrafeFr.value.length>0 && form.noteAnagrafeFr.value.length<10){
				message += label("","- Attenzione, il campo 'Note' del flag 'Provenienza da anagrafe altra regione' deve avere almeno 10 caratteri se inizializzato.\r\n");
				formTest = false;	  
			}
		}*/
	
		
		<% if(true){ %>

		if (form.flagAcquistoOnline != null &&  form.flagAcquistoOnline.checked && form.sitoWebAcquisto.value=="-1" ){
		    message += label("","- Attenzione, inserire il sito web d'acquisto.\r\n");
			formTest = false;
			var myselect = document.getElementById("sitoWebAcquisto");
			if(myselect.options[myselect.selectedIndex].value=="Altro"){
				

				if(form.noteAcquistoOnline.value.length<2){
					message += label("","- Attenzione, il campo 'Note' della sezione 'Acquisto online' deve essere valorizzato.\r\n");
					formTest = false;	  
				}
			
				}
		}
	<%}%>
		if(true){
			var origine=false;
			if(form.origine_da != null && form.origine_da.value!='')
				origine=true;
			//if(form.flagFuoriNazione != null && form.flagFuoriNazione.checked)
			//	origine=true;
			if(form.flagFuoriRegione != null && form.flagFuoriRegione.checked)
				origine=true;
			if(form.flagFuoriRegione != null && form.flagFuoriRegione.checked)
				origine=true;
			<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("false")){ %>
			if(form.flagAcquistoOnline != null && form.flagAcquistoOnline.checked)
				origine=true;
			<% } %>
			if(form.flagSenzaOrigine != null && form.flagSenzaOrigine.checked){
				origine=true;
				nessuna_origine=true;
			}
			if(!origine){
			    message += label("","- Attenzione, inserire i dati sull'origine dell'animale.\r\n");
				formTest = false;	  			
			}	
		}
  }else{
	  document.getElementById("flagSenzaOrigine").value="on";
  }

  
  if (document.getElementById("data_ritrovamento").value != "" && document.getElementById("dataNascita").value != "" && 
		  giorni_differenza(document.getElementById("data_ritrovamento").value,document.getElementById("dataNascita").value)>0)
  {
		 message += label("","- Attenzione, Data di ritrovamento inferiore a data di nascita.\r\n");
		  formTest = false;
  }

  if (document.getElementById("data_ritrovamento").value != "" && document.getElementById("dataRegistrazione").value != "" && 
		  giorni_differenza(document.getElementById("data_ritrovamento").value,document.getElementById("dataRegistrazione").value)<0)
  {
		 message += label("","- Attenzione, Data di ritrovamento maggiore di data di registrazione.\r\n");
		  formTest = false;
}
	 
  
  
  if(verificaInserimentoAnimaleSalva(form.microchip)!=null)
  {
	  	formTest = false;
  }
  
	/*CONTROLLO VALIDITA' MC PER LP E SPECIE*/
	if (document.forms[0].ruolo.value == '24'){
		if ((form.idSpecie.value == '1' || ((form.idSpecie.value == '2' || form.idSpecie.value == '3') )) && !(form.microchip.value.substring(0, 6) == "380260")){
			message += label("","- Attenzione, MC non valido: selezionare un Mc del tipo 380260... \r\n");
	       	formTest = false;
	 	}	
	}
	
	
	

    if ( form.idSpecie.value == '1' && form.flagMorsicatore != null &&  form.flagMorsicatore.checked){
    	if(( (form.dataMorso.value ==null ) || (form.dataMorso.value==""))){
    		message += label("","- Flag Morsicatore settato: valorizzare almeno una data\r\n");
		    formTest = false;
	    }   	
    }
    
    //Flusso 251: disabilitazione flusso: mettere if (false)
    if(true)
    {
    if (document.forms[0].ruolo.value == '24' && document.getElementById('flagSterilizzazione')!=null && document.getElementById('flagSterilizzazione').checked==true && document.getElementById('idProgettoSterilizzazioneRichiesto')!=null && document.getElementById('idProgettoSterilizzazioneRichiesto').value=="-1"){
			message += label("","- Attenzione, selezionare un progetto di sterilizzazione \r\n");
	       	formTest = false;
	}
	}
    
    
  
    lanciaControlloDate(<%=User.getRoleId()%>, <%=ApplicationProperties.getProperty("ID_RUOLO_LLP")%>);

    //controllo sul proprietario se non è stato selezionato
    if (form.idProprietario.value == "-1") { 
    	message += label("check.ubicazione","- Proprietario è un informazione richiesta\r\n");
        formTest = false;
    }
    //controllo sul detentore se non è stato selezionato 
    if (form.idSpecie.value == '1' &&  form.idDetentore.value == "-1") { 
       	message += label("check.detentore","- Detentore è un informazione richiesta\r\n");
       	formTest = false;
    }
    
    if (form.idSpecie.value == '1' && !checkOccupazioneStabilimento()){<%
    	if(!ApplicationProperties.getProperty("blocco_canili_occupati").equals("true")){%>
    		alert("Attenzione, il canile è in sovraffollamento. A far data dal 20/02/2016 non sarà piu possibile registrare nuovi cani in ingresso.");<%
    	}else{%>
 		   	message += label("", "Canile selezionato in sovraffollamento, non e' possibile inserire ulteriori cani, selezionare un altro canile. \r\n ");
			formTest = false;<%
    	} %>		
    }
    
    var gattiSuColonie = false;
    
    if(gattiSuColonie)
    {
	    if(form.idSpecie.value == '1' || form.idSpecie.value == '3'){
	    if (formTest && checkSpecieEProprietario() == false){
	    	message += label("", "Hai selezionato un proprietario di tipo sindaco, devi selezionare un detentore di tipo canile \r\n ");
			formTest = false;
	   	}}
	    
	    if(form.idSpecie.value == '2' ){
	    if (formTest && checkSpecieEProprietario() == false){
	    	message += label("", "Hai selezionato un proprietario di tipo sindaco, devi selezionare un detentore di tipo canile o colonia\r\n ");
			formTest = false;
	   	}
	    }
    }
    else
    	{
    	 if (formTest && checkSpecieEProprietario() == false){
 	    	message += label("", "Hai selezionato un proprietario di tipo sindaco, devi selezionare un detentore di tipo canile \r\n ");
 			formTest = false;
 	   	}
    	
    	}

    if (form.idProprietario.value != "-1" && checkCatturaDaProprietarioDetentoreTipo() == false){
		;
	}

    //----CAMPI OBBLIGATORI--------------
   	//controllo sulla taglia
	if (form.idSpecie.value == '1' &&  form.idTaglia.value == '-1') { 
		message += label("taglia.required", "- Taglia è un informazione richiesta\r\n");
	    formTest = false;
	}
    
    if ((form.idAslRiferimento==null) || (form.idAslRiferimento.value == '-1' )) { 

    	message += label("asl.required", "- Asl è un informazione richiesta\r\n");
	    formTest = false;
	}
     //controllo sulla razza
	if (form.idRazza.value == '-1') { 
	    message += label("razza.required", "- Razza è un informazione richiesta\r\n");
	    formTest = false;
	}
	//controllo sul mantello
	if (form.idTipoMantello.value == '-1') { 
		message += label("mantello.required", "- Mantello è un informazione richiesta\r\n");
	    formTest = false;
	}
	
 // controllo sul nome
 
	/* SINAAF ADEGUAMENTO */
		//controllo sul nome
		if (form.nome.value == "") { 
			message += label("nome.required", "- Nome è una informazione richiesta\r\n");
		    formTest = false;
		}
	
	//controllo sul mc
	if (form.microchip.value == "") {
		message += label("serial.number.required", "- Microchip è un informazione richiesta\r\n");
	    formTest = false;
	}else{
		//controllo sulla lunghezza del microchip    
	    if( !( (form.microchip.value.length == 15) && ( /^([0-9]+)$/.test( form.microchip.value )) ) ){
	    	message += label("", "- La lunghezza del microchip deve essere di 15 caratteri numerici\r\n");
	        formTest = false;
	    }
	}

	 //controllo sul mc
    if (form.tatuaggio != null && form.tatuaggio.value != "") {
		if (form.idSpecie.value=='1' && form.dataTatuaggio != null && form.dataTatuaggio.value == "") {
	    	message += label("", "- Data Inserimento secondo mc richiesta\r\n");
	     	formTest = false;
		}  
	}
	
	 if (form.idSpecie.value == '1' && form.dataTatuaggio != null &&  form.dataTatuaggio.value != "") {
	 	if (form.tatuaggio.value == "") {
			message += label("", "- Tatuaggio/2nd microchip richiesto\r\n");
		    formTest = false;
		}
	}
	
	//controllo sul check  regione
	if (form.idSpecie.value == '1' && form.flagProvenienzaFuoriRegione != null &&  form.flagProvenienzaFuoriRegione.checked){
		if ( form.idRegioneProvenienza.value== -1){
	   		message += label("", "- Selezionare la Regione di Provenienza\r\n");
	   		formTest = false;
	   	}
	}
			 
	if (form.numeroPassaporto && form.numeroPassaporto.value!=""){
		if (form.dataRilascioPassaporto.value==""){
			message += label("", "- Data Rilascio passaporto richiesta.\r\n");
	     	formTest = false;
	    }	
	}

	if (form.dataRilascioPassaporto && form.dataRilascioPassaporto.value!=""){
		if (form.numeroPassaporto.value==""){
	 		message += label("", "- Campo passaporto richiesto.\r\n");
	     	formTest = false;
	    }	
	}

	if (!$('input[name=sesso]:checked').length > 0) {
		message += label("", "- Sesso dell'animale richiesto.\r\n");
 		formTest = false;
	}

    if (document.addAnimale.flagCattura != null && document.addAnimale.flagCattura.checked){
    	if (document.addAnimale.dataCattura.value == null || document.addAnimale.dataCattura.value == ''){
    		message += label("", "- La data della cattura è richiesta.\r\n");
     		formTest = false;
    	}
    }
    
    
    
    if (document.addAnimale.flagSterilizzazione != null && document.addAnimale.flagSterilizzazione.checked){
    	if (document.addAnimale.dataSterilizzazione.value == null || document.addAnimale.dataSterilizzazione.value == ''){
    		message += label("", "- La data della sterilizzazione è richiesta.\r\n");
     		formTest = false;
    	}
    }
    
    /* var selezionatiEntrambi = document.addAnimale.idVeterinarioMicrochip != null && document.addAnimale.idVeterinarioMicrochip.value!='' && document.addAnimale.idVeterinarioMicrochip.value!='-1' && document.addAnimale.cfVeterinarioMicrochip != null && document.addAnimale.cfVeterinarioMicrochip.value!='' ;
    
    if (selezionatiEntrambi ){
    	message += label("", "- Selezionare il veterinario chippatore dal menu a tendina o inseririlo nel campo di testo.\r\n");
     	formTest = false;
    } */
    
    if (document.addAnimale.idVeterinarioMicrochip != null &&
    		(document.addAnimale.idVeterinarioMicrochip.value=='' || document.addAnimale.idVeterinarioMicrochip.value=='-1') && document.addAnimale.flagFuoriRegione != null &&  !document.addAnimale.flagFuoriRegione.checked ){
    		message += label("", "- Il veterinario chippatura è richiesto.\r\n");
     		formTest = false;
    }
    
  <%--   if(!selezionatiEntrambi && 
    		((document.addAnimale.idVeterinarioMicrochip!=null && document.addAnimale.idVeterinarioMicrochip.value!='' && document.addAnimale.idVeterinarioMicrochip.value!='-1') || (document.addAnimale.cfVeterinarioMicrochip!=null && document.addAnimale.cfVeterinarioMicrochip.value!='')))
    {
    	var cfManuale;
    	if(document.addAnimale.cfVeterinarioMicrochip!=null)
    		cfManuale = document.addAnimale.cfVeterinarioMicrochip.value;
    		
	    var cfVeterinario = checkCfVeterinarioSinaaf(document.addAnimale.idVeterinarioMicrochip.value,cfManuale,'<%=User.getUserId()%>');
	    
	    if(cfVeterinario!=null)
	    {
	    	if(document.forms[0].ruolo.value=='24' || document.forms[0].ruolo.value=='37')
				message += label("", "- Il proprio codice fiscale " + cfVeterinario +  " non è censito in SINAAF come veterinario chippatore.\r\n");
	    	else
	    		message += label("", "- Il codice fiscale " + cfVeterinario +  " del veterinario chippatura non è censito in SINAAF\r\n");
	    	formTest = false;
	    }
    }
    
     --%>
    
    
    
    //Controllo campi attivita itinerante
   	if ( document.addAnimale.flagAttivitaItinerante!=null && document.addAnimale.flagAttivitaItinerante.checked){
		if (document.getElementById("idComuneAttivitaItinerante").value == '-1' || document.getElementById("luogoAttivitaItinerante").value == ''){
			message += label("", "- Inserisci le informazioni sul luogo dell\'attivita itinerante svolta.\r\n");
    		formTest = false;
	   }
   }

    
    
   	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
	
    
   	controlloDate();

   	
   	if((document.getElementById("microchipMadre").value.length<15)&&($("input[name=origine_da]:checked").val() != "nazione_estera")&& ($("input[name=tipo_origine]:checked").val() == "soggetto_fisico")){
   	 message += label("", "- Attenzione! Lunghezza Microchip Madre minore di 15 caratteri!\r\n");
		formTest = false;

   	}
   	
	if((document.getElementById("microchipMadre").value != document.getElementById("controlloMicrochipMadre").value) && document.getElementById("microchipMadre").value!=""){
	   	 message += label("", "- Attenzione! Bisogna confermare il microchip di provenienza!\r\n");
			formTest = false;

	   	}
   	
   	
   	
   	<%	}  %>
 
    if (formTest == false) {
     		alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
      	return false;
    }else{ /*
    	if(nessuna_origine){
    		var r = confirm("ATTENZIONE! Avendo spuntato il flag 'Informazioni mancanti sull'origine dell'animale', si rende necessaria un'autocertificazione di responsabilità da parte del "+
    						"proprietario dell'animale da allegare alla scheda del dettaglio animale.\n\nCliccando 'OK' verrà generato il documento da allegare.\n\nProseguire con l'inserimento?");
    		if (r == true) {
    			openRichiestaPDF('PrintAutocertificazioneMancataOrigineAnimale','-1','-1',''+document.getElementById("microchip").value,''+document.getElementById("idProprietario").value, '-1');
        		loadModalWindow(); //ATTENDERE PREGO
        		return true; 
        	}else{
 		   		return false;
    		}
    	}else{ */

            
    		
    		
    		
<% 
    		if(ApplicationProperties.getProperty("flusso_336_req3").equals("true") && User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")))
    		{
%>

    			var fuoriRegione =  document.getElementById('origine_da')!=null && $("input[name=origine_da]:checked").val()=="fuori_regione"  ;
    			var mancataTracciabilita = document.getElementById('mancata_tracciabilita')!=null && document.getElementById('mancata_tracciabilita').checked;
    			var proprietarioDiverso = !fuoriRegione && !mancataTracciabilita && form.idProprietarioProvenienza.value!=form.idProprietario.value ;
    			//if((fuoriRegione || mancataTracciabilita || proprietarioDiverso) && form.idSpecie.value == '1')
        		if(false)
    			{
    				if(confirm("Attenzione!!! I dati di provenienza inseriti genereranno una segnalazione di trasgressione all'ASL. Proseguire lo stesso?"))
    				{
    					loadModalWindow(); 
    	    			document.getElementById('modalWindow').style.display = 'block';
    	    			return true;
    				}
    				else
    					return false
    				
    			}
    			

<%
    		}
%>
    	
    		loadModalWindow(); 
			document.getElementById('modalWindow').style.display = 'block';
			return true;
    		
    	//}
    }
    
    
    
    

	
	
	
}  
function verificaPassaporto(campoIn){
	var ok = false;
	
	//Flusso 238: rimuovere ultimi due parametri
	EventoRilascioPassaporto.checkValorePassaporto(campoIn.value, <%=User.getSiteId()%> , <%=-1%>,<%=(String)request.getSession().getAttribute("id_canile")%>,<%=(String)request.getSession().getAttribute("id_stabilimento_gisa")%>,  {
		callback:function(data) {
		
		if (data.idEsito == 1)
			ok = true;
		else {
			 alert('Passaporto non utilizzabile. In fase di inserimento anagrafica è possibile l\'inserimento solo di passaporti non appartenenti alla regione campania. Per tutti gli altri casi utilizzare la registrazione di rilascio passaporto. ');
			 campoIn.value = '';
		}
		},
		timeout:8000,
		async:false

		});

	return ok;
}


var array_pratiche = new Array();

function visualizzaPratiche(){
	if (document.addAnimale.flagContributoRegionale.checked){
		if((document.addAnimale.idProprietario.value == "-1")||(document.addAnimale.idDetentore.value == "-1")){
			document.addAnimale.flagContributoRegionale.checked=false;
			alert('- Selezionare prima un Proprietario e un Detentore per questo cane');
		}else{
			if((document.addAnimale.dataSterilizzazione.value == "")||(document.addAnimale.dataSterilizzazione.value == null)){
				document.addAnimale.flagContributoRegionale.checked=false;
				alert('Selezionare prima la data di sterilizzazione');
			}else{
				//estrae tutte le pratiche per cui esiste aleno una posizione aperta
				PraticaList.getListData(document.addAnimale.dataSterilizzazione.value,document.addAnimale.idAslRiferimento.value,document.addAnimale.idDetentore.value, document.addAnimale.idSpecie.value, valorizzaLista);
			}	
		}
	}else{
		document.getElementById("pratica_contributo").style.visibility="hidden";
		document.addAnimale.pratica.value = -1;
	}
}




function visualizzaPraticheLP()
{
		var sesso ="";
		if ($('input[name=sesso]:checked').length > 0) 
		{
			sesso = $('input[name=sesso]:checked')[0].value; 
		}
		
		var idComuneProprietario ="";
		if (document.getElementById('idComuneProprietario')!=null && document.getElementById('idComuneProprietario').value != "") 
		{
			idComuneProprietario = document.getElementById('idComuneProprietario').value;
		}
		
		<!-- Flusso 251: modifiche del 03/08 - INIZIO -->
		//if(document.getElementById('dataSterilizzazione').value != "" && sesso != "" && idComuneProprietario != "")
		//{
			document.getElementById("pratica_contributo").style.visibility="visible";
			PraticaList.getListDataLP(document.getElementById('dataSterilizzazione').value , sesso, idComuneProprietario, '<%=User.getUserId()%>', valorizzaListaLP);
		/*}
		else
		{
			document.getElementById("pratica_contributo").style.visibility="hidden";
			removeOptions(document.getElementById('idProgettoSterilizzazioneRichiesto'));
		}*/
		<!-- Flusso 251: modifiche del 03/08 - FINE -->
}


function valorizzaListaLP(listaPratiche)
{
  var select = document.getElementById('idProgettoSterilizzazioneRichiesto'); 
  var valorePrecedente = select.value; 
  var valueCeAncora = false;
	
  i = 0;
  k = 0;

  for (var j = select.length - 1; j >= 0; j--)
  	  	select.remove(j);

	 var NewOpttmp = document.createElement('option');
	 NewOpttmp.value=-1;
	 NewOpttmp.text="<-- Selezionare una pratica -->";
	 try{
	 select.add(NewOpttmp, null); //Metodo Standard, non funziona con IE
	 }
	 catch(e){
		 select.add(NewOpttmp); 
	 }	
  while(i < listaPratiche.length){
		
			 array_pratiche[listaPratiche[i].id]=listaPratiche[i];

			 var NewOpt = document.createElement('option');
			 NewOpt.value = listaPratiche[i].id;
			 if(listaPratiche[i].id==valorePrecedente)
					valueCeAncora = true;
			 // Flusso 251: modifiche del 03/08 - INIZIO: aggiunto il totale di cani su ogni progetto -->
		 	 NewOpt.text =  "Decreto numero "+listaPratiche[i].numero_decreto_pratica + " del "+ listaPratiche[i].data_decreto_stringa +" - Cani maschi restanti "+ listaPratiche[i].cani_restanti_maschi + "/" + listaPratiche[i].totale_cani_maschi +" - Cani femmina restanti "+listaPratiche[i].cani_restanti_femmina  + "/" + listaPratiche[i].totale_cani_femmina + " - "+ listaPratiche[i].elenco_comuni ;
			
			if(listaPratiche[i].elenco_comuni.length != 0 ){

				for (var k=0; k<listaPratiche[i].elenco_comuni.length; k++) {
				 	NewOpt.text =  "Decreto numero "+listaPratiche[i].numero_decreto_pratica + " del "+ listaPratiche[i].data_decreto_stringa +" - Cani maschi restanti "+ listaPratiche[i].cani_restanti_maschi  + "/" + listaPratiche[i].totale_cani_maschi +" - Cani femmina restanti "+listaPratiche[i].cani_restanti_femmina  + "/" + listaPratiche[i].totale_cani_femmina  +" - "+ listaPratiche[i].elenco_comuni[k];	
				}
			}
			
			
			
			    try
			    {
			  	  select.add(NewOpt, null); //Metodo Standard, non funziona con IE
			    }catch(e){
			  	  select.add(NewOpt); // Funziona solo con IE
			    }
			    i++;						   
	}
  
  if(valorePrecedente!="" && valueCeAncora)
 		document.getElementById('idProgettoSterilizzazioneRichiesto').value=valorePrecedente;
    
    }

function removeOptions(selectElement) {
	   var i, L = selectElement.options.length - 1;
	   for(i = L; i >= 0; i--) {
	      selectElement.remove(i);
	   }
	}

function valorizzaLista(listaPratiche){
	var select = document.forms['addAnimale'].idProgettoSterilizzazioneRichiesto; //Recupero la SELECT
	i = 0;
  	//indice utilizzato per i canili
  	k = 0;
	//Azzero il contenuto della seconda select
  	for (var j = select.length - 1; j >= 0; j--)
  		select.remove(j);
	var NewOpttmp = document.createElement('option');
 	NewOpttmp.value=-1;
 	NewOpttmp.text="<-- Selezionare una pratica -->";
 	try{
 		select.add(NewOpttmp, null); //Metodo Standard, non funziona con IE
 	}catch(e){
	 select.add(NewOpttmp); 
 	}	
	while(i < listaPratiche.length){
		array_pratiche[listaPratiche[i].id]=listaPratiche[i];
		var NewOpt = document.createElement('option');
		NewOpt.value = listaPratiche[i].id;
		//alert(NewOpt.value);
	 	NewOpt.text =  "Decreto numero "+listaPratiche[i].numero_decreto_pratica + " del "+ listaPratiche[i].data_decreto_stringa +" - N° cani padronali restanti "+ listaPratiche[i].cani_restanti_padronali +" - N° cani catturati restanti "+listaPratiche[i].cani_restanti_catturati + " - "+ listaPratiche[i].elenco_comuni ;
		if(listaPratiche[i].elencoCanili.length != 0 ){
			for (var k=0; k<listaPratiche[i].elencoCanili.length; k++) {
				NewOpt.text =  "Decreto numero "+listaPratiche[i].numero_decreto_pratica + " del "+ listaPratiche[i].data_decreto_stringa +" - N° cani padronali restanti "+ listaPratiche[i].cani_restanti_padronali +" - N° cani catturati restanti "+listaPratiche[i].cani_restanti_catturati + " - "+ listaPratiche[i].elencoCanili;	
			}
		}
		//controllo dell'id selezionato nel caso di salva e clona
		if(document.addAnimale.oldPratica.value == NewOpt.value){
			NewOpt.selected = true;
		}
		//Aggiungo l'elemento option
		try{
			select.add(NewOpt, null); //Metodo Standard, non funziona con IE
		}catch(e){
			select.add(NewOpt); // Funziona solo con IE
		}
		i++;						   
	}
   	if (select.length>0){
       	document.getElementById("pratica_contributo").style.visibility="visible";
	}
}

function svuota(){
	document.addAnimale.flagContributoRegionale.checked=false;
	document.getElementById("pratica_contributo").style.visibility="hidden";
}


function checkProprietarioDetentore(){
	if (document.addAnimale.flagCattura.checked){
		LineaProduttiva.verificaLineaProduttiva(document.addAnimale.idProprietario.value, document.addAnimale.idDetentore.value, 2, 4, check );
	}
}

function checkCatturaDaProprietarioDetentoreTipo(){
	var ok = false;
	//alert($('#flagCattura').is(':checked'));
	LineaProduttiva.verificaLineaProduttivaPerCatture(document.addAnimale.idProprietario.value, document.addAnimale.idDetentore.value, $('#flagCattura').is(':checked'), {
		callback:function(data) {
			//alert(data.idEsito);
		if (data.idEsito == -1){
			ok = false;
			message = data.descrizione;
			formTest  = false;
		}else{
			ok = true;
		}
		},
		timeout:8000,
		async:false
		});
	return ok;
}


function checkSpecieEProprietario(){
	var ok = false;
	//alert($('#flagCattura').is(':checked'));
	LineaProduttiva.verificaProprietarioSpecie( document.addAnimale.idSpecie.value, document.addAnimale.idProprietario.value,document.addAnimale.idDetentore.value,  {
		callback:function(data) {
		ok= data;
		},
		timeout:8000,
		async:false
		});
	return ok;
}

function check(rit){
	if (rit == false){
		$('#flagCattura').attr('checked', false);
		alert("Selezionare un proprietario sindaco e un detentore canile per poter aggiungere una registrazione di cattura");
	}
}

function apriPopup(){
	 $("#dialogMunicipalita").dialog('open');
}	

function apriPopupAggiuntaVetChippatore(){
	 $("#dialogAggiuntaVetChippatore").dialog('open');
}	

$(document).ready(function(){
	
	calenda('dataRegistrazione','','0');
	calenda('dataNascita','','0');
	calenda('dataMicrochip','','0');
	calenda('dataMorso','','0');
	calenda('dataSterilizzazione','','0');
	calenda('dataTatuaggio','','0');
	calenda('dataRilascioPassaporto','','0');
	calenda('dataScadenzaPassaporto','','');
	calenda('data_ritrovamento','','0');
	calenda('leishmaniosiDataOrdinanzaSindacale','','0');
	calenda('dataControlloEhrlichiosi','','0');
	calenda('dataControlloRickettsiosi','','0');
	calenda('dataCattura','','0');
	calenda('dataMadre','','-8M');
	
	 $('#idTaglia').change(function(){
		 checkOccupazioneStabilimento(true);
	 });
	if( $('#idComuneCattura').val() > 0){
		visualizzaMunicipalita();
	}
    $("#dialogMunicipalita").dialog({
    	autoOpen: false,
        maxWidth:600,
        maxHeight: 500,
        width: 600,
        height: 500,
        modal: true,
        buttons: {
            "Chiudi": function() {
               $(this).dialog("close");
            }
        },
        close: function() {
        } });
    //PROPRIETARIO = SINDACO -> NOME ANIMALE = cane_randagio
    //alert($("#tipologia_proprietario").val());
    if($("#tipologia_proprietario").val() == '3' || $("#tipologia_proprietario").val() == 3){
    	$("#nome").val('cane_randagio');
    }else if($("#nome").val() == 'cane_randagio'){
    	$("#nome").val('');
    }
}); 

function initDiv()
{

$(document).ready(function(){	
	 $("#dialogAggiuntaVetChippatore").dialog({
   	autoOpen: false,
       maxWidth:600,
       maxHeight: 500,
       width: 600,
       height: 300,
       modal: true,
       buttons: {
           "Salva": function() {
        	  checkVetChip = true;
        	  
              if(document.getElementById('nomeVeterinarioMicrochip').value=='')
              {
            		alert('Inserire il nome del veterinario chippatore'); 
            		checkVetChip=false;
            		document.getElementById('nomeVeterinarioMicrochip').focus();
              }
              else if(document.getElementById('cognomeVeterinarioMicrochip').value=='')
              {
          		   alert('Inserire il cognome del veterinario chippatore'); 
          		   checkVetChip=false;
          		   document.getElementById('cognomeVeterinarioMicrochip').focus();
              }
              else if(document.getElementById('cfVeterinarioMicrochip').value=='')
              {
          		alert('Inserire il codice fiscale del veterinario chippatore'); 
          		checkVetChip=false;
          		document.getElementById('cfVeterinarioMicrochip').focus();
              }
              else if(CalcolaCodiceFiscaleCognome(document.getElementById('cognomeVeterinarioMicrochip').value.toUpperCase())!= document.getElementById('cfVeterinarioMicrochip').value.toUpperCase().substring(0,3)   ||
            		  CalcolaCodiceFiscaleNome(document.getElementById('nomeVeterinarioMicrochip').value.toUpperCase())!= document.getElementById('cfVeterinarioMicrochip').value.toUpperCase().substring(3,6) )
              {
          		alert('Il nome e cognome non corrispondono al codice fiscale'); 
          		checkVetChip=false;
          		document.getElementById('cfVeterinarioMicrochip').focus();
              }
              else if(document.getElementById('dataInizioVeterinarioMicrochip').value=='')
              {
          		alert('Inserire la data di inizio validità del veterinario chippatore'); 
          		checkVetChip=false;
          		document.getElementById('dataInizioVeterinarioMicrochip').focus();
              }
              else if(document.getElementById('aslVeterinarioMicrochip').value=='-1')
              {
          		alert("Inserire l'asl del veterinario chippatore"); 
          		checkVetChip=false;
          		document.getElementById('aslVeterinarioMicrochip').focus();
              }
              if(checkVetChip==true)
              {
            	  Animale.inserisciVetChippatore(document.getElementById('nomeVeterinarioMicrochip').value,document.getElementById('cognomeVeterinarioMicrochip').value,document.getElementById('cfVeterinarioMicrochip').value, document.getElementById('dataInizioVeterinarioMicrochip').value, document.getElementById('dataFineVeterinarioMicrochip').value,document.getElementById('aslVeterinarioMicrochip').value,  '<%=User.getUserId()%>', {
          			callback:function(data) {
          			if (data!=null && data !=null && data!='KO')
          			{
          				alert('Veterinario chippatore anagrafato correttamente');
      					Animale.listaVeterinari({
      	          			callback:function(data) {
      	          				if(data!=null)
      	          					{
      	          						document.getElementById('idVeterinarioMicrochip').innerHTML=data;
      	          						document.getElementById('nomeVeterinarioMicrochip').value='';
      	          						document.getElementById('cognomeVeterinarioMicrochip').value='';
      	          						document.getElementById('cfVeterinarioMicrochip').value='';
      	          						document.getElementById('dataInizioVeterinarioMicrochip').value='';
      	          						document.getElementById('dataFineVeterinarioMicrochip').value='';
      	          						document.getElementById('aslVeterinarioMicrochip').value='-1';
      	          					}
      	          			 $("#dialogAggiuntaVetChippatore").dialog("close");
      	          			},
      	          			timeout:8000,
      	          			async:false

      	          			});
          			}
          			else
          			{
          				alert("Errore durante l'inserimento del veterinario chippatore.");	
          				
          			}
          			},
          			timeout:8000,
          			async:false

          			});
              }
           },
           "Chiudi": function() {
               $(this).dialog("close");
            }
       },
       close: function() {
       } });
}); 
}
	 
	 
function checkOccupazioneStabilimento(flagAvviso){
	var ok = false;
	Stabilimento.checkOccupazioneCanile(document.addAnimale.idDetentore.value, document.addAnimale.idTaglia.value, document.addAnimale.dataNascita.value, -1, {
		callback:function(data) {
			ok= data;
			//alert(ok);	
			if (!ok && flagAvviso){		
				<% if(!ApplicationProperties.getProperty("blocco_canili_occupati").equals("true")){ %>
					ok=true;
				<%	}  %>
				<% if(!ApplicationProperties.getProperty("blocco_canili_occupati").equals("true")){ %>
					alert("Attenzione, il canile è in sovraffollamento. A far data dal 20/02/2016 non sarà piu possibile registrare nuovi cani in ingresso.");
				<%  }else{ %>
					alert("Canile selezionato in sovraffollamento, non e' possibile inserire ulteriori cani, selezionare un altro canile.");
				<%  } %>
			}
		},
		timeout:8000,
		async:false
		});
	return ok;
}

/* GESTIONE MUNICIPALITA' COMUNE CATTURA */
function visualizzaMunicipalita(){
	DwrUtil.getListaMunicipalita(document.forms[0].idComuneCattura.value, valorizzaListaCallback21);
 }
 
function valorizzaListaCallback21(listaMunicipalita){
	var select = document.createElement("select");
 	select.id = "idMunicipalita"; //Recupero la SELECT
 	select.name="idMunicipalita";
	i = 0;
   	//indice utilizzato per i canili
   	k = 0;
   	//Azzero il contenuto della seconda select
	for (var j = select.length - 1; j >= 0; j--)
   		select.remove(j);
   	while(i < listaMunicipalita.length){
		var NewOpt = document.createElement('option');
 		NewOpt.value = listaMunicipalita[i].id;
 		NewOpt.text =  listaMunicipalita[i].nomeMunicipalita.replace('\uFFFD', 'à');
 		//Aggiungo l'elemento option
 		try{
			select.add(NewOpt, null); //Metodo Standard, non funziona con IE
 		}catch(e){
 			select.add(NewOpt); // Funziona solo con IE
 		}
 		i++;						   
 	}
 	if (select.length>0){
 		var tableRef = document.getElementById('cattura').getElementsByTagName('tbody')[0];
	 	// Insert a row in the table at the last row
 		var newRow   = tableRef.insertRow(tableRef.rows.length);
 		newRow.setAttribute('id','municip');
 		// Insert a cell in the row at index 0
 		var newCell  = newRow.insertCell(0);
	 	// Append a text node to the cell
	 	var newText  = document.createTextNode('Municipalita');
	 	newCell.className = "formLabel";
	 	newCell.appendChild(newText);
	 	var newCell1  = newRow.insertCell(1);
	 	newCell1.appendChild(select);
	 	var link = document.createElement("a");
	 	link.setAttribute("href", "javascript:apriPopup();");
	 	// For IE only, you can simply set the innerText of the node.
	 	// The below code, however, should work on all browsers.
	 	var linkText = document.createTextNode("Informazioni");
	 	link.appendChild(linkText);
	 	newCell1.appendChild(link);
  	}else{
  		var element =  document.getElementById('municip');
  		if (typeof(element) != 'undefined' && element != null){
  			element.style.display = 'none';
  		}
  	}
}
</script>

<%@ include file="../initPage.jsp"%>
<!-- 
<SCRIPT LANGUAGE="JavaScript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
</SCRIPT>
 -->

<script language="javascript">

function popUp(url) {
	title  = '_types';
	width  =  '500';
	height =  '600';
	resize =  'yes';
	bars   =  'no';
	url = url + '&idAsl=' + document.addAnimale.idAslRiferimento.value;
	var posx = (screen.width - width)/2;
	var posy = (screen.height - height)/2;
	var windowParams = 'scrollbars=yes ,WIDTH=' + width + ',HEIGHT=' + height + ',RESIZABLE=' + resize + ',SCROLLBARS=' + bars + ',STATUS=0,LEFT=' + posx + ',TOP=' + posy + 'screenX=' + posx + ',screenY=' + posy;
	var newwin=window.open(url, title, windowParams);
	newwin.focus();
	if (newwin != null) {
		if (newwin.opener == null)
	    	newwin.opener = self;
	}
}

function abilitaEsitiEhi(){
	if(document.getElementById('flagControlloEhrlichiosi')!=null){
		if(document.getElementById('flagControlloEhrlichiosi').checked){
			document.getElementById('esitoEhradd1').style.visibility="visible";
			//document.getElementById('esitoEhradd2').style.visibility="visible";
		}else{
			document.getElementById('esitoEhradd1').style.visibility="hidden";
			document.getElementById('dataControlloEhrlichiosi').value="";
			document.addAnimale.esitoControlloEhrlichiosi.value="-1";
			//document.getElementById('esitoEhradd2').style.visibility="hidden";
		}
	}
}

function abilitaEsitiRik(){
	if(document.getElementById('flagControlloRickettsiosi')!=null){
		if(document.getElementById('flagControlloRickettsiosi').checked ){
			document.getElementById('esitoRickadd1').style.visibility="visible";
		}else{
			document.getElementById('esitoRickadd1').style.visibility="hidden";
			document.getElementById('dataControlloRickettsiosi').value="";
			//document.addAnimale.esitoControlloRickettsiosi.value="-1";
		}
	}
}

function checkContributo(){

<%
//Flusso 251: disabilitazione flusso. Per disabilitarlo decommentare la riga "if true" e commentare quella seguente
//if(true)
if(User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")))
{
%>
	if(document.getElementById('flagContributoRegionale')!=null){
		if(document.getElementById('flagContributoRegionale').checked ){
			visualizzaPratiche();
			document.getElementById("pratica_contributo").style.visibility="visible";
		}
	}
<%
}
else
{
%>	
<!-- Flusso 251: modifiche del 03/08 - INIZIO -->
//if(document.getElementById('dataSterilizzazione')!=null && document.getElementById('dataSterilizzazione').value!=""){
		visualizzaPraticheLP();
		document.getElementById("pratica_contributo").style.visibility="visible";
//}
<!-- Flusso 251: modifiche del 03/08 - FINE -->
<%
}
%>
}

function doCheck(form){
	if (form.dosubmit.value == "false") {     
    	return true;
    } else {
    	return(checkForm(form));
   	}
}


function removNoDisplay(){
	var ele=null;
	
	document.getElementById("mancata_tracciabilita").style.removeProperty("display");
	$("#flagSenzaOrigine").removeAttr('checked');
	
	if(document.getElementById("provenienza_da_altra_nazione")!=null){
		// OSCURO NAZIONE ESTERA
		document.getElementById("provenienza_da_altra_nazione").style.display="none";
		document.getElementById("utProvenienzaEstera").style.display="none";
		$("#idNazioneProvenienza").val("-1");	 
		document.getElementById("noteNazioneProvenienza").value="";
		// OSCURO ANAGRAFE FUORI REGIONE
		document.getElementById("provenienza_da_altra_regione").style.removeProperty("display");
		$("#flagFuoriRegione").removeAttr('checked');			
		document.getElementById("utProvenienza").style.display="none";
		$("#idRegioneProvenienza").val("-1");	 
		document.getElementById("noteAnagrafeFr").value="";
	}
	// OSCURO EX PROPRIETARIO O RITROVAMENTO
	document.getElementById("provenienza_soggetto_ritrovamento").style.removeProperty("display");
	document.getElementById("radio_tipo_origine").style.display="none";
	ele = document.getElementsByName("origine_da");
	for(var i=0;i<ele.length;i++)
		ele[i].checked = false;
	ele = document.getElementsByName("tipo_origine");
	for(var i=0;i<ele.length;i++)
		ele[i].checked = false;
	
	document.getElementById("proprietarioProvenienza").style.display="none";
   	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
    document.getElementById("microchipMadreDiv").style.display="none";
<%}%>
	document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
	 
	document.getElementById("dati_ritrovamento").style.removeProperty("display");
	document.getElementById("provincia_ritrovamentoinput").value="";
	document.getElementById("comune_ritrovamentoinput").value="";
	$('select[name="provincia_ritrovamento"]').val("");
	$('select[name="comune_ritrovamento"]').val("");
	document.getElementById("indirizzo_ritrovamento").value="";
	document.getElementById("data_ritrovamento").value="";
	// OSCURO ACQUISTO SU SITO WEB
					<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

	document.getElementById("mostraAcquistoOnline").style.removeProperty("display");
	$("#flagAcquistoOnline").removeAttr('checked');			
	$("#sitoWebAcquisto").val("-1");	 
	document.getElementById("sitoWebAcquisto_hidden").value="";	
	 document.getElementById("noteAcquistoOnline").style.display="none";
	 document.getElementById("noteAcquistoOnline").value="";<%}%>
}


function CheckGenericoOrigineAnimale(evt){
	var ele=null;
	if(evt.id == "flagSenzaOrigine"){
		if(evt.checked){
			alert("ATTENZIONE! Iscrizione in banca dati di cane privo di tracciabilità.");
			if(document.getElementById("provenienza_da_altra_nazione")!=null){
				// OSCURO NAZIONE ESTERA
				document.getElementById("provenienza_da_altra_nazione").style.display="none";
				document.getElementById("utProvenienzaEstera").style.display="none";
				$("#idNazioneProvenienza").val("-1");	 
				document.getElementById("noteNazioneProvenienza").value="";
				// OSCURO ANAGRAFE FUORI REGIONE
				document.getElementById("provenienza_da_altra_regione").style.display="none";
				$("#flagFuoriRegione").removeAttr('checked');			
				document.getElementById("utProvenienza").style.display="none";
				$("#idRegioneProvenienza").val("-1");	 
				document.getElementById("noteAnagrafeFr").value="";
				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

				document.getElementById("microchipMadre").value='';
				  document.getElementById("idProprietarioProvenienza").value='-1';
				  document.getElementById("cfProv").value='';
				  document.getElementById("ragioneSocialeProv").value='';
					document.getElementById("idAnimaleMadre").value='-1';

				  <%}%>
				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
				document.getElementById("mostraAcquistoOnline").style.display="none";
<%}%>
			}
			// OSCURO EX PROPRIETARIO O RITROVAMENTO
			document.getElementById("provenienza_soggetto_ritrovamento").style.display="none";
			document.getElementById("radio_tipo_origine").style.display="none";
			ele = document.getElementsByName("origine_da");
			for(var i=0;i<ele.length;i++)
				ele[i].checked = false;
			ele = document.getElementsByName("tipo_origine");
			for(var i=0;i<ele.length;i++)
				ele[i].checked = false;
			
			document.getElementById("proprietarioProvenienza").style.display="none";
		   	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

		    document.getElementById("microchipMadreDiv").style.display="none";
		    <%}%>
			document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
			
			document.getElementById("dati_ritrovamento").style.display="none";
			if(document.getElementById("provincia_ritrovamentoinput")!=null) document.getElementById("provincia_ritrovamentoinput").value="";
			if(document.getElementById("comune_ritrovamentoinput")!=null)    document.getElementById("comune_ritrovamentoinput").value="";
			$('select[name="provincia_ritrovamento"]').val("");
			$('select[name="comune_ritrovamento"]').val("");
			document.getElementById("indirizzo_ritrovamento").value="";
			document.getElementById("data_ritrovamento").value="";
			
			// OSCURO ACQUISTO SU SITO WEB
							<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
			document.getElementById("mostraAcquistoOnline").style.display="none";
			$("#flagAcquistoOnline").removeAttr('checked');			
			$("#sitoWebAcquisto").val("-1");	 
			document.getElementById("sitoWebAcquisto_hidden").value="";	
			 document.getElementById("noteAcquistoOnline").style.display="none";
			 document.getElementById("noteAcquistoOnline").value="";
<%}%>
		}else{
			removNoDisplay();
		}
		
	}else if(evt.id == "flagFuoriNazione"){
		if(evt.checked){
			document.getElementById("utProvenienzaEstera").style.removeProperty("display");
			<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
			document.getElementById("microchipMadreDiv").style.removeProperty("display");
			document.getElementById("proprietarioProvenienza").style.removeProperty("display");
			<%}%>

			// OSCURO ANAGRAFE FUORI REGIONE
			document.getElementById("provenienza_da_altra_regione").style.display="none";
			$("#flagFuoriRegione").removeAttr('checked');			
			document.getElementById("utProvenienza").style.display="none";
			$("#idRegioneProvenienza").val("-1");	 
			document.getElementById("noteAnagrafeFr").value="";
			// OSCURO EX PROPRIETARIO O RITROVAMENTO
			document.getElementById("provenienza_soggetto_ritrovamento").style.display="none";
			document.getElementById("radio_tipo_origine").style.display="none";
			ele = document.getElementsByName("origine_da");
			for(var i=0;i<ele.length;i++)
				ele[i].checked = false;
			ele = document.getElementsByName("tipo_origine");
			for(var i=0;i<ele.length;i++)
				ele[i].checked = false;
			
			document.getElementById("proprietarioProvenienza").style.display="none";
		 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

		    document.getElementById("microchipMadreDiv").style.display="none";
		    <%}%>

			document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
			 
			document.getElementById("dati_ritrovamento").style.display="none";
			document.getElementById("provincia_ritrovamentoinput").value="";
			document.getElementById("comune_ritrovamentoinput").value="";
			$('select[name="provincia_ritrovamento"]').val("");
			$('select[name="comune_ritrovamento"]').val("");
						document.getElementById("indirizzo_ritrovamento").value="";
			document.getElementById("data_ritrovamento").value="";
		}else{
			removNoDisplay();
		}
	}else if(evt.id == "flagFuoriRegione"){
		if(evt.checked){
			document.getElementById("origine_table").style.display="none";
			document.getElementById("utProvenienza").style.removeProperty("display");
			// OSCURO NAZIONE ESTERA
			document.getElementById("provenienza_da_altra_nazione").style.display="none";
			document.getElementById("utProvenienzaEstera").style.display="none";
			$("#idNazioneProvenienza").val("-1");	 
			document.getElementById("noteNazioneProvenienza").value="";
			// OSCURO EX PROPRIETARIO O RITROVAMENTO
			document.getElementById("provenienza_soggetto_ritrovamento").style.display="none";
			document.getElementById("radio_tipo_origine").style.display="none";
			ele = document.getElementsByName("origine_da");
			for(var i=0;i<ele.length;i++)
				ele[i].checked = false;
			ele = document.getElementsByName("tipo_origine");
			for(var i=0;i<ele.length;i++)
				ele[i].checked = false;
			
			document.getElementById("proprietarioProvenienza").style.display="none";
		 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

		    document.getElementById("microchipMadreDiv").style.display="none";
		    <%}%>

			document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
			 
			document.getElementById("dati_ritrovamento").style.display="none";
			document.getElementById("provincia_ritrovamentoinput").value="";
			document.getElementById("comune_ritrovamentoinput").value="";
			$('select[name="provincia_ritrovamento"]').val("");
			$('select[name="comune_ritrovamento"]').val("");
						document.getElementById("indirizzo_ritrovamento").value="";
			document.getElementById("data_ritrovamento").value="";
			<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

			document.getElementById("mostraAcquistoOnline").style.display="none";
			$("#flagAcquistoOnline").removeAttr('checked');
			document.getElementById("utProvenienzaOnline").style.display="none";
			document.getElementById("sitoWebAcquisto").value="-1";
			document.getElementById("sitoWebAcquisto_hidden").value="";
			 document.getElementById("noteAcquistoOnline").style.display="none";
			 document.getElementById("noteAcquistoOnline").value="";
			<%}%>
			document.getElementById("mancata_tracciabilita").style.display="none";
			$("#flagSenzaOrigine").removeAttr('checked');
		}else{
			mostraOrigine();
			removNoDisplay();
		}
	}else if(evt.id == "origine_da"){
		if(evt.checked){
		<% if(!ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
			if(evt.value=="in_regione"){
				 document.getElementById("ricerca_fr").style.removeProperty("display");
				 
			}
			else{
				 document.getElementById("ricerca_fr").style.display="none";
			}
			<%}%>
			
			document.getElementById("provenienza_soggetto_ritrovamento").style.removeProperty("display");
			document.getElementById("radio_tipo_origine").style.removeProperty("display");
			<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

			document.getElementById("mostraAcquistoOnline").style.removeProperty("display");
			$("#flagAcquistoOnline").removeAttr('checked');
			document.getElementById("utProvenienzaOnline").style.display="none";
			document.getElementById("sitoWebAcquisto").value="-1";
			document.getElementById("sitoWebAcquisto_hidden").value="";
			 document.getElementById("noteAcquistoOnline").style.display="none";
			 document.getElementById("noteAcquistoOnline").value="";
			<%}%>
			
			var ele = document.getElementsByName("tipo_origine");
			for(var i=0;i<ele.length;i++)
				ele[i].checked = false;
			    
			document.getElementById("proprietarioProvenienza").style.display="none";
		 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

		    document.getElementById("microchipMadreDiv").style.display="none";
		    <%}%>

			document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
			 
			document.getElementById("dati_ritrovamento").style.display="none";
			document.getElementById("provincia_ritrovamentoinput").value="";
			document.getElementById("comune_ritrovamentoinput").value="";
			$('select[name="provincia_ritrovamento"]').val("");
			$('select[name="comune_ritrovamento"]').val("");
			document.getElementById("indirizzo_ritrovamento").value="";
			document.getElementById("data_ritrovamento").value="";
			if(document.getElementById("provenienza_da_altra_nazione")!=null){
				// OSCURO NAZIONE ESTERA
				document.getElementById("provenienza_da_altra_nazione").style.display="none";
				document.getElementById("utProvenienzaEstera").style.display="none";
				$("#idNazioneProvenienza").val("-1");	 
				document.getElementById("noteNazioneProvenienza").value="";
				//OSCURO ANAGRAFE FUORI REGIONE
				document.getElementById("provenienza_da_altra_regione").style.display="none";
				$("#flagFuoriRegione").removeAttr('checked');			
				document.getElementById("utProvenienza").style.display="none";
				$("#idRegioneProvenienza").val("-1");	 
				document.getElementById("noteAnagrafeFr").value="";
			}
			// OSCURO EX PROPRIETARIO O RITROVAMENTO
				
			
			document.getElementById("proprietarioProvenienza").style.display="none";
		 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

		    document.getElementById("microchipMadreDiv").style.display="none";
		    <%}%>

			document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
			 
			document.getElementById("dati_ritrovamento").style.display="none";
			document.getElementById("provincia_ritrovamentoinput").value="";
			document.getElementById("comune_ritrovamentoinput").value="";
			$('select[name="provincia_ritrovamento"]').val("");
			$('select[name="comune_ritrovamento"]').val("");
			document.getElementById("indirizzo_ritrovamento").value="";
			document.getElementById("data_ritrovamento").value="";
			if(evt.value=="nazione_estera"){
				document.getElementById("radio_tipo_origine").style.display="none";
				document.getElementById("provenienza_da_altra_nazione").style.removeProperty("display");
				document.getElementById("utProvenienzaEstera").style.removeProperty("display");
				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
				document.getElementById("microchipMadreDiv").style.removeProperty("display");
				document.getElementById("proprietarioProvenienza").style.removeProperty("display");
	<%}%>
				$("#idNazioneProvenienza").val("-1");	 
				document.getElementById("noteNazioneProvenienza").value="";


			}
			
		}
	}else if(evt.id == "tipo_origine"){
		if(evt.checked){
			if(evt.value=="ritrovamento"){
				document.getElementById("proprietarioProvenienza").style.display="none";
			 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

			    document.getElementById("microchipMadreDiv").style.display="none";
			    <%}%>

				document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
				
				document.getElementById("dati_ritrovamento").style.removeProperty("display");
				document.getElementById("provincia_ritrovamentoinput").value="";
				document.getElementById("comune_ritrovamentoinput").value="";
				$('select[name="provincia_ritrovamento"]').val("");
				$('select[name="comune_ritrovamento"]').val("");
				document.getElementById("indirizzo_ritrovamento").value="";
				document.getElementById("data_ritrovamento").value="";
				
				document.getElementById("provenienza_da_altra_nazione").style.display="none";
				document.getElementById("utProvenienzaEstera").style.display="none";
				$("#idNazioneProvenienza").val("-1");	 
				document.getElementById("noteNazioneProvenienza").value="";
				 // OSCURO ACQUISTO SU SITO WEB
				 				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

				document.getElementById("mostraAcquistoOnline").style.display="none";
				$("#flagAcquistoOnline").removeAttr('checked');			
				$("#sitoWebAcquisto").val("-1");	 
				document.getElementById("sitoWebAcquisto_hidden").value="";
				 document.getElementById("noteAcquistoOnline").style.display="none";
				 document.getElementById("noteAcquistoOnline").value="";
				<%}%>
			}else if(evt.value=="soggetto_fisico"){
				document.getElementById("proprietarioProvenienza").style.removeProperty("display");
			 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

			    document.getElementById("microchipMadreDiv").style.removeProperty("display");
			    <%}%>

				document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
				
				document.getElementById("dati_ritrovamento").style.display="none";
				document.getElementById("provincia_ritrovamentoinput").value="";
				document.getElementById("comune_ritrovamentoinput").value="";
				$('select[name="provincia_ritrovamento"]').val("");
				$('select[name="comune_ritrovamento"]').val("");
				document.getElementById("indirizzo_ritrovamento").value="";
				document.getElementById("data_ritrovamento").value="";
				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

				document.getElementById("mostraAcquistoOnline").style.removeProperty("display");
				<%}%>
				document.getElementById("provenienza_da_altra_nazione").style.display="none";
				document.getElementById("utProvenienzaEstera").style.display="none";
				$("#idNazioneProvenienza").val("-1");	 
				document.getElementById("noteNazioneProvenienza").value="";
				
			}else{
				document.getElementById("dati_ritrovamento").style.display="none";
				document.getElementById("provincia_ritrovamentoinput").value="";
				document.getElementById("comune_ritrovamentoinput").value="";
				$('select[name="provincia_ritrovamento"]').val("");
				$('select[name="comune_ritrovamento"]').val("");
				document.getElementById("indirizzo_ritrovamento").value="";
				document.getElementById("data_ritrovamento").value="";
				
				document.getElementById("proprietarioProvenienza").style.removeProperty("display");
			    
			 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

				document.getElementById("microchipMadreDiv").style.removeProperty("display");
			    <%}%>

				document.getElementById("idProprietarioProvenienza").value="-1"; document.getElementById("nome_proprietario_provenienza").innerHTML="";
				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
				document.getElementById("mostraAcquistoOnline").style.removeProperty("display");
				<%}%>
				document.getElementById("provenienza_da_altra_nazione").style.removeProperty("display");
				document.getElementById("utProvenienzaEstera").style.removeProperty("display");
			}						
		}
	}else{ 
		<% if(true){ %>

		if(evt.id == "flagAcquistoOnline"){
		if(evt.checked){
				abilitaNoteOnline();
				document.getElementById("mostraAcquistoOnline").style.removeProperty("display");
				document.getElementById("utProvenienzaOnline").style.removeProperty("display");
			}else{
				$("#flagAcquistoOnline").removeAttr('checked');			
				document.getElementById("utProvenienzaOnline").style.display="none";
				$("#sitoWebAcquisto").val("-1");	 
				document.getElementById("sitoWebAcquisto_hidden").value="";	
				 document.getElementById("noteAcquistoOnline").style.display="none";
				 document.getElementById("noteAcquistoOnline").value="";
			}						
		}<%}%>}
}

function  inserisciInformazioniAttivitaItinerante(){
	if (document.addAnimale.flagAttivitaItinerante != null && document.addAnimale.flagAttivitaItinerante.checked){
		document.getElementById("attivitaItinerante").style.visibility="visible";
		$( "#flagFuoriRegione_propr" ).prop( "checked", false );
		$( "#flagFuoriRegione_propr" ).prop( "disabled", true );
	} else {
		document.getElementById("luogoAttivitaItinerante").value = '';
		document.getElementById("idComuneAttivitaItinerante").value = '-1';
		$("#idProprietario").val('-1');
		$("#nomeProprietario").html('');
		$("#idDetentore").val('-1');
		$("#nomeDetentore").html('');
		$( "#flagFuoriRegione_propr" ).prop( "disabled", false );
		document.getElementById("attivitaItinerante").style.visibility="hidden";
  	}
}

function abilitaSelezionePropDet(idAsl) {
	if(document.getElementById('flagSindacoFuoriRegione') != null && document.getElementById('flagSindacoFuoriRegione').checked){
		document.getElementById("origine_da").style.display = "none";
	}else{
		document.getElementById("origine_da").style.removeProperty("display");	
	}
}

function checkMorsicatore() {
	if (document.addAnimale.flagMorsicatore.checked){
		document.getElementById("mors").style.visibility="visible";
  	} else {
  		document.getElementById("mors").style.visibility="hidden";
  	}
}

function checkSpecieAnimale(obj){
	document.forms[0].doContinue.value = 'false';
	document.forms[0].submit();
}

function openRichiesta(idAnimale, idSpecie){
	var res;
	var result;
	window.open('AnimaleAction.do?command=PrintRichiestaIscrizione&idAnimale='+idAnimale+'&idSpecie='+idSpecie,'popupSelect',
	'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}

function openCertificato(idAnimale, idSpecie){
	var res;
	var result;
	window.open('AnimaleAction.do?command=PrintCertificatoIscrizione&idAnimale='+idAnimale+'&idSpecie='+idSpecie,'popupSelect',
	'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}

function openObblighi(){
	var res;
	var result;
	window.open('anagrafe_animali/documenti/obblighi_legge_proprietario.jsp','popupSelect',
	'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}

function openCampioni(idAnimale, idSpecie){
	var res;
	var result;
	window.open('AnimaleAction.do?command=PrintRichiestaCampioni&idAnimale='+idAnimale+'&idSpecie='+idSpecie,'popupSelect',
	'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}

function openCampioniRabbia(idAnimale, idSpecie){
	var res;
	var result;
	window.open('AnimaleAction.do?command=PrintRichiestaCampioniRabbia&idAnimale='+idAnimale+'&idSpecie='+idSpecie,'popupSelect',
	'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}


function getFiltroDetentore()
{
	var gattiSuColonie = false;
	lineaProduttivaFiltroDetentore = "&idLineaProduttiva1=5";
	
	if(gattiSuColonie)
	{
		lineaSindaco = false;
		if(document.addAnimale.idProprietario.value!=null && 
				   document.addAnimale.idProprietario.value!="" && 
				   document.addAnimale.idProprietario.value!="null" )
			{
		LineaProduttiva.verificaProprietarioSindaco(document.addAnimale.idProprietario.value, {
			callback:function(data) {
				lineaSindaco= data;
			},
			timeout:8000,
			async:false
			});
		
			}
		if(document.addAnimale.idSpecie!=null &&
		   document.addAnimale.idSpecie.value=='2' && 
		   document.addAnimale.idProprietario.value!=null && 
		   document.addAnimale.idProprietario.value!="" && 
		   document.addAnimale.idProprietario.value!="null" && 
		   lineaSindaco)
		{
			lineaProduttivaFiltroDetentore = "&idLineaProduttiva1=5;8";
		}
	
	}
	
	return lineaProduttivaFiltroDetentore;
}


</script>

<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
		<dhv:evaluate if="<%=(origine==null || origine.equals(""))%>">
			<td width="100%">
				<a href="AnimaleAction.do"><dhv:label name="anagrafica.animale">Animale</dhv:label></a> > 
				<dhv:label name="anagrafica.animale.aggiungi">Aggiungi</dhv:label>
			</td>
		</dhv:evaluate>
		<dhv:evaluate if="<%=(origine.equals("operatore"))%>">
		<!--  SE PROVENGO DAl DETTAGLIO OPERATORE LASCIA IL RIFERIMENTO -->
			<td width="100%"><a href="OperatoreAction.do?command=Details&opId=<%=opId %>">
				<dhv:label name="anagrafica.animale">Dettaglio Operatore</dhv:label></a> > 
				<dhv:label name="anagrafica.animale.aggiungi">Aggiungi animale</dhv:label>
			</td>
		</dhv:evaluate>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>

<body onLoad="abilitaEsitiEhi(); abilitaEsitiRik();checkContributo();">
<font color="red"><%=(request.getAttribute("error")!=null)?((String)request.getAttribute("error")):("") %></font>
<form name="addAnimale"	action="AnimaleAction.do?command=Insert&auto-populate=true<%=addLinkParams(request, "popup|popupType|actionId")%>"	method="post">
	<input type="hidden" id="datacorrente" name="datacorrente" value="<%=currentDate%>"> 
	<input type="hidden" name="ruolo" value="<%=User.getRoleId()%>"> <%
	
	
			
			
			String lineaProduttivaFiltro = "";
	if (animale.getIdSpecie() == Furetto.idSpecie)
		lineaProduttivaFiltro = "idLineaProduttiva1=1;4";
	else
		lineaProduttivaFiltro = "idLineaProduttiva=1";
	
 	if (User.getRoleId() == 24) { %> 
 		<input type="hidden" name="idTipologiaSoggettoSterilizzante" value="2" id="idTipologiaSoggettoSterilizzante" /> 
 		<!-- LLPP --> 
 		<input type="hidden" name="idSoggettoSterilizzante"	id="idSoggettoSterilizzante" value="<%=User.getUserId()%>" /> 
 		<!-- ID VETERINARIO -->
<%	} else {
%> 		<input type="hidden" name="idTipologiaSoggettoSterilizzante" value="1" id="idTipologiaSoggettoSterilizzante" /> 
		<!-- ASL --> 
		<input type="hidden" name="idSoggettoSterilizzante"	id="idSoggettoSterilizzante" value="<%=User.getSiteId()%>" /> 
		<!-- ID ASL -->
<%	} %>
	<input type="hidden" name="customerSatisfaction" id ="customerSatisfaction" value = "si">
	
	<table class="">
		
		<input type="button" value="<dhv:label name="global.button.save">Save</dhv:label>"
		onClick="verificaMicrochipMadre(document.forms[0].microchipMadre);this.form.dosubmit.value='true';this.form.saveandclone.value='';if(doCheck(this.form)){setTimestampStartRichiesta();this.form.submit()};" />
		
		<dhv:evaluate if="<%=session.getAttribute("caller")==null || !ApplicationProperties.getProperty("VAM_ID").equals(session.getAttribute("caller")) %>" >
			<input type="button" value="Salva e Clona" onClick="verificaMicrochipMadre(document.forms[0].microchipMadre);this.form.dosubmit.value='true';this.form.saveandclone.value='1';if(doCheck(this.form)){setTimestampStartRichiesta();this.form.submit()};" />
		</dhv:evaluate>
		
		<dhv:evaluate if="<%=(origine==null || origine.equals(""))%>">
			<input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>"	onClick="window.location.href='AnimaleAction.do';this.form.dosubmit.value='false';" />
		</dhv:evaluate>
				
		<dhv:evaluate if="<%=(origine.equals("operatore"))%>">
			<!--  SE PROVENGO DAl DETTAGLIO OPERATORE LASCIA IL RIFERIMENTO -->
			<input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="window.location.href='OperatoreAction.do?command=Details&opId=<%=opId %>';this.form.dosubmit.value='false';" />
		</dhv:evaluate>
			
		<%if (request.getAttribute("SalvaeClona")!=null){ %>
			<font color = "green">Animale con mc <%=animale.getMicrochip()  %> Salvato Correttamente 
			<dhv:permission name="anagrafe_canina-documenti-view">
				<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16" />
				<a href="#" onclick="openRichiestaPDF('PrintRichiestaIscrizione','<%=animale.getIdAnimale()%>','<%=animale.getIdSpecie()%>', '-1', '-1', '-1');" id="" target="_self">Richiesta prima iscrizione</a>
				<dhv:evaluate if="<%=(animale.getIdAslRiferimento() != Constants.ID_ASL_FUORI_REGIONE)%>">
				
				
<%
				Boolean esisteRegistroSanzioneProprietario_privoTracciabilita = null;
				System.out.println("REGISTRO DEBUG: "+request.getAttribute("esisteRegistroSanzioneProprietario_privoTracciabilita"));

				if (request.getAttribute("esisteRegistroSanzioneProprietario_privoTracciabilita") !=null)
				{
					esisteRegistroSanzioneProprietario_privoTracciabilita = (Boolean)request.getAttribute("esisteRegistroSanzioneProprietario_privoTracciabilita");
				}
				else
				{
					esisteRegistroSanzioneProprietario_privoTracciabilita = false;
				}
				
				Boolean esisteRegistroSanzioneProprietario_fuorinazione = null;
				if (request.getAttribute("esisteRegistroSanzioneProprietario_fuorinazione") !=null)
				{
					esisteRegistroSanzioneProprietario_fuorinazione = (Boolean)request.getAttribute("esisteRegistroSanzioneProprietario_fuorinazione");
				}
				else
				{
					esisteRegistroSanzioneProprietario_fuorinazione = false;
				}
					
				
				Boolean esisteRegistroSanzioneCedente = null;
				if (request.getAttribute("esisteRegistroSanzioneCedente") !=null)
				{
				 	esisteRegistroSanzioneCedente = (Boolean)request.getAttribute("esisteRegistroSanzioneCedente");
				}
				else
				{
					esisteRegistroSanzioneCedente = false;
				}
				
%>
				
				<dhv:evaluate if="<%=((!esisteRegistroSanzioneProprietario_privoTracciabilita && !esisteRegistroSanzioneProprietario_fuorinazione && !esisteRegistroSanzioneCedente)) %>">
					<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16" />
					<a href="#" onclick="openCertificato('<%=animale.getIdAnimale()%>','<%=animale.getIdSpecie()%>');" id="" target="_self">Certificato di Iscrizione</a>
				</dhv:evaluate>	
					
					<img src="images/icons/stock_print-16.gif" border="0"	align="absmiddle" height="16" width="16" />
					<a href="#"	onclick="openCampioni('<%=animale.getIdAnimale()%>','<%=animale.getIdSpecie()%>');"	id="" target="_self">Scheda invio campioni</a>
				</dhv:evaluate>
			</dhv:permission>
			</font>
		<%} %>

		<table  cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
			<input type="hidden" value="<%=session.getAttribute("caller") %>" name="origineInserimento" id="origineInserimento" />
			<tr >
				<th colspan="2"><strong><dhv:label name="accounts.accountasset_include.SpecificInformation">Specific Information</dhv:label></strong></th>
			</tr>
			<dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))
				&& User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")) 
				&& User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) 
				&& User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2")) 
				//&& User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_ANAGRAFE_CANINA"))
			)%>">
				<tr id="aslRif">
					<td class="formLabel" nowrap><dhv:label name="">Asl di Riferimento</dhv:label></td>
					<td>
						<%	
							if (User.getSiteId() == -1) 
							{
								out.print(AslList.getSelectedValue(animale.getIdAslRiferimento()));
%>
	 							<input type="hidden" size="30" id="idAslRiferimento" name="idAslRiferimento" value="<%=animale.getIdAslRiferimento()%>"> 
<%
							} 
							else 
							{
								int idAslAnimale = User.getSiteId();
								if(animale.isFlagAttivitaItinerante())
									idAslAnimale = animale.getIdAslRiferimento();
 								out.print(AslList.getSelectedValue(idAslAnimale));
 %>
 								<input type="hidden" size="30" id="idAslRiferimento" name="idAslRiferimento" value="<%=idAslAnimale%>">
<%
							}
%>
					</td>
				</tr>
			</dhv:evaluate>

			<tr>
				<td class="formLabel" nowrap><dhv:label name="">Specie animale</dhv:label></td>
				<td>
					<dhv:evaluate if='<%=(animale.getIdProprietario() > 0)%>'>
						<%=specieList.getSelectedValue(animale.getIdSpecie())%>
						<input type="hidden" value="<%=animale.getIdSpecie()%>" name="idSpecie" id="idSpecie" />
					</dhv:evaluate> 
					<dhv:evaluate if='<%=!(animale.getIdProprietario() > 0)%>'>
						<%	specieList.setJsEvent("onChange=\"javascript:checkSpecieAnimale(this);\"");	%>
						<%=specieList.getHtmlSelect("idSpecie", animale.getIdSpecie())%>
					</dhv:evaluate>
				</td>
			</tr>
			
			<dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) && User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">	
				<tr id="attivitaItinerantetr">
					<td class="formLabel" nowrap><dhv:label name="">Anagrafe effettuata in attività itinerante</dhv:label></td>
					<td>
						<input type="checkbox" id="flagAttivitaItinerante" name="flagAttivitaItinerante" onclick="inserisciInformazioniAttivitaItinerante()" name="flagAttivitaItinerante"
						<%if (animale != null && animale.isFlagAttivitaItinerante()) {%> checked="checked" <%}%> />
						<div id="attivitaItinerante" <%=(animale != null && animale.isFlagAttivitaItinerante()) ? ("") : ("style=\"visibility:hidden\"")%>>
							Comune: <%=comuniList_asl.getHtmlSelect("idComuneAttivitaItinerante", animale.getIdComuneAttivitaItinerante())%><font color="red">*</font> 
							Luogo: <input type="text" name="luogoAttivitaItinerante"	id="luogoAttivitaItinerante"	value="<%=animale.getLuogoAttivitaItinerante()%>"/>
						</div>		
					</td>
				</tr>
			</dhv:evaluate>
			
			
			<% if(User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))
				&& User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA"))){%>
			<!--  SEZIONE PROVENIENZA ALTRA ANAGRAFICA REGIONALE -->
			<tr  id="provenienza_da_altra_regione" class="containerBody">
				<td class="formLabel"><dhv:label name="">Provenienza da anagrafe altra regione</dhv:label></td>
				<td>
					<input type="checkbox" id="flagFuoriRegione"	onclick="if(this.checked){alert('Attenzione! Flag da attivare esclusivamente per registrare animali gi&agrave; provvisti di microchip, provenienti da altra regione o stato estero.');} nascondiVetChippatore(this,document.getElementById('idVeterinarioMicrochip'));CheckGenericoOrigineAnimale(this);verificaInserimentoAnimale(document.forms[0].microchip);" name="flagFuoriRegione"
					<%if (animale != null && Cane.isFlagFuoriRegione()) {%>	checked="checked" <%}%> />
					<div id="utProvenienza"	
						<%=(animale != null && Cane.getIdRegioneProvenienza() != -1) ? ("")	: ("style=\"display:none\"")%>>
						<%=regioniList.getHtmlSelect("idRegioneProvenienza",Cane.getIdRegioneProvenienza())%><font color="red">&nbsp;*</font> 
						<input type="hidden" id="verDate" name="verDate" value="ok" />
						<br><textarea rows="4" cols="50" id="noteAnagrafeFr" name="noteAnagrafeFr"><%=((String)request.getAttribute("noteAnagrafeFr")!=null ? (String)request.getAttribute("noteAnagrafeFr") : "")%></textarea>
						
						</div>
				</td>
			</tr>
			<% }else{ %>
  				<input type="hidden" id="provenienza_da_altra_regione"/>
  				<input type="hidden" id="flagFuoriRegione" /> 
  				<input type="hidden" id="utProvenienza" /> 
  				<input type="hidden" id="idRegioneProvenienza" value="-1" />
  				<input type="hidden" id="noteAnagrafeFr" value=""/>
			<% } %>
			
  
  		<tr class="containerBody">
			<td class="formLabel"><dhv:label name="">Data Registrazione</dhv:label>
			</td>


			<td><input class="date_picker" type="text" name="dataRegistrazione" id= "dataRegistrazione"
				size="10" value="<%=toDateString(animale.getDataRegistrazione())%>"
				nomecampo="registrazione" tipocontrollo="T2,T6,T7,T18"
				labelcampo="Data Registrazione" />&nbsp;<font color="red">* Data riportata
			dal documento.</font></td>
		</tr>		





<%
if (!ApplicationProperties.getProperty("ID_RUOLO_LLP").equals(User.getRoleId()+"") && !ApplicationProperties.getProperty("UNINA").equals(User.getRoleId()+"")) 
{ 
%> 
<tr class="containerBody">
				<td class="formLabel"><dhv:label name="">Residenza proprietario fuori regione</dhv:label>
				</td>
				<td >
				<% 	Stabilimento stabPropr = new Stabilimento();
				String check="";
				if(animale != null	&& animale.getProprietario() != null && animale.getProprietario().getIdOperatore() > 0
						&&  animale.getProprietario().getListaStabilimenti()!=null )
					stabPropr= (Stabilimento)(animale.getProprietario().getListaStabilimenti()).get(0);
				if (stabPropr.isFlagFuoriRegione() || stabPropr.getIdAsl()== Integer.parseInt(ApplicationProperties.getProperty("ID_ASL_FUORI_REGIONE")))
					check="checked=checked";
				%>
				
			
				<input type="checkbox" id="flagFuoriRegione_propr" name="flagFuoriRegione_propr" 
				<%=check %> />

				</td>

</tr>

<%
}
%>

		<tr class="containerBody" id="proprietario">
			<td class="formLabel" nowrap><dhv:label name="">Seleziona Proprietario</dhv:label>
			</td>
			<td>
			<table cellspacing="0" border="0" width="100%" class="details">
			<%int idTipologiaLineaProdProprietario = -1;
			Stabilimento stabProprietario = new Stabilimento();
			  %>
				<dhv:evaluate
					if="<%=(animale != null
										&& animale.getProprietario() != null && animale
										.getProprietario().getIdOperatore() > 0)%>">
								<%idTipologiaLineaProdProprietario = ((LineaProduttiva) (((Stabilimento) animale
										.getProprietario().getListaStabilimenti()
										.get(0)).getListaLineeProduttive().get(0))).getIdRelazioneAttivita(); 
										stabProprietario = (Stabilimento) animale
										.getProprietario().getListaStabilimenti()
										.get(0); //STABILIMENTO PER EVENTULE COMUNE CATTURA%>
					<input type="hidden" id="tipologia_proprietario" value="<%=idTipologiaLineaProdProprietario%>"/>

					<tr>

						<td id="nomeProprietario"><%=toHtml(animale.getProprietario()
										.getRagioneSociale())%></td>
					</tr>
					<input type="hidden" name="idProprietario" id="idProprietario"
						value="<%=(animale.getProprietario() != null) ? ((LineaProduttiva) (((Stabilimento) animale
								.getProprietario().getListaStabilimenti()
								.get(0)).getListaLineeProduttive().get(0)))
								.getId()
								: ""%>">
								
								
								<input type="hidden" name="idComuneProprietario" id="idComuneProprietario" value="<%=(stabProprietario!=null && stabProprietario.getSedeOperativa()!=null)?(stabProprietario.getSedeOperativa().getComune()):("")%>">
								
								<!-- Sovrascrivo valore asl con quello del proprietario se il ruolo di chi sta inserendo lo prevede -->
					<dhv:evaluate
						if="<%=Animale
											.setAslRiferimentoAnimaleByRole(User)%>">
						<input type="hidden" name="idAslRiferimento" id="idAslRiferimento"
							value="<%=(animale.getProprietario() != null) ? ((Stabilimento) animale
									.getProprietario().getListaStabilimenti()
									.get(0)).getIdAsl()
									: "-1"%>">

					</dhv:evaluate>

				</dhv:evaluate>


				<tr>
					<td><dhv:evaluate
						if="<%=(
								//User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) && 
								User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
						
						<a onclick="win_open_search_proprietario('1','true');return false;">Ricerca</a>
						<a onclick="win_open_add_proprietario('1','true','1');return false;">Aggiungi</a>
							
						<!-- <a
						href="javascript:popUp('OperatoreAction.do?command=SearchForm&tipologiaSoggetto=1&popup=true');">Ricerca</a> -->
					</dhv:evaluate> <dhv:evaluate if="<%=(
							//User.getRoleId() ==  new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) || 
							User.getRoleId() ==  new Integer(ApplicationProperties.getProperty("UNINA")))%>">
					<%-- 	<a
							onclick="window.open('OperatoreAction.do?estero=no&in_regione=si&command=SearchForm&tipologiaSoggetto=1&popup=true','','width=800,height=600');return false;"
							href="OperatoreAction.do?command=SearchForm&tipologiaSoggetto=1&popup=true">Ricerca</a>
						<a onclick="window.open('OperatoreAction.do?estero=no&in_regione=si&command=Add&tipologiaSoggetto=1&<%=lineaProduttivaFiltro%>&popup=true&idLineaProduttiva=1','','scrollbars=1,width=800,height=600');return false;"
							href="OperatoreAction.do?command=Add&tipologiaSoggetto=2&<%=lineaProduttivaFiltro%>&popup=true&idLineaProduttiva=1">Aggiungi</a>
				 --%>			
						<a onclick="win_open_search_proprietario('1','true');return false;">Ricerca</a>
						<a onclick="win_open_add_proprietario('1','true','1');return false;">Aggiungi</a>
							
							
						<!--<a href="javascript:popUp('OperatoreAction.do?command=SearchForm&tipologiaSoggetto=1&popup=true&idLineaProduttiva1=1');">Ricerca</a> -->
					</dhv:evaluate>
					</td>
				</tr>
			</table>

			<dhv:evaluate
				if="<%=(animale.getProprietario() == null || (animale
								.getProprietario() != null && animale
								.getProprietario().getIdOperatore() <= 0))%>">
				<input type="hidden" name="idProprietario" id="idProprietario"
					value="-1">
			</dhv:evaluate></td>

		</tr>

		<%
			int idDetentore = -1;
			String nomeDetentore = "";
			int idTipologiaLineaProduttivaDetentore = -1;
			int idComuneCattura = -1;

				if (animale != null && animale.getDetentore() != null && animale.getDetentore().getIdOperatore() > 0) {
					nomeDetentore = toHtml(animale.getDetentore()
							.getRagioneSociale());
					idTipologiaLineaProduttivaDetentore = ((LineaProduttiva) (((Stabilimento) animale
							.getDetentore().getListaStabilimenti().get(0))
							.getListaLineeProduttive().get(0))).getIdRelazioneAttivita();
					idDetentore = ((animale.getDetentore() != null && animale
							.getDetentore().getListaStabilimenti().size() > 0)) ? ((LineaProduttiva) (((Stabilimento) animale
							.getDetentore().getListaStabilimenti().get(0))
							.getListaLineeProduttive().get(0))).getId()
							: -1;
							if ((idTipologiaLineaProdProprietario == LineaProduttiva.idAggregazioneSindaco || 
									idTipologiaLineaProdProprietario == LineaProduttiva.idAggregazioneSindacoFR) && 
									idTipologiaLineaProduttivaDetentore == LineaProduttiva.idAggregazioneCanile){
								idComuneCattura = stabProprietario.getSedeOperativa().getComune();
								System.out.println("COMUNE CATTURA   "+idComuneCattura);
							}
				
				}
		
		%>
		
						<input type="hidden" name="idDetentore" id="idDetentore"
					value="<%=idDetentore%>">
<dhv:evaluate if="<%=(
		//User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) && 
		User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
		<!-- dhv:evaluate if='<%=(animale.getIdSpecie() == 1)%>' -->
		<tr class="containerBody" id="detentore">
			<td class="formLabel" nowrap><dhv:label name="">Selezione Detentore</dhv:label>
			</td>
			<td>

			<table cellspacing="0" border="0" width="100%" class="details">
				<!-- dhv:evaluate if="<%=(Cane != null && Cane.getDetentore() != null)%>" -->

				<tr>

					<td id="nomeDetentore"><%=nomeDetentore%></td>
				</tr>

				<!-- /dhv:evaluate -->
				<tr>
					<td><dhv:evaluate if="<%=(
							//User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) && 
							User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
						<a onclick="win_open_search_delegato(getFiltroDetentore());return false;">Ricerca</a>
						<a onclick="win_open_add_delegato('<%=lineaProduttivaFiltro%>');return false;">Aggiungi</a>
							
						<!--<a
						href="javascript:popUp('OperatoreAction.do?command=SearchForm&tipologiaSoggetto=2&popup=true');">Ricerca</a>-->
					</dhv:evaluate> <dhv:evaluate if="<%=(
							//User.getRoleId() ==  new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) || 
							User.getRoleId() ==  new Integer(ApplicationProperties.getProperty("UNINA")))%>">
						<a onclick="win_open_search_delegato('');return false;">Ricerca</a>
						<a onclick="win_open_add_delegato('<%=lineaProduttivaFiltro%>');return false;">Aggiungi</a>
						<!-- <a href="javascript:popUp('OperatoreAction.do?command=SearchForm&tipologiaSoggetto=2&popup=true&idLineaProduttiva1=1');">Ricerca</a>	-->
					</dhv:evaluate></td>
				</tr>
			</table>

</dhv:evaluate>
			</td>

		</tr>
		<!-- /dhv:evaluate -->


		<tr class="containerBody">
			<dhv:evaluate if='<%=(animale.getIdSpecie() != 3)%>'>
				<!--  RAZZA CANE GATTO -->
				<td class="formLabel"><dhv:label name="">Razza</dhv:label></td>
				<td><%=razzaList.getHtmlSelect("idRazza", animale
								.getIdRazza())%>
				<%=showAttribute(request, "idRazza")%> <font color="red">*</font>
				<% if(ApplicationProperties.getProperty("flusso_336_req1").equals("true"))
				{%>
				<dhv:label
				name=""> Incrocio</dhv:label> <input type="checkbox" id="flagIncrocio"
				name="flagIncrocio"/></td>
			<%} %>
						</dhv:evaluate>
			
			<dhv:evaluate if='<%=(animale.getIdSpecie()== 3)%>'>
				<!--  RAZZA FURETTO -->
				<input type="hidden" name="idRazza" id="idRazza" value="0"></input>
			</dhv:evaluate>
			
		</tr>
		<tr>
			<td class="formLabel"><dhv:label name="">Sesso</dhv:label></td>
			<td>
				<input type="radio" name="sesso" value="M" id="sesso" <%=("M".equals(animale.getSesso())) ? " checked" : ""%> 
<%
				//Flusso 251: disabilitazione flusso. Per disabilitarlo decommentare la riga "if false" e commentare quella seguente
				//if(false)
				if((User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))))
				{
%>
							onclick="visualizzaPraticheLP();"
<%
				}
%>				
				>M 
				<input type="radio" name="sesso" value="F" id="sesso" <%=("F".equals(animale.getSesso())) ? " checked" : ""%> 
<%
				//Flusso 251: disabilitazione flusso. Per disabilitarlo commentare la riga "if false" e commentare quella seguente
				//if(false)
				if((User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))))
				{
%>
							onclick="visualizzaPraticheLP();"
<%
				}
%>				
				>F
			</td>
		</tr>

		<dhv:evaluate if='<%=(animale.getIdSpecie() == 1)%>'>
			<tr class="containerBody">
				<td class="formLabel"><dhv:label name="">Taglia</dhv:label></td>
				<td>
<%
	if(idTipologiaLineaProdProprietario==LineaProduttiva.idAggregazioneSindaco)
	{
%>
		<%=tagliaList.getHtmlSelectDescriptionEstesa("idTaglia", Cane.getIdTaglia())%> <%=showAttribute(request, "idTaglia")%> 
<%
	}
	else
	{
%>
		<%=tagliaList.getHtmlSelect("idTaglia", Cane.getIdTaglia())%> <%=showAttribute(request, "idTaglia")%> 
<% 
	}
%>

					<font color="red">*</font>
<%
				if(idTipologiaLineaProdProprietario==LineaProduttiva.idAggregazioneSindaco)
				{
%>
					<font id="avvisoTaglia"><i>La taglia si riferisce al peso presunto del cane da adulto</i></font>
<%
				}
%>
				</td>
			</tr>

		</dhv:evaluate>

		<dhv:evaluate if='<%=(animale.getIdSpecie() == 3)%>'>
			<!-- SE E' UN FURETTO, LA TAGLIA PUO' ESSERE SOLO MEDIA (2) -->
			<tr class="containerBody">
				<td class="formLabel"><dhv:label name="">Taglia</dhv:label></td>
				<td>Piccola</td>
			</tr>
			<input type="hidden" id="idTaglia" name="idTaglia" value="1"></input>
		</dhv:evaluate>

		<tr class="containerBody">
			<td class="formLabel"><dhv:label name="">Nato il</dhv:label></td>


			<td><input class="date_picker" type="text" name="dataNascita" id="dataNascita" size="10"
				onchange="mostraOrigine()"
				value="<%=toDateString(animale.getDataNascita())%>"
				nomecampo="nascita" tipocontrollo="T2" labelcampo="Data Nascita" />&nbsp;
			<div id="datanascitaDiv">
			</div><font color="red">*</font> <dhv:label
				name="">Data nascita presunta</dhv:label> <input type="checkbox"
				name="flagDataNascitaPresunta"
				<%=animale.isFlagDataNascitaPresunta() ? "DEFAULT CHECKED"
							: ""%> />

			</td>
		</tr>


		<tr class="containerBody">
			<td class="formLabel"><dhv:label name="">Mantello</dhv:label></td>
			<td><%=mantelloList.getHtmlSelect("idTipoMantello", animale
							.getIdTipoMantello())%> <%=showAttribute(request, "idTipoMantello")%>
			<font color="red">*</font></td>
		</tr>


		<tr class="containerBody">
			<td class="formLabel"><dhv:label name="">Nome</dhv:label></td>
			
			<!-- SINAAF ADEGUAMENTO -->
			<td><input type="text" size="30" id="nome" name="nome"	maxlength="41" value="<%=toHtmlValue(animale.getNome())%>">	<%=showAttribute(request, "nome")%><font color="red">*</font></td>
	    
	 
		</tr>
 


		<tr class="containerBody">
			<td class="formLabel"><dhv:label name="">Microchip</dhv:label></td>
		<dhv:evaluate if="<%=!ApplicationProperties.getProperty("VAM_ID").equals(session.getAttribute("caller")) %>" >
			<td><input type="text" size="16" id="microchip" name="microchip"
				maxlength="15" value="<%=(animale.getMicrochip() != null) ? animale.getMicrochip() : "" %>"
				onchange="verificaInserimentoAnimale(document.forms[0].microchip);"
				
				
				<%
				//Flusso 251: disabilitazione flusso. Per disabilitarlo decommentare la riga "if false" e commentare la seguente
				//if(false)
				if((User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))))
				{
					%>
							visualizzaPraticheLP();
				<%
				}
				%>
				
				
				
				
				">

			<font color="red">*</font> <%=showError(request, "ErroreMicrochip")%>&nbsp;&nbsp;

			</td></dhv:evaluate>
			
		<dhv:evaluate if="<%=ApplicationProperties.getProperty("VAM_ID").equals(session.getAttribute("caller")) %>" >
			<td><input type="text" size="16" id="microchip" name="microchip"
				maxlength="15" value="<%=(animale.getMicrochip() != null) ? animale.getMicrochip() : "" %>"
				onchange="verificaInserimentoAnimale(document.forms[0].microchip)" readonly="readonly">

			<font color="red">*</font> <%=showError(request, "ErroreMicrochip")%>&nbsp;&nbsp;

			</td></dhv:evaluate>
		</tr>

		
		<tr class="containerBody" style="">
			<td class="formLabel"><dhv:label name="">Data chippatura</dhv:label>
			</td>
			<td><input type="text" id="dataMicrochip" name="dataMicrochip" size="10" class="date_picker"
				value="<%=toDateasString(animale.getDataMicrochip())%>"
				nomecampo="chippatura" tipocontrollo="T2,T17"
				labelcampo="Data Chippatura" /> &nbsp;<font color=red>&nbsp;*</font></td>
				
				<td>		<dhv:evaluate if="<%=(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) || 
				User.getRoleId() == new Integer(ApplicationProperties.getProperty("UNINA")))%>">
				
				<input type="hidden" name="idVeterinarioMicrochip" id="idVeterinarioMicrochip" value="<%=User.getUserId() %>" />
				
	    </dhv:evaluate>	</td>
		</tr>
		
		
	
		<dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) && 
				User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">

			<tr class="containerBody" id="trVeterinarioChippatura">
				<td class="formLabel"><dhv:label name="">Veterinario chippatura</dhv:label>
				</td>
				<td>
				<table cellspacing="0" border="0" width="100%" class="details">
					<tr>
						<td><dhv:evaluate if='<%=(animale.getIdSpecie() == Cane.idSpecie)%>'>
							<%	veterinariList.setJsEvent("onChange=\"javascript:checkVeterinarioMicrochip(this);\"");	%>
							<%=veterinariList.getHtmlSelect("idVeterinarioMicrochip", Cane.getIdVeterinarioMicrochip())%>
						</dhv:evaluate> <dhv:evaluate if='<%=(animale.getIdSpecie() == Gatto.idSpecie)%>'>
							<%	veterinariList.setJsEvent("onChange=\"javascript:checkVeterinarioMicrochip(this);\"");	%> 
							<%=veterinariList.getHtmlSelect("idVeterinarioMicrochip", Gatto.getIdVeterinarioMicrochip())%>
						</dhv:evaluate><dhv:evaluate if='<%=(animale.getIdSpecie() == Furetto.idSpecie)%>'>
							<%	veterinariList.setJsEvent("onChange=\"javascript:checkVeterinarioMicrochip(this);\"");	%> 
							<%=veterinariList.getHtmlSelect("idVeterinarioMicrochip", Furetto.getIdVeterinarioMicrochip())%>
						</dhv:evaluate>
						<font color=red>&nbsp;*</font>
						<input type="button" name="aggiuntaVetChippatore" id="aggiuntaVetChippatore" value="Aggiungi veterinario non presente" onclick="apriPopupAggiuntaVetChippatore()" />
						<div id="dialogAggiuntaVetChippatore" title="Aggiunta veterinario chippatore">
    						<jsp:include page="../registrazioni_animale/aggiuntaVetChippatore.jsp"></jsp:include>
						</div>
						
						</td>
					</tr>
				</table>


				</td>

			</tr>
			
			
			



			<dhv:evaluate if='false'>
				<tr class="containerBody">
					<td class="formLabel">Morsicatore</td>
					<td><input type="checkbox" id="flagMorsicatore"
						onclick="checkMorsicatore()" name="flagMorsicatore" />

					<div id="mors"><br>
					Date: <input class="date_picker" type="text" id="dataMorso" name="dataMorso"
						size="10"
						value="<%=(Cane.getDataMorso() != null) ? toDateasString(Cane
									.getDataMorso())
									: ""%>"
						nomecampo="dataMorso" tipocontrollo="T10,T9"
						labelcampo="Data Morsicatore N.1" /> &nbsp;</div>
					</td>
				</tr>
			</dhv:evaluate>

			<dhv:evaluate if='false'>
				<tr class="containerBody">
					<td class="formLabel"><dhv:label name="">Aggressivo</dhv:label>
					</td>
					<td><input type="checkbox" name="flagAggressivo"
						<%if (Cane.isFlagAggressivo()) {%> checked="checked" <%}%> /></td>
				</tr>
			</dhv:evaluate>
		</dhv:evaluate>
		<tr class="containerBody" id="sterilizzazione">
			<td class="formLabel"><dhv:label name="">Data Sterilizzazione</dhv:label>
			</td>
			<td>
			<table border="0">
				<tr>
					<td><input type="checkbox" name="flagSterilizzazione" id="flagSterilizzazione"
						onclick="javascript : if (this.checked==true) { document.getElementById('divster').style.display='' } else{document.getElementById('divster').style.display='none'; document.addAnimale.dataSterilizzazione.value= ''; 
<%
							//Flusso 251: disabilitazione flusso. Per disabilitarlo decommentare la riga "if false" e commentare quella seguente
							//if(false)
							if(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")))
							{
%>
								visualizzaPraticheLP(); 
<%
							}
%>
						}"
						<%=(animale.isFlagSterilizzazione()) ? "checked" : ""%>></td>
				</tr>
				<tr>
					<td>
					<!-- flusso 251  -->
					<div id="divster" style="display: none"><input class="date_picker"
						type="text" name="dataSterilizzazione" id="dataSterilizzazione" size="10"
						
						
						<%
						//Flusso 251: disabilitazione flusso. Per disabilitarlo decommentare la riga "if false" e commentare quella seguente
						//if(false)
						if(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")))
						{
						%>
						
							onchange="visualizzaPraticheLP();" 
						<%
						}
						%>
						
						value="<%=toDateasString(animale.getDataSterilizzazione())%>"
						nomecampo="dataSterilizzazione" tipocontrollo="T10,T11,T9"
						labelcampo="Data Sterilizzazione" /> &nbsp; &nbsp;
						<dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))
						&& User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
						<dhv:evaluate if ="<%=(animale.getIdSpecie() != Furetto.idSpecie) %>">
						Contributo Regionale <input
						type="checkbox" name="flagContributoRegionale"
						id="flagContributoRegionale"
						<%if (animale.isFlagContributoRegionale()) {%> checked="checked"
						<%}%> onclick="visualizzaPratiche();" /> <%=showAttribute(request, "errContr")%>&nbsp;
						</dhv:evaluate>
						</dhv:evaluate>
					<br />
					<br />

					<div id="pratica_contributo" name="pratica_contributo"
						style="visibility: hidden"><input type="hidden"
						name="oldPratica"
						value="<%=request.getParameter("pratica") != null ? request
					.getParameter("pratica") : ""%>">
					<select id="idProgettoSterilizzazioneRichiesto"
						name="idProgettoSterilizzazioneRichiesto">
					</select></div>

					<%=showError(request, "praticaError")%> <input type="hidden"
						name="contributoPagato"></div>

					</td>
				</tr>

			</table>


			</td>
		</tr>



		<dhv:evaluate if="<%=(User.getRoleId() != 24 && User.getRoleId() != Integer.valueOf(ApplicationProperties.getProperty("UNINA")))%>">

			<tr class="containerBody">
				<td class="formLabel"><dhv:label
					name="anagrafe_animali_tatuaggio">Tatuaggio/2°Microchip</dhv:label>
				</td>
				<td><input type="text" size="20" name="tatuaggio"
					id="tatuaggio" maxlength="15"
					value="<%=toHtmlValue(animale.getTatuaggio())%>"
					onchange="verificaInserimentoAnimale(document.forms[0].tatuaggio)">
				<%=showError(request, "ErroreTatuaggio")%>&nbsp;&nbsp;</td>

			</tr>

			<tr class="containerBody">
				<td class="formLabel"><dhv:label name="">Data rilascio secondo Microchip</dhv:label>
				</td>
				<td><input class="date_picker" type="text" id="dataTatuaggio" name="dataTatuaggio" size="10"
					value="<%=toDateasString(animale.getDataTatuaggio())%>"
					nomecampo="dataTatuaggio" tipocontrollo="T10,T11,T9"
					labelcampo="Data Secondo MC" />&nbsp;</td>

			</tr>


<%-- COMMENTATO IN APPLICAZIONE CR 01/10/14 MODIFICA SCHEDA ANAGRAFICA ANIMALE
DECOMMENTATO NUOVAMENTE IN APPLICAZIONE CR 2015 PASSAPORTI A PRIORI
	 --%>		<tr class="containerBody">
				<td class="formLabel"><dhv:label name="">Passaporto</dhv:label>
				</td>
				<td><input type="text" name="numeroPassaporto" size="15"
					maxlength="13"
					value="<%=toHtmlValue(animale.getNumeroPassaporto())%>" onchange="javascript:verificaPassaporto(this);"></td>
			</tr>
			
			<tr class="containerBody">
				<td class="formLabel"><dhv:label name="">Data rilascio passaporto - Data scadenza passaporto</dhv:label>
				</td>
				<td> <input type="text" class="date_picker"
					name="dataRilascioPassaporto" id="dataRilascioPassaporto" size="10"
					value="<%=toDateasString(animale.getDataRilascioPassaporto())%>"
					nomecampo="dataRilascioPassaporto" tipocontrollo=""
					labelcampo="Data rilascio passaporto"/>&nbsp;&nbsp;
					--
					<input type="text" class="date_picker" onclick="checkDataFine('dataRilascioPassaporto','dataScadenzaPassaporto')"
					name="dataScadenzaPassaporto" id="dataScadenzaPassaporto" size="10"
					value=""
					nomecampo="dataScadenzaPassaporto" tipocontrollo=""
					labelcampo="Data scadenza passaporto" />&nbsp;&nbsp;&nbsp;</td>
			</tr>

	  </dhv:evaluate>
	  </table>
	  <br/>
	  <table id="origine_table" cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
			<input type="hidden" id="abilita_origine" value="false"/>
			<tr>
				<th  colspan="2"><strong>Dati provenienza animale mai anagrafato</strong></th>
			</tr>
			
			
  			<tr class="containerBody" id="provenienza_soggetto_ritrovamento">
			    <td class="formLabel"><dhv:label name="">Seleziona origine animale</dhv:label></td>
			    <td  bgcolor="#b3d9ff" >
				    <input type="radio" id="origine_da" name="origine_da" value="in_regione" onclick="<%if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>document.getElementById('mostraProprietarioProvenienza').style.display = 'none';<%}%>document.getElementById('microchipMadre').value = '';document.getElementById('dataMadre').style.display='';document.getElementById('CFProp').style.display='';"> In regione&nbsp;&nbsp;
				  	<input type="radio" id="origine_da" name="origine_da" value="fuori_regione" onclick="document.getElementById('microchipMadre').value = '';document.getElementById('dataMadre').style.display='';document.getElementById('CFProp').style.display='';"> Fuori regione&nbsp;&nbsp;
					<% if(User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")) && User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))){%>
				  	<input type="radio" id="origine_da" name="origine_da" value="nazione_estera" onclick="document.getElementById('microchipMadre').value = '';document.getElementById('dataMadre').style.display='none';document.getElementById('CFProp').style.display='none';"> Proveniente da nazione estera&nbsp;&nbsp;
				  	<% } %>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Pulisci campo" onclick="removNoDisplay()"/)>
				</td>
			</tr>
			
			<tr class="containerBody" id="radio_tipo_origine" height="175">
    			<td class="formLabel"><dhv:label name="">Specificare la provenienza</dhv:label></td>  
    				<td  bgcolor="#b3d9ff">
      					<table width="100%" cellspacing="0" border="0">
        					<tr>
          						<td>
						            <input type="radio" name="tipo_origine" id="tipo_origine" value="soggetto_fisico"> Da proprietario&nbsp;&nbsp;
						  	       <%
						   if(User.getRoleId() != 24 || ApplicationProperties.getProperty("flusso_336_req3").equals("false") )
						   {
						   %>
						  	        <input type="radio" name="tipo_origine" id="tipo_origine"  value="ritrovamento"> Da ritrovamento
						  <%
						   }
						  %>
						  	    </td>
						  	    
						  	    
						  	    
						  	    
  	      						<td align="center" id="dati_ritrovamento">
   	 				            	<b>DATI RITROVAMENTO</b>
									<table bgcolor="#ffffff" cellspacing="10" style="border:'none'">
									
									
									
									
									
	      <tr>
    	  <td><label>Provincia</label></td>
		  <td>
			<select class="todisable" name="provincia_ritrovamento" id="provincia_ritrovamento">
			  <% System.out.println(request.getAttribute("provincia_ritrovamento")+" - "+request.getAttribute("comune_ritrovamento"));
			  if(request.getAttribute("provincia_ritrovamento")!= null && !((String)request.getAttribute("provincia_ritrovamento")).equals("")){ 
				out.print("<option value=\""+((String)request.getAttribute("provincia_ritrovamento"))+"\">"+provinceList.getSelectedValue(Integer.parseInt(((String)request.getAttribute("provincia_ritrovamento"))))+"</option>");%>  
			  <%}else{ %>
			  <option value="">Inserire le prime 4 lettere</option>
			  <% } %>
			</select>		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">*</font>
		    <input type="hidden" name="provincia_ritrovamentoTesto"
			  id="provincia_ritrovamentoTesto" />
          </td>
	    </tr>
	
	    <tr>
   	      <td><label>Comune</label></td>
		  <td>
		    <select class="todisable" name="comune_ritrovamento" id="comune_ritrovamento">
			<% if(request.getAttribute("comune_ritrovamento")!= null && !((String)request.getAttribute("comune_ritrovamento")).equals("")){ 
				out.print("<option selected value=\""+((String)request.getAttribute("comune_ritrovamento"))+"\">"+comuniList_all.getSelectedValue(Integer.parseInt(((String)request.getAttribute("comune_ritrovamento"))))+"</option>"); %>  
			 <% }else{%>
			  <option value="">Inserire le prime 4 lettere</option>
			  <% } %>
			
			</select>		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">*</font>
			<input type="hidden" name="comune_ritrovamentoTesto" id="comune_ritrovamentoTesto" />
		  </td>
	    </tr>
	    
	    <tr>
			<td><label>Indirizzo</label></td>
			<td>
				<input type="text" size="50" maxlength="50" id="indirizzo_ritrovamento" name = "indirizzo_ritrovamento" value="<%=(request.getAttribute("indirizzo_ritrovamento")!=null ? ((String)request.getAttribute("indirizzo_ritrovamento")) : "")%>">
			 	<font color="red">&nbsp;*&nbsp;</font> 
			</td>
 	    </tr>
 	    
 	    <tr>
			        <td><label>Data</label></td>
                    <td><input type="text" id="data_ritrovamento" name="data_ritrovamento" value="<%=(request.getAttribute("data_ritrovamento")!=null ? ((String)request.getAttribute("data_ritrovamento")) : "")%>"
				      size="10" value="" class="date_picker"
					  nomecampo="ritrovamento" 
					  labelcampo="Data Ritrovamento" />&nbsp;<font color="red">* Data ritrovamento</font>
				    </td>
				  </tr>	
  	       </table>
  	      </td>
  	    </tr>
  	  </table>
    </td>
  </tr>
  
  		<% if(User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA"))){%>
			<!--  SEZIONE PROVENIENZA ALTRA NAZIONE -->
			<tr  id="provenienza_da_altra_nazione" class="containerBody">
				<td class="formLabel"><dhv:label name="">Provenienza da nazione estera</dhv:label></td>
				<td bgcolor="#b3d9ff">
				     <%//if (animale != null && request.getAttribute("idNazioneProvenienza")!=null  && !((String)request.getAttribute("idNazioneProvenienza")).equals("-1")) {;}
					  %>
					<div id="utProvenienzaEstera" 
						<%=(request.getAttribute("idNazioneProvenienza") != null && !((String)request.getAttribute("idNazioneProvenienza")).equals("-1")) ? (""): ("style=\"display:none\"")%>>
						<%=nazioniList.getHtmlSelect("idNazioneProvenienza",Integer.parseInt((request.getAttribute("idNazioneProvenienza") != null ? (String)request.getAttribute("idNazioneProvenienza") : "-1" )))%><font color="red">&nbsp;*</font> 
						<input type="hidden" id="idNazioneProvenienza_hidden" 
						  value='<%=(request.getAttribute("idNazioneProvenienza") != null ? (String)request.getAttribute("idNazioneProvenienza") : "-1")%>' />
						<input type="hidden" id="verDate" name="verDate" value="ok" />
						<br><textarea rows="4" cols="50" id="noteNazioneProvenienza" name="noteNazioneProvenienza"><%=((String)request.getAttribute("noteNazioneProvenienza")!=null ? (String)request.getAttribute("noteNazioneProvenienza") : "")%></textarea>
					</div>
				</td>
			</tr>
			<% }else{ %>
  				<input type="hidden" id="provenienza_da_altra_nazione"/>
  				<input type="hidden" id="utProvenienzaEstera" /> 
  				<input type="hidden" id="idNazioneProvenienza" value="-1" />
  				<input type="hidden" id="noteNazioneProvenienza" value=""/>
			<% } %>
  
<!------------------------------------- GESTIONE PROPRIETARIO DI PROVENIENZA ---------------------------------------->
						<%
			int idProprietarioProvenienza = -1;
			String nomeProprietarioProvenienza = "";
				

				if (animale != null && animale.getProprietarioProvenienza() != null && animale.getProprietarioProvenienza().getIdOperatore() > 0) {
					if(animale.getProprietarioProvenienza().getIdOperatore()<10000000){
					
					nomeProprietarioProvenienza = toHtml(animale.getProprietarioProvenienza().getRagioneSociale());
					idProprietarioProvenienza = ((animale.getProprietarioProvenienza() != null && animale
							.getProprietarioProvenienza().getListaStabilimenti().size() > 0)) ? ((LineaProduttiva) (((Stabilimento) animale
							.getProprietarioProvenienza().getListaStabilimenti().get(0))
							.getListaLineeProduttive().get(0))).getId()
							: -1;
				}else{
					nomeProprietarioProvenienza = toHtml(animale.getProprietarioProvenienza().getRagioneSociale());
					idProprietarioProvenienza = animale.getProprietarioProvenienza().getIdOperatore();
				}
				}
		
		%>
		
		<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true"))
		{
		%>
		
		
		 <dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
    <tr class="containerBody" id="microchipMadreDiv" style="display:none;">
	  <td class="formLabel" nowrap><dhv:label name="">Dati madre</dhv:label></td>
	  <td  bgcolor="#b3d9ff" ><table cellspacing="0" border="0" width="100%" class="details">
	        <tr>
			</tr>
			<tr id="mostraMicrochipMadre" >
   			  <td bgcolor="#ffffff"><dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
						<input type="hidden" id="idAnimaleMadre" name="idAnimaleMadre">
						<input type="hidden" id="dataNascitaMadre" name="dataNascitaMadre">	
						<input type="hidden" id="controlloMicrochipMadre" name="controlloMicrochipMadre" value="<%=toHtmlValue(animale.getMicrochipMadre())%>">											
						<input type="text" size="16" id="microchipMadre" name="microchipMadre" placeholder="Microchip"
				maxlength="15" value="<%=toHtmlValue(animale.getMicrochipMadre())%>" ><%=showAttribute(request, "microchipMadre")%>
				 		<input class="date_picker" type="text" name="dataMadre" id="dataMadre" size="10"
				onchange="mostraOrigine()"
				nomecampo="nascita" tipocontrollo="" labelcampo="Data Madre" placeholder="Data di nascita" />&nbsp;
				 		<input type="text" size="18" id="CFProp" name="CFProp" placeholder="Cf/iva proprietario">
				 <input type="button" value="Conferma" onclick="verificaMicrochipMadre(document.forms[0].microchipMadre);"> 
				</dhv:evaluate> 
			  </td>
			</tr>
		  </table></td>
		</tr>
  </dhv:evaluate>
  
  
  
   
  
  
    <input type="hidden" name="cfProv" id="cfProv">
    <input type="hidden" name="ragioneSocialeProv" id="ragioneSocialeProv">
  <input type="hidden" name="idProprietarioProvenienza" id="idProprietarioProvenienza"	value="<%=idProprietarioProvenienza%>">
  <dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
    <tr class="containerBody" id="proprietarioProvenienza">
	  <td class="formLabel" nowrap><dhv:label name="">Proprietario provenienza</dhv:label></td>
	  <td  bgcolor="#b3d9ff" ><table cellspacing="0" border="0" width="100%" class="details">
	        <tr>
	        
              <td id="nome_proprietario_provenienza"><%=nomeProprietarioProvenienza%></td>
			</tr>
			<tr id="mostraProprietarioProvenienza" style="display:none;" >
		
   			  <td bgcolor="#ffffff">
						
						<a onclick="win_open_add_origine('8','true','1');return false;">Aggiungi</a>
			  </td>
			</tr>
		  </table></td>
		</tr>
		
		
		
		
  </dhv:evaluate>
  
  
  
  
  
  
  
  
		<%}else{ %>
		
		
  <input type="hidden" name="idProprietarioProvenienza" id="idProprietarioProvenienza"	value="<%=idProprietarioProvenienza%>">
  <dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
    <tr class="containerBody" id="proprietarioProvenienza">
	  <td class="formLabel" nowrap><dhv:label name="">Seleziona proprietario provenienza</dhv:label></td>
	  <td  bgcolor="#b3d9ff" ><table cellspacing="0" border="0" width="100%" class="details">
	        <tr>
              <td id="nome_proprietario_provenienza"><%=nomeProprietarioProvenienza%></td>
			</tr>
			<tr id="mostraProprietarioProvenienza" >
   			  <td bgcolor="#ffffff"><dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("UNINA")))%>">
						&nbsp;&nbsp;
						
						<a id="ricerca_fr" onclick="win_open_search_origine('8','true');return false;">Ricerca</a>
						<a onclick="win_open_add_origine('8','true','1');return false;">Aggiungi</a>
				</dhv:evaluate> 
			  </td>
			</tr>
		  </table></td>
		</tr>
		
		
		
		
  </dhv:evaluate>
  <%} %>

<!-- ------------------------------------------------------------------------------------------------------------ -->
				<% if(true){ %>

			<!--  SEZIONE ACQUISTO ONLINE -->
			<tr  class="containerBody" id="mostraAcquistoOnline" >
				<td class="formLabel"><dhv:label name="">Acquisto online</dhv:label></td>
				<td bgcolor="#b3d9ff">
					<input type="checkbox" id="flagAcquistoOnline"	onclick="CheckGenericoOrigineAnimale(this)" name="flagAcquistoOnline" <%if (animale != null && request.getAttribute("sitoWebAcquisto")!=null && !((String)request.getAttribute("sitoWebAcquisto")).equals("-1")) {%> checked="checked" <%}%> />
					<div id="utProvenienzaOnline" 
						<%=((request.getAttribute("sitoWebAcquisto") != null && !((String)request.getAttribute("sitoWebAcquisto")).equals("-1")) ? "": "style=\"display:none\"")%>>
						<input type="hidden" id="sitoWebAcquisto_hidden" 
						  value='<%=(request.getAttribute("sitoWebAcquisto") != null ? (String)request.getAttribute("sitoWebAcquisto") : "-1")%>' />
						<select id="sitoWebAcquisto" name="sitoWebAcquisto" onChange="abilitaNoteOnline()">
							<option value="-1">--Seleziona---</option>
							<option value="AnimalHouseOnline">Animal House Online</option>
							<option value="CaniECuccioli">Cani e Cuccioli</option>
							<option value="AnnunciAnimali">Annunci Animali</option>
							<option value="Subito">Subito</option>
							<option value="Ebay">Ebay</option>
							<option value="Altro">Altro</option>
						</select><font color="red">&nbsp;*</font> 
						<br><textarea rows="4" cols="50" id="noteAcquistoOnline" name="noteAcquistoOnline"><%=((String)request.getAttribute("noteAcquistoOnline")!=null ? (String)request.getAttribute("noteAcquistoOnline") : "")%></textarea>
						<input type="hidden" id="verDate" name="verDate" value="ok" />
						</div>
				</td>
			</tr>
			<%} %>
		
			<!--  SEZIONE MANCATA TRACCIABILITA' -->
			<tr  id="mancata_tracciabilita" class="containerBody">
				<td class="formLabel"><dhv:label name="">Le informazioni sull'origine dell'animale non sono rintracciabili</dhv:label></td>
				<td bgcolor="#b3d9ff">
					<input type="checkbox" id="flagSenzaOrigine" disabled="disabled" style="display:none;"	onclick="CheckGenericoOrigineAnimale(this)" name="flagSenzaOrigine" 
					     <%if (animale != null && request.getAttribute("flagSenzaOrigine")!=null  && ((String)request.getAttribute("flagSenzaOrigine")).equals("on")) {%> checked="checked" <%}%> />
				&nbsp;<b>Clicca <a href="javascript:popURL('guida_2016/Manuale_tracciabilita.pdf','CRM_Help','1000 ','500','yes','yes');" onclick="document.getElementById('flagSenzaOrigine').disabled=false;document.getElementById('flagSenzaOrigine').style.display='';">QUI</a> per maggiori dettagli</b><br/> 
				</td>
			</tr>

	</table>
	<dhv:evaluate if="<%=(User.getRoleId() != 24)%>">
		<br>
		<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2"><strong>Dati Aggiuntivi</strong></th>
			</tr>

			<tr class="containerBody">
				<td valign="top" class="formLabel"><dhv:label name="">Segni particolari</dhv:label>
				</td>
				<td><textarea name="segniParticolari" rows="3" cols="50"><%=toString(animale.getSegniParticolari())%></textarea>
				<%=showAttribute(request, "descriptionError")%></td>
			</tr>
			<tr class="containerBody">
				<td valign="top" class="formLabel"><dhv:label name="">Note</dhv:label>
				</td>
				<td><textarea name="note" rows="3" cols="50"><%=toString(animale.getNota2())%></textarea>
				</td>
			</tr>
		</table>
		<br>


<dhv:evaluate if ="<%=!(User.getRoleId() == Integer.valueOf(ApplicationProperties.getProperty("UNINA") ))%>">
		<dhv:evaluate if='<%=(animale.getIdSpecie() == 1)%>'>
			<table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details">
				<tr>
					<th colspan="4"><strong><dhv:label name="">Controlli Richiesti</dhv:label></strong>
					</th>
				</tr>

				<!-- Leishmaniosi -->
				<%-- <tr class="containerBody" style="display: none">--%>
				<tr class="containerBody">
					<td width="25%" valign="top" class="formLabel2"><dhv:label
						name="">Leishmaniosi</dhv:label></td>
					<td width="40%" id="esitiLeishSindAdd">
					<table class="noborder">
						<tr>
							<td>Ord.sind. <input type="text" size="10"
								id="leishmaniosiNumeroOrdinanzaSindacale"
								name="leishmaniosiNumeroOrdinanzaSindacale" maxlength="15"
								value="<%=toString(Cane
											.getLeishmaniosiNumeroOrdinanzaSindacale())%>">
							del <input type="text" class="date_picker"
								id="leishmaniosiDataOrdinanzaSindacale"
								name="leishmaniosiDataOrdinanzaSindacale" size="10"
								value="<%=toDateasString(Cane
									.getLeishmaniosiDataOrdinanzaSindacale())%>"
								nomecampo="leishmaniosiDataOrdinanzaSindacale"
								tipocontrollo="T10,T9"
								labelcampo="Ordine Sindacale Leishmaniosi" /> &nbsp;</td>
						</tr>
					</table>
					</td>
				</tr>
				<!-- tr leishmaniosi -->

				<!-- Ehrlichiosi -->
				<%-- if ( !update ) { --%>
				<tr class="containerBody">
					<td valign="top" class="formLabel2"><dhv:label name="">Ehrlichiosi</dhv:label>
					</td>
					<td>
					<table class="noborder">
						<tr>
							<td><input type="checkbox" id="flagControlloEhrlichiosi"
								<%if (Cane.isFlagControlloEhrlichiosi()) {%> checked="checked"
								<%}%> name="flagControlloEhrlichiosi"
								onclick="abilitaEsitiEhi();" /></td>


							<td id="esitoEhradd1">
							<table class="noborder">
								<tr>
									<td>Data <input type="text"
										id="dataControlloEhrlichiosi" name="dataControlloEhrlichiosi"
										size="10" class="date_picker"
										value="<%=toDateasString(Cane
											.getDataControlloEhrlichiosi())%>"
										nomecampo="dataControlloEhrlichiosi"
										tipocontrollo="T10,T11,T9" labelcampo="Data Ehrlichiosi" />&nbsp;
									 <%--} --%></td>
									<td>Esito <%-- if (.getEsitoControlloEhrlichiosi() == 0 || animale.getEsitoControlloEhrlichiosi() == 1 || animale.getEsitoControlloEhrlichiosi() == -1) { %>
    		<%=esitoList.getSelectedValue(animale.getEsitoControlloEhrlichiosi()) %>

    			
    	<%}else{ --%> <%=esitoList.getHtmlSelect(
									"esitoControlloEhrlichiosi", Cane
											.getEsitoControlloEhrlichiosi())%> <%-- }--%></td>
								</tr>
							</table>
							</td>


						</tr>

					</table>
					</td>
				</tr>

				<!-- Rickettiosi -->
				<tr class="containerBody">
					<td valign="top" class="formLabel2"><dhv:label name="">Rickettiosi</dhv:label>
					</td>
					<td>
					<table class="noborder">
						<tr>
							<td><input type="checkbox" id="flagControlloRickettsiosi"
								name="flagControlloRickettsiosi"
								<%if (Cane.isFlagControlloRickettsiosi()) {%> checked="checked"
								<%}%> onclick="abilitaEsitiRik();" /></td>
							<td id="esitoRickadd1">
							<table class="noborder">
								<tr>
									<td>Data <input type="text" class="date_picker"
										id="dataControlloRickettsiosi"
										name="dataControlloRickettsiosi" size="10"
										value="<%=toDateasString(Cane
									.getDataControlloRickettsiosi())%>"
										nomecampo="dataControlloRickettsiosi"
										tipocontrollo="T10,T11,T9" labelcampo="Data Rickettiosi" />&nbsp;
									</td>
									<td id=>Esito <%=esitoList.getHtmlSelect(
									"esitoControlloRickettsiosi", Cane
											.getEsitoControlloRickettsiosi())%></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<%--} --%>
			</table>
		</dhv:evaluate>



		<br />
		
		
 	<!-- ------------------------------CATTURA---------------------------------------------- -->
<table width="100%"><tr><td>
	 	<dhv:evaluate if='<%=(animale.getIdSpecie() != Furetto.idSpecie)%>'>
			<table id="cattura" name="cattura" cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details">
				<tr>
					<th colspan="2"><strong>Dettagli Cattura</strong></th>
				</tr>

				<tr class="containerBody">
					<td class="formLabel"><dhv:label name="">Cattura</dhv:label></td>
					<td><%-- if (!update) { --%> <input type="checkbox"
						onclick="javascript:checkProprietarioDetentore();"
						<%if (Cane.isFlagCattura()) {%> checked="checked" <%}%>
						id="flagCattura" name="flagCattura" /></td>
				</tr>


				<tr class="containerBody">
					<td valign="top" class="formLabel"><dhv:label name="">Comune Cattura</dhv:label>
					</td><input type="hidden" name="idComuneCattura" id="idComuneCattura" value="<%=stabProprietario.getSedeOperativa().getComune()%>" onChange="javascript:visualizzaMunicipalita();"/>
					<td><%-- if (!update) { --%> <%=comuniList.getSelectedValue(stabProprietario.getSedeOperativa().getComune())%>
					<%-- } else { %>
		<%= ( asset.getComuneCattura() != null ) ? asset.getComuneCattura() : "" %>
	<% } --%></td>
				</tr>
				<tr class="containerBody">
					<td valign="top" class="formLabel"><dhv:label name="">Luogo Cattura</dhv:label>
					</td>
					<td><input type="text" name="luogoCattura"
						value="<%=toHtmlValue(Cane.getLuogoCattura())%>" id="luogoCattura" /></td>
				</tr>
				<tr class="containerBody">
					<td class="formLabel"><dhv:label name="">Data Cattura</dhv:label>
					</td>
					<td><%-- if (!update) { --%> <!--  <div id="divDataCatturaSi" style="display:none; vertical-align: middle">-->
					<div id="divDataCatturaSi" style=""><input
						type="text" id="dataCattura" class="date_picker"
						name="dataCattura" size="10"
						value="<%=toDateasString(Cane.getDataCattura())%>"
						nomecampo="dataCattura" tipocontrollo="T3" labelcampo="Data Cattura" />
					&nbsp;</div>
					<%-- } else{ %>
    	<%= ( asset.getDataCattura() != null ) ? asset.getDataCattura() : "" %>
    <% } --%></td>
				</tr>
				<tr class="containerBody">
					<td valign="top" class="formLabel"><dhv:label name="">Verbale Cattura</dhv:label>
					</td>
					<td><%-- if (!update) { --%> <textarea name="verbaleCattura"
						id="verbaleCattura" rows="3" cols="50" onmouseover=""></textarea>
					<%-- } else {%>
    <%= ( asset.getVerbaleCattura() != null ) ? asset.getVerbaleCattura() : "" %>	
   <%} --%></td>
				</tr>

			</table>
	  	</dhv:evaluate>
	  	
	  </td>
	  
	  </tr></table>
	  	<!-- --------------------------------------------------------------------------------------------------- -->

	</dhv:evaluate>
</dhv:evaluate>
</br>
	<dhv:permission name="anagrafe_canina-note_internal_use_only-add">
		<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2"><strong>NOTE USO INTERNO</strong></th>
			</tr>
			<tr class="containerBody">
				<td valign="top" class="formLabel"><dhv:label name="">Note</dhv:label>
				</td>
				<td><textarea name="noteInternalUseOnly" rows="3" cols="50"><%=toString(animale.getNoteInternalUseOnly())%></textarea>
				</td>
			</tr>
		</table>
	</dhv:permission>

	<input type="hidden" name="dosubmit" value="true" />
	<input type="hidden" name="saveandclone" value="" />

	<br />
	<input type="button"
		value="<dhv:label name="global.button.save">Save</dhv:label>"
		onClick="this.form.dosubmit.value='true';this.form.saveandclone.value='';if(doCheck(this.form)){setTimestampStartRichiesta();this.form.submit()};" />

<dhv:evaluate if="<%=session.getAttribute("caller")==null || !ApplicationProperties.getProperty("VAM_ID").equals(session.getAttribute("caller")) %>" >
	<input type="button"
		value="Salva e Clona"
		onClick="this.form.dosubmit.value='true';this.form.saveandclone.value='1';if(doCheck(this.form)){setTimestampStartRichiesta();this.form.submit()};" />
	
	</dhv:evaluate>
		
	<input type="hidden" name="doContinue" id="doContinue" value="">
		<input type="hidden" name="closeOKPopMC" id="closeOKPopMC" value="false">
	
	
	
	</form>
	
	<div id="dialogMunicipalita" title="Municipalit&agrave; del comune di Napoli">
    <jsp:include page="../registrazioni_animale/municipalita.jsp"></jsp:include>
</div>
<script language="javascript">

mostraOrigine();

$("form input:radio").change(function () {
	CheckGenericoOrigineAnimale(this);
});

function gestioneCheckboxOrigineDopoReload(){
	<% 
	if (request.getAttribute("origine_da")!=null){
		String origine_ = (String)request.getAttribute("origine_da");
		if(origine_.equals("in_regione")){  %>
			var $radios = $('input:radio[name=origine_da]');
			$radios.filter('[value=in_regione]').prop('checked', true);
			<%if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){%>
			 document.getElementById('mostraProprietarioProvenienza').style.display = 'none';

			 document.getElementById("microchipMadreDiv").style.display="none";

			//if(!ApplicationProperties.getProperty("flusso_336_req2").equals("true"))
			 //document.getElementById("ricerca_fr").style.removeProperty("display");
	<% 	}}else if(origine_.equals("fuori_regione")){  %>
		    var $radios = $('input:radio[name=origine_da]');
		    $radios.filter('[value=fuori_regione]').prop('checked', true);
			<%if(!ApplicationProperties.getProperty("flusso_336_req2").equals("true")){%>
		    document.getElementById("ricerca_fr").style.display="none";
			<%}else{%>
						 document.getElementById("microchipMadreDiv").style.display="none";
			<%}%>
	<% }else{ %>
	    var $radios = $('input:radio[name=origine_da]');
	    $radios.filter('[value=nazione_estera]').prop('checked', true);
	    
		document.getElementById("radio_tipo_origine").style.display="none";
	    document.getElementById("proprietarioProvenienza").style.removeProperty("display");
		<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

		document.getElementById("microchipMadreDiv").style.removeProperty("display");
	    <%}%>

	    document.getElementById("dati_ritrovamento").style.display="none";
	    
		document.getElementById("provenienza_da_altra_nazione").style.removeProperty("display");
		document.getElementById("utProvenienzaEstera").style.removeProperty("display");
	    
	<%}
		if (request.getAttribute("tipo_origine")!=null){%>
			// OSCURO NAZIONE ESTERA
			document.getElementById("provenienza_da_altra_nazione").style.display="none";
			document.getElementById("utProvenienzaEstera").style.display="none";
			$("#idNazioneProvenienza").val("-1");	 
			document.getElementById("noteNazioneProvenienza").value="";<%
			String tipo_origine_ = (String)request.getAttribute("tipo_origine");
			if(tipo_origine_.equals("ritrovamento")){ %>
				var $radios = $('input:radio[name=tipo_origine]');
			    $radios.filter('[value=ritrovamento]').prop('checked', true);
			   	document.getElementById("proprietarioProvenienza").style.display="none";
				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

				document.getElementById("microchipMadreDiv").style.display="none";
			    <%}%>

			    document.getElementById("dati_ritrovamento").style.removeProperty("display");
			    // OSCURO ACQUISTO SU SITO WEB
			    				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

				document.getElementById("mostraAcquistoOnline").style.display="none";
				$("#flagAcquistoOnline").removeAttr('checked');			
				$("#sitoWebAcquisto").val("-1");	 
				document.getElementById("sitoWebAcquisto_hidden").value="";
				 document.getElementById("noteAcquistoOnline").style.display="none";
				 document.getElementById("noteAcquistoOnline").value="";<%}
			}else{ %> 
			   	var $radios = $('input:radio[name=tipo_origine]');
			   	$radios.filter('[value=soggetto_fisico]').prop('checked', true);
			   	document.getElementById("dati_ritrovamento").style.display="none";
				<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

				document.getElementById("microchipMadreDiv").style.removeProperty("display");
			    <%}%>
			   	document.getElementById("proprietarioProvenienza").style.removeProperty("display");
			   	<%
			}
		}
	}else{  %>
		// OSCURO NAZIONE ESTERA
		document.getElementById("provenienza_da_altra_nazione").style.display="none";
		document.getElementById("utProvenienzaEstera").style.display="none";
		$("#idNazioneProvenienza").val("-1");	 
		document.getElementById("noteNazioneProvenienza").value="";
	
		document.getElementById("provenienza_soggetto_ritrovamento").style.display="none";
		document.getElementById("radio_tipo_origine").style.display="none";
		document.getElementById("proprietarioProvenienza").style.display="none";
		<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

		document.getElementById("microchipMadreDiv").style.display="none";
		document.getElementById("dataMadre").style.display="none";

	    <%}%>
		document.getElementById("dati_ritrovamento").style.display="none";
		var ele = document.getElementsByName("origine_da");
		for(var i=0;i<ele.length;i++)
			ele[i].checked = false;
		ele = document.getElementsByName("tipo_origine");
		for(var i=0;i<ele.length;i++)
			ele[i].checked = false;<% 
	} %>
}

function gestioneOrigineDopoReloadPagina(){
	<%if (request.getAttribute("flagFuoriRegione")==null ) {%>
		// OSCURO ANAGRAFE FUORI REGIONE
		document.getElementById("provenienza_da_altra_regione").style.display="none";
		$("#flagFuoriRegione").removeAttr('checked');			
		document.getElementById("utProvenienza").style.display="none";
		$("#idRegioneProvenienza").val("-1");	 
		document.getElementById("noteAnagrafeFr").value="";
		<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
		//document.getElementById("mostraAcquistoOnline").style.display="none";

	<% }}else{ %>
		// OSCURO ACQUISTO SU SITO WEB
						<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

		document.getElementById("mostraAcquistoOnline").style.display="none";
		$("#flagAcquistoOnline").removeAttr('checked');			
		$("#sitoWebAcquisto").val("-1");	 
		document.getElementById("sitoWebAcquisto_hidden").value="";	
		 document.getElementById("noteAcquistoOnline").style.display="none";
		 document.getElementById("noteAcquistoOnline").value="";
	<% }} %>
	
	<%if (request.getAttribute("flagSenzaOrigine")==null ) {%>
		document.getElementById("mancata_tracciabilita").style.display="none";
		$("#flagSenzaOrigine").removeAttr('checked');	
	<% } %>
	
	
	gestioneCheckboxOrigineDopoReload();
	
	/*
	console.log(document.getElementById("flagSenzaOrigine").getAttribute("checked"))
	if(document.getElementById("flagSenzaOrigine").getAttribute("checked")=="checked"){
		document.getElementById("mostraAcquistoOnline").style.display="none";

	}
	*/
	
	
	<% if(request.getAttribute("flagAcquistoOnline")!= null){ 
	%>
  		$("#sitoWebAcquisto").val(''+document.getElementById("sitoWebAcquisto_hidden").value);
  		abilitaNoteOnline();
	<% }//else{ 
	%>
		// OSCURO ACQUISTO SU SITO WEB
		//document.getElementById("mostraAcquistoOnline").style.display="none";
		//$("#flagAcquistoOnline").removeAttr('checked');			
		//document.getElementById("utProvenienzaOnline").style.display="none";
		//$("#sitoWebAcquisto").val("-1");	 
		//document.getElementById("sitoWebAcquisto_hidden").value="";
		//document.getElementById("noteAcquistoOnline").value="";
	<% //} 
	%>
}


 openDivSterilizzazione();
 abilitaSelezionePropDet(<%=User.getSiteId()%>);
 
 <% if (request.getAttribute("flagFuoriRegione")!=null || request.getAttribute("flagAcquistoOnline")!= null || 
	    request.getAttribute("origine_da")!=null || request.getAttribute("origine_da")!=null || request.getAttribute("flagSenzaOrigine")!=null){  %>
	    gestioneOrigineDopoReloadPagina();
 <% }else{ %>
	document.getElementById("radio_tipo_origine").style.display="none";
	document.getElementById("dati_ritrovamento").style.display="none";
   	document.getElementById("proprietarioProvenienza").style.display="none";
	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

	document.getElementById("microchipMadreDiv").style.display="none";
    <%}%>
	document.getElementById("provenienza_da_altra_nazione").style.display="none";
	document.getElementById("utProvenienzaEstera").style.display="none";
	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
	 document.getElementById("noteAcquistoOnline").style.display="none";
	//$('#flagSenzaOrigine').attr('checked', true);
	//CheckGenericoOrigineAnimale(document.getElementById("flagSenzaOrigine"));
 <% }} %>
 
 
 function mostraOrigine(){
	 var oggi = new Date();
	 var from =$("#dataNascita").val().split("/");
	 var data_reg = new Date(from[2], from[1] - 1, from[0]);
	 var timeinmilisec = oggi.getTime()-data_reg.getTime();
	 var giorni=(Math.floor(timeinmilisec / (1000 * 60 * 60 * 24)));
	 var idSpecie=($('select[name="idSpecie"]').val());
	 var tipologia_proprietario="0";
	 if (document.getElementById("tipologia_proprietario")!=null)
		 tipologia_proprietario=document.getElementById("tipologia_proprietario").value;
	 if(idSpecie==null)
		 idSpecie=$("#idSpecie").val();
		 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>
	 if((tipologia_proprietario=="1" || tipologia_proprietario=="4" || tipologia_proprietario=="5" || tipologia_proprietario=="6" || tipologia_proprietario=="8") && idSpecie=="1"){
		 <%}else{%>
		 	 if((giorni<365 && tipologia_proprietario=="1" || tipologia_proprietario=="4" || tipologia_proprietario=="5" || tipologia_proprietario=="6" || tipologia_proprietario=="8") && idSpecie=="1"){
		 
		 <%}%>
		 document.getElementById("origine_table").style.removeProperty("display");
		 document.getElementById("provenienza_da_altra_regione").style.removeProperty("display");
		 $("#abilita_origine").val("true");
	 }else{
		 document.getElementById("origine_table").style.display="none";
		 //document.getElementById("provenienza_da_altra_regione").style.display="none";
		 $("#abilita_origine").val("false");

	 }
 }
 
 function abilitaNoteOnline(){
	 
	var myselect = document.getElementById("sitoWebAcquisto");
	if(myselect.options[myselect.selectedIndex].value=="Altro"){
		 document.getElementById("noteAcquistoOnline").style.removeProperty("display");
	 }else{
		 document.getElementById("noteAcquistoOnline").style.display="none";
		 document.getElementById("noteAcquistoOnline").value="";
	 }
 }
 
 
 function win_open_search_delegato(id_linea){
		win=window.open('OperatoreAction.do?command=SearchForm&tipologiaSoggetto=2'+id_linea+'&popup=true&aslAll=no','','scrollbars=1,width=800,height=600');
	  if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock();document.getElementById('modalWindow').style.display='none'; } }, 1000); }
	}

	function win_open_add_delegato(id_linea){
		win= window.open('OperatoreAction.do?command=Add&tipologiaSoggetto=2&'+id_linea+'&popup=true&aslAll=no','','scrollbars=1,width=800,height=600');
	  if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock(); document.getElementById('modalWindow').style.display='none';} }, 1000); }
	}
 
 
		 	<% if(ApplicationProperties.getProperty("flusso_336_req2").equals("true")){ %>

function win_open_add_origine(tipologiaSoggetto, popup, id_linea){
  if($("input[name=origine_da]:checked").val() == "fuori_regione"){
		win= window.open('OperatoreAction.do?command=OrigineAdd&tipologiaSoggetto='+tipologiaSoggetto+'&<%=lineaProduttivaFiltro%>&popup='+popup+'&idLineaProduttiva='+id_linea+'&in_regione=no','','scrollbars=1,width=800,height=600');
  }else if($("input[name=origine_da]:checked").val() == "nazione_estera"){
		win= window.open('OperatoreAction.do?command=OrigineAdd&tipologiaSoggetto='+tipologiaSoggetto+'&<%=lineaProduttivaFiltro%>&popup='+popup+'&idLineaProduttiva='+id_linea+'&in_regione=no&nazione_estera=si','','scrollbars=1,width=800,height=600');
  }
  
  if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock(); document.getElementById('modalWindow').style.display='none'; } }, 1000); }
}

<%}else{%>


function win_open_add_origine(tipologiaSoggetto, popup, id_linea){
	  if($("input[name=origine_da]:checked").val() == "in_regione"){
			win= window.open('OperatoreAction.do?command=OrigineAdd&tipologiaSoggetto='+tipologiaSoggetto+'&<%=lineaProduttivaFiltro%>&popup='+popup+'&idLineaProduttiva='+id_linea+'&in_regione=si','','scrollbars=1,width=800,height=600');
	  }else{
			win= window.open('OperatoreAction.do?command=OrigineAdd&tipologiaSoggetto='+tipologiaSoggetto+'&<%=lineaProduttivaFiltro%>&popup='+popup+'&idLineaProduttiva='+id_linea+'&in_regione=no','','scrollbars=1,width=800,height=600');

		  }
	  
	  if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock(); document.getElementById('modalWindow').style.display='none'; } }, 1000); }
	}

<%}%>


function win_open_search_origine(tipologiaSoggetto, popup){
  if($("input[name=origine_da]:checked").val() == "in_regione"){
		win= window.open('OperatoreAction.do?command=SearchForm&provenienza=si&tipologiaSoggetto='+tipologiaSoggetto+'&popup='+popup+'&in_regione=si','','scrollbars=1,width=800,height=600');
  }else{
		win= window.open('OperatoreAction.do?command=SearchForm&provenienza=si&tipologiaSoggetto='+tipologiaSoggetto+'&popup='+popup+'&in_regione=no','','scrollbars=1,width=800,height=600');
  }
  if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock();document.getElementById('modalWindow').style.display='none'; } }, 1000); }
}

function win_open_add_proprietario(tipologiaSoggetto, popup, id_linea){
	var aslAll = 'no';
	if($('#flagAttivitaItinerante').is(':checked')) { aslAll = 'si' }
	if(document.getElementById('flagFuoriRegione_propr')!= null && document.getElementById('flagFuoriRegione_propr').checked) {
		win= window.open('OperatoreAction.do?command=Add&estero=no&tipologiaSoggetto='+tipologiaSoggetto+'&<%=lineaProduttivaFiltro%>&popup='+popup+'&idLineaProduttiva='+id_linea+'&in_regione=no&aslAll='+aslAll,'','scrollbars=1,width=800,height=600');
	  }else{
			win= window.open('OperatoreAction.do?command=Add&tipologiaSoggetto='+tipologiaSoggetto+'&<%=lineaProduttivaFiltro%>&popup='+popup+'&idLineaProduttiva='+id_linea+'&in_regione=si&aslAll='+aslAll,'','scrollbars=1,width=800,height=600');
	  }
	  if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock(); document.getElementById('modalWindow').style.display='none';} }, 1000); }	
	}

	function win_open_search_proprietario(tipologiaSoggetto, popup){
	  var aslAll = 'no';
	  if($('#flagAttivitaItinerante').is(':checked')) { aslAll = 'si' }
	  if(document.getElementById('flagFuoriRegione_propr')!= null && document.getElementById('flagFuoriRegione_propr').checked) {
			win= window.open('OperatoreAction.do?command=SearchForm&estero=no&tipologiaSoggetto='+tipologiaSoggetto+'&popup='+popup+'&in_regione=no&aslAll='+aslAll,'','scrollbars=1,width=800,height=600');
	  }else{
			win= window.open('OperatoreAction.do?command=SearchForm&tipologiaSoggetto='+tipologiaSoggetto+'&popup='+popup+'&in_regione=si&aslAll='+aslAll,'','scrollbars=1,width=800,height=600');
	  }
		  if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock(); document.getElementById('modalWindow').style.display='none';} }, 1000); }
	}
	
<%
if(request.getAttribute("ErrorBlocco")!=null && !((String)request.getAttribute("ErrorBlocco")).equals("")){
%>
alert("<%=((String)request.getAttribute("ErrorBlocco"))%>");
<%
}	
%>

if (document.forms[0].ruolo.value != '24' && document.forms[0].ruolo.value != '37')
{
	document.addAnimale.idVeterinarioMicrochip.value=-1;
}

var innerHTMLtrVeterinarioChippatura = document.getElementById('trVeterinarioChippatura').innerHTML;
initDiv();

nascondiVetChippatore(document.getElementById('flagFuoriRegione'),document.getElementById('idVeterinarioMicrochip'));



<%
if (ApplicationProperties.getProperty("VAM_ID").equals(session.getAttribute("caller")))
{ 
%>
	getDatiAnimaleSinaaf(document.forms[0].microchip);

<%
}
%>








function getDatiAnimaleMadre(campoIn,campoin2,campoin3,campoin4)
{	  
	loadModalWindow();
	document.getElementById('modalWindow').style.display = 'block';

	  if($("input[name=origine_da]:checked").val() == "fuori_regione"){
		document.addAnimale.idAnimaleMadre.value=-1;
	  Animale.getAnimale(campoIn.value,<%=User.getUserId()%>,getDatiAnimaleSinaafCallBack2);

	  }else{
		  if($("input[name=origine_da]:checked").val() == "nazione_estera"){
			  
		 
			  document.getElementById("mostraProprietarioProvenienza").style.visibility="visible";
			  document.getElementById("mostraProprietarioProvenienza").style.display="block";

			  document.getElementById("nome_proprietario_provenienza").innerHTML="";
			  document.getElementById("cfProv").value="";
			  document.getElementById("ragioneSocialeProv").value="";
			  document.getElementById("mostraProprietarioProvenienza").display="block";
			  document.getElementById("CFProp").value='';
				 document.getElementById("dataMadre").value='';
			  document.getElementById("mostraProprietarioProvenienza").visibility="visible";

			  Animale.getAnimale(campoIn.value,<%=User.getUserId()%>,getDatiAnimaleSinaafCallBack2);
			  Animale.getAnimaleMadre(campoIn.value,campoin2.value,campoin3.value,campoin4.value.toUpperCase(),<%=User.getUserId()%>,getDatiAnimaleMadreCallBack);

		  }else{
		  Animale.getAnimaleMadre(campoIn.value,campoin2.value,campoin3.value,campoin4.value.toUpperCase(),<%=User.getUserId()%>,getDatiAnimaleMadreCallBack);
		  }
		  
	  }
	  
	  
	 
}


var data_sterilizzazione_madre
var data_decesso_madre

function getDatiAnimaleMadreCallBack(value)
{
	  var data = value[7]
	  
	  data = Date.parse(data)
	  data = data - 15552000000
	  data_sterilizzazione_madre = value[10];
	  data_decesso_madre = value[11];
	  console.log("data decesso: ", data_decesso_madre);
	  console.log("data sterilizzazione: ", data_sterilizzazione_madre);
	
	  	if($("input[name=origine_da]:checked").val() == "nazione_estera"){
	
	  		
	  		if(value!=null && value[4]!=null){
	  			var msg = "Attenzione! La provenienza di questo MC non è estera.";
			  alert(msg);
			  document.getElementById("mostraProprietarioProvenienza").style.visibility="hidden";
			  document.getElementById("mostraProprietarioProvenienza").style.display="none";
			  document.getElementById("microchipMadre").value='';
			  document.getElementById("idProprietarioProvenienza").value='-1';
			  document.getElementById("cfProv").value='';
			  document.getElementById("ragioneSocialeProv").value='';
			  document.getElementById("nome_proprietario_provenienza").innerHTML='';
			  document.getElementById("CFProp").value='';
				 document.getElementById("dataMadre").value='';
	  	}
	  
	  
	  loadModalWindowUnlock();
		document.getElementById('modalWindow').style.display = 'none';
return;

	  	}
	  
	  
		if(document.getElementById("dataNascita").value == "" || document.getElementById("dataNascita").value == null ){
			 var msg = "Attenzione! inserire prima la data nascita del cucciolo";
			  alert(msg)
				document.addAnimale.idAnimaleMadre.value=-1;
		  		document.getElementById("dataNascitaMadre").value="";	

				 document.getElementById("microchipMadre").value='';
				 document.getElementById("CFProp").value='';
				 document.getElementById("dataMadre").value='';
				 document.getElementById('mostraProprietarioProvenienza').style.display = 'none';
				 loadModalWindowUnlock();
					document.getElementById('modalWindow').style.display = 'none';
					return;
				 
		}else {
			
			var data_nascita_figlio_format = (Date.parse(document.getElementById("dataNascita").value));
			var data_sterilizzazione_format = (Date.parse(data_sterilizzazione_madre));
			var data_decesso_format = (Date.parse(data_decesso_madre));
			console.log(data_nascita_figlio_format);
			console.log(data_decesso_format);
			if(!isNaN(data_sterilizzazione_format))
				if(data_sterilizzazione_format < data_nascita_figlio_format){
					var msg = "Attenzione! L' animale ricercato risulta sterilizzato";
					  alert(msg)
						document.addAnimale.idAnimaleMadre.value=-1;
				  		document.getElementById("dataNascitaMadre").value="";	

						 document.getElementById("microchipMadre").value='';
						 document.getElementById("CFProp").value='';
						 document.getElementById("dataMadre").value='';
						 document.getElementById('mostraProprietarioProvenienza').style.display = 'none';
						  loadModalWindowUnlock();
							document.getElementById('modalWindow').style.display = 'none';
							return;
				}
			if(!isNaN(data_decesso_format))
				if(data_decesso_format < data_nascita_figlio_format){
					var msg = "Attenzione! L' animale ricercato risulta deceduto";
					  alert(msg)
						document.addAnimale.idAnimaleMadre.value=-1;
				  		document.getElementById("dataNascitaMadre").value="";	

						 document.getElementById("microchipMadre").value='';
						 document.getElementById("CFProp").value='';
						 document.getElementById("dataMadre").value='';
						 document.getElementById('mostraProprietarioProvenienza').style.display = 'none';
						  loadModalWindowUnlock();
							document.getElementById('modalWindow').style.display = 'none';
							return;
				}
					
				
		}
	 	 
	  
	  if(value != null && value[8]=="true")
	  {
		  var msg = "Attenzione! Per i dati specificati non è stato trovato nessun cane femmina";
		  if(value!=null && value[0]!=null)
		  		msg+="\n- Data nascita: " + value[0];
		  if(value!=null && value[1]!=null)
		  		msg+="\n- Nome: " + value[1];
		  if(value!=null && value[2]!=null)
		  		msg+="\n- Data chippatura: " + value[2];
		  if(value!=null && value[3]!=null)
		  		msg+="\n- Sesso: " + value[3];
		  
		  //msg+="\nSi desidera acquisirli nella maschera di inserimento?"
		 // alert(msg);
				
		  		
		  
		  
			  	if(value!=null && value[1]!=null)
			  		{
					document.addAnimale.idProprietarioProvenienza.value=value[1];
			  		}
			  	if(value!=null && value[4]!=null)
		  		{
				document.addAnimale.idAnimaleMadre.value=value[4];
		  		}
				if(value!=null && value[7]!=null)
		  		{
				document.getElementById("dataNascitaMadre").value=value[7];
		  		}
			  	
			  	if(value!=null && value[5]!=null)
		  		{
			  		document.getElementById("nome_proprietario_provenienza").innerHTML= value[5];	
		  		}else{
		  			var msg = "Attenzione! Per i dati specificati non è stato trovato nessun cane femmina";
		  		  alert(msg)
		  			document.addAnimale.idAnimaleMadre.value=-1;
		  			 document.getElementById("microchipMadre").value='';
		 	  		document.getElementById("dataNascitaMadre").value="";	
		 	  		document.getElementById("microchipMadre").value='';
					  document.getElementById("idProprietarioProvenienza").value='-1';
					  document.getElementById("cfProv").value='';
					  document.getElementById("ragioneSocialeProv").value='';
					  document.getElementById("nome_proprietario_provenienza").innerHTML='';
					  document.getElementById("CFProp").value='';
						 document.getElementById("dataMadre").value='';
						 document.getElementById('mostraProprietarioProvenienza').style.display = 'none';

					  loadModalWindowUnlock();
						document.getElementById('modalWindow').style.display = 'none';
						return;
		  		}

			  	
	  }else{
	  var msg = "Attenzione! Per i dati specificati non è stato trovato nessun cane femmina";
	  alert(msg)
		document.addAnimale.idAnimaleMadre.value=-1;
		 document.getElementById("microchipMadre").value='';
	  		document.getElementById("dataNascitaMadre").value="";	
	  		document.getElementById("microchipMadre").value='';
			  document.getElementById("idProprietarioProvenienza").value='-1';
			  document.getElementById("cfProv").value='';
			  document.getElementById("ragioneSocialeProv").value='';
			  document.getElementById("nome_proprietario_provenienza").innerHTML='';
			  document.getElementById("CFProp").value='';
				 document.getElementById("dataMadre").value='';
				 document.getElementById('mostraProprietarioProvenienza').style.display = 'none';

			  loadModalWindowUnlock();
				document.getElementById('modalWindow').style.display = 'none';
				return;

	  }
	  
	
	 
	  
	  
	  if (document.addAnimale.idAnimaleMadre.value==-1){
		  var msg = "Attenzione! Per i dati specificati non è stato trovato nessun cane femmina";
		  alert(msg)
			document.addAnimale.idAnimaleMadre.value=-1;
	  		document.getElementById("dataNascitaMadre").value="";	

			 document.getElementById("microchipMadre").value='';
			 document.getElementById("CFProp").value='';
			 document.getElementById("dataMadre").value='';
			 document.getElementById('mostraProprietarioProvenienza').style.display = 'none';

	  }

		loadModalWindowUnlock();
		document.getElementById('modalWindow').style.display = 'none';
		
	
}



function getDatiAnimaleSinaafCallBack2(value)
{
	
	if($("input[name=origine_da]:checked").val() == "nazione_estera"){
		
		
		
		
		if(value[8] !="Entity not found"){
		var msg = "Attenzione! La provenienza di questo MC non è estera.";
		  alert(msg);
		  document.getElementById("mostraProprietarioProvenienza").style.visibility="hidden";
		  document.getElementById("mostraProprietarioProvenienza").style.display="none";
		  document.getElementById("microchipMadre").value='';
		  document.getElementById("idProprietarioProvenienza").value='-1';
		  document.getElementById("cfProv").value='';
		  document.getElementById("ragioneSocialeProv").value='';
		  document.getElementById("CFProp").value='';
			 document.getElementById("dataMadre").value='';
		 
		}
		
		 loadModalWindowUnlock();
			document.getElementById('modalWindow').style.display = 'none';
	return;

}

	if ((value[9] !=null &&  value[9] != "") ){
		  var msg = "Attenzione! La madre è in regione";
		 document.getElementById("nome_proprietario_provenienza").innerHTML="";
		  document.getElementById("cfProv").value="";
		  document.getElementById("ragioneSocialeProv").value="";
		  document.getElementById("microchipMadre").value='';
		  document.getElementById("CFProp").value='';
			 document.getElementById("dataMadre").value='';

		  alert(msg);
			document.addAnimale.idAnimaleMadre.value=-1;
			loadModalWindowUnlock();
			document.getElementById('modalWindow').style.display = 'none';
			return;
	  }
	 document.getElementById("CFProp").style.display="";
	 document.getElementById("dataMadre").style.display="";
	  if (value[8] =="Entity not found"){
		  var msg = "Attenzione! Sul portale nazionale non è stato trovato nessun animale per questo microchip, si prosegue ad inserire manualmente il proprietario ";
		  document.getElementById("mostraProprietarioProvenienza").style.visibility="visible";
		  document.getElementById("mostraProprietarioProvenienza").style.display="block";
		  document.getElementById("CFProp").style.display="none";
			 document.getElementById("dataMadre").style.display="none";
		  document.getElementById("nome_proprietario_provenienza").innerHTML="";
		  document.getElementById("cfProv").value="";
		  document.getElementById("ragioneSocialeProv").value="";


		  alert(msg);
			document.addAnimale.idAnimaleMadre.value=-1;
			loadModalWindowUnlock();
			document.getElementById('modalWindow').style.display = 'none';
			return;
	  }
	
	  var check = true;
	  if(document.addAnimale.dataMadre.value!=value[0])
		  {
		  check = false;
		  
		  }
	  if(document.addAnimale.CFProp.value!=value[7])
	  	{
		check = false;
	  	}
		 
	  
	  
	  if(value!=null && value[5]=="1" && value[3]=="F" && value[4] != "NA" && value[4] != "SA" && value[4] != "CE" && value[4] != "AV" && value[4] != "BN" && check==true)
	  {
		  var msg = "Attenzione! Sul portale nazionale sono stati riscontrati i seguenti dati relativi all'animale con il microchip inserito: ";
		  if(value!=null && value[0]!=null)
		  		msg+="\n- Data nascita: " + value[0];
		  if(value!=null && value[1]!=null)
		  		msg+="\n- Nome: " + value[1];
		  if(value!=null && value[2]!=null)
		  		msg+="\n- Data chippatura: " + value[2];
		  if(value!=null && value[3]!=null)
		  		msg+="\n- Sesso: " + value[3];
		  if(value!=null && value[4]!=null)
		  		msg+="\n- Provincia: " + value[4];
		  if(value!=null && value[5]!=null)
		  		msg+="\n- Specie: " + value[5];
		  if(value!=null && value[6]!=null)
		  		msg+="\n- Ragione: " + value[6];
		  if(value!=null && value[7]!=null)
		  		msg+="\n- CF: " + value[7];
		  
		  
		  //msg+="\nSi desidera acquisirli nella maschera di inserimento?"
		  alert(msg);
				if(value!=null && value[0]!=null)
					{
						document.getElementById("dataNascitaMadre").value=value[0];				
						}
			  	if(value!=null && value[1]!=null)
			  		{
			  		//document.addAnimale.nome.value=value[1];
			  		//document.addAnimale.nome.readOnly="readonly";
			  		}
			  	if(value!=null && value[2]!=null)
			  		//document.addAnimale.dataMicrochip.value=value[2];
			  	if(value!=null && value[3]!=null)
			  		///document.addAnimale.sesso.value=value[3];
			  		if(value!=null && value[6]!=null){
				  		document.getElementById("nome_proprietario_provenienza").innerHTML= value[6];	
				  		document.getElementById("ragioneSocialeProv").value= value[6];	

			  		}
			  		if(value!=null && value[7]!=null){
				  		document.getElementById("cfProv").value= value[7];
				  		document.getElementById("nome_proprietario_provenienza").innerHTML= value[7];	
						 document.getElementById("mostraProprietarioProvenienza").style.visibility="hidden";

			  		}
			  	
	  }
	  else
		  {
		  var msg = "Attenzione! Sul portale nazionale sono stati riscontrati i seguenti problemi: ";

		  	if(value!=null && value[4]!=null && (value[4] == "NA" || value[4] == "SA" || value[4] == "CE" || value[4] == "AV" || value[4] == "BN" ))
		  			msg+="\n- PROVINCIA IN REGIONE: " + value[4];
		  	if(value!=null && value[3]!=null && value[3]!="F")
	  			msg+="\n- SESSO NON COMPATIBILE: " + value[3];
		  	if(value!=null && value[5]!=null && value[5]!="1")
	  			msg+="\n- SPECIE NON COMPATIBILE: " + value[5];
		  	if(check==false)
		  		msg+="\n DATI ANIMALI NON COMPLETI"
		  			document.getElementById("CFProp").value='';
				 document.getElementById("dataMadre").value='';
				 document.getElementById('mostraProprietarioProvenienza').style.display = 'none';
			  document.getElementById("nome_proprietario_provenienza").innerHTML="";
			  document.getElementById("cfProv").value="";
			  document.getElementById("ragioneSocialeProv").value="";
			  document.getElementById("microchipMadre").value='';

			document.addAnimale.idAnimaleMadre.value=-1;
		  	alert(msg)
		  
		//  document.addAnimale.nome.readOnly=false;
		 // document.getElementById('datanascitaDiv').style.display="block";
		  
		  }
	  loadModalWindowUnlock();
		document.getElementById('modalWindow').style.display = 'none';
}






function verificaMicrochipMadre (campoIn){
	
	
	if((document.getElementById("microchipMadre").value.length<15)&&($("input[name=origine_da]:checked").val() != "nazione_estera")&& ($("input[name=tipo_origine]:checked").val() == "soggetto_fisico")){
	   	var msg = label("", "- Attenzione! Lunghezza Microchip Madre minore di 15 caratteri!\r\n");
			alert(msg);
			return;
	   	}
	
	if(document.getElementById("microchipMadre").value.length=='' && $("input[name=origine_da]:checked").val() == "nazione_estera"){
	   	var msg = label("", "- Attenzione! Valorizzare il microchip della madre\r\n");
			alert(msg);
			return;
	   	}
	
	if(document.getElementById("dataMadre").value=='' && $("input[name=origine_da]:checked").val() != "nazione_estera")
	{
	   	var msg = label("", "- Attenzione! Valorizzare la data di nascita della madre\r\n");
			alert(msg);
			return;
	}
	
	if(document.getElementById("CFProp").value==''  && $("input[name=origine_da]:checked").val() != "nazione_estera")
	{
	   	var msg = label("", "- Attenzione! Valorizzare il codice fiscale del proprietario della madre\r\n");
			alert(msg);
			return;
	}
	
	
	
	document.getElementById("controlloMicrochipMadre").value= document.getElementById("microchipMadre").value
	
	
	
	
	loadModalWindow();
	document.getElementById('modalWindow').style.display = 'block';

	
	
	campo = campoIn ;
  
			getDatiAnimaleMadre(document.forms[0].microchipMadre,document.forms[0].microchip,document.forms[0].dataMadre,document.forms[0].CFProp);
	
	
  const prefixMc = ["040",	 "688","643", "191",	  "208",	  "250",	  "276",	  "280",	  "308",	  "320",	  "348",	  "350",	  "380",	  "384",	  "388",	  "389",	  "390",
	  "480",	  "528",	  "680",	  "724",	  "756",	  "826",	  "830",	  "882",	  "895",	  "900",	  "934",	  "937",	  "938",	  "939",	  "941",	  "944",
	  "945",	  "947",	  "952",	  "953",	  "956",	  "959",	  "967",	  "968",	  "968",	  "972",	  "977",	  "978",	  "980",	  "981",	  "982",	  "985",
	  "987",	  "992"	
];
  
  
   if(campo.value.length==15 && (document.getElementById('flagFuoriRegione')!=null && document.getElementById('flagFuoriRegione').checked==true) )
   {
	   if(false)
	 //if(!prefixMc.includes(campo.value.substring(0,3)))
		 {
		 	alert( "Il Microchip ha un prefisso non valido");
		 	campo.value="";
		 	verificaMc=false;
		 }
	}
   
   
  }





function controlloDate(){

	
	var datafix=""+(document.getElementById("dataNascita").value)+""
	   
	  var giorni= datafix.substring(0,2);
	  
	  var mesi = datafix.substring(3,5);
	  
	  var anni = datafix.substring(6,10);
	  
	  var data=mesi+"/"+giorni+"/"+anni;
	 

	 
	
	
	
	
	
	if(Date.parse(document.getElementById("dataMadre").value)>(Date.parse(document.getElementById("dataNascita").value)))
  {
	  message += label("", "- Attenzione! La data di nascita della madre non è coerente!\r\n");
		document.addAnimale.idProprietarioProvenienza.value=-1;
		document.addAnimale.idAnimaleMadre.value=-1;
  		document.getElementById("nome_proprietario_provenienza").innerHTML= "";	
  		document.getElementById("dataNascitaMadre").value="";	
  		 document.getElementById("CFProp").value='';
		 document.getElementById("dataMadre").value='';
			formTest = false;

	  
  }else{
	  
	  
	  data = Date.parse(data)
	   data = data - 15552000000
	  
	   
	   var datafix2=""+(document.getElementById("dataMadre").value)+""
	   
		  var giorni2= datafix2.substring(0,2);
		  
		  var mesi2 = datafix2.substring(3,5);
		  
		  var anni2 = datafix2.substring(6,10);
		  
		  var data2=mesi2+"/"+giorni2+"/"+anni2;
		  data2 = Date.parse(data2)

	   
	 
	  
	  if(data2>data){
		  message += label("", "- Attenzione! La data di nascita della madre non è coerente!\r\n");
			document.addAnimale.idProprietarioProvenienza.value=-1;
			document.addAnimale.idAnimaleMadre.value=-1;
	  		document.getElementById("nome_proprietario_provenienza").innerHTML= "";	
	  		document.getElementById("dataNascitaMadre").value="";
	  		 document.getElementById("CFProp").value='';
			 document.getElementById("dataMadre").value='';
  			formTest = false;
	  }
	  
  }
}

</script>




<script type="text/javascript">
	if(document.getElementById('flagSenzaOrigine')!=null && document.getElementById('flagSenzaOrigine').checked==true)
	{
		document.getElementById('flagSenzaOrigine').disabled=false;
		document.getElementById('flagSenzaOrigine').style.display='';
	}
	
	
	
<%
	if((animale.getIdSpecie() == Cane.idSpecie && Cane.getIdVeterinarioMicrochip()<=0) || (animale.getIdSpecie() == Gatto.idSpecie && Gatto.getIdVeterinarioMicrochip()<=0))
	{
%>
	if (document.forms[0].ruolo.value != '24' && document.forms[0].ruolo.value != '37')
	{
		document.addAnimale.idVeterinarioMicrochip.value=-1;
	}
	
<%
	}
%>
	
</script>
