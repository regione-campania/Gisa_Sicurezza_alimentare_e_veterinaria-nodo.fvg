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

 
 <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details" id = "tabVerbale">
    <tr>
      <th colspan="2">
        <img border="0" src="images/file.gif" align="absmiddle"><b>Verbale Riunione</b>
      </th>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        Oggetto
      </td>
      <td>
        <input type="text" name="subject1"  required="required" size="59" maxlength="255" value="<%= toHtmlValue((String)request.getAttribute("subject1")) %>"><font color="red">*</font>
        <%= showAttribute(request, "subjectError") %>
      </td>
    </tr>
      <tr class="containerBody">
      <td class="formLabel">
       File
       (Max. <%=maxSizeString %> MB)
       
      </td>
      <td>
        <input type="file" id="file1" name="file1" size="45"  required="required">  <a href="#" onclick="rimuoviFile(1); return false;"><img src="images/delete.gif"></a>
      
      </td>
    </tr>
    
  </table>
  
  <br/>
  <jsp:include page="allegaAltriFileRiunione.jsp"/>
  

