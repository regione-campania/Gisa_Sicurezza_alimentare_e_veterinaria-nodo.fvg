<jsp:useBean id="CUSedutaData" class="java.lang.String" scope="request"/>
<jsp:useBean id="CUSedutaNumero" class="java.lang.String" scope="request"/>
<jsp:useBean id="CUSedutaId" class="java.lang.String" scope="request"/>
<jsp:useBean id="CUSedutaIdMacello" class="java.lang.String" scope="request"/>

<% if (CUSedutaData!=null && !"".equals(CUSedutaData)){ %>
<table class="details" cellpadding="10" cellspacing="10">
<tr><th colspan="2">INFORMAZIONI CONTROLLO UFFICIALE ASSOCIATO A SEDUTA DI MACELLAZIONE</th></tr>
<tr><td class="formLabel">Seduta</td><td><a href="MacellazioniSintesis.do?command=List&altId=<%= CUSedutaIdMacello%>&comboSessioniMacellazione=<%=toDateasStringfromString(CUSedutaData) %>-<%= CUSedutaNumero%>" style="text-decoration: underline"><%=toDateasStringfromString(CUSedutaData) %>-<%= CUSedutaNumero%></a></td></tr>
</table>
<% } %>

<% if (CUSedutaId!=null && !"".equals(CUSedutaId)){ %>
<table class="details" cellpadding="10" cellspacing="10">
<col width="50%">
<tr><th colspan="2">INFORMAZIONI CONTROLLO UFFICIALE ASSOCIATO A SEDUTA DI MACELLAZIONE</th></tr>
<tr><td class="formLabel">Id Controllo Ufficiale</td><td><a href="Vigilanza.do?command=TicketDetails&id=<%=CUSedutaId%>"><%=CUSedutaId %></a></td></tr>
</table>
<% } %>