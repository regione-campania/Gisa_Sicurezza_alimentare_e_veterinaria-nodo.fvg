<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@page import="java.util.Iterator"%>
<%@page import="org.aspcfs.modules.anagrafe_animali.base.Leish"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="ListaEsitiLeish" class="org.aspcfs.modules.anagrafe_animali.base.LeishList" scope="request"/>
<jsp:useBean id="esitiLeishListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>

<h3>Lista Esiti Leishmaniosi</h3>

<%@ include file="../initPage.jsp"%>
<dhv:pagedListStatus title='Esiti Leishmaniosi' object="esitiLeishListInfo"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">

<tr>
<th>Microchip</th>
<th>Data Prelievo</th>
<th>Data Esito</th>
<th>Esito</th>
</tr>

<%
if(ListaEsitiLeish.size()>0)
{
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Timestamp ultimo_agg = null ;
	Iterator it = ListaEsitiLeish.iterator();
	while (it.hasNext())
	{
		
		Leish leish = (Leish)it.next();
		ultimo_agg = leish.getDataAggiornamento();
		%>
		<tr>
		<td>
		<dhv:evaluate if="<%=(!isPopup(request) && User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")))%>">
			<a target="_blank" href="AnimaleAction.do?command=Details&microchip=<%=leish.getIdentificativo() %>&idSpecie=1<%=addLinkParams(request,
										"popup|popupType|actionId")%>"><%=leish.getIdentificativo() %></a>
		</dhv:evaluate> 
		
		<dhv:evaluate if="<%=(!isPopup(request) && User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) && leish.getAnimale().getIdAnimale() > 0 && leish.getAnimale().getIdUtenteInserimento() == User.getUserId())%>">
			<a target="_blank" href="AnimaleAction.do?command=Details&microchip=<%=leish.getIdentificativo() %>&idSpecie=1<%=addLinkParams(request,
										"popup|popupType|actionId")%>"><%=leish.getIdentificativo() %></a>
		</dhv:evaluate> 
		<dhv:evaluate if="<%=(isPopup(request) || (!isPopup(request) && User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")) && leish.getAnimale().getIdAnimale() > 0 && leish.getAnimale().getIdUtenteInserimento() != User.getUserId() ) )%>">
						<%=leish.getIdentificativo() %>
		</dhv:evaluate>				
		</td>
		<td><%=((leish.getDataPrelievo()!=null ) ? sdf.format(new java.sql.Date (leish.getDataPrelievo().getTime())) : "" ) %></td>
		<td><%=((leish.getDataEsito()!=null ) ? sdf.format(new java.sql.Date (leish.getDataEsito().getTime())) : "") %></td>
		<td><%=leish.getNoteEsito() %></td>
		</tr>
		<%		
	}
	%>
	<tr><td colspan="3">Aggiornato al <%=((ultimo_agg!=null ) ? sdf.format(new java.sql.Date (ultimo_agg.getTime())) : "") %></td></tr>
	<%
	
}
else
{
%>
<tr>
<td colspan="3"> Nessun Esame per Leishmaniosi presente </td>
</tr>
<%	
}

%>

</table>
  <dhv:pagedListControl object="esitiLeishListInfo"/>
