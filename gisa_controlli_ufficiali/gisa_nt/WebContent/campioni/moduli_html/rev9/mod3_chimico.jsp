
<%int z = 0; %>

<!-- INIT DOCUMENTALE -->
	<%@ include file="/gestione_documenti/initDocumentale.jsp" %>
<!-- FINE INIT DOCUMENTALE -->

<!-- INIZIO HEADER -->
	<%@ include file="/campioni/moduli_html/rev9/header.jsp" %>
<!-- FINE HEADER -->

<div class="boxOrigineDocumento"><%@ include file="../../../../utils23/hostName.jsp" %></div>

<table><tr>
<TD>
<div id="idbutn" style="display:block;">
<%-- <input type="button" class = "buttonClass" value ="Salva in modalità definitiva" onclick="this.form.bozza.value='false';javascript:checkSubmit();"/>
--%>
</div>
<input id="stampaId" type="button" class = "buttonClass"  style="display:none" value ="Stampa" onclick="javascript:if( confirm('Attenzione! Controlla bene tutti i dati inseriti in quanto alla chiusura della finestra, i dati saranno persi.\nVuoi effettuare la stampa?')){return window.print();}else return false;"/>
<input type="hidden" id = "bozza" name = "bozza" value="">

<%-- onclick="this.form.bozza.value='false';" --%>
<br>

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
alle ore <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("ora_controllo").get("ora_controllo"))%> </label> 
i sottoscritti: <br/>

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
, qualificandosi, si sono presentati presso:<br>

<U><b>Stabilimento/azienda/altro</b>(luogo del controllo):</U><br/>
Comune di <label class="layout"><%= fixValoreLong(OrgOperatore.getComune())%></label> 
alla via <label class="layout"><%= fixValoreLong(OrgOperatore.getIndirizzo()) %></label> 
ric.CE n° <label class="layout"><%= fixValoreLong(OrgOperatore.getApproval_number())%></label><br/>
regist./cod.az./targa/n.seriale <label class="layout"><%= fixValoreLong(OrgOperatore.getN_reg()) %></label>  
linea di attività ispezionata<br/>
<label class="layout"><%= fixValoreLong(OrgOperatore.getTipologia_att())%></label>.<br><br/>

<U><b>Nome/ditta/Ragione/Denominazione sociale: </b></U><br/>
<label class="layout"><%= fixValoreLong(OrgOperatore.getRagione_sociale())%></label><br/>
sede legale/residente in <label class="layout"><%= fixValoreLong(OrgOperatore.getSede_legale())%></label> alla via <label class="layout"><%= fixValoreLong(OrgOperatore.getIndirizzo_legale()) %></label><br/>
PI/CF <label class="layout"><%= fixValoreLong(OrgOperatore.getCodice_fiscale()) %></label> domicilio digitale <label class="layout">____________</label><br/><br/>

<U><b>Presente all'ispezione:</b></U><br/>
sig. <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("nome_presente_ispezione").get("nome_presente_ispezione"))%> </label> (dati identificativi contenuti nel Mod 5 agli atti)
 hanno prelevato un campione di 
 <label class="layout"><%= fixValoreLong(OrgCampione.getMatrice())%> </label>
<%--  <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("campione_prelevato").get("campione_prelevato"))%> </label> --%>
 da una partita di <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("rappresentativo_partita").get("rappresentativo_partita"))%> </label> 
<span class="bordo" style="border:1px solid black;">
[<%= fixValore(Modulo.getListaCampiModulo().get("unita_partita").get("unita_partita")).equals("2") ? "X" : ""%>] KG 
[<%= fixValore(Modulo.getListaCampiModulo().get("unita_partita").get("unita_partita")).equals("3") ? "X" : ""%>] LT
[<%= fixValore(Modulo.getListaCampiModulo().get("unita_partita").get("unita_partita")).equals("4") ? "X" : ""%>] UNITA 
</span>
 detenuta nel <label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("detenuta_in").get("detenuta_in"))%> </label>
 a  <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("gradi").get("gradi"))%> </label> °C
 in
 <span class="bordo" style="border:1px solid black;">
[<%= fixValore(Modulo.getListaCampiModulo().get("contenitore_unita_partita").get("contenitore_unita_partita")).equals("2") ? "X" : ""%>] CONFEZIONE INTEGRA
[<%= fixValore(Modulo.getListaCampiModulo().get("contenitore_unita_partita").get("contenitore_unita_partita")).equals("4") ? "X" : ""%>] CONFEZIONE APERTA  
[<%= fixValore(Modulo.getListaCampiModulo().get("contenitore_unita_partita").get("contenitore_unita_partita")).equals("3") ? "X" : ""%>] PREINCARTO
[<%= fixValore(Modulo.getListaCampiModulo().get("contenitore_unita_partita").get("contenitore_unita_partita")).equals("5") ? "X" : ""%>] STATO SFUSO 
</span>
con le seguenti indicazioni:
<label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("indicazioni").get("indicazioni"))%> </label><br/>
<!-- METODO DI PRODUZIONE -->
Metodo di produzione: 
<span class="bordo" style="border:1px solid black;"> 
[<%= fixValore(Modulo.getListaCampiModulo().get("metodo_produzione").get("metodo_produzione")).equals("1") ? "X" : ""%>] BIOLOGICA
[<%= fixValore(Modulo.getListaCampiModulo().get("metodo_produzione").get("metodo_produzione")).equals("2") ? "X" : ""%>] INTEGRATA  
[<%= fixValore(Modulo.getListaCampiModulo().get("metodo_produzione").get("metodo_produzione")).equals("3") ? "X" : ""%>] NON DEFINITA
</span><BR>
Zona FAO (solo per prodotti della pesca) <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("fao").get("fao"))%> </label>
Nazione dello stabilimento di produzione <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("nazione").get("nazione"))%> </label> 
Trattamenti subiti dalla merce campionata <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("trattamenti").get("trattamenti"))%> </label><br/>
Il campione è stato effettuato durante la fase <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("fase").get("fase"))%> </label>
Trattasi di alimento pronto da mangiare (R.T.E.)? 
[<%= fixValore(Modulo.getListaCampiModulo().get("rte").get("rte")).equals("2") ? "X" : ""%>] SI
[<%= fixValore(Modulo.getListaCampiModulo().get("rte").get("rte")).equals("3") ? "X" : ""%>] NO
<br>
Ai sensi dell'art. 2 del Reg (CE) n.1881/06 il fattore di 
<span class="bordo" style="border:1px solid black;"> 
[<%= fixValore(Modulo.getListaCampiModulo().get("fattore_scelta").get("fattore_scelta")).equals("1") ? "X" : ""%>] trasformazione
[<%= fixValore(Modulo.getListaCampiModulo().get("fattore_scelta").get("fattore_scelta")).equals("2") ? "X" : ""%>] concentrazione  
[<%= fixValore(Modulo.getListaCampiModulo().get("fattore_scelta").get("fattore_scelta")).equals("3") ? "X" : ""%>] diluizione del processo di produzione
</span><BR>
[<%= fixValore(Modulo.getListaCampiModulo().get("fattore_trasformazione").get("fattore_trasformazione")).equals("2") ? "X" : ""%>] E' PARI A
 <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("fattore_trasformazione_pari").get("fattore_trasformazione_pari"))%> </label> 
[<%= fixValore(Modulo.getListaCampiModulo().get("fattore_trasformazione").get("fattore_trasformazione")).equals("3") ? "X" : ""%>] SARA' ACQUISITO IN SEGUITO
<br/>
Il campione è costituito da  n. <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("num_aliquote").get("num_aliquote"))%> </label> aliquote
sulle 
 <span class="bordo" style="border:1px solid black;">
[<%= fixValore(Modulo.getListaCampiModulo().get("previste").get("previste")).equals("1") ? "X" : ""%>] 4
[<%= fixValore(Modulo.getListaCampiModulo().get("previste").get("previste")).equals("2") ? "X" : ""%>] 5 
</span>
previste. Motivo del mancato prelevamento di tutte le aliquote:<br> 
A [<%= fixValore(Modulo.getListaCampiModulo().get("causa_mancanza_aliquote").get("causa_mancanza_aliquote")).equals("2") ? "X" : ""%>] espressa rinuncia dell'operatore/del presente al campionamento delle aliquote per la controperizia/controversia 
<br/>
B [<%= fixValore(Modulo.getListaCampiModulo().get("causa_mancanza_aliquote").get("causa_mancanza_aliquote")).equals("3") ? "X" : ""%>] per i seguenti motivi che ne escludono l'opportunità, la pertinenza o la fattibilità tecnica <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("motivi_mancanza_aliquote").get("motivi_mancanza_aliquote"))%> </label><br/>
Nel caso B in applicazione del precetto ex art. 223 punto 1 D.L.vo 271/89
in merito alle garanzie del diritto alla difesa si comunica che in data <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("data").get("data"))%> </label> 
alle ore <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("ore").get("ore"))%> </label> presso la sede del laboratorio di destinazione gli interessati possono assistere, anche per rappresentanza, all'inizio delle operazioni di analisi.<br>
Ciascuna aliquota e' costituita da n. <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("num_uc").get("num_uc"))%> </label> unita' campionarie/campioni elementari del peso di ca. <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("peso").get("peso"))%> </label> cadauna che sono state  
[] lasciate nel proprio contenitore ovvero posti in contenitori 
[<%= fixValore(Modulo.getListaCampiModulo().get("uc_contenitore").get("uc_contenitore")).equals("2") ? "X" : ""%>] DI PLASTICA
[<%= fixValore(Modulo.getListaCampiModulo().get("uc_contenitore").get("uc_contenitore")).equals("3") ? "X" : ""%>] DI VETRO. <br>
Le aliquote, munite di cartellino e sigillate con piombino, ovvero poste in buste autosigillanti antimanomissione, recano la dicitura 
<label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("dicitura").get("dicitura"))%> </label>, e  sono state controfirmate dal presente al campionamento.  L'aliquota per l'eventuale controperizia analitica:<br>
A [<%= fixValore(Modulo.getListaCampiModulo().get("lasciata_aliquota").get("lasciata_aliquota")).equals("2") ? "X" : ""%>] E' STATA (solo nel caso di campione prelavato presso lo stabilimento di produzione dell'alimento campionato)<br>
B [<%= fixValore(Modulo.getListaCampiModulo().get("lasciata_aliquota").get("lasciata_aliquota")).equals("3") ? "X" : ""%>] NON E' STATA (nel caso di campione prelevato presso uno stabilimento diverso da quello dove è stato prodotto o nel caso di apertura ufficiale ex art. 223 punto 1 D.L.vo 271/89)
lasciata al presente all'ispezione. <br>
Le altre n.<label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("altre_num").get("altre_num"))%> </label> (compresa l'aliquota per la controperizia del caso B) sono conservate e inviate al laboratorio del <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("inviate").get("inviate"))%> </label> a <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("temperatura_aliq").get("temperatura_aliq"))%> </label> °C per la ricerca di 
<label class="layout"><%= fixValoreLong(OrgCampione.getAnaliti())%> </label><br/>
<%-- <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("ricerca_descrizione").get("ricerca_descrizione"))%> </label><br/> --%>
Nel caso la ricerca sia IPA o bisfenolo, il materiale di confezionamento/imballaggio primario è costituito da: <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("imballaggio").get("imballaggio"))%> </label>.<br/>
Il codice foodex della matrice prelevata è attribuito automaticamente dal Sistema informatico GISA. Il  presente  verbale e' redatto  in  n. _______ copie  di  cui  una  viene  rilasciata  al  presente  al  campionamento  che  dichiara <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("dichiarazione").get("dichiarazione"))%> </label><br/>
[<%= fixValore(Modulo.getListaCampiModulo().get("proceduto_sequestro").get("proceduto_sequestro")).equals("2") ? "X" : ""%>] SI E'
[<%= fixValore(Modulo.getListaCampiModulo().get("proceduto_sequestro").get("proceduto_sequestro")).equals("3") ? "X" : ""%>] NON SI E'
 proceduto al sequestro della restante merce con verbale di sequestro n <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("verbale").get("verbale"))%> </label><br/>
Note: <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("note").get("note"))%> </label><br/><br/>
Letto, confermato e sottoscritto <br/>
IL PRESENTE ALL'ISPEZIONE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;	GLI OPERATORI DEL CONTROLLO UFFICIALE  		


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
