<%@page import="org.json.JSONObject"%>
<jsp:useBean id="json" class="java.lang.String" scope="request" />
<%@ include file="../initPage.jsp"%>


<%
if(request.getAttribute("errore")!=null)
{
%>

	<%=showError(request, "errore")%>

<%
}


if(json!=null && !json.equals(""))
{
	JSONObject j = new JSONObject(json);
	Iterator<String> iterJson = (Iterator<String>)j.keys();
	while(iterJson.hasNext())
	{
		String key = iterJson.next();
		Object valoreObj = j.get(key);
		String valore="";
		if(!valoreObj.equals(JSONObject.NULL))
			if(valoreObj instanceof Integer)
				valore = ((Integer)valoreObj)+"";
			else
				valore = (String)valoreObj;
			valore=	(valore == null || valore.equalsIgnoreCase("null"))?(""):(valore);
		
%>
		<tr class="containerBody">
		   <td class="formLabel"><%=key%></td>
		   <td><%=valore%></td>
        </tr>
  
<%
	}
}
%>

