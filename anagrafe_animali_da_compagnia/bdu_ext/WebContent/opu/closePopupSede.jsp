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
<html>
<jsp:useBean id="SedeAdded" class="org.aspcfs.modules.opu.base.Indirizzo" scope="request" /> <!-- sede inserita -->
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<!-- Gestire campi diversi per sedi diverse in base a tipologia sede in SedeAdded -->

<script type="text/javascript">

function submitParent(){

	if (window.opener.document.forms[0].idSedeAdded_Legale != null)
		window.opener.document.forms[0].idSedeAdded_Legale.value = '<%=SedeAdded.getIdIndirizzo()%>';

	if (window.opener.document.forms[0].idSedeAdded_Stabilimento != null)
		window.opener.document.forms[0].idSedeAdded_Stabilimento.value = '<%=SedeAdded.getIdIndirizzo()%>';

	if (window.opener.document.forms[0].doContinue != null)
		window.opener.document.forms[0].doContinue.value = 'false';
	
	window.opener.document.forms[0].submit();
	window.close();
}




</script>

<body onload="javascript:submitParent();">

