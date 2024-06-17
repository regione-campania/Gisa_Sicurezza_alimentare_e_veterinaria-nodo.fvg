<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@page import="org.aspcfs.modules.util.imports.ApplicationProperties"%>

<%@page import="org.aspcfs.utils.web.LookupList"%><jsp:useBean id="OrgDetails" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request" />

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
cal19.showNavigationDropdowns();
</SCRIPT>

<%
String param1 = "altId=" + OrgDetails.getAltId()+"&stabId=" + OrgDetails.getIdStabilimento(); request.setAttribute("Operatore",OrgDetails.getOperatore());
%>


<SCRIPT LANGUAGE="JavaScript" ID="js19">
function chgAction( button )
{
	if (button.checked){
		action_name = button.value;
    if( action_name=="old" ) {
        document.getElementById('macellazioniForm').action = 'MacellazioniSintesis.do?command=StampeModuli&<%=param1%>';
    }
    else if( action_name=="new" ) {
    	document.getElementById('macellazioniForm').action = 'GestioneDocumenti.do?command=GeneraPDFMacelli&<%=param1%>';
    }
	}
}
</script>
<%@ include file="../utils23/initPage.jsp"%>
	
	<head>
		<link rel="stylesheet" type="text/css" href="css/jmesa.css"></link>
		
		<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
		<script type="text/javascript" src="javascript/jmesa.js"></script>
		
	</head>


<table class="trails" cellspacing="0">
	<tr>
		<td>
			<%
				if (request.getParameter("return") == null)
				{
			%>
					
					<a href="StabilimentoSintesisAction.do?command=DettaglioStabilimento&altId=<%=OrgDetails.getAltId() %>">Scheda Stabilimento</a> >
			<%
				}
				else if (request.getParameter("return").equals("dashboard"))
				{}
			%>
			Stampe Moduli
		</td>
	</tr>
</table>


<dhv:container
	name="sintesismacelli"
	selected="stampe_moduli" object="Operatore" param="<%=param1%>"
	appendToUrl='<%=addLinkParams(request, "popup|popupType|actionId")%>'
	>
	
<%--form name="macellazioniForm" action="MacellazioniSintesis.do?command=StampeModuli&<%=param1%>" method="post"--%>
<%--form name="macellazioniForm" action="GestioneDocumenti.do?command=GeneraPDFMacelli&<%=param1%>" method="post"--%>

<div align="right" style="display:none">
<b>Gestione stampe</b><br/>
<input type="radio" id="radio1" name="radio" value="old" onClick="chgAction(this)" checked="checked"/> Vecchia gestione
<input type="radio" id="radio2" name="radio" value="new" onClick="chgAction(this)"/> Nuova gestione  
</div>


	<%-- <input type="hidden" name="altId" value="<%=OrgDetails.getAltId() %>" /> --%>
<!-- Flusso 339 rimossa la guida ai moduli -->
<!-- GUIDA UTENTE-->
<%-- <dhv:permission name="guidautente-view"> --%>
<!-- <a href="javascript:popURL('macellazioni/guida.jsp','CRM_Help','790','500','yes','yes');"> -->
<!-- <font size="3px" color="#006699"><b>Clicca qui per la guida utente </font><b></a> -->
<%-- </dhv:permission> --%>
<!-- <br> -->
<!-- <br> -->

<%

HashMap<String,ArrayList<String>> date = (HashMap<String,ArrayList<String>> ) request.getAttribute("DateStampa");

ArrayList<String> lista1 = date.get("GET_DATE_IDATIDOSI");
ArrayList<String> lista2 = date.get("GET_DATE_MODELLO_MARCHI");
ArrayList<String> lista3 = date.get("GET_DATE_ANIMALI_INFETTI");
ArrayList<String> lista4 = date.get("GET_DATE_ANIMALI_GRAVIDI");
ArrayList<String> lista5 = date.get("GET_DATE_TBC_RILEVAZIONE_MACELLO");
ArrayList<String> lista6 = date.get("GET_DATE_BRC_RILEVAZIONE_MACELLO");
ArrayList<String> lista7 = date.get("GET_DATE_1033_TBC");
ArrayList<String> lista8 = date.get("GET_DATE_EVIDENZE_VISITA_ANTE_MORTEM");
ArrayList<String> lista9 = date.get("GET_DATE_MORTE_ANTE_MACELLAZIONE");
ArrayList<String> lista10 = date.get("GET_DATE_ANIMALI_LEB");
ArrayList<String> lista11 = date.get("GET_DATE_TRASPORTI_ANIMALI_INFETTI");
				 


 		  			
				  			
		   



	  			
 

%>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">



<table cellpadding="5" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong><dhv:label name="">Lista Moduli Macelli</dhv:label></strong>
          </th>
         </tr> 
         <tr> 
          <th>
            <strong>Nome</strong>
          </th>
          <th>
            <strong><dhv:label name="">Azione</dhv:label></strong>
          </th>
        </tr>
<form name="macellazioniForm" action="GestioneDocumenti.do?command=GeneraPDFMacelli&<%=param1%>" method="post" id="macellazioniForm">

	<input type="hidden" name="tipo" id="tipo" value="Macelli_Modello" />         
        <!-- Modello Idatidosi -->

		<tr>
       		<td >
	       		<dhv:label name="">1. Modello Idatidosi</dhv:label>
       		</td>
       		<td >
       		<%= LookupList.stampaCombo(lista1, "data1")%>
<!--          		<input readonly type="text" name="data1" id="data1" size="10" />-->
<!--		  		<a href="#" onClick="cal19.select(document.forms[0].data1,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">-->
<!--		  		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a><font color="red">*</font>		  	-->

       			<input type="submit" id="generaPdf" name="generaPdf" <%if(lista1.isEmpty()){%>disabled="disabled"<%} %> value="Genera Modulo" onclick="this.form.tipoModulo.value='1'" />
       		</td>
  	   	</tr>
  	   	  	   	<input type="hidden" id="tipoModulo" name="tipoModulo" value="" />
</form>

<form name="macellazioniForm" action="GestioneDocumenti.do?command=GeneraPDFMacelli&<%=param1%>" method="post" id="macellazioniForm">

	<input type="hidden" name="tipo" id="tipo" value="Macelli_Modello_New" /> 
		<tr>
       		<td >
	       		<dhv:label name="">ALL_1_POSITIVI_DUBBI_SOSPESO_TBC_DGRC_104_2022</dhv:label>
       		</td>
       		<td>
       			<input type="submit" id="generaPdf" name="generaPdf" value="Genera Modulo" onclick="this.form.tipoModulo.value='1'" />
       		</td>
  	   	</tr>
		<tr>
       		<td >
       			<dhv:label name="">ALL_2_POSITIVI_ALL_INFETTO_TBC_DGRC_104_2022</dhv:label>
       		</td>
       		<td >
       			<input type="submit" id="generaPdf" name="generaPdf" value = "Genera Modulo"  onclick="this.form.tipoModulo.value='2'"/>
       		</td>
  	   	</tr>
		<tr>
       		<td >
       			<dhv:label name="">ALL_3_MACELLAZIONE_REGOLARE_GDRC_104_2022</dhv:label>
       		</td>
       		<td >
       			<input type="submit" id="generaPdf" name="generaPdf" value = "Genera Modulo"  onclick="this.form.tipoModulo.value='3'"/>
       		</td>
  	   	</tr>
		<tr>
       		<td >
       			<dhv:label name="">ALL_4_MACELLAZIONE_BRC_GDRC_104_2022</dhv:label>
       		</td>
       		<td >
       			<input type="submit" id="generaPdf" name="generaPdf" value = "Genera Modulo"  onclick="this.form.tipoModulo.value='4'"/>
       		</td>
  	   	</tr>
		<tr>
       		<td >
       			<dhv:label name="">ALL_5_MACELLAZIONE_BRC__AO_ focolai attivi con isolamento</dhv:label>
       		</td>
       		<td >
       			<input type="submit" id="generaPdf" name="generaPdf" value = "Genera Modulo"  onclick="this.form.tipoModulo.value='5'"/>
       		</td>
  	   	</tr>
		<tr>
       		<td >
       			<dhv:label name="">ALL_6_MACELLAZIONE_TBC_AO_ focolai attivi con isolamento</dhv:label>
       		</td>
       		<td >
       			<input type="submit" id="generaPdf" name="generaPdf" value = "Genera Modulo"  onclick="this.form.tipoModulo.value='6'"/>
       		</td>
  	   	</tr>
		
		
  	   	
  	   	<input type="hidden" id="tipoModulo" name="tipoModulo" value="" />
</table>

<p style="color: red;">
<%= request.getAttribute("messaggio") != null && !request.getAttribute("messaggio").equals("") ? request.getAttribute("messaggio") : "" %>
</p>
</dhv:permission>
</form>
<%--

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiSintesis.do?command=ToRegistroMacellazioni&<%=param1 %>">Registro Macellazioni</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiSintesis.do?command=ToArt17&<%=param1 %>">Articolo 17</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiSintesis.do?command=ToMortiStalla&<%=param1 %>">Anim. morti in stalla/trasporto</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiSintesis.do?command=ToBSE&<%=param1 %>">Modulo BSE</a>
</dhv:permission>\



<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiSintesis.do?command=ToAbbattimento&<%=param1 %>">Abbattimento</a>
</dhv:permission>

<br/><br/>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniSintesis.do?command=PrintBRCRilevazioneMacelli&file=BRC_rilevazione_macelli.xml&<%=param1 %>">BRC rilevazione macelli</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniSintesis.do?command=PrintTBCRilevazioneMacelli&file=TBC_rilevazione_macelli.xml&<%=param1 %>">TBC rilevazione macelli</a>
</dhv:permission>
<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniSintesis.do?command=PrintDisinfezioneMezziTrasporto&file=disinfezione_mezzi_di_trasporto.xml&<%=param1 %>">Disinfezione mezzi di trasporto</a>
</dhv:permission>
 --%> 

</dhv:container>

