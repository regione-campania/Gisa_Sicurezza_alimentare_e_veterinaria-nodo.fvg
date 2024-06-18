//suffisso max/minDate anno = Y, mese = M, giorno = D
//calendario libero
//calenda('data_x');/calenda('data_x','','');/calenda('data_x',,);
//max data oggi 
//calenda('data_inserimento',,'0');
//maggiore età 
//calenda('data_nascita',,'-18Y');
//solo data odierna 
//calenda('data','0','0');

function calenda(ele, data_min, data_max) {
	$( '#' + ele ).attr('maxlength','10');
	console.log('calendario '+ele+", "+data_min+", "+data_max);
	$( '#' + ele ).datepicker({
		showButtonPanel: true,
		closeText: "Chiudi",
		prevText: "Prec",
		nextText: "Succ",
		currentText: "Svuota",
		monthNames: [ "Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno",
			"Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre" ],
		monthNamesShort: [ "Gen", "Feb", "Mar", "Apr", "Mag", "Giu",
			"Lug", "Ago", "Set", "Ott", "Nov", "Dic" ],
		dayNames: [ "Domenica", "Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato" ],
		dayNamesShort: [ "Dom", "Lun", "Mar", "Mer", "Gio", "Ven", "Sab" ],
		dayNamesMin: [ "Do", "Lu", "Ma", "Me", "Gi", "Ve", "Sa" ],
		weekHeader: "Sm",
		dateFormat: "dd/mm/yy",
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: "",
		yearRange: "1900:+10",
		changeMonth: true,
	    changeYear: true,
		maxDate: data_max,
		minDate: data_min,
		onClose: function(){
				 	var dataSel = $('#' + ele ).val();
				 	if(dataSel != ''){
				 		var dd = ''; var mm = ''; var aaaa = '';
					 	var dataArr = dataSel.split('/');
					 	dd = dataArr[0]; mm = dataArr[1]; aaaa = dataArr[2];
					 	if(dd === undefined || mm === undefined || aaaa === undefined){
				 		        //console.log(dd.length != 2, mm.length != 2, aaaa.length != 4);
					 			alert('Inserire la data nel formato corretto. GG/MM/AAAA');
					 			//$('#' + ele).datepicker('setDate',new Date());
					 			$('#' + ele).val(new Date().toLocaleDateString(undefined, {year: 'numeric', month: '2-digit', day: '2-digit'}));
					 	}else{
					 		if(dd.length != 2 || mm.length != 2 || aaaa.length != 4){
					 			//console.log(dd.length != 2, mm.length != 2, aaaa.length != 4);
						 		alert('Inserire la data nel formato corretto. GG/MM/AAAA');
					 			$('#' + ele).val(new Date().toLocaleDateString(undefined, {year: 'numeric', month: '2-digit', day: '2-digit'}));
						 	}else{
						 		if(aaaa < 1900){
						 			alert('Impossibile inserire una data precedente al 01/01/1900');
						 			$('#' + ele).val(new Date().toLocaleDateString(undefined, {year: 'numeric', month: '2-digit', day: '2-digit'}));
						 		}else{
						 			$('#' + ele).datepicker('setDate',dataSel);
						 		}
						 	}
					 	}
					 	
				 	}
				 }
	});
	$('#' + ele).datepicker('setDate',$('#' + ele ).val());
	onSubCheck(ele);
		
}

function checkDataFine(data_inizio, data_fine) {
	if($('#' + data_inizio).val() == null || $('#' + data_inizio).val() == ''){
		if($('#' + data_inizio).attr('labelcampo') != null)
			alert("Selezionare prima una data valida per il campo:\n" + $('#' + data_inizio).attr('labelcampo') + ".");
		else
			alert("Selezionare prima una data valida.");
		
		$('#' + data_fine).blur();
		$('#' + data_fine).datepicker("hide");
		//$("#data_fine ~ .ui-datepicker").hide();
	}else{
		$('#' + data_fine).datepicker('option','minDate',$('#' + data_inizio).val());
		$('#' + data_fine).datepicker("show");
	}
}

function onSubCheck( ele ){
	var form = $('#' + ele).closest('form');
	form.submit(function ( event ){
		var dataSel = $('#' + ele ).val();
	 	if(dataSel != ''){
	 		var dd = ''; var mm = ''; var aaaa = '';
		 	var dataArr = dataSel.split('/');
		 	dd = dataArr[0]; mm = dataArr[1]; aaaa = dataArr[2];
		 	if(dd === undefined || mm === undefined || aaaa === undefined){
 		        //console.log(dd.length != 2, mm.length != 2, aaaa.length != 4);
	 			alert('Inserire la data nel formato corretto. GG/MM/AAAA');
	 			$('#' + ele).val(new Date().toLocaleDateString(undefined, {year: 'numeric', month: '2-digit', day: '2-digit'}));
		 	}else{
		 		if(dd.length != 2 || mm.length != 2 || aaaa.length != 4){
		 			//console.log(dd.length != 2, mm.length != 2, aaaa.length != 4);
			 		alert('Inserire la data nel formato corretto. GG/MM/AAAA');
		 			$('#' + ele).val(new Date().toLocaleDateString(undefined, {year: 'numeric', month: '2-digit', day: '2-digit'}));
			 	}else{
			 		if(aaaa < 1900){
			 			alert('Impossibile inserire una data precedente al 01/01/1900');
			 			$('#' + ele).val(new Date().toLocaleDateString(undefined, {year: 'numeric', month: '2-digit', day: '2-digit'}));
			 		}else{
			 			$('#' + ele).datepicker('setDate',dataSel);
			 		}
			 	}
		 	}
	    }
	});
} 