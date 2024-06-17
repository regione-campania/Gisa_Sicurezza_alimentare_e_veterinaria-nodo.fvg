<jsp:useBean id="operazioneScelta" class="java.lang.String" scope="request" />

<jsp:useBean id="StabilimentoOpu" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request"/>
<%@ include file="../utils23/initPage.jsp" %>

<table style="width: 37%">
<%
	if("cambioTitolarita".equalsIgnoreCase(operazioneScelta))
	{
	%>
	<tr>
		<td>PARTITA IVA</td>
		<td>
	
			<%-- <input type="text" value = "<%=toHtml(StabilimentoOpu.getOperatore().getPartitaIva()) %>" <%if(StabilimentoOpu.getOperatore().getTipo_impresa()!=9){ %>class="required" <%} %>min="11" maxlength="11" id="partitaIvaVariazione" name="partitaIvaVariazione" placeholder="Inserire la partita Iva" size="11"  onblur="rimuoviSpazi(this)"/> --%>
<!-- <font color="red">Attenzione. Indicare la coppia Partita IVA / Numero registrazione dell'impresa cedente.</font> -->
		
		<%=toHtml(StabilimentoOpu.getOperatore().getPartitaIva()) %>&nbsp;<font color="red" style="position: relative; left : 50px;">  Partita IVA impresa cui si subentra</font>
		<input type="hidden" name="partitaIvaVariazione" id="partitaIvaVariazione" />
		</td>
	</tr>
	<%} %>

	<tr>
		<td>NUMERO REGISTRAZIONE</td>
		<td>
			<%-- <input type="text" value = "<%=toHtml(StabilimentoOpu.getNumero_registrazione()) %>"  id="numeroRegistrazioneVariazione" name="numeroRegistrazioneVariazione" placeholder="Inserire il numero registrazione" size="55" onblur="rimuoviSpazi(this)" /> --%>
			<%=toHtml(StabilimentoOpu.getNumero_registrazione()) %>  
			<input type="hidden" name ="numeroRegistrazioneVariazione" id="numeroRegistrazioneVariazione" value="<%=toHtml(StabilimentoOpu.getNumero_registrazione()) %>" />
		</td>
	</tr>
</table>

 