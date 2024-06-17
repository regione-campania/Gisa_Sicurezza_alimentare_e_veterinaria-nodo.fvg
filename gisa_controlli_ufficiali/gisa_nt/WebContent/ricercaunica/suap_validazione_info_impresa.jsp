<jsp:useBean id="Richiesta" class="org.aspcfs.modules.suap.base.Stabilimento" scope="request" />


	<table cellpadding="4" cellspacing="0" border="0" width="100%"
				class="details">
				<tr>
					<th colspan="2"><strong>Validazione Richiesta <%=Richiesta.getOperatore().getDescrizioneOperazione() %></strong>
					</th>
				</tr>
				<tr>
					<td class="formLabel">Id Richiesta</td>
					<td style="background-color: lightgray;">${Richiesta.idOperatore}</td>
				</tr>
				<tr>
					<td class="formLabel">Partita Iva</td>
					<td style="background-color: lightgray;">${Richiesta.operatore.partitaIva}</td>
				</tr>
				<tr>
					<td class="formLabel">Codice Fiscale</td>
					<td style="background-color: lightgray;">${Richiesta.operatore.codFiscale}</td>
				</tr>
				<tr>
					<td class="formLabel">Rapp Legale</td>
					<td style="background-color: lightgray;">${Richiesta.operatore.rappLegale.nome}
						${Richiesta.operatore.rappLegale.cognome}
						${Richiesta.operatore.rappLegale.codFiscale}</td>
				</tr>
				<tr>
					<td class="formLabel">Sede Legale</td>
					<td style="background-color: lightgray;">${Richiesta.operatore.sedeLegaleImpresa.descrizioneComune}
						${Richiesta.operatore.sedeLegaleImpresa.via}</td>
				</tr>

				<tr>
					<td class="formLabel">Sede Operativa</td>
					<td style="background-color: lightgray;">${Richiesta.sedeOperativa.descrizioneComune}
						${Richiesta.sedeOperativa.via}</td>
				</tr>


				<tr>
					<td class="formLabel">Ragione Sociale</td>
					<td style="background-color: lightgray;"><%=Richiesta.getOperatore().getRagioneSociale() %></td>
				</tr>


<%if (Richiesta.getNumeroRegistrazioneVariazione()!=null) {%>
				<tr>
					<td class="formLabel">Numero Registrazione Variazione</td>
					<td style="background-color: lightgray;">
						<p id="codRegText"><%=Richiesta.getNumeroRegistrazioneVariazione() %>
						<p />

					</td>
				</tr>
				<%} %>
				<%if (Richiesta.getPartitaIvaVariazione()!=null) {%>
				<tr>
					<td class="formLabel">Partita Iva Variazione</td>
					<td style="background-color: lightgray;">
						<p id="codRegText"><%=Richiesta.getPartitaIvaVariazione()%>
						<p />

					</td>
				</tr>
				<%} %>
</table>