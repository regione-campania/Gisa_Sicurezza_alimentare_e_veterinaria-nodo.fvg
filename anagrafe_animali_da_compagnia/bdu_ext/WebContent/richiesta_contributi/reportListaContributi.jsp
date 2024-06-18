<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../initPage.jsp" %>
	

<%@page import="org.aspcfs.modules.richiestecontributi.base.RichiestaContributi"%>
<jsp:useBean id="Asl" class="org.aspcfs.utils.web.LookupList" scope="request"/>


	<head>
		<link rel="stylesheet"  type="text/css" href="css/jmesa.css"></link>
		
		<script type="text/javascript" src="javascript/jquery-1.3.min.js"></script>
		<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
		<script type="text/javascript" src="javascript/jmesa.js"></script>
	</head>
		<p>
			<font color="red">
				<%=toHtmlValue( (String)request.getAttribute( "Error" ) ) %>
			</font>
		</p>
		
		<%
		List<RichiestaContributi> lrc = (List) request.getAttribute( "listaRC" );
		
		boolean approvati=(Boolean) request.getAttribute("approvati");
		
		%>
		
				<table class="details"  cellspacing="0" cellpadding="5" border="0" width="60%">
				<%if (lrc.size()>0){ %>
				<tr>
					<%if (approvati==true) {%>
					<th colspan="8" align="center">Report Richieste Contributi Elaborate</th>
					<%} else { %>
					<th colspan="8" align="center">Report Richieste Contributi Respinti</th>
					<%} %>
				</tr>
				<tr>
					<th >ID richiesta</th>
					<th >ASL richiedente</th>
					<th >Data di richiesta</th>
					<%--<th> Tipologia </th>--%>
					<th> Numero Decreto </th>
					<th >Data del decreto </th>
					<th >Dettaglio </th>
				</tr>
				
				
				<%
				 RichiestaContributi rc;
		      	 for(int i=0;i<lrc.size();i++) {
		    	 rc=(RichiestaContributi)lrc.get(i);
		    	  %> 
		    	  
					<tr>						
						<td><%=rc.getId() %></td>
						<td><%=rc.getDescrizioneAsl() %></td>
						<td><%=rc.formatData(rc.getData_richiesta())%></td>
					<%--	<td><%=rc.getTipo_richiesta() %></td>--%>
						<td><%=rc.getNumeroDecreto() %>
						<td><%=rc.formatData(rc.getData_Decreto()) %></td>
						
						<td> 
							<form method="post" id="<%=i %>"action="ContributiSterilizzazioni.do?command=ViewDetailsContributi&idDettaglio=<%=rc.getId() %>&n_protocollo=<%=rc.getProtocollo()%> ">
							<input type="submit" value="Dettaglio" />
							</form>
						</td>						
					</tr>	
					
				<%}%>
				<%}	else {%>
					<%if (approvati==true) {%>
				
						<label>
							<font color="red">
								Operazione non possibile perchè non ci sono contributi elaborati
							</font>
					</label>
					<%} else { %>
						<label>
							<font color="red">
								Operazione non possibile perchè non ci sono contributi respinti
							</font>
						</label>
					
				<%}} %>
				
				
			</table>
			