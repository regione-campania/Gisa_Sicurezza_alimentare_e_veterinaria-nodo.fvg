
 <tr style="display:none">
	<td> 
		<b>USA SCELTA PIU' FREQUENTE</b>&nbsp;
		<input onchange="mostra_candidati_rank('attprincipale_ranked<%=i %>','attprincipale<%=i %>',<%=linea.getId() %>,this,<%=i %>,'<%=newStabilimento.getTipoInserimentoScia()%>')" <%=linea.getCandidatiPerRanking() == null || linea.getCandidatiPerRanking().size() == 0 ? "disabled" : "" %> type ="checkbox" class="checkbox_rank" id="usa_rank" name="usa_rank_linea-<%=i %>" value="true"/>
	</td>
</tr>

<tr>
	<td>
		<table id = "attprincipale_ranked<%=i %>" style ="width:100%" cellspacing = "10"> 
		</table>
	</td>
</tr>
 