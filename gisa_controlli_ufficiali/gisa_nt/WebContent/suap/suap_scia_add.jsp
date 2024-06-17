

 <script>
 
 function sceltaOperazione(contesto,url) //tiposcelta 1 per registrati, 2 per riconosciuti
 {
	 if(contesto=='Suap')
		 {
		 goTo(url);
		 }
	 else
		 {
		 document.forms['scelta'].action=url;
		 
		 $( "#dialogSceltaComune" ).dialog('open');
		 }
 }
 
 </script>
 
 <%
 String contesto = (String) application.getAttribute("SUFFISSO_TAB_ACCESSI");
	if (contesto!=null && contesto.equals("_ext"))
		contesto="Suap";
	else
		contesto = "Gisa";
	
 
 %>
 
 <dhv:permission name="opu-add"> 
<fieldset style="display: inline-block;"> 
<legend><b></b></legend>
 
<table class="noborder" >
<tr>
	 <td>
	 	<input type="button" class="aniceBigButton" style="height:50px !important; width:350px !important;" 
	 		value="Gestione Att. fisse" 
	 		onclick="alert('Attenzione, questa funzionalità è ora disponibile dal cavaliere PRATICHE SUAP 2.0');"
	 		<%-- 
	 		onClick="sceltaOperazione('<%=contesto %>','SuapStab.do?command=Scelta&tipoInserimento=4&stato=7&fissa=true')"
	 		 --%>
	 		/> 
	 </td>
	 <td>
	 	<input type="button" class="aniceBigButton" style="height:50px !important; width:350px !important;" 
	 		value="Gestione Att. mobili" 
	 		onclick="alert('Attenzione, questa funzionalità è ora disponibile dal cavaliere PRATICHE SUAP 2.0');"
	 		<%-- 
	 		onClick="sceltaOperazione('<%=contesto %>','SuapStab.do?command=Scelta&tipoInserimento=4&stato=7&fissa=false')"
	 		--%>
	 		/>
	 </td>
 	 <td>
  		<input type="button" class="aniceBigButton" style="height:50px !important; width:350px !important;" 
  			value="APICOLTURA"
  			onclick="alert('Attenzione, questa funzionalità è ora disponibile dal cavaliere PRATICHE SUAP 2.0');" 
  			<%-- 
  			onClick="sceltaOperazione('<%=contesto %>','SuapStab.do?command=Scelta&tipoInserimento=2&stato=7&fissa=api')"
  			--%>
  			/>  
  	</td>
</tr>
</table>
 
</fieldset>
  </dhv:permission> 
  
  <% if (contesto=="Suap") { %>
  <div align="right">
  <a href="#" onclick="window.open('suap/download/ModAccredSuap.pdf')">Modulo richiesta accreditamento suap
  <img src="gestione_documenti/images/pdf_icon.png" width="20"/>
  </a>
  </div>
  <%} %>
  
  
  
  