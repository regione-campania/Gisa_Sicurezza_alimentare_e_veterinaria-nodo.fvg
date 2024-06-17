<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@page import ="org.aspcfs.modules.suap.utils.CodiciRisultatiRichiesta" %>
<%@page import ="org.aspcfs.modules.opu.base.OperatorePerDuplicati" %>
<%@page import ="java.util.ArrayList, java.util.HashMap,org.aspcfs.modules.suap.base.CodiciRisultatoFrontEnd,org.aspcfs.modules.suap.base.Stabilimento" %>
<%@page import ="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<jsp:useBean id="descrizione_errore" class="java.lang.String" scope="request"/>
<jsp:useBean id="Richiesta" class="org.aspcfs.modules.suap.base.Stabilimento" scope="request" />

<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>

<%@ include file="../utils23/initPage.jsp"%>
	 
	 <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	<tr><th colspan="4"><strong>VARIAZIONE DI TITOLARITA STABILIMENTO</strong></th></tr>
	<tr>
		<th colspan="3">&nbsp;</th>
		<th>Operazione</th>
	</tr>

	<tr>
	<td colspan="3"></td>
	<td><%
	if(Richiesta.getOperatore().isValidato()==false)
	{ 
	%>
		<input id="btnCessazioneGlobale" type="submit"
			value="trasferisci in anagrafica stabilimenti"
			onClick="intercettaBottoneValidaGlobale(1);" />
		<input id="btnCessazioneGlobale" type="submit"
			value="Respingi"
			onClick="intercettaBottoneValidaGlobale(2);" />
			<%
			} %>
		</td>
		
		
		
	</tr>
   
    </table>
  