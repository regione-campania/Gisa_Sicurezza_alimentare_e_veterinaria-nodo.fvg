<script type="text/javascript">
function openModPnaa(orgId,idCampione,url, idC, mod){
	//var mes = document.getElementById('messaggio_pnaa').value;
	var mes = '';
	
	if( mes != '' && mes != 'null'){
		alert(mes);
	}else{
		
		  window.open('CampioniReport.do?command=ViewSchedaPNAA2&idCampione='+idCampione+'&idCU='+idC+'&orgId='+orgId+'&url='+url+'&tipo='+mod,'popupSelect',
				'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
   }				
}
</script>
 
 <script type="text/javascript">
 function openModificaPnaa(orgId,idCampione,url, idC, mod){
	//var mes = document.getElementById('messaggio_pnaa').value;
	var mes = '';
	
	if( mes != '' && mes != 'null'){
		alert(mes);
	}else{
		
		  window.open('CampioniReport.do?command=ModificaSchedaPNAA2&idCampione='+idCampione+'&idCU='+idC+'&orgId='+orgId+'&url='+url+'&tipo='+mod,'popupSelect',
				'height=600px,width=800px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
   }				
}
</script>

