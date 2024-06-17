<script>
function showDialogAlert(msg){
	loadModalWindow();
	$("#dialogPagoPaMessaggio").html(msg.replaceAll("\n", "<br/>"));
	$("#dialogPagoPaTR_OK").show();
	$("#dialogPagoPa").dialog({
	    resizable: true,
	    height: 'auto',
	    modal : true,
	    width: '800px',
        overflow:'auto',
	    open: function(event, ui) {
	        $(event.target).parent().css('position', 'fixed'); 
	        $(event.target).parent().css('top', '2%');
	        $(event.target).parent().css('left', '20%');
	    }

	});
}

function showDialogConfirm(msg){
	loadModalWindow();
	$("#dialogPagoPaMessaggio").html(msg.replaceAll("\n", "<br/>"));
	$("#dialogPagoPaTR_SINO").show();
	$("#dialogPagoPa").dialog({
	    resizable: true,
	    height: 'auto',
	    modal : true,
	    width: '800px',
        overflow:'auto',
	    open: function(event, ui) {
	        $(event.target).parent().css('position', 'fixed');
	        $(event.target).parent().css('top', '2%');
	        $(event.target).parent().css('left', '20%');
	    }

	});
}

function showDialogAlertClose(msg){
	loadModalWindow();
	$("#dialogPagoPaMessaggio").html(msg.replaceAll("\n", "<br/>"));
	$("#dialogPagoPaTR_OK").show();
	$("#dialogPagoPaButtonOK").on("click", function(){ window.close(); });
	$("#dialogPagoPa").dialog({
	    resizable: true,
	    height: 'auto',
	    modal : true,
	    width: '800px',
        overflow:'auto',
	    open: function(event, ui) {
	        $(event.target).parent().css('position', 'fixed'); 
	        $(event.target).parent().css('top', '2%');
	        $(event.target).parent().css('left', '20%');
	    }

	});
}

function submitForm(){
	$("#dialogPagoPaTR_SINO").hide();
	$("#dialogPagoPaButtonX").hide();
	$("#dialogPagoPaTR_WAIT").show();
	$("#formPagoPa").submit();
}

function closeDialog(){
	loadModalWindowUnlock();
	$("#dialogPagoPaTR_OK").hide();
	$("#dialogPagoPaTR_SINO").hide();
	$("#dialogPagoPaMessaggio").html("");
	$("#dialogPagoPa").dialog("close");
}
</script>

<div id="dialogPagoPa" style="display: none;" > 
<table style="border-collapse: collapse" cellpadding="10" cellspacing="10">
<tr><th style="background-color: #BDCFFF;"> <input type="button" id="dialogPagoPaButtonX" name="dialogPagoPaButtonX" value="X" style="width: 20px; font-size: 10px" onClick="closeDialog()"/> &nbsp;&nbsp;&nbsp;&nbsp; GESTIONE PAGOPA</th></tr>
<tr><td style="background-color: white" align="center"> <label id="dialogPagoPaMessaggio" style="font-size: 15px"></label> </td> </tr>
<tr id="dialogPagoPaTR_OK" style="display: none;"><td style="background-color: white" align="center"> <input type="button" id="dialogPagoPaButtonOK" name="dialogPagoPaButtonOK" value="OK" style="width: 50px; font-size: 15px" onClick="closeDialog()"/> </td> </tr>
<tr id="dialogPagoPaTR_SINO" style="display: none;"><td style="background-color: white" align="center"><input type="button" id="dialogPagoPaButtonNO" name="dialogPagoPaButtonNO" value="NO" style="width: 50px; font-size: 15px" onClick="closeDialog()"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input type="button" id="dialogPagoPaButtonSI" name="dialogPagoPaButtonSI" value="SI" style="width: 50px; font-size: 15px" onClick="submitForm()"/> </td> </tr>
<tr id="dialogPagoPaTR_WAIT" style="display: none;"><td style="background-color: white" align="center"> <img src="gestione_documenti/images/loading.gif"/> <label style="font-size: 15px">... CARICAMENTO IN CORSO ... </label> </td> </tr>
</table>
</div>