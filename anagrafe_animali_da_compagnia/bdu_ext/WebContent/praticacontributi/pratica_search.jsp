<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.praticacontributi.base.*"%>
<%--<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>--%>
<jsp:useBean id="aslRifList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%--<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>--%>
<jsp:useBean id="pratica" class="org.aspcfs.modules.praticacontributi.base.Pratica" scope="request"/>
<%@ include file="../initPage.jsp"%>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/jquery-ui.js"></SCRIPT>
<!-- 
<SCRIPT LANGUAGE="JavaScript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
</SCRIPT>
 -->

<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<!--   <script src="https://code.jquery.com/jquery-1.8.2.js"></script> -->
<!--     <script src="https://code.jquery.com/ui/1.9.1/jquery-ui.js"></script> -->


<script language="JavaScript">

$( document ).ready( function(){
	calenda('dataDecreto','','0');
	calenda('dataInizioSterilizzazione','','0');
	calenda('dataFineSterilizzazione','','');
});

  function clearForm() {
	  if (document.forms['searchPratica'].dataFineSterilizzazione){
		  document.forms['searchPratica'].dataFineSterilizzazione.value = '';
		  }
	  if (document.forms['searchPratica'].dataInizioSterilizzazione){
		  document.forms['searchPratica'].dataInizioSterilizzazione.value = '';
		  }
	  if (document.forms['searchPratica'].dataDecreto){
		  document.forms['searchPratica'].dataDecreto.value = '';
		  }
	  if (document.forms['searchPratica'].searchcodenumeroDecretoPratica){
		  document.forms['searchPratica'].searchcodenumeroDecretoPratica.value = '';
		  }
	   if (document.forms['searchPratica'].aslRif){
		  document.forms['searchPratica'].aslRif.selectedIndex = 0;
		  }
	   if (document.forms['searchPratica'].comuneScelto){
			  document.forms['searchPratica'].comuneScelto.selectedIndex= -1;
			  }
	  
  }
 
  
  function checkForm(form) {
   	formTest = true;
    message = "";
    
    if(document.getElementById('tipoProgetto')!=null && document.getElementById('tipoProgetto').value=="-1")
    {
    	message = "- Selezionare un tipo progetto"
    	formTest = false;
    }

  	if (formTest == false) {
      alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
      return false;
    }
  	else
  		{
  			document.searchPratica.submit();
  			loadModalWindow();
  		}
  }
  
  function init() {
		
	  } 


  function popolaCampi(){
	  var idAsl = "-1";
	//  alert($("#aslRif").is("input"));
	  
	  if ($("#aslRif").is("input")){
		  idAsl = $('#aslRif').val();
		//  alert('è hidden');

		  }else{ 
				idAsl = $("#aslRif").children("option:selected").val();
			//	alert('è select');
		  }
	//alert(idAsl);
	if (idAsl > 0){
		 $.ajax({
			  
		        type: "GET",
		        url: "./ServletComuni?combo=5&idAsl="+idAsl,
		        async: false,
		        dataType: "json",
		        error: function(XMLHttpRequest, status, errorThrown) {
		            alert("oh no!");
		            alert(status);
		        },
		        success: function (data, status) {
		        	//alert(data);
		            var options = '';
		            for (var i = 0; i < data.length; i++) {
		            	var row = data[i];
		              options += '<option value="' +row['codice'] + '">' + row['descrizione'] + '</option>';
		            }
		            $("#comuneScelto").html(options);

					
		         //   alert("success");
		           
		        	
		        },
		        complete: function() {
		        	
		        }
		    });
	}
	}



  $(document).ready(function() {

	   popolaCampi();
		
	$("#aslRif").change(function() {

		popolaCampi();

	});
	});
  
</script>
<body onload="javascript:init();clearForm();">
<%-- Trails --%>
<table class="trails" cellspacing="0">
	<tr>
		<td width="100%"><a href="">
		<dhv:label name="">Pratica Contributi</dhv:label></a> > <dhv:label name="">Cerca Pratica Contributi </dhv:label>
		</td>
	</tr>
</table>
<%-- End Trails --%>
<form name="searchPratica" action="PraticaContributi.do?command=SearchList&auto-populate=true" onSubmit="return checkForm(this);" method="post">

<table cellpadding="2" cellspacing="2" border="0" width="100%">
	<tr>
			<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
			<tr>
				<th colspan="2"><strong>
					<dhv:label  name="">Filtri informazioni Pratica Contributo</dhv:label></strong>
				</th>
			</tr>
			<!-- Flusso 251: modifiche del 03/08 - INIZIO -->
			
			<tr>
       	  		<td nowrap class="formLabel">
           		   <dhv:label name="">Tipo progetto</dhv:label>
           		</td>
           		<td>	
        		<select id="tipoProgetto" name="tipoProgetto">
        			<option value="-1">&lt;-- Selezionare una voce --&gt;</option>
        			<option value="1">Per comuni</option>
        			<option value="2">Per canili</option>
        		</select>
      		
  			</td>
        </tr>
        
        <!-- Flusso 251: modifiche del 03/08 - FINE -->
        
        
			<tr>
       	  		<td nowrap class="formLabel">
           		   <dhv:label name="">Asl di Riferimento</dhv:label>
           		</td>
           		<td>	
        		<dhv:evaluate if="<%= (User.getSiteId() > 0) %>">
  		    		<%=aslRifList.getSelectedValue(User.getSiteId())  %>
  		    		 <input type="hidden" id="aslRif" name="aslRif" value="<%= User.getSiteId() %>" />
  		    	</dhv:evaluate>
 		  
 		    	<dhv:evaluate if="<%= (User.getSiteId() <= 0) %>" >
  					<%= aslRifList.getHtmlSelect("aslRif", -1 ) %>
  					<input type="hidden" name="aslRifHidd" value="-1" />
  				</dhv:evaluate>  
      		
  			</td>
        </tr>
        
        
        <tr>
        		<td class="formLabel"><dhv:label name="">Comune</dhv:label></td>
				<td>
				
				<select name="comuneScelto" id="comuneScelto" ></select>
					<!-- input type="text" name="comuneScelto" size="20" maxlength="30"/ -->
				</td>
        </tr>
       	<tr class="containerBody">
				<td class="formLabel"><dhv:label
					name="">Numero Decreto</dhv:label>
				</td>
				<td>
					<input type="text" name="searchcodenumeroDecretoPratica" size="10"/>
				</td>
			</tr>
			
			<tr class="containerBody">
				<td class="formLabel"><dhv:label name="">Data Decreto</dhv:label></td>
				<td>
				<input class="date_picker" type="text" name="dataDecreto" id="dataDecreto" size="10"/>
    					&nbsp;
				</td>
			</tr>
			
			<tr class="containerBody">
				<td class="formLabel"><dhv:label
					name="">Data Inizio Sterilizzazione</dhv:label>
				</td>
				<td>
						<input class="date_picker" type="text" name="dataInizioSterilizzazione" id="dataInizioSterilizzazione" size="10"/>
    					&nbsp;
				</td>
			</tr>
			
			<tr class="containerBody">
				<td class="formLabel"><dhv:label
					name="">Data Fine Sterilizzazione</dhv:label>
				</td>
				<td>
						<input class="date_picker" type="text" name="dataFineSterilizzazione" id="dataFineSterilizzazione" size="10" onclick="checkDataFine('dataInizioSterilizzazione','dataFineSterilizzazione')"/>
    					&nbsp;
	      				
				</td>
			</tr>
			
			<tr class="containerBody">
				<td class="formLabel"><dhv:label
					name="">Stato Pratica</dhv:label>
				</td>
				<td>
				<input type="radio" name="searchcodeStatoP" value= "1"  > Chiuse
            	<input type="radio" name="searchcodeStatoP" value= "2" > Aperte
            	<input type="radio" name="searchcodeStatoP" value= "3" checked="checked" > Tutte
           		</td>
			</tr>
		
		</table>
		<br />		
        <input type="button" value="<dhv:label name="button.search">Search</dhv:label>" onClick="javascript:checkForm();"> 
		<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="javascript:clearForm();">
</form>

</body>

