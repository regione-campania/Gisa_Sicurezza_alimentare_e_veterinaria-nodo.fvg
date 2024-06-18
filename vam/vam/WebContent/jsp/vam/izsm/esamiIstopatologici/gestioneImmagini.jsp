<%@page import="it.us.web.bean.vam.EsameIstopatologico"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>

<div class="">
	<form id="fileupload" action="vam.accettazione.UploadImg.us" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="classRef" value="<%=EsameIstopatologico.class.getCanonicalName() %>" />
		<input type="hidden" name="idClass" value="${esame.id }" />
		<c:choose>
			<c:when test="${cc!=null}">
				<input type="hidden" name="idAccettazione" value="${cc.accettazione.id}" />
			</c:when>
			<c:otherwise>
				<input type="hidden" name="idAccettazione" value="${esame.cartellaClinica.accettazione.id}" />			
			</c:otherwise>
		</c:choose>
	    <div class="row" style="height: 20px">
	        <div class="span13 fileupload-buttonbar">
	            <div class="progressbar fileupload-progressbar" style="width: 400px"><div style="width:0%;"></div></div>
	            <span class="btn success fileinput-button">
	                <span>Aggiungi immagini...</span>
	                <input type="file" name="files[]" multiple>
	            </span>
	            <span class="btn info fileinput-button">
	                <span>Chiudi Finestra</span>
	                <input type="button" onclick="javascript:window.close();" />
	            </span>
	            
	        </div>
	    </div>
	    <br>
	    <div class="row">
	        <div class="span14">
	            <table class="zebra-striped"><tbody class="files"></tbody></table>
	        </div>
	    </div>
	</form>
</div>
