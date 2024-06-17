<table cellpadding="10" class="barcodes">

<tr>
<td><b>Codice<br>Quesito<br>Diagnostico</b></td>
<td><% if(Mod.getCampioneCodiceEsame()!=null && !Mod.getCampioneCodiceEsame().equals("") ){ %> <img align ="middle" src="<%=createBarcodeImage(Mod.getCampioneCodiceEsame().toUpperCase() )%>" /> <% } else { %> NON DISPONIBILE <% } %></td>
</tr>

<tr>
<td><b>Codice<br>Stabilimento</b></td>
<td><% if(Mod.getCampioneCodiceOsa()!=null && !Mod.getCampioneCodiceOsa().equals("") ){ %> <img align ="middle" src="<%=createBarcodeImage(Mod.getCampioneCodiceOsa().toUpperCase() )%>" /> <% } else { %> NON DISPONIBILE <% } %></td>
</tr>

<tr>
<td><b>Codice<br>Matrice</b></td>
<td><% if(Mod.getCampioneListaCodiceMatrice()!=null && !Mod.getCampioneListaCodiceMatrice().equals("") ){ 
String[] codiciMatrici = Mod.getCampioneListaCodiceMatrice().split(",");
for (int i = 0; i<codiciMatrici.length; i++){%><img align ="middle" src="<%=createBarcodeImage(codiciMatrici[i].toUpperCase() )%>" /><br/><% } %>
<% } else { %> NON DISPONIBILE <% } %></td>
</tr>

<tr style="<%= (Mod.getCampioneCodicePreaccettazione()!=null && !Mod.getCampioneCodicePreaccettazione().equals("") ) ? "" : "display:none" %>">
<td><b>Codice<br>Preaccettazione</b></td>
<td><% if(Mod.getCampioneCodicePreaccettazione()!=null && !Mod.getCampioneCodicePreaccettazione().equals("") ){ %> <img align ="middle" src="<%=createBarcodeImage(Mod.getCampioneCodicePreaccettazione().toUpperCase() )%>" /> <% } else { %> NON DISPONIBILE <% } %></td>
</tr>

</table>