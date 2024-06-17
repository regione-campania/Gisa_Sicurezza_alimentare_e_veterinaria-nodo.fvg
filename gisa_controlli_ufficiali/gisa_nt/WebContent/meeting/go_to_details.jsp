<jsp:useBean id="Riunione" class="org.aspcfs.modules.meeting.base.Riunione" scope="request"/>
<jsp:useBean id="Rilascio" class="org.aspcfs.modules.meeting.base.Rilascio" scope="request"/>

<script>

<% if (Riunione!=null && Riunione.getId()>0) { %>
location.href='GestioneRiunioni.do?command=DettaglioRiunione&id=<%=Riunione.getId()%>';
<%} else if (Rilascio!=null && Rilascio.getId()>0) { %>
location.href='GestioneRiunioni.do?command=DettaglioRilascio&id=<%=Rilascio.getId()%>';
<% } %>


</script>
