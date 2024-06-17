 <tr style="display:none">
        	<td colspan="2">
      
	        <b>USA SCELTA PIU' FREQUENTE</b>
	        &nbsp; 
	        <input onchange="mostra_candidati_rank('attprincipale_ranked<%=indice %>','attprincipale<%=indice %>',<%=lp.getId() %>,this,0,'<%=StabilimentoDettaglio.getTipoInserimentoScia()%>')" <%=lp.getCandidatiPerRanking() == null || lp.getCandidatiPerRanking().size() == 0 ? "disabled" : "" %> type ="checkbox" class="checkbox_rank" id="usa_rank" name="usa_rank_linea_principale<%=indice %>" value="true"/>
	        </td>
</tr>
<tr>
			 
    		 
    		<td colspan="2"><table id = "attprincipale_ranked<%=indice %>" style ="width:100%"></table></td>
</tr>