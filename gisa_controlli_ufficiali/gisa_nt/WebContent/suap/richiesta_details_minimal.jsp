<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.suap.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.Constants" %>
<%@page import="java.util.Map.Entry"%>

<link rel="stylesheet" type="text/css" href="css/jmesa.css"></link>		
		<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
		<script type="text/javascript" src="javascript/jmesa.js"></script>

<%@page import="java.sql.Timestamp"%>

<jsp:useBean id="StabilimentoDettaglio" class="org.aspcfs.modules.suap.base.Stabilimento" scope="request"/>


<% 
int tipoDettaglioScheda = 28;

%>


<jsp:include page="../schede_centralizzate/iframe.jsp">
    <jsp:param name="objectId" value="<%=StabilimentoDettaglio.getAltId() %>" />
       <jsp:param name="objectIdName" value="alt_id" />
     <jsp:param name="tipo_dettaglio" value="<%=tipoDettaglioScheda %>" />
     </jsp:include>
     


