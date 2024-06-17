<%ArrayList<org.aspcfs.modules.gestionecu.base.Qualifica> listaQualificheAc = (ArrayList<org.aspcfs.modules.gestionecu.base.Qualifica>)request.getAttribute("ListaQualificheAC");%>	

<select id="qualifica" name="qualifica">
<option value="-1">--- SELEZIONA ---</option>
<% 
boolean wasGruppo = false;
for (int i = 0; i<listaQualificheAc.size(); i++)  {
	org.aspcfs.modules.gestionecu.base.Qualifica q = (org.aspcfs.modules.gestionecu.base.Qualifica) listaQualificheAc.get(i);%>
	
	<% if (wasGruppo) {%>
	</optgroup>
	<% } %>
	
	<% if (q.isGruppo()) {%>
	 <optgroup label="<%=q.getNome()%>">
	<% } %>
	
	<% if (!q.isGruppo()) {%>
	<option value="<%=q.getId()%>"><%=q.getNome() %></option>
	<% } %>
	
	<% if (i == listaQualificheAc.size()-1) { %>
	</optgroup>
	<% } %>
	
<% } %>
</select>


<script>
function apriComponenti(){
	
	if(document.getElementById("qualifica").value == -1){
		alert("Selezionare un ruolo prima di procedere.");
		return;
	}
	
	var idQualifica = document.getElementById("qualifica").value;
	var idAsl = document.getElementById("siteId").value;
	
	$('#dialogNucleoIspettivoAutoritaCompetenti' ).dialog('open');
	
	link = "NucleoIspettivo.do?command=ListAutoritaCompetenti&idAsl="+idAsl+"&idQualifica="+idQualifica;
	$.ajax({
        url: link,
        //force to handle it as text
        dataType: "text",
        success: function(data) {
        entrato= false ;
        //data downloaded so we call parseJSON function 
        //and pass downloaded data
        var json = $.parseJSON(data);
        if (json.length>1 || (json.length==1 && json[0].id>0))
            	{
            $.each(json, function(i, item) {
            	 
            	 if(item.id>0 )
            		 {
            		 var checked = '';
            		 
            			if (!(document.getElementById("qualificaStrutturaComponenteId"+item.idQualifica+"_"+item.idStruttura+"_"+item.id)===undefined || document.getElementById("qualificaStrutturaComponenteId"+item.idQualifica+"_"+item.idStruttura+"_"+item.id)===null))
            				 checked = 'checked';
            		 
            		 var tdStruttura = "<td>"+item.nomeStruttura+"</td>";
            		 var tdNominativo = "<td>"+item.nominativo+"</td>";
            		 var tdCheckbox = "<td>" +"<input type=\"checkbox\" name=\"componenteNucleoId\" id =\"componenteNucleoId"+item.idQualifica+"_"+item.idStruttura+"_"+item.id+"\" value = \""+item.idQualifica+"_"+item.idStruttura+"_"+item.id+ "\" data-nominativo = \""+ item.nominativo + "\" data-struttura = \""+ item.nomeStruttura +"\" data-id_struttura = \""+item.idStruttura+ "\" data-id_componente = \""+item.id+ "\" data-id_qualifica = \"" + item.idQualifica + "\" data-qualifica = \"" + item.nomeQualifica + "\" " + checked + " onClick=\"settaComponente(this)\"/></td>";
            		 
            		 var newTr ="<tr style=\"display: table-row;\" class=\"odd\" role=\"row\">" + tdStruttura + tdNominativo + tdCheckbox+"</tr>";
            		
            		 $( "#tablelistanucleo" ).find("tbody").append(newTr);
            		 //
            		 
            		 }
            	 
            });
            	}
            else
            	{
            	
            	 var newTr ='<tr style="display: table-row;" class="odd" role="row"><td colspan="3">Attenzione non esiste nessun utente associato nel Dpat</tr>';
           	 $( "#tablelistanucleo" ).find("tbody").append(newTr).trigger('update');
            	
            	}
            
            $( "#tablelistanucleo" ).find("tbody").trigger('update');
            
          
            

        },
        async :true
    
    });
	
	
}
</script>

<a href="#" onclick="apriComponenti(); return false;"><font  color="#006699" style="font-weight: bold;">Seleziona Componente</font></a>

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
function settaComponente(cb){
	
	var idQualificaStrutturaComponente = cb.value;
	
	var idComponente = cb.dataset.id_componente;
	var nomeComponente = cb.dataset.nominativo;
	
	var idStruttura = cb.dataset.id_struttura;
	var nomeStruttura = cb.dataset.struttura;
	
	var idQualifica = cb.dataset.id_qualifica;
	var nomeQualifica = cb.dataset.qualifica;
	
	if (cb.checked){
		
		var esiste = false;
		var idComponenti = document.getElementsByName("componenteId");
		for (var i=0; i<idComponenti.length; i++)
			if (idComponenti[i].value == idComponente)
				esiste = true;
		
		if (esiste){
			alert("Attenzione. Il nominativo indicato risulta gia' selezionato presso un'altra struttura.");
			cb.checked = false;
			return false;
		}
			
		if (document.getElementById("qualificaStrutturaComponenteId"+idQualificaStrutturaComponente)===undefined || document.getElementById("qualificaStrutturaComponenteId"+idQualificaStrutturaComponente)===null)
			creaComponente(idQualificaStrutturaComponente, idQualifica, nomeQualifica,  idStruttura, nomeStruttura, idComponente, nomeComponente);
		else 
			cancellaComponente(idQualificaStrutturaComponente);
		
	} else {
	
		if (document.getElementById("qualificaStrutturaComponenteId"+idQualificaStrutturaComponente)===undefined || document.getElementById("qualificaStrutturaComponenteId"+idQualificaStrutturaComponente)===null){
			//non faccio nulla
		}
		else 
			cancellaComponente(idQualificaStrutturaComponente);
				
	}
	

}

function creaComponente(idQualificaStrutturaComponente, idQualifica, nomeQualifica, idStruttura, nomeStruttura, idComponente, nomeComponente) {
	
	var div = document.getElementById("divComponenti");

	const newElement = document.createElement("input");
	newElement.setAttribute("type", "hidden");
	newElement.name = "qualificaStrutturaComponenteId";
	newElement.id = "qualificaStrutturaComponenteId"+idQualificaStrutturaComponente;
	newElement.value = idQualificaStrutturaComponente;
	div.appendChild(newElement);
	
	const newElement4 = document.createElement("input");
	newElement4.setAttribute("type", "hidden");
	newElement4.name = "componenteStrutturaId";
	newElement4.id = "componenteStrutturaId"+idQualificaStrutturaComponente;
	newElement4.value = idQualifica;
	div.appendChild(newElement4);
	
	const newLabel4 = document.createElement("label");
	newLabel4.name = "componenteStrutturaNome"+idQualificaStrutturaComponente;
	newLabel4.id = "componenteStrutturaNome"+idQualificaStrutturaComponente;
	newLabel4.innerHTML = '<i>'+nomeStruttura+'</i> ';
	div.appendChild(newLabel4);
	
	const newElement2 = document.createElement("input");
	newElement2.setAttribute("type", "hidden");
	newElement2.name = "componenteId";
	newElement2.id = "componenteId"+idQualificaStrutturaComponente;
	newElement2.value = idComponente;
	div.appendChild(newElement2);
	
	const newLabel2 = document.createElement("label");
	newLabel2.name = "componenteNome"+idQualificaStrutturaComponente;
	newLabel2.id = "componenteNome"+idQualificaStrutturaComponente;
	newLabel2.innerHTML = '<b>' + nomeComponente + '</b> ';
	div.appendChild(newLabel2);
	
	const newElement3 = document.createElement("input");
	newElement3.setAttribute("type", "hidden");
	newElement3.name = "componenteQualificaId";
	newElement3.id = "componenteQualificaId"+idQualificaStrutturaComponente;
	newElement3.value = idQualifica;
	div.appendChild(newElement3);
	
	const newLabel3 = document.createElement("label");
	newLabel3.name = "componenteQualificaNome"+idQualificaStrutturaComponente;
	newLabel3.id = "componenteQualificaNome"+idQualificaStrutturaComponente;
	newLabel3.innerHTML = ' ('+nomeQualifica+') ';
	div.appendChild(newLabel3);
	
	const newButton = document.createElement("input");
	newButton.setAttribute("type", "button");
	newButton.name = "componenteButton"+idQualificaStrutturaComponente;
	newButton.id = "componenteButton"+idQualificaStrutturaComponente;
	newButton.value = " X ";
	newButton.onclick = function(){cancellaComponente(idQualificaStrutturaComponente);return false;};
	div.appendChild(newButton);
	
	const newBr = document.createElement("label");
	newBr.name = "componenteBr"+idQualificaStrutturaComponente;
	newBr.id = "componenteBr"+idQualificaStrutturaComponente;
	newBr.innerHTML = '<br/>';
	div.appendChild(newBr);
	
}

function cancellaComponente(idQualificaStrutturaComponente) {
	
	document.getElementById("qualificaStrutturaComponenteId"+idQualificaStrutturaComponente).remove();
	document.getElementById("componenteId"+idQualificaStrutturaComponente).remove();
	document.getElementById("componenteNome"+idQualificaStrutturaComponente).remove();
	document.getElementById("componenteQualificaId"+idQualificaStrutturaComponente).remove();
	document.getElementById("componenteQualificaNome"+idQualificaStrutturaComponente).remove();
	document.getElementById("componenteStrutturaId"+idQualificaStrutturaComponente).remove();
	document.getElementById("componenteStrutturaNome"+idQualificaStrutturaComponente).remove();
	document.getElementById("componenteButton"+idQualificaStrutturaComponente).remove();
	document.getElementById("componenteBr"+idQualificaStrutturaComponente).remove();
	
}

function svuotaTabella () {
	var table = document.getElementById("tablelistanucleo");
	for(var i = 2;i<table.rows.length;){
        table.deleteRow(i);
    }
}

$(function () {

	
	 $( "#dialogNucleoIspettivoAutoritaCompetenti" ).dialog({
	    	autoOpen: false,
	        resizable: false,
	        closeOnEscape: false,
	       	title:"LISTA COMPONENTI NUCLEO ISPETTIVO",
	        width:850,
	        height:500,
	        draggable: false,
	        modal: true,
	        buttons:{
// 	        	 "FATTO": function() {settaComponenti(); $( "#tablelistanucleo td").parent().remove(); $(this).dialog("close");} ,
// 	        	 "ESCI" : function() {  $( "#tablelistanucleo td").parent().remove(); $(this).dialog("close");}
	        	"CONFERMA ED ESCI" : function() {  svuotaTabella(); $(this).dialog("close");}
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

	<div id ="dialogNucleoIspettivoAutoritaCompetenti">
		<%
		%>		
	

<font color="red">Attenzione! Di seguito sono riportati tutti i nominativi delle persone afferenti alle strutture presenti nello strumento di calcolo per cui è stato eseguito il "Salva e Chiudi".<br>
Qualora non fossero presenti i nominativi desiderati, controllare che figurino correttamente nello strumento di calcolo e che quest'ultimo sia stato Salvato/Chiuso.
</font>
<br>

<table  class="tablesorter" id="tablelistanucleo">

	<thead>
		<tr class="tablesorter-headerRow" role="row">
		<th aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="STRUTTURA" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">STRUTTURA DI APPARTENENZA</div></th>
		<th aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="NOMINATIVO" class="filter-match tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner">NOMINATIVO</div></th>
		<th data-sorter="false" aria-sort="none" style="-moz-user-select: none;" unselectable="on" aria-controls="table" aria-disabled="false" role="columnheader" scope="col" tabindex="0" data-column="0" data-placeholder="FILTRO" class="filter-false tablesorter-header tablesorter-headerUnSorted"><div class="tablesorter-header-inner"></div></th>
					
		</tr>
	</thead>
	<tbody aria-relevant="all" aria-live="polite">
	
	<%
	
	
	%>
	
</tbody>
</table>
	
</div>
		
<div id="divComponenti">
</div>



<% 
if (request.getAttribute("TicketDetails")!=null) { 

for(org.aspcfs.modules.vigilanza.base.ComponenteNucleoIspettivo componente : TicketDetails.getNucleoIspettivoConStruttura() ){ %>

<script>
creaComponente(
		"<%=componente.getIdQualifica()%>_<%=componente.getIdStruttura()%>_<%=componente.getIdComponente()%>", 
		<%=componente.getIdQualifica()%>, 
		"<%=toHtml(componente.getNomeQualifica())%>",  
		<%=componente.getIdStruttura()%>, 
		"<%=toHtml(componente.getNomeStruttura())%>", 
		<%=componente.getIdComponente()%>, 
		"<%=toHtml(componente.getNomeComponente())%>");			
</script>
	
<% } %>	

<% } %>	
	
	
	