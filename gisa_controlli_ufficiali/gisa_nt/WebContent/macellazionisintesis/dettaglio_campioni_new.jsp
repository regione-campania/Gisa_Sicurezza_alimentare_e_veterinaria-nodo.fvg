<table cellpadding="4" cellspacing="0" width="100%" class="details">

<tr><th colspan="6"><strong>Campioni</strong></th></tr>

<tr>
<th>Numero verbale</th>
<th>Data Prelievo</th>
<th>Motivazione</th>
<th>Matrice</th>
<th>Analiti</th>
<th>Note</th>
</tr>

<% for (int i = 0; i<CampioniNew.size(); i++) {
	CampioneNew c = (CampioneNew) CampioniNew.get(i);	%>

<tr>
<td><a href="<%=(c.getIdCampione() > 0) ? "Vigilanza.do?command=CampioneDetails&id="+c.getIdCampione() : "#" %>" parent="_blank"><%=c.getNumeroVerbale() %></a></td>
<td><%=c.getDataPrelievo() %></td>
<td><%=c.getIdMotivo() > 0 ? toHtml(c.getDescrizioneMotivo()) : "" %> <%= c.getIdPiano()>0 ? toHtml(c.getDescrizionePiano()) : "" %></td>
<td><%=c.getDescrizioneMatrice() %></td>
<td><%=c.getDescrizioneAnalisi() %></td>
<td><%=c.getNote() %></td>
</tr>

<% } %>

</table> 