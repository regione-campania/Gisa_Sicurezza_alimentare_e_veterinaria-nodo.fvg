<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../../utils23/initPage.jsp" %>

<jsp:useBean id="numeroSeduta" class="java.lang.String" scope="request"/>
<jsp:useBean id="dataSeduta" class="java.lang.String" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request" />
<jsp:useBean id="OrgTamponeMacelli" class="org.aspcf.modules.controlliufficiali.base.ModTamponiMAcellazione" scope="request"/>
<jsp:useBean id="OrgOperatore" class="org.aspcf.modules.controlliufficiali.base.Organization" scope="request"/>
<jsp:useBean id="OrgUtente" class="org.aspcf.modules.controlliufficiali.base.OrganizationUtente" scope="request"/>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<link rel="stylesheet" type="text/css" media="screen" documentale_url="" href="macellazionidocumenti/css/screen_modello_10.css" />
<link rel="stylesheet" type="text/css" media="print" documentale_url="" href="macellazionidocumenti/css/print_modello_10.css" />


<!--  INIZIO HEADER -->

<div class="header">
<table class="tabellaHeader-simple">
		<tr>
			<td style="border:none">
				<div class="boxIdDocumento"></div><br/><center><b>REGIONE<br>CAMPANIA<br>ASL<br><br></b></center> 
			</td>
			<td>
				DIPART. DI PREV. SERVIZIO _____________ U.O. ____________<br>
				PEC__________________________<br>
				COD UTENTE SIGLA__________________________
			</td>
			<td><b>MOD. 10</b><br>Rev.9<br>del<br>17/11/21</td>
			<td>VERBALE<br>PRELEVAMENTO<br>CAMPIONE SUPERF.<br>CARCASSE<br>N. &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>
		</tr>
		<tr>	
			<td align="left" colspan="4"><b>CAMPIONE EFFETTUATO PER: </b></td>
		</tr>
</table>
</div>

<!-- FINE HEADER -->

<!-- INIT DOCUMENTALE -->
	<%@ include file="/gestione_documenti/initDocumentale.jsp" %>
<!-- FINE INIT DOCUMENTALE -->

<div class="boxOrigineDocumento"><%@ include file="../../../utils23/hostName.jsp" %></div>

<!-- input id="stampaId" type="button" class = "buttonClass" value ="Stampa" onclick="javascript:if( confirm('Attenzione! Controlla bene tutti i dati inseriti in quanto alla chiusura della finestra, i dati saranno persi.\nVuoi effettuare la stampa?')){return window.print();}else return false;"/-->
<input type="hidden" id = "bozza" name = "bozza" value="">
<script type="text/javascript">
function catturaHtml(form){
	//popolaCampi();
	h=document.getElementsByTagName('html')[0].innerHTML;
	var span = document.createElement("span");
	span.innerHTML = h;
	Array.from(span.querySelectorAll("script"), script => script.remove()); 
	h = span.innerHTML;
	h = h.replaceAll(/<\!--.*?-->/g, "");

	
	
	//h=fixCaratteriSpeciali(h);
	form.htmlcode.value = h;


}
</script>

<div id="stampa" style="display:block"><center>  
<jsp:include page="../gestione_documenti/boxDocumentaleNoAutomatico.jsp">
<jsp:param name="orgId" value="-1" />
<jsp:param name="stabId" value="-1" />
<jsp:param name="altId" value="<%= OrgDetails.getAltId() %>" />
<jsp:param name="tipo" value="Macelli_10" />
<jsp:param name="extra" value="<%= dataSeduta+"-"+numeroSeduta %>" />
<jsp:param name="idCU" value="-1" /> 
</jsp:include>
</center>
</div>

<!-- <form method="post" name="form2" action="GestioneDocumenti.do?command="> -->
<!-- <input id="salvaId" type="button" class = "buttonClass" value ="Genera e stampa PDF" onclick="catturaHtml(this.form);if (confirm ('Continuare?')){javascript:salva(this.form)}"/> -->

<!-- <input type="hidden" id ="htmlcode" name ="htmlcode" value="" /> -->
<!-- <input type="hidden" id="documentale" name ="documentale" value="ok"></input> -->
<!-- <input type="hidden" id="listavalori" name ="listavalori" value=""></input> -->
<%-- <input type="hidden" id ="altId" name ="altId" value="<%=request.getParameter("altId") %>" /> --%>
<!-- <input type="hidden" id ="ticketId" name ="ticketId" value="0" /> -->
<%-- <input type="hidden" id ="tipo" name ="tipo" value="<%=request.getParameter("tipo") %>" /> --%>
<%-- <input type="hidden" id ="idCU" name ="idCU" value="<%=request.getParameter("altId") %>" /> --%>
<%-- <input type="hidden" id ="url" name ="url" value="<%=request.getParameter("url") %>" /> --%>

<%-- <input type="hidden" id ="dataSeduta" name ="dataSeduta" value="<%=dataSeduta%>" /> --%>
<%-- <input type="hidden" id ="numeroSeduta" name ="numeroSeduta" value="<%=numeroSeduta%>" /> --%>
<!-- </form> -->


 
<html>
<body>
<div align="center">
	<div style="text-justify: inter-word;text-align: justify;">
	<table>
		<tr>
			<td>
				L'anno________ addi'____ del mese di_______________________________ alle ore__________ i sottoscritti________________________________________<br>________________________________________________________________________________,
				qualificandosi, si sono presentati presso:<br>
				<u><b>Stabilimento/azienda/altro</b> <i>(luogo dell'ispezione)</i></u>: Comune di <i><%= OrgDetails.getIndirizzo().getDescrizioneComune() != null && !OrgDetails.getIndirizzo().getDescrizioneComune().equals("") ? OrgDetails.getIndirizzo().getDescrizioneComune() +" "+ "_________________________________________________________________________________________".substring(OrgDetails.getIndirizzo().getDescrizioneComune().length()+3 ) : "_________________________________________________________________________________________" %></i><br>
				alla via <i><%= OrgDetails.getIndirizzo().getVia() != null && !OrgDetails.getIndirizzo().getVia().equals("") ? OrgDetails.getIndirizzo().getVia() +" "+ "________________________________________________________________".substring(OrgDetails.getIndirizzo().getVia().length()+3 ) : "________________________________________________________________" %></i>
				 n <i><%= OrgDetails.getIndirizzo().getCivico() != null && !OrgDetails.getIndirizzo().getCivico().equals("") ? OrgDetails.getIndirizzo().getCivico() +" "+ "_______".substring(OrgDetails.getIndirizzo().getCivico().length()+3 ) : "_______" %></i> ric. CE n. _________________________________<br>
				registr./cod az./targa/n.seriale ________________________________________________________________________________________________________________<br>
				linea di attivita' ispezionata ________________________________________________________________________________________________________________<br>
				<u><b>Nome/ditta/ragione/denominazione sociale</b></u>: <i><%= OrgDetails.getName() != null && !OrgDetails.getName().equals("") ? OrgDetails.getName() +" "+ "_________________________________________________________________________________________________________".substring(OrgDetails.getName().length()+3 ) : "_________________________________________________________________________________________________________" %></i><br>
				sede legale in <i><%= OrgDetails.getOperatore().getSedeLegale().getDescrizioneComune() != null && !OrgDetails.getOperatore().getSedeLegale().getDescrizioneComune().equals("") ? OrgDetails.getOperatore().getSedeLegale().getDescrizioneComune() +" "+ "_______________________________________________".substring(OrgDetails.getOperatore().getSedeLegale().getDescrizioneComune().length()+3 ) : "_______________________________________________" %></i>
				 alla via <i><%= OrgDetails.getOperatore().getSedeLegale().getVia() != null && !OrgDetails.getOperatore().getSedeLegale().getVia().equals("") ? OrgDetails.getOperatore().getSedeLegale().getVia() +" "+ "_______________________________________________".substring(OrgDetails.getOperatore().getSedeLegale().getVia().length()+3 ) : "_______________________________________________" %></i>
				 n. <i><%= OrgDetails.getOperatore().getSedeLegale().getCivico() != null && !OrgDetails.getOperatore().getSedeLegale().getCivico().equals("") ? OrgDetails.getOperatore().getSedeLegale().getCivico() +" "+ "______________".substring(OrgDetails.getOperatore().getSedeLegale().getCivico().length()+3 ) : "______________" %></i><br>
				PI/CF <i><%= OrgDetails.getOperatore().getPartitaIva() != null && !OrgDetails.getOperatore().getPartitaIva().equals("") ? OrgDetails.getOperatore().getPartitaIva() +" "+ "_____________________________________________________________".substring(OrgDetails.getOperatore().getPartitaIva().length()+3) : "_____________________________________________________________"%></i>
				 legale rappr. sig. <i><%= OrgDetails.getOperatore().getRappLegale().getCognome() != null && !OrgDetails.getOperatore().getRappLegale().getCognome().equals("") && OrgDetails.getOperatore().getRappLegale().getNome() != null && !OrgDetails.getOperatore().getRappLegale().getNome().equals("") ? OrgDetails.getOperatore().getRappLegale().getCognome()+" "+OrgDetails.getOperatore().getRappLegale().getNome() +" "+ "___________________________________________________________".substring((OrgDetails.getOperatore().getRappLegale().getCognome() + OrgDetails.getOperatore().getRappLegale().getNome()).length()+3) : "___________________________________________________________"%></i><br>
				nato a <i><%= OrgDetails.getOperatore().getRappLegale().getComuneNascita() != null && !OrgDetails.getOperatore().getRappLegale().getComuneNascita().equals("") ? OrgDetails.getOperatore().getRappLegale().getComuneNascita() + " " + "________________________________________________".substring(OrgDetails.getOperatore().getRappLegale().getComuneNascita().length()+3) : "________________________________________________" %></i> il <i><%= OrgDetails.getOperatore().getRappLegale().getDataNascita() != null ? OrgDetails.getOperatore().getRappLegale().getDataNascita().getDate() : "____" %>/<%= OrgDetails.getOperatore().getRappLegale().getDataNascita() != null ? OrgDetails.getOperatore().getRappLegale().getDataNascita().getMonth()+1 : "____" %>/<%= OrgDetails.getOperatore().getRappLegale().getDataNascita() != null ? OrgDetails.getOperatore().getRappLegale().getDataNascita().getYear() : "____" %></i>
				 e residente in <i><%= OrgDetails.getOperatore().getRappLegale().getIndirizzo().getDescrizioneComune() != null && !OrgDetails.getOperatore().getRappLegale().getIndirizzo().getDescrizioneComune().equals("") ? OrgDetails.getOperatore().getRappLegale().getIndirizzo().getDescrizioneComune() +" "+"__________________________________________".substring(OrgDetails.getOperatore().getRappLegale().getIndirizzo().getDescrizioneComune().length()+3) : "__________________________________________"%></i> alla <br>
				 via <i><%= OrgDetails.getOperatore().getRappLegale().getIndirizzo().getVia() != null && !OrgDetails.getOperatore().getRappLegale().getIndirizzo().getVia().equals("") ? OrgDetails.getOperatore().getRappLegale().getIndirizzo().getVia() +" "+"__________________________________________________________________".substring(OrgDetails.getOperatore().getRappLegale().getIndirizzo().getVia().length()+3) : "__________________________________________________________________" %></i>
				   n. <i><%= OrgDetails.getOperatore().getRappLegale().getIndirizzo().getCivico() != null && !OrgDetails.getOperatore().getRappLegale().getIndirizzo().getCivico().equals("") ? OrgDetails.getOperatore().getRappLegale().getIndirizzo().getCivico() +" "+"_____".substring(OrgDetails.getOperatore().getRappLegale().getIndirizzo().getCivico().length()+3) : "_____" %></i>
				    domicilio digitale <i><%= OrgDetails.getOperatore().getRappLegale().getDomicilioDigitale() != null && !OrgDetails.getOperatore().getRappLegale().getDomicilioDigitale().equals("") ? OrgDetails.getOperatore().getRappLegale().getDomicilioDigitale() +" "+"_______________________________________________".substring(OrgDetails.getOperatore().getRappLegale().getDomicilioDigitale().length()+3) : "_______________________________________________" %></i>
				<br><u><b>Presente all'ispezione</b>:</u> sig. _____________________________________________________________________________________________________________________<br>
				(dati identificativi contenuti nel Mod 5 agli atti). I sottoscritti hanno proceduto, in regime di asepsi, al prelievo di campione/i per l'esame microbiologico dalle superfici di carcasse come appresso specificato:<br>
			</td>
		</tr>
	</table>
	<table class="tabellaHeader-simple">
		<tr>
			<td><u><b>Carcasse</b></u></td>
			<td colspan="4">
				<input type="checkbox" id="bovinoCK"> bovino*
				<input type="checkbox" id="ovinoCK"> ovino*
				<input type="checkbox" id="caprinoCK"> caprino*
				<input type="checkbox" id="equinoCK"> equino*
				<input type="checkbox" id="suinoCK"> suino*
				<input type="checkbox" id="broilerCK"> broiler**
				<input type="checkbox" id="tacchinoCK"> tacchino**
				<br> *dopo la macellazione, ma prima del raffreddamento &nbsp&nbsp **dopo il raffreddamento
			</td>
		</tr>
		<tr>
			<td><u><b>Ricerca:</b></u></td>
			<td><input type="checkbox"><b>(A)</b> colonie aerob. (no carni avicole)</td>
			<td><input type="checkbox"><b>(B)</b> enterobatteriaceae (no carni avic.)</td>
			<td><input type="checkbox"><b>(C)</b> salmonella spp.</td>
			<td><input type="checkbox"><b>(D)</b> tessuto di SNC</td>
		</tr>
		<tr>
			<td rowspan="5"><u><b>Metodo:</b></u></td>
			<td rowspan="3">
				<input type="checkbox"> <u>Non distruttivo</u>.<br>
				Volume diluente<br>
				______________ ml.
			</td>
			<td colspan="3" align="left">
				<input type="checkbox"> Per <b>(A)</b> e <b>(B)</b>: n. 4 siti ognuno di __________ cm2 (min. 50 cm2 per piccoli ruminanti - min. 100cm2 per bovini, equini o suini) 
				per n. 5 carcasse scelte a caso utilizzando <input type="checkbox"> SPONGE <input type="checkbox"> GARZA <input type="checkbox"> TAMPONE
			</td>
		</tr>
		<tr>
			<td colspan="3" align="left">
				<input type="checkbox"> Per <b>(C)</b>: n. 4 siti ognuno di ________ cm2 (min 100 cm2) per n. 5 carcasse scelte a caso utilizzando SPONGE (NON applicabile a broiler e tacchini )
			</td>
		</tr>
		<tr>
			<td colspan="3" align="left">
				<input type="checkbox"> Per <b>(D)</b>: n. 1 tampone per n. 2 siti (massetere destro e sinistro) su una superficie di cm. 10 x 10
			</td>
		</tr>
			
		<tr>
			<td rowspan="2">
				<input type="checkbox"> <u>Distruttivo</u>
			</td>
			<td colspan="3" align="left">
				<input type="checkbox"> Per <b>(A)</b> e <b>(B)</b>: prelievo di n. 4 pezzi di tessuto (ognuno 5 cm2 spessi almeno 2mm) x n.5 carcasse scelte a caso
			</td>
		</tr>
		<tr>
			<td colspan="3" align="left">
				<input type="checkbox"> Per <b>(C)</b>nei broiler e tacchini: n. 1 frammento di pelle di collo di almeno 10 gr. per n.15 carcasse scelte a caso 
			</td>
		</tr>
		<tr>
			<td colspan="5">
				 <u><b>RUMINANTI, EQUINI E SUINI</b></u>: IDENTIFICAZIONE DELLE CARCASSE PRESCELTE (I° COLONNA) E DESCRIZIONE DEI SITI SCELTI PER 
					IL METODO NON DISTRUTTIVO O DAI QUALI SONO STATI PRELEVATI I CAMPIONI DI TESSUTO CON IL METODO DISTRUTTIVO
			</td>
		</tr>
		<tr>
			<td align="left">I CARCASSA N.	
			</td>
			<td align="left">1)
			</td>
			<td align="left">2)
			</td>
			<td align="left">3)
			</td>
			<td align="left">4)
			</td>
		</tr>
		<tr>
			<td align="left">II CARCASSA N.	
			</td>
			<td align="left">1)
			</td>
			<td align="left">2)
			</td>
			<td align="left">3)
			</td>
			<td align="left">4)
			</td>
		</tr>
		<tr>
			<td align="left">III CARCASSA N.	
			</td>
			<td align="left">1)
			</td>
			<td align="left">2)
			</td>
			<td align="left">3)
			</td>
			<td align="left">4)
			</td>
		</tr>
		<tr>
			<td align="left">IV CARCASSA N.	
			</td>
			<td align="left">1)
			</td>
			<td align="left">2)
			</td>
			<td align="left">3)
			</td>
			<td align="left">4)
			</td>
		</tr>
		<tr>
			<td align="left">V CARCASSA N.	
			</td>
			<td align="left">1)
			</td>
			<td align="left">2)
			</td>
			<td align="left">3)
			</td>
			<td align="left">4)
			</td>
		</tr>
		<tr><td colspan="5"><u><b>PER POLLAME</b></u>: IDENTIFICAZIONE DELLE CARCASSE PRESCELTE</td></tr>
		<tr>
			<td align="left">I CARCASSA N. <br><br></td>
			<td align="left">II CARCASSA N. <br><br></td>
			<td align="left">III CARCASSA N. <br><br></td>
			<td align="left">IV CARCASSA N. <br><br></td>
			<td align="left">V CARCASSA N. <br><br></td>
		</tr>
		<tr>
			<td align="left">VI CARCASSA N. <br><br></td>
			<td align="left">VII CARCASSA N. <br><br></td>
			<td align="left">VIII CARCASSA N. <br><br></td>
			<td align="left">IX CARCASSA N. <br><br></td>
			<td align="left">X CARCASSA N. <br><br></td>
		</tr>
		<tr>
			<td align="left">XI CARCASSA N. <br><br></td>
			<td align="left">XII CARCASSA N. <br><br></td>
			<td align="left">XIII CARCASSA N. <br><br></td>
			<td align="left">XIV CARCASSA N. <br><br></td>
			<td align="left">XV CARCASSA N. <br><br></td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				Il prelievo e' stato effettuato sulle stesse carcasse campionate contemporaneamente dall'OSA in autocontrollo <input type="checkbox"> SI <input type="checkbox"> NO.<br> 
				Le u.c. sono state poste in <input type="checkbox"> buste di plastica sterili <input type="checkbox"> recipienti di ____________ sterili che vengono sigillati con piombini
				recanti la dicitura _________________________________________________________________________________ e 
				muniti di cartellini controfirmati dal presente al campionamento . Esse sono inviate al _____________________________________________________________________ Le u.c. vengono conservate e trasferite alla temperatura di _______ C
			</td>
		</tr>	
	</table>
	<br><br>
	<table>
		<tr align="center">
			<td><h2>IL RAPPRESENTANTE DELL'IMPRESA</h2></td>
			<td><h2>GLI OPERATORI DEL CONTROLLO UFFICIALE</h2></td>			
		</tr>
	</table>
	</div>
</div>

</body>
</html>