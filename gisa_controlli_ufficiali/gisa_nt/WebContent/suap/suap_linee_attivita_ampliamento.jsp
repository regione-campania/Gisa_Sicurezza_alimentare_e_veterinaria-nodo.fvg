<jsp:useBean id="newStabilimento" class="org.aspcfs.modules.suap.base.Stabilimento" scope="request" />

<script type="text/javascript" src="suap/javascriptsuap/suap_linee.js"></script>


<input type="hidden" value="false" id="validatelp">
<fieldset id="operazione">
	<h1>
		<center>AGGIUNTA DI UNA O PIU' LINEE DI ATTIVITA'</center>
	</h1>
</fieldset>

<!-- <fieldset id="setAttivitaPrincipale"> -->
<!-- 	<legend>INDICARE IL TIPO DI ATTIVITA PRINCIPALE</legend> -->
<!-- 	<table id="attprincipale" style="width: 100%;"> -->
<!-- 	</table> -->
<!-- 	<table style="width: 100%;"> -->
<!-- 		<tr id="trDataInizioLinea"> -->
<!-- 			<td>DATA INIZIO</td> -->
<!-- 			<td><input type="text" size="15" name="dataInizioLinea" -->
<!-- 				id="dataInizioLinea" class="required" placeholder="dd/MM/YYYY"> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 		<tr id="trDataFineLinea"> -->
<!-- 			<td>DATA FINE</td> -->
<!-- 			<td><input type="text" size="15" name="dataFineLinea" -->
<!-- 				id="dataFineLinea" value="" placeholder="dd/MM/YYYY"></td> -->
<!-- 		</tr> -->
<!-- 	</table> -->
	
<!-- </fieldset> -->
<br>
<br>
<fieldset id="secondarie">
	<legend><%="Indicare con quali linee si vuole ampliare lo stabilimento.".toUpperCase() %></legend>
	<table style="width: 100%;">
		<tr>
			<%--<td width="50%" align="left"><%="Indicare con quali linee si vuole ampliare lo stabilimento.".toUpperCase() %></td>  --%>
			<td align="left"><input type="button" value="Aggiungi"
				onclick="aggiungiRiferimentoTabella(<%=newStabilimento.getTipoInserimentoScia()%>)"></td>
		</tr>
	</table>
 
</fieldset>