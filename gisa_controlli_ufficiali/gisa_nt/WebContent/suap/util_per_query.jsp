

<%@page import="java.sql.*" %>

<% Connection con = null;
   PreparedStatement pst = null;
   ResultSet rs = null;
   String driverName = null;
   String urlDb = null;
   String user = null;
   String pw = null;
   String query = null;
   
   try
   {
	   
		driverName = (String)request.getAttribute("driverName");
		urlDb = (String) request.getAttribute("urlDb");
		user = (String) request.getAttribute("db_username");
		pw = (String) request.getAttribute ("db_password");
		query = (String) request.getAttribute("query"); //si presuppone che sia stata già riempita con i parametri
		
		
	   	Class.forName(driverName);
	   	
	   	con = DriverManager.getConnection(urlDb,user,pw);
	   	
	   	pst = con.prepareStatement(query);
	   	
	   	rs = pst.executeQuery();
	   	rs.next();
	   	String valoreOttenuto = rs.getString(1);
	   	request.setAttribute("valoreOttenutoDaQuery",valoreOttenuto);
	   	
   }
   catch(Exception ex)
   {
	   ex.printStackTrace();
   }
   finally
   {
	   if(con != null) con.close();
   }
   	
%>
