<table>
<tr ><td colspan="4">
<br>
<label><b><font size="2">Verifica Esistenza stabilimento</b></label><br>
Num.registrazione 852: &nbsp;&nbsp;<input type="text" value="" id="num_registrazione" size="40"/>&nbsp;&nbsp;
<input type="button" id="invia" value="PROSEGUI" onclick="verificaNumRegistrazione()"/></font>
</td></tr>
</table>

<script>

$('#vecchioNumero').hide();

function intercettaPregresso(){
	$('#vecchioNumero').show();
	
}

function verificaNumRegistrazione(){
	if ($('#num_registrazione').val()==""){
		goTo('OpuStab.do?command=CaricaImport&pregresso=true');
	}else{
		loadModalWindowCustom("Verifica Esistenza Num. Registrazione. Attendere");
		$.ajax({
            url : 'opu/verifica852.jsp', // Your Servlet mapping or JSP(not suggested)
            data : 'numRegistrazione='+$('#num_registrazione').val().trim(), 
            type : 'POST',
            dataType : 'text', // Returns HTML as plain text; included script tags are evaluated when inserted in the DOM.
            success : function(response) {
            	if(response.indexOf("NONPRESENTE") > -1 ){
                	//alert("Numero di registrazione 852 non trovato. Si procederà all'operazione.")
               goTo('OpuStab.do?command=CaricaImport&pregresso=true&'); /*perche c'e' & finale ? */
               }else{
                 	alert("ATTENZIONE! Esiste già uno stabilimento registrato 852 con il numero inserito. \nSe lo si vuole aggiungere a quelli di nuova gestione, bisogna fare richiesta di import, contattando l'HelpDesk.");
                        }
                loadModalWindowUnlock(); 
            },
            error : function(request, textStatus, errorThrown) {
                alert(errorThrown);
                loadModalWindowUnlock(); 
            }
        });
	   
	}
}

</script>



