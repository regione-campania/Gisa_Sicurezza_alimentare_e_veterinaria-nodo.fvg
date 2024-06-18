<%@page import="org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page import="java.util.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.assets.base.*,org.aspcfs.modules.servicecontracts.base.*,org.aspcfs.modules.anagrafe_animali.base.*"%>

<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
<jsp:useBean id="schede" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="schedadecessoListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="causeDecessoList" class="org.aspcfs.utils.web.LookupList" scope="request" />


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



<link rel="stylesheet" type="text/css"
	href="extjs/resources/css/ext-all.css" />

<table class="details" cellpadding="4" cellspacing="0" border="0"
	width="100%">
	<thead>
		<tr>
			<th width="25%" nowrap><strong><dhv:label name="">Microchip</dhv:label></strong>
			</th>
			<th width="25%" nowrap><strong><dhv:label name="">Data decesso</dhv:label></strong>
			</th>
			<th width="25%" nowrap><strong><dhv:label name="">Causa decesso</dhv:label></strong>
			</th>
			<th width="25%" nowrap><strong><dhv:label name="">Operazioni</dhv:label></strong>
			</th>
		</tr>
	</thead>
	<tbody>
		<%
			Iterator<SchedaDecesso> itr = schede.iterator();
			if (itr.hasNext()) {
				int rowid = 0;
				int i = 0;
				while (itr.hasNext()) {
					i++;
					rowid = (rowid != 1 ? 1 : 2);
					SchedaDecesso scheda = itr.next();
		%>
		<tr class="row<%=rowid%>">
			<td width="25%" nowrap><%=scheda.getAnimale().getMicrochip()%></a></td>
			<td width="25%" nowrap><%=toHtmlValue(toDateasString(scheda.getDataDecesso()))%></td>
			<td width="25%" nowrap><%=causeDecessoList.getSelectedValue(scheda.getIdCausa())%></td>
			<td width="25%" nowrap><a href="SchedaDecesso.do?command=Detail&id=<%=scheda.getId()%>">Dettaglio</a></td>
		</tr>
		<%
			}
			} 
		%>
	</tbody>
</table>
<dhv:pagedListControl object="registriListInfo" />