<jsp:useBean id="DettaglioBiogas" class="org.aspcfs.modules.schedeadeguamenti.base.SchedaBiogas" scope="request"/>
<jsp:useBean id="MessaggioSchedaBiogas" class="java.lang.String" scope="request"/>
<jsp:useBean id="orgId" class="java.lang.String" scope="request"/>
<jsp:useBean id="altId" class="java.lang.String" scope="request"/>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<% if (MessaggioSchedaBiogas!=null && !MessaggioSchedaBiogas.equals("")) {%>
<script>
alert("<%=MessaggioSchedaBiogas%>");
</script>
<% } %>

<br/><br/>
<center>
<table class="details">
<tr><th colspan="2">INFORMAZIONI IMPIANTO BIOGAS</th></tr>
<tr><td>E' PRESENTE UN IMPIANTO BIOGAS?</td><td> 
<input type="radio" disabled id="impiantoBiogasS" name="impiantoBiogas" value="S" <%=(DettaglioBiogas!=null && DettaglioBiogas.getImpiantoBiogas()!=null && DettaglioBiogas.getImpiantoBiogas().equals("S")) ? "checked" : "" %>>SI<br/>
<input type="radio" disabled id="impiantoBiogasN" name="impiantoBiogas" value="N" <%=(DettaglioBiogas!=null && DettaglioBiogas.getImpiantoBiogas()!=null && DettaglioBiogas.getImpiantoBiogas().equals("N")) ? "checked" : "" %>>NO
</td></tr>

<tr><td>TIPOLOGIA</td><td>
<input type="radio" disabled id="tipologiaBiogasR" name="tipologiaBiogas" value="R" <%=(DettaglioBiogas!=null && DettaglioBiogas.getImpiantoBiogas()!=null && DettaglioBiogas.getImpiantoBiogas().equals("S")) ? "checked" : "" %>>Riconosciuto<br/>
<input type="radio" disabled id="tipologiaBiogasD" name="tipologiaBiogas" value="D" <%=(DettaglioBiogas!=null && DettaglioBiogas.getTipologiaBiogas()!=null && DettaglioBiogas.getTipologiaBiogas().equals("D")) ? "checked" : "" %>>Deroga
</td></tr>

<dhv:permission name="adeguamento-schedabiogas-add">
<%if (DettaglioBiogas==null || DettaglioBiogas.getId()<=0) { %>
<tr><td colspan="2" align="center">
<input type="button" onClick="window.location.href='SchedeAdeguamentiAction.do?command=AddSchedaBiogas&orgId=<%=orgId%>&altId=<%=altId %>'" value="COMPILA"/>
</td></tr>
<% } %>
</dhv:permission>

</table>

</center>