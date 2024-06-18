<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*" %>

<jsp:useBean id="eventiListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="specieList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="registrazioniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="annoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<!-- <script src="https://code.jquery.com/jquery-1.8.2.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.9.1/jquery-ui.js"></script> -->
  
  <script language="JavaScript">
  function clearForm() {
    <%-- Account Filters --%>
   
    var frm_elements = searchRegistrazioni.elements;
   // frm_elements.searchcodeId.value="";
    //frm_elements.searchcodeidTipologiaEvento.value="-1";
    frm_elements.searchcodeidSpecieAnimale.value="-1";
    frm_elements.searchtimestampBDUda.value="";
    frm_elements.searchtimestampBDUa.value="";
    frm_elements.searchtimestampeventoda.value="";
    frm_elements.searchtimestampeventoa.value="";
 
   }
</script>

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/jquery-ui.js"></SCRIPT>
<!-- 
<SCRIPT LANGUAGE="JavaScript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
form.searchcodeidTipologiaEvento.value=36;
</SCRIPT>
-->    
  
<script type="text/javascript">

$( document ).ready( function(){
	calenda('searchtimestampeventoda','','0');
	calenda('searchtimestampeventoa','','');
});

function checkForm(form) {
	form.searchcodeidTipologiaEvento.value=36;
	return true;

		
	  }

</script>

    
    <%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<!--a href="RegistrazioniAnimale.do"><dhv:label name="">Registrazioni</dhv:label></a> --> 
<dhv:label name="">Ricerca</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>


<form name="searchRegistrazioni" action="ProfilassiRabbia.do?command=Search12" method="post" onsubmit="javascript:return checkForm(this);">
<table cellpadding="2" cellspacing="2" border="0" width="100%">
	<tr>
		<td width="50%" valign="top">
<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2"><strong>Informazioni Registrazioni</strong>
				</th>
			</tr>
			<tr>
          <td class="formLabel">
            <dhv:label name="">Tipologia registrazione</dhv:label>
          </td>
          <td>
          <label>Inserimento Vaccinazioni antirabbia</label>
          </td>
        </tr>

        <tr>
          <td class="formLabel">
            <dhv:label name="">Utente</dhv:label>
          </td>
          <td>
          <jsp:useBean id="currentUser" class="java.lang.String" scope="request"/>
          
          <label><%= currentUser %></label>
        	<input type="hidden" size="23" name="searchcodeId" value="<%= eventiListInfo.getSearchOptionValue("searchcodeId") %>">
          </td>
        </tr>
       
        <td class="formLabel">
            <dhv:label name="">Specie animale</dhv:label>
          </td>
          <td>
          <%=specieList.getHtmlSelect("searchcodeidSpecieAnimale",  eventiListInfo.getSearchOptionValue("searchcodeidSpecieAnimale")) %>
          </td>
        </tr>
        
        
	</table>
		
</td>

<td width="50%" valign="top">

<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2"><strong>Informazioni temporali</strong>
				</th>
			</tr>
			
			
          
         <input  readonly type="hidden" id="searchtimestampBDUda" name="searchtimestampBDUda" size="10" value="" nomecampo="searchtimestampBDUda" labelcampo="searchtimestampBDUda"/>&nbsp;
        <input  readonly type="hidden" id="searchtimestampBDUa" name="searchtimestampBDUa" size="10" value="" nomecampo="searchtimestampBDUa" labelcampo="searchtimestampBDUa" />&nbsp;
         
       
       
	    	<tr>
          <td class="formLabel">
            <dhv:label name="">Data della vaccinazione</dhv:label>
          </td>
          <td>Da:
         <input  class="date_picker" type="text" id="searchtimestampeventoda" name="searchtimestampeventoda" size="10" value="" nomecampo="searchtimestampeventoda" labelcampo="searchtimestampeventoda"/>&nbsp;
         &nbsp;&nbsp;
		A:
		<input  class="date_picker" type="text" id="searchtimestampeventoa" name="searchtimestampeventoa" size="10" value="" nomecampo="searchtimestampeventoa" labelcampo="searchtimestampeventoa" onclick="checkDataFine('searchtimestampeventoda','searchtimestampeventoa')" />&nbsp;
          </td>
       </tr>

        <td class="formLabel">
            <dhv:label name="">Asl</dhv:label>
          </td>
          <td>
          <%=AslList.getHtmlSelect("searchcodeidAslInserimentoEventoBDU",  eventiListInfo.getSearchOptionValue("searchcodeidAslInserimentoEventoBDU")) %>
          </td>
        </tr>
         
         
		
	</table>		
		
</td>
</tr>
</table>
<table height="300px">
	<tr>
		<td valign="top">
			<input type="hidden" name="popup" id="popup" value="">
			<input type="submit" value="<dhv:label name="button.search">Search</dhv:label>">
			<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="javascript:clearForm();">
			<input type="hidden" name="source" value="searchForm">
		</td>
	</tr>
</table>
</form>
</body>
