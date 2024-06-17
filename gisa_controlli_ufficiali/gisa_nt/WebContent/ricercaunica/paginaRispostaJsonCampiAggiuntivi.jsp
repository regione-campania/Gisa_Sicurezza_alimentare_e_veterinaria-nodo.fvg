<%@page import="org.aspcfs.modules.suap.base.LineaProduttivaValidazione"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>

<%@page import="org.aspcfs.modules.suap.base.LineaProduttiva"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList, java.util.HashMap"%>
<%@page import="org.json.*"%>
<%@page import="org.aspcfs.modules.opu.base.LineeMobiliHtmlFields" %>
<%@page import = "org.aspcfs.utils.Jsonable" %>



 
<%
    LineaProduttiva linea = (LineaProduttiva)request.getAttribute("lineaConCampiAssociati");
    JSONObject resp = new JSONObject(); //{status : int , campiLinea : jsonArray}
    if(linea == null)
    {
    	 resp.put("status","-1");
    	  
    	 
    }
    else
    {
    	ArrayList<LineeMobiliHtmlFields> campiAggiuntivi = linea.getHtmlFieldsValidazione();
    	JSONArray campi = new JSONArray(Jsonable.getListAsJsonArrayString(campiAggiuntivi));
    	resp.put("status","0");
    	resp.put("campiPerLinea",campi);
    	resp.put("idLinea",linea.getIdRelazioneAttivita()+"");
    	System.out.println( campiAggiuntivi.size());
    }
	  
	
	response.setContentType("application/json");
	out.write(resp.toString());
%>


