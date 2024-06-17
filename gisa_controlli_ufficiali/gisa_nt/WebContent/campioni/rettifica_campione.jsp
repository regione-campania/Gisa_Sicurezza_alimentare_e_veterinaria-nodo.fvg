<jsp:useBean id="Campione" class="org.aspcfs.modules.campioni.base.Ticket" scope="request"/>
<jsp:useBean id="messaggio" class="java.lang.String" scope="request"/>
<jsp:useBean id="MotivazioniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="MotivazioniPianiList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<%@page import="org.aspcfs.modules.campioni.base.Analita"%>
<%@page import="org.aspcfs.utils.web.LookupList"%>

<%@ include file="../../utils23/initPage.jsp" %>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<script>
function gestisciMotivazioneCampione(motivazione){
	
	if (motivazione.value == "89") {
		document.getElementById("idMotivazionePianoCampione").style.display="block"; 
	} 
	else { 
		document.getElementById("idMotivazionePianoCampione").style.display="none";
	}
}

function annulla(id){
	if (confirm('Le modifiche saranno annullate.')){
		loadModalWindow();
		window.location.href = "Vigilanza.do?command=CampioneDetails&id="+id;
	}
}

function checkForm(form){
	
	if (form.idMotivazioneCampione.value == "-1"){
		alert("Inserire una motivazione campione.");
		return false;
	}	
	
	if (form.idMotivazioneCampione.value == "89" && form.idMotivazionePianoCampione.value == "-1"){
		alert("Inserire una motivazione campione.");
		return false;
	}
	
	if (form.idMatrice_1 == null || form.idMatrice_1.value == "-1"){
		alert("Inserire una matrice.");
		return false;
	}
	
	if (form.analitiId_1 == null || form.analitiId_1.value == "-1"){
		alert("Inserire un tipo di analisi.");
		return false;
	}
	
	if (confirm('Salvare le modifiche?')){
		loadModalWindow();
		form.submit();
	}
}

</script>


<% if (messaggio!= null && !messaggio.equals("")){ %>
<script>
alert("<%=messaggio %>");
</script>
<% if (messaggio.startsWith("OK")){ %>
<script>
loadModalWindow();
window.location.href = "Vigilanza.do?command=CampioneDetails&id=<%=Campione.getId()%>";
</script>
<% } } %>

<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<td>
 <a href="Vigilanza.do?command=TicketDetails&id=<%=Campione.getIdControlloUfficiale()%>">Controllo Ufficiale</a> >
 <a href="Vigilanza.do?command=CampioneDetails&id=<%=Campione.getId()%>">Campione</a> >
Rettifica
</td>
</tr>
</table>
<%-- End Trails --%>


<form action="Vigilanza.do?command=InsertRettificaCampione" method="post">

<table class="details" width="100%" cellpadding="10" cellspacing="10" style="border-collapse: collapse">

<tr><th colspan="2">SCHEDA CAMPIONE</th></tr>
<tr><td class="formLabel">Id Controllo Ufficiale</td><td><%=Campione.getIdControlloUfficiale() %></td></tr>
<tr><td class="formLabel">Id Campione</td><td><%=Campione.getId() %></td></tr>
<tr><td class="formLabel">Identificativo Campione</td><td><%=Campione.getIdentificativo()%></td></tr>

<tr><th colspan="2">DATI ATTUALMENTE PRESENTI</th></tr>

<tr>
<td class="formLabel">Motivazione campione</td>
<td>

<%
LookupList listaPiani = (LookupList)request.getAttribute("Piani2");
%>

<%=MotivazioniList.getSelectedValue(Campione.getMotivazione_campione())%>

<% if (Campione.getMotivazione_piano_campione()>0){ %> 
      	<%=listaPiani.getSelectedValue(Campione.getMotivazione_piano_campione())%>
    <%  }%> 
 
</td>
</tr>

<tr>
<td class="formLabel">Matrice</td>
<td>

<%
HashMap<Integer,String> matrici= Campione.getMatrici();
Iterator<Integer> itMatrici = matrici.keySet().iterator();
int i = 0 ;
while(itMatrici.hasNext()){
							i++ ;
							int chiave = itMatrici.next();
							String descrizione = Campione.getMatrici().get(chiave);
							out.print(i+") "+descrizione+"<br/>");
						}
						%>
						<% if(i==0){%>
							N.D
<% } %>
</td>
</tr>

<tr>
<td class="formLabel">Tipo di analisi</td>
<td>
<%
i=0 ;
ArrayList<Analita> tipi= Campione.getTipiCampioni();
for(Analita a : tipi)
						{
							i++ ;
							int chiave = a.getIdAnalita();
							String descrizione = a.getDescrizione();
							out.print(+i+") "+descrizione+"<br/>");
						
						}
%>
</td>
</tr>

<tr><th colspan="2">MODIFICHE</th></tr>


<tr>
<td class="formLabel">Motivazione campione</td>
<td>

<% MotivazioniList.setJsEvent("onchange= gestisciMotivazioneCampione(this)"); %>
<%= MotivazioniList.getHtmlSelect("idMotivazioneCampione",-1) %>

<% MotivazioniPianiList.setJsEvent("style=\"display:none;\""); %>
<%= MotivazioniPianiList.getHtmlSelectWithdisabled("idMotivazionePianoCampione","-1") %>
        
</td>
</tr>
<%@ include file="/campioni/matrici_analiti_tree.jsp" %>


<tr><td colspan="2" align="center">
<input type="button" value="Annulla" onClick="annulla('<%=Campione.getId()%>'))"/>
<input type="button" value="Conferma" onClick="checkForm(this.form)"/>
</td></tr>

</table>

<input type="hidden" id="idCampione" name="idCampione" value="<%=Campione.getId()%>"/>

</form>