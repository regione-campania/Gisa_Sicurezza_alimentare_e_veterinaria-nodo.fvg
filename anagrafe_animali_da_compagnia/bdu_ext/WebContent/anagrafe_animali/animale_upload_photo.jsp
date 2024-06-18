<jsp:useBean id="animale"
	class="org.aspcfs.modules.anagrafe_animali.base.Animale"
	scope="request" />
<html>
<head>
<title>Caricamento immagine</title>
</head>
<body>
<h3>File Upload:</h3>
Seleziona un'immagine da caricare: <br />
<form action="UploadServlet" method="post"
                        enctype="multipart/form-data">
<input type="file" name="file" size="50" />
<input type="hidden" value="<%=animale.getMicrochip() %>" name="microchip" id="microchip"/>
<br />
<input type="submit" value="Invia" />
</form>

<table>
<tr>
		<td>
		Il caricamento dell'immagine cancella qualsiasi altra immagine precedentemente caricata per il microchip</br>  
		Il file deve essere esclusivamente un'immagine con estensione .jpg. Altri file o formati verranno esclusi. </br>
		
		</td>
		</tr>
		<BR/>
		<tr>
		<td><label><font color="red" size ="3">Il sistema ridimensionerà immagini eccessivamente grandi</font></label></td>
		</tr>
</table>
</body>
</html>