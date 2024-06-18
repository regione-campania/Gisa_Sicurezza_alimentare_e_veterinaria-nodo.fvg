<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<jsp:useBean id="tipoSoggettoSterilizz"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="listaPratiche" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="evento"
	class="org.aspcfs.modules.registrazioniAnimali.base.Evento"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="veterinariList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%
	EventoSterilizzazione eventoSter = (EventoSterilizzazione) evento;
%>
<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>

<%@page
	import="org.aspcfs.modules.registrazioniAnimali.base.EventoSterilizzazione"%>

<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="pagedList">
	<th colspan="2">Dettagli della registrazione di sterilizzazione</th>

	<tr>
		<td><b><dhv:label name="">Data della sterilizzazione</dhv:label></b></td>
		<td><%=toDateasString(eventoSter.getDataSterilizzazione())%>&nbsp;
		</td>
	</tr>
	<tr>
		<td width="20%"><b><dhv:label name="">Contributo Regionale</dhv:label></b>
		</td>
		<td><%=(!eventoSter.isFlagContributoRegionale()) ? "No"
					: "Si pratica contributi decreto nr "
							+ listaPratiche.getSelectedValue(eventoSter
									.getIdProgettoSterilizzazioneRichiesto())%>

		</td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Tipologia soggetto sterilizzante</dhv:label></b></td>
		<td><%=tipoSoggettoSterilizz.getSelectedValue(eventoSter.getIdTipologiaSoggettoSterilizzante())%>
		<dhv:evaluate
			if="<%=(eventoSter.getIdTipologiaSoggettoSterilizzante() == EventoSterilizzazione.idTipoSoggettoASL)%>">
		</dhv:evaluate></td>
	</tr>
	<tr>
		<td><b><dhv:label name="">Soggetto sterilizzante</dhv:label></b></td>
		<td>
			<%if((eventoSter.getIdTipologiaSoggettoSterilizzante() == EventoSterilizzazione.idTipoSoggettoASL) && eventoSter.getIdSoggettoSterilizzante() > 0){ %>
					Asl di <%=AslList.getSelectedValue(eventoSter.getIdSoggettoSterilizzante())%>
			<% }else{ %>		
					--
			<% } %>
		<dhv:evaluate
			if="<%=(eventoSter.getIdTipologiaSoggettoSterilizzante() == EventoSterilizzazione.idTipoSoggettoLLP)%>">
	 		<%=veterinariList.getSelectedValue(eventoSter.getIdSoggettoSterilizzante())%>
		</dhv:evaluate>
		</td>
	</tr>
	
	
	<dhv:evaluate if="<%=(eventoSter.getVeterinarioAsl1()>0 || eventoSter.getVeterinarioAsl2()>0)%>">
		<tr>
			<td>
				<b>
					<dhv:label name="">Veterinari asl</dhv:label>
				</b>
			</td>
			<td>
				<dhv:evaluate if="<%=(eventoSter.getVeterinarioAsl1()>0)%>">
					<dhv:username id="<%=eventoSter.getVeterinarioAsl1()%>"/>
					<br/>
				</dhv:evaluate>	
				<dhv:evaluate if="<%=(eventoSter.getVeterinarioAsl2()>0)%>">
					<dhv:username id="<%=eventoSter.getVeterinarioAsl2()%>"/>
				</dhv:evaluate>
			</td>
		</tr>
	</dhv:evaluate>


</table>