<h2>Raccomandazione Grave</h2>
  
  <table>
  <tr id = "show_gravi">
    
    <td>
     <input type = "hidden" id = "elementi_nc_gravi" name = "elementi_nc_gravi" value = "1">
   	<input type = "hidden" id = "size_nc_gravi" name = "size_nc_gravi" value = "1">
    <table border="0" cellspacing="0" cellpadding="10" class="empty"  >
        <tr >
        <td>
        <table >
<!--          <tr><td colspan="3"><input type = "button" value = "Inserisci un'altra Raccomandazione Grave" onclick="return clonaNC_Gravi()"><input type = "button" value = "Elimina Raccomandazione Grave" onclick="removeGravi('false');"><input type = "button" value = "Reset Raccomandazione Grave" onclick="resetGravi('<%=CU.getId() %>',3,true)" ></td></tr>-->
        <tr id = "nc_gravi_1">
        
         <td>
        <center> &nbsp;</center>
           <br>
      	<%
         		
        	if ( CU.getOggettoAudit().size()!=0)
        	{
        		
        		Iterator<Integer> ite = CU.getOggettoAudit().keySet().iterator();
        		%>
        		<select multiple="multiple" name = "Provvedimenti3_1"  id = "Provvedimenti3_1"  size = "6" onchange="calcolaPuntiGravi(document.getElementById('elementi_nc_gravi').value,25);">	
        		<option value = "-1" selected="selected">--  SELEZIONA UN OGGETTO DELL'AUDIT --</option>
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
        		Osservazioni.setSelectSize(6);
        		Osservazioni.setMultiple(true);
        		%>
         		<%= Osservazioni.getHtmlSelect("Osservazioni_Gravi",-1) %>
        		
        		<%        		
        	}
        	else
        	{
        	%>
        	
<!--         	<input type = "hidden" name = "Provvedimenti3_1" id = "Provvedimenti3_1" value = "-1"> -->
        	Selezionare Oggetto dell'audit dal controllo
        	
        	<%
        	Osservazioni.setSelectSize(8);
        	Osservazioni.setMultiple(true);
        	Osservazioni.setJsEvent("onchange=calcolaPuntiGravi(document.getElementById('elementi_nc_gravi').value,25);"); %>
         <%= Osservazioni.getHtmlSelect("Provvedimenti3_1",TicketDetails.getProvvedimenti())%>
          <input type = "hidden" name = "Provvedimenti3_1_selezionato" id = "Provvedimenti3_1_selezionato" value = "-1">
       <%} %>
        </td>
          </tr>
          </table>
      </td></tr>
      <tr>
                  <td><textarea name = "note_gravi" rows="5" cols="60"></textarea> </td>
      
           <td>Punteggio
          <input type="text" value="" name="puntiGravi" id="puntiGravi" readonly="readonly" onchange="calcolaTotale()">
          </td>
         
             <td>&nbsp;&nbsp;&nbsp;</td>
  
        </tr>
        <tr>
            <td>
            <div class="buttonwrapper">
   
    </div></td>
        </tr>
      </table>
    </td>
  </tr>
  </table>
      <input type = "hidden" name = "stato_gravi" id = "stato_gravi" value = "true">
  
    <input type = "hidden" name = "descrizione_or_combo_sel_gravi" id = "descrizione_or_combo_sel_gravi" value = "false">