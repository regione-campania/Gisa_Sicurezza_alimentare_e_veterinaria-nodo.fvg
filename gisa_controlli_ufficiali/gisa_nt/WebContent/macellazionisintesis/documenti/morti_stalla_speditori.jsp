<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>

<%@page import="org.aspcfs.modules.macellazionisintesis.utils.MacelliUtil"%>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request" />

<%@ include file="../../utils23/initPage.jsp"%>

	<head>
		<link rel="stylesheet" type="text/css" href="css/jmesa.css"></link>
		
		<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
		<script type="text/javascript" src="javascript/jmesa.js"></script>
	</head>

<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<%
				if (request.getParameter("return") == null)
				{
			%>
					
					<a href="StabilimentoSintesisAction.do?command=DettaglioStabilimento&altId=<%=OrgDetails.getAltId() %>">Scheda Stabilimento</a> >
			<%
				}
				else if (request.getParameter("return").equals("dashboard"))
				{}
			%>
			<a href="MacellazioniSintesis.do?command=List&altId=<%=OrgDetails.getAltId() %>">Macellazioni</a> > Anim. morti in stalla/trasporto
		</td>
	</tr>
</table>

<%
String param1 = "altId=" + OrgDetails.getAltId()+"&stabId=" + OrgDetails.getIdStabilimento(); request.setAttribute("Operatore",OrgDetails.getOperatore());
%>



<dhv:container 
	name="sintesismacelli"
	selected="macellazioni" 
	object="Operatore" 
	param="<%=param1 %>" 
	appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>' 
	>

<br/>



<font color="red"> <%=toHtmlValue( (String)request.getAttribute( "messaggio" ) ) %> </font>
<br/><br/>

	<form name="macellazioniForm" action="MacellazioniDocumentiSintesis.do">
		<input type="hidden" name="command" value="SpeditoriMortiStalla" />
		<input type="hidden" name="altId" value="<%=OrgDetails.getAltId() %>" />
		<input type="hidden" name="data" value="<%=request.getParameter( "data" ) %>" />
       <%=request.getAttribute( "tabella" )%>
    </form>
	    
	 <script type="text/javascript">
            function onInvokeAction(id) {
                $.jmesa.setExportToLimit(id, '');
                $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                location.href = 'MacellazioniDocumentiSintesis.do?command=SpeditoriMortiStalla&' + parameterString;
            }
    </script>
 
</dhv:container>
