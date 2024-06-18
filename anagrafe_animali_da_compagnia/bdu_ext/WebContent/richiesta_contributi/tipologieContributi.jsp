<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../initPage.jsp" %>

<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*, java.text.DateFormat"%>
<%@page import="org.aspcfs.modules.registrazione_canili.base.RegistrazioneCanile"%>
<jsp:useBean id="RC" class="org.aspcfs.modules.richiestecontributi.base.RichiestaContributi" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

	<head>
		
		
		</head>
		<p>
			<font color="red">
				<%=toHtmlValue( (String)request.getAttribute( "Error" ) ) %>
			</font>
		</p>
		
		
				
		<form method="post" name="addRichiesta" action="ContributiSterilizzazioni.do?command=AvviaRichiestaCatturati" onSubmit="return verifica();">
			
			<input type="submit" value="Avvia la richiesta" />
			
			<input type="button" value="Annulla" onclick="location.href='ContributiSterilizzazioni.do'" />
			
			<table class="details"  cellspacing="0" cellpadding="4" border="0" width="100%">
							
				
				
			</table>
			
	    </form>
