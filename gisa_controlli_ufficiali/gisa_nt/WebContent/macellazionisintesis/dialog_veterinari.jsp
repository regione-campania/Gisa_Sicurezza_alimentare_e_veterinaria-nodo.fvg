<script>
function apriComponenti(Vpm){
	
	if(Vpm == 'Vpm'){
		document.getElementById("Vpm").value = Vpm;
	}else{
		document.getElementById("Vpm").value = '';
		Vpm = ''
	}
	
	if(document.getElementById("qualifica" + Vpm).value == -1){
		alert("Selezionare un ruolo prima di procedere.");
		return;
	}
	
	if($("#divComponenti"+ Vpm +" i").length >= 3){
		alert("Limite componenti raggiunto, impossibile aggiungerne degli altri.");
		return;
	}
	var idQualifica = document.getElementById("qualifica" + Vpm).value;
	var idAsl = document.getElementById("siteId").value;
	
	$('#dialogNucleoIspettivoAutoritaCompetenti' ).dialog('open');
	
	link = "NucleoIspettivo.do?command=ListAutoritaCompetenti&idAsl="+idAsl+"&idQualifica="+idQualifica;
	console.log(link);
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
            			if (!(document.getElementById("qualificaStrutturaComponenteId" + Vpm +item.idQualifica+"_"+item.idStruttura+"_"+item.id)===undefined || document.getElementById("qualificaStrutturaComponenteId" + Vpm +item.idQualifica+"_"+item.idStruttura+"_"+item.id)===null))
            				checked = 'checked';
            		 
            		 var tdStruttura = "<td>"+item.nomeStruttura+"</td>";
            		 var tdNominativo = "<td>"+item.nominativo+"</td>";
            		 var tdCheckbox = "<td>" +"<input type=\"checkbox\" name=\"componenteNucleoId" + Vpm + "\" id =\"componenteNucleoId"+ Vpm +item.idQualifica+"_"+item.idStruttura+"_"+item.id+"\" value = \""+item.idQualifica+"_"+item.idStruttura+"_"+item.id+ "\" data-nominativo = \""+ item.nominativo + "\" data-struttura = \""+ item.nomeStruttura +"\" data-id_struttura = \""+item.idStruttura+ "\" data-id_componente = \""+item.id+ "\" data-id_qualifica = \"" + item.idQualifica + "\" data-qualifica = \"" + item.nomeQualifica + "\" " + checked + " onClick=\"settaComponente(this)\"/></td>";
            		 
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
	
	var Vpm = document.getElementById("Vpm").value;
	
	if (cb.checked){
		
		var esiste = false;
		var idComponenti = document.getElementsByName("componenteId" + Vpm);
		for (var i=0; i<idComponenti.length; i++)
			if (idComponenti[i].value == idComponente)
				esiste = true;
		
		if (esiste){
			alert("Attenzione. Il nominativo indicato risulta gia' selezionato presso un'altra struttura.");
			cb.checked = false;
			return false;
		}
			
		if (document.getElementById("qualificaStrutturaComponenteId"+ Vpm +idQualificaStrutturaComponente)===undefined || document.getElementById("qualificaStrutturaComponenteId"+ Vpm +idQualificaStrutturaComponente)===null){
			if($("#divComponenti"+ Vpm +" i").length >= 3){
				alert("Limite componenti raggiunto, impossibile aggiungerne degli altri.");
				cb.checked = false;
				return false;
			}
			creaComponente(idQualificaStrutturaComponente, idQualifica, nomeQualifica,  idStruttura, nomeStruttura, idComponente, nomeComponente);
		}
		else 
			cancellaComponente(idQualificaStrutturaComponente);
		
	} else {
	
		if (document.getElementById("qualificaStrutturaComponenteId"+ Vpm +idQualificaStrutturaComponente)===undefined || document.getElementById("qualificaStrutturaComponenteId"+ Vpm +idQualificaStrutturaComponente)===null){
			//non faccio nulla
		}
		else 
			cancellaComponente(idQualificaStrutturaComponente);
				
	}
	

}

function creaComponente(idQualificaStrutturaComponente, idQualifica, nomeQualifica, idStruttura, nomeStruttura, idComponente, nomeComponente) {
	
	var Vpm = document.getElementById("Vpm").value;
	var div = document.getElementById("divComponenti" + Vpm);

	const newElement = document.createElement("input");
	newElement.setAttribute("type", "hidden");
	newElement.name = "qualificaStrutturaComponenteId" + Vpm;
	newElement.id = "qualificaStrutturaComponenteId" + Vpm +idQualificaStrutturaComponente;
	newElement.value = idQualificaStrutturaComponente;
	div.appendChild(newElement);
	
	const newElement4 = document.createElement("input");
	newElement4.setAttribute("type", "hidden");
	newElement4.name = "componenteStrutturaId" + Vpm;
	newElement4.id = "componenteStrutturaId" + Vpm +idQualificaStrutturaComponente;
	newElement4.value = idQualifica;
	div.appendChild(newElement4);
	
	const newLabel4 = document.createElement("label");
	newLabel4.name = "componenteStrutturaNome" + Vpm +idQualificaStrutturaComponente;
	newLabel4.id = "componenteStrutturaNome" + Vpm +idQualificaStrutturaComponente;
	newLabel4.innerHTML = '<i style="display: none">'+nomeStruttura+'</i> ';
	div.appendChild(newLabel4);
	
	const newElement2 = document.createElement("input");
	newElement2.setAttribute("type", "hidden");
	newElement2.name = "componenteId" + Vpm;
	newElement2.id = "componenteId" + Vpm +idQualificaStrutturaComponente;
	newElement2.value = idComponente;
	div.appendChild(newElement2);
	
	const newLabel2 = document.createElement("label");
	newLabel2.name = "componenteNome" + Vpm +idQualificaStrutturaComponente;
	newLabel2.id = "componenteNome" + Vpm +idQualificaStrutturaComponente;
	newLabel2.innerHTML = '<b>' + nomeComponente + '</b> ';
	div.appendChild(newLabel2);
	
	const newElement5 = document.createElement("input");
	newElement5.setAttribute("type", "hidden");
	newElement5.name = "componenteNominativo" + Vpm +idQualificaStrutturaComponente;
	newElement5.id = "componenteNominativo" + Vpm +idQualificaStrutturaComponente;
	newElement5.value = nomeComponente;
	div.appendChild(newElement5);
	
	const newElement3 = document.createElement("input");
	newElement3.setAttribute("type", "hidden");
	newElement3.name = "componenteQualificaId" + Vpm;
	newElement3.id = "componenteQualificaId" + Vpm +idQualificaStrutturaComponente;
	newElement3.style = "display: none;"
	newElement3.value = idQualifica;
	div.appendChild(newElement3);
	
	const newLabel3 = document.createElement("label");
	newLabel3.name = "componenteQualificaNome" + Vpm +idQualificaStrutturaComponente;
	newLabel3.id = "componenteQualificaNome" + Vpm +idQualificaStrutturaComponente;
	//newLabel3.innerHTML = ' ('+nomeQualifica+') ';
	div.appendChild(newLabel3);
	
	const newButton = document.createElement("input");
	newButton.setAttribute("type", "button");
	newButton.name = "componenteButton" + Vpm +idQualificaStrutturaComponente;
	newButton.id = "componenteButton" + Vpm +idQualificaStrutturaComponente;
	newButton.value = " X ";
	newButton.onclick = function(){cancellaComponente(idQualificaStrutturaComponente);return false;};
	div.appendChild(newButton);
	
	const newBr = document.createElement("label");
	newBr.name = "componenteBr" + Vpm +idQualificaStrutturaComponente;
	newBr.id = "componenteBr" + Vpm +idQualificaStrutturaComponente;
	newBr.innerHTML = '<br/>';
	div.appendChild(newBr);
	
}

function cancellaComponente(idQualificaStrutturaComponente) {
	
	var Vpm = document.getElementById("Vpm").value;
	console.log("qualificaStrutturaComponenteId" + Vpm +idQualificaStrutturaComponente);
	
	document.getElementById("qualificaStrutturaComponenteId" + Vpm +idQualificaStrutturaComponente).remove();
	document.getElementById("componenteId" + Vpm +idQualificaStrutturaComponente).remove();
	document.getElementById("componenteNome" + Vpm +idQualificaStrutturaComponente).remove();
	document.getElementById("componenteQualificaId" + Vpm +idQualificaStrutturaComponente).remove();
	document.getElementById("componenteQualificaNome" + Vpm +idQualificaStrutturaComponente).remove();
	document.getElementById("componenteStrutturaId" + Vpm +idQualificaStrutturaComponente).remove();
	document.getElementById("componenteStrutturaNome" + Vpm +idQualificaStrutturaComponente).remove();
	document.getElementById("componenteButton" + Vpm +idQualificaStrutturaComponente).remove();
	document.getElementById("componenteBr" + Vpm +idQualificaStrutturaComponente).remove();
	
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
	       	title:"LISTA VETERINARI",
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
	
	
	