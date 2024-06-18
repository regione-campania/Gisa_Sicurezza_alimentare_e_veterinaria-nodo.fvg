<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../initPage.jsp" %>
<jsp:useBean id="RC" class="org.aspcfs.modules.richiestecontributi.base.RichiestaContributi" scope="request"/>	
<%@page import="org.aspcfs.modules.richiestecontributi.base.RichiestaContributi,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.anagrafe_animali.base.*"%>
<jsp:useBean id="Asl" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="specieList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>


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
		List<Animale> listaCani=(List)session.getAttribute( "listaCaniDettaglio" );
		int num=listaCani.size();
		if (num!=0){
		
		%>
		
		<form method="post" name="GeneraPdf" action="ContributiSterilizzazioni.do?command=prova">
					
			<table class="details"  cellspacing="0" cellpadding="8" border="0" width="70%">
				<tr>
					<th colspan="11" align="center">Dettaglio Richiesta contributi  </th>
				</tr>
				<tr>
					<th> Microchip</th>
					<th> Tipo Animale</th>
					<th> Proprietario</th>
					<th> Asl Richiedente</th>
					<th> Data Sterilizzazione</th>
					<th> Comune Proprietario </th>
					<th> Comune Cattura </th>
					<th> Comune Colonia </th>
					<th> Tipologia</th>
					<th width="20%"> Pagamento </th>
					<th><input type="button" value="Genera pdf" onclick="location.href='ContributiSterilizzazioni.do?command=prova&&idProtocollo=<%=request.getAttribute("numero_protocollo")%>'" /></th>
				</tr>
				
				<%  Animale c;
					for (int i=0;i<listaCani.size();i++) {
					c=listaCani.get(i);
				%>
					<tr>						
						<td><%=c.getMicrochip() %></td>
					<dhv:evaluate if="<%=c.isFlagCattura()%>">
						<td>Catturato</td>
					</dhv:evaluate>
					<dhv:evaluate if="<%=!c.isFlagCattura()%>">
						<td>Padronale</td>
					</dhv:evaluate>
					
					<td><%=c.getNomeCognomeProprietario() %></td>
				    <td>&nbsp; <%=Asl.getSelectedValue(c.getIdAslRiferimento()) %></td>
					<td><%=toDateasString(c.getDataSterilizzazione())%></td>
						
						
						
					<!-- Comune proprietario -->
					<%//Operatore proprietario = c.getProprietario();
					  //Stabilimento stab = (Stabilimento) proprietario.getListaStabilimenti().get(0);
					  //Indirizzo ind =  stab.getSedeOperativa();
					 // int idComune = ind.getComune();
					 int idComune = c.getIdComuneProprietario();
						%>
					<td><%= comuniList.getSelectedValue(idComune) %></td>
					
					<!-- Comune Cattura -->
					<%//if (c.getIdSpecie() == Cane.idSpecie) {
						//Cane thisCane = (Cane) listaCani.get(i);
						if  (c.getIdComuneCattura() < 1 ) {%>
					<td>  --- </td>
					<% } else {%>
					<td><%= comuniList.getSelectedValue(c.getIdComuneCattura()) %></td>
					<%}//}else{ %><%//} %>
				
				<!-- EVENTUALE COMUNE COLONIA -->
						<!-- Comune colonia -->
						<%
						 int idComuneColonia = -1;
						if (c.getIdSpecie() == Gatto.idSpecie){
							idComuneColonia = c.getIdComuneDetentore();
						//	Gatto thisGatto  = (Gatto) listaCani.get(i);
						//	Operatore detentore = thisGatto.getDetentore();
							
						//	if (detentore != null && detentore.getListaStabilimenti().size() > 0){
						  //		stab = (Stabilimento) detentore.getListaStabilimenti().get(0);
						  //		LineaProduttiva lp = (LineaProduttiva) stab.getListaLineeProduttive().get(0);
						  //		if (lp.getIdAttivita() == 7){
						    //		ind =  stab.getSedeOperativa();
							
						   idComuneColonia = c.getIdComuneDetentore();
						  		//}
							//}
						}
							%>
							<td><%= comuniList.getSelectedValue(idComuneColonia) %> &nbsp; </td>
					
						<td><%=specieList.getSelectedValue(c.getIdSpecie()) %></td>
						<% if(c.isContributoPagato()==true) { %>
						<td>
						<%out.println("SI"); %>
  						</td>
						<%}
						else {
						%>
						
						<td>
  						<%out.println("NO"); %></td>		
						<%}%>
					</tr>	
					
				<%}%>

			</table>
	   </form>
	  <%} else {%>
<label>
		<font color="red">
			Operazione non possibile perchè non ci sono animali in questa pratica</font>
		</label>
<%} %>