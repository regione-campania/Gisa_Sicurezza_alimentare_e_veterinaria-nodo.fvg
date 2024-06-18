<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page import="java.io.*,java.util.*,org.aspcfs.utils.web.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.registrazioniAnimali.base.*"%>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" /> 
<jsp:useBean id="causeDecessoList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="neoplasieList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="diagnosiCitologiche" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="diagnosiIstologicheTumorali" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipoDiagnosiIstologiche" class="org.aspcfs.utils.web.LookupList" scope="request" />

	
<meta charset="utf-8" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<!-- <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<script language="javascript" SRC="javascript/jquery-ui.js"></script>
<script language="javascript" SRC="javascript/CalendarPopup2.js"></script>
<!--
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/dateControl.js"></script>
<script language="javascript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
</SCRIPT>
-->

<script type="text/javascript" src="dwr/interface/DwrUtil.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/Animale.js"> </script>

<script type="text/javascript">

$( document ).ready( function(){
	calenda('dataDa','','0');
	calenda('dataA','','0');
});

</script>

<%@ include file="../initPage.jsp"%>
<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td width="100%"><a href="ProfilassiRabbia.do"><dhv:label
				name="">Scheda decesso</dhv:label></a> > <dhv:label name="">Ricerca</dhv:label>
				
			</td>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>
<body>

<form name="add" id="idForm" action="SchedaDecesso.do?command=Search&auto-populate=true" method="post"></br>

<span id="datireg" class="datireg">
<table cellpadding="2" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Anagrafica animale</dhv:label></strong>
		</th>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Microchip</dhv:label></td>
		<td><input type="text" name="microchip" id="microchip" value="" maxlength="15"   />
			&nbsp;
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Data decesso</dhv:label></td>
		<td id="datanascita">
			Da:
	         <input class="date_picker" type="text" id="dataDa" name="dataDa" size="10" value="" nomecampo="dataDa" labelcampo="dataDa"/>&nbsp;
	         &nbsp;&nbsp;
			A:
			<input class="date_picker" type="text" id="dataA" name="dataA" size="10" value="" nomecampo="dataA" labelcampo="dataA" />&nbsp;
		</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Animali Viventi/Deceduti</dhv:label></td>
		<td id="datanascita">
	<select name="flagDecesso" id="flagDecesso">
					<option value="">Tutti</option>
					<option value="false">Viventi</option>
					<option value="true">Deceduti</option>
				</select>
	</td>
	</tr>
	</table>
<br/>


<input type="submit" onclick="" value="Ricerca" id="invia" />
</form>
