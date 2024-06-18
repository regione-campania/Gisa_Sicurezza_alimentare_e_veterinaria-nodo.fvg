

import java.io.IOException;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.SystemStatus;

import com.darkhorseventures.database.ConnectionPool;

/**
 * Servlet implementation class PrintSystemStatus
 */
public class PrintSystemStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrintSystemStatus() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		SystemStatus system = null;
		
		 ConnectionPool ce = (ConnectionPool) request.getSession().getAttribute(
	        "ConnectionPool");
		 
		 
		 if (ce != null) {
			 system = (SystemStatus) ((Hashtable) request.getSession().getAttribute("SystemStatus")).get(ce.getUrl());
		    } else {
		      if (System.getProperty("DEBUG") != null) {
		        System.out.println("CFSModule-> ** System status is null **");
		      }
		    }
		      
		      
		HashMap map =  system.getProperties();
		
		Iterator it= map.keySet().iterator();
		while (it.hasNext())
		{
			System.out.println("System Status -> "+it.next());
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
