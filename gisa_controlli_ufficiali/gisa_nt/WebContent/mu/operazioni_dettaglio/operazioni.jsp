<%@page import="org.aspcfs.modules.mu_wkf.base.*" %>
<%@page import="java.util.*"%> 
<jsp:useBean id="path" class="org.aspcfs.modules.mu_wkf.base.Path" scope="request"/>
<jsp:useBean id="capo" class="org.aspcfs.modules.mu.base.CapoUnivoco" scope="request" />
<jsp:useBean id="listaCapi" class="java.lang.String" scope="request"/>
  
  
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<!-- <script type="text/javascript" src="javascript/ui.tabs.js"></script> -->

<%@ include file="include.jsp" %>

<script>



</script>


<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%
String param1 = "orgId=" + OrgDetails.getOrgId();
%>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="MacellazioneUnica.do?command=List&orgId=<%=seduta.getIdMacello()%>">Home macellazioni </a> 
			> <a href="MacellazioneUnica.do?command=DettaglioSeduta&idSeduta=<%=dettaglioCapo.getIdSeduta()%>"> Dettaglio seduta </a> > Dettaglio macellazione
		</td>
	</tr>
</table>

<dhv:container name="stabilimenti_macellazioni_ungulati" selected="macellazioniuniche" object="OrgDetails" param="<%= param1 %>" >


 
 
 

<br/>

<%-- <input type="hidden" id="listaCapi" name="listaCapi" value="<%=listaCapi %>"/> --%>

<%
	ArrayList<Step> steps = path.getListaSteps();
	Iterator i = steps.iterator();
	while (i.hasNext()) {
		Step thisStep = (Step) i.next();
		String file_to_include = "/mu/operazioni_dettaglio/"+thisStep.getJspPageToInclude();
		
%>
<div>

<jsp:include page='<%=file_to_include %>'  flush="true"/> 

</div>
<br/>
<%
	}
%>


</dhv:container>