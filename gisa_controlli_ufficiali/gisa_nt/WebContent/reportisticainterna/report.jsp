<jsp:useBean id="idAsl" class="java.lang.String" scope="request"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="report" class="org.aspcfs.modules.reportisticainterna.base.Report" scope="request"/>


<script>
function apriLista(idReport, idAsl, fonte){
	if (confirm ('ATTENZIONE. La lista potrebbe impiegare molto tempo ad essere caricata.')){
		window.open('ReportisticaInterna.do?command=Lista&idReport='+idReport+'&idAsl='+idAsl+'&fonte='+fonte, 'popupSelect',
	    'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}
	
}
function apriListaNonPresenti(idReport, idAsl, fonte){
	if (confirm ('ATTENZIONE. La lista potrebbe impiegare molto tempo ad essere caricata.')){
		window.open('ReportisticaInterna.do?command=ListaNonPresenti&idReport='+idReport+'&idAsl='+idAsl+'&fonte='+fonte, 'popupSelect',
	    'height=800px,width=1280px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}
	
}

</script>


	<table class="trails" cellspacing="0">
	<tr>
	<td>
	<a href="ReportisticaInterna.do">Reportistica Interna</a> > 
	<%=report.getNome() %>
	</td>
	</tr>
	</table>
	

<table class="details" width="100%" cellspacing="10" cellpadding="10">
<col width="50%">
<tr><th colspan="2" style="text-align:center !important"><font size="5px">REPORTISTICA INTERNA PER L'ASL <font color="red"><%=SiteList.getSelectedValue(idAsl) %> </font>(Anno corrente)</font></th></tr>
<tr><th colspan="2" style="text-align:center !important"><font size="5px"><%=report.getNome() %></font></th></tr>
<tr><th colspan="2" style="text-align:center !important"><font size="5px"><%=report.getDescrizione() %></font></th></tr>
<tr><td align="center"> <font size="5px">Dato fonte GISA NATIVO</font><br/>(Valori distinti per: <%=report.getCampoDistinctNativo() %>)</td> <td align="center"> <font size="5px">Dato fonte GISA DBI</font><br/>(Valori distinti per: <%=report.getCampoDistinctDbi() %>)</td></tr>
<tr style="<%=report.getCountNativo()!=report.getCountDbi() ? "background-color: #ffb2b2" : "" %>"><td align="center"><a href="#" onClick="apriLista('<%=report.getId()%>', '<%=idAsl%>', 'nativo')" style="font-size:25px"><%=report.getCountNativo() %></a></td> <td align="center"> <a href="#" onClick="apriLista('<%=report.getId()%>', '<%=idAsl%>', 'dbi')" style="font-size:25px"><%=report.getCountDbi() %></a></td></tr>
<tr><td align="center"> <%=report.getQueryNativo().replace("?", idAsl) %></td> <td align="center"> <%=report.getQueryDbi().replace("?", idAsl) %></td></tr>
<tr><td align="center"> <% if (report.getCountNativo()!=report.getCountDbi()) { %><a href="#" onClick="apriListaNonPresenti('<%=report.getId()%>', '<%=idAsl%>', 'nativo')" style="font-size:25px">Record non presenti su GISA DBI</a><% } %></td> <td align="center"> <% if (report.getCountDbi()!=report.getCountNativo()) { %><a href="#" onClick="apriListaNonPresenti('<%=report.getId()%>', '<%=idAsl%>', 'dbi')" style="font-size:25px">Record non presenti su GISA NATIVO</a><%} %></td></tr>
</table>


<br/><br/>
	<center>
<a href="ReportisticaInterna.do?command=Default" style="font-size:25px">Nuova estrazione</a>
</center>
