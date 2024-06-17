
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@page import="org.aspcfs.modules.gestoriacquenew.base.*"%>
<%@page import="java.net.URLEncoder" %>
<%@page import="java.sql.Date" %>
<%@ include file="../utils23/initPage.jsp" %>
<script src="gestoriacquedirete/script.js"></script>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="GestoreAcque" class="org.aspcfs.modules.gestoriacquenew.base.GestoreAcque" scope="session" /> <!-- vuoto se non è stato trovato per l'user id quel gestore -->
<jsp:useBean id="PuntoPrelievoRichiesto" class="org.aspcfs.modules.gestoriacquenew.base.PuntoPrelievo" scope="request" />
<jsp:useBean id="ComuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CampionamentoChiList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipologiaPdpList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AmbitoPrelievoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="FinalitaPrelievoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="MotivoPrelievoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipologiaFonteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean scope="request" class="org.aspcfs.modules.gestoriacquenew.base.ControlloInterno" id="ControlloRichiesto" />

<head>

</head>
<body>

 	 <%int idPuntoPrelievo = PuntoPrelievoRichiesto.getId();
 	   String paramPerContainer = "idPuntoPrelievo="+idPuntoPrelievo;
 	   %>
	 <%if(GestoreAcque.getId() <= 0 && GestoreAcque.getId()!=-999) {%>
		<!-- non e' stato trovato gestore acque per l'user id dell'utente loggato -->
		<br>
		
		<br>
		<font color="red"> Attenzione, per l'utente <%=User.getUsername() %> non e' stato trovato un Gestore Acque Di Rete Associato</font>
	
	<%}
	  else 
	  {
	  
		  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  String etichettaStatoControllo = ControlloRichiesto.getStatusId() == 1 ? "<font size=\"4\" color=\"green\">&#x2713;</font> &nbsp;Aperto" : "<font size=\"4\" color=\"red\">&#x2715;</font> &nbsp;Chiuso";
	  %>
		
		<br>
		<br>
		<!-- e' stato trovato gestore acque per l'user id dell'utente loggato -->
		<center>
		<div style="max-width:1500px;">
		 	 <dhv:container name="puntodiprelievodetail_container" selected="Scheda Controlli Interni" object=""  param="<%=paramPerContainer %>">
			<table class="details" width="100%;">
				<tr><th colspan="2"><center>SCHEDA CONTROLLO GESTORE <%=PuntoPrelievoRichiesto.getNomeGestore()%></center></th></tr>
			    <tr><th style=" width:10%;"   align="left">PUNTO DI PRELIEVO</th><td align="left">&nbsp;&nbsp;<%= nullablePrint(PuntoPrelievoRichiesto.getDenominazione()) %></td></tr>
				<tr><th style=" width:10%;"   align="left">INDIRIZZO PUNTO DI PRELIEVO</th><td align="left">&nbsp;&nbsp;<%= nullablePrint(PuntoPrelievoRichiesto.getIndirizzo().getVia())%></td></tr>
				 <tr><th style=" width:10%;"   align="left">STATO CONTROLLO</th><td align="left">&nbsp;&nbsp;<%= etichettaStatoControllo %></td> </tr>
				 <tr><th style=" width:10%;"   align="left">A.S.L.</th><td align="left">&nbsp;&nbsp;<%=nullablePrint(ControlloRichiesto.getDescAsl()) %></td></tr>
			     <tr><th style=" width:10%;"   align="left">IDENTIFICATIVO</th><td align="left">&nbsp;&nbsp;<%=nullablePrint(ControlloRichiesto.getIdControlloUfficiale()+"") %></td></tr> <!-- uso la versione padded di id del ticket, nella proprieta del bean id controllo ufficiale -->
				 <tr><th style=" width:10%;"   align="left">TECNICA DEL CONTROLLO</th><td align="left">&nbsp;&nbsp;<%="Controllo Interno" %></td></tr>
				 <tr><th style=" width:10%;"   align="left">DATA PRELIEVO</th><td align="left">&nbsp;&nbsp;<%=ControlloRichiesto.getDataInizioControllo() != null ? sdf.format(new Date(ControlloRichiesto.getDataInizioControllo().getTime() )) : ""%></td></tr>		
		</table>		
				
		<% if (ControlloRichiesto.getTrizio()!=null) { %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left">ESITO</th><td align="left">&nbsp;&nbsp;<%=ControlloRichiesto.getEsito().equalsIgnoreCase("conforme") ? "<font color=\"green\">"+ControlloRichiesto.getEsito()+"</font>" : "<font color=\"red\">"+ControlloRichiesto.getEsito()+"</font>"   %></td></tr>
		<tr><th style=" width:10%;"   align="left">PARAMETRI NON CONFORMI</th><td align="left">&nbsp;&nbsp;<%=ControlloRichiesto.getNonConformita() != null ? ControlloRichiesto.getNonConformita() : ""   %></td></tr>
			</table>
			<br><br>
			<table class="details" width="100%;">
			
				<tr>
				 
				<th>ORA</th>
				<th>TRIZIO</th>
				<th>RADON</th>
				<th>DOSE INDICATIVA</th>
				<th>ALFA</th>
				<th>BETA</th>
				<th>NOTE</th>
				</tr>
				
				<tr >
				
					<%
						String checkTrue = "<font size=\"4\" color=\"green\">&#x2713;</font>" ;
					%>
					<td align="center"><%=printSafe(ControlloRichiesto.getOra())%></td>
					<td align="center"><%=printSafe(ControlloRichiesto.getTrizio())%></td>
					<td align="center"><%=printSafe(ControlloRichiesto.getRadon()) %></td>
					<td align="center"><%=printSafe(ControlloRichiesto.getDose()) %></td>
					<td align="center"><%=printSafe(ControlloRichiesto.getAlfa()) %></td>
					<td align="center"><%=printSafe(ControlloRichiesto.getBeta()) %></td>
					<td align="center"><%=printSafe(ControlloRichiesto.getNote()) %></td>
				</tr>
				
			</table>
	<% } else if (ControlloRichiesto.getCampione_finalitaMisura()!=null) {%>
	
		<br/><br/>
		
		<table class="details" width="100%;">
			<tr><th style=" width:10%;"   align="left" colspan="2">Codice Campione</th></tr>
			<tr>
				<th style=" width:10%;"   align="left">ID UNIVOCO CAMPIONE</th>
				<th style=" width:10%;"   align="left">Codice Interno Laboratorio di Misura</th>
			</tr>
			<tr>
				<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getIdUnivocoCampione())%></td>
				<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getCodiceInternoLab())%></td>
			</tr>
		</table>
		<br>
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="3">Zona di fornitura (ZdF)</th></tr>
		<tr>
		<th style=" width:10%;"   align="left">ID ZONA DI FORNITURA</th>
		<th style=" width:10%;"   align="left">DENOMINAZIONE DELLA ZONA DI FORNITURA</th>
		<th style=" width:10%;"   align="left">GESTORE ZONA DI FORNITURA</th>
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getCodicePuntoPrelievo())%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getFornitura_denominazioneZona() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getFornitura_denominazioneGestore() )%></td>
		</tr>
		</table>
		<br>
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="5">Finalita' generali e motivi specifici del prelievo</th></tr>
			<tr>
				<th style=" width:10%;"   align="left">Ambito Prelievo</th>
				<th style=" width:10%;"   align="left">Finalita' Generali del Prelievo</th>
				<th style=" width:10%;"   align="left">Nota sulle finalita'</th>
				<th style=" width:10%;"   align="left">Motivo specifico del prelievo</th>
				<th style=" width:10%;"   align="left">Nota sul motivo del prelievo</th>
			</tr>
			<tr>
				<td align="left">&nbsp;&nbsp;<%=printSafe(AmbitoPrelievoList.getSelectedValue(ControlloRichiesto.getAmbitoPrelievo()))%></td>
				<td align="left">&nbsp;&nbsp;<%=printSafe(FinalitaPrelievoList.getSelectedValue(ControlloRichiesto.getCampione_finalitaMisura()))%></td>
				<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getCampione_notaFinalitaMisura())%></td>
				<td align="left">&nbsp;&nbsp;<%=printSafe(MotivoPrelievoList.getSelectedValue(ControlloRichiesto.getCampione_motivoPrelievo()))%></td>
				<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getCampione_notaMotivoPrelievo())%></td>
			</tr>
		</table>
		<br>
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="2">Dati Prelievo</th></tr>
		<tr>
			<th style=" width:10%;"   align="left">Chi ha effettuato il prelievo</th>
			<th style=" width:10%;"   align="left">Data Prelievo</th>
		</tr>
		<tr>
			<td align="left">&nbsp;&nbsp;<%=printSafe(CampionamentoChiList.getSelectedValue(ControlloRichiesto.getCampionamento_chi()))%></td>
			<td align="left">&nbsp;&nbsp;<%=ControlloRichiesto.getDataInizioControllo() != null ? sdf.format(new Date(ControlloRichiesto.getDataInizioControllo().getTime() )) : ""%></td>
		</tr>
		</table>
		<br>
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="4">Dati sul Punto di Prelievo</th></tr>
		<tr>
			<th style=" width:10%;"   align="left">Numero di punti di prelievo per ZdF</th>
			<th style=" width:10%;"   align="left">Numero progressivo del punto di prelievo</th>
			<th style=" width:10%;"   align="left">Numero di prelievi effettuati all'anno (per il punto di prelievo in esame)</th>
			<th style=" width:10%;"   align="left">Numero progressivo del prelievo effettuato nel corso dell'anno</th>
		</tr>
		<tr>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getNumeroPuntiPrelievo())%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getNumeroProgressivoPuntoPrelievo())%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getCampionamento_numeroPrelievi())%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getNumeroProgressivoPrelievoEffettuatoAnno())%></td>
		</tr>
		</table>
		<br>
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="3">Altre informazioni sul Punto di Prelievo</th></tr>
		<tr>
			<th style=" width:10%;"   align="left">Tipologia del punto di prelievo</th>
			<th style=" width:10%;"   align="left">Codice del punto di prelievo</th>
			<th style=" width:10%;"   align="left">Tipologia delle fonti</th>
		</tr>
		<tr>
			<td align="left">&nbsp;&nbsp;<%=printSafe(TipologiaPdpList.getSelectedValue(ControlloRichiesto.getTipologiaPuntoPrelievo()))%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(PuntoPrelievoRichiesto.getCodiceGisa() )%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(TipologiaFonteList.getSelectedValue(ControlloRichiesto.getPunto_tipoAcqua()))%></td>
		</tr>
		</table>
		<table class="details" width="100%;">
		<tr>
			<th style=" width:10%;"   align="left">Comune del punto di prelievo</th>
			<th style=" width:10%;"   align="left">Indirizzo</th>
			<th style=" width:10%;"   align="left">Coordinate geografiche (latitudine)</th>
			<th style=" width:10%;"   align="left">Coordinate geografiche (longitudine)</th>
		</tr>
		<tr>
			<td align="left">&nbsp;&nbsp;<%=ControlloRichiesto.getComunePuntoPrelievo() != null ? ComuniList.getSelectedValue(ControlloRichiesto.getComunePuntoPrelievo()) : ""%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getIndirizzoPuntoPrelievo())%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getCoordinateLatitudine())%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getCoordinateLongitudine())%></td>
		</tr>
		</table>
		
		<br/>
		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="6">Risultati misurazioni x la Dose Indicativa (DI):  screening basato sulla misura della concentrazione di attivita' alfa totale</th></tr>
		<tr>
		<th style=" width:10%;"   align="left">ATTIVITA' ALFA TOTALE (Bq/L) MAR</th>
		<th style=" width:10%;"   align="left">ATTIVITA' ALFA TOTALE (Bq/L) Risultato della misura</th>
		<th style=" width:10%;"   align="left">INCERTEZZA SULL'ATTIVITA' ALFA TOTALE (Bq/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_alfaTotaleMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_alfaTotaleMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_alfaTotaleIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_alfaTotaleDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_alfaTotaleLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_alfaTotaleMetodoProva() )%></td>
		</tr>
		</table>
		<br>
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="6">Risultati misurazioni x la Dose Indicativa (DI):  screening basato sulla misura della concentrazione di attivita' beta totale</th></tr>
		<tr>
		<th style=" width:10%;"   align="left">ATTIVITA' BETA TOTALE (Bq/L) MAR</th>
		<th style=" width:10%;"   align="left">ATTIVITA' BETA TOTALE (Bq/L) Risultato della misura</th>
		<th style=" width:10%;"   align="left">INCERTEZZA SULL'ATTIVITA' BETA TOTALE (Bq/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaTotaleMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaTotaleMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaTotaleIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaTotaleDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaTotaleLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaTotaleMetodoProva() )%></td>
		</tr>
		</table>
		<br>
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="8">Risultati misurazioni x la Dose Indicativa (DI): risultati della misura della concentrazione di K-40 per screening basato sulla determinazione della concentrazione di attivita' beta residua</th></tr>
		<tr>
		<th style=" width:10%;"   align="left">ATTIVITA' K-40 BETA RESIDUA (Bq/L) MAR</th>
		<th style=" width:10%;"   align="left">ATTIVITA' K-40 BETA RESIDUA (Bq/L) Risultato della misura</th>
		<th style=" width:10%;"   align="left">INCERTEZZA SULL'ATTIVITA' K-40 BETA RESIDUA (Bq/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">ATTIVITA' BETA RESIDUA VALORE DETERMINATO (Bq/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA SULL'ATTIVITA' BETA RESIDUA (Bq/L)</th>
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaResiduaMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaResiduaMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaResiduaIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaResiduaDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaResiduaLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaResiduaMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaResiduoValoreDeterminato() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_betaResiduoIncertezza() )%></td>
		</tr>
		
		</table>
		
		<br/>
		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="6">Controllo della concentrazione di attivita' di radon</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">CONCENTRAZIONE di 222RN (Bq/l) MAR</th>
		<th style=" width:10%;"   align="left">CONCENTRAZIONE di 222RN (Bq/l) Risultato</th>
		<th style=" width:10%;"   align="left">INCERTEZZA SULLA CONCENTRAZIONE di 222RN (Bq/l)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadon_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadon_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadon_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadon_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadon_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadon_concentrazioneMetodoProva() )%></td>
		</tr>
		</table>
		
		<br/>
		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="6">Controllo della concentrazione di attivita' di Trizio</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">CONCENTRAZIONE di 3H (Bq/l) MAR</th>
		<th style=" width:10%;"   align="left">CONCENTRAZIONE di 3H (Bq/l) Risultato</th>
		<th style=" width:10%;"   align="left">INCERTEZZA SULLA CONCENTRAZIONE di 3H (Bq/l)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getTrizio_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getTrizio_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getTrizio_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getTrizio_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getTrizio_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getTrizio_concentrazioneMetodoProva() )%></td>
		</tr>
		</table>
		
		<br/>
		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="1">Note Complessive</th></tr>
		<tr><td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getCampioneNote())%></td></tr>
		</table>
		
		<br>
		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="3">Formule di controllo relative a eventuali superamenti dei livelli di screening</th></tr>
		<tr>
			<th style=" width:10%;"   align="left">Conc. di attività alfa-totale Superato il livello di screening (=0.1 Bq/L)?</th>
			<th style=" width:10%;"   align="left">Conc. di attività beta-totale Superato il livello di screening (=0.5 Bq/L)?</th>
			<th style=" width:10%;"   align="left">Conc. di attività beta-residua Superato il livello di 0.2 Bq/L?</th>
		</tr>
		<tr>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getAlfaTotale_superato() )%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getBetaTotale_superato() )%></td>
			<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getBetaResidua_superato() )%></td>
		</tr>		
		</table>
		<br>
		
		<% if(ControlloRichiesto.getRadio226_concentrazioneMar() != null && !ControlloRichiesto.getRadio226_concentrazioneMar().equals("")){ %>
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="7">Misura del radio-226</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">MAR (BQ/L)</th>
		<th style=" width:10%;"   align="left">VALORE MISURATO (BQ/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA (BQ/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">Rapporto tra conc. misurata e conc. derivata</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio226_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio226_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio226_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio226_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio226_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio226_concentrazioneMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio226_concentrazioneRapporto() )%></td>
		</tr>
		</table>
			
		<% } %>
		
		<% if(ControlloRichiesto.getRadio228_concentrazioneMar() != null  && !ControlloRichiesto.getRadio228_concentrazioneMar().equals("")){ %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="7">Misura del radio-228</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">MAR (BQ/L)</th>
		<th style=" width:10%;"   align="left">VALORE MISURATO (BQ/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA (BQ/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">Rapporto tra conc. misurata e conc. derivata</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio228_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio228_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio228_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio228_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio228_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio228_concentrazioneMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadio228_concentrazioneRapporto() )%></td>
		</tr>
		</table>
			
		<% } %>
		
		<% if(ControlloRichiesto.getUranio234_concentrazioneMar() != null  && !ControlloRichiesto.getUranio234_concentrazioneMar().equals("")){ %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="7">Misura dell'uranio-234</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">MAR (BQ/L)</th>
		<th style=" width:10%;"   align="left">VALORE MISURATO (BQ/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA (BQ/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">Rapporto tra conc. misurata e conc. derivata</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getUranio234_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getUranio234_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getUranio234_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getUranio234_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getUranio234_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getUranio234_concentrazioneMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getUranio234_concentrazioneRapporto() )%></td>
		</tr>
		</table>
			
		<% } %>
		
		<% if(ControlloRichiesto.getPiombo210_concentrazioneMar() != null  && !ControlloRichiesto.getPiombo210_concentrazioneMar().equals("")){ %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="7">Misura del piombo-210</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">MAR (BQ/L)</th>
		<th style=" width:10%;"   align="left">VALORE MISURATO (BQ/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA (BQ/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">Rapporto tra conc. misurata e conc. derivata</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPiombo210_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPiombo210_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPiombo210_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPiombo210_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPiombo210_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPiombo210_concentrazioneMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPiombo210_concentrazioneRapporto() )%></td>
		</tr>
		</table>
			
		<% } %>
		
		<% if(ControlloRichiesto.getPolonio210_concentrazioneMar() != null  && !ControlloRichiesto.getPolonio210_concentrazioneMar().equals("")){ %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="7">Misura del Polonio-210</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">MAR (BQ/L)</th>
		<th style=" width:10%;"   align="left">VALORE MISURATO (BQ/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA (BQ/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">Rapporto tra conc. misurata e conc. derivata</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPolonio210_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPolonio210_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPolonio210_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPolonio210_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPolonio210_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPolonio210_concentrazioneMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getPolonio210_concentrazioneRapporto() )%></td>
		</tr>
		</table>
			
		<% } %>
		
		<% if(ControlloRichiesto.getRadionuclide1_concentrazioneSimbolo() != null  && !ControlloRichiesto.getRadionuclide1_concentrazioneSimbolo().equals("")){ %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="9">Misura della concentrazione di attivita' di altro radionuclide 1</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">SIMBOLO</th>
		<th style=" width:10%;"   align="left">MAR (BQ/L)</th>
		<th style=" width:10%;"   align="left">VALORE MISURATO (BQ/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA (BQ/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">CONCENTRAZIONE DERIVATA</th>
		<th style=" width:10%;"   align="left">Rapporto tra conc. misurata e conc. derivata</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneSimbolo() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneDerivata() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide1_concentrazioneRapporto() )%></td>
		</tr>
		</table>
			
		<% } %>
		
		<% if(ControlloRichiesto.getRadionuclide2_concentrazioneSimbolo() != null  && !ControlloRichiesto.getRadionuclide2_concentrazioneSimbolo().equals("")){ %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="9">Misura della concentrazione di attivita' di altro radionuclide 2</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">SIMBOLO</th>
		<th style=" width:10%;"   align="left">MAR (BQ/L)</th>
		<th style=" width:10%;"   align="left">VALORE MISURATO (BQ/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA (BQ/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">CONCENTRAZIONE DERIVATA</th>
		<th style=" width:10%;"   align="left">Rapporto tra conc. misurata e conc. derivata</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneSimbolo() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneDerivata() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide2_concentrazioneRapporto() )%></td>
		</tr>
		</table>
			
		<% } %>
		
		<% if(ControlloRichiesto.getRadionuclide3_concentrazioneSimbolo() != null  && !ControlloRichiesto.getRadionuclide3_concentrazioneSimbolo().equals("")){ %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="9">Misura della concentrazione di attivita' di altro radionuclide 3</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">SIMBOLO</th>
		<th style=" width:10%;"   align="left">MAR (BQ/L)</th>
		<th style=" width:10%;"   align="left">VALORE MISURATO (BQ/L)</th>
		<th style=" width:10%;"   align="left">INCERTEZZA (BQ/L)</th>
		<th style=" width:10%;"   align="left">DATA DELLA MISURA</th>
		<th style=" width:10%;"   align="left">LABORATORIO CHE HA EFFETTUATO LA MISURA</th>
		<th style=" width:10%;"   align="left">METODO DI PROVA UTILIZZATO</th>
		<th style=" width:10%;"   align="left">CONCENTRAZIONE DERIVATA</th>
		<th style=" width:10%;"   align="left">Rapporto tra conc. misurata e conc. derivata</th>
		
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneSimbolo() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneMar() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneIncertezza() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneDataMisura() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneLaboratorio() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneMetodoProva() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneDerivata() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRadionuclide3_concentrazioneRapporto() )%></td>
		</tr>
		</table>
			
		<% } %>
		
		<% if(ControlloRichiesto.getDI_MSV_Inferiore() != null  && !ControlloRichiesto.getDI_MSV_Inferiore().equals("")){ %>		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="2">Dose indicativa</th></tr>
		
		<tr>
		<th style=" width:10%;"   align="left">Limite inferiore</th>
		<th style=" width:10%;"   align="left">Limite superiore</th>
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_MSV_Inferiore() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getDI_MSV_Superiore() )%></td>
		</tr>
		<tr><th style=" width:10%;"   align="left" colspan="9">Rapporto tra conc. misurata e conc. derivata</th></tr>
		<tr>
		<th style=" width:10%;"   align="left">Ra-226</th>
		<th style=" width:10%;"   align="left">Ra-228</th>
		<th style=" width:10%;"   align="left">U-234</th>
		<th style=" width:10%;"   align="left">U-238</th>
		<th style=" width:10%;"   align="left">Pb-210</th>
		<th style=" width:10%;"   align="left">Po-210</th>
		<th style=" width:10%;"   align="left">Radionucl.1</th>
		<th style=" width:10%;"   align="left">Radionucl.2</th>
		<th style=" width:10%;"   align="left">Radionucl.3</th>
		</tr>
		<tr>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoRa226() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoRa228() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoU234() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoU238() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoPb210() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoPo210() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoRN1() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoRN2() )%></td>
		<td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getRapportoRN3() )%></td>
		</tr>

		</table>
		
		<table class="details" width="100%;">
		<tr><th style=" width:10%;"   align="left" colspan="1">Note dato approfondimento</th></tr>
		<tr><td align="left">&nbsp;&nbsp;<%=printSafe(ControlloRichiesto.getApprofondimentoNote())%></td></tr>
		</table>	
			
		<% } %>
		
		<% } %>
	 		</dhv:container>
		</div>
		</center>
	
	<%} %>
	 

   <%! public String printSafe(String toPrint)
      {
      	if(toPrint == null )
      	{
      		toPrint = "";
      	}
      	return toPrint;
      	
      }%>

		 

</body>
</html>