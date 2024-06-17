<script>
function apriPerContoDiAutoritaCompetenti()
{
	$('#dialogPerContoDiAutoritaCompetenti' ).dialog('open');
}		
</script>


<a href="#" onclick="apriPerContoDiAutoritaCompetenti(); return false;"><font  color="#006699" style="font-weight: bold;">Seleziona per conto di</font></a>

<%@page import="org.aspcfs.modules.oia.base.OiaNodo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.aspcf.modules.controlliufficiali.base.Piano"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.aspcfs.modules.vigilanza.base.Ticket"%>
<link rel="stylesheet" type="text/css" href="javascript/jquerypluginTableSorter/css/theme.css"></link>
<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.js"></script>
<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.pager.js"></script>
<script type="text/javascript" src="javascript/jquerypluginTableSorter/jquery.tablesorter.widgets.js"></script>
<script type="text/javascript" src="javascript/jquerypluginTableSorter/tableJqueryFilterDialogCu.js"></script>

<script>

function settaPerContoDi(cb)
{
	
	var idPerContoDi = cb.value;
	var aslPerContoDi = cb.dataset.asl;
	var tipologiaPerContoDi = cb.dataset.tipologia;
	var descrizionePerContoDi = cb.dataset.descrizione_struttura;
	var nomePerContoDi = cb.dataset.struttura;
		
	if (cb.checked){

		if (document.getElementById("perContoDiId"+idPerContoDi)===undefined || document.getElementById("perContoDiId"+idPerContoDi)===null)
			creaPerContoDi(idPerContoDi, nomePerContoDi, descrizionePerContoDi, aslPerContoDi, tipologiaPerContoDi);
		else 
			cancellaPerContoDi(idPerContoDi);
		
	} else {
	
		if (document.getElementById("perContoDiId"+idPerContoDi)===undefined || document.getElementById("perContoDiId"+idPerContoDi)===null) {
			//non faccio nulla
		}
		else 
			cancellaPerContoDi(idPerContoDi);
				
	}
	
}

function creaPerContoDi(idPerContoDi, nomePerContoDi, descrizionePerContoDi, aslPerContoDi, tipologiaPerContoDi) {
	
	var div = document.getElementById("divPerContoDi");

	const newElement = document.createElement("input");
	newElement.setAttribute("type", "hidden");
	newElement.name = "perContoDiId";
	newElement.id = "perContoDiId"+idPerContoDi;
	newElement.value = idPerContoDi;
	div.appendChild(newElement);
	
	const newLabel = document.createElement("label");
	newLabel.name = "perContoDiNome"+idPerContoDi;
	newLabel.id = "perContoDiNome"+idPerContoDi;
	newLabel.innerHTML = "<b>" + aslPerContoDi +"</b> -> "+ tipologiaPerContoDi + " -> " + descrizionePerContoDi + " -> " + nomePerContoDi+" ";
	div.appendChild(newLabel);
	
	const newButton = document.createElement("input");
	newButton.setAttribute("type", "button");
	newButton.name = "perContoDiButton"+idPerContoDi;
	newButton.id = "perContoDiButton"+idPerContoDi;
	newButton.value = " X ";
	newButton.onclick = function(){cancellaPerContoDi(idPerContoDi);return false;};
	div.appendChild(newButton);
	
	const newBr = document.createElement("label");
	newBr.name = "perContoDiBr"+idPerContoDi;
	newBr.id = "perContoDiBr"+idPerContoDi;
	newBr.innerHTML = '<br/>';
	div.appendChild(newBr);
	
}

function cancellaPerContoDi(idPerContoDi) {
	
	document.getElementById("perContoDiId"+idPerContoDi).remove();
	document.getElementById("perContoDiNome"+idPerContoDi).remove();
	document.getElementById("perContoDiButton"+idPerContoDi).remove();
	document.getElementById("perContoDiBr"+idPerContoDi).remove();
	document.getElementById("perContoDi_"+idPerContoDi).checked=false;
	
}

$(function () {
	 
	
	 $( "#dialogPerContoDiAutoritaCompetenti" ).dialog({
	    	autoOpen: false,
	        resizable: false,
	        closeOnEscape: false,
	       	title:"LISTA PER CONTO DI",
	        width:850,
	        height:500,
	        draggable: false,
	        modal: true,
	        buttons:{
// 	        	 "FATTO": function() {settaPerContoDi();$(this).dialog("close");} ,
// 	        	 "ESCI" : function() { $(this).dialog("close");}
				 "CONFERMA ED ESCI" : function() { $(this).dialog("close");}		
	        	
	        },
	        show: {
	            effect: "blind",
	            duration: 1000
	        },
	        hide: {
	            effect: "explode",
	            duration: 1000
	        }
	       
	    }).prev(".ui-dialog-titlebar").css("background","#bdcfff");
	 
  
});         
</script>

	<div id ="dialogPerContoDiAutoritaCompetenti">
		<%
		ArrayList<OiaNodo> listaPerContoDiAc = (ArrayList<OiaNodo>)request.getAttribute("ListaPerContoDiAC");
		%>		
	

<font color="red">Attenzione! Di seguito sono riportate tutte le strutture presenti nello strumento di calcolo per cui è stato eseguito il "Salva e Chiudi".<br>
Qualora non fossero presenti le strutture desiderate, controllare che figurino correttamente nello strumento di calcolo e che quest'ultimo sia stato Salvato/Chiuso.
</font>
<br>

<table  class="tablesorter" id="tablelistastruttureMulti">

	<thead>
		<tr class="tablesorter-headerRow" role="row">
		<th aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="ASL" class="first-name filter-select"><div class="tablesorter-header-inner">ASL</div></th>
		<th aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="TIPO STRUTTURA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">TIPOLOGIA STRUTTURA</div></th>
		<th aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="DESCRIZIONE" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">DESCRIZIONE STRUTTURA</div></th>
		<th aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="STRUTTURA APPARTENENZA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">STRUTTURA DI APPARTENENZA</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRO" class="filter-false tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner"></div></th>
					
		</tr>
	</thead>
	<tbody aria-relevant="all" aria-live="polite">
	
	<%
	
	if (listaPerContoDiAc!=null)
	for (OiaNodo nodoAsl : listaPerContoDiAc)
	{
		boolean checked= false ;
		checked = TicketDetails.getListaStruttureControllareAutoritaCompetenti().containsKey(nodoAsl.getId());
			
				%>
				
				<tr>
				<td><%= toHtml2(AslList.getSelectedValue( nodoAsl.getId_asl()))%></td>
				<td><%= toHtml2(nodoAsl.getDescrizione_tipologia_struttura())%></td>
				<td><%=nodoAsl.getDescrizione_lunga() %></td>
				<td><%=nodoAsl.getDescrizionePadre() %></td>
				<td><input type="checkbox" data-asl = "<%= toHtml2(AslList.getSelectedValue( nodoAsl.getId_asl()))%>" data-tipologia = "<%= toHtml2(nodoAsl.getDescrizione_tipologia_struttura())%>" data-descrizione_struttura = "<%=nodoAsl.getDescrizione_lunga() %>" data-struttura = "<%=nodoAsl.getDescrizionePadre() %>" name = "perContoDi_" id = "perContoDi_<%=nodoAsl.getId() %>" value="<%=nodoAsl.getId()%>" onClick="settaPerContoDi(this)"></td>
				</tr>
				
				<%
			
			
			
	
	}
	%>
	
</tbody>
</table>
	
</div>
		
				
<div id="divPerContoDi">
</div>
	


<% 
if (request.getAttribute("TicketDetails")!=null) { 
	
for(OiaNodo percontodi : TicketDetails.getLista_unita_operative() ){
%>
	 <script>
	   document.getElementById("perContoDi_<%=percontodi.getId() %>").checked = true;
	   settaPerContoDi(document.getElementById("perContoDi_<%=percontodi.getId() %>"));
	</script>	   
<%    }    %>	
<% } %>	
	