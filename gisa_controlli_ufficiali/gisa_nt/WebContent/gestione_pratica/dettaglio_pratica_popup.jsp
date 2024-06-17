<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="dettaglio_pratica" class="org.aspcfs.modules.gestionepratiche.base.Pratica" scope="request"/>
<%@ include file="../utils23/initPage.jsp" %>
<br>
<center>

<h2><%=dettaglio_pratica.getDesc_causale_pratica() %></h2>
<br><br>
<!-- causale pratica suap -->
<%if(dettaglio_pratica.getId_causale_pratica() == 1){ %>
	<table class="table details" id="tabella_pratiche" style="border-collapse: collapse" width="100%" cellpadding="5"> 
		<tr>
			<th style="text-align:center"><p>Data inserimento</p></th>
			<th style="text-align:center"><p>Numero pratica</p></th>
			<th style="text-align:center"><p>Comune</p></th>
			<th style="text-align:center"><p>DATA PEC / DATA SCIA</p></th>
			<th style="text-align:center"><p>tipo pratica</p></th>
			<th style="text-align:center"><p>Utente</p></th> 
		</tr>
	
		<tr >	
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataInserimentoPratica()) %></p></td>	
			<td align="center"><p><%=dettaglio_pratica.getNumeroPratica() %></p></td>	
			<td align="center"><p><%=dettaglio_pratica.getComuneRichiedente() %></p></td>
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataOperazione()) %></p></td>
			<td align="center"><p><%=dettaglio_pratica.getDesc_tipo_operazione() %></p></td>
			<td align="center"><p><dhv:username id="<%= dettaglio_pratica.getIdUtente() %>" /></p></td> 
		</tr>
	
	</table>
	
	
	<iframe 
		scrolling="no" 
		src="GestioneAllegatiGins.do?command=ListaAllegatiDettaglioPratica&numeroPratica=<%=dettaglio_pratica.getNumeroPratica()%>&alt_id=<%=dettaglio_pratica.getAltId()%>&stab_id=<%=dettaglio_pratica.getIdStabilimento()%>&idComunePratica=<%=dettaglio_pratica.getIdComuneRichiedente()%>"  
		id="listaallegatipratica" 
		style="width: 100%; height: 100%; border: none; "  
		onload="this.style.height=(this.contentDocument.body.scrollHeight)+'px';">
	</iframe>

<%} %>

<!-- causale errata corrige -->
<%if(dettaglio_pratica.getId_causale_pratica() == 2){ %>
	<table class="table details" id="tabella_pratiche" style="border-collapse: collapse" width="100%" cellpadding="5"> 
		<tr>
			<th style="text-align:center"><p>DATA INSERIMENTO</p></th>
			<th style="text-align:center"><p>NUMERO RICHIESTA</p></th>
			<th style="text-align:center"><p>DATA RICHIESTA</p></th>
			<th style="text-align:center"><p>TIPO OPERAZIONE</p></th>
			<th style="text-align:center; width: 20%;"><p>NOTE</p></th> 
			<th style="text-align:center"><p>UTENTE</p></th> 
		</tr>
	
		<tr >	
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataInserimentoPratica()) %></p></td>	
			<td align="center"><p><%=dettaglio_pratica.getNumeroPratica() %></p></td>	
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataOperazione()) %></p></td>
			<td align="center"><p><%=dettaglio_pratica.getDesc_tipo_operazione() %></p></td>
			<td align="center"><p><%=dettaglio_pratica.getNotaPratica() %></p></td>
			<td align="center"><p><dhv:username id="<%= dettaglio_pratica.getIdUtente() %>" /></p></td> 		
		</tr>
	
	</table>
	
	<iframe 
		scrolling="no" 
		src="GestioneAllegatiGins.do?command=ListaAllegatiDettaglioPratica&numeroPratica=<%=dettaglio_pratica.getNumeroPratica()%>&alt_id=<%=dettaglio_pratica.getAltId()%>&stab_id=<%=dettaglio_pratica.getIdStabilimento()%>&idComunePratica=<%=dettaglio_pratica.getIdComuneRichiedente()%>"  
		id="listaallegatipratica" 
		style="width: 100%; height: 100%; border: none; "  
		onload="this.style.height=(this.contentDocument.body.scrollHeight)+'px';">
	</iframe>

<%} %>

<!-- causale richiesta forze dell ordine -->
<%if(dettaglio_pratica.getId_causale_pratica() == 3){ %>
	<table class="table details" id="tabella_pratiche" style="border-collapse: collapse" width="100%" cellpadding="5"> 
		<tr>
			<th style="text-align:center"><p>DATA INSERIMENTO</p></th>
			<th style="text-align:center"><p>NUMERO RICHIESTA</p></th>
			<th style="text-align:center"><p>DATA  RICHIESTA</p></th>
			<th style="text-align:center"><p>TIPO OPERAZIONE</p></th>
			<th style="text-align:center; width: 20%;"><p>NOTE</p></th> 
			<th style="text-align:center"><p>UTENTE</p></th> 
		</tr>
	
		<tr >	
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataInserimentoPratica()) %></p></td>	
			<td align="center"><p><%=dettaglio_pratica.getNumeroPratica() %></p></td>
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataOperazione()) %></p></td>
			<td align="center"><p><%=dettaglio_pratica.getDesc_tipo_operazione() %></p></td>
			<td align="center"><p><%=dettaglio_pratica.getNotaPratica() %></p></td>
			<td align="center"><p><dhv:username id="<%= dettaglio_pratica.getIdUtente() %>" /></p></td> 		
		</tr>
	
	</table>

<%} %>

<!-- causale presa visione diretta -->
<%if(dettaglio_pratica.getId_causale_pratica() == 4){ %>
	<table class="table details" id="tabella_pratiche" style="border-collapse: collapse" width="100%" cellpadding="5"> 
		<tr>
			<th style="text-align:center"><p>DATA INSERIMENTO</p></th>
			<th style="text-align:center"><p>NUMERO RICHIESTA</p></th>
			<th style="text-align:center"><p>DATA  RICHIESTA</p></th>
			<th style="text-align:center"><p>TIPO OPERAZIONE</p></th>
			<th style="text-align:center; width: 20%;"><p>NOTE</p></th> 
			<th style="text-align:center"><p>UTENTE</p></th> 
		</tr>
	
		<tr >	
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataInserimentoPratica()) %></p></td>	
			<td align="center"><p><%=dettaglio_pratica.getNumeroPratica() %></p></td>
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataOperazione()) %></p></td>
			<td align="center"><p><%=dettaglio_pratica.getDesc_tipo_operazione() %></p></td>
			<td align="center"><p><%=dettaglio_pratica.getNotaPratica() %></p></td>
			<td align="center"><p><dhv:username id="<%= dettaglio_pratica.getIdUtente() %>" /></p></td> 		
		</tr>
		
	</table>

<%} %>

<!-- causale altro -->
<%if(dettaglio_pratica.getId_causale_pratica() == 5){ %>
	<table class="table details" id="tabella_pratiche" style="border-collapse: collapse" width="100%" cellpadding="5"> 
		<tr>
			<th style="text-align:center"><p>DATA INSERIMENTO</p></th>
			<th style="text-align:center"><p>NUMERO RICHIESTA</p></th>
			<th style="text-align:center"><p>TIPO OPERAZIONE</p></th>
			<th style="text-align:center; width: 20%;"><p>NOTE</p></th> 
			<th style="text-align:center"><p>UTENTE</p></th> 
		</tr>
	
		<tr >	
			<td align="center"><p><%=toDateasString(dettaglio_pratica.getDataInserimentoPratica()) %></p></td>	
			<td align="center"><p><%=dettaglio_pratica.getNumeroPratica() %></p></td>
			<td align="center">
				<p>
					<%if(dettaglio_pratica.getDesc_tipo_operazione().toLowerCase().contains("cessazione")
							&& dettaglio_pratica.getNotaPratica().toLowerCase().contains("ufficio") ) { %>
						CESSAZIONE D'UFFICIO
					<% } else { %>
						<%=dettaglio_pratica.getDesc_tipo_operazione() %>
					<%} %>
		   		</p>
			</td>
			<td align="center"><p><%=dettaglio_pratica.getNotaPratica() %></p></td>
			<td align="center"><p><dhv:username id="<%= dettaglio_pratica.getIdUtente() %>" /></p></td> 		
		</tr>	
	
	</table>

<%} %>
</center>
  		

  	
 