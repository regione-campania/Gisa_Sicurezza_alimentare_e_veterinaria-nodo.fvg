
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.molluschibivalvi.base.*"%>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.molluschibivalvi.base.Concessionario" scope="request" />
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application" />
<jsp:useBean id="systemStatus" class="org.aspcfs.controller.SystemStatus" scope="request" />
<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script>
function checkForm()
{
	formtest = true ;
	msg ='Controllare di aver selezionato i seguenti campi : \n';
	if(document.addAccount.name.value =='')
	{
		formtest = false ;
		msg = 'Il campo impresa deve essere popolato\n'
	}
	if(document.addAccount.address1city.value =='')
	{
		formtest = false ;
		msg = 'Il campo comune deve essere popolato\n'
	}
	if(document.addAccount.siteId.value =='')
	{
		formtest = false ;
		msg = 'Il campo asl deve essere popolato\n'
	}
	
	if(formtest==true)
		document.addAccount.submit();
	else
	{
		alert(msg);
		return false ;
	}
}
var campoLat;
var campoLong;
	function showCoordinate(address,city,prov,cap,campo_lat,campo_long)
	{
   campoLat = campo_lat;
   campoLong = campo_long;
   Geocodifica.getCoordinate(address,city,prov,cap,'','','',setGeocodedLatLonCoordinate);
   }
function setGeocodedLatLonCoordinate(value)
{
	campoLat.value = value[1];;
	campoLong.value =value[0];
	
}

</script>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<%@ include file="../utils23/initPage.jsp"%>

<form id="addAccount" name="addAccount"
	action="Concessionari.do?command=Modify&orgId=<%=OrgDetails.getId() %>&auto-populate=true"
	method="post">

<table class="trails" cellspacing="0">
	<tr>
		<td width="100%"><a href="MolluschiBivalvi.do">Molluschi
		Bivalvi</a> > Scheda Concessionario</td>
	</tr>
</table>


<br />
<br />
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong>Scheda Concessionario</strong></th>
	</tr>



	<tr>
		<td nowrap="nowrap" class="formLabel">ASL</td>
		<td>
			<%= SiteIdList.getSelectedValue(OrgDetails.getSiteId()) %>
		</td>
	</tr>

	<tr>
		<td nowrap class="formLabel" > Impresa</td>
		<td>
		<%=toHtml2(OrgDetails.getName()) %>
		</td>
	</tr>
	
<tr id = "classeId">
		<td nowrap class="formLabel" name="orgname1" id="orgname1"> Cf Impresa</td>
		<td><%=toHtml2(OrgDetails.getCfTitolare()) %></td>
	</tr>
	
	<tr>
		<td nowrap class="formLabel" name="orgname1" id="orgname1"> Legale Rappresentante</td>
		<td><%=toHtml2(OrgDetails.getTitolareNome()) %> </td>
	</tr>
		
	
	
	
	
</table>
<br>
<%
OrganizationAddress oa = new OrganizationAddress();
if(OrgDetails.getAddressList().size()>0)
	oa = (OrganizationAddress) OrgDetails.getAddressList().get(0);
%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	<tr>
		<th colspan="2"><strong>Sede Legale</strong></th></tr>
	<tr>
		<td nowrap="nowrap" class="formLabel" name="province" id="province">Comune</td>
		<td><%=toHtml2(oa.getCity()) %></td>
	</tr>
	<tr>
		<td nowrap="nowrap" class="formLabel">Indirizzo
		</td>
		<td><%=toHtml2(oa.getStreetAddressLine1()) %>
		</td>
	</tr>

	<tr>
		<td nowrap="nowrap" class="formLabel">CAP</td>
		<td><%=toHtml2(oa.getZip()) %>
		</td>
	</tr>

	<tr>
		<td nowrap="nowrap" class="formLabel">Prov</td>
		<td>
		<%=toHtml2(oa.getState()) %>

		</td>
	</tr>



	<tr class="containerBody">
		<td class="formLabel" nowrap="nowrap">Latitudine</td>
		<td>
		<%=oa.getLatitude() %>
		</td>
	</tr>
	
	<tr class="containerBody">
		<td class="formLabel" nowrap="nowrap">Longitudine</td>
		<td><%=oa.getLongitude() %></td>
	</tr>
	
</table>

<br>
<%if(OrgDetails.getListaConcessioni().size()>0)
	{%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
<tr><th colspan="4">Zone di Produzione</th></tr>
<tr>
<th>loc. Zona di Produzione</th>
<th>Numero Concessione</th>
<th>Data Concessione</th>
<th>Data Scadenza</th>
</tr>

<%
int idZona = -1 ;
if(request.getAttribute("idZona")!=null)
	idZona = (Integer.parseInt(""+request.getAttribute("idZona")));
Iterator itConcessioni = OrgDetails.getListaConcessioni().iterator();
 while (itConcessioni.hasNext() )
{
	Concessione concessione = (Concessione)itConcessioni.next();
%>
<tr <% if(idZona == concessione.getZona().getId()){%> style="background-color: yellow" <%} %> >

<td><%=concessione.getZona().getName() %></td>
<td><%=concessione.getNumConcessione()%></td>
<td><%=concessione.getDataConcessioneasString() %></td>
<td><%=concessione.getDataScadenzaasString() %></td>
</tr>
<%	
}
%>

</table>
<%} %>
</form>

