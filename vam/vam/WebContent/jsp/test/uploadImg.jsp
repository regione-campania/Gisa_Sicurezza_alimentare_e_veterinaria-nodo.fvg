<%@page import="it.us.web.bean.vam.Autopsia"%>

<div class="">
	<form id="fileupload" action="vam.accettazione.UploadImg.us" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="classRef" value="<%=Autopsia.class.getCanonicalName() %>" />
		<input type="hidden" name="idClass" value="1" />
		<input type="hidden" name="idAccettazione" value="1" />
		<input type="hidden" name="" value="">
	    <div class="row" style="height: 20px">
	        <div class="span16 fileupload-buttonbar">
	            <div class="progressbar fileupload-progressbar" style="width: 600px"><div style="width:0%;"></div></div>
	            <span class="btn success fileinput-button">
	                <span>Aggiungi immagini...</span>
	                <input type="file" name="files[]" multiple>
	            </span>
	            <%--
	            <button type="submit" class="btn primary start">Avvia upload</button>
	            <button type="reset" class="btn info cancel">Annulla upload</button>
	            <button type="button" class="btn danger delete">Elimina selezionati</button>
	            <input type="checkbox" class="toggle">
	            --%>
	        </div>
	    </div>
	    <br>
	    <div class="row">
	        <div class="span16">
	            <table class="zebra-striped"><tbody class="files"></tbody></table>
	        </div>
	    </div>
	</form>
</div>
