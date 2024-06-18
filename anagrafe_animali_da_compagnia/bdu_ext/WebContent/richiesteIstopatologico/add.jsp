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



<%
String param1 = "";
String url = (String)request.getAttribute("url");
%>


<%@ include file="../initPage.jsp"%>
		
<table cellpadding="2" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<td colspan="2" class="formLabel">
			<iframe src="<%=url%>" width="100%" height="800"></iframe>
			
		</td>
	</tr>
</table>


		
		