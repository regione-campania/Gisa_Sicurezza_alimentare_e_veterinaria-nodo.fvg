<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="Registro" class="org.aspcfs.modules.registrocaricoscarico.base.recapiti.RegistroRecapiti" scope="request"/>

<jsp:useBean id="riferimentoId" class="java.lang.String" scope="request"/>
<jsp:useBean id="riferimentoIdNomeTab" class="java.lang.String" scope="request"/>
<jsp:useBean id="RagioneSociale" class="java.lang.String" scope="request"/>
<jsp:useBean id="NumRegistrazioneStab" class="java.lang.String" scope="request"/>

<jsp:useBean id="TipiSpecie" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiRazzaBovini" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiRazzaEquini" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiRazzaSuini" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiRazzaAsini" class="org.aspcfs.utils.web.LookupList" scope="request" />

<jsp:useBean id="TipiSeme" class="org.aspcfs.utils.web.LookupList" scope="request" />

<%@page import="org.aspcfs.modules.registrocaricoscarico.base.recapiti.*"%>

<%@ include file="../../../utils23/initPage.jsp"%>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<link rel="stylesheet" type="text/css" media="screen" documentale_url="" href="registrocaricoscarico/css/style.css" />

<link rel="stylesheet" type="text/css" href="javascript/jquerypluginTableSorter/css/theme.css"></link>
<link rel="stylesheet" type="text/css" href="javascript/jquerypluginTableSorter/css/jquery.tablesorter.pages.css"></link>

<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.js"></script>
<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.pager.js"></script>

<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.widgets.js"></script>
<script type="text/javascript" src="javascript/jquerypluginTableSorter/tableJqueryFilterDialogRegistriCS.js"></script>


<script>
function openPopupAddModifyCarico(idRegistro, numReg, idCarico){
	var idTipologiaRegistro = document.getElementById("idTipologiaRegistro").value;
	var windowInsert = window.open('GestioneRegistroCaricoScarico.do?command=AddModifyCarico&idRegistro='+idRegistro+'&numRegistrazioneStab='+numReg+'&idCarico='+idCarico+'&idTipologiaRegistro='+idTipologiaRegistro,'popupRegistroCSC'+idRegistro,
         'height=600px,width=500px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	
	windowInsert.focus();

}

function openPopupAddModifyScarico(idCarico, idScarico){
	var idTipologiaRegistro = document.getElementById("idTipologiaRegistro").value;
	var windowInsert = window.open('GestioneRegistroCaricoScarico.do?command=AddModifyScarico&idCarico='+idCarico+'&idScarico='+idScarico+'&idTipologiaRegistro='+idTipologiaRegistro,'popupRegistroCSS'+idCarico,
         'height=600px,width=500px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	
	windowInsert.focus();

}

function openDeleteCarico(idCarico){
	var idTipologiaRegistro = document.getElementById("idTipologiaRegistro").value;
	if (confirm("Attenzione. Il record selezionato sara' cancellato. Proseguire?")){
		loadModalWindow();
		window.location.href='GestioneRegistroCaricoScarico.do?command=DeleteCarico&idCarico='+idCarico+'&idTipologiaRegistro='+idTipologiaRegistro;
	}
}
function openDeleteScarico(idScarico){
	var idTipologiaRegistro = document.getElementById("idTipologiaRegistro").value;
	if (confirm("Attenzione. Il record selezionato sara' cancellato. Proseguire?")){
		loadModalWindow();
		window.location.href='GestioneRegistroCaricoScarico.do?command=DeleteScarico&idScarico='+idScarico+'&idTipologiaRegistro='+idTipologiaRegistro;
	}
}

function openPopupGiacenza(idRegistro){
	var idTipologiaRegistro = document.getElementById("idTipologiaRegistro").value;
	var windowGiacenza = window.open('GestioneRegistroCaricoScarico.do?command=Giacenza&idRegistro='+idRegistro+'&idTipologiaRegistro='+idTipologiaRegistro,'popupGiacenzaCS'+idRegistro, 
         'height=500px,width=800px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	
	windowGiacenza.focus();

}

function openPopupExcelRegistro(idRegistro){
	
	var dataInizio = document.getElementById("dataInizio").value;
	var dataFine = document.getElementById("dataFine").value;
	
	if (dataInizio > dataFine){
		alert("Data Inizio non puo' essere superiore a Data Fine.")
		return false;
	}
	
	  var link = 'GenerazioneExcel.do?command=GetExcel&idRegistro='+idRegistro+'&dataInizio='+dataInizio+'&dataFine='+dataFine+'&tipo_richiesta=registro_recapiti'; 
	  var result = window.open(link,'popupSelectExcel',
		'height=400px,width=400px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	  var text = document.createTextNode('GENERAZIONE EXCEL IN CORSO.');
		span = document.createElement('span');
		span.style.fontSize = "30px";
		span.style.fontWeight = "bold";
		span.style.color ="#ff0000";
		span.appendChild(text);
		var br = document.createElement("br");
		var text2 = document.createTextNode('Attendere la generazione del documento entro qualche secondo...');
		span2 = document.createElement('span');
		span2.style.fontSize = "20px";
		span2.style.fontStyle = "italic";
		span2.style.color ="#000000";
		span2.appendChild(text2);
		result.document.body.appendChild(span);
		result.document.body.appendChild(br);
		result.document.body.appendChild(span2);
		result.focus(); 
}	
</script>


<%-- Trails --%>
	<table class="trails" cellspacing="0">
	<tr>
	<td>
	<a href="GestioneAnagraficaAction.do?command=Details&stabId=<%=riferimentoId%>"><%=RagioneSociale %> (<%=NumRegistrazioneStab %>)</a> > 
	<a href="GestioneRegistroCaricoScarico.do?command=Scelta&riferimentoId=<%=riferimentoId %>&riferimentoIdNomeTab=<%=riferimentoIdNomeTab %>">REGISTRO CARICO/SCARICO</a> > 
	RECAPITI
	</td>
	</tr>
	</table>
<%-- Trails --%>

<table class="detailsRecapito" cellpadding="10" cellspacing="10" width="100%">
<tr>
<th>REGISTRO CARICO/SCARICO RECAPITI</th>
</tr>
</table>

<table  class="tablesorter" id = "tablelistaregistrirecapiti">
  
<thead>
		<tr class="tablesorter-headerRow" role="row">
		
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">NUM REGISTRAZIONE</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">DATA REGISTRAZIONE ENTRATA</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">CODICE MITTENTE</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">CODICE SPECIE</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">CODICE RAZZA</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">NOME CAPO</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">MATRICOLA RIPRODUTTORE MASCHIO</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">MATRICOLA RIPRODUTTORE FEMMINA</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">IDENTIFICAZIONE PARTITA</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="first-name filter-select"><div class="tablesorter-header-inner">TIPO SEME/EMBRIONE</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">DOSI/EMBRIONI ACQUISTATE</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">DOCUMENTO COMMERCIALE ENTRATA</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">DATA REGISTRAZIONE USCITA</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">CODICE DESTINATARIO</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">DOSI/EMBRIONI VENDUTE</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">DOSI/EMBRIONI DISTRUTTE</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">DOCUMENTO COMMERCIALE USCITA</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">INFORMAZIONI</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRO" class="filter-false tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">OPERAZIONI</div></th>
		
		</tr>
	</thead>
	<tbody aria-relevant="all" aria-live="polite">

<% 
ArrayList<CaricoRecapiti> listaCarico = Registro.getListaCarico();

for (int i = 0; i< listaCarico.size(); i++){
	CaricoRecapiti c = (CaricoRecapiti) listaCarico.get(i); %>

<tr>
<td><%=toHtml(c.getNumRegistrazione()) %> <br/> <b>CARICO</b></td>
<td><%=toDateasStringFromString(c.getDataRegistrazioneEntrata()) %></td>
<td><%=toHtml(c.getCodiceMittente()) %></td>
<td><%=c.getIdSpecie() > 0 ? TipiSpecie.getSelectedValue(c.getIdSpecie()) : "" %></td>
<td><%=c.getIdRazza() > 0 ? (c.getIdSpecie()==1 ? TipiRazzaBovini.getSelectedValue(c.getIdRazza()) : c.getIdSpecie()==2 ? TipiRazzaSuini.getSelectedValue(c.getIdRazza()) : c.getIdSpecie()==3 ? TipiRazzaEquini.getSelectedValue(c.getIdRazza())  : c.getIdSpecie()==4 ? TipiRazzaAsini.getSelectedValue(c.getIdRazza()) : "") : "" %></td>
<td><%=toHtml(c.getNomeCapo()) %></td>
<td><%=toHtml(c.getMatricolaRiproduttoreMaschio()) %></td>
<td><%=toHtml(c.getMatricolaRiproduttoreFemmina()) %></td>
<td><%=toHtml(c.getIdentificazionePartita()) %></td>
<td><%=c.getIdTipoSeme() > 0 ? TipiSeme.getSelectedValue(c.getIdTipoSeme()) : "" %></td>
<td><%=c.getDosiAcquistate() %></td>
<td><%=toHtml(c.getDocumentoCommercialeEntrata()) %></td>

<td></td>
<td></td>
<td></td>
<td></td>
<td></td>

<td>
Inserito: <br/><b><dhv:username id="<%= c.getEnteredBy() %>"></dhv:username></b> <br/><%=toDateasStringWitTime(c.getEntered())  %>
<% if (c.getTrashedDate()!=null) { %><br/>Cancellato: <br/><b><dhv:username id="<%= c.getTrashedBy() %>"></dhv:username></b> <br/><%=toDateasStringWitTime(c.getTrashedDate())  %> <% } %>
</td>

<td>

<% if (c.getListaScarico().size() == 0 && c.getTrashedDate() == null){ %>
	<dhv:permission name="registro_carico_scarico_recapiti-edit">
	<input type="button" style="width:200px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" value="MODIFICA" onClick="openPopupAddModifyCarico('<%=c.getIdRegistro() %>', '<%=Registro.getNumRegistrazioneStab() %>', '<%=c.getId()%>'); return false;"/>
	</dhv:permission>
	
	<dhv:permission name="registro_carico_scarico_recapiti-delete">
	<input type="button"  style="background-color:red; width:200px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" value="ELIMINA" onClick="openDeleteCarico('<%=c.getId()%>'); return false;"/>
	</dhv:permission>
	
	<br/><br/>
<%} %>	

<% if (c.getTrashedDate() == null){ %>

<dhv:permission name="registro_carico_scarico_recapiti-add">
<input type="button" style="width:200px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" value="INSERISCI SCARICO" onClick="openPopupAddModifyScarico('<%=c.getId()%>', '-1'); return false;"/>
</dhv:permission>

<% } %>

</td>

</tr>

<% ArrayList<ScaricoRecapiti> listaScarico = c.getListaScarico();
for (int j = 0; j< listaScarico.size(); j++){
	ScaricoRecapiti s = (ScaricoRecapiti) listaScarico.get(j); %>

<tr>
<td><%=toHtml(s.getNumRegistrazione()) %> <br/> <i>scarico</i></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>

<td><%=toDateasStringFromString(s.getDataRegistrazioneUscita()) %></td>
<td><%=toHtml(s.getCodiceDestinatario()) %></td>
<td><%=s.getDosiVendute() %></td>
<td><%=s.getDosiDistrutte() %></td>
<td><%=toHtml(s.getDocumentoCommercialeUscita()) %></td>

<td>
Inserito: <br/><b><dhv:username id="<%= s.getEnteredBy() %>"></dhv:username></b> <br/><%=toDateasStringWitTime(s.getEntered())  %>
<% if (s.getTrashedDate()!=null) { %> <br/>Cancellato: <br/><b><dhv:username id="<%= s.getTrashedBy() %>"></dhv:username></b> <br/><%=toDateasStringWitTime(s.getTrashedDate())  %> <% } %>
</td>

<td>

<% if (s.getTrashedDate() == null){ %>

	<dhv:permission name="registro_carico_scarico_recapiti-edit">
	<input type="button" style="width:200px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" value="MODIFICA" onClick="openPopupAddModifyScarico('<%=c.getId() %>', '<%=s.getId()%>'); return false;"/>
	</dhv:permission>
	
	<dhv:permission name="registro_carico_scarico_recapiti-delete">
	<input type="button"  style="background-color:red; width:200px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" value="ELIMINA" onClick="openDeleteScarico('<%=s.getId()%>'); return false;"/>
	</dhv:permission>
	
<% } %>	
	

</td>

</tr>

<% } } %>
 
</tbody>
	
	</table>

<br/>

<center>
<dhv:permission name="registro_carico_scarico_recapiti-add">
<input type="button" style="width:250px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" value="INSERISCI CARICO" onClick="openPopupAddModifyCarico('<%=Registro.getId()%>', '<%=NumRegistrazioneStab%>', '-1'); return false;"/>
</dhv:permission>
</center>

<% if (Registro.getId() > 0) { %>
<br/><br/><br/>

<center> 
<input type="button" style="width:250px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" value="VISUALIZZA GIACENZA" onClick="openPopupGiacenza('<%=Registro.getId()%>'); return false;"/>
</center>

<br/>
<div id="filtriExcel" style="border: 1px solid black" align="center"><br/>
<font size="2px"> 

<script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script>  
<b>Data Inizio <input type="date" id="dataInizio" name="dataInizio" value="" style="font-size:15px"/> <b>Data Fine</b> <input type="date" id="dataFine" name="dataFine" value="" style="font-size:15px"/>
<br/><br/>
<img src="gestione_documenti/images/xls_icon.png" border="0" align="absmiddle" height="30" width="30"/>
<input type="button" style="width:250px; height: 50px; font-size: 20px; word-wrap: break-word; display: inline-block;" value="ESPORTA IN EXCEL" onClick="openPopupExcelRegistro('<%=Registro.getId()%>'); return false;"/>
<br/>
<font color="red"><i>Attenzione. Saranno esportati i record di carico e scarico con Data Registrazione Entrata e Data Registrazione Uscita rientranti nell'intervallo selezionato.</i></font>     

</font>  
</div>
<% } %> 
       
<input type="hidden" id="idTipologiaRegistro" name="idTipologiaRegistro" value="<%=RegistroRecapiti.ID_TIPOLOGIA%>"/>
       
       