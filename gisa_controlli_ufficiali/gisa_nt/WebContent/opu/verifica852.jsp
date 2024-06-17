<%@ page import=" org.aspcfs.modules.suap.utils.SuapDwr" %>


<%
String num=(String)request.getParameter("numRegistrazione");
String strResponse=org.aspcfs.modules.suap.utils.SuapDwr.getNumeroRegistrazione852(num);
%>

<%=strResponse %>