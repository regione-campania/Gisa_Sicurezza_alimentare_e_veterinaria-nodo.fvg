 
 <%@ include file="../../utils23/initPage.jsp"%>
  <%
       int maxFileSize=-1;
	   int mb1size = 1048576;
	    maxFileSize=Integer.parseInt(org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("MAX_SIZE_ALLEGATI"));
	   	String maxSizeString = String.format("%.2f", (double) maxFileSize/ (double) mb1size);
       %>
       
       <script>
       
       function rimuoviFile(id){
    	   document.getElementById("file"+id).value="";
       }
       
       
function GetFileSize(fileid) {
	var input = document.getElementById('file1');
        file = input.files[0];
        if (file.size> <%=Integer.parseInt(org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("MAX_SIZE_ALLEGATI"))%>)
      	 	return false;
        return true;
		}
</script>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="2">
        <img border="0" src="images/file.gif" align="absmiddle"><b>Allega Allegati</b>
      </th>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        Oggetto
      </td>
      <td>
        <input type="text" name="subject2" size="59" maxlength="255" value="<%= toHtmlValue((String)request.getAttribute("subject2")) %>">
        <%= showAttribute(request, "subjectError") %>
      </td>
    </tr>
      <tr class="containerBody">
      <td class="formLabel">
       File
       (Max. <%=maxSizeString %> MB)
       
      </td>
    <td>
        <input type="file" id="file2" name="file2" size="45">   <a href="#" onclick="rimuoviFile(2); return false;"><img src="images/delete.gif"></a>
      </td>
    </tr>
     
    <tr class="containerBody">
      <td class="formLabel">
        Oggetto
      </td>
      <td>
        <input type="text" name="subject3" size="59" maxlength="255" value="<%= toHtmlValue((String)request.getAttribute("subject3")) %>">
        <%= showAttribute(request, "subjectError") %>
      </td>
    </tr>
      <tr class="containerBody">
      <td class="formLabel">
       File
       (Max. <%=maxSizeString %> MB)
       
      </td>
     <td>
        <input type="file" id="file3" name="file3" size="45">   <a href="#" onclick="rimuoviFile(3); return false;"><img src="images/delete.gif"></a>
      </td>
    </tr>
    
     <tr class="containerBody">
      <td class="formLabel">
        Oggetto
      </td>
      <td>
        <input type="text" name="subject4" size="59" maxlength="255" value="<%= toHtmlValue((String)request.getAttribute("subject4")) %>">
        <%= showAttribute(request, "subjectError") %>
      </td>
    </tr>
      <tr class="containerBody">
      <td class="formLabel">
       File
       (Max. <%=maxSizeString %> MB)
       
      </td>
       <td>
        <input type="file" id="file4" name="file4" size="45">   <a href="#" onclick="rimuoviFile(4); return false;"><img src="images/delete.gif"></a>
      </td>
    </tr>
    
     <tr class="containerBody">
      <td class="formLabel">
        Oggetto
      </td>
      <td>
        <input type="text" name="subject5" size="59" maxlength="255" value="<%= toHtmlValue((String)request.getAttribute("subject5")) %>">
        <%= showAttribute(request, "subjectError") %>
      </td>
    </tr>
      <tr class="containerBody">
      <td class="formLabel">
       File
       (Max. <%=maxSizeString %> MB)
       
      </td>
       <td>
        <input type="file" id="file5" name="file5" size="45">   <a href="#" onclick="rimuoviFile(5); return false;"><img src="images/delete.gif"></a>
      </td>
    </tr>
    
     <tr class="containerBody">
      <td class="formLabel">
        Oggetto
      </td>
      <td>
        <input type="text" name="subject6" size="59" maxlength="255" value="<%= toHtmlValue((String)request.getAttribute("subject6")) %>">
        <%= showAttribute(request, "subjectError") %>
      </td>
    </tr>
      <tr class="containerBody">
      <td class="formLabel">
       File
       (Max. <%=maxSizeString %> MB)
       
      </td>
       <td>
        <input type="file" id="file6" name="file6" size="45">  <a href="#" onclick="rimuoviFile(6); return false;"><img src="images/delete.gif"></a>
      </td>
    </tr>  
  </table>
  