<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.opu.base.*, org.aspcfs.modules.base.*, org.aspcfs.modules.registrazioniAnimali.base.*" %>

<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<%-- Trails --%>
<table class="trails" cellspacing="0">
	<tr>
		<td width="100%"><a href="AnimaleAction.do"><dhv:label
			name="">Anagrafe animali</dhv:label></a> > <dhv:label name="">Gestisci decessi</dhv:label>
		</td>
	</tr>
</table>
<%-- End Trails --%>

<form name="searchAnimale"
	action="AnimaleAction.do?command=GestisciDecessiTrovaAnimali" onSubmit=""
	method="post"><input type="hidden" name="doContinue"
	id="doContinue" value="" />
<label>Cerca nel DB animali che hanno età: </label>
<select name= "anni" id="anni">
  <!-- option value="10">più di 10 anni</option>
  <option value="20">più di 20 anni</option -->
  <option value="25">più di 25 anni</option>
  <option value="30">più di 30 anni</option>
</select><br/>

<label>Stato in cessione: </label>
<input type="checkbox" name="inCessione"/><br/>

<label>Ragione Sociale Proprietario: </label>
<input type="text" name="ragioneSocProp" id = "ragioneSocProp"/><br/>

<label>Ragione Sociale Detentore: </label>
<input type="text" name="ragioneSocDet" id = "ragioneSocDet"/>



<input type="submit" value="<dhv:label name="button.search">Search</dhv:label>"> </form>







