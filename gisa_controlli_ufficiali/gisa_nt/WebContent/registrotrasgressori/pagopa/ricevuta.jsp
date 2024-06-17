<jsp:useBean id="pagamento" class="org.aspcfs.modules.registrotrasgressori.base.Pagamento" scope="request"/>
<link rel="stylesheet" type="text/css" media="all" documentale_url="" href="registrotrasgressori/css/ricevuta_pagopa_layout.css" />
<%@ include file="../../utils23/initPage.jsp"%>

<table width="100%" cellpadding="10" cellspacing="10">
<col width="20%"><col width="60%">
<tr>

<td align="center">
<div align="left"><img style="text-decoration: none;" width="80" height="80" documentale_url="" src="gestione_documenti/schede/images/regionecampania.jpg" /></div>
<div class="boxIdDocumento"></div>
<div class="boxOrigineDocumento"><%@ include file="../../../utils23/hostName.jsp" %></div>
</td>  
       
<td align="center" valign="top" class="titolo0">RICEVUTA TELEMATICA PAGAMENTO <%=(!org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("ambiente").equalsIgnoreCase("ufficiale")) ? "<font color=\"red\"><b>COLLAUDO</b></font>" : "" %></td
<td align="center"><img style="text-decoration: none;" width="80" height="80" documentale_url="" src="registrotrasgressori/pagopa/logo.png" /></td>
</table>

<hr>

<table width="100%">
<col width="20%"><col width="20%"><col width="10%"><col width="20%"><col width="20%">

<tr>
<td class="titolo1">IMPORTO TOTALE PAGATO:</td><td class="risposta1"><%=toHtml(pagamento.getRicevuta().getSingoloImportoPagato() ) %></td>
<td></td>
<td class="titolo1">ESITO:</td><td class="risposta1">Pagamento eseguito <%-- <%=pagamento.getRicevuta().getEsitoSingoloPagamento() %> --%></td> 
</tr>

<tr>
<td class="titolo1">CODICE CONTESTO:</td><td class="risposta1"><%=toHtml(pagamento.getRicevuta().getCodiceContestoPagamento()) %></td>
<td></td>
<td class="titolo1">DATA RICHIESTA: </td><td class="risposta1"><%=toHtml(toDateasStringFromString(pagamento.getRicevuta().getRiferimentoDataRichiesta())) %></td>
</tr>

<tr>
<td class="titolo1">ID UNIVOCO VERSAMENTO:</td><td class="risposta1"><%=toHtml(pagamento.getRicevuta().getIdUnivocoVersamento()) %></td>
<td></td>
<td class="titolo1">DATA RICEVUTA:</td><td class="risposta1"><%=toHtml(toDateasStringFromStringWithTime(pagamento.getRicevuta().getDataRicevuta())) %></td>
</tr>

<tr>
<td class="titolo1">DOMINIO ENTE:</td><td class="risposta1"><%=toHtml(pagamento.getRicevuta().getIdentificativoDominio()) %></td>
<td></td>
<td class="titolo1">IDENTIFICATIVO RICEVUTA:</td><td class="risposta1"><%=toHtml(pagamento.getRicevuta().getIdentificativoMessaggioRicevuta()) %></td>
</tr>

<tr>
<td class="titolo1">RIFERIMENTO RICHIESTA:</td><td class="risposta1"><%=toHtml(pagamento.getRicevuta().getRiferimentoMessaggioRichiesta()) %></td>
<td></td>
<td></td><td></td>
</tr>

</table>

<hr>

<table width="100%">
<col width="15%"><col width="15%"><col width="10%"><col width="5%">
<col width="10%">
<col width="15%"><col width="15%"><col width="10%"><col width="5%">
<tr>
<th colspan="4" class="header1">ENTE BENEFICIARIO</th>
<th></th>
<th colspan="4" class="header1">SOGGETTO INTESTATARIO</th>
</tr>

<tr>
<td class="titolo2">DENOMINAZIONE:</td>
<td class="risposta2" colspan="3"><%=toHtml(pagamento.getRicevuta().getDenominazioneBeneficiario() ) %></td>
<td></td>
<td class="titolo2">ANAGRAFICA:</td>
<td class="risposta2" colspan="3"><%=toHtml(pagamento.getRicevuta().getAnagraficaPagatore() ) %></td>
</tr>

<tr>
<td class="titolo2">TIPO:</td>
<td class="risposta2" colspan="3"><%=toHtml(pagamento.getRicevuta().getTipoBeneficiario() ) %></td>
<td></td>
<td class="titolo2">TIPO:</td>
<td class="risposta2" colspan="3"><%=toHtml(pagamento.getRicevuta().getTipoPagatore() ) %></td>
</tr>

<tr>
<td class="titolo2">CODICE UNIVOCO:</td>
<td class="risposta2" colspan="3"><%=toHtml(pagamento.getRicevuta().getCodiceUnivocoBeneficiario() ) %></td>
<td></td>
<td class="titolo2">CODICE UNIVOCO:</td>
<td class="risposta2" colspan="3"><%=toHtml(pagamento.getRicevuta().getCodiceUnivocoPagatore() ) %></td>
</tr>

<tr>
<td class="titolo2">NAZIONE:</td>
<td class="risposta2"><%=toHtml(pagamento.getRicevuta().getNazioneBeneficiario() ) %></td>
<td class="titolo2">PROVINCIA:</td>
<td class="risposta2"><%=toHtml(pagamento.getRicevuta().getProvinciaBeneficiario() ) %></td>
<td></td>
<td class="titolo2">EMAIL:</td>
<td class="risposta2" colspan="3"><%=toHtml(pagamento.getRicevuta().getEmailPagatore() ) %></td>
</tr>

<tr>
<td class="titolo2">LOCALITA':</td>
<td class="risposta2" colspan="3"><%=toHtml(pagamento.getRicevuta().getLocalitaBeneficiario() ) %></td>
<td></td>
<td class="titolo2">NAZIONE:</td>
<td class="risposta2"><%=toHtml(pagamento.getRicevuta().getNazionePagatore() ) %></td>
<td class="titolo2">PROVINCIA:</td><td class="risposta2"><%=toHtml(pagamento.getRicevuta().getProvinciaPagatore() ) %></td>
</tr>

<tr>
<td class="titolo2">INDIRIZZO:</td>
<td class="risposta2" colspan="3"><%= toHtml(pagamento.getRicevuta().getIndirizzoBeneficiario() ) %></td>
<td></td>
<td class="titolo2">LOCALITA':</td>
<td class="risposta2" colspan="3"><%= toHtml(pagamento.getRicevuta().getLocalitaPagatore() ) %></td>
</tr>

<tr>
<td class="titolo2">CIVICO:</td>
<td class="risposta2"><%= toHtml(pagamento.getRicevuta().getCivicoBeneficiario() ) %></td>
<td class="titolo2">CAP:</td>
<td class="risposta2"><%= toHtml(pagamento.getRicevuta().getCapBeneficiario() ) %></td>
<td></td>
<td class="titolo2">INDIRIZZO:</td>
<td class="risposta2" colspan="3"><%= toHtml(pagamento.getRicevuta().getIndirizzoPagatore() ) %></td>
</tr>

<tr>
<td class="titolo2">DENOMINAZIONE UNITA' OPERATIVA:</td>
<td class="risposta2" colspan="3"></td>
<td></td>
<td class="titolo2">CIVICO:</td>
<td class="risposta2"><%= toHtml(pagamento.getRicevuta().getCivicoPagatore() ) %></td>
<td class="titolo2">CAP:</td>
<td class="risposta2"><%= toHtml(pagamento.getRicevuta().getCapPagatore() ) %></td>
</tr>

<tr>
<td class="titolo2">CODICE UNITA' OPERATIVA:</td>
<td class="risposta2" colspan="3"></td>
<td></td>
<td class="titolo2"></td>
<td class="risposta2" colspan="3"></td>
</tr>

</table>

<table width="100%">
<col width="10%"><col width="20%"><col width="10%"><col width="5%">
<col width="10%">
<col width="10%"><col width="20%"><col width="10%"><col width="5%">
<tr>
<th colspan="4" class="header1">ISTITUTO ATTESTANTE</th>
<th></th>
<th colspan="4" class="header1">SOGGETTO VERSANTE</th>
</tr>

<tr>
<td class="titolo2">DENOMINAZIONE:</td>
<td class="risposta2" colspan="3"><%= toHtml(pagamento.getRicevuta().getDenominazioneAttestante() ) %></td>
<td></td>
<td class="titolo2">ANAGRAFICA:</td>
<td class="risposta2" colspan="3"></td>
</tr>

<tr>
<td class="titolo2">TIPO:</td>
<td class="risposta2" colspan="3"><%= toHtml(pagamento.getRicevuta().getTipoAttestante() ) %></td>
<td></td>
<td class="titolo2">TIPO:</td>
<td class="risposta2" colspan="3"></td>
</tr>

<tr>
<td class="titolo2">CODICE UNIVOCO:</td>
<td class="risposta2" colspan="3"><%= toHtml(pagamento.getRicevuta().getCodiceUnivocoAttestante() ) %></td>
<td></td>
<td class="titolo2">CODICE UNIVOCO:</td>
<td class="risposta2" colspan="3"></td>
</tr>

<tr>
<td class="titolo2">NAZIONE:</td>
<td class="risposta2"></td>
<td class="titolo2">PROVINCIA:</td>
<td class="risposta2"></td>
<td></td>
<td class="titolo2">EMAIL:</td>
<td class="risposta2" colspan="3"></td>
</tr>

<tr>
<td class="titolo2">LOCALITA':</td>
<td class="risposta2" colspan="3"></td>
<td></td>
<td class="titolo2">NAZIONE:</td>
<td class="risposta2"></td>
<td class="titolo2">PROVINCIA:</td><td class="risposta2"></td>
</tr>

<tr>
<td class="titolo2">INDIRIZZO:</td>
<td class="risposta2" colspan="3"></td>
<td></td>
<td class="titolo2">LOCALITA':</td>
<td class="risposta2" colspan="3"></td>
</tr>

<tr>
<td class="titolo2">CIVICO:</td>
<td class="risposta2"></td>
<td class="titolo2">CAP:</td>
<td class="risposta2"></td>
<td></td>
<td class="titolo2">INDIRIZZO:</td>
<td class="risposta2" colspan="3"></td>
</tr>

<tr>
<td class="titolo2">DENOMINAZIONE UNITA' OPERATIVA:</td>
<td class="risposta2" colspan="3"></td>
<td></td>
<td class="titolo2">CIVICO:</td>
<td class="risposta2"></td>
<td class="titolo2">CAP:</td>
<td class="risposta2"></td>
</tr>

<tr>
<td class="titolo2">CODICE UNITA' OPERATIVA:</td>
<td class="risposta2" colspan="3"></td>
<td></td>
<td class="titolo2"></td>
<td class="risposta2" colspan="3"></td>
</tr>

</table>

<hr>

<table width="100%" style="border: 1px solid black; border-collapse:collapse">

<tr><th colspan="4" class="header3" style="border: 1px solid black">DOVUTI PAGATI</th></tr>

<tr><td colspan="4"></td></tr>

<tr>
<th class="titolo3" style="border: 1px solid black">Id Univoco Dovuto</th>
<th class="titolo3" style="border: 1px solid black">Importo pagato</th>
<th class="titolo3" style="border: 1px solid black">Data pagamento</th>
<th class="titolo3" style="border: 1px solid black">Id Univoco Riscossione</th>
</tr>

<tr>
<td style="border: 1px solid black" class="risposta3"><%= toHtml(pagamento.getRicevuta().getIdUnivocoDovuto() ) %></td>
<td style="border: 1px solid black" class="risposta3"><%= toHtml(pagamento.getRicevuta().getSingoloImportoPagato() ) %></td>
<td style="border: 1px solid black" class="risposta3"><%= toHtml(toDateasStringFromString(pagamento.getRicevuta().getDataEsitoSingoloPagamento()) ) %></td>
<td style="border: 1px solid black" class="risposta3"><%= toHtml(pagamento.getRicevuta().getIdentificativoUnivocoRiscossione() ) %></td>
</tr>
</table>

<table width="100%" style="border: 1px solid black; border-collapse:collapse">
<tr>
<th class="titolo3" style="border: 1px solid black">Tipo dovuto</th>
<td style="border: 1px solid black" class="risposta3"><%= toHtml(pagamento.getIdentificativoTipoDovuto() ) %></td>
<th class="titolo3" style="border: 1px solid black">Dati Specifici Riscossione</th>
<th class="titolo3" style="border: 1px solid black">Commissioni</th>
</tr>

<tr>
<th class="titolo3" style="border: 1px solid black">Causale versamento</th>
<td style="border: 1px solid black" class="risposta3"><%= toHtml(pagamento.getRicevuta().getCausaleVersamento() ) %></td>
<td style="border: 1px solid black" class="risposta3"><%= toHtml(pagamento.getRicevuta().getDatiSpecificiRiscossione() ) %></td>
<td style="border: 1px solid black" class="risposta3"></td>
</tr>

</table>