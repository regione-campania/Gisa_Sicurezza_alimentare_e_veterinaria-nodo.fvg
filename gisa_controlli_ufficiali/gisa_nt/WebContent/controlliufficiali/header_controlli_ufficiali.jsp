
<%-- if (TicketDetails.getTipologia_operatore()==1){ %>
<script>
alert('Gli stabilimenti 852 sono momentaneamente non disponibili causa allineamento dati in corso.');
loadModalWindow();
window.location.href="OpuStab.do?command=SearchForm";
</script>
<% } --%>

<%@page import="org.aspcfs.modules.admin.base.Role"%>
<%@page import="com.sun.research.ws.wadl.Request"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.aspcfs.utils.UserUtils"%>
<link href="css/nonconformita.css" rel="stylesheet" type="text/css" />



<script>var myRequest = null;
var idTypeList = new Array();

function CreateXmlHttpReq(handler) {
  var xmlhttp = null;
  if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
  
  xmlhttp.onreadystatechange = handler;
  return xmlhttp;
}

function myHandler() {
	//alert('my handler')
    if (myRequest.readyState == 4 && myRequest.status == 200) {

		location.href=link_ret;
    }
}
var link_ret;
function riapriChiusuraTemp(link,link_di_ritorno)
{
	loadModalWindowCustom("Attendere! Riapertura in corso");

	link_ret = link_di_ritorno ;
	 myRequest = CreateXmlHttpReq(myHandler);
	myRequest.open("GET",link);
	myRequest.send(null);
}


</script>

<!-- BOTTONI -->
<%-- <%@ include file="header_cu_bottoni_org_old.jsp"%> --%>

<%@ include file="header_cu_bottoni_org.jsp"%>
<!-- BOTTONI -->


	
	
	<dhv:permission name="global-search-acquacoltura-add">
	<% if (TicketDetails.isAcquacoltura()) {%>
	<br/>
	<div align="right">
		<b>     
			<a href="#" style="-moz-appearance: button;" onClick="openPopupBox('PrintReportVigilanza.do?command=GestioneCuAcquacolturaBdn&idControllo=<%=TicketDetails.getId()%>')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gestione dati per invio in BDN &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
		</b>
	</div>
	<br/>
	<% } %>
	</dhv:permission>
	
	
	
	
<script>


$(document).ready(function() {	

	
	//select all the a tag with name equal to modal
	$('a[name=modal]').click(function(e) {
		//Cancel the link behavior
		e.preventDefault();
		
		//Get the A tag
		var id = $(this).attr('href');
	
		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
	
		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		
		//transition effect		
		$('#mask').fadeIn(1000);	
		$('#mask').fadeTo("slow",0.8);	
	
		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();
              
		//Set the popup window to center
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
		
		//transition effect
		$(id).fadeIn(2000); 
	
	});
	
	//if close button is clicked
	$('.window .close').click(function (e) {
		//Cancel the link behavior
		e.preventDefault();
		
		$('#mask').hide();
		$('.window').hide();
	});		
	
	//if mask is clicked
	$('#mask').click(function () {
		$(this).hide();
		$('.window').hide();
	});			
	
});

</script>
<style>
body {
	font-family: verdana;
	font-size: 15px;
}

a {
	color: #333;
	text-decoration: none
}

a:hover {
	color: #ccc;
	text-decoration: none
}

#mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9000;
	background-color: #000;
	display: none;
}

#boxes .window {
	position: absolute;
	left: 0;
	top: 0;
	width: 675px;
	height: 658;
	display: none;
	z-index: 9999;
	padding: 20px;
}

#boxes
#dialog
#
{
width:675px;
height:680;
padding:10px;
background-color:#ffffff
;}
#dialog4 {
	width: 100%;
	height: 100%;
	padding: 10px;
	background-color: #ffffff;
	overflow: scroll;
}

#dialog10 {
	width: 100%;
	height: 100%;
	padding: 10px;
	background-color: #ffffff;
	overflow: scroll;
}


#boxes #dialog1 {
	width: 375px;
	height: 203px;
}

#dialog1 .d-header {
	background: url(images/login-header.png) no-repeat 0 0 transparent;
	width: 375px;
	height: 150px;
}

#dialog1 .d-header input {
	position: relative;
	top: 60px;
	left: 100px;
	border: 3px solid #cccccc;
	height: 22px;
	width: 200px;
	font-size: 15px;
	padding: 5px;
	margin-top: 4px;
}

#dialog1 .d-blank {
	float: left;
	background: url(images/login-blank.png) no-repeat 0 0 transparent;
	width: 267px;
	height: 53px;
}

#dialog1 .d-login {
	float: left;
	width: 108px;
	height: 53px;
}

#boxes #dialog2 {
	background: url(images/notice.png) no-repeat 0 0 transparent;
	width: 326px;
	height: 229px;
	padding: 50px 0 20px 25px;
}
</style>




<input type="hidden" id="idChecklist" name="idChecklist"
	value="<%=request.getAttribute("idChecklist_corrente")%>" />


<div id="boxes">


<div id="dialog4" class="window"><a href="#" class="close" /><font
	color="red">CHIUDI</font></a> <br>
<%@ include file="guida_compila_checklist.txt"%>
</div>


<div id="dialog10" class="window"><a href="#" class="close" /><font
	color="red">CHIUDI</font></a> <br>
<script>
function checkFormSupervisione()
{
	
	var flag_supervisione_efficace = "";
	var supervisione_note = "";
	if (document.getElementById('flag_supervisione_efficace_si').checked==true)
		flag_supervisione_efficace = 'si';
	else
	{
		flag_supervisione_efficace = 'no';
	}
	supervisione_note = document.getElementById('supervisione_note').value
	loadModalWindow();
	window.location.href="<%=TicketDetails.getURlDettaglio() %>Vigilanza.do?command=Supervisiona&id=<%= TicketDetails.getId() %>&stabId=<%=TicketDetails.getIdStabilimento()%>&orgId=<%=TicketDetails.getOrgId()%>&flag_supervisione_efficace="+flag_supervisione_efficace+"&supervisione_note="+supervisione_note;
}
	
</script>
 <table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details">

				<tr>
					<th colspan="2">Dettagli Supervisione</th>
				</tr>
				
				<tr>
					<td class="formLabel" nowrap>Il Controllo e' risultato efficace e congruo</td>
					<td>
					
					 SI <input type = "radio" name = "flag" id = "flag_supervisione_efficace_si" value = "si" onclick="document.getElementById('note_supervisione').style.display='none'"   checked="checked" >
					 NO <input type = "radio" name = "flag"  id = "flag_supervisione_efficace_no" value = "no" onclick="document.getElementById('note_supervisione').style.display=''" >
					
					</td>
				</tr>
				
				<tr id = "note_supervisione" style="display: none">
					<td class="formLabel" nowrap>Indicare il motivo</td>
					<td><input type="text" id="supervisione_note" name = "supervisione_note"/> </td>
				</tr>
				<input type = "hidden"  name= "flag_supervisione_efficace" >
				<tr><td colspan="2"><input type = "button" onclick="checkFormSupervisione(); this.style.display='none'" value = "Salva Supervisione"></td></tr>

</table>

</div>

 <script language="JavaScript" TYPE="text/javascript"
	SRC="gestione_documenti/generazioneDocumentale.js"></script>

<dhv:permission name="cu_stampa-view">
<div align="right">
<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
<input type="button" title="Stampa Riepilogativa del Controllo Ufficiale" value="Stampa Riepilogativa del Controllo Ufficiale"	onClick="openRichiestaPDFControlli('<%= TicketDetails.getId() %>');">
</div>
</dhv:permission>

<!-- Mask to cover the whole screen -->
<div id="mask"></div>

</div>
<% if (TicketDetails.isflagBloccoCu()==false && TicketDetails.getTipoCampione() == 4 && TicketDetails.getClosed() == null && (TicketDetails.getStatusId() == 1 || TicketDetails.getStatusId() == 3)){ %>
<% if (TicketDetails.getTipologia_operatore()!=14) { //NON ACQUE DI RETE %>
<dhv:permission name="cu_aggiunta_motivi-view">
<br/> <input type="button" value="aggiungi piano/attivita" onClick="openPopupFull('Vigilanza.do?command=AddMotivoCU&idControlloUfficiale=<%=TicketDetails.getId()%>')"/><br/><br/>
</dhv:permission>
<% } %>
<% } %>

<% //GESTIONE MESSAGGIO ERRORE CHIUSURA CU
if (request.getAttribute("Messaggio")!=null && !request.getAttribute("Messaggio").equals("")){%>
<script>
if (typeof messaggioAlert !== 'undefined') { } else { var messaggioAlert = false;} //Istanzio la variabile se non gia presente (questa pagina viene inclusa due volte)

if (messaggioAlert==false){ //se ho gia mostrato l'alert
	alert('<%=request.getAttribute("Messaggio") %>');
	messaggioAlert = true; //metti a true in modo da non mostrarlo di nuovo (questa pagina viene inclusa due volte)
}
</script>
<%} %>