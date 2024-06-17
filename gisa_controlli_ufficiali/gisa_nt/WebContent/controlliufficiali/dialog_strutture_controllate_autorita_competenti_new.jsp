<script>
function apriStruttureAutoritaCompetenti()
{
	$('#dialogStruttureControllateAutoritaCompetenti' ).dialog('open');
}
</script>


<a href="#" onclick="apriStruttureAutoritaCompetenti(); return false;"><font  color="#006699" style="font-weight: bold;">Seleziona le strutture controllate</font></a>


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

function settaStruttura(cb)
{
	
	var idStruttura = cb.value;
	var aslStruttura = cb.dataset.asl;
	var tipologiaStruttura = cb.dataset.tipologia;
	var descrizioneStruttura = cb.dataset.descrizione_struttura;
	var nomeStruttura = cb.dataset.struttura;
		
	if (cb.checked){

		if (document.getElementById("strutturaId"+idStruttura)===undefined || document.getElementById("strutturaId"+idStruttura)===null)
			creaStruttura(idStruttura, nomeStruttura, descrizioneStruttura, aslStruttura, tipologiaStruttura);
		else 
			cancellaStruttura(idStruttura);
		
	} else {
	
		if (document.getElementById("strutturaId"+idStruttura)===undefined || document.getElementById("strutturaId"+idStruttura)===null) {
			//non faccio nulla
		}
		else 
			cancellaStruttura(idStruttura);
				
	}
	
}

function creaStruttura(idStruttura, nomeStruttura, descrizioneStruttura, aslStruttura, tipologiaStruttura) {
	
	var div = document.getElementById("divStrutture");

	const newElement = document.createElement("input");
	newElement.setAttribute("type", "hidden");
	newElement.name = "strutturaId";
	newElement.id = "strutturaId"+idStruttura;
	newElement.value = idStruttura;
	div.appendChild(newElement);
	
	const newLabel = document.createElement("label");
	newLabel.name = "strutturaNome"+idStruttura;
	newLabel.id = "strutturaNome"+idStruttura;
	newLabel.innerHTML = "<b>" + aslStruttura +"</b> -> "+ tipologiaStruttura + " -> " + descrizioneStruttura + " -> " + nomeStruttura+" ";
	div.appendChild(newLabel);
	
	const newButton = document.createElement("input");
	newButton.setAttribute("type", "button");
	newButton.name = "strutturaButton"+idStruttura;
	newButton.id = "strutturaButton"+idStruttura;
	newButton.value = " X ";
	newButton.onclick = function(){cancellaStruttura(idStruttura);return false;};
	div.appendChild(newButton);
	
	const newBr = document.createElement("label");
	newBr.name = "strutturaBr"+idStruttura;
	newBr.id = "strutturaBr"+idStruttura;
	newBr.innerHTML = '<br/>';
	div.appendChild(newBr);
	
}

function cancellaStruttura(idStruttura) {
	
	document.getElementById("strutturaId"+idStruttura).remove();
	document.getElementById("strutturaNome"+idStruttura).remove();
	document.getElementById("strutturaButton"+idStruttura).remove();
	document.getElementById("strutturaBr"+idStruttura).remove();
	document.getElementById("strutturaControllata_"+idStruttura).checked=false;
	
}

$(function () {
	 
	
	
	 $( "#dialogStruttureControllateAutoritaCompetenti" ).dialog({
	    	autoOpen: false,
	        resizable: false,
	        closeOnEscape: false,
	       	title:"LISTA STRUTTURE SOTTOPOSTE A CONTROLLO",
	        width:850,
	        height:500,
	        draggable: false,
	        modal: true,
	        buttons:{
// 	        	 "FATTO": function() {settaStruttura();$(this).dialog("close");} ,
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

	<div id ="dialogStruttureControllateAutoritaCompetenti">
		<%
		ArrayList<OiaNodo> listaStruttureControllateAc = (ArrayList<OiaNodo>)request.getAttribute("ListaStruttureAC");
		%>		

<font color="red">Attenzione! Di seguito sono riportate tutte le strutture presenti nello strumento di calcolo per cui è stato eseguito il "Salva e Chiudi".<br>
Qualora non fossero presenti le strutture desiderate, controllare che figurino correttamente nello strumento di calcolo e che quest'ultimo sia stato Salvato/Chiuso.
</font>
<br>

<table  class="tablesorter" id="tablelistastruttureac">

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
	
	if (listaStruttureControllateAc!=null)
	for (OiaNodo nodoAsl : listaStruttureControllateAc)
	{
		boolean checked= false ;
		checked = TicketDetails.getListaStruttureControllareAutoritaCompetenti().containsKey(nodoAsl.getId());
			
				%>
				
				<tr>
				<td><%= toHtml2(AslList.getSelectedValue( nodoAsl.getId_asl()))%></td>
				<td><%= toHtml2(nodoAsl.getDescrizione_tipologia_struttura())%></td>
				<td><%=nodoAsl.getDescrizione_lunga() %></td>
				<td><%=nodoAsl.getDescrizionePadre() %></td>
				<td><input type="checkbox" data-asl = "<%= toHtml2(AslList.getSelectedValue( nodoAsl.getId_asl()))%>" data-tipologia = "<%= toHtml2(nodoAsl.getDescrizione_tipologia_struttura())%>" data-descrizione_struttura = "<%=nodoAsl.getDescrizione_lunga() %>" data-struttura = "<%=nodoAsl.getDescrizionePadre() %>" name = "strutturaControllata_" id = "strutturaControllata_<%=nodoAsl.getId() %>" value="<%=nodoAsl.getId()%>" onClick="settaStruttura(this)"></td>
				</tr>
				
				<%
			
			
			
	
	}
	%>
	
</tbody>
</table>
	
</div>
		
		
<div id="divStrutture">
</div>
	
	
<% 
if (request.getAttribute("TicketDetails")!=null) { 

HashMap<Integer,OiaNodo > listaStruttureControllate = TicketDetails.getListaStruttureControllareAutoritaCompetenti();
Iterator<Integer> itstrutt = listaStruttureControllate.keySet().iterator();
while (itstrutt.hasNext()) {
 	   OiaNodo struttura = (OiaNodo) listaStruttureControllate.get(itstrutt.next());
%>
	 <script>
	   document.getElementById("strutturaControllata_<%=struttura.getId() %>").checked = true;
	   settaStruttura(document.getElementById("strutturaControllata_<%=struttura.getId() %>"));
	</script>	   
<%    }    %>	
	
	
<% } %>
	
	