<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
<jsp:useBean id="listaOperatoriStorico" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="Stabilimento" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request"/>
<jsp:useBean id="Relazione" class="org.aspcfs.modules.sintesis.base.SintesisRelazioneLineaProduttiva" scope="request"/>
<jsp:useBean id="Errore" class="java.lang.String" scope="request"/>

<%@ page import="org.aspcfs.modules.sintesis.base.*" %>

<%@ page import="org.aspcfs.modules.gestioneml.base.*" %>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<%@ include file="../../utils23/initPage.jsp"%>

<script>
function listaOperatori(relid){
	loadModalWindow();
	window.location.href="StabilimentoSintesisMercatoAction.do?command=ListaOperatoriMercatoLinea&idRelazione="+relid;
}

function dettaglio(id, tab){
	window.opener.loadModalWindow();
	
	var windowMercato = window.open('', 'windowMercato');
	windowMercato.focus();
	
	window.opener.location.href="OpuStab.do?command=Details&stabId="+id;

}

</script>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>



<% if (listaOperatoriStorico.size()==0) {%>
<script>
alert('Non sono presenti operatori nello storico di questo box.');
listaOperatori('<%=Relazione.getIdRelazione()%>');
</script>
<% } %>

<center>
<a href="#" onClick="listaOperatori('<%=Relazione.getIdRelazione()%>')">Torna alla lista operatori</a><br/><br/>

<i>Storico operatori associati al Mercato:</i><br/>
<b><%=Relazione.getPathCompleto().replace("->", "-><br/>") %></b><br/>
<i>sullo stabilimento:</i> <br/>
<b><%=Stabilimento.getDenominazione() %></b><br/>
<i>all'indirizzo:</i> <br/>
<b><%=Stabilimento.getIndirizzo().getDescrizioneToponimo() %> <%=Stabilimento.getIndirizzo().getVia() %> <%=(Stabilimento.getIndirizzo().getCivico()!=null) ? ", "+Stabilimento.getIndirizzo().getCivico() : "" %>, <%=Stabilimento.getIndirizzo().getDescrizioneComune() %>, <%=Stabilimento.getIndirizzo().getDescrizione_provincia() %></b>
</center>

<br/><br/>

<table id="operatori" class="details" width="60%"cellpadding="10" cellspacing="10" style="border-collapse: collapse">
<col width="10%"><col width="40%"><col width="30%">

<tr><th>Num. Box</th> <th>Ragione Sociale</th> <th>Identificativo</th> <th>Stato</th></tr>

<%
	for (int i = 0; i<listaOperatoriStorico.size(); i++){ 
	SintesisOperatoreMercato operatore = null;
	operatore = (SintesisOperatoreMercato) listaOperatoriStorico.get(i);
	if (operatore != null) {
%>
	
<tr>
<td><%=operatore.getNumBox() %></td>


<% if (operatore.getTrashedDate()==null) {%>
<td><a href="#" onClick="dettaglio('<%=operatore.getRiferimentoIdOperatore()%>', '<%=operatore.getRiferimentoIdNomeTabOperatore()%>')"><%= (operatore.getOpuStabilimento()!=null) ? operatore.getOpuStabilimento().getOperatore().getRagioneSociale() : (operatore.getOrgStabilimento()!=null) ? operatore.getOrgStabilimento().getName() : ""  %></a></td>
<% }  else {%>
<td><%= (operatore.getOpuStabilimento()!=null) ? operatore.getOpuStabilimento().getOperatore().getRagioneSociale() : (operatore.getOrgStabilimento()!=null) ? operatore.getOrgStabilimento().getName() : ""  %></td>
<% } %>

<td><%=operatore.getIdentificativo() %></td> 
<td> 
<% if (operatore.getTrashedDate()!=null){  %>
CANCELLATO <br/>(<dhv:username id="<%= operatore.getTrashedBy() %>" /> <br/><%=toDateasString(operatore.getTrashedDate()) %>) 
<% } else if (operatore.getDataCessazione()!=null) { %>
CESSATO <br/>(<dhv:username id="<%= operatore.getCessatoBy() %>" /> <br/><%=toDateasString(operatore.getDataCessazione()) %>) 
<% } %>
</td> 
</td>
</tr>

<% }
} %>


</table>