<jsp:useBean id="idEsitoClassyfarm" class="java.lang.String" scope="request"/>
<jsp:useBean id="idControllo" class="java.lang.String" scope="request"/>
<jsp:useBean id="descrizioneMessaggioClassyfarm" class="java.lang.String" scope="request"/>
<jsp:useBean id="descrizioneErroreClassyfarm" class="java.lang.String" scope="request"/>

<table class="details">
<tr><th colspan="2">INVIO CLASSYFARM</th></tr>
<tr><td class="formLabel">Esito</td> <td><%= idEsitoClassyfarm.equals("0") ? "CHECKLIST INSERITA" : idEsitoClassyfarm.equals("1") ? "CHECKLIST INSERITA CON ERRORI" : idEsitoClassyfarm.equals("2") ? "CHECKLIST NON INSERITA" :""%></td></tr>
<tr><td class="formLabel">Descrizione errore</td> <td><%=descrizioneErroreClassyfarm %></td></tr>
<tr><td class="formLabel">Messaggio</td> <td><%=descrizioneMessaggioClassyfarm %></td></tr>
<tr><td class="formLabel">Note</td> <td><%=!idEsitoClassyfarm.equals("0") ? "L'invio non e' andato a buon fine. Di conseguenza, la checklist e' stata riaperta." : "" %></td></tr>
</table>

<script>
window.opener.loadModalWindow();
window.opener.location.href="Vigilanza.do?command=TicketDetails&id=<%=idControllo%>";
</script>