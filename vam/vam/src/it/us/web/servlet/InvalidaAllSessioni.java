package it.us.web.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class ReloadUtenti
 */
public class InvalidaAllSessioni extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InvalidaAllSessioni() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @throws IOException 
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
		boolean esito = false;
		HashMap<String, HttpSession> utenti = (HashMap<String, HttpSession>)req.getSession().getServletContext().getAttribute("utenti");

		try {
			if(utenti != null && !utenti.isEmpty()){
				esito = closeAllSession(utenti);
			}
			if (esito==true)
				res.getWriter().write("OK");
			else
				res.getWriter().write("KO");
		} catch (Exception e) {
			e.printStackTrace();
			res.getWriter().write("Eccezione catturata :"+e.getMessage());
		}
	}

	public boolean closeAllSession(HashMap<String, HttpSession> utenti){
		Boolean esito = false; 
		Iterator it = utenti.entrySet().iterator();
		if(utenti != null && utenti.size() > 0){	    	
			try{
				while (it.hasNext()){
					Entry entry = (Entry) it.next();
					HttpSession sessione = (HttpSession)entry.getValue();
					it.remove();
					sessione.invalidate();
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
			
			if (utenti.size()==0) {
				utenti.clear();
				esito=true;
			}
		}

		return esito;
	}
}

