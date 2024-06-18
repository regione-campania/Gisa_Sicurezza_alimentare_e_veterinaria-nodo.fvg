<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page import="java.io.*,java.util.*,org.aspcfs.utils.web.*"%>

<%@page import="org.aspcfs.modules.anagrafe_animali.base.Animale"%>

<%@page import="org.aspcfs.modules.system.base.SiteList"%>
<%@page import="org.aspcfs.modules.opu.base.StabilimentoList"%>
<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoRegistrazioneBDU,org.aspcfs.modules.opu.base.*"%>
<%@page import="org.aspcfs.modules.system.base.SiteList"%>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<!-- <script src="https://code.jquery.com/jquery-1.8.2.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.9.1/jquery-ui.js"></script> -->
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.EventoRegistrazioneBDU" scope="request" />

<jsp:useBean id="Cane"
	class="org.aspcfs.modules.anagrafe_animali.base.Cane" scope="request" />
<jsp:useBean id="Gatto"
	class="org.aspcfs.modules.anagrafe_animali.base.Gatto" scope="request" />
<jsp:useBean id="Furetto"
	class="org.aspcfs.modules.anagrafe_animali.base.Furetto"
	scope="request" />

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<jsp:useBean id="utenteInserimento" class="org.aspcfs.modules.admin.base.User"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="regioniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="specieList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="razzaList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="tagliaList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="mantelloList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="esitoControlloList"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="animale"
	class="org.aspcfs.modules.anagrafe_animali.base.Animale"
	scope="request" />
<jsp:useBean id="oldAnimale"
	class="org.aspcfs.modules.anagrafe_animali.base.Animale"
	scope="request" />
<jsp:useBean id="praticacontributi"
	class="org.aspcfs.modules.praticacontributi.base.Pratica"
	scope="request" />
<jsp:useBean id="veterinariList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="rilascioPassaporto"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoRilascioPassaporto"
	scope="request" />
<jsp:useBean id="nazioniList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="comuniList_all" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="provinceList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/Animale.js"></script>

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/dateControl.js"></script>
<script type="text/javascript" src="dwr/interface/DwrUtil.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/PraticaList.js"> </script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/LineaProduttiva.js"> </script>



<script>

$(document).ready(function() {
	
	$("#dialog").dialog({
        autoOpen: false,
        resizable: false,
        modal: true,
        title: 'Attenzione!',
        close: function () {
           // $('#opener').button('refresh');
            },
        buttons: {
            'Prosegui': function() {
                
                if (!$.trim($("#motivazioneModificaPopup").val())) {
                	$("#motivazioneModificaPopup").css('border', '1px solid red');
                	$("#motivazioneModificaPopup").css('margin-top', '0px');
                	$("#testo").css('color', 'red');
                	
                    return false;
                }else{
                	$(this).dialog('close');
                 //   alert( $("#motivazioneModificaPopup").val());
                    $("#motivazioneModifica").val($("#motivazioneModificaPopup").val());
               //     alert( $("#motivazioneModifica").val());
                        
                }
                
            	loadModalWindow(); //ATTENDERE PREGO     
                $("#addAnimale").submit();    
            },
            'Rinuncia': function() {
                $(this).dialog('close');
               return false;
            }
        }
    });



});



var campo ;


function checkForm(form) 
{
	formTest = true;
	message = "";
	if (form.nome.value == "") 
	{ 
		message += label("nome.required", "- Selezionare un valore per il nome\r\n");
		formTest = false;
	}
	
	 if (formTest == false) {
	      alert(label("check.form", "I dati non possono essera salvati, per favore verifica le seguenti informazioni:\r\n\r\n") + message);
	      return false;
	    }
	    else
	    {    $('#dialog').dialog('open');
	      	return true;
	    }
}


</script>

<%@ include file="../initPage.jsp"%>

<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td><a href="AnimaleAction.do?command=Search"><dhv:label
						name="">Ricerca animali</dhv:label></a> > <a
				href="AnimaleAction.do?command=Details&animaleId=<%=animale.getIdAnimale()%>&idSpecie=<%=animale.getIdSpecie()%>"><dhv:label
						name="">Dettagli animale</dhv:label></a> > <dhv:label name="">Modifica</dhv:label>
			</td>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>
<body>
	<form name="addAnimale" id="addAnimale"
		action="AnimaleAction.do?command=UpdateAsl&auto-populate=true<%=addLinkParams(request, "popup|popupType|actionId")%>"
		method="post">
		<input type="hidden" name="idAnimale" value="<%=animale.getIdAnimale()%>">
		<input type="hidden" name="ruolo" value="<%=User.getRoleId()%>">
		<input type="hidden" value="<%=utenteInserimento.getRoleId()%>"  name="ruoloUtenteInserimento" id="ruoloUtenteInserimento"/>
		<table class="">
			<input type="button"
				value="<dhv:label name="global.button.save">Save</dhv:label>"
				onClick="if(checkForm(this.form)){this.form.submit()};" />
			<table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details">
				<tr>
					<th colspan="2"><strong><dhv:label
								name="accounts.accountasset_include.SpecificInformation">Specific Information</dhv:label></strong>
					</th>
				</tr>

				<tr class="containerBody">
					<td class="formLabel"><dhv:label name="">Nome </dhv:label></td>
			
					
    				<!-- SINAAF ADEGUAMENTO -->
					  <td><input type="text" size="30" id="nome" name="nome"maxlength="41" value="<%=toHtmlValue(animale.getNome())%>"><%=showAttribute(request, "nome")%>	<font color="red">*</font></td>
				
				</tr>
				</table>
			</form>


