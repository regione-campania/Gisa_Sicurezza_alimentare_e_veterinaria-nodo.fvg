
<h2>Osservazioni</h2>
<table>
<tr id = "show_formali">
    
    <td>
    
   <input type = "hidden" id = "elementi_nc_formali" name = "elementi_nc_formali" value = "1">
   <input type = "hidden" id = "size_nc_formali" name = "size_nc_formali" value = "1">
      <table border="0" width="100%" cellspacing="0" cellpadding="10" class="empty" >
        <tr >
        <td>
        <table>
<!--        <tr><td colspan="3" ><input type = "button" value = "Inserisci un'altra Osservazione"  onclick="return clonaOsservazioni_Formali()"><input type = "button" value = "Elimina Osservazione" onclick="return removeOsservazioni('false',1);"><input type = "button" value = "Reset Osservazioni" onclick="resetOsservazioni('<%=CU.getId() %>',1,1,true)" ></td></tr>-->
        <tr id = "nc_formali_1" >
    
         <td>
         	
         	
         		<%
         		
        	if ( CU.getOggettoAudit().size()!=0)
        	{
        		
        		Iterator<Integer> ite = CU.getOggettoAudit().keySet().iterator();
        		%>
        		<select multiple="multiple" name = "Provvedimenti1_1"  id = "Provvedimenti1_1"  size = "6" onchange="calcolaPuntiFormali(document.getElementById('elementi_nc_formali').value,1)">	
        		<option value = "-1" selected="selected">-- SELEZIONA UN OGGETTO DELL'AUDIT --</option>
        		<%
        		while(ite.hasNext())
        		{
        			int code = ite.next();
        			
        			
        				
        			%>
        			<option value ="<%=code %>"><%=CU.getOggettoAudit().get(code) %></option>
        			<%
            		
        		}
        		%>
        		</select>
        		
        		<%        	
        		Osservazioni.setSelectSize(	6);
        		Osservazioni.setMultiple(true);
        		%>
         		
         		<%= Osservazioni.getHtmlSelect("Osservazioni_Formali",-1) %>
        		<%
        	}
        	else
        	{
        	%>
        	
        	Selezionare Oggetto dell'audit dal controllo
        		<%
        		Osservazioni.setSelectSize(8);
        		Osservazioni.setMultiple(true);
        		Osservazioni.setJsEvent("onchange=calcolaPuntiFormali(document.getElementById('elementi_nc_formali').value,1);"); %>
         		<%= Osservazioni.getHtmlSelect("Provvedimenti1_1",TicketDetails.getProvvedimenti()) %>
       <%} %>
         
<!--         <input type = "hidden" name = "Provvedimenti1_1_selezionato" id = "Provvedimenti1_1_selezionato" value = "-1">-->
         
        </td>
        
        </tr>
                
      </table> 
      </td></tr>
      <tr>
       <td><textarea name = "note_formali" rows="5" cols="60"></textarea> </td>
          <td>
          <center>Punteggio</center>
           <br>
            <input type="text" value="" name="puntiFormali" readonly="readonly" id="puntiFormali" onchange="calcolaTotale()">
          </td>
          
          <td>&nbsp;</td>

 </tr>
<tr>
<td >


</td>
</tr>
</table>
</td>
</tr>
</table>
  
 
  <input type = "hidden" name = "descrizione_or_combo_sel" id = "descrizione_or_combo_sel_formali" value = "false">
  
  <input type = "hidden" name = "stato_formali" id = "stato_formali" value = "true">
  