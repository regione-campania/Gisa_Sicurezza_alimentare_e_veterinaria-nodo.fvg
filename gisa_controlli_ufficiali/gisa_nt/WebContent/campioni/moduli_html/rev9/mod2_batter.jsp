<%int z=0; %>

<!-- INIT DOCUMENTALE -->
	<%@ include file="/gestione_documenti/initDocumentale.jsp" %>
<!-- FINE INIT DOCUMENTALE -->

<!-- INIZIO HEADER -->
	<%@ include file="/campioni/moduli_html/rev9/header.jsp" %>
<!-- FINE HEADER -->

<div class="boxOrigineDocumento"><%@ include file="../../../utils23/hostName.jsp" %></div>

<table><tr>
<TD>
<div id="idbutn" style="display:block;">
<%-- <input type="button" class = "buttonClass" value ="Salva in modalità definitiva" onclick="this.form.bozza.value='false';javascript:checkSubmit();"/>
--%>
</div>
<input id="stampaId" type="button" class = "buttonClass"  style="display:none" value ="Stampa" onclick="javascript:if( confirm('Attenzione! Controlla bene tutti i dati inseriti in quanto alla chiusura della finestra, i dati saranno persi.\nVuoi effettuare la stampa?')){return window.print();}else return false;"/>
<input type="hidden" id = "bozza" name = "bozza" value="">

<%-- onclick="this.form.bozza.value='false';" --%>

<dhv:permission name="server_documentale-view">
<%if (definitivoDocumentale!=null && definitivoDocumentale.equals("true")){ %>
<!--  BOX DOCUMENTALE -->
	  <jsp:include page="../../../gestione_documenti/boxDocumentale.jsp">
    <jsp:param name="orgId" value="<%=request.getParameter("orgId") %>" />
     <jsp:param name="ticketId" value="<%=request.getParameter("ticketId") %>" />
      <jsp:param name="tipo" value="<%=request.getParameter("tipo") %>" />
       <jsp:param name="idCU" value="<%=request.getParameter("idCU") %>" />
        <jsp:param name="url" value="<%=request.getParameter("url") %>" />
</jsp:include>
<!--  BOX DOCUMENTALE -->
<% } else {%>
<form method="post" name="form2" action="PrintModulesHTML.do?command=ViewModules">
<input id="stampaPdfId" type="button" class = "buttonClass" value ="Genera e Stampa PDF" onclick="if (confirm ('Nella prossima schermata sarà possibile recuperare l\'ultimo PDF generato a partire dal documento a schermo, \n oppure generarne uno nuovo.')){javascript:salva(this.form)}"/>
<input type="hidden" id="documentale" name ="documentale" value="ok"></input>
<input type="hidden" id="listavalori" name ="listavalori" value=""></input>
 <input type="hidden" id ="orgId" name ="orgId" value="<%=request.getParameter("orgId") %>" />
  <input type="hidden" id ="ticketId" name ="ticketId" value="<%=request.getParameter("ticketId") %>" />
   <input type="hidden" id ="tipo" name ="tipo" value="<%=request.getParameter("tipo") %>" />
    <input type="hidden" id ="idCU" name ="idCU" value="<%=request.getParameter("idCU") %>" />
      <input type="hidden" id ="url" name ="url" value="<%=request.getParameter("url") %>" />
</form>
<% } %>
</dhv:permission>
</TD>
</TABLE>
<P class="main">
L'anno <label class="layout"><%= fixValore( OrgOperatore.getAnnoReferto()) %></label> 
addì <label class="layout"><%= fixValoreShort(OrgOperatore.getGiornoReferto())%></label> 
del mese di <label class="layout"><%= fixValore(OrgOperatore.getMeseReferto())%></label> 
alle ore <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("ora_controllo").get("ora_controllo"))%> </label> i sottoscritti:<br/>

<% if (OrgOperatore.getComponente_nucleo()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_due()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_due()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_tre()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_tre()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_quattro()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_quattro()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_cinque()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_cinque()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_sei()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_sei()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_sette()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_sette()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_otto()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_otto()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_nove()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_nove()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_dieci()!=null) {%> <label class="layout"><%= fixValoreLong(OrgOperatore.getComponente_nucleo_dieci()) %></label> <%} %> 
<br/>
, qualificandosi, si sono presentati presso:<br><br/>

<U><b>Stabilimento/azienda/altro</b><i>(luogo del controllo)</i>:</U> <br/>
Comune di <label class="layout"><%= fixValoreLong(OrgOperatore.getComune())%></label> 
alla via <label class="layout"><%= fixValoreLong(OrgOperatore.getIndirizzo()) %></label> 
ric. CE <label class="layout"><%= fixValoreLong(OrgOperatore.getApproval_number())%></label> <br/>
regist./cod.az./targa/n.seriale <label class="layout"><%= fixValoreLong(OrgOperatore.getN_reg()) %></label> 
linea di attività ispezionata<br/> <label class="layout"><%= fixValoreLong(OrgOperatore.getTipologia_att())%></label>.<br><br/>

<U><b>Nome/ditta/Ragione/Denominazione sociale: </b></U><br/>
<label class="layout"><%= fixValoreLong(OrgOperatore.getRagione_sociale())%></label> 
sede legale/residente in <label class="layout"><%= fixValoreLong(OrgOperatore.getSede_legale())%></label><br/>
alla via <label class="layout"><%= fixValoreLong(OrgOperatore.getIndirizzo_legale()) %></label> 
PI/CF <label class="layout"><%= fixValoreLong(OrgOperatore.getCodice_fiscale()) %></label> 
domicilio digitale <label class="layout">____________</label><br/><br/>

<U><b>Presente all'ispezione:</b></U><br/>
sig. <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("nome_presente_ispezione").get("nome_presente_ispezione"))%> </label> (dati identificativi contenuti nel Mod 5 agli atti) 
hanno prelevato un campione di <label class="layout"><%= OrgCampione.getMatrice()%> </label>
<%-- <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("campione_prelevato").get("campione_prelevato"))%> </label>  --%>
da una partita di <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("rappresentativo_partita").get("rappresentativo_partita"))%> </label> 
<span class="bordo" style="border:1px solid black;"> 
[<%= fixValore(Modulo.getListaCampiModulo().get("unita_partita").get("unita_partita")).equals("2") ? "X" : ""%>] KG 
[<%= fixValore(Modulo.getListaCampiModulo().get("unita_partita").get("unita_partita")).equals("3") ? "X" : ""%>] LT
[<%= fixValore(Modulo.getListaCampiModulo().get("unita_partita").get("unita_partita")).equals("4") ? "X" : ""%>] UNITA 
</span>
 
<br/>

detenuta nel <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("detenuta_in").get("detenuta_in"))%> </label>
a <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("gradi").get("gradi"))%> </label> °C in<br/>
<span class="bordo" style="border:1px solid black;"> 
[<%= fixValore(Modulo.getListaCampiModulo().get("contenitore_unita_partita").get("contenitore_unita_partita")).equals("2") ? "X" : ""%>] CONFEZIONE INTEGRA 
[<%= fixValore(Modulo.getListaCampiModulo().get("contenitore_unita_partita").get("contenitore_unita_partita")).equals("4") ? "X" : ""%>] CONFEZIONE APERTA 
[<%= fixValore(Modulo.getListaCampiModulo().get("contenitore_unita_partita").get("contenitore_unita_partita")).equals("3") ? "X" : ""%>] PREINCARTO
[<%= fixValore(Modulo.getListaCampiModulo().get("contenitore_unita_partita").get("contenitore_unita_partita")).equals("5") ? "X" : ""%>] STATO SFUSO 
</span><br/>

 con le seguenti indicazioni:
<label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("indicazioni").get("indicazioni"))%> </label><br/>
Trattasi di alimento R.T.E.? 
[<%= fixValore(Modulo.getListaCampiModulo().get("rte").get("rte")).equals("2") ? "X" : ""%>] SI
[<%= fixValore(Modulo.getListaCampiModulo().get("rte").get("rte")).equals("3") ? "X" : ""%>] NO
<br/>
Il latte utilizzato come materia prima è pastorizzato?  
[<%= fixValore(Modulo.getListaCampiModulo().get("latte_pastorizzato").get("latte_pastorizzato")).equals("2") ? "X" : ""%>] SI
[<%= fixValore(Modulo.getListaCampiModulo().get("latte_pastorizzato").get("latte_pastorizzato")).equals("3") ? "X" : ""%>] NO
[<%= fixValore(Modulo.getListaCampiModulo().get("latte_pastorizzato").get("latte_pastorizzato")).equals("4") ? "X" : ""%>] NON SO

<br/>
Nazione dello stabilimento di produzione <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("nazione").get("nazione"))%> </label> Zona FAO (per prod.pesca) <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("fao").get("fao"))%> </label> 
<br/>
Trattamenti subiti dalla merce campionata <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("trattamenti").get("trattamenti"))%> </label><br/>
<br/>
Il campione e' stato prelevato secondo le norme specifiche in materia per la 
[<%= fixValore(Modulo.getListaCampiModulo().get("motivo_prelievo").get("motivo_prelievo")).equals("2") ? "X" : ""%>] RICERCA DI 
 <label class="layout"><%=  fixValoreLong(OrgCampione.getAnaliti())%> </label>
<%-- <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("ricerca_descrizione").get("ricerca_descrizione"))%> </label> --%>
[<%= fixValore(Modulo.getListaCampiModulo().get("motivo_prelievo").get("motivo_prelievo")).equals("3") ? "X" : ""%>] NUMERAZIONE DI <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("numerazione_descrizione").get("numerazione_descrizione"))%> </label>

<br/>
quale:	
[<%= fixValore(Modulo.getListaCampiModulo().get("tipologia_prelievo").get("tipologia_prelievo")).equals("2") ? "X" : ""%>] (<b>1</b>) CRITERIO DI IGIENE DI PROCESSO
[<%= fixValore(Modulo.getListaCampiModulo().get("tipologia_prelievo").get("tipologia_prelievo")).equals("3") ? "X" : ""%>] (<b>2</b>) CRITERIO DI SICUREZZA ALIMENTARE
[<%= fixValore(Modulo.getListaCampiModulo().get("tipologia_prelievo").get("tipologia_prelievo")).equals("4") ? "X" : ""%>] (<b>3</b>) ALTRI PARAMETRI MICROBIOLOGICI.
<br/>
<!--  -->
Il campione è stato prelevato durante la fase <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("fase").get("fase"))%> </label><br>
attuando procedure tali da evitare per quanto possibile l'inquinamento accidentale della matrice.<br>
[<%= fixValore(Modulo.getListaCampiModulo().get("precetto").get("precetto")).equals("2") ? "X" : ""%>] In applicazione del precetto ex art. 223 punto 1 D.L.vo 271/89 in merito alle garanzie del diritto alla difesa si comunica
 che in data <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("data").get("data"))%> </label> alle ore <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("ore").get("ore"))%> </label>
 presso la sede del laboratorio di destinazione gli interessati possono 
 assistere, anche per rappresentanza, all'inizio delle operazioni di analisi [Precetto obbligatorio nei sopracitati casi (<b>2</b>) e (<b>3</b>)].<br>
 Essendo una analisi microbiologica, ai sensi del punto 2 dell'art. 7 del D.L.vo 27/21 viene esclusa la possibilità di 
 ripetizione dell'analisi in quanto inopportuna e non pertinente, e pertanto il campione è costituito da n. 1  formata 
 da n.<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("sicurezza_numero_uc").get("sicurezza_numero_uc"))%> </label> 
unità campionarie del peso di ca. <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("sicurezza_peso").get("sicurezza_peso"))%> </label>
cadauna.<br>
Le unita' campionarie sono [<%= fixValore(Modulo.getListaCampiModulo().get("uc_contenitore").get("uc_contenitore")).equals("4") ? "X" : ""%>] lasciate nel proprio contenitore ovvero poste in contenitori
[<%= fixValore(Modulo.getListaCampiModulo().get("uc_contenitore").get("uc_contenitore")).equals("2") ? "X" : ""%>] di plastica.
[<%= fixValore(Modulo.getListaCampiModulo().get("uc_contenitore").get("uc_contenitore")).equals("3") ? "X" : ""%>] di vetro sterili.
<br> L'aliquota, munita di cartellino e sigillata con piombino, ovvero posta in busta autosigillante antimanomissione, 
reca la dicitura <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("dicitura").get("dicitura"))%> </label> 
ed è stata controfirmata dal presente al campionamento. Il Sistema informatico GISA attribuirà automaticamente il codice foodex alla 
matrice prelevata.<br>
L'aliquota viene conservata e inviata al laboratorio del <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("inviate").get("inviate"))%> </label> 	alla temp. di  <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("temperatura_aliq").get("temperatura_aliq"))%> </label> °C. 
Il  presente  verbale e' redatto  in  n. 3 copie  di  cui  una  viene  rilasciata  al  presente  al  campionamento  che  dichiara <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("dichiarazione").get("dichiarazione"))%> </label><br/>
[<%= fixValore(Modulo.getListaCampiModulo().get("proceduto_sequestro").get("proceduto_sequestro")).equals("2") ? "X" : ""%>] SI E'
[<%= fixValore(Modulo.getListaCampiModulo().get("proceduto_sequestro").get("proceduto_sequestro")).equals("3") ? "X" : ""%>] NON SI E'
 proceduto al sequestro della restante merce con verbale di sequestro n <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("verbale").get("verbale"))%> </label><br/>
Note: <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("note").get("note"))%> </label><br/><br/>

Letto, confermato e sottoscritto <br/>
IL PRESENTE ALL'ISPEZIONE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;	GLI OPERATORI DEL CONTROLLO UFFICIALE  		

<div style="page-break-before:always"> 
<!-- INIZIO HEADER -->
	<%@ include file="/campioni/moduli_html/rev9/header.jsp" %>
<!-- FINE HEADER -->

<!-- INIZIO FOOTER -->
	<%@ include file="/campioni/moduli_html/footer.jsp" %>
<!-- FINE FOOTER -->

</div>
<br><br><br>
<%@ include file="/gestione_documenti/gdpr_footer.jsp" %>
<br/>
