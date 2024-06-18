<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page import="java.util.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.assets.base.*,org.aspcfs.modules.servicecontracts.base.*,org.aspcfs.modules.anagrafe_animali.base.*"%>

<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
<jsp:useBean id="registri" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="registriListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />


<%@ include file="../initPage.jsp"%>
<%@ include file="../initPopupMenu.jsp"%>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
	SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
	SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
	
<%-- Preload image rollovers for drop-down menu --%>
	loadImages('select');
	
	
</script>

<script type="text/javascript">
function sblocca(id_eve,id_animale)
{
	if(confirm("sei sicuro di voler sbloccare la pratica?"))
	window.open('AnimaleAction.do?command=RegistroSanzioni&delete=true&idAnimale='+id_animale+'&id_evento='+id_eve,'_self')
}
</script>


<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
	<tr>
		<td width="100%"><a href="AnimaleAction.do"><dhv:label
			name="">Anagrafe animali</dhv:label></a> > <dhv:label name="">ELENCO TRASGRESSORI</dhv:label>
		</td>
	</tr>
</table>
	<%-- End Trails --%>
</dhv:evaluate>

<dhv:pagedListStatus title='<%=showError(request, "actionError")%>'
	object="registriListInfo" />
<br />





<link rel="stylesheet" type="text/css"
	href="extjs/resources/css/ext-all.css" />


<table class="details" cellpadding="4" cellspacing="0" border="0"
	width="100%">
	<thead>
		<tr>
		    <th  nowrap><strong><dhv:label name="">Data evento</dhv:label></strong>
			</th>
			<th  nowrap><strong><dhv:label name="">ID evento</dhv:label></strong>
			</th>
			<th  nowrap><strong><dhv:label name="">Microchip</dhv:label></strong>
			</th>
			<th  nowrap><strong><dhv:label name="">Razza</dhv:label></strong>
			</th>
			<th  nowrap><strong><dhv:label name="">Data nascita</dhv:label></strong>
			</th>
			<th ><strong><dhv:label name="">Libero professionista</dhv:label></strong>
			</th>
			<th ><strong><dhv:label name="">Proprietario</dhv:label></strong>
			</th>
			<th ><strong><dhv:label name="">Microchip madre</dhv:label></strong>
			</th>
			<th ><strong><dhv:label name="">Proprietario madre</dhv:label></strong>
			</th>
			<th ><strong><dhv:label name="">Stato</dhv:label></strong>
			</th>
			<th ><strong><dhv:label name="">Data chiusura</dhv:label></strong>
			</th>
			<th ><strong><dhv:label name="">Utente chiusura</dhv:label></strong>
			</th>
			<th><strong><dhv:label name="">Sanzione a carico di</dhv:label></strong>
			</th>
			<th><strong><dhv:label name="">Comune</dhv:label></strong>
			</th>
			<th><strong><dhv:label name="">Emessa sanzione / CU</dhv:label></strong>
			</th>
			<th><strong><dhv:label name="">Azioni</dhv:label></strong>
			</th>
		</tr>
	</thead>
	<tbody>
		<%
			Iterator<RegistroSanzioni> itr = registri.iterator();
			if (itr.hasNext()) {
				int rowid = 0;
				int i = 0;
				while (itr.hasNext()) {
					i++;
					rowid = (rowid != 1 ? 1 : 2);
					RegistroSanzioni registro = itr.next();
		%>
		<tr class="row<%=rowid%>">
			<td nowrap><%=toDateasString(registro.getDataRegistrazione()) %></td>
			<td nowrap><%=registro.getIdEvento()%></td>
			<td nowrap><a href="javascript:popURL('AnimaleAction.do?command=Details&animaleId=<%=registro.getIdAnimale()%>&popup=true&viewOnly=true','AccountDetails','650','500','yes','yes');">
						<%=registro.getMicrochip()%></a></td>
			<td nowrap><%=registro.getRazza()%></td>
			<td nowrap><%=toDateasString(registro.getDataNascita()) %></td>
			<td nowrap><%=registro.getUtenteInserimento()%></td>
			<td nowrap><a href="javascript:popURL('OperatoreAction.do?command=Details&opId=<%=registro.getIdProprietario()%>&popup=true&viewOnly=true','AccountDetails','650','500','yes','yes');"><%=registro.getProprietario() %></a></td>
			<td nowrap>
<%
			if(registro.getIdAnimaleMadre()>0)
			{
%>
			<a href="javascript:popURL('AnimaleAction.do?command=Details&animaleId=<%=registro.getIdAnimaleMadre()%>&popup=true&viewOnly=true','AccountDetails','650','500','yes','yes');">
						<%=registro.getMicrochipMadre()%></a>
<%
			}
			else
			{
				out.println(registro.getMicrochipMadre());
			}
%>
			</td>
			<td nowrap>
<%
			if(registro.getIdProprietarioProvenienza()>0 && registro.getIdAnimaleMadre()>0)
			{
%>
				<a href="javascript:popURL('OperatoreAction.do?command=Details&opId=<%=registro.getIdProprietarioProvenienza()%>&popup=true&viewOnly=true','AccountDetails','650','500','yes','yes');"><%=registro.getProprietarioProvenienza() %></a></td>
<%
			}
			else
			{
				out.println(registro.getProprietarioProvenienza());
			}
%>	
			<td nowrap><%=registro.getStato()%></td>
			<td nowrap><%=toDateasString(registro.getDataChiusura()) %></td>
			<td nowrap><%=((registro.getUtenteChiusura()!=null)?(registro.getUtenteChiusura()):("") )%></td>
			<td nowrap><%=registro.getSoggettoSanzionato()%></td>
			<td nowrap><%=((registro.getSanzioneProprietario()==true || ("3").equals(registro.getSoggettoSanzionatoCode()))?(registro.getComuneProprietario()):(registro.getComuneCedente()) )%></td>
			<td nowrap><%=((registro.getNumeroSanzione()!=null)?(registro.getNumeroSanzione()):("") )%> <br><%=((registro.getIdCu()!=null)?("CU: "+registro.getIdCu()):("") )%></td>
			<% //&&  (User.getRoleId() == new Integer(ApplicationProperties.getProperty("UNINA")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_REFERENTE_ASL") || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_AMMINISTRATORE_ASL")
			// || 	User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_SYSADMINASL") || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_ANAGRAFE_CANINA")	
			//
			//if(("Cedente ASL FUORI REGIONE").equals(registro.getSoggettoSanzionato())&& ("Aperta").equals(registro.getStato()) &&  (User.getRoleId() == new Integer(ApplicationProperties.getProperty("UNINA")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_REFERENTE_ASL")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_AMMINISTRATORE_ASL"))|| User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_SYSADMINASL")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_ANAGRAFE_CANINA"))))
				if(registro.isStatoApertura()&&("3").equals(registro.getSoggettoSanzionatoCode())&&  (User.getRoleId() == new Integer(ApplicationProperties.getProperty("UNINA")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_REFERENTE_ASL")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_AMMINISTRATORE_ASL"))|| User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_SYSADMINASL")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_ANAGRAFE_CANINA"))||  User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) || User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))  ))
			{
%>
			<td nowrap><input type="button" value="Sblocca Pratica" onclick="sblocca(<%=registro.getIdEvento()%>,<%=registro.getIdAnimale()%>)" /></td>
			<%} %>
		</tr>
		<%
			}
			} 
		%>
	</tbody>
</table>


<dhv:pagedListControl object="registriListInfo" />

<br>
<b>Guida all'inserimento delle sanzioni</b>
<br><br>
<b>Cedente senza tracciabilita':</b><br> 
L'organo accertatore applica la sanzione prevista all'art. 20, comma 1 del D.lgs. 134/2022, per la violazione del comma 1 dell'articolo 16.
<br><br>
<b>Acquirente senza tracciabilita':</b><br>
L'organo accertatore applica la sanzione prevista all'art. 20, comma 1 del D.lgs. 134/2022, per la violazione del comma 1 dell'articolo 16.
<br><br> 
<b>Cedente residente fuori regione:</b><br> 
L'organo accertatore applica la sanzione prevista all'art. 20, comma 1 del D.lgs. 134/2022, per la violazione del comma 1 dell'articolo 16.
<br><br> 
<b>Cane senza identificativo proveniente dall'estero:</b><br> 
L'organo accertatore applica al richiedente la sanzione prevista ai sensi della Legge 201/2010 art.5 comma 1.
<br><br>