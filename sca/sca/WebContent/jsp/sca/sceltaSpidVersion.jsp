<%@page import="it.us.web.db.ApplicationProperties"%>
<%@page import="java.net.InetAddress"%>
<%@page import="it.us.web.util.CfUtil"%>
<%@page import="com.sun.corba.se.spi.legacy.connection.GetEndPointInfoAgainException"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="java.io.*"%>
<%@page import="configurazione.centralizzata.nuova.gestione.ClientServizioCentralizzato"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="endpoints" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="num_registrazione_stab" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="lista_partita_iva" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="canilebdu" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="roles" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="username" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="esiti" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="asl" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="qualifica" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="profilo_professionale" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="errore2" class="java.lang.String" scope="request" />
<jsp:useBean id="hostMessages" class="java.util.HashMap" scope="request" />
<jsp:useBean id="utenteGuc" class="it.us.web.bean.guc.Utente" scope="session" />

<script src="<%=ApplicationProperties.getUrlFromMon("gisaSpid")%>"></script>


<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<c:if test="${utenteGuc!=null}" >
<div style="clear: both;" align="right">
<c:out  value="${utenteGuc.cognome}"/>, <c:out value="${utenteGuc.nome}"/> (<c:out value="${fn:toUpperCase(utenteGuc.codiceFiscale)} "/>)
<a href="javascript: GisaSpid.logoutSpid('login.LogoutSca.us')">[Logout da Spid/CIE]</a>
<br><font align="right" color="green">Contatti help desk: <%=ApplicationProperties.getProperty("TELEFONO_HD")%></font>
</div>
</c:if>

<style>
body {
    color: #000044;
	font:  bold 15px/20px Trebouchet ms,geneva, serif;
}
table { 
    border-spacing: 12px;
    border-collapse: separate;
}
 td {
    padding: 10px;
	 border: 1px solid grey;
	 width:150px;
}
</style>
<%

ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();

ArrayList<String> ep = new ArrayList<String>();

for(int i = 0; i< endpoints.size(); i++){
	if(!ep.contains(endpoints.get(i).toString()) && !endpoints.get(i).toString().toLowerCase().equals("digemon")){
		ep.add(endpoints.get(i).toString());
	}
}

%>

<script>

var msgHostDown = ""; // messaggio
var nCall = <%= ep.size() %>; // endpoint da controllare
var nResp = 0; // endpoint controllati

function checkHostsICO( urlEp, endpoint, callback ){
	
	var image = new Image();
	image.src = urlEp+"/favicon.ico";
	
	setTimeout(function (){

		if ( !image.complete || !image.naturalWidth ) {
			console.log("[ICO] " + urlEp + " is offline" );
			// messaggio finale
			msgHostDown = msgHostDown + endpoint.toUpperCase() + " non raggiungibile \n";
			/* $("[href*= ... ") seleziona tutti tag <a> contenenti &endpoint= gisa/vam/bdu e ne modifica l'onclick
			per prevenire il reindirizzamento */
			$("[href*='&endpoint="+ endpoint +"']").each(function( index ) {
		 		  $( this ).attr("onclick", "event.preventDefault();messaggioEndpoint('"+endpoint.toUpperCase()+"')");
		 	});
			
		} else {
			console.log("[ICO] " + urlEp + " is online" );
			//msgHostDown = msgHostDown + urlEp + " raggiungibile \n";
		}
		nResp++;
		callback();
		clearTimeout();
	}
	,1000);
}

function checkICO(){
	// nResp == nCall -> n risposte == n chiamate -> controllato ogni endpoint
	if(msgHostDown != "" && nResp == nCall){
		 alert("[ICO] ATTENZIONE \n\n" + msgHostDown);
	}
	return;
}

function messaggioEndpoint( endpoint ){
	var mGisa = "<%= hostMessages.get("GISA") %>";
	var mBdu = "<%= hostMessages.get("BDU") %>";
	var mVam = "<%= hostMessages.get("VAM") %>";
	
	mGisa = mGisa.replaceAll("<br/>","\n");
	mBdu = mBdu.replaceAll("<br/>","\n");
	mVam = mVam.replaceAll("<br/>","\n");
	
	if( endpoint == "GISA" || endpoint == "GISA_EXT"){
		alert("Attenzione " + endpoint + " non raggiungibile \n" + mGisa);
	}
	
	if( endpoint == "BDU"){
		alert("Attenzione " + endpoint + " non raggiungibile \n" + mBdu);
	}
	
	if( endpoint == "VAM"){
		alert("Attenzione " + endpoint + " non raggiungibile \n" + mVam);
	}
}


<%
	for(int i = 0; i< ep.size(); i++){ 
%>
		// funzione check up&down ( url, endpoint controllato, callback)
		checkHostsICO('<%= mappaEndPoints.getString(ep.get(i).toLowerCase()) %>','<%= ep.get(i) %>',checkICO);
		
<%
	}
%>
	

function openPopup(url){
	
	  var res;
  var result;
  	  window.open(url,'popupSelect',
        'height=1280px,width=600px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}
	</script>
<body>
<%
if(!ApplicationProperties.getAmbiente().toUpperCase().contains("UFFICIALE"))
{
%>
<h1 style="text-align:center;background-color:#4477AA;color:white;border:0px;font:8px Trebuchet MS,Verdana,Helvetica,Arial,san-serif;font-size:1.5em;font-weight:normal;"  >
AMBIENTE <%=ApplicationProperties.getAmbiente()%> (mon: <i><%=ApplicationProperties.getAmbienteFromMon() %></i>)
</h1>
<%
}
%>
<h1 style="text-align:center;background-color:#eeeeee;">
S.C.A. - Sistema Centralizzato degli Accessi GISA
</h1>

<%@ include file="/block_back_button.jsp" %>


<script src="js/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="js/dist/sweetalert.css">

<c:if test="${ScadenzaPassword!=null}" >
<script>
sweetAlert("Avviso Password Obsoleta", "${ScadenzaPassword}", "warning");
</script>
</c:if>


<%
boolean controlloCf = false;
if(endpoints.size() > 0) { %>
<div id="content">
<center>
<% 
String qualificaDesc = "";
String profiloProfessionaleDesc = "";

   if( qualifica.size() > 0 && profilo_professionale.size() > 0 ){
	   qualificaDesc = qualifica.get(0).toString().toUpperCase();
	   qualificaDesc = qualificaDesc.replace("'", "");
 	   profiloProfessionaleDesc = profilo_professionale.get(0).toString().toUpperCase();
 	   profiloProfessionaleDesc = profiloProfessionaleDesc.replace("'", "");

%>
${utenteGuc.nome} ${utenteGuc.cognome} - <%=qualificaDesc%> - <%=profiloProfessionaleDesc%> 
<% } %>
<table>
<tr>
<% 	String asl_start=asl.get(0).toString();
	String ep_start=endpoints.get(0).toString();
	int conta_col = 0;
	//boolean controlloCf =  utenteGuc.getCodiceFiscale() == null || utenteGuc.getCodiceFiscale().length()!=16 || !(CfUtil.ControllaCF(utenteGuc.getCodiceFiscale().toUpperCase()) ).equals("");
	for(int i=1;i<=asl.size();i++) {
		String endp=endpoints.get(i-1).toString();
		String asl_corrente = asl.get(i-1).toString();
		String ep_corrente = endpoints.get(i-1).toString();
		String username_corrente=username.get(i-1).toString();
		String pathFile = request.getRealPath("/") + "img/"+roles.get(i-1).toString().toLowerCase().replaceAll(" ", "")+".png";
		File f = new File(pathFile);
		String img="1";
		if(f.exists()){
			img	= roles.get(i-1).toString().toLowerCase().replaceAll(" ", "");
		} 
		
	%>
		<!-- Se l'asl corrente e uguale alla precedente -->
		<%if(i<=endpoints.size() && ep_corrente.equals(ep_start)) { 
			++conta_col;
			//if(conta_col <=3){
				if(true){
		%>
			<td align="center">
				<% if(!esiti.isEmpty() && esiti.get(i-1).equals((i-1))) { //significa che e un KO
					
				%>
				<a href="#" onclick="alert('ATTENZIONE! <%=StringEscapeUtils.escapeJavaScript("L'ACCESSO")%> PER APPLICAZIONE E RUOLO SELEZIONATI RISULTA DISATTIVATO. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
				<br><%=roles.get(i-1).toString()%> 
				<br>ASL: <%=asl.get(i-1).toString()%> 
				<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } 
				else if( controlloCf && !endp.equalsIgnoreCase("gisa_ext"))
				{
					%>
					<a href="#" onclick="alert('ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO IL CODICE FISCALE <%=StringEscapeUtils.escapeJavaScript("NON E'")%> CORRETTO');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
							<br><%=roles.get(i-1).toString()%> 
							<br>ASL: <%=asl.get(i-1).toString()%> 
							<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<%}
				else { %>
					<a onclick="attendere()" href="login.LoginEndpoint.us?username=<%=username_corrente%>&endpoint=<%=endp%>&qualifica=<%=qualificaDesc%>&profilo_professionale=<%=profiloProfessionaleDesc%>"><img width="50px" style="background-color:#d21242" alt="" src="img/<%=img%>.png"></a>
					<br><%=roles.get(i-1).toString()%> 
					<br>ASL: <%=asl.get(i-1).toString()%> 
					<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
					<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
					<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
					<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } %>
			</td>
			<% } //numero_di_colonne 
			else { 
				conta_col=0; 
				++conta_col;%>
				</tr>
				<tr>
					<td align="center">
						<% if(!esiti.isEmpty() && esiti.get(i-1).equals((i-1))) { //significa che e un KO %>
						 <a href="#" onclick="alert('ATTENZIONE! <%=StringEscapeUtils.escapeJavaScript("L'ACCESSO")%> PER APPLICAZIONE E RUOLO SELEZIONATI RISULTA DISATTIVATO. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png">
						 </a>
						<br><%=roles.get(i-1).toString()%> 
						<br>ASL: <%=asl.get(i-1).toString()%> 
						<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
						<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
						<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
						<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
						<% } 
						else if(  controlloCf && !endp.equalsIgnoreCase("gisa_ext"))
						{
							%>
							<a href="#" onclick="alert('ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO IL CODICE FISCALE <%=StringEscapeUtils.escapeJavaScript("NON E'")%> CORRETTO');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
									<br><%=roles.get(i-1).toString()%> 
									<br>ASL: <%=asl.get(i-1).toString()%> 
									<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
									<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
									<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
									<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
						<%}
						else { %>
						<a onclick="attendere()" href="login.LoginEndpoint.us?username=<%=username_corrente%>&endpoint=<%=endp%>&qualifica=<%=qualificaDesc%>&profilo_professionale=<%=profiloProfessionaleDesc%>"><img width="50px" style="background-color:#f47836" alt="" src="img/<%=img%>.png"></a>
					<br><%=roles.get(i-1).toString()%> 
					<br>ASL: <%=asl.get(i-1).toString()%> 
					<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
					<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
					<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
					<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } %>
					</td>
					
			<% } %>
		
		<% } else { %>
		</tr>
		</table>
		<% asl_start= asl_corrente;
		ep_start=ep_corrente;
		conta_col=0;
		%>
		<table>
			<tr>
			
			<% ++conta_col;
				//if(conta_col <=3){
					if(true){
			%>
			<td align="center">
				<% if(!esiti.isEmpty() && esiti.get(i-1).equals((i-1))) { //significa che e un KO %>
				
					<a href="#" onclick="alert('ATTENZIONE! <%=StringEscapeUtils.escapeJavaScript("L'ACCESSO")%> PER APPLICAZIONE E RUOLO SELEZIONATI RISULTA DISATTIVATO. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png" >
					</a>
					<br><%=roles.get(i-1).toString()%> 
					<br>ASL: <%=asl.get(i-1).toString()%> 
					<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>
					<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
					<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%>  
					<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } 
				else if(  controlloCf && !endp.equalsIgnoreCase("gisa_ext"))
				{
					%>
					<a href="#" onclick="alert('ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO IL CODICE FISCALE <%=StringEscapeUtils.escapeJavaScript("NON E'")%> CORRETTO');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
							<br><%=roles.get(i-1).toString()%> 
							<br>ASL: <%=asl.get(i-1).toString()%> 
							<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
							<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
							<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
							<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<%}
				else { %>
					<a onclick="attendere()" href="login.LoginEndpoint.us?username=<%=username_corrente%>&endpoint=<%=endp%>&qualifica=<%=qualificaDesc%>&profilo_professionale=<%=profiloProfessionaleDesc%>"><img width="50px" style="background-color:#f47836" alt="" src="img/<%=img%>.png" >
					</a>
					<br><%=roles.get(i-1).toString()%> 
					<br>ASL: <%=asl.get(i-1).toString()%> 
					<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
					<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
					<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
					<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } %>	
			</td>	
			<% } else {
				conta_col=0; ++conta_col;%>
			</tr>	
			<tr>
				<td align="center">
					<% if(!esiti.isEmpty() && esiti.get(i-1).equals((i-1))) { //significa che e un KO %>
						<a href="#" onclick="alert('ATTENZIONE! <%=StringEscapeUtils.escapeJavaScript("L'ACCESSO")%> PER APPLICAZIONE E RUOLO SELEZIONATI RISULTA DISATTIVATO. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png" >
						</a>
						<br><%=roles.get(i-1).toString()%>
						<br>ASL: <%=asl.get(i-1).toString()%> 
						<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>
						<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
						<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%>  
						<br><font color="#013ADF"><%=endp.toUpperCase()%></font>			
					<% }
					else if(  controlloCf && !endp.equalsIgnoreCase("gisa_ext"))
					{
						%>
						<a href="#" onclick="alert('ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO IL CODICE FISCALE <%=StringEscapeUtils.escapeJavaScript("NON E'")%> CORRETTO');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
								<br><%=roles.get(i-1).toString()%> 
								<br>ASL: <%=asl.get(i-1).toString()%> 
								<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
								<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
								<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
								<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
					<%}
					else { %>
						<a onclick="attendere()" href="login.LoginEndpoint.us?username=<%=username_corrente%>&endpoint=<%=endp%>&qualifica=<%=qualificaDesc%>&profilo_professionale=<%=profiloProfessionaleDesc%>"><img width="50px" style="background-color:#d21242" alt="" src="img/<%=img%>.png">
						</a>
						<br><%=roles.get(i-1).toString()%>
						<br>ASL: <%=asl.get(i-1).toString()%> 
						<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
						<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
						<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
						<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
					<% } %>
				</td>
		
			<% }
		}%>	
						
<%} %>
</tr>
</table>	

</center>
</div>
<% } %>



<h1 style="font-size:12px;text-align:center;background-color:#eeeeee;">
Codice sorgente disponibile sul <a style="color:black;" href="https://github.com/regione-campania/GISA" target="_new">repository github della Regione Campania</a>
</h1>



<%
if(controlloCf)
{
%>

<script type="text/javascript">
	alert('Si avvisa che il codice fiscale non e valido.  Si prega di contattare il servizio di help desk per aggiornarlo.');
</script>
<%
}
%>

</body>