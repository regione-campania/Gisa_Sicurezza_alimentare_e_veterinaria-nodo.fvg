<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>

<%@page import="java.util.Vector"%>
<%@page import="org.aspcfs.modules.devdoc.base.Flusso"%>
<%@page import="org.aspcfs.modules.devdoc.base.FlussoNota"%>
<%@page import="org.aspcfs.modules.devdoc.base.Modulo"%>
<%@page import="org.aspcfs.modules.devdoc.base.ModuloList"%>
<%@page import="org.aspcfs.modules.devdoc.base.FlussoStato"%>

<jsp:useBean id="Flusso" class="org.aspcfs.modules.devdoc.base.Flusso"
	scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />


<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>

<%@page
	import="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoModulo"%>
<%@page
	import="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoModuloList"%>
<jsp:useBean id="listaAllegati"
	class="org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoModuloList"
	scope="request" />

<jsp:useBean id="listaTipiPriorita"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="listaReferenti" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="listaStati" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="listaStatiModifica" class="org.aspcfs.utils.web.LookupList" scope="request" />


<%
java.time.LocalDate dateObj = java.time.LocalDate.now();
java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
String todayDate = dateObj.format(formatter);

%>

<%!public static String fixData(String timestring) {
		String toRet = "";
		if (timestring == null || timestring.equals("null"))
			return toRet;
		String anno = timestring.substring(0, 4);
		String mese = timestring.substring(5, 7);
		String giorno = timestring.substring(8, 10);
		String ora = timestring.substring(11, 13);
		String minuto = timestring.substring(14, 16);
		String secondi = timestring.substring(17, 19);
		toRet = giorno + "/" + mese + "/" + anno + " " + ora + ":" + minuto;
		return toRet;

	}%>
<%!public static String fixStringa(String nome) {
		String toRet = nome;
		if (nome == null || nome.equals("null"))
			return toRet;
		toRet = nome.replaceAll("'", "");
		toRet = toRet.replaceAll(" ", "_");
		toRet = toRet.replaceAll("\\?", "");

		return toRet;

	}

	public static String zeroPad(int id) {
		String toRet = String.valueOf(id);
		while (toRet.length() < 3)
			toRet = "0" + toRet;
		return toRet;

	}%>



<%@ include file="../utils23/initPage.jsp"%>


<table class="trails" cellspacing="0">
	<tr>
		<td><a href="GestioneFlussoSviluppo.do?command=Dashboard">Richiesta
				documentale sviluppo software</a> > Dettaglio Richiesta</td>
	</tr>
</table>

<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong>Informazioni Richiesta</strong></th>
	</tr>

	<tr class="containerBody">
		<td nowrap class="formLabel">Richiesta</td>
		<td><%=zeroPad(Flusso.getIdFlusso())%>&nbsp;</td>
	</tr>



	<tr class="containerBody">
		<td nowrap class="formLabel">Descrizione</td>
		<td><%=Flusso.getDescrizione()%>&nbsp;</td>
	</tr>

	<tr class="containerBody">
		<td nowrap class="formLabel">Referente</td>
		<td>
		
		<%=listaReferenti.getSelectedValue(Flusso.getIdReferente()) %>
		
		<dhv:permission	name="devdoc-referente-view">
		<% if (Flusso.getIdStato() != Flusso.STATO_CONSEGNATO && Flusso.getIdStato() != Flusso.STATO_COLLAUDATO) { %>
		<a href="#" id="bottoneModificaReferente" onClick="document.getElementById('divModificaReferente').style.display='table-row'; this.style.display='none'; return false; ">Modifica</a>
		<%} %>
		</dhv:permission>
		
		<div id="divModificaReferente" style="display:none">
		<form id="update-referente-form" method="post"
				action="GestioneFlussoSviluppo.do?command=UpdateReferente&idFlusso=<%=Flusso.getIdFlusso()%>">
				<%=listaReferenti.getHtmlSelect("idReferente", Flusso.getIdReferente())%>&nbsp;
				
				<a href="#" onClick="document.getElementById('divModificaReferente').style.display='none'; document.getElementById('bottoneModificaReferente').style.display='block'; return false; ">ANNULLA</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="submit">SALVA REFERENTE</button>
			</form>
		</div>	
		&nbsp;</td>
	</tr>
	
	<tr class="containerBody">
		<td nowrap class="formLabel">Ambito</td>
		<td><%=Flusso.getAmbito()%>
			&nbsp;</td>
	</tr>
	
	
	
	<tr class="containerBody">
		<td nowrap class="formLabel">Priorita'</td>
		<td>
		<%=listaTipiPriorita.getSelectedValue(Flusso.getIdPriorita())%>
		
		<dhv:permission	name="devdoc-priorita-view">
		<% if (Flusso.getIdStato() != Flusso.STATO_CONSEGNATO && Flusso.getIdStato() != Flusso.STATO_COLLAUDATO) { %>
		<a href="#" id="bottoneModificaPriorita" onClick="document.getElementById('divModificaPriorita').style.display='table-row'; this.style.display='none'; return false; ">Modifica</a>
		<%} %>
		</dhv:permission>
		
		<div id="divModificaPriorita" style="display:none">
		<form id="update-priorita-form" method="post"
				action="GestioneFlussoSviluppo.do?command=UpdatePriorita&idFlusso=<%=Flusso.getIdFlusso()%>">
				<%=listaTipiPriorita.getHtmlSelect("idPriorita", Flusso.getIdPriorita())%>&nbsp;
				
				<a href="#" onClick="document.getElementById('divModificaPriorita').style.display='none'; document.getElementById('bottoneModificaPriorita').style.display='block'; return false; ">ANNULLA</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="submit">SALVA PRIORITA</button>
			</form> 
 	</div>
		</td>
	</tr>
	
	<tr class="containerBody">
		<td nowrap class="formLabel">Stato</td>
		<td><%=listaStati.getSelectedValue(Flusso.getIdStato())%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		
		<%if (listaStatiModifica.size()>0){ %>
		<a href="#" id="bottoneModificaStato" onClick="document.getElementById('divModificaStato').style.display='table-row'; this.style.display='none'; return false; ">Modifica</a>
		<%} %>
		
		
		<% listaStatiModifica.setRequired(true); %>
		
		<div id="divModificaStato" style="display:none">
		<form id="update-stato-form" method="post"
				action="GestioneFlussoSviluppo.do?command=UpdateStato&idFlusso=<%=Flusso.getIdFlusso()%>">
						<b>Nuovo stato:</b>	<%=listaStatiModifica.getHtmlSelect("idStato", -1) %> &nbsp; &nbsp; &nbsp; 
						<b>Data:</b> <input type="date" id="dataCambioStato" name="dataCambioStato" required max="<%=todayDate%>"/>
						<br/>
						<textarea cols="70" rows="3" id="noteCambioStato" name="noteCambioStato" required placeholder="Note"></textarea><br/>
						
						<a href="#" onClick="document.getElementById('divModificaStato').style.display='none'; document.getElementById('bottoneModificaStato').style.display='block'; return false; ">ANNULLA</a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="submit">SALVA STATO</button>
			</form> 
		</div>
		
		</td>
	</tr>

	<tr class="containerBody">
		<td nowrap class="formLabel">Tags</td>
		<td><%=toHtml(Flusso.getTags())%>&nbsp;</td>
	</tr>

	<tr class="containerBody">
		<td nowrap class="formLabel">Data ultima modifica</td>
		<td><%=(Flusso.getData() != null) ? toDateWithTimeasString(Flusso.getData()) : ""%>&nbsp;
		</td>
	</tr>	

	<tr class="containerBody">
		<td nowrap class="formLabel">Giornate stimate (effort)</td>
		<td><%=(Flusso.getGiornateEffort() != 0) ? Flusso.getGiornateEffort() : ""%>&nbsp;
		</td>
	</tr>	
	
	<tr class="containerBody">
		<td nowrap class="formLabel">Giornate stimate (elapsed)</td>
		<td><%=(Flusso.getGiornateElapsed() != 0) ? Flusso.getGiornateElapsed() : ""%>&nbsp;
		</td>
	</tr>

	<tr class="containerBody">
		<td nowrap class="formLabel">Data inizio sviluppo</td>
		<td><%=(Flusso.getDataInizioSviluppo() != null) ? toDateasStringFromString(Flusso.getDataInizioSviluppo()) : ""%>&nbsp;
		</td>
	</tr>	

<tr class="containerBody">
		<td nowrap class="formLabel">Data previsto collaudo</td>
		<td><%=(Flusso.getDataPrevistaCollaudo() != null) ? toDateasStringFromString(Flusso.getDataPrevistaCollaudo()) : ""%>&nbsp;
		</td>
	</tr>	

</table>

<br />

<form id="form-aggiungi-stato" name="form-aggiungi-stato" method="post"
	action="GestioneFlussoSviluppo.do?command=ModificaStato&idFlusso=<%=Flusso.getIdFlusso()%>"
	onsubmit="checkFormStato(event)">
	<table class="details" cellpadding="4" cellspacing="4" width="100%">
		<thead>
			<tr>
				<th colspan="5">STORICO STATI</th>
			</tr>
			
			<tr>
				<th>STATO</th>
				<th>UTENTE</th>
				<th>DATA CAMBIO STATO</th>
				<th>NOTE</th>
				<th>DATA OPERAZIONE</th>
				
			</tr>
			
		</thead>
		<tbody>
			
			<%
				for (FlussoStato stato : Flusso.getStati()) {
			%>
			<tr>
				<td><%=listaStati.getSelectedValue(stato.getIdStato())%></td>
				<td><dhv:username id="<%=stato.getIdUtente()%>" /></td>
				<td><%=toDateasStringFromString(stato.getData())%></td>
				<td><%=stato.getNote()%></td>
				<td><%=toDateasStringWitTime(stato.getEntered())%></td>
			</tr>
			<%
				}
			%>
			
		</tbody>
		
	</table>
</form>

<br/>

	<table class="details" cellpadding="4" cellspacing="4" width="100%">
	<tr>
		<th colspan="4"><strong>Moduli</strong></th>
	</tr>

	<tr>
		<th><strong>Tipo</strong></th>
		<th><strong>Caricato da</strong></th>
		<th><strong>Caricato il</strong></th>
		<th><strong>Dettaglio</strong></th>
	</tr>

	<%
		ModuloList listaModuli = Flusso.getModuli();

		Modulo modB = null;
		Modulo modC = null;
		Modulo modCH = null;
		Modulo modD = null;
		Modulo modA = null;
		Modulo modVCE = null;

		for (int k = 0; k < listaModuli.size(); k++) {
			Modulo mod = (Modulo) listaModuli.get(k);
			switch (mod.getIdTipo()) {
			case 1:
				modB = mod;
				break;
			case 2:
				modC = mod;
				break;
			case 3:
				modD = mod;
				break;
			case 4:
				modCH = mod;
				break;
			case 5:
				modA = mod;
				break;
			case 6:
				modVCE = mod;
				break;
			default:
				break;
			}
		}
	%>

	<dhv:permission name="devdoc-mod-a-view">
		<%
			if (modA != null) {
		%>
		<tr>
			<td>Modulo A</td>
			<td><dhv:username id="<%=modA.getIdUtente()%>" /></td>
			<td><%=toDateasString(modA.getData())%></td>
			<td><a href="#"
				onClick="apriDettaglioModulo('<%=modA.getId()%>'); return false;">Visualizza</a></td>
		</tr>
		<%
			}
		%>
	</dhv:permission>
	<dhv:permission name="devdoc-mod-b-view">
		<%
			if (modB != null) {
		%>
		<tr>
			<td>Modulo B</td>
			<td><dhv:username id="<%=modB.getIdUtente()%>" /></td>
			<td><%=toDateasString(modB.getData())%></td>
			<td><a href="#"
				onClick="apriDettaglioModulo('<%=modB.getId()%>'); return false;">Visualizza</a></td>
		</tr>
		<%
			}
		%>
	</dhv:permission>
	<dhv:permission name="devdoc-mod-c-view">
		<%
			if (modC != null) {
		%>
		<tr>
			<td>Modulo C</td>
			<td><dhv:username id="<%=modC.getIdUtente()%>" /></td>
			<td><%=toDateasString(modC.getData())%></td>
			<td><a href="#"
				onClick="apriDettaglioModulo('<%=modC.getId()%>'); return false;">Visualizza</a></td>
		</tr>
		<%
			}
		%>
	</dhv:permission>
	<dhv:permission name="devdoc-mod-ch-view">
		<%
			if (modCH != null) {
		%>
		<tr>
			<td>Modulo CH</td>
			<td><dhv:username id="<%=modCH.getIdUtente()%>" /></td>
			<td><%=toDateasString(modCH.getData())%></td>
			<td><a href="#"
				onClick="apriDettaglioModulo('<%=modCH.getId()%>'); return false;">Visualizza</a></td>
		</tr>
		<%
			}
		%>
	</dhv:permission>
	<dhv:permission name="devdoc-mod-d-view">
		<%
			if (modD != null) {
		%>
		<tr>
			<td>Modulo D</td>
			<td><dhv:username id="<%=modD.getIdUtente()%>" /></td>
			<td><%=toDateasString(modD.getData())%></td>
			<td><a href="#"
				onClick="apriDettaglioModulo('<%=modD.getId()%>'); return false;">Visualizza</a></td>
		</tr>
		<%
			}
		%>
	</dhv:permission>
	<dhv:permission name="devdoc-vce-view">
		<%
			if (modVCE != null) {
		%>
		<tr>
			<td>Modulo VCE</td>
			<td><dhv:username id="<%=modVCE.getIdUtente()%>" /></td>
			<td><%=toDateasString(modVCE.getData())%></td>
			<td><a href="#"
				onClick="apriDettaglioModulo('<%=modVCE.getId()%>'); return false;">Visualizza</a></td>
		</tr>
		<%
			}
		%>
	</dhv:permission>
</table>
<br>
<br>
<form id="form-aggiungi-nota" name="form-aggiungi-nota" method="post"
	action="GestioneFlussoSviluppo.do?command=AggiungiNota&idFlusso=<%=Flusso.getIdFlusso()%>"
	onsubmit="checkFormNoteFlusso(event)">
	<table class="details" cellpadding="4" cellspacing="4" width="100%">
		<thead>
			<tr>
				<th colspan="3">NOTE</th>
			</tr>
			<%
				if (!Flusso.getNote().isEmpty()) {
			%>
			<tr>
				<th>NOTA</th>
				<th>INSERITA DA</th>
				<th>INSERITA IL</th>
			</tr>
			<%
				}
			%>
		</thead>
		<tbody>
			<%
				if (!Flusso.getNote().isEmpty()) {
			%>
			<%
				for (FlussoNota nota : Flusso.getNote()) {
			%>
			<tr>
				<td><%=nota.getNota()%></td>
				<td><dhv:username id="<%=nota.getIdUtente()%>" /></td>
				<td><%=toDateasStringWitTime(nota.getDataInserimento())%></td>
			</tr>
			<%
				}
			%>
			<%
				}
			%>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3"><textarea id="nuova-nota" name="nuova-nota"
						required style="width: 100%;"></textarea><br/>
						<button type="submit">INSERISCI NOTA</button></td>
			</tr>
		</tfoot>
	</table>
</form>
