package org.aspcfs.modules.sintesis.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.modules.sintesis.base.LogImport;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;

/**
 * Servlet implementation class ReloadUtenti
 */
public class ServletSemaforoSintesis extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletSemaforoSintesis() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("[ServletSemaforoSintesis] Inizio procedura.");
		
		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;

		ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
		String ceHost = prefs.get("GATEKEEPER.URL");
		String ceUser = prefs.get("GATEKEEPER.USER");
		String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

		ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
		cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");
	
		String msgSemaforo = "";
		
		try {
			db = apriConnessione(request, cp, db, ce);
			
			 LogImport log = new LogImport();
		     msgSemaforo = log.checkSemaforo(db);
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}		
		
		if (msgSemaforo!=null && !msgSemaforo.equals("")){
			msgSemaforo = msgSemaforo.replace("&egrave;",  "e'").toUpperCase();
			
			
			if (msgSemaforo.contains("LETTURA DEL FILE IN CORSO"))
				msgSemaforo += "<br/><b>NON ABBANDONARE LA PAGINA.</b>";
		
			msgSemaforo = "<center><font color='red' size='5px'>"+msgSemaforo+"</font></center>";
		} else {
			msgSemaforo = "<center><input type='button' style='background-color: #4477AA; color: white; font-size: 20px;' value='VAI AI RISULTATI' onClick='parent.location.href=\"StabilimentoSintesisAction.do?command=PrepareImport\"'/></center>";
		}

		response.setContentType("text/html"); 
		response.getWriter().write(msgSemaforo);

		System.out.println("[ServletSemaforoSintesis] Fine procedura.");

	} 
	
	
	private Connection apriConnessione(HttpServletRequest request, ConnectionPool cp, Connection db, ConnectionElement ce) throws SQLException{
		db = cp.getConnection(ce, null);
		return db;
	}
	private void chiudiConnessione(ConnectionPool cp, Connection db){
		if (cp != null) {
			if (db != null) {
				cp.free(db, null);
			}
		}
	}
	
	

}