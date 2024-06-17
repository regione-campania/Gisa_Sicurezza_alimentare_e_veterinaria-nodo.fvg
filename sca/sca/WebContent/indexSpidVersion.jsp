<%@page import="it.us.web.db.ApplicationProperties"%>
<%@page import="java.net.InetAddress"%>
<%@page import="it.us.web.action.GenericAction"%>
<%@page import="it.us.web.action.login.*"%>
<%
	//String test = (String)request.getAttribute("test");
    String test = null;
    boolean usernameAttivato = false;
%>



<%--
<%
	GenericAction.redirectTo("login.LogoutSca.us", request, response);
%>
--%>





<style>
/* unvisited link */


/* mouse over link */
h3:hover {
  color: hotpink;
  background-color: #e4e4e4;
}

.btn {

  background: #d9a234;
  background-image: linear-gradient(to bottom, #d9a234, #a3520c);
  border-radius: 9px;
  box-shadow: 3px 5px 5px #666666;
  font-family: Geneva, sans-serif;
  color: #ffffff;
  font-size: 10px;
  padding: 1px 10px 1px 10px;
  text-decoration: none;
}

.btn:hover {
  background: #ccbb21;
  background-image: linear-gradient(to bottom, #ccbb21, #c48351);
  color:#0a0a0a;
  font-weight: bold;
  text-decoration: none;
}
</style>

<script>
function continua() {


}
</script>

<script src="<%=ApplicationProperties.getUrlFromMon("gisaSpid")%>"></script>


<script>
function gotoV() {
	
	f=document.getElementById('f1');
	//f.action='http://vam.anagrafecaninacampania.it/vam/login.Login.us';
	f.action='http://srvVAMW/vam/login.Login.us';
	f.submit();
}
function gotoB() {
	
	f=document.getElementById('f1');
	//f.action='http://srv.anagrafecaninacampania.it/bdu/Login.do?command=Login&auto-populate=true';
	f.action='http://srvBDUW/bdu/Login.do?command=Login&auto-populate=true';
	u=document.getElementById('usr');
	u.name='username';
	f.submit();
}
function gotoG() {
	
	f=document.getElementById('f1');
	//f.action='http://srv.gisacampania.it/gisa_nt/Login.do?command=Login&auto-populate=true';
	f.action='http://srvGISAW/gisa_nt/Login.do?command=Login&auto-populate=true';
	u=document.getElementById('usr');
	u.name='username';
	f.submit();
}

</script>

<script>
function openPopupCambioPassword(){
	        
	  window.open('cambiopassword.CambioPassword.us','popupSelect',
	         'height=600px,width=600px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}

function chkUser(iduser){
	if(document.getElementById(iduser).value+" " == " ") {
		alert('Inserire il corretto username con cui si intende eseguire la login');
		return false;
	}
	return true;
}

function callbackfoo(data){

/* riempire i campi CF e token, quindi eseguire submit */
//	alert("spid-ret: " + JSON.stringify(data));
    attendere();
	var cf_spid = document.getElementById('cf_spid');
	var tk_spid = document.getElementById('tk_spid');
	tk_spid.value=data.token;
	cf_spid.value=data.fiscalCode;

	console.log('token: ' + tk_spid.value);

//alert(tk_spid.value);
	document.forms[0].submit();
}

</script>



<%@ include file="avviso_messaggio_urgente.jsp" %>

<%@ include file="block_back_button.jsp" %>

<div id="content" align="center">
<center> 
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
S.C.A. - Sistema Centralizzato degli Accessi
</h1>
     
 	<div align="center">
	  	<form id="f1" action="login.Login.us" method="post">					
			<!-- <b>Username  </b> <br>
				<input type="text" name="utente" id='usr'/> <br>					
			<b>Password  </b> <br>
				<input type="password" name="password" /> <br>
			<br> -->
<%
if(test!=null)
{
%>	
			<input type="text" name="cf_spid" id="cf_spid"/> <br>
<%
}
else
{
	%>	
			<input type="hidden" name="cf_spid" id="cf_spid"/> <br>
<%	
}
%>
			<input type="hidden" name="tk_spid" id="tk_spid"/> <br>
			<input type="hidden" name="action" value="login"/>
<%
if(test!=null)
{
%>
			<input type="submit" value="Entra-test">
<%
}
%>
			<input type="button" value="Entra con SPID/CIE" onclick="GisaSpid.entraConSpid(event, 'f1', null, 'callbackfoo', null);">

			<!--br/>  a href="#" style="color: inherit;" onClick="openPopupCambioPassword()">Cambia Password</a-->
<%
if(usernameAttivato)
{
%>
			<br><br>
			<a href="/sca/IndexSca.us?reload" style="color: inherit;" ><h3>Accedi con Username</h3></a>
<%
}
%>
		</form>	
<br>
			<a href="<%=ApplicationProperties.getUrlFromMon("moduloSpid")%>/ManualeModuloPre-reg_rev10.pdf" style="color: inherit;" target="_blank"><h3>Come registrarsi all'Ecosistema Gisa</h3></a>
			<a href="#" style="color: inherit;" data-toggle="modal" data-target="#warnModal" ><h3>Registrati all'Ecosistema Gisa</h3></a>

<font align="right" color="green">Contatti help desk: <%=ApplicationProperties.getProperty("TELEFONO_HD")%></font>
<br><br>
<font align="right" color="red">Per accedere all'ambiente DEMO cliccare:<a href="https://scademo.gisacampania.it" style="color: inherit;"target="_blank">qui</a></font>

<!-- 		<button title="Usare l'accesso diretto in caso di problemi con l'accesso centralizzato" class='btn' onclick='gotoG()'>Gisa direct</button> -->
	<!-- 	<button  title="Usare l'accesso diretto in caso di problemi con l'accesso centralizzato" class='btn' onclick='gotoB()'>Bdu direct</button>
		<button  title="Usare l'accesso diretto in caso di problemi con l'accesso centralizzato" class='btn' onclick='gotoV()'>Vam direct</button>
	--></div>
</center>
</div>


<!-- Modal -->
<div class="modal fade" id="warnModal" tabindex="-1" role="dialog" aria-labelledby="warnModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="warnModalLabel">ATTENZIONE</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
		Le registrazioni utenti tramite questo sito
		si riferiscono all'ecosistema GISA e 
		NON sono utilizzabili per le notifiche 
		in ambito Sicurezza Lavoro
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-lg" data-dismiss="modal" onclick="location='<%=ApplicationProperties.getUrlFromMon("sicurezzaLavoro")%>'">Vai a Sicurezza Lavoro</button>
        <button type="button" class="btn btn-primary btn-lg" data-dismiss="modal" onclick="location.href='<%=ApplicationProperties.getUrlFromMon("moduloSpid")%>';">Prosegui "Registrati su Ecosistema Gisa"</button>
      </div>
    </div>
  </div>
</div>
