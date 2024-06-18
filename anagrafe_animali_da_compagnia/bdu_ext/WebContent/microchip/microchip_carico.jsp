<%@page import="java.util.Date"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.microchip.base.*,java.text.DateFormat" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="produttoreMCList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<%@ include file="../initPage.jsp" %>

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />


<script language="JavaScript" TYPE="text/javascript" SRC="javascript/modalWindow.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/dateControl.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/Animale.js"> </script>
<!-- 
<SCRIPT LANGUAGE="JavaScript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
</SCRIPT>
 -->
<script language="JavaScript">
	$( document ).ready( function(){
		calenda('dataScadenzaMC','1','');
	});
	
	function doCheck(form) {
		
		
      if (form.dosubmit!=null && form.dosubmit.value == "false") {
         	return true;
     } else {
    	 
    	 return(checkMC(form));
     }
   	}
   	
	function checkMC(){
		
		var _MS_PER_DAY = 1000 * 60 * 60 * 24;
		formTest = true;
    	message = "";
    	if ( !( (document.getElementById('microchip').value.length == 15) && ( /^([0-9]+)$/.test( document.getElementById('microchip').value )) ) ){
    		message += label("", "- La lunghezza del microchip deve essere di 15 caratteri numerici\r\n");
      		formTest = false;
    	}
    	
    	if (document.getElementById('ruolo').value == '24'){
    		 if (  !(document.getElementById('microchip').value.substring(0, 6) == "380260")){
    			 message += label("","- MC non valido: selezionare un Mc del tipo 380260... \r\n");
    			 formTest = false;
    		 }
    			
    		}
    /* 	SINAAF ADEGUAMENTO */
    		if (document.getElementById('dataScadenzaMC').value == ''){
    			 message += label("","- La data scadenza  del microchip deve inserita.  \r\n");
    			 formTest = false;
    		 }
    		else{
    			var datascadenzaT = document.getElementById('dataScadenzaMC').value.replace(/(\d+[/])(\d+[/])/, '$2$1');
    			var datascadenza = new Date(datascadenzaT);
    			var dataCorrente= new Date();

    			var utc1 = Date.UTC(datascadenza.getFullYear(), datascadenza.getMonth(),datascadenza.getDate());
    			var utc2 = Date.UTC(dataCorrente.getFullYear(), dataCorrente.getMonth(), dataCorrente.getDate());

    			if ( Math.floor((utc2 - utc1) / _MS_PER_DAY)> 0 ) {
    				 message += label("","- La data scadenza  del microchip inferiore alla data odierna .  \r\n");
   					 formTest = false;
    			}
    		}
       		if (document.getElementById('identifLottoMC').value == ''){
   			 message += label("","- L'identificativo del lotto deve essere inserito.  \r\n");
   			 formTest = false;
   		 }
       		if (document.getElementById('idProduttoreMC').value == '-1'){
   			 message += label("","- Il produttore/distributore del microchip deve essere inserito. \r\n");
   			 formTest = false;
   		 }
       		
       		if (document.getElementById('confezione').value.length == 0)  {
        		message += label("", "- La confezione deve essere inserita. \r\n");
          		formTest = false;
        	}
       		
   /*     	/* 	if(document.getElementById('ruolo').value!='24' && document.getElementById('idProduttoreMC').value != '-1' &&  document.getElementById('microchip').value.length == 15 && ( /^([0-9]+)$/.test( document.getElementById('microchip').value )) )
       		{
       		var controlloMcProduttore;

    
       		Animale.verificaMcProduttore(microchip.value,document.getElementById('idProduttoreMC').value, {
       			callback:function(data) {
       			if (data != null){
       				controlloMcProduttore = data;
       			}
       			},
       			timeout:8000,
       			async:false

       			});
       		
       		if (controlloMcProduttore!=null){
      			 message += label("","- " + controlloMcProduttore + "\r\n");
      			 formTest = false;
      		 }
       		} */ 
    	
       		if(document.getElementById('ruolo').value!='24' && document.getElementById('idProduttoreMC').value != '-1' &&  document.getElementById('microchip').value.length == 15 && ( /^([0-9]+)$/.test( document.getElementById('microchip').value )) )
       		{
       		var controlloMcPrefisso;

    
       		Animale.verificaMcPrefisso(microchip.value, {
       			callback:function(data) {
       			if (data != null){
       				controlloMcPrefisso = data;
       			}
       			},
       			timeout:8000,
       			async:false

       			});
       		
       		if (controlloMcPrefisso!=null){
      			 message += label("","- " + controlloMcPrefisso + "\r\n");
      			 formTest = false;
      		 }
       		}
       		
       		
       		
    	if (formTest == false) {
      		alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
      		return false;
    	}
		else{

			loadModalWindow();
			document.forms[0].submit();
		}
    	
	}

</script>
<body>
<%-- Trails --%>
<%
String read="";
read=request.getAttribute("MC_FOR_CARICO")!=null ? "readOnly =true" :"";
%>
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
  Carico microchip 
</td>
</tr>

</table>

<% if (request.getAttribute("MC_FOR_CARICO")!=null){ %>

<table  cellspacing="0">
<tr>
<td width="100%">
 
<font size="3" color="red">Compilare le informazioni mancanti.<br>N.B. Chiudendo la pagina ( cliccando la X ) , si ritiene Annullata la scelta del MC.<br></font>

</td>
</tr>

</table>

<%} %>


<%-- End Trails --%>
<form action="Microchip.do?command=EseguiCarico&auto-populate=true" method="post" onSubmit="return checkMC(this);">

<input type="hidden" id="ruolo" name="ruolo" value="<%=User.getRoleId()%>">

<table cellpadding="2" cellspacing="2" border="0" width="100%">
  <tr>
    <td width="100%" valign="top">
    
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	  <tr>
	    <th colspan="2">
		  <strong>Carico Microchip a priori</strong>
		</th>
	  </tr>
	  
	  <tr class="containerBody">
	    <td nowrap class="formLabel">
	 	  Inserisci Microchip
	    </td>
	  
	    <td>
	      <input id="microchip" name="microchip" type="text" size="20" maxlength="15"  <%=read%> value="<%=request.getAttribute("MC_FOR_CARICO")!=null?request.getAttribute("MC_FOR_CARICO"):"" %>">
	    </td>
	  </tr>
	    
	  
	   <!--  	SINAAF ADEGUAMENTO -->
	   	  <tr class="containerBody">
	      <td nowrap class="formLabel">
		  Data Scadenza
		 </td>
	    	  
	  	 <td>
	  	 		<input type="text" class="date_picker"
					name="dataScadenzaMC" id="dataScadenzaMC" size="10"
					value=""
					nomecampo="dataScadenzaMC" tipocontrollo=""
					labelcampo="Data Scadenza" />&nbsp;<font color="red">*</font> 
	   	  </td>
	   	  </tr>
	   	  
	   	   <tr class="containerBody">
	        <td nowrap class="formLabel"> Identificativo  Lotto </td>
	 	 	<td> <input id="identifLottoMC" name="identifLottoMC" type="text"  maxlength="20"><font color="red">*</font></td>
	   	  </tr>
	   	  
	   	   <tr class="containerBody">
	        <td nowrap class="formLabel"> Produttore/Distributore Microchip </td>
	 	 	 
	 	 			<td><%=produttoreMCList.getHtmlSelect("idProduttoreMC",-1)%>
					 <font color="red">*</font></td>
	   	  </tr>
	 
	 		<tr class="containerBody">
	        <td nowrap class="formLabel"> Confezione </td>
	 	 	 
	 	 	<td> <input id="confezione" name="confezione" type="text" maxlength="20" ><font color="red">*</font></td>
	   	  </tr>
	 

	</table>
		  
    <%= showError( request, "errore") %>

    <% 
       if ( request.getAttribute("ok") != null ) { %>
    	<br>
    	
    	<%= showAttribute( request, "ok") %>
    <% } %>
    
   </td>
  </tr>
</table>
<br /><%-- 
<input type="submit" value="<dhv:label name="">Esegui Carico</dhv:label>" onClick="this.form.dosubmit.value='true';"> --%>
<input type="button" value="Esegui Carico" onclick="javascript:checkMC();">
<input type="hidden" name="dosubmit" value="true" />
<input type="hidden" name="AGGIORNAMENTOGIACENZA" value="<%=request.getAttribute("MC_FOR_CARICO")!=null?true:false %>" />

<input type="hidden" name="popup" value="<%=request.getAttribute("MC_FOR_CARICO")!=null?true:false %>" />
</form>
</body>