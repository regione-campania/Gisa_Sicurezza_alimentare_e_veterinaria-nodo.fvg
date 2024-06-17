<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<table class="trails" cellspacing="0">
<tr>
	<td>
		<a href="Parafarmacie.do?command=SearchFormFcie">
		Farmacie / Grossisti / Parafarmacie
		</a> >
		<a href="Parafarmacie.do?command=Details&idFarmacia=${altId}&opId=${altId}&orgId=${altId}">
			Scheda Operatore Parafarmacia
		</a> 
		> Importa in Anagrafica stabilimenti	
	</td>
</tr>
</table>

<center>
<h2>SELEZIONEARE LA LINEA DI ATTIVITA' CON CUI IMPORTARE LO STABILIMENTO</h2>
	<select id="linee" name="linee" style="max-width: 100%;" onchange="mostra_prosegui()">
		<option value=""></option>
		<c:forEach items="${listLinee}" var="linee">			
			<option value="${linee.id}">${linee.path_descrizione}</option>
		</c:forEach>
	</select> 
	<input type="hidden" id="altId" value="${altId}" />
	<br><br><br><br><br><br><br><br><br>
	<button type="button" class=""
		id="button_prosegui" 
		style="display: none;" 
		onClick="vai_a_import()">PROSEGUI</button>
		
	<button type="button" class="yellowBigButton" 
		style="width: 250px;" 
		onClick="window.location.href='Parafarmacie.do?command=Details&idFarmacia=${altId}&opId=${altId}&orgId=${altId}'">ANNULLA</button>
	<br><br><br><br><br><br>
</center>



<script>


function vai_a_import() {
	
	loadModalWindow();			
	var id_linea = document.getElementById('linee').value;
	var alt_id = document.getElementById('altId').value;
	var link = 'GestioneAnagraficaAction.do?command=Import&altId='+alt_id+'&id_linea='+id_linea;
	window.location.href=link;

}

	   
function mostra_prosegui(){
		if(document.getElementById('linee').value != ''){
			document.getElementById('button_prosegui').setAttribute("class", "yellowBigButton");
			document.getElementById('button_prosegui').style='width: 250px; margin-right: 10%';
		} else {
			document.getElementById('button_prosegui').setAttribute("class", "");
			document.getElementById('button_prosegui').style='display: none';
		}
	}
</script>


