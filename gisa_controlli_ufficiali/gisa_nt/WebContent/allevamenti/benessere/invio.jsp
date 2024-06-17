<jsp:useBean id="idBdn" class="java.lang.String" scope="request"/>
<jsp:useBean id="idControllo" class="java.lang.String" scope="request"/>
<jsp:useBean id="esitoImport" class="java.lang.String" scope="request"/>
<jsp:useBean id="descrizioneErrore" class="java.lang.String" scope="request"/>

<table class="details">
<tr><th colspan="2">INVIO BDN</th></tr>
<tr><td class="formLabel">Esito</td> <td><%=esitoImport %></td></tr>
<tr><td class="formLabel">Descrizione errore</td> <td><%=descrizioneErrore %></td></tr>
<tr><td class="formLabel">Id BDN</td> <td><%=idBdn %></td></tr>
<tr><td class="formLabel">Note</td> <td><%=!esitoImport.equals("OK") ? "L'invio non e' andato a buon fine. Di conseguenza, la checklist e' stata riaperta." : "" %></td></tr>
</table>

<script>
window.opener.loadModalWindow();
window.opener.location.href="Vigilanza.do?command=TicketDetails&id=<%=idControllo%>";
</script>