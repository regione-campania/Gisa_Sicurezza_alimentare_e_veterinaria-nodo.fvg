<center><i>ALLEGATO 1: Verbale di prelievo (PNAA)</i></center><br/>

<div align="right">
SCHEDA N. <label class="layout"><%= fixValore(Mod.getNumeroScheda())%></label>
</div>

<center>
<b>VERBALE DI PRELIEVO (PNAA)</b><br/>
<i><label class="layout"><%= fixValore(Mod.getCampioneMotivazione())%></label></i>
</center>

<div align="right">
Verbale n. <img src="<%=createBarcodeImage(Mod.getCampioneVerbale())%>" /> Data <label class="layout"><%= fixValoreShort(toDateasString(Mod.getCampioneData()))%></label> <br/>
Codice preccettazione:  <% if(Mod.getCampioneCodicePreaccettazione() != null && !Mod.getCampioneCodicePreaccettazione().equals("")){ %><img align ="middle" src="<%=createBarcodeImage(Mod.getCampioneCodicePreaccettazione().toUpperCase() )%>" /><% } else { %>NON DISPONIBILE<% } %>
</div>

<div class="boxOrigineDocumento"><%@ include file="../../../utils23/hostName.jsp" %></div> 

<br/><br/>
