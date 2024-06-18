<%@page import="it.us.web.util.json.JSONArray"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="it.us.web.util.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>


<script>
function openCessazioneClinica(id){
	window.location.href = 'cessazioneService_CessazioneClinica_Form.jsp?id='+id;
}

</script>


<table>
	<tr>
	<th>Nome clinica</th> <th>ASL</th> <th>Data Cessazione</th> <th>Operazione</th>
	</tr>
	
<%

int aslClinica = Integer.parseInt(request.getParameter("aslClinica"));
String nomeClinica = request.getParameter("nomeClinica");
int statoClinica = Integer.parseInt(request.getParameter("statoClinica"));


	Context ctxVam = new InitialContext();
	Connection connectionVam = null;
	javax.sql.DataSource dsVam = (javax.sql.DataSource)ctxVam.lookup("java:comp/env/jdbc/vamM");
	connectionVam = dsVam.getConnection();
		
	PreparedStatement stat =  connectionVam.prepareStatement("select * from public_functions.ricerca_clinica('"+nomeClinica+"', "+aslClinica+", "+statoClinica+")" ); 
	
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
		<td>
		<% if (jsonObj.get("data_cessazione")==null || "".equals(jsonObj.get("data_cessazione"))){ %>
		<input type="button" onClick="openCessazioneClinica('<%=jsonObj.get("id")%>')" value="Cessazione clinica"/>
		<%} %>
		</td>
		</tr> 
<%
		}
		}

	connectionVam.close();
	
%>

</table>






	 