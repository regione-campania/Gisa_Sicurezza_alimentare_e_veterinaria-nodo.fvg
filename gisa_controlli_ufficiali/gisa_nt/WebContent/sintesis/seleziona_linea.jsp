<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>



<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<jsp:useBean id="Richiesta" class="org.aspcfs.modules.sintesis.base.StabilimentoSintesisImport" scope="request"/>


<%@ include file="../utils23/initPage.jsp" %>
   
  <dhv:container name="sintesisimport" selected="Richieste" object=""  param="">
  
  
  <script> function checkForm(form){
	  var idLinea = form.idLineaProduttiva.value;
	  
	  if (idLinea != parseInt(idLinea, 10))
	  	  alert('Selezionare una linea!');
	  else{
		 form.idLinea.value = idLinea;
		 loadModalWindow();
		 form.submit();
	  }
	  
  }
  
  function annulla(form){
		if (confirm('ATTENZIONE! Annullare le modifiche?')){
			loadModalWindow();
			 window.history.back();
			 }
		
	}
  </script>
  		
<form id = "addAccount" name="addAccount" action="StabilimentoSintesisAction.do?command=SelezionaLinea&auto-populate=true" method="post">
<input type="hidden" id="idRichiesta" name="idRichiesta" value="<%=Richiesta.getId()%>"/>	
<input type="hidden" id="idLinea" name="idLinea" value=""/>	

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">

<tr><th colspan="2">Riepilogo</th></tr>


<tr>
<td class="formLabel">Approval number</td>
<td><%=Richiesta.getApprovalNumber() %></td>
</tr>

<tr>
<td class="formLabel">Denominazione sede operativa</td>
<td><%=Richiesta.getDenominazioneSedeOperativa() %></td>
</tr>

<tr>
<td class="formLabel">Ragione Sociale Impresa</td>
<td><%=Richiesta.getRagioneSocialeImpresa() %></td>
</tr>

<tr>
<td class="formLabel">Attivita'</td>
<td><%=Richiesta.getAttivita() %></td>
</tr>


<tr>
<td class="formLabel">Stato attivita'</td>
<td><%=Richiesta.getStatoAttivita() %></td>
</tr>

<tr>
<td class="formLabel">Descrizione Sezione</td>
<td><%=Richiesta.getDescrizioneSezione() %></td>
</tr>

<tr>
<td class="formLabel">Data inizio attivita'</td>
<td><%=Richiesta.getDataInizioAttivita() %></td>
</tr>

<tr>
<td class="formLabel">Data fine attivita'</td>
<td><%=Richiesta.getDataFineAttivita() %></td>
</tr>

	
<tr>
<td class="formLabel">Nuova linea</td>
<td>

<jsp:include page="../gestioneml/navigaml.jsp">
<jsp:param name="flagSintesis" value="true" />
<jsp:param name="rev" value="<%=org.aspcfs.modules.suap.utils.SuapDwr.getMaxRevMl() %>" />
</jsp:include>

</td>
</tr>

<tr><td align="center"><input type="button" value="ANNULLA" onClick="annulla(this.form)"/></td>
<td align="center"><input type="button" value="CONFERMA" onClick="checkForm(this.form)"/></td></tr>

	
</table>
</form>


</dhv:container>

</body>
</html>