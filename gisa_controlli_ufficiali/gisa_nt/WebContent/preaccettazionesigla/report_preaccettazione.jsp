<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@page import="java.util.ArrayList"%>
<%@page import="org.aspcfs.utils.Report"%>

<jsp:useBean id="report_preac" class="org.json.JSONArray" scope="request"/>
  <%@ include file="../utils23/initPage.jsp" %>
  
  <% ArrayList<Report> report = (ArrayList<Report>)request.getAttribute("report"); %>

<style>



</style> 

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="ReportPreaccettazione.do?command=SearchForm">CERCA PREACCETTAZIONE</a> > 
			<a href="ReportPreaccettazione.do?command=ReportForm">GENERA REPORT PREACCETTAZIONE </a> > REPORT
		</td>
	</tr>
</table>

<center>
<h3>REPORT PREACCETTAZIONE</h3>
<table class="details" width="60%">
<tr>
	<th>ASL</th>
	<th>N.</th>
	<th>STATO</th>
</tr>

<% for(Report r : report){ %>
<tr>
	<td><%= r.getAsl() %></td>
	<td><%= r.getN() %></td>
	<td><%= r.getStatoDesc() %></td>
</tr>	
<% } %>

</table>
<br><br>
</center> 