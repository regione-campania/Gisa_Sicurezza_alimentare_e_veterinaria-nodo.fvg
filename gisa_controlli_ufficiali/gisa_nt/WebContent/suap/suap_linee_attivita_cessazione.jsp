<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>
<%@page import="org.aspcfs.modules.suap.base.LineaProduttivaList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.sql.Timestamp"%>

<jsp:useBean id="newStabilimento" class="org.aspcfs.modules.suap.base.Stabilimento" scope="request" />
<jsp:useBean id="StabilimentoOpu" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request"/>

<%@ include file="../utils23/initPage.jsp" %>

<script type="text/javascript" src="suap/javascriptsuap/suap_linee.js"></script>


<input type="hidden" value="false" id="validatelp">

<fieldset id="operazione">

<% Timestamp maxDate = StabilimentoOpu.getDataInizioAttivita(); %>
<b>Data Inizio Attivita': </b><%=toDateasString(maxDate) %>
	<h1>
		<!-- <center>CHIUSURA STABILIMENTO O DI UNA O PIU' LINEE DI ATTIVITA'</center> -->
		<center>INSERIRE LA DATA DI CESSAZIONE<br>
		<input type="text" size="15" name="dataFineAttivitaCessazione" required="required" id="dataCessazione" placeholder="dd/MM/YYYY" readonly> 
	<script> $(function() {	$('#dataCessazione').datepick({dateFormat: 'dd/mm/yyyy', minDate: new Date('<%=maxDate%>'),  showOnFocus: false, showTrigger: '#calImg',  onClose: controlloDataCessazione }); }); </script>
	<div style="display: none;"> 
    &nbsp;&nbsp;<img id="calImg" src="images/cal.gif" alt="Popup" class="trigger">
    </div> 
	</h1>
</fieldset>

<br>
<br>
<fieldset id="secondarie">
	<legend><b>CESSAZIONE ATTIVITA'</b></legend>
	
	<table style="width: 100%;">
	<tr><td>SI INTENDE CESSARE L'INTERO STABILIMENTO? &nbsp; &nbsp; &nbsp; &nbsp;<input type="checkbox" id="cessazioneStabilimento" name="cessazioneStabilimento" onClick="gestisciCessazione(this)"/></td>
	<td>
	<div id="divCessazione" style="display:none">
	</div>
	
	</td>
	</tr>
	</table>
	
	<%
	if(StabilimentoOpu.getIdStabilimento()<=0){
	%>
		<table style="width: 100%; display: inline-block " id="tableQualeLinea">
			<tr>
				<td width="50%" align="left">INDICARE LE LINEE DI ATTIVITA CHE SI INTENDE CESSARE</td>
				<td align="left"><input type="button" value="SELEZIONA ATTIVITA DA CESSARE"
					onclick="aggiungiRiferimentoTabella(<%=newStabilimento.getTipoInserimentoScia()%>)"></td>
			</tr>
		</table>
	<%}
	else
	{
		%>
		<table style="width: 100%; display: inline-block" id="tableQualeLinea">
		<tr>
			<td width="50%" align="left" colspan="2">INDICARE LE LINEE DI ATTIVITA CHE SI INTENDE CESSARE</td>
			
		</tr>
		</table>
	 
	
	<%
	Iterator<LineaProduttiva> itLp = StabilimentoOpu.getListaLineeProduttive().iterator();
	int indice = 1 ;
	while (itLp.hasNext())
	{
		LineaProduttiva lp = itLp.next();
		if(lp.getStato()!=Stabilimento.STATO_CESSATO && lp.getStato()!=Stabilimento.STATO_SOSPESO)
		{
	%>
	
	<table id="attsecondarie<%=indice %>"  style="width: 100%;">
	<tbody>
	<tr>
	<td width="100%" align="left" colspan="2">
	<div style="width:100%;">

<%
String[] livelliLinea = lp.getDescrizione_linea_attivita().split("->");
for(String descrioneLiello : livelliLinea)
{
%>
	<p style="color:null"><%=descrioneLiello %></p>
<%	
}
%>
	</div>
	</td>
	<td id="validaattsecondarie<%=indice %>" aligh="right">
<img width="50px" height="50px" src="css/suap/images/ok3.png" style="display: none" id="img<%=indice%>">
</td>
<td><input type="checkbox" name="idLineaProduttiva" value="<%=lp.getId()%>" onclick="checkLinea(<%=indice%>,this);"></td>
	</tr>
	</tbody>
	</table>
	
	<%
	indice ++ ;
	} 
		}%>
	
		
		<%
	}
	
	%>
	<br> <br>
</fieldset>

 