<%@page import="java.net.InetAddress"%>
<jsp:useBean id="NazioniListISO" class="org.aspcfs.utils.web.LookupList" scope="request" />
<%@page import="org.aspcfs.modules.ws.WsPost"%>
<%@page import="org.aspcfs.utils.ApplicationProperties"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="java.sql.*,java.util.HashMap,java.util.Map"%>

<%
	Stabilimento StabilimentoDettaglio = (Stabilimento) OperatoreDettagli
			.getListaStabilimenti().get(0);
	Indirizzo sedeOperativa = StabilimentoDettaglio.getSedeOperativa();
	LineaProduttiva lp = (LineaProduttiva) StabilimentoDettaglio
			.getListaLineeProduttive().get(0);
%>

<%
	WsPost ws = request.getAttribute("ws")!=null ? ((WsPost)request.getAttribute("ws")) : (null);
	InetAddress net = InetAddress.getByName(ApplicationProperties.getProperty("SINAAF_MONITORAGGIO_HOST"));
	String monitoraggioPort = ApplicationProperties.getProperty("SINAAF_MONITORAGGIO_PORT");
	String monitoraggioApp = ApplicationProperties.getProperty("SINAAF_MONITORAGGIO_APP");

%>

<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>


<%@page import="org.aspcfs.modules.opu.base.Operatore"%>
<%@page import="org.aspcfs.modules.opu.base.ImportatoreInformazioni"%>
	

<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>

<style>
/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    border: 1px solid #888;
    width: 20%;
}

/* The Close Button */
.close {
    color: #aaaaaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}
</style>
<script>
function showHideModificaMq(){
	var div = document.getElementById("divMq");
	var divOld = document.getElementById("divMqOld");
	var button = document.getElementById("mqModificaButton");
	
	if (div.style.display=='none'){
		div.style.display='block';
		divOld.style.display='none';
		button.style.display='none';
	}
	else{
		div.style.display='none';
		divOld.style.display='block';
	}
}

function modificaMq(){
	var newMq = document.getElementById('newMq').value;
	var oldMq = document.getElementById('oldMq').value; 
	var idLinea = document.getElementById('idLinea').value; 
	var idUtente = document.getElementById('idUtente').value; 
	
	if (newMq==''){
		alert('Indicare MQ');
		return false;
	}
		loadModalWindow();
		PopolaCombo.aggiornaMQCanile(idLinea, oldMq, newMq, idUtente,modificaMqCallback);
}

function modificaMqCallback(value)
{
if (value==true){
	alert ('Modifica effettuata con successo. Verificare se necessario propagarla in GISA.')
	window.location.reload(true);
}
else {
	alert('Errore generico nella modifica dei mq');
	loadModalWindowUnlock();

}
	
}

function showHideBloccaSblocca(){
	var div = document.getElementById("divBloccaSblocca");
	var button = document.getElementById("bloccaSbloccaButton");
	if (div.style.display=='none'){
		div.style.display='block';
		button.style.display='none';
	}
	else{
		div.style.display='none';
	}
}

function bloccaSblocca(operazione){
	
	var idLinea = document.getElementById('idLinea').value; 
	var idUtente = document.getElementById('idUtente').value;
	var note = document.getElementById('note').value;
	note = note.trim(); 
	
	if (note=='' || note.length<5){
		alert('Il campo note deve essere almeno di 5 caratteri.');
		return false;
	}
	
	if (confirm("Eseguire la funzione "+operazione+" sul canile? ")){
		loadModalWindow();
		PopolaCombo.bloccaSbloccaCanile(idLinea, operazione, idUtente, note,bloccaSbloccaCallback);
	}
	else
		return false;
}

function bloccaSbloccaCallback(value)
{
if (value==true){
	alert ('Modifica effettuata con successo. Verificare se necessario propagarla in GISA.')
	window.location.reload(true);
}
else {
	alert('Errore generico nel blocco/sblocco del canile.');
	loadModalWindowUnlock();
}
}
</script>


<%
if(request.getAttribute("Error")!=null)
{
%>
<%=showError(request, "Error")%>
<%
}
if(request.getAttribute("messaggio")!=null)
{
%>
<%=showMessage(request, "messaggio")%>
<%
}
%>

<table
	cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<th colspan="2"><dhv:label
			name="opu.stabilimento.linea_produttiva">
			<strong></strong>
		</dhv:label></th>
	</tr>
	<tr>
		<td colspan="2"><%=lp.getAttivita()%> <dhv:evaluate
			if="<%=(AslList.size() > 0)%>">  / Asl <%=AslList.getSelectedValue(StabilimentoDettaglio
									.getIdAsl())%>
			<%=(StabilimentoDettaglio.isFlagFuoriRegione()) ? " - Fuori regione - "
							: ""%>

		</dhv:evaluate>
	</tr>

</table>
<br>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">

<%
	//if(ws!=null && ws.propagazioneSinaaf)
	if( User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) ||  User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))){
		if(ws!=null)
  		{	
		
%>


			<tr>
				<th colspan="2"><strong>SINAAF</strong></th>
			</tr>

			
				<tr>
					<td class="formLabel" nowrap>Stato SINAAF</td>
					<td>
						<img src="images/<%=ws.getColoreSincronizzazione()%>.gif"> <%=ws.getLabelSincronizzazione()%>		
  						<% //if (!ws.sincronizzato)
  				  		if(false)
  				  		{%>
  		   				<p><B><%=ApplicationProperties.getProperty("SINAAF_MSG_PROBLEM") %></B></p>
  		  				 <%} %>
  					<%	
  					/*if( User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) ||
  			        User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))){*/
  		  			if(true){ %>
  					<input type="button" value="Sincronizza" onclick="Sync(<%=lp.getId()%>,'proprietario');" />
					<input type="button" value="Vedi body put/post" onclick="getBody(<%=lp.getId()%>,'proprietario')" />
					<input type="button" value="Vedi in sinaaf" onclick="VediInSinaaf(<%=lp.getId()%>,'proprietario')" />
	           	  	<input type="button" value="Monitoraggio"   target="_new" onclick="monitoraggio(<%=lp.getId()%>,'proprietario');" />
	           	  <%	} %>
	           	  
	           	  <%
     if(ws.idSinaaf!=null && !ws.idSinaaf.equals(""))
     {
%>
      	<br/>ID: <%=ws.idSinaaf %>  		
     <%
  		}
     %>
     
      <%
     if(ws.codiceSinaaf!=null && !ws.codiceSinaaf.equals(""))
     {
%>
      	<br/>CODICE: <%=ws.codiceSinaaf %>  		
     <%
  		}
     %>
					</td>
				</tr>
				
				
				 
		</table>
		<br>
<%
	}
  		}
		
		
		


		
// SEZIONE BLOCCO PROPRIETARIO PRIVATO 
if(ApplicationProperties.getProperty("flusso_359").equals("true"))
{
	if(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazionePrivato)
	{
		
		boolean competenzaAsl = User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2")) || StabilimentoDettaglio.getIdAsl() == User.getSiteId();
		boolean permessoBloccoSbloccoRuolo = User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) || 
				   						User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2")) ||
				   						User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_REFERENTE_ASL")) || 
			       						User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_AMMINISTRATORE_ASL")) ||
				     					User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_ANAGRAFE_CANINA"));
		boolean permessoBloccoSblocco = permessoBloccoSbloccoRuolo && competenzaAsl;
%>
			<table cellpadding="4" cellspacing="0" border="0" width="100%"	class="details">
				<tr>
					<th colspan="2"><strong>INFORMAZIONI STATO PROPRIETARIO</strong></th>
				</tr>
				<input type="hidden" id="idLinea" name="idLinea" value="<%=lp.getId()%>"/>
	
<% 
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String data_corrente_st = sdf.format(new Date());
	String data_inizio_attivita ="";
	if(lp.getDataInizio()!=null)
		data_inizio_attivita = sdf.format(new Date(lp.getDataInizio().getTime()));
	Date data_corrente = sdf.parse(data_corrente_st);

	// CASO INIZIALE: POSSIBILITA' DI BLOCCARE
	if(OperatoreDettagli.getData_operazione_blocco()==null)
	{ 
%>
		<tr class="containerBody">
			<td nowrap class="formLabel"><dhv:label	name="">Stato</dhv:label></td>
			<td><font color="#008800"><b>ATTIVO</b></font></td>
		</tr>
<% 
		if(permessoBloccoSblocco)
		{
%>
		
			<tr class="containerBody">
				<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
				<td><input type="button" value="Sospendi ingressi<%=(lp.getIdRelazioneAttivita()==LineaProduttiva.idAggregazionePrivato)?("/uscite"):("")%>" onclick="open_jsp('blocca','','<%=data_inizio_attivita%>')"></td>
			</tr>
<%      }
	}
	else
	{
		if(OperatoreDettagli.isBloccato())
		{ 
			String data_operazione_st = null;
			Date data_operazione = null;
			if(OperatoreDettagli.getData_sospensione_blocco()!=null)
			{
				data_operazione_st = sdf.format(new Date(OperatoreDettagli.getData_sospensione_blocco().getTime()));
				data_operazione = sdf.parse(data_operazione_st);
			}
			if(data_operazione != null && data_operazione.compareTo(data_corrente)>0)
			{
				// risulta bloccato, ma la data del blocco effettivo è maggiore della data odierna
				// pertanto SARA' bloccato --> BLOCCO NON EFFETTIVO	%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Stato</dhv:label></td>
					<td><font color="#FFA500"><b>ATTIVO</b></font><br><font color="#FFA500">SOSPENSIONE 
					<%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("INGRESSI");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("USCITE");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("INGRESSI E USCITE");
							
					%></font> A PARTIRE DAL <%=data_operazione_st%></b></td>
						}
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Motivo</dhv:label></td>
					<td><%=OperatoreDettagli.getMotivo_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Note</dhv:label></td>
					<td><%=OperatoreDettagli.getNote_blocco()%></td>
				</tr>
<% 
				if(permessoBloccoSblocco)
				{
%>
				
					<tr class="containerBody">
						<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
						<td><input type="button" value="Annulla pianificazione blocco" onclick="open_jsp('annulla','','')"></td>
					</tr>
<% 
				}
			}
			else
			{ 

				
			
				// risulta bloccato e la data del blocco effettivo è minore o uguale alla data odierna
				// pertanto E' bloccato --> BLOCCO EFFETTIVO 
				
	%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Stato</dhv:label></td>
					<td><b><font color="#FF0000">SOSPENSIONE 
					<%
					System.out.println("14");
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("INGRESSI");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("USCITE");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("INGRESSI E USCITE");
							
					%>
					</font><%if(data_operazione!=null){ %> A PARTIRE DAL <%=data_operazione_st%> <%} %></b></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Motivo</dhv:label></td>
					<td><%=OperatoreDettagli.getMotivo_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Note</dhv:label></td>
					<td><%=OperatoreDettagli.getNote_blocco()%></td>
				</tr>
<% 
				if(permessoBloccoSblocco)
				{
%>
					<tr class="containerBody">
						<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
						<td><input type="button" value="Riattiva <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("ingressi");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("uscite");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("ingressi e uscite");
							
					%>" onclick="open_jsp('sblocca','<%=data_operazione_st%>','<%=data_inizio_attivita%>')"></td>
					</tr>
<% 				}
			}
		}
		else
		{ 
			String data_operazione_st = sdf.format(new Date(OperatoreDettagli.getData_riattivazione_blocco().getTime()));
			Date data_operazione = sdf.parse(data_operazione_st);
			if(data_operazione.compareTo(data_corrente)>0)
			{
				// risulta sbloccato, ma la data dello sblocco effettivo è maggiore della data odierna
				// pertanto SARA' sbloccato --> SBLOCCO NON EFFETTIVO	%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Stato</dhv:label></td>
					<td><font color="#FF0000"><b>BLOCCATO</b></font><br><font color="#FFA500">RIATTIVAZIONE <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("INGRESSI");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("USCITE");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("INGRESSI E USCITE");
							
					%></font> A PARTIRE DAL <%=data_operazione_st%></b></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Motivo</dhv:label></td>
					<td><%=OperatoreDettagli.getMotivo_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Note</dhv:label></td>
					<td><%=OperatoreDettagli.getNote_blocco()%></td>
				</tr>
<% 
				if(permessoBloccoSblocco)
				{
%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
					<td><input type="button" value="Annulla pianificazione blocco" onclick="open_jsp('annulla','','')"></td>
				</tr>
<% 
				}
			}
			else
			{ 
				// risulta sbloccato e la data del blocco effettivo è minore o uguale alla data odierna
				// pertanto E' bloccato --> BLOCCO EFFETTIVO %>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Stato canile</dhv:label></td>
					<td><b><font color="#008800">RIATTIVAZIONE <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("INGRESSI");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("USCITE");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("INGRESSI E USCITE");
							
					%></font> A PARTIRE DAL <%=data_operazione_st%></b></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Motivo</dhv:label></td>
					<td><%=OperatoreDettagli.getMotivo_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Note</dhv:label></td>
					<td><%=OperatoreDettagli.getNote_blocco()%></td>
				</tr>
<%
				if(permessoBloccoSblocco)
				{
%>
					<tr class="containerBody">
						<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
						<td><input type="button" value="Blocca" onclick="open_jsp('blocca','<%=data_operazione_st%>','<%=data_inizio_attivita%>')"></td>
					</tr>
<%
				}
			}
		 } 
%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><strong>Inserito</strong></td>
					<td><dhv:username id="<%=OperatoreDettagli.getUser_id_blocco()%>" /> il <%=toDateasString(OperatoreDettagli.getData_operazione_blocco())%>&nbsp;</td>
				</tr>
<% 			
	 }
	
	 if(OperatoreDettagli.getStoricoBlocco().size()>0)
	 { 
%>
	 <tr class="containerBody">
		<td nowrap class="formLabel"><dhv:label	name="">Strorico blocchi</dhv:label></td>
		<td><a href="#" id ="myBtn">VISUALIZZA STORICO</a>
			<!-- The Modal -->
			<div id="myModal" class="modal">
				<!-- Modal content -->
	  			<div class="modal-content">
	  			<span class="close">&times;</span>
    			<table cellpadding="4" cellspacing="0" border="0" width="100%"	class="details">
	  				<tr style="background-color: #BDCFFF">
						<td align="center" colspan="2"><strong>STORICO BLOCCHI</strong></td>
					</tr>
					<tr style="background-color: #EDEDED">
						<td align="center"><dhv:label	name="">DAL</dhv:label></td>
						<td align="center"><dhv:label	name="">AL</dhv:label></td>
					</tr>			
		  	  		<% List date = OperatoreDettagli.getStoricoBlocco();
						for (int i=0; i<date.size(); i++){
							String data_i = (String) date.get(i);
							String data_min = data_i.split("&")[0];
							String data_max = data_i.split("&")[1]; %>
							<tr><td align="center"><%=data_min%></td><td align="center"><%=data_max%></td></tr>
						<% } %>
	  	  		</table>
  	  			<p></p><br/>
	  			</div>
			</div>
		</td>
	 </tr>
	 <%
} 
	%>
	</table>
	</br>
<% 
	
	}
}

		
		
		
	System.out.println("ID ATTIVITA : " + lp.getIdAttivita());
	int idRelazioneAttivita = lp.getIdRelazioneAttivita();

	if (lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneColonia
				&& lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazionePrivato
				&& lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneSindaco
			&& lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneSindacoFR){
%>

<%
	String label_operatore = "opu.operatore_"
					+ idRelazioneAttivita;
			String label_operatore_rag_sociale = "opu.operatore.ragione_sociale_"
					+ idRelazioneAttivita;
%>


<!------------ SEZIONE BLOCCO CANILE -------------->
<%
if(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneCanile){ 

if(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneCanile 
			  && (lp.getDataFine()==null || lp.getDataFine().equals(""))){ %>
<table cellpadding="4" cellspacing="0" border="0" width="100%"	class="details">
	<tr>
		<th colspan="2"><strong>INFORMAZIONI STATO CANILE</strong></th>
	</tr>
	
	<% 
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	String data_corrente_st = sdf.format(new Date());
	String data_inizio_attivita ="";
	if(lp.getDataInizio()!=null)
		data_inizio_attivita = sdf.format(new Date(lp.getDataInizio().getTime()));
	Date data_corrente = sdf.parse(data_corrente_st);

	// CASO INIZIALE: POSSIBILITA' DI BLOCCARE
	if(OperatoreDettagli.getData_operazione_blocco()==null){ %>
		<tr class="containerBody">
			<td nowrap class="formLabel"><dhv:label	name="">Stato canile</dhv:label></td>
			<td><font color="#008800"><b>ATTIVO</b></font></td>
		</tr>
		<% if(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1"))
				|| User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))){%>
		
		<tr class="containerBody">
			<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
			<td><input type="button" value="Sospendi <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("ingressi");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("uscite");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("ingressi e uscite");
							
					%>" onclick="open_jsp('blocca','','<%=data_inizio_attivita%>')"></td>
		</tr><% }
	}else{
		
		if(OperatoreDettagli.isBloccato()){ 
			String data_operazione_st = sdf.format(new Date(OperatoreDettagli.getData_sospensione_blocco().getTime()));
			Date data_operazione = sdf.parse(data_operazione_st);
			if(data_operazione.compareTo(data_corrente)>0){
				// Il canile risulta bloccato, ma la data del blocco effettivo è maggiore della data odierna
				// pertanto SARA' bloccato --> BLOCCO NON EFFETTIVO	%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Stato canile</dhv:label></td>
					<td><font color="#FFA500"><b>ATTIVO</b></font><br><font color="#FFA500">SOSPENSIONE <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("INGRESSI");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("USCITE");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("INGRESSI E USCITE");
							
					%></font> A PARTIRE DAL <%=data_operazione_st%></b></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Motivo</dhv:label></td>
					<td><%=OperatoreDettagli.getMotivo_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Note</dhv:label></td>
					<td><%=OperatoreDettagli.getNote_blocco()%></td>
				</tr>
				<% if(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1"))
				|| User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))){%>
				
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
					<td><input type="button" value="Annulla pianificazione blocco" onclick="open_jsp('annulla','','')"></td>
				</tr><% }
			}else{ 
				// Il canile risulta bloccato e la data del blocco effettivo è minore o uguale alla data odierna
				// pertanto E' bloccato --> BLOCCO EFFETTIVO %>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Stato canile</dhv:label></td>
					<td><b><font color="#FF0000">SOSPENSIONE <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("INGRESSI");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("USCITE");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("INGRESSI E USCITE");
							
					%></font> A PARTIRE DAL <%=data_operazione_st%></b></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Motivo</dhv:label></td>
					<td><%=OperatoreDettagli.getMotivo_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Note</dhv:label></td>
					<td><%=OperatoreDettagli.getNote_blocco()%></td>
				</tr>
				<% if(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1"))
				|| User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))){%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
					<td><input type="button" value="Riattiva <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("ingressi");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("uscite");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("ingressi e uscite");
							
					%>" onclick="open_jsp('sblocca','<%=data_operazione_st%>','<%=data_inizio_attivita%>')"></td>
				</tr><% }
			}
		}else{ 
			String data_operazione_st = sdf.format(new Date(OperatoreDettagli.getData_riattivazione_blocco().getTime()));
			Date data_operazione = sdf.parse(data_operazione_st);
			if(data_operazione.compareTo(data_corrente)>0){
				// Il canile risulta sbloccato, ma la data dello sblocco effettivo è maggiore della data odierna
				// pertanto SARA' sbloccato --> SBLOCCO NON EFFETTIVO	%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Stato canile</dhv:label></td>
					<td><font color="#FF0000"><b>BLOCCATO</b></font><br><font color="#FFA500">RIATTIVAZIONE <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("INGRESSI");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("USCITE");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("INGRESSI E USCITE");
							
					%></font> A PARTIRE DAL <%=data_operazione_st%></b></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Motivo</dhv:label></td>
					<td><%=OperatoreDettagli.getMotivo_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Note</dhv:label></td>
					<td><%=OperatoreDettagli.getNote_blocco()%></td>
				</tr>
				<% if(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1"))
				|| User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))){%>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
					<td><input type="button" value="Annulla pianificazione blocco" onclick="open_jsp('annulla','','')"></td>
				</tr><% }
			}else{ 
				// Il canile risulta sbloccato e la data del blocco effettivo è minore o uguale alla data odierna
				// pertanto E' bloccato --> BLOCCO EFFETTIVO %>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Stato canile</dhv:label></td>
					<td><b><font color="#008800">RIATTIVAZIONE <%
						if(OperatoreDettagli.getMotivo_ingresso_uscita()<=1)
							out.println("INGRESSI");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==2)
							out.println("USCITE");
						else if(OperatoreDettagli.getMotivo_ingresso_uscita()==3)
							out.println("INGRESSI E USCITE");
							
					%></font> A PARTIRE DAL <%=data_operazione_st%></b></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Motivo</dhv:label></td>
					<td><%=OperatoreDettagli.getMotivo_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Note</dhv:label></td>
					<td><%=OperatoreDettagli.getNote_blocco()%></td>
				</tr>
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label	name="">Azione</dhv:label></td>
					<td><input type="button" value="Blocca" onclick="open_jsp('blocca','<%=data_operazione_st%>','<%=data_inizio_attivita%>')"></td>
				</tr><% 
			}
		 } %>
				<tr class="containerBody">
					<td nowrap class="formLabel"><strong>Inserito</strong></td>
					<td><dhv:username
						id="<%=OperatoreDettagli.getUser_id_blocco()%>" /> il <%=toDateasString(OperatoreDettagli.getData_operazione_blocco())%>&nbsp;
					</td>
				</tr><% 			
	 }%>
	 <% if(OperatoreDettagli.getStoricoBlocco().size()>0){ %>
	 <tr class="containerBody">
		<td nowrap class="formLabel"><dhv:label	name="">Strorico blocchi</dhv:label></td>
		<td><a href="#" id ="myBtn">VISUALIZZA STORICO</a>
			<!-- The Modal -->
			<div id="myModal" class="modal">
				<!-- Modal content -->
	  			<div class="modal-content">
	  			<span class="close">&times;</span>
    			<table cellpadding="4" cellspacing="0" border="0" width="100%"	class="details">
	  				<tr style="background-color: #BDCFFF">
						<td align="center" colspan="2"><strong>STORICO BLOCCHI</strong></td>
					</tr>
					<tr style="background-color: #EDEDED">
						<td align="center"><dhv:label	name="">DAL</dhv:label></td>
						<td align="center"><dhv:label	name="">AL</dhv:label></td>
					</tr>			
		  	  		<% List date = OperatoreDettagli.getStoricoBlocco();
						for (int i=0; i<date.size(); i++){
							String data_i = (String) date.get(i);
							String data_min = data_i.split("&")[0];
							String data_max = data_i.split("&")[1]; %>
							<tr><td align="center"><%=data_min%></td><td align="center"><%=data_max%></td></tr>
						<% } %>
	  	  		</table>
  	  			<p></p><br/>
	  			</div>
			</div>
		</td>
	 </tr>
	 <% } %>
	</table>
	</br>
<% }else{ %>
	<table cellpadding="4" cellspacing="0" border="0" width="100%"	class="details">
		<tr>
			<th colspan="2"><strong>INFORMAZIONI STATO CANILE</strong></th>
		</tr>
		<tr class="containerBody">
			<td nowrap class="formLabel"><dhv:label	name="">Stato canile</dhv:label></td>
			<td>CHIUSO/BLOCCATO</td>
		</tr>
		<tr class="containerBody">
			<td nowrap class="formLabel"><dhv:label	name="">Data chiusura</dhv:label></td>
			<td><%=lp.getDataFine().toString().substring(0,10)%></td>
		</tr>
	</table>
	</br>	
<% }
} %>
<!-- ------------------------------------------- -->










<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><dhv:label name="<%=label_operatore%>">
			<strong></strong>
		</dhv:label></th>
	</tr>
	
	<%String ragione_sociale = ""; %>
	
	<dhv:evaluate
		if="<%=(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneCanile)%>">
		<%ragione_sociale = OperatoreDettagli.getRagioneSociale();
		if (((CanileInformazioni) lp).isAbusivo()) {
			ragione_sociale += " -Abusivo- ";
		}
			 if (lp.getDataFine() != null) {
				 ragione_sociale += "-Chiuso-";
		} %>
		</dhv:evaluate>
		
			<dhv:evaluate
		if="<%=(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneImportatore || lp.getIdRelazioneAttivita() == LineaProduttiva.IdAggregazioneOperatoreCommerciale )%>">
			<%ragione_sociale = OperatoreDettagli.getRagioneSociale();
	
			 if (lp.getDataFine() != null) {
				 ragione_sociale += "-Chiuso-";
		} %>
		</dhv:evaluate>
		
		
	<dhv:evaluate
		if="<%=!(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneCanile || lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneImportatore || lp.getIdRelazioneAttivita() == LineaProduttiva.IdAggregazioneOperatoreCommerciale)%>">
		<%ragione_sociale = OperatoreDettagli.getRagioneSociale(); %>
	</dhv:evaluate>
	


	<dhv:evaluate if="<%=hasText(OperatoreDettagli.getRagioneSociale())%>">
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="<%=label_operatore_rag_sociale%>"></dhv:label></td>
			<td><%=toHtmlValue(ragione_sociale)%></td>
		</tr>
	</dhv:evaluate>

	<dhv:evaluate if="<%=hasText(OperatoreDettagli.getPartitaIva())%>">
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="opu.operatore.piva"></dhv:label></td>
			<td><%=toHtmlValue(OperatoreDettagli.getPartitaIva())%></td>
		</tr>
	</dhv:evaluate>


	<dhv:evaluate if="<%=hasText(OperatoreDettagli.getCodFiscale())%>">
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="opu.operatore.cf_impresa"></dhv:label></td>
			<td><%=toHtmlValue(OperatoreDettagli.getCodFiscale())%></td>
		</tr>
	</dhv:evaluate>
	
	<dhv:evaluate if="<%=hasText(lp.getTelefono1())%>">
			<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Telefono struttura (principale)</dhv:label></td>
			<td><%=toHtmlValue(lp.getTelefono1())%></td>
		</tr>
	</dhv:evaluate>
	
	<dhv:evaluate if="<%=hasText(lp.getTelefono2())%>">
			<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Telefono struttura (secondario)</dhv:label></td>
			<td><%=toHtmlValue(lp.getTelefono2())%></td>
		</tr>
	</dhv:evaluate>
	
		<dhv:evaluate if="<%=hasText(lp.getMail1())%>">
			<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Email</dhv:label></td>
			<td><%=toHtmlValue(lp.getMail1())%></td>
		</tr>
	</dhv:evaluate>
	
			<dhv:evaluate if="<%=hasText(lp.getFax())%>">
			<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Fax</dhv:label></td>
			<td><%=toHtmlValue(lp.getFax())%></td>
		</tr>
	</dhv:evaluate>
	</table>
	</br>
	<%
		}
	%>
	
	<!-- SEDE OPERATIVA -->
		<%
			if (lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneSindaco
						&& lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazionePrivato
						&& lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneSindacoFR) {
					String label_sede = "opu.stabilimento.sede_"
							+ lp.getIdRelazioneAttivita();
		%>
		<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2"><strong><dhv:label
					name="<%=label_sede%>"></dhv:label></strong></th>
			</tr>

			<dhv:evaluate
				if="<%=(AslList.size() > 0 && !StabilimentoDettaglio
									.isFlagFuoriRegione())%>">
				<!-- tr>

					<td class="formLabel" nowrap><dhv:label
						name="opu.stabilimento.asl"></dhv:label></td>
					<td><%=AslList.getSelectedValue(StabilimentoDettaglio
									.getIdAsl())%></td>
				</tr-->
			</dhv:evaluate>
			<dhv:evaluate
				if="<%=(StabilimentoDettaglio.getSedeOperativa() != null)%>">
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="<%=label_sede%>"></dhv:label></td>
					<td><%=sedeOperativa.toString()%>
					<!-- AGGIUNTA COORDINATE IN CASO DI CANILE O OP COMMERCIALE -->
					<% if(request.getAttribute("showCoordinate")!=null && Boolean.parseBoolean((String)request.getAttribute("showCoordinate"))){ %>
					<% 	if(StabilimentoDettaglio.getSedeOperativa().getLatitudine()>0 && StabilimentoDettaglio.getSedeOperativa().getLongitudine()>0){ %>
					&nbsp;&nbsp;-&nbsp;&nbsp;LATITUDINE:&nbsp;<%=StabilimentoDettaglio.getSedeOperativa().getLatitudine() %>,  
					&nbsp;LONGITUDINE:&nbsp;<%=StabilimentoDettaglio.getSedeOperativa().getLongitudine() %>
					&nbsp;&nbsp;-&nbsp;&nbsp;
					<a href="#" onclick="javascript:window.open('http://www.google.com/maps/place/<%=StabilimentoDettaglio.getSedeOperativa().getLatitudine()%>,<%=StabilimentoDettaglio.getSedeOperativa().getLongitudine()%>')">VISUALIZZA SU MAPPA</a>
					<% 	}else{ %>
					&nbsp;&nbsp;-&nbsp;&nbsp;
					<a href="#" onclick="javascript:window.open('http://www.google.it/maps?q=<%=sedeOperativa.toString()%>')">VISUALIZZA SU MAPPA</a>
					<%  } 
					} %>
					<!-- ******************************************************* -->
					</td>
				</tr>
			</dhv:evaluate>
		</table>

		<%
			}
		%>
		<br>
	
	<!-- CONTROLLI UFFICIALI -->
<dhv:evaluate if="<%=(lp.getIdRelazioneAttivita()==LineaProduttiva.idAggregazioneCanile || lp.getIdRelazioneAttivita()==LineaProduttiva.idAggregazioneImportatore || lp.getIdRelazioneAttivita()==LineaProduttiva.IdAggregazioneOperatoreCommerciale || lp.getIdRelazioneAttivita()==LineaProduttiva.idAggregazioneColonia)%>">
	<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
		<tr>
		<th colspan="2"><dhv:label name="">
			<strong>INFORMAZIONI CONTROLLI</strong>
		</dhv:label></th>
	</tr>
<dhv:evaluate if="<%=(lp.getIdRelazioneAttivita()==LineaProduttiva.idAggregazioneImportatore || lp.getIdRelazioneAttivita()==LineaProduttiva.IdAggregazioneOperatoreCommerciale )%>">

<tr><td class="formLabel" nowrap><dhv:label
				name="opu.stabilimento.autorizzazione">Autorizzazione</dhv:label></td>
			<td><%=(lp.getAutorizzazione() != null) ? lp.getAutorizzazione() : ""%> <%=(lp.getDataInizio() != null) ? " del " + lp.getDataInizioasString() : ""%>
			</td>
		</tr>
</dhv:evaluate>
	<dhv:evaluate
		if="<%=(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneCanile)%>">
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">CONTROLLI UFFICIALI</dhv:label></td>
			<td><%="Aperti: "
						+ ((CanileInformazioni) lp).getNrControlliAperti()
						+ " Chiusi: "
						+ ((CanileInformazioni) lp).getNrControlliChiusi()%></td>
		</tr>

		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">CATEGORIA RISCHIO</dhv:label></td>
			<td><%=((CanileInformazioni) lp).getCategoriaRischio()%></td>
		</tr>
		<dhv:evaluate
			if="<%=((CanileInformazioni) lp)
										.getDataProssimoControllo() != null%>">
			<tr class="containerBody">
				<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
					name="">DATA PROSSIMO CONTROLLO</dhv:label></td>
				<td><%=toDateasString(((CanileInformazioni) lp)
								.getDataProssimoControllo())%></td>
			</tr>
		</dhv:evaluate>

		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Abusivo</dhv:label></td>
			<td><%=(((CanileInformazioni) lp).isAbusivo()) ? "Si"
						: "No"%></td>
		</tr>

		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Centro di sterilizzazione</dhv:label></td>
			<td><%=(((CanileInformazioni) lp)
										.isCentroSterilizzazione()) ? "Si"
								: "No"%></td>
		</tr>
		
				<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Clinica / Ospedale</dhv:label></td>
			<td><%=(((CanileInformazioni) lp)
										.isFlagClinicaOspedale()) ? "Si"
								: "No"%></td>
		</tr>
		
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Superficie destinata al ricovero animali</dhv:label></td>
			<td><%
			String mq = "";
			if((((CanileInformazioni) lp).getMqDisponibili())>0){
				mq=String.valueOf((((CanileInformazioni) lp).getMqDisponibili()));
				}else{
					mq="N.D.";
					}%>
			
			<div id="divMqOld" style="display:block">
			<%=mq %>  mq.
			</div>
			<dhv:permission name="canili-campiestesi-edit">
			<input type="button" value="Modifica" id="mqModificaButton" onClick="showHideModificaMq()"/>
			
			
			
			
			
			<input type="hidden" id="oldMq" name=""oldMq"" value="<%=((CanileInformazioni) lp).getMqDisponibili()%>"/>
			<input type="hidden" id="idLinea" name="idLinea" value="<%=lp.getId()%>"/>
			<input type="hidden" id="idUtente" name="idUtente" value="<%=User.getUserId() %>"/>
			
			<div id="divMq" style="display:none">
			<input type="text" id="newMq" name="newMq" value="<%=mq%>" onkeyup="this.value=this.value.replace(/[^0-9]+/,'')"/>
			<input type="button" value="SALVA" onClick="modificaMq()"/>
			</div>
			<!-- 
			<br/><br/>
			
			<% String operazione = "BLOCCO";
				if(lp.getDataFine() != null)
					operazione="SBLOCCO";%>
			<input type="button" id="bloccaSbloccaButton" value="<%=operazione %> CANILE" onClick="showHideBloccaSblocca()"/>
			
			<div id="divBloccaSblocca" style="display:none">
			<textarea id="note" name="note" cols="80" rows="3"></textarea>
			<input type="button" value="SALVA" onClick="bloccaSblocca('<%=operazione%>')"/>
			</div>
			
			
			
			<br/><br/>-->
			</dhv:permission>
			
			</td>
		</tr>
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1">
				Indice di capienza
			</td>
<%
		double occupazioneAttuale = 0;
		if(request.getAttribute("occupazioneAttuale")!=null)
			occupazioneAttuale = (Double)request.getAttribute("occupazioneAttuale");
		double occupazioneTotale     = 0;		
		if(lp!=null)
			occupazioneTotale     = (((CanileInformazioni) lp).getMqDisponibili());
		double percentuale = 0;
		String colorFont = "green";
		
		
		if(occupazioneTotale>0)
			percentuale = (occupazioneAttuale/occupazioneTotale)*100;
		percentuale = new BigDecimal(percentuale).setScale(2 , BigDecimal .ROUND_UP).doubleValue();
		
		if(percentuale>=80 && percentuale<100)
			colorFont="orange";
		else if(percentuale>=100)
		{
			colorFont="red";
		}
%>

			<td>
				<b><font color="<%=colorFont%>"><%=occupazioneAttuale%> mq <%if(occupazioneTotale>0){ out.println(" (" + percentuale + " %)");} %></font></b>
			</td>
		</tr>
		
		
		
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1">
				Numero di cani presenti
			</td>
<%
		int limiteNumeroCaniVivi = Integer.parseInt(ApplicationProperties.getProperty("limite_numero_cani_vivi"));
		int numeroCaniVivi = 0;
		if(request.getAttribute("numeroCaniVivi")!=null)
			numeroCaniVivi = (Integer)request.getAttribute("numeroCaniVivi");

		percentuale = 0;
		colorFont = "green";
		
		if(numeroCaniVivi>0)
			percentuale = (Double.parseDouble(numeroCaniVivi+"")/limiteNumeroCaniVivi)*100;
		percentuale = new BigDecimal(percentuale).setScale(2 , BigDecimal .ROUND_UP).doubleValue();
		
		if(percentuale>=80 && percentuale<100)
			colorFont="orange";
		else if(percentuale>=100)
		{
			colorFont="red";
		}
%>

			<td>
				<b><font color="<%=colorFont%>"><%=numeroCaniVivi%> <%if(limiteNumeroCaniVivi>0){ out.println(" (" + percentuale + " %)");} %></font></b>
			</td>
		</tr>
		
		
<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Municipale</dhv:label></td>
			<td><%=(((CanileInformazioni) lp).isMunicipale()) ? "Si"
						: "No"%></td>
		</tr>

		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Autorizzazione</dhv:label></td>
			<td><%=(((CanileInformazioni) lp).getAutorizzazione())%></td>
		</tr>
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Data autorizzazione</dhv:label></td>
			<td><dhv:evaluate
				if="<%=(((CanileInformazioni) lp)
										.getDataAutorizzazione()) != null%>">
				<%=toDateasString((((CanileInformazioni) lp)
								.getDataAutorizzazione()))%>
			</dhv:evaluate></td>
		</tr>
			<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Data chiusura</dhv:label></td>
			<td><dhv:evaluate
				if="<%=lp.getDataFine() != null%>">
				<%=toDateasString(lp.getDataFine())%>
			</dhv:evaluate></td>
		</tr>
	</dhv:evaluate>

	<dhv:evaluate
		if="<%=(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneImportatore)%>">
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">CONTROLLI UFFICIALI</dhv:label></td>
			<td><%="Aperti: "
								+ ((ImportatoreInformazioni) lp)
										.getNrControlliAperti()
								+ " Chiusi: "
								+ ((ImportatoreInformazioni) lp)
										.getNrControlliChiusi()%></td>
		</tr>

		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">CATEGORIA RISCHIO</dhv:label></td>
			<td><%=((ImportatoreInformazioni) lp).getCategoriaRischio()%></td>
		</tr>
		<dhv:evaluate
			if="<%=((ImportatoreInformazioni) lp)
								.getDataProssimoControllo() != null%>">
			<tr class="containerBody">
				<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
					name="">DATA PROSSIMO CONTROLLO</dhv:label></td>
				<td><%=toDateasString(((ImportatoreInformazioni) lp)
								.getDataProssimoControllo())%></td>
			</tr>

		</dhv:evaluate>
		
					
				<tr class="containerBody">
					<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
						name="">Codice UVAC</dhv:label></td>
					<td><%=((ImportatoreInformazioni) lp).getCodiceUvac()%></td>
				</tr>
		
				<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">Superfice destinata al ricovero animali</dhv:label></td>
			<td><%=(((ImportatoreInformazioni) lp).getMqDisponibili())%></td>
		</tr>
		
	</dhv:evaluate>

	<dhv:evaluate
		if="<%=(lp.getIdRelazioneAttivita() == LineaProduttiva.IdAggregazioneOperatoreCommerciale)%>">
		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">CONTROLLI UFFICIALI</dhv:label></td>
			<td><%="Aperti: "
						+ ((OperatoreCommercialeInformazioni) lp)
								.getNrControlliAperti()
						+ " Chiusi: "
						+ ((OperatoreCommercialeInformazioni) lp)
								.getNrControlliChiusi()%></td>
		</tr>

		<tr class="containerBody">
			<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
				name="">CATEGORIA RISCHIO</dhv:label></td>
			<td><%=((OperatoreCommercialeInformazioni) lp)
								.getCategoriaRischio()%></td>
		</tr>
		<dhv:evaluate
			if="<%=((OperatoreCommercialeInformazioni) lp)
								.getDataProssimoControllo() != null%>">
			<tr class="containerBody">
				<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
					name="">DATA PROSSIMO CONTROLLO</dhv:label></td>
				<td><%=toDateasString(((OperatoreCommercialeInformazioni) lp)
										.getDataProssimoControllo())%></td>
			</tr>
		</dhv:evaluate>
		
		


	</dhv:evaluate>


	<dhv:evaluate
		if="<%=(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneColonia)%>">

			<tr class="containerBody">
				<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
					name="">CONTROLLI UFFICIALI</dhv:label></td>
				<td><%="Aperti: "
						+ ((ColoniaInformazioni) lp).getNrControlliAperti()
						+ " Chiusi: "
						+ ((ColoniaInformazioni) lp).getNrControlliChiusi()%></td>
			</tr>

			<tr class="containerBody">
				<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
					name="">CATEGORIA RISCHIO</dhv:label></td>
				<td><%=((ColoniaInformazioni) lp)
										.getCategoriaRischio()%></td>
			</tr>
			<dhv:evaluate
				if="<%=((ColoniaInformazioni) lp)
										.getDataProssimoControllo() != null%>">
				<tr class="containerBody">
					<td nowrap class="formLabel" name="orgname1" id="orgname1"><dhv:label
						name="">DATA PROSSIMO CONTROLLO</dhv:label></td>
					<td><%=toDateasString(((ColoniaInformazioni) lp)
								.getDataProssimoControllo())%></td>
				</tr>
			</dhv:evaluate>


			</dhv:evaluate>

			<!-- FINE CONTROLLI -->




		</table>
		
		</dhv:evaluate>
		<br />



		<!-- Sede legale -->
		<%
			if (lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneColonia) {
					String label_sede_legale = "opu.sede_legale_"
							+ idRelazioneAttivita;
					System.out.println("label_sede_legale: "+label_sede_legale);
		%>
		<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2"><dhv:label name="">
					<strong><dhv:label name="<%=label_sede_legale%>"></dhv:label></strong>
				</dhv:label></th>
			</tr>
			<dhv:evaluate if="<%=(OperatoreDettagli.getSedeLegale() != null)%>">
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="<%=label_sede_legale%>"></dhv:label></td>
					<td>
					<%%> <%=OperatoreDettagli.getSedeLegale()
											.toString()%></td>
				</tr>
				
				
				
				
			</dhv:evaluate>
		</table>
		<br>
		<%
			}
		%>

		<%
			String label_proprietario = "opu.soggetto_fisico_"
						+ lp.getIdRelazioneAttivita();
		
			boolean isColonia = lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneColonia;
		%>
		<dhv:evaluate if="<%=(isColonia && StabilimentoDettaglio.getRappLegale() != null) || (!isColonia && OperatoreDettagli.getRappLegale() != null)%>">
			<table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details">

				<tr>
					<th colspan="2"><strong><dhv:label
						name="<%=label_proprietario%>"></dhv:label></strong></th>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.nome"></dhv:label></td>
					<td><%=(isColonia)?(StabilimentoDettaglio.getRappLegale().getNome()):(OperatoreDettagli.getRappLegale().getNome()) %></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.cognome"></dhv:label></td>
					<td><%=(isColonia)?(StabilimentoDettaglio.getRappLegale().getCognome()):(OperatoreDettagli.getRappLegale().getCognome())%></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.cf"></dhv:label></td>
					<td><%=(isColonia)?(StabilimentoDettaglio.getRappLegale().getCodFiscale()):(OperatoreDettagli.getRappLegale().getCodFiscale())%></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.didentita"></dhv:label></td>
					<td><%=(isColonia)?((StabilimentoDettaglio.getRappLegale().getDocumentoIdentita()!=null) ? StabilimentoDettaglio.getRappLegale().getDocumentoIdentita() : ""):((OperatoreDettagli.getRappLegale().getDocumentoIdentita()!=null) ? OperatoreDettagli.getRappLegale().getDocumentoIdentita() : "") %></td>
				</tr>
				<dhv:evaluate if="<%=( lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazionePrivato  || 
						 			   lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneSindacoFR   ||
						 			  lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneColonia )%>">
					<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.nazione_nascita"></dhv:label></td>
					<% 
					 String nazioneNascita="";
					 String codNazioneNascita="";
					
					  if ( isColonia) {
						  codNazioneNascita=StabilimentoDettaglio.getRappLegale().getCodeNazioneNascita();
					  }
					  else{
						  codNazioneNascita=OperatoreDettagli.getRappLegale().getCodeNazioneNascita();
					  }
					  nazioneNascita= codNazioneNascita!=null &&  !codNazioneNascita.equals("") ?toHtml(NazioniListISO.getSelectedValue(codNazioneNascita)):"";
					  %> 
					<td>
				  <%=nazioneNascita %></td>
					</td>
				</tr>
				
				</dhv:evaluate>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.comune_nascita"></dhv:label></td>
					<td><%=(isColonia)?(StabilimentoDettaglio.getRappLegale().getComuneNascita()):(OperatoreDettagli.getRappLegale().getComuneNascita())%>
					</td>
				</tr>
				
				<tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.provincia_nascita"></dhv:label></td>
					<td><%=(isColonia)?(StabilimentoDettaglio.getRappLegale().getProvinciaNascita()):(OperatoreDettagli.getRappLegale().getProvinciaNascita())%></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.data_nascita"></dhv:label></td>
					<td><%=(isColonia)?(toDateString(StabilimentoDettaglio.getRappLegale().getDataNascita())):(toDateString(OperatoreDettagli.getRappLegale().getDataNascita()))%></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.sesso"></dhv:label></td>
					<td><%=(isColonia)?(StabilimentoDettaglio.getRappLegale().getSesso()):(OperatoreDettagli.getRappLegale().getSesso())%></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.fax"></dhv:label></td>
					<td><%=(isColonia)?(StabilimentoDettaglio.getRappLegale().getFax()):(OperatoreDettagli.getRappLegale().getFax())%></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.telefono"></dhv:label></td>
						<%String telefono1 = "";
						if(isColonia)
						{
						if (StabilimentoDettaglio.getRappLegale().getTelefono1() != null &&  !("").equals(StabilimentoDettaglio.getRappLegale().getTelefono1()))
							telefono1 = StabilimentoDettaglio.getRappLegale().getTelefono1();
						else if (lp.getTelefono1() != null)
							telefono1 = lp.getTelefono1();
						}
						else
						{
							if (OperatoreDettagli.getRappLegale().getTelefono1() != null &&  !("").equals(OperatoreDettagli.getRappLegale().getTelefono1()))
								telefono1 = OperatoreDettagli.getRappLegale().getTelefono1();
							else if (lp.getTelefono1() != null)
								telefono1 = lp.getTelefono1();
							
							
						}
						%>
					<td><%=telefono1%></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.telefono2"></dhv:label></td>
				<%String telefono2 = "";
				if(isColonia)
				{
						if (StabilimentoDettaglio.getRappLegale().getTelefono2() != null &&  !("").equals(StabilimentoDettaglio.getRappLegale().getTelefono2()))
							telefono2 = StabilimentoDettaglio.getRappLegale().getTelefono2();
						else if (lp.getTelefono2() != null)
							telefono2 = lp.getTelefono2();
				}
				else
				{
					if (OperatoreDettagli.getRappLegale().getTelefono2() != null &&  !("").equals(OperatoreDettagli.getRappLegale().getTelefono2()))
						telefono2 = OperatoreDettagli.getRappLegale().getTelefono2();
					else if (lp.getTelefono2() != null)
						telefono2 = lp.getTelefono2();
			
					
				}
						%>
					<td><%=telefono2%></td>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.mail"></dhv:label></td>
					<td><%=StabilimentoDettaglio.getRappLegale().getEmail()%></td>
				</tr>
				
				<dhv:evaluate if="<%=(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneCanile || lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneImportatore || lp.getIdRelazioneAttivita() == LineaProduttiva.IdAggregazioneOperatoreCommerciale)%>">
		
					<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.indirizzo"></dhv:label>
					</td>
					
					<%
					if(isColonia)
					{
					%>
					<td><%=(StabilimentoDettaglio.getRappLegale()
											.getIndirizzo() != null) ? StabilimentoDettaglio
									.getRappLegale().getIndirizzo().toString()
									: ""%></td>
					<%
					}
					else
					{
						%>	
						<td><%=(OperatoreDettagli.getRappLegale()
								.getIndirizzo() != null) ? OperatoreDettagli
						.getRappLegale().getIndirizzo().toString()
						: ""%></td>
						
						<%
						
					}
					%>
				</tr></dhv:evaluate>
				
				<dhv:evaluate if="<%=(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneColonia)%>">
		
					<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.soggetto_fisico.indirizzo"></dhv:label>
					</td>
					<td><%=(StabilimentoDettaglio.getRappLegale()
											.getIndirizzo() != null) ? StabilimentoDettaglio
									.getRappLegale().getIndirizzo().toString()
									: ""%></td>
				</tr></dhv:evaluate>
				
					</table>

<%if(ApplicationProperties.getProperty("flusso_336_req4").equals("true"))
			{%>
		<dhv:evaluate if="<%=OperatoreDettagli.getIdAssociazione()!=null && !OperatoreDettagli.getIdAssociazione().equals("-1")%>">

<br></br><table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details"> <tr>
					<th colspan="2"><strong>Associazione Animalista</strong></th>
				</tr><tr>
						<td class="formLabel" nowrap><dhv:label name="Note">Dettagli Associazione</dhv:label></td>
						<td><%=OperatoreDettagli.getDescrizioneAssociazione()%></td>
					</tr></table>

</dhv:evaluate>

<%}%>



				<dhv:evaluate
					if="<%=(StabilimentoDettaglio.getNote() != null && !StabilimentoDettaglio
										.getNote().equals("") && isColonia)%>">
						<br></br><table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details"> <tr>
					<th colspan="2"><strong>NOTE</strong></th>
				</tr><tr>
						<td class="formLabel" nowrap><dhv:label name="Note">Note</dhv:label></td>
						<td><%=StabilimentoDettaglio.getNote()%></td>
					</tr></table>
				</dhv:evaluate>
				
				
				<dhv:evaluate
					if="<%=(OperatoreDettagli.getNote() != null && !OperatoreDettagli
										.getNote().equals("") && !isColonia)%>">
						<br></br><table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details"> <tr>
					<th colspan="2"><strong>NOTE</strong></th>
				</tr><tr>
						<td class="formLabel" nowrap><dhv:label name="Note">Note</dhv:label></td>
						<td><%=OperatoreDettagli.getNote()%></td>
					</tr></table>
				</dhv:evaluate>

		</dhv:evaluate>
		<br />
		
		<br>
		<%
			if (lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneColonia
						&& lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazionePrivato
						&& lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneSindaco
						&& lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneSindacoFR) {
					String label_responsabile_stabilimento = "opu.stabilimento.soggetto_fisico_"
							+ idRelazioneAttivita;
		%>
		<dhv:evaluate
			if="<%=(StabilimentoDettaglio.getRappLegale() != null && StabilimentoDettaglio
											.getRappLegale().getCodFiscale() != null)%>">
			<table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details">

				<tr>
					<th colspan="2"><strong><dhv:label
						name="<%=label_responsabile_stabilimento%>"></dhv:label></strong></th>
				</tr>
				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.stabilimento.soggetto_fisico.ragione_sociale"></dhv:label>
					</td>
					<td><%=StabilimentoDettaglio.getRappLegale()
									.getCognome() + " "
							+ StabilimentoDettaglio.getRappLegale().getNome() + "<br/>Codice fiscale: "
							+ StabilimentoDettaglio.getRappLegale().getCodFiscale()%></td>
				</tr>

				<tr>
					<td class="formLabel" nowrap><dhv:label
						name="opu.stabilimento.soggetto_fisico.indirizzo_residenza"></dhv:label>
					</td>
					<td><%=(StabilimentoDettaglio.getRappLegale()
											.getIndirizzo() != null) ? StabilimentoDettaglio
									.getRappLegale().getIndirizzo().toString()
									: ""%></td>
				</tr>


			</table>
			<br />
		</dhv:evaluate>
		<%
			}
		%>

	

		<%
			if (lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneColonia) {
		%>
		<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">

			<tr>
				<th colspan="2"><strong><dhv:label name="">Informazioni colonia</dhv:label></th>
			</tr>

			<tr>
				<td class="formLabel" nowrap>Data registrazione colonia</td>
				<td><%=(((ColoniaInformazioni) lp)
										.getDataRegistrazioneColonia() != null) ? toDateasString(((ColoniaInformazioni) lp)
								.getDataRegistrazioneColonia())
								: "--"%></td>
			</tr>

			<tr>
				<td class="formLabel" nowrap>Numero protocollo</td>
				<td><%=((ColoniaInformazioni) lp).getNrProtocollo() == null || ((ColoniaInformazioni) lp).getNrProtocollo().equals("null") ? "" : ((ColoniaInformazioni) lp).getNrProtocollo() %></td>
			</tr>

			<tr>
				<td class="formLabel" nowrap>Numero totale gatti</td>
				<td><%=((ColoniaInformazioni) lp).getNrGattiTotale()%> --  Totale presunto: <%=(((ColoniaInformazioni) lp)
										.isTotalePresunto()) ? "Si" : "No"%></td>
			</tr>

			<tr>
				<td class="formLabel" nowrap>Data del censimento gatti</td>
				<td><%=(((ColoniaInformazioni) lp)
										.getDataCensimentoTotale() != null) ? toDateasString(((ColoniaInformazioni) lp)
								.getDataCensimentoTotale())
								: "--"%></td>
			</tr>
			
	

			<tr>
				<td class="formLabel" nowrap>Numero totale gatti identificati</td>
				<td><%=((ColoniaInformazioni) lp)
								.getTotaleIdentificatiSterilizzati()%></td>
			</tr>

			<tr>
				<td class="formLabel" nowrap>Numero totale gatti ancora da
				identificare</td>
				<td><%=((ColoniaInformazioni) lp)
										.getNrGattiDaCensire()%></td>
			</tr>
			
						<tr>
				<td class="formLabel" nowrap>Numero gatti sterilizzati</td>
				<td><%=((ColoniaInformazioni) lp).getNrGattiSterilizzati()%></td>
			</tr>
			
						<tr>
				<td class="formLabel" nowrap>Numero gatti non
				sterilizzati</td>
				<td><%=((ColoniaInformazioni) lp)
										.getNrGattiDaSterilizzare()%></td>
			</tr>



			<tr>
				<td class="formLabel" nowrap>Totale femmine</td>
				<td><%=((ColoniaInformazioni) lp).getNrGattiFTotale()%> -- Totale presunto: <%=(((ColoniaInformazioni) lp)
										.isTotaleFPresunto()) ? "Si" : "No"%></td>
			</tr>


			<tr>
				<td class="formLabel" nowrap>Totale maschi</td>
				<td><%=((ColoniaInformazioni) lp).getNrGattiMTotale()%> -- Totale presunto: <%=(((ColoniaInformazioni) lp)
										.isTotaleMPresunto()) ? "Si" : "No"%></td>
			</tr>


			<tr>
				<td class="formLabel" nowrap>Veterinario</td>
				<td><%= ((ColoniaInformazioni) lp).getNomeVeterinario() == null || ((ColoniaInformazioni) lp).getNomeVeterinario().equals("null") ? "" : ((ColoniaInformazioni) lp).getNomeVeterinario() %></td>
			</tr>
			</table>

			<%
				}
			%>




		
		
		</br></br>
		
		
<script>
//Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}



function open_jsp(tipoOperazione, dataOperazione, dataInizioAttivita){
	var w=650;
	var h=270;
	var left = (screen.width/2)-(w/2);
	var top = (screen.height/2)-(h/2);
	if(tipoOperazione=="annulla"){
			var r = confirm("Sicuro di voler annullare pianificazione BLOCCO/SBLOCCO?");
		if (r == true) {
			window.location.href="OperatoreAction.do?command=BloccaSbloccaCanile&motivo_ingresso_uscita=<%=OperatoreDettagli.getMotivo_ingresso_uscita()%>&operazione=annulla&id_linea_produttiva=<%=lp.getIdRelazioneAttivita()%>&idCanile="+document.getElementById("idLinea").value;
			return true; 
		}else{
			return false;
		}
	}else{
		var win= window.open('OperatoreAction.do?command=BloccaSbloccaCanile&motivo_ingresso_uscita=<%=OperatoreDettagli.getMotivo_ingresso_uscita()%>&id_linea_produttiva=<%=lp.getIdRelazioneAttivita()%>&operazione='+tipoOperazione+'&data_inizio_attivita='+dataInizioAttivita+'&data_operazione='+dataOperazione+'&idCanile='+document.getElementById("idLinea").value,
			  '','scrollbars=1,width='+w+',height='+h+',top='+top+', left='+left);
		if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock(); } }, 1000); }	

	}

}


function Sync(getid,entita)
{
	console.log(<%=ApplicationProperties.getProperty("BDU2SINAC_ATTIVO")%>);
	
	<%
	if(ApplicationProperties.getProperty("BDU2SINAC_ATTIVO").equals("true"))
	{
	%>
	console.log(entita);

	if(entita == 'detentore')
		{
		entita = "proprietario";
		}
	
	popURL("SinaafAction.do?command=Redirect2Bdu2Sinac&idEntita="+getid+"&entita="+entita+"&tipo=sincronizza",'Sinaaf','650','500','yes','yes');
	//loadModalWindow();
	//setTimeout(function() {
	//	  window.location.reload()
	//	}, 10000);
	
	<%
	}else
	{
	%>
	

	location.href='SinaafAction.do?command=Invia&idSinaaf=<%=ws.idSinaaf%>&entita=proprietario&id=<%=lp.getId()%>&urlToRedirect=OperatoreAction.do?command=Details_____opId=<%=lp.getId()%>'

	
	<%
	}
	%>
	
	}

function getBody(getid,entita)
{
	
	
	
	<%
	if(ApplicationProperties.getProperty("BDU2SINAC_ATTIVO").equals("true"))
	{
	%>
	console.log(entita);

	if(entita == 'detentore')
		{
		  entita = "proprietario";
		}
	
	popURL("SinaafAction.do?command=Redirect2Bdu2Sinac&idEntita="+getid+"&entita="+entita+"&tipo=body",'Sinaaf','650','500','yes','yes');
		
	<%
	}else
	{
	%>
	

	window.open('SinaafAction.do?command=VediRequest&idSinaaf=<%=ws.idSinaaf%>&entita=proprietario&id=<%=lp.getId()%>&urlToRedirect=OperatoreAction.do?command=Details_____opId=<%=lp.getId()%>','Sinaaf','650','500','yes','yes')

	<%
	}
	%>
}
	
	function VediInSinaaf(getid,entita)
	{
		
		
		
		<%
		if(ApplicationProperties.getProperty("BDU2SINAC_ATTIVO").equals("true"))
		{
		%>
		console.log(entita);

		if(entita == 'detentore')
			{
			  entita = "proprietario";
			}
		
		popURL("SinaafAction.do?command=Redirect2Bdu2Sinac&idEntita="+getid+"&entita="+entita+"&tipo=vediInSinaaf",'Sinaaf','650','500','yes','yes');
			
		<%
		}else
		{
		%>
		

		popURL('SinaafAction.do?command=Vedi&idSinaaf=<%=ws.idSinaaf%>&entita=proprietario&id=<%=lp.getId()%>','Sinaaf','650','500','yes','yes'); 

	<%
	}
	%>
	
	
	
	
	
	
}

	function monitoraggio(getid,entita)
	{
		
		
		
		<%
		if(ApplicationProperties.getProperty("BDU2SINAC_ATTIVO").equals("true"))
		{
		%>
		console.log(entita);

		if(entita == 'detentore')
			{
			  entita = "proprietario";
			}
		
		popURL("SinaafAction.do?command=Redirect2Bdu2Sinac&idEntita="+getid+"&entita="+entita+"&tipo=monitoraggio",'Sinaaf','650','500','yes','yes');
			
		<%
		}else
		{
		%>
	
	<%
	}
	%>

	
}




</script>