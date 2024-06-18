<%@page import="it.us.web.bean.vam.Autopsia"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>

<div class="">
	<form id="fileupload" action="vam.accettazione.UploadImg.us" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="classRef" value="<%=Autopsia.class.getCanonicalName() %>" />
		<input type="hidden" id="idClass" name="idClass" value="" />
		<input type="hidden" name="idAccettazione" value="${a.cartellaClinica.accettazione.id}" />
	    <div class="row" style="height: 20px">
	        <div class="span13 fileupload-buttonbar">
	            <div class="progressbar fileupload-progressbar" style="width: 400px"><div style="width:0%;"></div></div>
	            <c:if test="${readonly==false}">
		            <span class="btn success fileinput-button">
		                <span>Aggiungi immagini...</span>
		                <input type="file" name="files[]" multiple>
		            </span>
	            </c:if>
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
	     <c:if test="${a.id==null}">
	      	<script>document.getElementById("idClass").value="-1";</script>
	     </c:if>
	     <c:if test="${a.id!=null}">
	      	<script>document.getElementById("idClass").value="${a.id }";</script>
	     </c:if>
	</form>
</div>
