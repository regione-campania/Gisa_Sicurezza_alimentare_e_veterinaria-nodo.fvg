<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import ="org.json.JSONObject" %>

 
	<%
		JSONObject campi = (JSONObject)request.getAttribute("jsonObj");
		response.setContentType("application/json");
		response.getWriter().println(campi.toString());
	 %>
 