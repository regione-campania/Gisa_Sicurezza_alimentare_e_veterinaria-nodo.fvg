
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
     <dhv:label name = "opu.operatore_gisa"> <strong></strong></dhv:label>
    </th>
  </tr>
  
	<dhv:evaluate if="<%= hasText(OperatoreDettagli.getRagioneSociale()) %>">
      	<tr class="containerBody">
        	<td nowrap class="formLabel" name="orgname1" id="orgname1">
        		<dhv:label name="opu.operatore.intestazione"></dhv:label>
        	</td>
        	<td>
			 	<%= toHtmlValue(OperatoreDettagli.getRagioneSociale()) %>
       		</td>
      	</tr>
     </dhv:evaluate>

	<dhv:evaluate if="<%= hasText(OperatoreDettagli.getPartitaIva()) %>">
      	<tr class="containerBody">
        	<td nowrap class="formLabel" name="orgname1" id="orgname1">
          		<dhv:label name="opu.operatore.piva"></dhv:label>
        	</td>
        	<td>
			 	<%= toHtmlValue(OperatoreDettagli.getPartitaIva()) %>
       		</td>
      	</tr>
     </dhv:evaluate>

	<dhv:evaluate if="<%= hasText(OperatoreDettagli.getCodFiscale()) %>">
      	<tr class="containerBody">
        	<td nowrap class="formLabel" name="orgname1" id="orgname1">
          		<dhv:label name="opu.operatore.cf"></dhv:label>
        	</td>
        	<td>
			 	<%= toHtmlValue(OperatoreDettagli.getCodFiscale()) %>
       		</td>
      	</tr>
     </dhv:evaluate>
     <dhv:evaluate if="<%= hasText(OperatoreDettagli.getDomicilioDigitale()) %>">
      	<tr class="containerBody">
        	<td nowrap class="formLabel" name="orgname1" id="orgname1">
          		Domicilio Digitale
        	</td>
        	<td>
			 	<%= toHtmlValue(OperatoreDettagli.getDomicilioDigitale()) %>
       		</td>
      	</tr>
     </dhv:evaluate>
    
</table>

<br/>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong><dhv:label name="opu.sede_legale"></dhv:label>
	 </th>
 </tr> 
 
 	<dhv:evaluate if="<%= (OperatoreDettagli.getSedeLegale() != null) %>">
  	<tr>
    	<td class="formLabel" nowrap>
      		<dhv:label name="opu.sede_legale.indirizzo"></dhv:label>
    	</td>
    	<td>
    		<%
    			String comune = ComuniList.getSelectedValue(OperatoreDettagli.getSedeLegale().getComune());
    			String via = (OperatoreDettagli.getSedeLegale().getVia()!= null)? OperatoreDettagli.getSedeLegale().getVia():"";  
    		%>
      		<%= comune + ", " + via %>
    	</td>
  </tr>
 </dhv:evaluate>
 </table>

<br>

 <dhv:evaluate if="<%= (OperatoreDettagli.getRappLegale() != null )  %>">

  	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  		<tr>
    		<th colspan="2">
      			<strong><dhv:label name="opu.soggetto_fisico"></dhv:label></strong>
     		</th> 
  		</tr>
  		<tr>
    		<td class="formLabel" nowrap>
      			<dhv:label name="opu.soggetto_fisico.nome"></dhv:label>
    		</td>
    		<td>
      			<%=OperatoreDettagli.getRappLegale().getCognome() + " " + OperatoreDettagli.getRappLegale().getNome() %>
    		</td>
  		</tr>
  		<tr>
    		<td class="formLabel" nowrap>
      			<dhv:label name="opu.soggetto_fisico.cf"></dhv:label>
    		</td>
    		<td>
    			<%=OperatoreDettagli.getRappLegale().getCodFiscale() %>
    		</td>
    	</tr>
     	<tr>
    		<td class="formLabel" nowrap>
      			<dhv:label name="opu.soggetto_fisico.comune_nascita"></dhv:label>
    		</td>
    		<td>
    			<%=OperatoreDettagli.getRappLegale().getComuneNascita() %>
    		</td>
    	</tr>
     	<tr>
    		<td class="formLabel" nowrap>
      			<dhv:label name="opu.soggetto_fisico.data_nascita"></dhv:label>
    		</td>
    		<td>
    			<%=toDateString(OperatoreDettagli.getRappLegale().getDataNascita()) %>
    		</td>
    	</tr>
     	<tr>
    		<td class="formLabel" nowrap>
      			<dhv:label name="opu.soggetto_fisico.sesso"></dhv:label>
    		</td>
    		<td>
    			<%=OperatoreDettagli.getRappLegale().getSesso() %>
    		</td>
    	</tr>
    
	</table>
	
 </dhv:evaluate>

<br/>

<% int columnCount = 0; %>

<a href= "StabilimentoAction.do?command=Add&idOp=<%=OperatoreDettagli.getIdOperatore() %>" ><dhv:label name="opu.stabilimento.nuovo"></dhv:label> </a>

<br/>


 <!-- DETTAGLIO LINEE PRODUTTIVE PRESENTI NELL'OPERATORE -->

 <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details"> 
 		<tr>
			<th colspan="7" style="background-color: rgb(204, 255, 153);" >
				<strong> <dhv:label name="opu.stabilimento.lista"></dhv:label></strong>
			</th>
	    </tr>
  		<tr>
        	<th nowrap <% ++columnCount; %>>
           		<strong><a href=""><dhv:label name="opu.stabilimento.asl"></dhv:label></a></strong>
	 		</th>
	 		<th nowrap <% ++columnCount; %>>
      			<dhv:label name="opu.stabilimento.comune"></dhv:label>
    		</th>
    		<th nowrap <% ++columnCount; %>>
         		<dhv:label name="opu.stabilimento.indirizzo"></dhv:label>
			</th>
			<th nowrap <% ++columnCount; %> colspan="3">
         		<dhv:label name="opu.stabilimento.linea_produttiva"></dhv:label>
			</th>
			
			
		</tr>
		
		
		
  <%
  StabilimentoList listaStabilimenti = OperatoreDettagli.getListaStabilimenti();
  if (listaStabilimenti.size()>0)
  {
		Iterator<Stabilimento> itStabList = listaStabilimenti.iterator() ;
		while (itStabList.hasNext())
		{
			Stabilimento thisStab = itStabList.next();
			int numLineeProduttive = thisStab.getListaLineeProduttive().size();
			%>
			<tr>
			<td><a href = "StabilimentoAction.do?command=Details&opId=<%=thisStab.getIdOperatore() %>&stabId=<%=thisStab.getIdStabilimento() %>" ><%=AslList.getSelectedValue(thisStab.getIdAsl()) %></a></td>
			<td><%=(thisStab.getSedeOperativa()!=null)? ComuniList.getSelectedValue(thisStab.getSedeOperativa().getComune()):"" %></td>
			<td><%=(thisStab.getSedeOperativa()!=null)? thisStab.getSedeOperativa().getVia():"" %></td>
			<td>
			<%
				LineaProduttivaList listaLineaProd = thisStab.getListaLineeProduttive() ;
				if (listaLineaProd.size()>0)
				{
					Iterator<LineaProduttiva> itlpList = listaLineaProd.iterator() ;
			%>
					<table class="noborder" width="100%">
					
			<%
				while (itlpList.hasNext())
				{
					LineaProduttiva lp = itlpList.next() ;
					%>
					<tr>
						<td> <%=toHtmlValue(lp.getCodice()) + " - "+lp.getCategoria() + " - " +lp.getAttivita()  %> </td>
					</tr>
					<%
					
					
				}
			%>
			
			</table>
			<%
				}
			
			%>
		</td>
			</tr>
			<%
			
		}
	  
  }
  %>
  
</table>
<!-- FINE DETTAGLIO LINEE PRODUTTIVE PER OPERATORE -->

