
<%@page import="org.aspcfs.utils.GestoreConnessioni"%><%@ page language="java" import="java.sql.*" %>
<% response.setContentType("text/html");%>
<%

String str=request.getParameter("queryString");
Connection con =  null ;
try {

con = GestoreConnessioni.getConnection();

String sql = "SELECT nome FROM comuni1 WHERE notused is null and nome ilike '"+str+"%' LIMIT 10";
Statement stm = con.createStatement();
stm.executeQuery(sql);
ResultSet rs= stm.getResultSet();
while (rs.next ()){
out.println("<li onclick='fill("+rs.getString("nome")+");'>"+rs.getString("nome")+"</li>");
}}catch(Exception e){
out.println("Exception is ;"+e);
}
finally
{
	GestoreConnessioni.freeConnection(con) ;
}
%>
