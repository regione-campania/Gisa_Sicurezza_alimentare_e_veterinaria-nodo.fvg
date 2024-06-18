<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: accounts_add.jsp 18488 2007-01-15 20:12:32Z matt $
  - Description:
  --%>
  
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.allevamenti.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.contacts.base.*" %>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StageList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SpecieList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<jsp:useBean id="RatingList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="IndustryList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgPhoneTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgAddressTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgEmailTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AccountTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.allevamenti.base.Organization" scope="request"/>
<jsp:useBean id="StateSelect" class="org.aspcfs.utils.web.StateSelect" scope="request"/>
<jsp:useBean id="CountrySelect" class="org.aspcfs.utils.web.CountrySelect" scope="request"/>
<jsp:useBean id="AccountSizeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SalutationList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SegmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SICCodeList" class="org.aspcfs.modules.admin.base.SICCodeList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<jsp:useBean id="TimeZoneSelect" class="org.aspcfs.utils.web.HtmlSelectTimeZone" scope="request"/>
<jsp:useBean id="systemStatus" class="org.aspcfs.controller.SystemStatus" scope="request"/>
<jsp:useBean id="ErroreImport" class="java.lang.String" scope="request"/>

<%@ include file="../utils23/initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkNumber.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkEmail.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popCheckList.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkURL.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/setSalutation.js"></script>

<table class="trails" cellspacing="0">
<tr>
<td width="100%">
<a href="Allevamenti.do">Allevamenti</a> >
Ricerca in BDN
</td>
</tr>
</table>

<%if (ErroreImport!=null && !ErroreImport.equals("null") && !ErroreImport.equals("")) {%>
<script>
alert ("<%=ErroreImport%>");
</script>
<%} %>

<form method="post" action = "Allevamenti.do?command=ToInterrogaBDN" onsubmit="javascript:if(this.cod_azienda.value==''){alert('Inserire il codice Azienda');return false;} return true ;">

<table>

<tr>
<td>Codice Azienda</td>
<td><input type = "text" name = "cod_azienda"></td>
</tr>

<tr>
<td>Specie</td>
<td>
<select id="specie" name="specie">
<%for (int i = 0 ; i < SpecieList.size(); i++){
  LookupElement el = (LookupElement)SpecieList.get(i);
  String chiave = "-1";
  if (el.getCode() > 0)
  	 chiave = el.getShort_description();
  if (chiave.startsWith("0"))
	  chiave = chiave.substring(1, chiave.length());
  
  if (el.getAlt_Short_description() == null || "".equals(el.getAlt_Short_description())){ %>
	<option value="<%=chiave%>"><%=el.getDescription() %></option>
	<%} %>	
<%}%>
</select>
</td>
</tr>

</table>
<input type = "submit" value = "Ricerca in Bdn">

</form>
