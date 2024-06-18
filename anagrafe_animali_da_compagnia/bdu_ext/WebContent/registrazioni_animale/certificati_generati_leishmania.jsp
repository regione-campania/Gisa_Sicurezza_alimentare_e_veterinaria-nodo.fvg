<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="java.io.*,java.util.*,org.aspcfs.utils.web.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.registrazioniAnimali.base.*"%>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<jsp:useBean id="EventoPrelievoLeishmania"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoPrelievoLeishmania"
	scope="request" />
<jsp:useBean id="animale"
	class="org.aspcfs.modules.anagrafe_animali.base.Animale"
	scope="request" />


<meta charset="utf-8" />
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>


<script language="javascript" SRC="javascript/CalendarPopup.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/dateControl.js"></script>
<script language="javascript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
</SCRIPT>

<script type="text/javascript" src="dwr/interface/DwrUtil.js">
	
</script>
<script type="text/javascript" src="dwr/engine.js">
	
</script>
<script type="text/javascript" src="dwr/util.js"></script>




<script language="JavaScript" TYPE="text/javascript"
	SRC="gestione_documenti/generazioneDocumentale.js"></script>



<%@ include file="../initPage.jsp"%>
<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td width="100%"><a href="ProfilassiRabbia.do"><dhv:label
						name="">Profilassi Rabbia</dhv:label></a> > <dhv:label name="">Stampa certificati</dhv:label>
			</td>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>
<body>
	<table>
		<tr>
			<td><img src="images/icons/stock_print-16.gif" border="0"
				align="absmiddle" height="16" width="16" /> <a href="#"
				onclick="openRichiestaPDF('PrintRichiestaCampioni', '<%=EventoPrelievoLeishmania.getIdAnimale()%>','<%=animale.getIdSpecie()%>', '-1', '-1', '<%=EventoPrelievoLeishmania.getIdEvento()%>');"
				id="" target="_self">Scheda invio campioni Leishmania</a> <%=showWarning(request, "avvisoCertificati", false)%>
			</td>
		</tr>

		<tr>
			<td><img src="images/icons/stock_print-16.gif" border="0"
				align="absmiddle" height="16" width="16" />
				<a href="GeneraBarCode.do?command=SearchForm&microchip=<%=animale.getMicrochip()%>&tipo=1" target="popup" onclick="setTimeout(loadModalWindowUnlock,3000);">
					Stampa Barcode
				</a>
				</td>
		</tr>

	</table>

	</br>
	</br>

	</br>