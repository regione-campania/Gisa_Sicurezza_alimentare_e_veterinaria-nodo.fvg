<jsp:useBean id="Capo" class="org.aspcfs.modules.macellazionisintesis.base.Capo" scope="request" />

<script>function reloadPadre(){
	window.parent.opener.location.href = "MacellazioniSintesis.do?command=List&altId=<%=Capo.getId_macello()%>&tipo=1";
	window.close();
}</script>



<br/>
<h4>Cancellazione del capo <%=Capo.getCd_matricola() %> eseguita con successo.</h4>
<br/><br/>
<input type="button" value="chiudi" onClick="reloadPadre()"/>