<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.HashMap"%> 

<%@page import="java.util.ArrayList"%>


<% 
	HashMap<String, HttpSession> utenti = null;
	utenti = (HashMap<String, HttpSession>)request.getSession().getServletContext().getAttribute("utenti");
%>

<%= utenti.keySet().size() %>

