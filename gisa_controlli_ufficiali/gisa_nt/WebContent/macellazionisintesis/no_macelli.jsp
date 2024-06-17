<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>

<%@page import="org.aspcfs.modules.macellazionisintesis.utils.MacelliUtil"%>

<%@page import="org.aspcfs.modules.util.imports.ApplicationProperties"%>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request" />
<jsp:useBean id="error" class="java.lang.String" scope="request" />


<script>
alert('<%=error%>');
window.location.href="StabilimentoSintesisAction.do?command=DettaglioStabilimento&stabId=<%=OrgDetails.getIdStabilimento()%>";
</script>