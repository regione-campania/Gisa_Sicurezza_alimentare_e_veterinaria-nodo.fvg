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


<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
	<tr>
		<td width="100%"><a href="AnimaleAction.do"><dhv:label
			name="">Anagrafe animali</dhv:label></a> > <dhv:label name="">REGISTRO UNICO CANI A RISCHIO ELEVATO DI AGGRESSIVITA'</dhv:label>
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
			<th width="25%" nowrap><strong><dhv:label name="">Microchip</dhv:label></strong>
			</th>
			<th width="25%" nowrap><strong><dhv:label name="">Id evento</dhv:label></strong>
			</th>
			<th width="25%" nowrap><strong><dhv:label name="">Evento</dhv:label></strong>
			</th>
			<th width="25%"><strong><dhv:label name="">Data registrazione</dhv:label></strong>
			</th>
		</tr>
	</thead>
	<tbody>
		<%
			Iterator<RegistroUnico> itr = registri.iterator();
			if (itr.hasNext()) {
				int rowid = 0;
				int i = 0;
				while (itr.hasNext()) {
					i++;
					rowid = (rowid != 1 ? 1 : 2);
					RegistroUnico registro = itr.next();
		%>
		<tr class="row<%=rowid%>">
			<td width="25%" nowrap><a href="javascript:popURL('AnimaleAction.do?command=DetailRegistroUnico&idEvento=<%=registro.getIdEvento()%>&popup=true&viewOnly=true','AccountDetails','650','500','yes','yes');">
						<%=registro.getMicrochip()%></a></td>
			<td width="25%" nowrap><%=registro.getIdEvento()%></td>
			<td width="25%" nowrap><%=registro.getEvento()%></td>
			<td width="25%" nowrap><%=toDateasString(registro.getDataRegistrazione()) %></td>
		</tr>
		<%
			}
			} 
		%>
	</tbody>
</table>
<dhv:pagedListControl object="registriListInfo" />