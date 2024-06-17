<%@page import="org.aspcfs.utils.InvioMassivoDistributori"%>
<%@page import="org.aspcfs.modules.distributori.base.Distrubutore"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="InvioMassivo" class="org.aspcfs.utils.InvioMassivoDistributori" scope="request"/>

<%
ArrayList<Distrubutore> listaRecordKO = (ArrayList<Distrubutore>)request.getAttribute("listaRecordKO");
%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
<tr>
<th>
Data Import
</th>
<th>
Esito Import
</th>
<th>
Scarica File
</th>
</tr>
<%
ArrayList<InvioMassivoDistributori> listaInvii = (ArrayList<InvioMassivoDistributori>) request.getAttribute("listaInvii");
for(InvioMassivoDistributori invio : listaInvii)
{
%>
<tr>
<td><%=invio.getData() %></td>
<td><%=invio.getEsito() %></td>
<td><a href="OpuStab.do?command=DownloadFileEsitoImportDistributori&idInvio=<%=invio.getId() %>" >Scarica</a></td>
</tr>
<%
}
%>
</table>

<input type="button" value="ESCI" onClick="$( '#dialogImport' ).dialog('close');"/>
