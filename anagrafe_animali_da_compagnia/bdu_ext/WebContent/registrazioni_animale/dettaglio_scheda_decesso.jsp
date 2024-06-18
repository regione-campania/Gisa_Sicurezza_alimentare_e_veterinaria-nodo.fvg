<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso"%>
<jsp:useBean id="specieList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script>
<jsp:useBean id="actionFrom" class="java.lang.String" scope="request" />

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="razzaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="mantelloList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tagliaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="causeDecessoList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="neoplasieList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="diagnosiIstologicheList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="animale" class="org.aspcfs.modules.anagrafe_animali.base.Animale"	scope="request" />
<jsp:useBean id="diagnosiCitologiche" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="diagnosiIstologicheTumorali" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipoDiagnosiIstologiche" class="org.aspcfs.utils.web.LookupList" scope="request" />



<%
		SchedaDecesso scheda = ((SchedaDecesso)request.getAttribute("scheda"));
%>

<%
String param1 = "params=&idAnimale=" + animale.getIdAnimale() + "&idSchedaDecesso=" + scheda.getId() + "&idSpecie=" + animale.getIdSpecie() + "&folderId=-1&parentId=-1&messaggioPost=&pag=null&pagTot=0&pagine=&def=true";
%>

<input type="hidden" name="idAnimale" value="<%=animale.getIdAnimale()%>" />
<input type="hidden" name="id" value="<%=scheda.getId()%>" />

<dhv:container name="scheda_decesso" selected="details"
		object="scheda" param="<%=param1%>"
		appendToUrl='<%=addLinkParams(request, "popup|popupType|actionId")%>'>

<dhv:evaluate if="<%=User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))%>">
		<table class="trails" cellspacing="0">
			<tr>
				<td width="100%">
							<a href="AnimaleAction.do"><dhv:label name="">Animale</dhv:label></a> > 
							<a href="AnimaleAction.do?command=Details&animaleId=<%=scheda.getAnimale().getIdAnimale()%>&idSpecie=<%=scheda.getAnimale().getIdSpecie()%>"><dhv:label name="">Dettagli animale</dhv:label></a> >
							Scheda decesso
					</td>
							
			</tr>
		</table>
		<%-- End Trails --%>
	</dhv:evaluate>
	
	
	
	


<%@ include file="../initPage.jsp"%>
	
		
		<table cellpadding="2" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Anagrafica animale</dhv:label></strong>
		</th>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Microchip</dhv:label></td>
		<td><%=scheda.getAnimale().getMicrochip()%>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Specie</dhv:label></td>
		<td id="specie"><%=specieList.getSelectedValue(scheda.getAnimale().getIdSpecie())%>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Razza</dhv:label></td>
		<td id="razza"><%=toHtml(razzaList.getSelectedValue(scheda.getAnimale().getIdRazza()))%>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Data nascita</dhv:label></td>
		<td id="datanascita"><%=toHtmlValue(toDateasString(scheda.getAnimale().getDataNascita()))%>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Sesso</dhv:label></td>
		<td id="sesso"><%=(scheda.getAnimale().getSesso() != null && !("").equals(scheda.getAnimale().getSesso())) ? toHtml(scheda.getAnimale().getSesso()) : "--"%>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Mantello</dhv:label></td>
		<td id="mantello"><%=mantelloList.getSelectedValue(scheda.getAnimale().getIdTipoMantello())%>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Taglia</dhv:label></td>
		<td id="taglia"><%=toHtml(tagliaList.getSelectedValue(scheda.getAnimale().getIdTaglia()))%>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Sterilizzato</dhv:label></td>
		<td id="sterilizzato">
<%
		if(scheda.getAnimale().getFlagSterilizzazione())
		{
			out.println("SI");
			if(scheda.getAnimale().getDataSterilizzazione()!=null)
				out.println(" IN DATA " + toHtmlValue(toDateasString(scheda.getAnimale().getDataSterilizzazione())));		
		}
		else
		{
			out.println("NO");
		}
		 %>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Indirizzo</dhv:label></td>
		<td id="indirizzo">
			<%=scheda.getAnimale().getUbicazione()%>
		</td>
	</tr>
</table>
<br/>
<table cellpadding="2" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Informazioni scheda decesso</dhv:label></strong>
		</th>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Data decesso</dhv:label></td>
		<td>
			<%=toHtmlValue(toDateasString(scheda.getDataDecesso()))%>
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Causa decesso</dhv:label></td>
		<td>
			<%=causeDecessoList.getSelectedValue(scheda.getIdCausa())%><%if(scheda.getNoteCausaDecesso()!=null && !scheda.getNoteCausaDecesso().equals("")) {%>&nbsp;&nbsp;&nbsp;&nbsp; Note: <%=scheda.getNoteCausaDecesso() %><%}%>
		</td>
	</tr>

<%
	if(scheda.getIdNeoplasia()>0)
	{
%>
	<tr>
		<td class="formLabel"><dhv:label name="">Diagnosi di Neoplasia</dhv:label></td>
		<td>
			<%=neoplasieList.getSelectedValue(scheda.getIdNeoplasia())%><%if(scheda.getNoteNeoplasia()!=null && !scheda.getNoteNeoplasia().equals("")) {%> &nbsp;&nbsp;&nbsp;&nbsp; Note: <%=scheda.getNoteNeoplasia() %><%}%>
		</td>
	</tr>
	
<%
	}
	if(scheda.getIdDiagnosiCitologica()>0)
	{
%>
	<tr>
		<td class="formLabel"><dhv:label name="">Diagnosi citologica</dhv:label></td>
		<td>
			<%=diagnosiCitologiche.getSelectedValue(scheda.getIdDiagnosiCitologica())%>
		</td>
	</tr>
<%
	}

	if(scheda.getIdNeoplasia()==13)
	{
%>	
		<tr>
		<th colspan="2"><strong><dhv:label name="">Diagnosi istologica</dhv:label></strong>
		</th>
	</tr>
	
		<tr id="dataEsitoIstologicaTr"  >
		<td id="dataEsitoIstologicaTd1"   class="formLabel"><dhv:label name="">Data esito</dhv:label></td>
		<td id="dataEsitoIstologicaTd2"    ><%=toHtmlValue(toDateasString(scheda.getDataEsitoIstologico()))%>
		</td>
	</tr>
	
	<tr id="descMorfologicaIstologicaTr"  >
		<td id="descMorfologicaIstologicaTd1"   class="formLabel"><dhv:label name="">Descrizione morfologica</dhv:label></td>
		<td id="descMorfologicaIstologicaTd2"   ><%=scheda.getDescMorfologicaIstologico() %> 
		</td>
	</tr>
	
	<tr id="tipoDiagnosiIstologicaTr"  >
		<td id="tipoDiagnosiIstologicaTd1"   class="formLabel"><dhv:label name="">Tipo Diagnosi</dhv:label></td>
		<td id="tipoDiagnosiIstologicaTd2"    ><%=tipoDiagnosiIstologiche.getSelectedValue(scheda.getIdTipoDiagnosiIstologica()) %>  </font>
		</td>
	</tr>
	
	
	<tr id="diagnosiIstologicaTr"  >
		<td id="diagnosiIstologicaTd1"   class="formLabel"><dhv:label name="">Diagnosi</dhv:label></td>
		<td id="diagnosiIstologicaTd2"   ><%=diagnosiIstologicheTumorali.getSelectedValue( scheda.getIdDiagnosiIstologica()) %></td>
	</tr>
	
	<tr id="noteDiagnosiIstologicaTr"  >
		<td id="noteDiagnosiIstologicaTd1"   class="formLabel"><dhv:label name="">Note Diagnosi</dhv:label></td>
		<td id="noteDiagnosiIstologicaTd2"    ><%if(scheda.getNoteDiagnosiIstologicaTumorali()!=null){
			out.println(scheda.getNoteDiagnosiIstologicaTumorali());
		}
		
		%>
		</td>
	</tr>
	
	
<%
	}
%>
	
							
</table>
<br/>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
			<tr>
				<th colspan="2"><strong>Medico veterinario</strong>
				</th>
			</tr>
			<tr class="containerBody">
				<td nowrap class="formLabel">Nome e cognome</td>
				<td><%=scheda.getNomeCognome()%>&nbsp;</td>
			</tr>
			<tr class="containerBody">
				<td nowrap class="formLabel">Codice fiscale</td>
				<td><%=scheda.getCodiceFiscale()%>&nbsp;</td>
			</tr>
		</table>
		<br/>
		
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
			<tr>
				<th colspan="2"><strong><dhv:label name="accounts.accounts_contacts_calls_details.RecordInformation">Record Information</dhv:label></strong>
				</th>
			</tr>
			<tr class="containerBody">
				<td nowrap class="formLabel"><dhv:label
						name="accounts.accounts_calls_list.Entered">Entered</dhv:label></td>
				<td><%=scheda.getInformazioniInserimentoRecord()%>&nbsp;</td>
			</tr>
			<tr class="containerBody">
				<td nowrap class="formLabel"><dhv:label
						name="accounts.accounts_contacts_calls_details.Modified">Modified</dhv:label>
				</td>
				<td>
					<dhv:username id="<%=scheda.getModifiedBy()%>" /> <%=toHtmlValue(toDateasString(scheda.getModified()))%>&nbsp;
				</td>
			</tr>
		</table>



<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
			<tr class="containerBody">
				<td nowrap class="formLabel"></td>
				<td>
					<input type="button" value="Stampa" onclick="openRichiestaPDF('PrintSchedaDecesso', '<%=scheda.getAnimale().getIdAnimale()%>','-1',  '-1', '-1', '-1')"/>
				</td>
			</tr>
</table>

	</dhv:container>	
		