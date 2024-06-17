<%String parametri = "";

String ragioneSociale = request.getParameter("ragioneSociale");
if (ragioneSociale!=null && !ragioneSociale.trim().equals(""))
	parametri+="&searchragioneSociale="+ragioneSociale;

String partitaIva = request.getParameter("partitaIva");
if (partitaIva!=null && !partitaIva.trim().equals(""))
	parametri+="&searchpartitaIva="+partitaIva;

String codFiscaleRappresentante = request.getParameter("codFiscaleRappresentante");
if (codFiscaleRappresentante!=null && !codFiscaleRappresentante.trim().equals(""))
	parametri+="&searchcodiceFiscaleSoggettoFisico="+codFiscaleRappresentante;

String comuneStabilimento = request.getParameter("comuneStabilimento");
if (comuneStabilimento!=null && !comuneStabilimento.trim().equals(""))
	parametri+="&searchcomuneSedeOperativa="+comuneStabilimento;

String indirizzoStabilimento = request.getParameter("indirizzoStabilimento");
if (indirizzoStabilimento!=null && !indirizzoStabilimento.trim().equals(""))
	parametri+="&searchindirizzoSedeOperativa="+indirizzoStabilimento;

String asl = request.getParameter("asl");
if (asl!=null && !asl.trim().equals(""))
	parametri+="&searchcodeOrgSiteId="+asl;

String numeroRegistrazione = request.getParameter("numeroRegistrazione");
if (numeroRegistrazione!=null && !numeroRegistrazione.trim().equals(""))
	parametri+="&searchnumeroRegistrazione="+numeroRegistrazione;

%>



<script>
function cercaDirettamente(form){
	form.action ='RicercaUnica.do?command=Search<%=parametri%>';
	loadModalWindow();
	form.submit();
}

function cambioParametri(form){
	form.action ='RicercaUnica.do?command=Dashboard';
	loadModalWindow();
	form.submit();
}
</script>


<form name="ricercaUnica" action="" method="post">
<center>
<table style="border:1px solid black">
<tr><td>
<!-- <input class="redBigButton" type="button" value="CAMBIA PARAMETRI E RICERCA IN TUTTI I CAVALIERI" onClick="cambioParametri(this.form)"/> -->
</td><td>
<input class="greyBigButton" type="button" value="RICERCA IN TUTTI I CAVALIERI" onClick="cercaDirettamente(this.form)"/>
</td></tr>
</table>
</center>
</form>