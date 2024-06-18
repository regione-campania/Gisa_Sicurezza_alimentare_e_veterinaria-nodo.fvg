<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.login.beans.UserBean, org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*" %>
<jsp:useBean id="SearchOrgListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="AccountStateSelect" class="org.aspcfs.utils.web.StateSelect" scope="request"/>
<jsp:useBean id="ContactStateSelect" class="org.aspcfs.utils.web.StateSelect" scope="request"/>
<jsp:useBean id="CountrySelect" class="org.aspcfs.utils.web.CountrySelect" scope="request"/>
<jsp:useBean id="SegmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StageList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="aslRifList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<%@ include file="../initPage.jsp" %>

<body onLoad="">
	<form name="searchRichiesta" action="PraticaContributi.do?command=Search" method="post" onSubmit="return doCheck(this);">
	<%-- Trails --%>
		<table class="trails" cellspacing="0">
			<tr>
				<td>
					<a href="PraticaContributi.do">
						<dhv:label name="">Pratica Contributi</dhv:label>
					</a> > 
						<dhv:label name="">Ricerca Pratica Contributi</dhv:label>
				</td>
			</tr>
		</table>
	<%-- End Trails --%>
	
		<table cellpadding="2" cellspacing="2" border="0" width="100%">
			<tr>
			    <td width="100%" valign="top">
			      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
       
			      </table>
				</td>    
		</table>
		<br />
		
		<input type="submit" value="<dhv:label name="button.search">Search</dhv:label>">
		<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="javascript:clearForm();">
		<input type="hidden" name="source" value="searchForm">
	</form>
</body>