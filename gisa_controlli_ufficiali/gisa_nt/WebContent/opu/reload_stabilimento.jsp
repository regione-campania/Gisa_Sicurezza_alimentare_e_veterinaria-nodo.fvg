<jsp:useBean id="StabilimentoDettaglio" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request"/>

<script>
location.href='<%=StabilimentoDettaglio.getAction()+".do?command=Details&stabId="+StabilimentoDettaglio.getIdStabilimento()+"&opId="+StabilimentoDettaglio.getIdOperatore()%>';
</script>

