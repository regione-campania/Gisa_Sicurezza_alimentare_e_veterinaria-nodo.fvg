<%@page import="it.us.web.util.json.JSONArray"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="it.us.web.util.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>



<table>
	<tr>
	<th>Nome clinica</th> <th>ASL</th> <th>Data Cessazione</th> <th>Note Cessazione</th> <th>Note HD</th>
	</tr>
	
<%

int idClinica = Integer.parseInt(request.getParameter("idClinica"));
String dataCessazione = request.getParameter("dataCessazione");
String noteCessazione = request.getParameter("noteCessazione");

	Context ctxVam = new InitialContext();
	Connection connectionVam = null;
	javax.sql.DataSource dsVam = (javax.sql.DataSource)ctxVam.lookup("java:comp/env/jdbc/vamM");
	connectionVam = dsVam.getConnection();
		
	PreparedStatement stat =  connectionVam.prepareStatement("select * from public_functions.cessazione_clinica('"+idClinica+"', -1, '"+dataCessazione+"', '"+noteCessazione+"')" ); 
	
	ResultSet rs =  stat.executeQuery();
	while(rs.next())
	{
		String stringToParse = rs.getString(1);
		
		if (stringToParse==null)
			break; 
		JSONArray jsonArr = new JSONArray(stringToParse);
		for (int i = 0; i< jsonArr.length(); i++){
			  JSONObject jsonObj = jsonArr.getJSONObject(i);		
%>
		<tr>
		
		<td><%=jsonObj.get("nome") %></td>
		<td><%=jsonObj.get("asl") %></td>
		<td><%=jsonObj.get("data_cessazione")%></td>
		<td><%=jsonObj.get("note_cessazione")%></td>
		<td><%=jsonObj.get("note_hd")%></td>
		
		
		</tr> 
<%
		}
		}

	connectionVam.close();
	
%>

</table>






	 