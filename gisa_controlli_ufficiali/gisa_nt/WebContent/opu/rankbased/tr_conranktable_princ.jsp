 <!-- parte scelta ranking -->
<!-- IL BOTTONE DI SCELTA CANDIDATO DI RANKING E' DISABILITATO SE NON C'E' ALMENO UN CANDIDATO PER LA VECCHIA LINEA SCELTA -->
<!-- QUANDO CLICCO SULLA CHECKBOX, VIENE POPOLATA LA TABELLA (IN QUESTO CASO QUELLA DELL'ATTIVITA PRINCIPALE
ATTPRINCIPALE_RANKED CON EVENTUALI CANDIDATI O... -->
 <tr style="display:none">
	<td>
		 
		<b>USA SCELTA PIU' FREQUENTE</b>
		&nbsp;
		<input onchange="mostra_candidati_rank('attprincipale_ranked','attprincipale',<%=linea_attivita_principale.getId() %>,this,0,'<%=newStabilimento.getTipoInserimentoScia()%>')" <%=linea_attivita_principale.getCandidatiPerRanking() == null || linea_attivita_principale.getCandidatiPerRanking().size() == 0 ? "disabled" : "" %> type ="checkbox" class="checkbox_rank" id="usa_rank" name="usa_rank_linea_principale" value="true"/>
	</td>
</tr>

 <tr style="display:none">
	<td>
		<table id = "attprincipale_ranked" cellspacing = "10" style ="width:100%">
		</table>
	</td>
</tr>
