<% 
int riferimentoId = Integer.parseInt(request.getParameter("riferimentoId"));
String riferimentoIdNomeTab = request.getParameter("riferimentoIdNomeTab");
String typeView = request.getParameter("typeView");
%>

<script>
function openRegistro(rifId, rifTab){
	var res;
	var result;
	loadModalWindow();
	window.location.href="GestioneRegistroCaricoScarico.do?command=Scelta&riferimentoId="+rifId+"&riferimentoIdNomeTab="+rifTab;
		
}
</script>

<%
	if(typeView!=null && typeView.equals("button"))
	{
%>
		<input style="width:250px" value="Visualizza Registro Carico/Scarico" type="button" onClick="openRegistro('<%=riferimentoId%>', '<%=riferimentoIdNomeTab%>');return false;"/>
<%
	}
	else
	{}
%>