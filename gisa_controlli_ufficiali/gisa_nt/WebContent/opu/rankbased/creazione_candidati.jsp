

<!-- salvo come oggetto js i candidati per tutte le linee -->
<script>
	
		 
		//candidatiPerIdLineeVecchie = [];
		candidatiPerIdLineeVecchie = {};
		<%for (int k=0;k<linee_attivita.size();k++)
		{
		
			int idLineaVecchia = linee_attivita.get(k).getId();
			//int idLineaVecchiaOriginale = linee_attivita.get(k).getIdLineaVecchiaOriginale();
			
			%>
			candidatiPerIdLineeVecchie[<%=idLineaVecchia%>] = [];
			<%
			ArrayList<LineeAttivita> candidati = linee_attivita.get(k).getCandidatiPerRanking();
			if(candidati == null)
				continue; //non sono arrivati candidati per quella linea vecchia
			for(int j=0;j<candidati.size(); j++)
			{
				
				int idLineaNuovaCandidata = candidati.get(j).getId();
				int idMacroareaNuovaCandidata = candidati.get(j).getIdMacroarea();
				int idAggregazioneNuovaCandidata = candidati.get(j).getIdAggregazione();
				int idAttivitaNuovaCandidata = candidati.get(j).getIdAttivita();
				String macroareaNuovaCandidata = candidati.get(j).getMacroarea();
				String aggregazioneNuovaCandidata = candidati.get(j).getAggregazione();
				String attivitaNuovaCandidata = candidati.get(j).getAttivita();
				
				//NB: idLineaVecchia è quella della vecchia ma in lista_linee_attivita_vecchia_anag
				//idLineaVecchiaOriginale è quella della vecchia ma secondo la gestione originale
			%>
			candidatiPerIdLineeVecchie[<%=idLineaVecchia%>].push( 
					{
						
						idLinea : <%=idLineaNuovaCandidata  %>
						,idMacroarea :<%=idMacroareaNuovaCandidata  %>
						,idAggregazione : <%=idAggregazioneNuovaCandidata  %>
						,idAttivita :  <%=idAttivitaNuovaCandidata   %>
						,macroarea : '<%=macroareaNuovaCandidata.replace("'","").replace("\"","") %>'
						,aggregazione :  '<%=aggregazioneNuovaCandidata.replace("'","").replace("\"","") %>'
						,attivita : '<%=attivitaNuovaCandidata.replace("'","").replace("\"","") %>'
					}
				);
			 
				
	
			<%}
		}%>
		 
</script>