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
  --%>
 
<%@page import="java.util.Iterator"%>
<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%><html>
<jsp:useBean id="OperatoreAdd" class="org.aspcfs.modules.opu.base.Operatore" scope="request" /> <!-- sede inserita -->
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<!-- Gestire campi diversi per sedi diverse in base a tipologia sede in SedeAdded -->
<%@ include file="../utils23/initPage.jsp" %>
<%@ include file="../utils23/initPopupMenu.jsp" %>

<script type="text/javascript">
function setOperatorePopUp(idOperatore)
{
	if (window.opener.document != null)
	{
		window.opener.document.getElementById('id_operatore').value = idOperatore;
		window.opener.document.getElementById('idOperatore').value=idOperatore;
		window.opener.document.forms[0].doContinueStab.value = 'false';
		window.opener.loadModalWindow();
		window.opener.document.forms[0].submit();
		window.close();
		
	}
	
}
setOperatorePopUp(<%=OperatoreAdd.getIdOperatore()%>);
</script>
<body>

