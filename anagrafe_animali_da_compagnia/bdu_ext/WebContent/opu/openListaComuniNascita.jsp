<script type="text/javascript">
function openListaComuniNascita(){
	var res;
	var result;

if (true) {
	window.open('opu/listaComuniNascita.jsp','popupSelect',
	'height=595px,width=400px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	
	
	} else {
	
		res = window.showModalDialog('opu/listaComuniNascita.jsp','popupSelect',
		'dialogWidth:400px;dialogHeight:400px;center: 1; scroll: 0; help: 1; status: 0');
	
	}
}
	
</script>

<img src="javascript/reveal/Question_Mark.png" border="0"
			align="absmiddle" height="16" width="16" />
		<a href="#"
			onclick="openListaComuniNascita();"
			id="" target="_self">Lista comuni di nascita presenti in banca dati</a>
	