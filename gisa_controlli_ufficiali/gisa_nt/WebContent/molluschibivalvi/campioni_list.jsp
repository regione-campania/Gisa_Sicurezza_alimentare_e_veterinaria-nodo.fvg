
<%@page import="org.aspcfs.modules.campioni.base.Analita"%><jsp:useBean id="EsitoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<%@page import="org.aspcfs.modules.campioni.base.TicketList"%><%
TicketList listaCampioni = (TicketList)request.getAttribute("CampioniList");
%>
<%@ include file="../utils23/initPage.jsp" %>

	
<%@page import="java.util.Iterator"%>
<dhv:evaluate if="<%= !isPopup(request) %>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td><a href="MolluschiBivalvi.do">Molluschi bivalvi</a> > <%
			if (request.getParameter("return") == null) {
			%>
			<a href="MolluschiBivalvi.do?command=Search"><dhv:label
				name="stabilimenti.SearchResults">Search Results</dhv:label></a> > <%
			} 
			%>
			
			
			<a href="MolluschiBivalvi.do?command=Details&orgId=<%= listaCampioni.getOrgId() %>">Scheda Molluschi Bivalvi</a> > History Classificazioni
			
			</td>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>
<br>

<table cellpadding="8" cellspacing="0" border="0" width="100%" class="pagedList">
<tr>
			<th colspan="6" style="background-color: rgb(204, 255, 153);" ><strong>
				<dhv:label name="">Lista Campioni</dhv:label>
		    </strong></th>
	    </tr>
	    <tr>
	    <th width="5%">Identificativo</th>
	    <th width="5%">Data Prelievo</th>
	     <th width="10%">Num Verbale</th>
	      <th width="20%">Matrice</th>
	     <th width="20%">Analisi</th>
	    </tr>
	   
	   <%
	
    Iterator j = listaCampioni.iterator();
	
    if ( j.hasNext() ) {
      int rowid = 0;
      int i =0;
      while (j.hasNext()) {      
        i++;
        rowid = (rowid != 1?1:2);
        org.aspcfs.modules.campioni.base.Ticket thisTic = (org.aspcfs.modules.campioni.base.Ticket)j.next();
        
  %>
  
  <tr class="row<%= rowid %>">
      <td >
     <a href = "MolluschiBivalviCampioni.do?command=TicketDetails&id=<%= thisTic.getId() %>&orgId=<%= thisTic.getOrgId()%>">
      <%=thisTic.getIdentificativo() %>
      </a>
      </td>
      
      <td><%= toDateasString(thisTic.getAssignedDate()) %></td>
      <td >
      <%=thisTic.getLocation() %>
      </td>
      
        <td >
      <%
     Iterator<Integer> it = thisTic.getMatrici().keySet().iterator() ;
      while (it.hasNext())
      {
    	  out.println(thisTic.getMatrici().get(it.next()));
      }
      
      %>
      </td>
      
       <td >
      <%
      ArrayList<Analita> itAnaliti = thisTic.getTipiCampioni();
      for (Analita analita : itAnaliti)
      {
    	  out.println("- "+analita.getDescrizione()+" (<b>Esito:</b>  "+EsitoCampione.getSelectedValue(analita.getEsito_id())+")<br><br>");
      }
      %>
      </td>
     
      
     
      </tr>
      
      <%}
       }
      else
      {
    	  %>
    	  <tr><td colspan="5">Nessun Campione Rilevato</td></tr>
    	  <%
      }
      %>
	   
</table>