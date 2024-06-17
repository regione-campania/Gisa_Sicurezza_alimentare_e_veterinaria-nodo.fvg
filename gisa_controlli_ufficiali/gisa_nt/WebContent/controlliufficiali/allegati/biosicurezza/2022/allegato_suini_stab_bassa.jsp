<jsp:useBean id="Allevamento" class="org.aspcf.modules.controlliufficiali.base.Organization" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Ticket" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>
<jsp:useBean id="DomandeList" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="specie" class="java.lang.String" scope="request"/>
<jsp:useBean id="versione" class="java.lang.String" scope="request"/>
<jsp:useBean id="idChkClassyfarmMod" class="java.lang.String" scope="request"/>
<jsp:useBean id="Checklist" class="org.aspcf.modules.checklist_biosicurezza.base.ChecklistIstanza" scope="request"/>
<%@page import="java.util.regex.*"%>

<%@page import="org.aspcf.modules.checklist_biosicurezza.base.*"%>

<link rel="stylesheet" type="text/css" media="screen" documentale_url="" href="controlliufficiali/allegati/biosicurezza/2022/css/screen.css" />
<link rel="stylesheet" type="text/css" media="print" documentale_url="" href="controlliufficiali/allegati/biosicurezza/2022/css/print.css" />

<%@ include file="../../../../utils23/initPage.jsp" %>


<script>

function gestisciNumber(campo) {
	var value = campo.value;
	
	value = value.replace(/[^0-9]/g, '');
	campo.value = value;
	
}

function gestisciCb(cb){
	if (!cb.checked)
		return false; 
	
	var f = document.forms['myform'];
	for(var i=0,fLen=f.length;i<fLen;i++){

		if (f.elements[i].type=='checkbox' && f.elements[i].name == cb.name && f.elements[i].id != cb.id)
	    { 
	          f.elements[i].checked = false;
	    } 
}
	
	var dom_id = cb.dataset.dom_id;
	var dom_ordine = cb.dataset.dom_ordine;
	var dom_classyfarm_id = cb.dataset.dom_classyfarm_id;
	var risposta_classyfarm_id = cb.dataset.risposta_classyfarm_id;
	
	if (dom_classyfarm_id == '4981' && risposta_classyfarm_id == '14529'){ // SE HO RISPOSTO NA ALLA DOMANDA SELEZIONATA
		
		for(var i=0,fLen=f.length;i<fLen;i++){ // SETTO NA A TUTTE LE DOMANDE COLLEGATE COME DA RICHIESTA REFERENTE

			if (f.elements[i].type=='checkbox' && f.elements[i].dataset.dom_classyfarm_id == '4983' && f.elements[i].dataset.risposta_classyfarm_id == '14537')
		    { 
		          f.elements[i].checked = true;
		    } 
			if (f.elements[i].type=='checkbox' && f.elements[i].dataset.dom_classyfarm_id == '4985' && f.elements[i].dataset.risposta_classyfarm_id == '14545')
		    { 
		          f.elements[i].checked = true;
		    } 
			if (f.elements[i].type=='checkbox' && f.elements[i].dataset.dom_classyfarm_id == '4986' && f.elements[i].dataset.risposta_classyfarm_id == '14549')
		    { 
		          f.elements[i].checked = true;
		    } 
			if (f.elements[i].type=='checkbox' && f.elements[i].dataset.dom_classyfarm_id == '4987' && f.elements[i].dataset.risposta_classyfarm_id == '14553')
		    { 
		          f.elements[i].checked = true;
		    } 
			if (f.elements[i].type=='checkbox' && f.elements[i].dataset.dom_classyfarm_id == '4996' && f.elements[i].dataset.risposta_classyfarm_id == '14589')
		    { 
		          f.elements[i].checked = true;
		    } 
			if (f.elements[i].type=='checkbox' && f.elements[i].dataset.dom_classyfarm_id == '4997' && f.elements[i].dataset.risposta_classyfarm_id == '14593')
		    { 
		          f.elements[i].checked = true;
		    } 	
			
		}
	
	}
	
}

function verificaStatoChecklist(isBozza){
	
	if(isBozza == 'false'){
		var f = document.forms['myform'];
		for(var i=0,fLen=f.length;i<fLen;i++){

			if (f.elements[i].type == 'radio' || f.elements[i].type=='checkbox')
		    { 
		          f.elements[i].disabled = true;
		    } 
			else if (f.elements[i].type == 'submit')
		    { 
		          
		    } 
		   else {
			    
		  		f.elements[i].readOnly = true;
		  		f.elements[i].className = 'layout';
		    }
		}
		var g = document.forms['myform'].getElementsByTagName("textarea");
		for(var j=0; j < g.length; j++)
			 g.item(j).className = 'layout';

		document.getElementById('salvaTemporaneo').style.display = 'none';
		document.getElementById('salvaDefinitivo').style.display = 'none';
		document.getElementById('stampa').style.display = 'block';
		window.opener.loadModalWindow();
        //window.opener.location.reload();
        window.opener.location.href="AllevamentiVigilanza.do?command=TicketDetails&id=<%=Ticket.getId()%>";

	}
}

function saveForm(form, tipo){
	
	if (tipo=='temp'){
		if(confirm('La scheda sarà aggiornata come richiesto. Vuoi procedere con il salvataggio?')) {
		 form.bozza.value = "true";
		 loadModalWindow();
		 form.submit();
		}
	}
	else {
		
		//QUI VANNO MESSI TUTTI I CONTROLLI DI CONGRUENZA
		var check = true;
		check = checkForm(form);
		if (!check)
			return false;
		
		if(confirm('La scheda sarà aggiornata come richiesto ma i dati non saranno più modificabili. Vuoi procedere con il salvataggio definitivo?')) {
		 form.bozza.value = "false";
		 loadModalWindow();
		 form.submit();
		}
	}
	
}

function checkForm(form){
	var esito = true;
	var msg = 'Impossibile salvare. Controllare i seguenti campi: \n\n';

	if (!tutteDomandeRisposte()){
			msg+="Rispondere a tutte le domande.\n";
			esito = false;
	}
	
	var f = document.forms['myform'];
	for(var i=0,fLen=f.length;i<fLen;i++){
	if (f.elements[i].dataset.dom_classyfarm_id=='4920' && f.elements[i].value.trim() == ''){ 
		msg+= "Compilare NOME E COGNOME DEL PROPRIETARIO/DETENTORE/CONDUTTORE PRESENTE ALL'ISPEZIONE.\n";
	    esito = false;
	    } 
	if (f.elements[i].dataset.dom_classyfarm_id=='4919' && (f.elements[i].value.trim() == '' /*|| parseInt(f.elements[i].value.trim())> 300*/)){ 
		msg+= "Indicare un valore nel campo NUMERO TOTALE DEGLI ANIMALI.\n";
	    esito = false;
	    }
	}
			
	if (!esito)
		alert(msg);
	return esito;
}


function tutteDomandeRisposte(){
	
	<%for (int i = 0; i<Checklist.getDomande().size(); i++) {
		Domanda domanda = Checklist.getDomande().get(i); %>
	
		var x = document.getElementsByName("dom_<%=domanda.getId()%>_risposta");
		
		var selezionato = false;
		var totSelezionabili = 0;
		
		for (var j = 0; j<x.length; j++){
			if (x[j].type == 'checkbox' || x[j].type == 'radio' ){
				totSelezionabili++;
				if ( x[j].checked)
					selezionato = true;
		}
		}
	
		document.getElementById("tr_<%=domanda.getId()%>").style.background='';
		if (!selezionato && totSelezionabili>1){
			document.getElementById("tr_<%=domanda.getId()%>").style.background='red';
			return false;
		}
		selezionato = false;
		
		<% } %>	
		return true;
	}

</script>

<div class="boxIdDocumento"></div>
<div class="boxOrigineDocumento"><%@ include file="../../../../utils23/hostName.jsp" %></div>


<form method="post" name="myform" action="PrintModulesHTML.do?command=InsertChecklistBiosicurezza&auto-populate=true">

<center>
<div class="header">
<b>VALUTAZIONE DELLA BIOSICUREZZA: SUINI - ALLEVAMENTI STABULATI A BASSA CAPACITA <br/>
CONTROLLO UFFICIALE REV.1_2022</b>
</div>
</center> <br/><br/>

<center>
<table class="dettaglioAzienda" cellpadding="10" cellspacing="10">

<tr>
<td><b>CODICE AZIENDA</b></td> 
<td> <label class="layout"><%=Allevamento.getN_reg()%></label> </td>
</tr>

<tr>
<td><b>ID FISCALE</b></td>
<td><label class="layout"><%=Allevamento.getCf_prop()%></label></td>
</tr>

<tr>
<td><b>INDIRIZZO</b></td> 
<td><label class="layout"><%=Allevamento.getIndirizzo()%></label></td>
</tr>

<tr>
<td><b>CITTA'</b></td> 
<td><label class="layout"><%=Allevamento.getComune()%></label></td> 
</tr>

<tr>
<td><b>ASL DI COMPETENZA</b></td> 
<td><label class="layout"><%=Allevamento.getAsl()%></label></td>
</tr>

<tr>
<td><b>CODICE AREA</b></td> 
<td><label class="layout">___________________</label></td>
</tr>

<tr>
<td>Latitudine</td> 
<td><label class="layout"><%=Allevamento.getLatitudine()%></label></td>
</tr>

<tr>
<td>Longitudine</td> 
<td><label class="layout"><%=Allevamento.getLongitudine()%></label></td>
</tr>

<tr>
<td><b>INDIRIZZO PRODUTTIVO</b><br/>(ciclo chiuso, ciclo aperto, svezzamento, ingrasso, svezzamento + ingrasso)</td> 
<td><label class="layout">______________________</label></td>
</tr>

<tr>
<td><b>TIPOLOGIA DI ALLEVAMENTO</b></td> 
<td>STABULATO</td>
</tr>

<tr>
<td><b>RAZZE-LINEE GENETICHE</b><br/> (Incrocio, Large white, Landrace, Duroc, Danbred, Goland, Hypor, Topigs, PIC, Hermitage, altra)</td> 
<td><label class="layout">______________________</label></td>
</tr>

<tr>
<td><b>DATA</b></td> 
<td><label class="layout">______________________</label></td>
</tr>

<tr>
<td><b>NOME COMPILATORE</b></td> 
<td><label class="layout">______________________</label></td>
</tr>

</table>
</center>    

<div style="page-break-before:always">&nbsp; </div>


<table cellpadding="10" class="domande"> 

<col width="40%"><col width="15%"><col width="15%"><col width="15%"> 

<% 
String sezionePrecedente = "";
for (int i = 0; i<Checklist.getDomande().size(); i++) {
	Domanda domanda = Checklist.getDomande().get(i); %>
	
	<% if (!domanda.getSezione().equals(sezionePrecedente)) {%>
	<tr><th colspan="5"><%=domanda.getSezione() %></th></tr>
	
	<% } %>
	
	<tr id="tr_<%=domanda.getId()%>">
	
	<td> <%=domanda.getDomanda() %> </td>
	
	<% for (int j = 0; j<domanda.getListaRisposte().size(); j++) {
		Risposta risposta = (Risposta) domanda.getListaRisposte().get(j);%>
		<td <%= (j ==  (domanda.getListaRisposte().size() -1)) ? "colspan=\"" + (4 - j) + "\"" : ""%>> 
		<% if (risposta.getTipo().equalsIgnoreCase("checkbox")){ %>
		<input type="checkbox" id="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" name="dom_<%=domanda.getId() %>_risposta" data-dom_id="<%=domanda.getId() %>" data-dom_ordine="<%=domanda.getOrdine() %>" data-dom_classyfarm_id="<%=domanda.getIdClassyfarm() %>" data-risposta_classyfarm_id="<%=risposta.getIdClassyfarm() %>" value="<%=risposta.getId() %>" <%=(risposta.getRisposta()!=null && risposta.isRisposto()) ? "checked=\"checked\"" : "" %> onChange="gestisciCb(this)"/> <%=risposta.getRisposta() %>
		<%} else if (risposta.getTipo().equalsIgnoreCase("textarea")) { %>
<%-- 		<textarea class="editField" cols="20" rows="3" id="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" name="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>"  placeholder="<%=risposta.getRisposta() %>"><%=risposta.getNote() %></textarea> </td> --%>
<!-- 		le textarea non funzionano nello stampa pdf! -->
		<input type="text" class="editField" id="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" name="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" data-dom_id="<%=domanda.getId() %>" data-dom_ordine="<%=domanda.getOrdine() %>" data-dom_classyfarm_id="<%=domanda.getIdClassyfarm() %>" data-risposta_classyfarm_id="<%=risposta.getIdClassyfarm() %>" placeholder="<%=risposta.getRisposta() %>" maxlength="80" <%= risposta.getNote().length() > 30 ? "size=\""+risposta.getNote().length()+"\"" : "size=\"30\"" %> value="<%=risposta.getNote() %>"/> </td>
		<%} else if (risposta.getTipo().equalsIgnoreCase("date")) { %>
		<%=risposta.getRisposta() %>
		<input type ="date" class="editField" id="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" name="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" data-dom_id="<%=domanda.getId() %>" data-dom_ordine="<%=domanda.getOrdine() %>" data-dom_classyfarm_id="<%=domanda.getIdClassyfarm() %>" data-risposta_classyfarm_id="<%=risposta.getIdClassyfarm() %>" value="<%=risposta.getNote() %>"/></td>
		<%} else if (risposta.getTipo().equalsIgnoreCase("number")) { %>
		<input type="number" class="editField" onKeyUp="gestisciNumber(this)" id="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" name="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" data-dom_id="<%=domanda.getId() %>" data-dom_ordine="<%=domanda.getOrdine() %>" data-dom_classyfarm_id="<%=domanda.getIdClassyfarm() %>" data-risposta_classyfarm_id="<%=risposta.getIdClassyfarm() %>" placeholder="<%=risposta.getRisposta() %>" value="<%=risposta.getNote() %>"/> </td>
		<%} else if (risposta.getTipo().equalsIgnoreCase("checkboxList")) { %> 
	
		<% for (int c = 0; c<risposta.getLista().length; c++) { %>
		<input type="checkbox" id="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId() %>" name="dom_<%=domanda.getId() %>_risposta_<%=risposta.getId()%>" value="<%=risposta.getLista()[c]%>" <%= risposta.getNote().contains(risposta.getLista()[c]) ? "checked=\"checked\"" : ""%> /> <%=risposta.getLista()[c]%><br/>
		<% } %>
	
		<%} %>
		</td>
	<%} %>
	
	</tr>
	
<% sezionePrecedente = domanda.getSezione();
}  %>
</table>

<br/><br/>

<center>
<table width="100%" cellpadding="10" cellspacing="10">
<tr>
<td>Il Conduttore/Allevatore</td>
<td>Il Veterinario Ufficiale</td>
</tr>

<tr>
<td>___________________________________</td>
<td>___________________________________</td>
</tr>
</table>
</center>

<br/><br/><br/><br/>

<input type="button" name="salva" id="salvaTemporaneo" class="buttonClass" value="Salva Temporaneo" onclick="saveForm(this.form, 'temp'); return false;"/>

<input type="button" name="salva" id="salvaDefinitivo" class="buttonClass" value="Salva Definitivo" onclick="saveForm(this.form, 'def'); return false;"/>

<input type="hidden" readonly name="bozza" id="bozza" value="" />
<input type="hidden" readonly name="idControllo" id="idControllo" value="<%=Ticket.getId()%>" />
<input type="hidden" readonly name="orgId" id="orgId" value="<%=Ticket.getOrgId()%>" />
<input type="hidden" readonly name="specie" id="specie" value="<%=specie %>" />
<input type="hidden" readonly name="versione" id="versione" value="<%=versione %>" />
<input type="hidden" readonly name="idChkClassyfarmMod" id="idChkClassyfarmMod" value="<%=idChkClassyfarmMod %>" />

</form>

<br/>
<div id="stampa" style="display:none">
<jsp:include page="../../../../gestione_documenti/boxDocumentaleNoAutomatico.jsp">
<jsp:param name="orgId" value="<%=request.getParameter("orgId") %>" />
<jsp:param name="extra" value="<%=request.getParameter("specie")+"_"+request.getParameter("idChkClassyfarmMod") %>" />
<jsp:param name="tipo" value="ChecklistBiosicurezzaSuiniStabBassa2022" />
<jsp:param name="idCU" value="<%=request.getParameter("idControllo") %>" />
<jsp:param name="url" value="<%=request.getParameter("url") %>" />
</jsp:include>
</div>
	

<script>
verificaStatoChecklist('<%=Checklist.isBozza()%>');
</script>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>















































<script>

function rispondiSoloDomande() {
	
	 var nomi = ["Test", "Prova", "Uno", "Due", "Tre", "Quattro", "Cinque", "Sei", "Sette", "Rischio", "Impresa", "Azienda", "Alpha", "Bravo", "Sierra", "Echo", "Novembre", "SPA", "Delta", "Kilo", "Coffee", "Angolo", "Oscar"];
	 var inputs = document.getElementsByTagName('input');
	 var inputNamePrecedente="";
   	for (i = 0; i < inputs.length; i++) {
   		
   	    	
	       if (inputs[i].type == 'radio' || inputs[i].type == 'checkbox') {
	       	var random = Math.floor(Math.random() * 11);
	         	 	if (random>5 || inputNamePrecedente!=inputs[i].name){
	          			inputs[i].checked=true;
	          			inputs[i].dispatchEvent(new Event('change'));
	         	 	}
	       	}
	       else if (inputs[i].type == 'textarea') {
	         inputs[i].value = nomi[Math.floor((Math.random() * nomi.length-1) + 1)] + " " + nomi[Math.floor((Math.random() * nomi.length-1) + 1)];
	   	}
	       else if (inputs[i].type == 'number') {
		         inputs[i].value = Math.floor((Math.random() * 100) + 1);
		   	}    
	       inputNamePrecedente = inputs[i].name;
	         
   	}
	  inputs = document.getElementsByTagName('textarea');

   	for (i = 0; i < inputs.length; i++) {
   		 if (inputs[i].style.display!='none')
   			 inputs[i].value = nomi[Math.floor((Math.random() * nomi.length-1) + 1)] + " " + nomi[Math.floor((Math.random() * nomi.length-1) + 1)];
   		 else
   			 inputs[i].value = '';
	   }
}


</script>


<%UserBean user = (UserBean) session.getAttribute("User");
if (user.getUserId()==5885) { %>
<input type="button" id="casoD" name="casoD" style="background-color:lime" value="rispondi a caso solo alle domande (TEST)" onClick="rispondiSoloDomande()"/>
<% } %>

