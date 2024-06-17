<center>INFORMAZIONI OBBLIGATORIE DA TRASMETTERE AI LABORATORI DEL CONTROLLO UFFICIALE NELL'AMBITO DELLE ATTIVITA' DI VIGILANZA E CONTROLLO DI ALIMENTI E BEVANDE:<br/>
<b>VIGILANZA E CONTROLLO ALIMENTI E BEVANDE (VIG)</b></center>

<br/>

<center>Allegato al verbale prelevamento n.

<%if (OrgCampione.getBarcodePrelievoNew()!=null && !OrgCampione.getBarcodePrelievoNew().equals("")) { %>
	<%=OrgCampione.getBarcodePrelievoNew()%>
	<%} else { %>
	<%=OrgCampione.getBarcodePrelievo()%>
<%}%> </center>
<center>del <%= fixValore(OrgOperatore.getGiornoReferto())%> <%= fixValore(OrgOperatore.getMeseReferto())%>  <%= fixValore( OrgOperatore.getAnnoReferto()) %></center>

<table rules="all" cellpadding="10" style="border-collapse: collapse">

<tr>
<td style="text-align:center; width:200px;border: 1px solid black;">Caratteristiche del prodotto campionato: matrice e tipologia di lavorazione/trattamento.</td>
<td style="text-align:center; width:200px; border: 1px solid black;"><%= fixValore(Modulo.getListaCampiModulo().get("caratteristiche").get("caratteristiche"))%></td>
</tr>

<tr>
<td style="text-align:center; width:200px;border: 1px solid black;">Nazione di origine e zona FAO di provenienza per i prodotti della pesca. </td>
<td style="text-align:center; width:200px; border: 1px solid black;"><%= fixValore(Modulo.getListaCampiModulo().get("nazione").get("nazione"))%></td>
</tr>

<tr>
<td style="text-align:center; width:200px;border: 1px solid black;">Se si tratta di alimenti ready to eat (si/no)</td>
<td style="text-align:center; width:200px; border: 1px solid black;"><%= fixValore(Modulo.getListaCampiModulo().get("ready").get("ready"))%></td>
</tr>

<tr>
<td style="text-align:center; width:200px;border: 1px solid black;">Indicare in caso di prodotti lattiero caseari se il latte utilizzato come materia prima sia pastorizzato o meno. (si/no)</td>
<td style="text-align:center; width:200px; border: 1px solid black;"><%= fixValore(Modulo.getListaCampiModulo().get("lattieri").get("lattieri"))%></td>
</tr>

<tr>
<td style="text-align:center; width:200px;border: 1px solid black;">In caso di ricerca di additivi indicare la norma di riferimento.</td>
<td style="text-align:center; width:200px; border: 1px solid black;"><%= fixValore(Modulo.getListaCampiModulo().get("additivi").get("additivi"))%></td>
</tr>

<tr>
<td style="text-align:center; width:200px;border: 1px solid black;">Specificare il materiale d'imballaggio se si tratta di campioni per la ricerca di IPA o BISFENOLI.</td>
<td style="text-align:center; width:200px; border: 1px solid black;"><%= fixValore(Modulo.getListaCampiModulo().get("imballaggio").get("imballaggio"))%></td>
</tr>

</table>



