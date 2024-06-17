<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@page import="java.util.Date"%>
<%@page import="org.aspcfs.taglib.PermissionHandler"%>
<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="StabilimentoDettaglio" class="org.aspcfs.modules.opu.base.Stabilimento" scope = "request"/>
<jsp:useBean id="InfoOperatoreMercato" class="org.aspcfs.modules.sintesis.base.SintesisOperatoreMercato" scope = "request"/>
<jsp:useBean id="InfoMercato" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope = "request"/>
<jsp:useBean id="Numero_cu" class="java.lang.String" scope="request"/>
<jsp:useBean id="Numero_pratiche" class="java.lang.String" scope="request"/>
<jsp:useBean id="numero_linee_aggiungibili" class="java.lang.String" scope="request"/>

<jsp:useBean id="Messaggio" class="java.lang.String" scope="request"/>
  
<script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script>
  
<%@ include file="../../utils23/initPage.jsp" %>


<% if (Messaggio!=null && !Messaggio.equalsIgnoreCase("null") && !Messaggio.equals("")) {%>
<script>
alert('<%=Messaggio%>');
</script>
<% } %>


<%-- Trails --%>
	<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="OpuStab.do?command=SearchForm">ANAGRAFICA STABILIMENTI</a> >
			<a href="RicercaUnica.do?command=Search">RISULTATO RICERCA</a> >
			SCHEDA
		</td>
	</tr>
	</table>
<%-- Trails --%>

<%@ include file="../../../controlliufficiali/anagrafica_diffida_list.jsp" %>

<%
String nomeContainer = "operatoremercato";

StabilimentoDettaglio.getOperatore().setRagioneSociale(StabilimentoDettaglio.getOperatore().getRagioneSociale().toUpperCase() );
request.setAttribute("Operatore",StabilimentoDettaglio.getOperatore());
String param = "stabId="+StabilimentoDettaglio.getIdStabilimento();
 
int tipoDettaglioScheda = 55;
	
%>

<dhv:permission name="note_hd-view">
	<jsp:include page="../../note_hd/link_note_hd.jsp">
	<jsp:param name="riferimentoId" value="<%=StabilimentoDettaglio.getIdStabilimento() %>" />
	<jsp:param name="riferimentoIdNomeTab" value="opu_stabilimento" />
	<jsp:param name="typeView" value="button" />
	</jsp:include>
</dhv:permission>


<jsp:include page="../../preaccettazionesigla/button_preaccettazione.jsp">    
    		<jsp:param name="riferimentoIdPreaccettazione" value="<%=StabilimentoDettaglio.getIdStabilimento() %>" />
    		<jsp:param name="riferimentoIdNomePreaccettazione" value="stabId" />
    		<jsp:param name="riferimentoIdNomeTabPreaccettazione" value="opu_stabilimento" />
   	 		<jsp:param name="userIdPreaccettazione" value="<%=User.getUserId() %>" />
</jsp:include>

<br><br>

<center>
<table class="details" cellpadding="10" cellspacing="10" width="50%">
<tr><td class="formLabel">Operatore associato al mercato</td><td colspan="5" align="center"><a href="StabilimentoSintesisAction.do?command=Details&stabId=<%=InfoMercato.getIdStabilimento() %>" onClick="loadModalWindow()"><%=InfoMercato.getOperatore().getRagioneSociale() %></a></td></tr>
<tr><td class="formLabel">Numero Box</td><td align="center"><%=InfoOperatoreMercato.getNumBox() %></td>
<td class="formLabel">Identificativo</td><td align="center"><%=InfoOperatoreMercato.getIdentificativo() %></td>
<td class="formLabel">Stato</td><td align="center"><%=InfoOperatoreMercato.getDataCessazione() != null ? "CESSATO "+InfoOperatoreMercato.getDataCessazione() : InfoOperatoreMercato.getTrashedDate() != null ? "ELIMINATO "+InfoOperatoreMercato.getTrashedDate() : "ATTIVO" %></td></tr>
</table>
</center>

<br>

<div align="right">
<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
<input type="button" title="Stampa Scheda" value="Stampa Scheda" onClick="openRichiestaPDFOpuAnagrafica('<%= StabilimentoDettaglio.getIdStabilimento() %>', '<%=tipoDettaglioScheda%>');">
</div>

<br/>

<dhv:container name="<%=nomeContainer %>"  selected="details" object="Operatore" param="<%=param%>" hideContainer="false">

<jsp:include page="../../schede_centralizzate/iframe.jsp">
<jsp:param name="objectId" value="<%=StabilimentoDettaglio.getIdStabilimento() %>" />
<jsp:param name="objectIdName" value="stab_id" />
<jsp:param name="tipo_dettaglio" value="<%=tipoDettaglioScheda %>" />
</jsp:include>

</dhv:container>
 

