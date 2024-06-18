<form action="AnimaleAction.do" id="form">
	<input type="hidden" value="Details" name="command"/>
	<input type="hidden" value="<%=(String)request.getAttribute("animaleId") %>" name="animaleId"/>
	<input type="hidden" value="<%=(String)request.getAttribute("idSpecie") %>" name="idSpecie"/>
	<input type="hidden" value="<%=(String)request.getAttribute("Error") %>" name="errore"/>
</form>


<script type="text/javascript">
	loadModalWindow();
	document.getElementById('form').submit();
</script>