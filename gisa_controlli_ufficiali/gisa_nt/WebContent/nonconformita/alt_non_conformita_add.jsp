<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<jsp:useBean id="View" class="java.lang.String" scope="request"/>
<jsp:useBean id="AcqueDiRete" class="java.lang.String" scope="request"/>

<jsp:useBean id="Macrocategorie" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<jsp:useBean id="listaLineeCU" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="listaOperatoriMercatoCU" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="ProvvedimentiBenessereMacellazione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ProvvedimentiBenessereTrasporto" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<%@page import="org.aspcfs.modules.lineeattivita.base.LineeAttivita"%>

<link href="css/nonconformita.css" rel="stylesheet" type="text/css" />
<!-- FINE CODICE PER POPUP MODALE JQUERY -->
<script>


var unloadEvent = function (e) {
	
	var salvato = document.getElementById('dosubmit');
	if (salvato!=null && salvato.value!="1")
		{
    var confirmationMessage = "Attenzione! ricordarsi di cliccare sul bottone SALVA per evitare di perdere i follow up inseriti.";

    (e || window.event).returnValue = confirmationMessage; //Gecko + IE
    loadModalWindowUnlock();
    return confirmationMessage; //Webkit, Safari, Chrome etc.
		}
};
window.addEventListener("beforeunload", unloadEvent);

function openNotePopupFollowup(altId,idC,dataC,tipo_nc){
	var res;
	var result;
	var tipologiaNc = document.getElementById("Provvedimenti"+tipo_nc+"_1").value;

	
		window.open('FollowupNC.do?command=Add&idC='+idC+'&dataC='+dataC+'&altId='+altId+'&tipoNc='+tipo_nc+'&tipologiaNc='+tipologiaNc,null,
		'height=800px,width=680px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=no ,modal=yes');
		
		
		
		} 
	

function openNotePopupDiffida(altId,idC,dataC,tipo_nc){
	var res;
	var result;

	
		window.open('DiffidaNC.do?command=Add&idC='+idC+'&dataC='+dataC+'&altId='+altId+'&tipoNc='+tipo_nc,null,
		'height=800px,width=680px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=no ,modal=yes');
		
		
		
		} 
	
	
	


function openNotePopupSanzione(altId,idC,dataC,tipo_nc){
	var res;
	var result;

	
		window.open('SanzioniNC.do?command=Add&idC='+idC+'&dataC='+dataC+'&altId='+altId+'&tipoNc='+tipo_nc,null,
		'height=800px,width=680px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=no ,modal=yes');
		
		
		} 
		
function openNotePopupSanzioneTerzi(impresa,orgId,idC,dataC,tipo_nc){
	var res;
	var result;

	
		window.open('SanzioniNC.do?command=Add&idC='+idC+'&dataC='+dataC+'&orgId='+orgId+'&orgIdSanzionata='+impresa+'&tipoNc='+tipo_nc,null,
		'height=800px,width=680px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=no ,modal=yes');
		
		
		} 
function openNotePopupSanzioneOperatoreMercato(operatore,altId,idC,dataC,tipo_nc){
	var res;
	var result;

	
		window.open('SanzioniNC.do?command=Add&idC='+idC+'&dataC='+dataC+'&altId='+altId+'&relOperatoreMercato='+operatore+'&tipoNc='+tipo_nc,null,
		'height=800px,width=680px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=no ,modal=yes');
		
		
		} 
		
	


function openNotePopupSequestro(altId,idC,dataC,tipo_nc){
	var res;
	var result;

	
		window.open('SequestriNC.do?command=Add&idC='+idC+'&dataC='+dataC+'&altId='+altId+'&tipoNc='+tipo_nc,null,
		'height=800px,width=680px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=no ,modal=yes');
		
		
		
		} 

function openNotePopupReato(altId,idC,dataC,tipo_nc){
	var res;
	var result;

	
		window.open('ReatiNC.do?command=Add&idC='+idC+'&dataC='+dataC+'&altId='+altId+'&tipoNc='+tipo_nc,null,
		'height=800px,width=680px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=no ,modal=yes');
		
		
		
	
}
</script>


<input type="hidden" name="tipoControlloUfficiale" id="tipoControlloUfficiale"" value="<%=CU.getTipoCampione()%>">
<input type="hidden" name="dataInizioControlloUfficiale" id="dataInizioControlloUfficiale" value="<%=CU.getAssignedDate()%>">

<div class="tabber">
<%
	if ( (View!=null && View.equals("AutoritaNonCompetenti") ) || (AcqueDiRete!=null && AcqueDiRete.equals("AcqueDiRete") )) {
%>
 <div style="display: none">
<%
	}
%>
<div class="tabbertab1"> 
<!-- cambiato nome perche' per qualche motivo cambiando classe si nasconde come ci aspettavamo flusso 304 -->
 <%@ include file="alt_non_conformita_formali.jsp" %>

</div>
<div class="tabbertab">
 <%@ include file="alt_non_conformita_significative.jsp" %>

</div>
<%
	if ( (View!=null && View.equals("AutoritaNonCompetenti") ) || (AcqueDiRete!=null && AcqueDiRete.equals("AcqueDiRete") )) {
%>
 </div>
<%
	}
%>

 <div class="tabbertab">
 <%@ include file="alt_non_conformita_gravi.jsp" %>

 </div>
 </div>



<input type = "hidden" id ="abilita_formali" name = "abilitanc_formali" value = "false">
<input type = "hidden" id = "abilita_significative" name = "abilitanc_significative"  value = "false">
<input type = "hidden" id = "abilita_gravi" name = "abilitanc_gravi"  value = "false">
<input type = "hidden" id ="formali" name = "formali" value = "">
<input type = "hidden" name = "idIspezione" value = "<%=CU.getTipoIspezione() %>">




<script>
resetElementi(0,0,0,1,1,1);
</script>





