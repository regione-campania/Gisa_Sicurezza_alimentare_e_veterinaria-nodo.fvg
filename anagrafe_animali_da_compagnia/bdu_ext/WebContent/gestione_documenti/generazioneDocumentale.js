
function openRichiestaPDF(idTipo, idAnimale, idSpecie, idMicrochip, idLinea, idEvento){
	var res;
	var generaNonLista="";
	if(idTipo=="PrintAutocertificazioneMancataOrigineAnimale" && idAnimale=="-1")
		generaNonLista="&generaNonLista=ok";
	var result=
		window.open('GestioneDocumenti.do?command=GeneraPDF&tipo='+idTipo+'&IdAnimale='+idAnimale+'&IdSpecie='+idSpecie+'&idMicrochip='+idMicrochip+'&idLinea='+idLinea+'&idEvento='+idEvento+generaNonLista,'popupSelect',
		'height=200px,width=842px,left=200px, top=200px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
		var text = document.createTextNode('GENERAZIONE PDF IN CORSO.');
		span = document.createElement('span');
		span.style.fontSize = "30px";
		span.style.fontWeight = "bold";
		span.style.color ="#ff0000";
		span.appendChild(text);
		var br = document.createElement("br");
		var text2 = document.createTextNode('Attendere la chiusura di questa finestra entro qualche secondo...');
		span2 = document.createElement('span');
		span2.style.fontSize = "20px";
		span2.style.fontStyle = "italic";
		span2.style.color ="#000000";
		span2.appendChild(text2);
		result.document.body.appendChild(span);
		result.document.body.appendChild(br);
		result.document.body.appendChild(span2);
		result.focus();
}
		 

function openRichiestaPDFRichiestaErrataCorrige(id, riferimentoId, riferimentoIdNomeTab){
	
	
	var res;
	var result=
		window.open('GestioneDocumenti.do?command=GeneraPDFRichiestaErrataCorrige&id='+id+'&riferimentoId='+riferimentoId+'&riferimentoIdNomeTab='+riferimentoIdNomeTab,'popupSelect',
		'height=200px,width=842px,left=200px, top=200px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
		var text = document.createTextNode('GENERAZIONE PDF IN CORSO.');
		span = document.createElement('span');
		span.style.fontSize = "30px";
		span.style.fontWeight = "bold";
		span.style.color ="#ff0000";
		span.appendChild(text);
		var br = document.createElement("br");
		var text2 = document.createTextNode('Attendere la generazione del documento ed invio mail entro qualche secondo...');
		span2 = document.createElement('span');
		span2.style.fontSize = "20px";
		span2.style.fontStyle = "italic";
		span2.style.color ="#000000";
		span2.appendChild(text2);
		result.document.body.appendChild(span);
		result.document.body.appendChild(br);
		result.document.body.appendChild(span2);
		result.focus();
		
	}