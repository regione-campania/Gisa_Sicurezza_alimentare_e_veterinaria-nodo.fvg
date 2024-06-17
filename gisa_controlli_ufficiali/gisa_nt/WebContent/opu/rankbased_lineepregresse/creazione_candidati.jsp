<!-- NB LA CHIAMO LINEA FITTIZIA (E IN ALCUNI PUNTI E' CHIAMATA VECCHIA LINEA) PERCHE' SAREBBE LA LINEA che NON REALMENTE ESISTE IN MASTER LIST
	E CHE NOI VOGLIAMO ASSOCIARE AD UNA NUOVA REALMENTE NELLA MASTER LIST -->
	<!-- costruisco oggetto js dei candidati ranked per ciascuna linea-->
	<%if(StabilimentoDettaglio.getListaLineeProduttive().size() > 0) 
	{
		LineaProduttivaList linee_attivita = StabilimentoDettaglio.getListaLineeProduttive();
		%>
		<script>
			 
			//candidatiPerIdLineeFittizie = [];
			//candidatiPerIdLineeFittizie.push({a : 'a'});
			//console.log(candidatiPerIdLineeFittizie[0].a);
			candidatiPerIdLineeFittizie = {};
			<%for (int k=0;k<linee_attivita.size();k++)
			{
			
				int idLineaFittizia = ((LineaProduttiva)linee_attivita.get(k)).getId();
				
				%>
				candidatiPerIdLineeFittizie[<%=idLineaFittizia%>] = [];
				<%
				ArrayList<LineeAttivita> candidati = ((LineaProduttiva)linee_attivita.get(k)).getCandidatiPerRanking();
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
					
				%>
				candidatiPerIdLineeFittizie[<%=idLineaFittizia%>].push(
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
				 
					
				<%--<%="candidato per "+idLineaFittizia+" "+macroareaNuovaCandidata.replace("'","")+" "+aggregazioneNuovaCandidata.replace("'","") + " "+attivitaNuovaCandidata.replace("'","") %>--%>
				<%}
			}%>
		</script>
	
	<%
	}%>