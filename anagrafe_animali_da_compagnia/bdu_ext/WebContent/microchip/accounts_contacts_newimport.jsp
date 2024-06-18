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
  - Version: $Id: accounts_contacts_newimport.jsp 15115 2006-05-31 16:47:51Z matt $
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.utils.web.*,org.aspcfs.modules.base.Constants" %>
<jsp:useBean id="ImportDetails" class="org.aspcfs.modules.microchip.base.MicrochipImport" scope="request"/>
<jsp:useBean id="SourceTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="RatingList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript">
  function doCheck(form) {
	 
    if (document.forms[0].dosubmit.value == "false") {
    	
      return true;
    } else {
    
      return(checkForm(form));
    }
  }
  function checkForm(form) {
    formTest = true;
    message = "";
   /*  alert("checkform");
    alert("1"+document.forms[0].name.value);
    
    alert("2"+document.forms[0].siteId.value);
    alert("3"+document.forms[0].id.value.length);
    alert("1"+formTest); */
    if(checkNullString(document.forms[0].name.value)) {
    	
       message += label("name.required", "- Name is a required field.\r\n");
			 formTest = false;
    }
  
    


     if(document.forms[0].siteId.value == -1 && <%= User.getRoleId()%>!=24) {
    
       message += "- Il sito è un campo richiesto.\r\n";
			 formTest = false;
    } 

    if (document.forms[0].id.value.length < 5) {
    
      message += label("file.required", "- File is required\r\n");
      formTest = false;
    }
    
    if (formTest == false) {
    	
      alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
     
      return false;
    }else{
    	
    	document.forms[0].submit();
    	 return true;
/*  		if (document.forms[0].upload.value != label("button.pleasewait",'Please Wait...')) {
    	  	  document.forms[0].upload.value=label("button.pleasewait",'Please Wait...');
        return true; 
      } else {
        return false;
      }  */
    }
  }
  
  function checkfile(sender) {
	    var validExts = new Array(".csv", ".txt");
	    var fileExt = sender.value;
	    fileExt = fileExt.substring(fileExt.lastIndexOf('.'));
	    if (validExts.indexOf(fileExt) < 0) {
	      alert("File non valido, file validi sono csv o txt " );
	      sender.value=null;
	      return false;
	    }
	    else return true;
	}
</script>
<body onLoad="javascript:document.inputForm.name.focus();">
<form method="post" name="inputForm" action="MicrochipImports.do?command=Save" enctype="multipart/form-data" >
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
  <td>
    <a href="MicrochipImports.do"><dhv:label name="">Microchip</dhv:label></a> >
    <a href="MicrochipImports.do?command=View"><dhv:label name="accounts.ViewImports">View Imports</dhv:label></a> >
    <dhv:label name="contacts.companydirectory_confirm_importupload.NewImport">New Import</dhv:label>
  </td>
</tr>
</table>
<%-- End Trails --%>
<%= showError(request, "actionError", false) %>
<%--  include basic contact form --%>
<% if ( User.getRoleId() != 24 ) { %> <!-- NON E' UN LP -->
	<%@ include file="./import_include.jsp" %>
<% }else{ %>
	<%@ include file="./import_vet_include.jsp" %>
<% } %>
<br />
<input type="button" value="<dhv:label name="global.button.save">Save</dhv:label>" name="upload" onClick="checkForm();">
<input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='MicrochipImports.do?command=View';this.form.dosubmit.value='false';">
<input type="hidden" name="dosubmit" value="true">
</form>
</body>
