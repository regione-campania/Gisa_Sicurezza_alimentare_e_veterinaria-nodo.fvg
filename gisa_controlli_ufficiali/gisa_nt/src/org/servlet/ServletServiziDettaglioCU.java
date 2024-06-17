package org.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.schedeCentralizzate.base.SchedaCentralizzataControllo;
import org.aspcfs.utils.web.LookupElement;
import org.aspcfs.utils.web.LookupList;
import org.json.JSONArray;
import org.json.JSONObject;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;
 
/**
 * Servlet implementation class ServletComuni
 */
public class ServletServiziDettaglioCU extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String cssScreen = "<style type=\"text/css\"> .dettaglioTabella table{ font-family: Arial, Helvetica, sans-serif;	font-size:12px;	color:#000000;} .dettaglioTabella td{	font-family: Arial, Helvetica, sans-serif;	font-size:12px;	color:#000000;} .grey {	 background-color:#EBEBEB;	 border: 1px solid black;	 }.blue {	 background-color:#e6f3ff;	  border: 1px solid black;	  text-transform:uppercase;	}.layout {	 border: 1px solid black;	 text-transform:uppercase;	} </style> ";
	String cssPrint = "<style type=\"text/css\"> .dettaglioTabella table{ font-family: Arial, Helvetica, sans-serif;	font-size:14px;	color:#000000;} .dettaglioTabella td{	font-family: Arial, Helvetica, sans-serif;	font-size:14px;	color:#000000;} .grey {	 background-color:#EBEBEB;	 border: 1px solid black;	 }.blue {	 background-color:#e6f3ff;	  border: 1px solid black;	  text-transform:uppercase;	}.layout {	 border: 1px solid black;	 text-transform:uppercase;	} </style> ";
	
	private static String CAPITOLO = "capitolo";
	private static String BARCODE = "barcode";
	private static String INDIRIZZO = "indirizzo";
	
	/** 
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletServiziDettaglioCU() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String objectId = request.getParameter("object_id");
		String tipoDettaglio = request.getParameter("tipo_dettaglio");
		String outputType = request.getParameter("output_type");
		String visualizzazione = request.getParameter("visualizzazione");
		
		if (outputType==null || outputType.equals("null") || outputType.equals(""))
			outputType = "html";
		if (visualizzazione==null || visualizzazione.equals("null") || visualizzazione.equals(""))
			visualizzazione = "tutto";
	
	
		Connection db = null;
		ConnectionPool cp = null ;
		try
		{
		ApplicationPrefs applicationPrefs = (ApplicationPrefs) getServletContext().getAttribute(
		"applicationPrefs");
		
		UserBean user = (UserBean) request.getSession().getAttribute("User");

		ApplicationPrefs prefs = (ApplicationPrefs) getServletContext().getAttribute("applicationPrefs");
		String ceDriver = prefs.get("GATEKEEPER.DRIVER");
		String ceHost = prefs.get("GATEKEEPER.URL");
		String ceUser = prefs.get("GATEKEEPER.USER");
		String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

		ConnectionElement ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
		ce.setDriver(ceDriver);

		cp = (ConnectionPool)getServletContext().getAttribute("ConnectionPool");
		db = cp.getConnection(ce,null);
		
		if (tipoDettaglio!=null && !tipoDettaglio.equals(""))
			gestisciDettaglio(request,response, db, objectId, tipoDettaglio, outputType, visualizzazione);
		else
			gestisciDettaglioVuoto(request,response, db);
		}
		 catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			
			cp.free(db,null);
		}
		

	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	
	public static String generaBarcode(HttpServletRequest request, String code) {
		String barcode = "";
		
		String protocol ="";
		int port = 80;
		String addr = "";
		
		try {protocol = "http://";} catch (Exception e) {}
		try {port = request.getLocalPort();} catch (Exception e) {}
		try {addr = request.getLocalAddr();} catch (Exception e) {}
		  
		if (port == 443)		
			protocol = "https://";
		
		String urlServlet = protocol+addr+":"+port+"/"+request.getContextPath()+"/"+"ServletBarcode";
		System.out.println("Servlet barcode: "+urlServlet);
		URL obj;
		HttpURLConnection conn = null;
		try {
			obj = new URL(urlServlet);
			
			conn = (HttpURLConnection) obj.openConnection();
			conn.setDoOutput(true);
			conn.setRequestMethod("GET");
			StringBuffer requestParams = new StringBuffer();
			requestParams.append("barcode");
			requestParams.append("=").append(code);
			OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
			wr.write(requestParams.toString());
			wr.flush();
			conn.getContentLength();
			BufferedReader in = new BufferedReader( new InputStreamReader(conn.getInputStream()));
			StringBuffer result = new StringBuffer();
			
			while (in != null) {
				String ricevuto = in.readLine();
				if (ricevuto==null)
					break;
				result.append(ricevuto); }
			//in.close();
			barcode = result.toString();
		} catch (Exception e){
			
		}
		finally {conn.disconnect();}
		return barcode;
	
}
		
		private String generaRigaJson(String nome, String valore, String attributo){
			if (nome==null)
				nome= "";
			else
				nome = nome.replaceAll("'", "");
			
			if (valore==null)
				valore="";
			else
				valore = valore.replaceAll("'", "");
			
			if (attributo==null)
				attributo = "";
			String output ="{nome:'"+nome+"', valore:'"+valore+"', attributo:'"+attributo.replaceAll("'", "\'")+"'}";
			return output;
		}
		
		
		protected void gestisciDettaglio(HttpServletRequest request, HttpServletResponse response, Connection db, String objectId, String tipoDettaglio, String outputType, String visualizzazione) throws ServletException, IOException, ParseException {
			// TODO Auto-generated method stub
			SchedaCentralizzataControllo scheda = new SchedaCentralizzataControllo();
			scheda.setTicketId(objectId);
			scheda.setTipo(tipoDettaglio);
			scheda.setDestinazione(visualizzazione);
			scheda.popolaScheda(db);
			
			if(outputType.equals("html"))
			{
				
			//String css = "<style type=\"text/css\"> table{ font-family: Arial, Helvetica, sans-serif;	font-size:14px;	color:#000000;}table, td{	font-family: Arial, Helvetica, sans-serif;	font-size:14px;	color:#000000;} .grey {	 background-color:#ededed;	 border: 1px solid black;	 }.blue {	 background-color:#bdcfff;	  border: 1px solid black;	  text-transform:uppercase;	}.layout {	 border: 1px solid black;	 text-transform:uppercase;	} </style> ";
				
			String objectCss = request.getParameter("object_css");
			if (objectCss==null || objectCss.equals("null") || objectCss.equals("")){
				if (scheda.getDestinazione().equals("print"))
					objectCss = cssPrint;
				else
					objectCss =cssScreen;
			}
			String output = "";
			
			output = "<table class=\"dettaglioTabella\" cellpadding=\"5\" style=\"border-collapse: collapse\" width=\"100%\"> <col width=\"33%\">";
			for(Map.Entry<String, String[]> elemento : scheda.getListaElementi().entrySet()){
				if ( elemento.getValue()[1]!=null && elemento.getValue()[1].equals(CAPITOLO)) {
				output = output + "<tr><td colspan=\"4\" class=\"blue\"><b>"+elemento.getKey().toUpperCase() +"</b></td></tr>";
				} 
				else if ( elemento.getValue()[0]!=null && !elemento.getValue()[0].replaceAll(" ", "").equals("") && !elemento.getValue()[0].equals("null")) {
			output = output + "<tr><td class=\"grey\" >"+elemento.getKey() +"</td>";
			output = output + "<td class=\"layout\">"+ elemento.getValue()[0] + "</td></tr>";
			}
			}
			output = output + "</table>";
			output = objectCss + output;
			
			response.getWriter().println(output.toString());
			}
			else if (outputType.equals("xml"))
			{
				String output="";
				
				output = output + "<Dettaglio>";
				output= output + "\n";
						;			
					for(Map.Entry<String, String[]> elemento : scheda.getListaElementi().entrySet()){
					output = output + "<nome>"+elemento.getKey()+"</nome>";
					output= output + "\n";
					output = output + "<valore>"+elemento.getValue()[0]+"</valore>";
					output= output + "\n";
					output = output + "<attributo>"+elemento.getValue()[1]+"</attributo>";
					output= output + "\n";
				}
					output = output + "</Dettaglio>";
					response.getWriter().println(output.toString());
			}
			else if (outputType.equals("json"))
			{
				JSONArray json_arr = new JSONArray();
				for(Map.Entry<String, String[]> elemento : scheda.getListaElementi().entrySet()){
					JSONObject json_obj = null ;
					String output = generaRigaJson(elemento.getKey(), elemento.getValue()[0], elemento.getValue()[1]);
					json_obj=new JSONObject(output);
					json_arr.put(json_obj);
				}
				
				response.setContentType("Application/JSON");
				response.getWriter().println(json_arr.toString().replaceAll(",}", "}"));
	            
			}
			
		}
		
		protected void gestisciDettaglioVuoto(HttpServletRequest request, HttpServletResponse response, Connection db) throws ServletException, IOException, SQLException {
			// TODO Auto-generated method stub
			
			//String css = "<style type=\"text/css\"> table{ font-family: Arial, Helvetica, sans-serif;	font-size:14px;	color:#000000;}table, td{	font-family: Arial, Helvetica, sans-serif;	font-size:14px;	color:#000000;} .grey {	 background-color:#EBEBEB;	 border: 1px solid black;	 }.blue {	 background-color:#e6f3ff;	  border: 1px solid black;	  text-transform:uppercase;	}.layout {	 border: 1px solid black;	 text-transform:uppercase;	} </style> ";
			
			String objectCss = request.getParameter("object_css");
			if (objectCss==null || objectCss.equals("null") || objectCss.equals(""))
				objectCss = cssScreen;
			
			LookupList tipoList = new LookupList(db, "lookup_tipo_controllo");
			tipoList.removeElementByLevel(4);
			tipoList.removeElementByLevel(5);
			tipoList.removeElementByLevel(7);
						
			String output = "";
			output = "<table class=\"dettaglioTabella\" cellpadding=\"5\" style=\"border-collapse: collapse\"> <col width=\"66%\">";
			output = output + "<tr><th colspan=\"2\">Lista dei tipi selezionabili</th></tr>";
			output = output + "<tr><th>Operatore</th> <th>Id</th></tr>";
			
			for (int i =0; i<tipoList.size(); i++){
				LookupElement elemento = (LookupElement) tipoList.get(i);
				output = output + "<tr><td class=\"layout\">"+elemento.getDescription()+"</td> <td class=\"layout\">"+ elemento.getCode() + "</td></tr>";
			}
			output = output + "</table>";
			
			output = objectCss + output;
			response.getWriter().println(output.toString());
			
		}
		private String visualizzaSuMappa(String indirizzo){
			String visualizzaSuMappa = " <a target=\"_blank\" href=\"http://www.google.it/maps?q="+indirizzo+"\">Visualizza su mappa</a>"; 
			return visualizzaSuMappa;
			
		}
		private String generaImmagine(String img){
			String immagine = "<img src=\""+img+"\"/>"; 
			return immagine;
			
		}
}
