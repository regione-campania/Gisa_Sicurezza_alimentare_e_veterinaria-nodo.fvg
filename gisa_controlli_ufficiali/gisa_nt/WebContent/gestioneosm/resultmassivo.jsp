<jsp:useBean id="tot" class="java.lang.String" scope="request"/>
<jsp:useBean id="totOK" class="java.lang.String" scope="request"/>
<jsp:useBean id="totKO" class="java.lang.String" scope="request"/>
<jsp:useBean id="num" class="java.lang.String" scope="request"/>
<jsp:useBean id="messaggio" class="java.lang.String" scope="request"/>
<jsp:useBean id="idImportMassivo" class="java.lang.String" scope="request"/>

<style>
.tableOsm {
table-layout: fixed;
word-wrap:break-word; 
border: 1px solid black;
border-collapse: collapse;
}
.tableOsm td,th{
border: 1px solid black;
font-size: 18px;
}
.tableOsm th{
background-color: 00ffee;
}
.esito {
font-size: 12px !important;
}

</style>

<table class="tableOsm" width="60%">
<col width="40%"><col width="10%"><col width="40%"><col width="10%">
<tr><th colspan="4">Risultati invio massivo OSM #<%=idImportMassivo %></th></tr>
<tr><td>OSM selezionati </td><td><%=num %></td> <td>OSM totali</td><td><%=tot %></td></tr>
<tr><td>OSM inviati OK (questo invio)</td><td><%=totOK %></td> <td>OSM inviati KO (questo invio)</td><td><%=totKO %></td></tr>
<tr><td colspan="4" align="center"><b>Log: </b><br/><br/><%=messaggio %></td></tr>
</table>

<center><a href="GestioneOSM.do?command=PrepareInvioMassivoOSM">Nuovo invio massivo</a></center>