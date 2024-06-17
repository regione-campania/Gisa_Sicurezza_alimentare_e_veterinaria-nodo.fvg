<% 
int riferimentoId = Integer.parseInt(request.getParameter("riferimentoId"));
String riferimentoIdNomeTab = request.getParameter("riferimentoIdNomeTab");
%>

<script>
function openPopupSchedeSupplementari(url){
	var res;
	var result;
		window.open(url,'popupSelectSchedeSupplementari',
		'height=400px,width=1300px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=no ,modal=yes');
		
}
</script>

<input style="width:250px" value="Gestione Schede Supplementari" type="button" onClick="openPopupSchedeSupplementari('GestioneSchedeSupplementari.do?command=Lista&riferimentoId=<%=riferimentoId%>&riferimentoIdNomeTab=<%=riferimentoIdNomeTab%>');return false;"/>
