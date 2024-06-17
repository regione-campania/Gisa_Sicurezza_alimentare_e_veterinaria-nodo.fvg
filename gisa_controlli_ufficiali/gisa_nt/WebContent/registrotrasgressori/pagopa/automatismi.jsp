<link rel="stylesheet" type="text/css" media="all" documentale_url="" href="registrotrasgressori/css/ricevuta_pagopa_layout.css" />

<%
String BG_COLOR = ""; 
String TXT_COLOR = "";
%>

<center>

Automatismi <img style="text-decoration: none;" width="80" height="80" documentale_url="" src="registrotrasgressori/pagopa/logo.png" />
<br/><br/>

<table cellpadding="10" cellspacing="10">

<%BG_COLOR = "coral"; TXT_COLOR = "black";%>
<tr style="background-color: <%=BG_COLOR%>"><th>Aggiorna stato massivo</th></tr>
<tr><td align="center">Questo automatismo aggiorna lo stato di TUTTI gli avvisi di pagamento aperti</td></tr>
<tr><td align="center">
<form action="ControllaPagamentiPagoPA" target="_blank">
<input type="submit" style="font-size:30px; background-color: <%=BG_COLOR %>; color: <%=TXT_COLOR %>" value="ESEGUI"/>
</form>
</td></tr>

<tr><td><hr></td></tr>

<%BG_COLOR= "chocolate"; TXT_COLOR = "black";%>
<tr style="background-color: <%=BG_COLOR%>"><th>Proroga Processo verbale / Scadenze tutti</th></tr>
<tr><td align="center">Questo automatismo proroga gli avvisi in scadenza ed aggiorna lo stato di quelli scaduti</td></tr>
<tr><td align="center">
<form action="ControllaScadenzePagoPA" target="_blank">
<input type="submit" style="font-size:30px; background-color: <%=BG_COLOR %>; color: <%=TXT_COLOR %>" value="ESEGUI"/>
</form>
</td></tr>

<tr><td><hr></td></tr>

<%BG_COLOR= "darkseagreen"; TXT_COLOR = "black";%>
<tr style="background-color: <%=BG_COLOR%>"><th>Rigenerazioni Ordinanza</th></tr>
<tr><td align="center">Questo automatismo verifica se ci sono due avvisi consecutivi scaduti per Numero Ordinanza, annulla tutti quelli non scaduti e rigenera un nuovo avviso sull'importo residuo</td></tr>
<tr><td align="center">
<form action="ControllaScadenzeOrdinanzaPagoPA" target="_blank">
<input type="submit" style="font-size:30px; background-color: <%=BG_COLOR %>; color: <%=TXT_COLOR %>" value="ESEGUI"/>
</form>
</td></tr>

<tr><td><hr></td></tr>

<%BG_COLOR= "lime"; TXT_COLOR = "black";%>
<tr style="background-color: <%=BG_COLOR%>"><th>RT PUSH</th></tr>
<tr><td align="center">Questo automatismo simula la chiamata di RT PUSH (o verifica stato) </td></tr>
<tr><td align="center">
<form action="ControllaPagamentoPagoPA" target="_blank">
<input type="text" style="font-size:30px" required id="IUV" name="IUV" placeholder="IUV"/> <input type="submit" style="font-size:30px; background-color: <%=BG_COLOR %>; color: <%=TXT_COLOR %>" value="ESEGUI"/>
</form>
</td></tr>

<tr><td><hr></td></tr>

<%BG_COLOR= "coral"; TXT_COLOR = "black";%>
<tr style="background-color: <%=BG_COLOR%>"><th>Aggiorna Header Avviso</th></tr>
<tr><td align="center">Questo automatismo scarica il PDF avviso (tramite urlFileAvviso) e lo carica sul documentale, associando l'header_file_avviso</td></tr>
<tr><td align="center">
<form action="AggiornaHeaderAvvisiPagoPA" target="_blank">
<input type="text" style="font-size:30px" required id="IUV" name="IUV" placeholder="IUV"/> <input type="submit" style="font-size:30px; background-color: <%=BG_COLOR %>; color: <%=TXT_COLOR %>" value="ESEGUI"/>
</form>
</td></tr>

<tr><td><hr></td></tr>

<%BG_COLOR= "orchid"; TXT_COLOR = "black";%>
<tr style="background-color: <%=BG_COLOR%>"><th>Aggiorna Header Ricevuta</th></tr>
<tr><td align="center">Questo automatismo genera il PDF Ricevuta (se presenti i dati) e lo carica sul documentale, associando l'header_file_ricevuta</td></tr>
<tr><td align="center">
<form action="AggiornaHeaderRicevutePagoPA" target="_blank">
<input type="text" style="font-size:30px" required id="IUV" name="IUV" placeholder="IUV"/> <input type="submit" style="font-size:30px; background-color: <%=BG_COLOR %>; color: <%=TXT_COLOR %>" value="ESEGUI"/>
</form>
</td></tr>

<tr><td><hr></td></tr>

<%BG_COLOR= "DarkKhaki"; TXT_COLOR = "black";%>
<tr style="background-color: <%=BG_COLOR%>"><th>Controlla Coerenza Avvisi</th></tr>
<tr><td align="center">Questo automatismo verifica la coerenza degli importi ordinanza e degli avvisi non annullati a seguito del pagamento di una rata gemella</td></tr>
<tr><td align="center">
<form action="ControllaCoerenzaAvvisiPagoPA" target="_blank">
<input type="submit" style="font-size:30px; background-color: <%=BG_COLOR %>; color: <%=TXT_COLOR %>" value="ESEGUI"/>
</form>
</td></tr>

</table>


</center>