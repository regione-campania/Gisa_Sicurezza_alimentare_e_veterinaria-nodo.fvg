package org.servlet;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
/**
 * Servlet implementation class ServletComuni
 */
public class ServletTestTimeout extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/** 
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletTestTimeout() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		
		//res.setContentType("text/css");
		//java.io.PrintWriter out = res.getWriter();
		//out.println("Inizio servlet. ");
		//out.flush();
		for (int i = 1; i<720; i++){
			try {
				java.lang.Thread.sleep(5000);
				
				String tempo = "";
				int minuti = 0;
				int secondi = 0;
				secondi = i*5;
				minuti = secondi/60;
				secondi = secondi%60;
				tempo = ((minuti > 0) ? minuti+" minuti " : "") + ((secondi>0) ? secondi+" secondi" : "");
				System.out.println("[ServletTestTimeout] Sono passati "+tempo+".");
				Logger logger = Logger.getLogger("MainLogger");
				logger.info("[ServletTestTimeout] Sono passati "+tempo+".");
				
			//	out.println("Sono passati "+tempo+".");
			//	out.flush();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		//out.println("Fine servlet.");

		
		
		
	} 
}