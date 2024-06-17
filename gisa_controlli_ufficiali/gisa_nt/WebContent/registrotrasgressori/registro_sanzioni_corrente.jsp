<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    
<%@ include file="../../utils23/initPage.jsp"%>

<%@page import="org.aspcfs.modules.registrotrasgressori.base.*"%>

<jsp:useBean id="listaTrasgressioni" class="java.util.Vector" scope="request"/>
<jsp:useBean id="messaggio" class="java.lang.String" scope="request"/>
<jsp:useBean id="anno" class="java.lang.String" scope="request"/>
<jsp:useBean id="trimestre" class="java.lang.String" scope="request"/>
<jsp:useBean id="gruppiUtente" type="java.util.ArrayList" scope="request" />

<% UserBean user = (UserBean) session.getAttribute("User");%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %> 

<%@ include file="js/registro_sanzioni_js.jsp"%>
<script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script>

<style>
table {
  border-collapse: separate;
  border-spacing: 0; 
}
th,
td {
  padding: 1rem;
  border: 1px solid black;
  text-align: center;
}
th {
  background-color: #BDCFFF;
 }
thead,
tfoot {
  background: #eee;
  }
thead {
  position: sticky;
  top: 0;
  
}
tfoot {
  position: sticky;
  bottom: 0;
  border-top: 2px solid #ccc;
}


</style>

<link rel="stylesheet" documentale_url="" href="registrotrasgressori/css/trasgressori_screen.css" type="text/css" media="screen" />
<link rel="stylesheet" documentale_url="" href="registrotrasgressori/css/trasgressori_print.css" type="text/css" media="print" />

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<script>
function mostraNascondiIuv(id, tipo){
	
	var div = document.getElementById("divIuv_"+tipo+"_"+id);
	if (div.style.display=='none')
		div.style.display='block';
	else
		div.style.display='none';
				
}

function modifica(id){
	loadModalWindow();
	window.location.href = "RegistroTrasgressori.do?command=ModificaSanzione&id="+id;
}

function dettaglioPagoPa(idSanzione){
	
	var windowPagoPa = window.open('GestionePagoPa.do?command=View&idSanzione='+idSanzione+'&origine=NumeroOrdinanza','popupPagoPa'+idSanzione,
         'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	
	windowPagoPa.focus();

}

function modificaForzataSanzione(idSanzione){

if (!confirm("Attenzione. Tramite questa funzionalità sarà possibile modificare TRASGRESSORE ed OBBLIGATO IN SOLIDO della sanzione selezionata.\n\n Assicurarsi di utilizzare la fuzionalità in coerenza con eventuali processi verbali già emessi. \n\n La funzionalità non sarà disponibile se sulla sanzione sono già stati generati avvisi di pagamento.\n\n Ogni modifica sarà tracciata. \n\n Proseguire? "))
	 return false;

	var windowModifica = window.open('GestionePagoPa.do?command=ModificaForzataSanzione&idSanzione='+idSanzione,'popupModificaForzataSanzione'+idSanzione,
         'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	
	windowModifica.focus();

}

</script>

<script>$(document).ready(function() {
      loadModalWindowUnlock();
}); 
</script>

<div class="documentaleNonStampare">
<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>
</div>

<div class="documentaleStampare" style="display:none">
<div class="boxIdDocumento"></div> <div class="boxOrigineDocumento"><%@ include file="../../utils23/hostName.jsp" %></div>
</div>

<script type="text/javascript">
loadModalWindowCustom('<div style="color:red; font-size: 40px;">Attendere la corretta compilazione del Registro Trasgressori... </div>');
</script>

<div align="left">
<label class="layout">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <b>REGISTRO SANZIONI AMMINISTRATIVE</b> ANNO <b><%= anno %></b> <%=(trimestre!=null && !trimestre.equals("-1")) ? "TRIMESTRE <b>" +trimestre : "</b>"%></label>
</div> 

<table id = "tablelistatrasgressioni">

	<thead>
		<tr class="tablesorter-headerRow" role="row">
			<% int index = -1; %>
			<% index++;%> <th>Azione </th>  
			<% index++;%> <th>N° prog <br/>  <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th>  
			<% index++;%> <th>Id controllo <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""> </th>  
			<% index++;%> <th>ASL di competenza <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th>  
			<% index++;%> <th>Ente accertatore 1 <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th> 
			<% index++;%> <th>Ente accertatore 2 <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th>  
			<% index++;%> <th>Ente accertatore 3 <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th>
			<% index++;%> <th>PV N° <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""> </th>  
			<% index++;%> <th>Num. sequestro eventualmente effettuato <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th> 
			<% index++;%> <th>Data accertamento  <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""> </th>  
			<% index++;%> <th>Data prot. in entrata in regione</th>  
			<% index++;%> <th>Trasgressore <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th>   
			<% index++;%> <th>Obbligato in solido <br/> <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th>
			<% index++;%> <th>Importo sanzione ridotta</th>
			<% index++;%> <th>Importo sanzione ridotta del 30%</th>  
			<% index++;%> <th>Illecito di competenza U.O.D. 01</th>  
			<% index++;%> <th>PV oblato in misura ridotta</th> 
			<% index++;%> <th>PV oblato in misura ultraridotta</th> 
			<% index++;%> <th>Data pagamento PV</th> 
			<% index++;%> <th>Funzionario assegnatario</th> 
			<% index++;%> <th>Presentati scritti difensivi</th> 	
			<% index++;%> <th>Presentata richiesta riduzione sanzione e/o rateizzazione</th> 
			<% index++;%> <th>Presentata richiesta audizione</th> 
			<% index++;%> <th>Ordinanza emessa</th> 
			<% index++;%> <th>Num. ordinanza <input type="text" id="myInput<%=index %>" onkeyup="filtra('<%=index %>')" placeholder=""></th> 
			<% index++;%> <th>Data di emissione dell'Ordinanza</th> 
			<% index++;%> <th>Giorni di lavorazione pratica</th> 
			<% index++;%> <th>Importo sanzione ingiunta</th> 
			<% index++;%> <th>Data ultima notifica ordinanza</th> 
			<% index++;%> <th>Data pagamento ordinanza</th> 
			<% index++;%> <th>Concessa rateizzazione dell'ordinanza-ingiunzione</th> 
			<% index++;%> <th>Rate pagate</th> 
			<% index++;%> <th>Ordinanza ingiunzione oblata</th> 
			<% index++;%> <th>Importo effettivamente introitato (2)</th> 
			<% index++;%> <th>Presentata opposizione all'ordinanza-ingiunzione</th> 
			<% index++;%> <th>Sentenza favorevole al ricorrente</th> 
			<% index++;%> <th>Importo stabilito dalla A.G.</th> 
			<% index++;%> <th>Ordinanza-ingiunzione oblata secondo il dispositivo della sentenza</th> 
			<% index++;%> <th>Importo effettivamente introitato (3)</th> 
			<% index++;%> <th>Avviata per l'esecuzione forzata</th> 
			<% index++;%> <th>Importo effettivamente introitato (4)</th> 
			<% index++;%> <th>IUV/RT Generati per PV</th>
			<% index++;%> <th>IUV/RT Generati per Ord./ingiunz.</th>
			<% index++;%> <th>Note Gruppo 1</th> 
			<% index++;%> <th>Note Gruppo 2</th> 
			<% index++;%> <th>Processo Verbale</th> 
			<% index++;%> <th>Altri allegati inseriti dagli agenti</th> 
			<% index++;%> <th>Avvisi esterni a GISA</th> 
			<% index++;%> <th>Avvisi esterni a GISA pagati</th> 
			<% index++;%> <th>Altri allegati</th>
			<% index++;%> <th>Pratica chiusa</th> 
					
		</tr>
	</thead>
	<tbody aria-relevant="all" aria-live="polite">
	
	<%if (listaTrasgressioni.size()>0){
		for (int i=0;i<listaTrasgressioni.size(); i++){
			Trasgressione trasgr = (Trasgressione) listaTrasgressioni.get(i);
	%>
		
		<tr id="riga_<%=i%>" class="<% if (trasgr.getPagopaDoppiPagamenti() != null && !"".equals(trasgr.getPagopaDoppiPagamenti())) { %>red<%} else if ("C".equals(trasgr.getOrdinanzaEmessa())){%>orange<%} else if (trasgr.isPraticaChiusa()){%>green<%} else {%>"row"+i%2<%} %>">
			
			<td>
			<dhv:permission name="registro_trasgressori-edit">
			<input type="button" value="Modifica" onClick="modifica('<%=trasgr.getId()%>')"/>
			</dhv:permission>
			
			<% if (org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("GESTIONE_PAGOPA")!=null && org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("GESTIONE_PAGOPA").equalsIgnoreCase("si")) {%>
			<% if (PopolaCombo.isPrevistoPagoPA(trasgr.getIdSanzione())){ %>
			<%if (gruppiUtente.contains(1)) { %>
			<dhv:permission name="pagopa_gestione-view">
			<br/><br/>
			<input type="button" id="invia" value="GESTIONE PAGOPA" onClick="dettaglioPagoPa('<%=trasgr.getIdSanzione()%>')"/>
			</dhv:permission>
			<%} %>
			<%} %>
			<%} %>
			  
			<dhv:permission name="sanzioni_modifica_trasgressori-view"> <!-- LIVELLO 1: PERMESSO SUL RUOLO -->
			<% if (PopolaCombo.hasCfPermission(user.getContact().getCodiceFiscale(), "sanzioni_modifica_trasgressori-view" )) { %> <!-- LIVELLO 2: PERMESSO SUL CF -->
			<br/><br/>
			<input type="button" id="invia" value="MODIFICA FORZATA SANZIONE" onClick="modificaForzataSanzione('<%=trasgr.getIdSanzione()%>')"/>
			<%} %>
			</dhv:permission>
			  
			 </td>			
			<td><%= trasgr.getProgressivo() %>\<%=trasgr.getAnnoYY() %></td>
			
			<td> 
			
			<label class="layout">
			
			<% if (trasgr.getIdControllo()>0) {
				boolean linkVisibile = false; %>
			
				<dhv:permission name="registro_trasgressori_link_cu-view">
				<% linkVisibile = true; %>
				<a href="Vigilanza.do?command=TicketDetails&id=<%=trasgr.getIdControllo() %>" target="_blank"><%=trasgr.getIdControllo() %></a>
				</dhv:permission>
				
				<% if (!linkVisibile) { %>
					<%=trasgr.getIdControllo() %>
				<%} %>
				
			<% } %>
			
			</label> 
			
			</td>
			
			<td>  
			<label class="layout"><%=(trasgr.getAsl()!=null) ? trasgr.getAsl() : "" %></label> </td>
			
			<% LinkedHashMap<String,String> listaEnti = trasgr.getListaEnti();
			int q = 0;
			for(Map.Entry<String, String> ente : listaEnti.entrySet()){
				q++;
			%>
			<td>  
			<label class="layout"><%=(ente.getValue()!=null) ? ente.getValue() : "" %></label></td>
			<%} %>
			
			<% for (int o = q; o<3; o++) {%>
			<td>  <label class="layout"><%="" %></label> </td>
			<%} %>
			
			<td>
			<label class="layout"><%=(trasgr.getPV()!=null) ? trasgr.getPV() : "" %></label> </td>
			
			<td>
			<label class="layout"><%=(trasgr.getPVsequestro()!=null) ? trasgr.getPVsequestro() : "" %></label> </td>
			
			<td>  
			<label class="layout"><%=(trasgr.getDataAccertamento()!=null) ?  toDateasString(trasgr.getDataAccertamento()) : "" %></label> </td>
			
			<td> 
			<label class="layout"><%=(trasgr.getDataProt()!=null) ?  toDateasString(trasgr.getDataProt()) : "" %></label>
			</td>
						
			<td>  
			<label class="layout"><%=(trasgr.getTrasgressore()!=null) ? trasgr.getTrasgressore() : "" %></label></td>
			
			<td>  
			<label class="layout"><%=(trasgr.getObbligatoInSolido()!=null) ? trasgr.getObbligatoInSolido() : "" %></label></td>
			
			<td>  
			<label class="layout"><%= trasgr.getImportoSanzioneRidotta() %>  &#x20ac; </label> </td>
			
			<td>  
			<label class="layout"><%=(trasgr.getImportoSanzioneUltraridotta() !=null) ? trasgr.getImportoSanzioneUltraridotta() : "" %></label></td>
			
			<td> 
			<input type="checkbox"  disabled <% if (trasgr.isCompetenzaRegionale()){ %> checked="checked" <%} %>/>  </td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<input type="checkbox" disabled <% if (trasgr.isPagopaPvOblatoRidotta()){ %> checked="checked" <%} %>/> 
			</td>
			<% } %>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<input type="checkbox" disabled <% if (trasgr.isPagopaPvOblatoUltraRidotta()){ %> checked="checked" <%} %>/> 
			</td>
			<% } %>
		
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<label class="layout"><%=(trasgr.getPagopaPvDataPagamento()!=null) ?  toDateasString(trasgr.getPagopaPvDataPagamento()) : "" %></label>
			<%} %></td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<label class="layout"><%=(trasgr.getFiAssegnatario()!=null) ? trasgr.getFiAssegnatario() : "" %></label>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<input type="checkbox" disabled <% if (trasgr.isPresentatiScritti()){ %> checked="checked" <%} %> /> 
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<input type="checkbox" disabled <% if (trasgr.isRichiestaRiduzioneSanzione()){ %> checked="checked" <%} %> />
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<input type="checkbox" disabled <% if (trasgr.isRichiestaAudizione()){ %> checked="checked" <%} %> />
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<input type="radio" disabled <% if ("A".equals(trasgr.getOrdinanzaEmessa())){ %> checked="checked" <%} %>/> Ord. Archiviazione <br/>
			<input type="radio" disabled <% if ("B".equals(trasgr.getOrdinanzaEmessa())){ %> checked="checked" <%} %>/> Ord. Ingiunzione <br/>
			<input type="radio" disabled <% if ("C".equals(trasgr.getOrdinanzaEmessa())){ %> checked="checked" <%} %>/> Pratica non lavorata 
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<label class="layout"><%=(trasgr.getNumOrdinanza()!=null) ? trasgr.getNumOrdinanza() : "" %></label> 
			<% } %>
			</td>
			 
			<td>  
			<% if (trasgr.isCompetenzaRegionale()) { %>
           	<label class="layout"><%=(trasgr.getDataEmissione()!=null) ?  toDateasString(trasgr.getDataEmissione()) : "" %></label>
		 	<% } %>
		 	</td>
		 
		 	<td> 
		 	<% if (trasgr.isCompetenzaRegionale()) { %>
			<label class="layout"><%=(trasgr.getGiorniLavorazione()>-1) ? trasgr.getGiorniLavorazione() : "" %></label>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa())) {%>
			<label class="layout"><%=trasgr.getImportoSanzioneIngiunta() %></label> &#x20ac;
			<% } %> 
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa())) {%>
			<label class="layout"><%=(trasgr.getDataUltimaNotificaOrdinanza()!=null) ?  toDateasString(trasgr.getDataUltimaNotificaOrdinanza()) : "" %></label>
			<% } %> 
			<% } %>
			 </td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa())) {%>
			<label class="layout"><%=(trasgr.getDataPagamentoOrdinanza()!=null) ?  toDateasString(trasgr.getDataPagamentoOrdinanza()) : "" %></label>
			<% } %> 
			<% } %>
			</td>

			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa())) {%>
		    <input type="radio" disabled <% if (trasgr.isRichiestaRateizzazione()){ %> checked="checked" <%} %>/> SI <br/>
			<input type="radio" disabled <% if (!trasgr.isRichiestaRateizzazione()){ %> checked="checked" <%} %>/> NO 
			<% } %>
			<% } %>
			</td>
		
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
<%-- 			<% if ("B".equals(trasgr.getOrdinanzaEmessa()) && trasgr.isRichiestaRateizzazione()) {%> --%>
			<%= (trasgr.getPagopaNoRatePagate().length()>0) ? trasgr.getPagopaNoRatePagate().trim()  :"" %>
<%-- 			<% } %> --%>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa())) {%>
			<input type="checkbox" disabled <% if (trasgr.isIngiunzioneOblata()){ %> checked="checked" <%} %> />
			<% } %>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa())) {%>
			<label class="layout"><%=trasgr.getImportoEffettivamenteVersato2() %></label> &#x20ac;
			<% } %>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa())) {%>
			<input type="checkbox" disabled <% if (trasgr.isPresentataOpposizione()){ %> checked="checked" <%} %> /> 
			<% } %>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa())) {%>
			<input type="radio" disabled <% if (trasgr.isSentenzaFavorevole()){ %> checked="checked" <%} %>/> SI <br/>
			<input type="radio" disabled <% if (!trasgr.isSentenzaFavorevole()){ %> checked="checked" <%} %>/> NO 
			<% } %>
			<% } %>
			</td>
		
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa()) && !trasgr.isSentenzaFavorevole()) {%>
			<label class="layout"><%=trasgr.getImportoStabilito() %></label> &#x20ac; 
			<% } %>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa()) && !trasgr.isSentenzaFavorevole()) {%>
			<input type="checkbox" disabled <% if (trasgr.isIngiunzioneOblataSentenza()){ %> checked="checked" <%} %> />
			<% } %>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa()) && !trasgr.isSentenzaFavorevole()) {%>
			<label class="layout"><%=trasgr.getImportoEffettivamenteVersato3() %></label> &#x20ac;
			<% } %>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa()) && !trasgr.isSentenzaFavorevole()) {%>
			<input type="checkbox" disabled <% if (trasgr.isIscrizioneRuoliSattoriali()){ %> checked="checked" <%} %> />
			<% } %>
			<% } %>
			</td>
			
			<td> 
			<% if (trasgr.isCompetenzaRegionale()) { %>
			<% if ("B".equals(trasgr.getOrdinanzaEmessa()) && !trasgr.isSentenzaFavorevole()) {%>
			<label class="layout"><%=trasgr.getImportoEffettivamenteVersato4() %></label> &#x20ac; 
			<% } %>
			<% } %>
			</td>
			
			<td>
			
			<% if (trasgr.getPagopaPvIuv()!=null && !trasgr.getPagopaPvIuv().equals("") && trasgr.getListaPagopaPvIuv().length>0) {%>
			<div style="display:none" id="divIuv_PV_<%=trasgr.getId()%>">
			<% for (int k = 0; k<trasgr.getListaPagopaPvIuv().length; k++) {
					String iuvCompleto = (String) trasgr.getListaPagopaPvIuv()[k];
					String iuv[] = iuvCompleto.split("!");
					String iuvIuv = "";
					String iuvHeader = "";
					String iuvStato = "";
					try {iuvIuv = iuv[0];} catch (Exception e){}
					try {iuvHeader = iuv[1];} catch (Exception e){}
					try {iuvStato = iuv[2];} catch (Exception e){}
					%> 					
					<% if (iuvHeader!=null && !iuvHeader.equals("") ) { %>
					<a href="#" onClick="openRichiestaDownload('<%= iuvHeader %>', '<%=Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(iuvStato) ? "RT" : "AVVISO"%>_<%=iuvIuv%>', 'true'); return false;"><%=iuvIuv %> (<%=iuvStato %>)</a>
					<%} else { %>
					<%=iuvIuv %> (<%=iuvStato %>)
					<%} %>
					
					<br/><br/>
					
		 		<%}%>
		 	</div>	
		 	<a href="#" onClick="mostraNascondiIuv('<%=trasgr.getId()%>', 'PV'); return false;">[MOSTRA/NASCONDI]</a>
		 	<% } %>
		 	
		 	</td>
		 	
		 	
		 	<td>
			<% if (trasgr.getPagopaNoIuv()!=null && !trasgr.getPagopaNoIuv().equals("") && trasgr.getListaPagopaNoIuv().length>0) {%> 
				<div style="display:none" id="divIuv_NO_<%=trasgr.getId()%>">
				<%	for (int k = 0; k<trasgr.getListaPagopaNoIuv().length; k++) {
					String iuvCompleto = (String) trasgr.getListaPagopaNoIuv()[k];
					String iuv[] = iuvCompleto.split("!");  
					String iuvIuv = "";
					String iuvHeader = "";
					String iuvStato = "";
					try {iuvIuv = iuv[0];} catch (Exception e){}
					try {iuvHeader = iuv[1];} catch (Exception e){}
					try {iuvStato = iuv[2];} catch (Exception e){}
					%> 
					<% if (iuvHeader!=null && !iuvHeader.equals("")) { %>
					<a href="#" onClick="openRichiestaDownload('<%= iuvHeader %>', '<%=Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(iuvStato) ? "RT" : "AVVISO"%>_<%=iuvIuv%>', 'true'); return false;"><%=iuvIuv %> (<%=iuvStato %>)</a>
					<%} else { %>
					<%=iuvIuv %> (<%=iuvStato %>)
					<%} %>
					
					<br/><br/>
					
		 		<%}%>
		 		</div>
		 		<a href="#" onClick="mostraNascondiIuv('<%=trasgr.getId()%>', 'NO'); return false;">[MOSTRA/NASCONDI]</a>
		 		<% } %>
		 		
		 	</td>
			
			<td> 
			<textarea class="layout" disabled><%= (trasgr.getNote1()!=null) ? trasgr.getNote1() : ""%></textarea>
			</td>
			
			<td> 
			<textarea class="layout" disabled><%= (trasgr.getNote2()!=null) ? trasgr.getNote2() : ""%></textarea>
			</td>
		
			<td> 
			<div id="linkDocumentoPv_<%=i%>">
			<% if (trasgr.getAllegatoPv()!=null && !trasgr.getAllegatoPv().replaceAll("#", "").equals("")) { 
				for (int k = 0; k<trasgr.getListaAllegatiPv().length; k++) {
					String[] alleg = trasgr.getListaAllegatiPv()[k].split("#");
					String header = "", oggetto = "", nomeClient = "";
					try {header= alleg[0];} catch (Exception e) {}
					try {oggetto= alleg[1];} catch (Exception e) {}
					try {nomeClient= alleg[2];} catch (Exception e) {}
					if (oggetto.equals("")) oggetto = header;
					if (nomeClient.equals("")) nomeClient = header;
					%>
					<a id = "<%=header%>_download" href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=header%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %>  </a><br/><br/>
		 		<%} } %>
		 	</div> 
		 	</td>
		 	
		 	<td>
			<div id="linkDocumentoAl_<%=i%>">
			<% if (trasgr.getAllegatoAl()!=null && !trasgr.getAllegatoAl().replaceAll("#", "").equals("")) { 
				for (int k = 0; k<trasgr.getListaAllegatiAl().length; k++) {
					String[] alleg = trasgr.getListaAllegatiAl()[k].split("#");
					String header = "", oggetto = "", nomeClient = "";
					try {header= alleg[0];} catch (Exception e) {}
					try {oggetto= alleg[1];} catch (Exception e) {}
					try {nomeClient= alleg[2];} catch (Exception e) {}
					if (oggetto.equals("")) oggetto = header;
					if (nomeClient.equals("")) nomeClient = header;
					%>
					<a id = "<%=header%>_download" href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=header%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %>  </a><br/><br/>
		 		<%} } %>
		 	</div> 
		 	</td>
		 	
		 	<td> 
			<div id="linkDocumentoAe_<%=i%>">
			<% if (trasgr.getAllegatoAe()!=null && !trasgr.getAllegatoAe().replaceAll("#", "").equals("")) { 
				for (int k = 0; k<trasgr.getListaAllegatiAe().length; k++) {
					String[] alleg = trasgr.getListaAllegatiAe()[k].split("#");
					String header = "", oggetto = "", nomeClient = "";
					try {header= alleg[0];} catch (Exception e) {}
					try {oggetto= alleg[1];} catch (Exception e) {}
					try {nomeClient= alleg[2];} catch (Exception e) {}
					if (oggetto.equals("")) oggetto = header;
					if (nomeClient.equals("")) nomeClient = header;
					%>
					<a id = "<%=header%>_download" href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=header%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %>  </a><br/><br/>
		 		<%} } %>
		 	</div> 
		 	</td>
		 	
		 	<td> 
			<input type="checkbox" disabled <% if (trasgr.isAePagati()){ %> checked="checked" <%} %> /> 
			</td>
		 	
		 	<td> 
			<div id="linkDocumentoRt_<%=i%>">
			<% if (trasgr.getAllegatoRt()!=null && !trasgr.getAllegatoRt().replaceAll("#", "").equals("")) { 
				for (int k = 0; k<trasgr.getListaAllegatiRt().length; k++) {
					String[] alleg = trasgr.getListaAllegatiRt()[k].split("#");
					String header = "", oggetto = "", nomeClient = "";
					try {header= alleg[0];} catch (Exception e) {}
					try {oggetto= alleg[1];} catch (Exception e) {}
					try {nomeClient= alleg[2];} catch (Exception e) {}
					if (oggetto.equals("")) oggetto = header;
					if (nomeClient.equals("")) nomeClient = header;
					%>
					<a id = "<%=header%>_download" href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=header%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %>  </a><br/><br/>
		 		<%} } %>
		 	</div> 
		 	</td>
		 
			<td> 
			<input type="checkbox" disabled <% if (trasgr.isPraticaChiusa()){ %> checked="checked" <%} %> /> 
			</td>
		 
		 </tr>
		
		<% } } else {%>
		
		<tr><td colspan="5"> Non sono presenti controlli per l'anno o il trimestre corrente. &nbsp; </td></tr>
		
		<% } %>
	
	</tbody>
	
	</table>
	
