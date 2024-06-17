 <%
 					int maxFileSize=-1;
 					int mb1size = 1048576;
  					maxFileSize=Integer.parseInt(org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("MAX_SIZE_ALLEGATI"));
 					String maxSizeString = String.format("%.2f", (double) maxFileSize/ (double) mb1size);
 					%>
 					
 					
  <script>
function checkFile(file){
var fileCaricato = file;
var errorString = '';

if (!GetFileSize(fileCaricato))
	errorString+='\nErrore! Selezionare un file con dimensione superiore a 0 ed inferiore a <%=maxSizeString%> MB';
if (errorString!= ''){
	alert(errorString)
	file.value = null;
}
}

function GetFileSize(fileCaricato) {
var input = fileCaricato;
  file = input.files[0];
  if (file.size == 0 || file.size> <%=Integer.parseInt(org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("MAX_SIZE_ALLEGATI"))%>)
	 	return false;
  return true;
	}
</script>					