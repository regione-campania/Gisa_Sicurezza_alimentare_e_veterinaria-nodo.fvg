<jsp:useBean id="listaReport" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<%@page import="org.aspcfs.modules.reportisticainterna.base.Report"%>


<form id = "addAccount" name="addAccount" action="ReportisticaInterna.do?command=Report&auto-populate=true" method="post" onSubmit="loadModalWindow();">

<table class="details" width="100%" cellspacing="10" cellpadding="10">

<tr><th style="text-align:center !important"><font size="5px"> Report </font></th> <td>
<select id="idReport" name="idReport" style="font-size: 25px">
<% for (int i = 0; i<listaReport.size(); i++) {
	Report report = (Report) listaReport.get(i);%>
	<option value="<%=report.getId()%>"><%=report.getNome() %></option>
<%} %>

</select>
</td></tr>
<tr><th style="text-align:center !important"><font size="5px"> ASL </font></th> <td> <%SiteList.setJsEvent("style=\"font-size: 25px\""); %> <%=SiteList.getHtmlSelect("idAsl", -1) %> </td></tr>
<tr> <td colspan="2"><input type="submit" value="CONFERMA"/></td></tr>

</table>

</form>
