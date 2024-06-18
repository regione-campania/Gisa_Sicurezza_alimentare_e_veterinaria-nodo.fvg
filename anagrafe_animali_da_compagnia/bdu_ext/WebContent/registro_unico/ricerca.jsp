<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<jsp:useBean id="anno" class="java.lang.String" scope="request"/>
<jsp:useBean id="annoCorrente" class="java.lang.String" scope="request"/>

<%-- Trails --%>
<table class="trails" cellspacing="0">
	<tr>
		<td width="100%"><a href="AnimaleAction.do"><dhv:label
			name="">Anagrafe animali</dhv:label></a> > <dhv:label name="">REGISTRO UNICO CANI A RISCHIO ELEVATO DI AGGRESSIVITA'</dhv:label>
		</td>
	</tr>
</table>
<%-- End Trails --%>

<form name="searchRegistroUnico" action="AnimaleAction.do?command=SearchRegistroUnico" onSubmit="" method="post">
<input type="hidden" name="doContinue" id="doContinue" value="" />
<label>Selezionare l'anno </label>

<select name= "anno" id="anno">
<%
	for (int i = Integer.parseInt(annoCorrente); i>= Integer.parseInt(anno); i--)
	{
%>
		<option value="<%=i%>"><%=i%></option>
<%
	} 
%>


</select>

<input type="submit" value="Apri registro"> </form>