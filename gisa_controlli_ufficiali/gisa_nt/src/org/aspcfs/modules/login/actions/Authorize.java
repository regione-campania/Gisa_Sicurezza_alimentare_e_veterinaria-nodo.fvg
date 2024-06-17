package org.aspcfs.modules.login.actions;

import interbase.interclient.PreparedStatement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.json.JSONObject;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;

public class Authorize implements Filter {

	boolean authenticationGranted = false;
	private List<String> excludedUrls;
	private static final String HTML_PATTERN = "<script[\\s\\S]*?>[\\s\\S]*?<\\/script>";
	private static final String HTML_PATTERN_UPPER = "<SCRIPT[\\s\\S]*?>[\\s\\S]*?<\\/SCRIPT>";

    private Pattern pattern = Pattern.compile(HTML_PATTERN);
    private Pattern patternUpper = Pattern.compile(HTML_PATTERN_UPPER);
	
	public void init(FilterConfig filterConfiguration) throws ServletException 
	{
		
		String excludePattern = filterConfiguration.getInitParameter("excludedUrls");
	    excludedUrls = Arrays.asList(excludePattern.split(","));
	    
		if (filterConfiguration.getInitParameter("grantedAccess").toLowerCase().equals("true"))
			authenticationGranted = true;
		
		//System.out.println("Authorize filter started having grant '" + (authenticationGranted ? "always" : "never" + "'."));
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain servletFilterChain) throws IOException, ServletException 
	{
		/*System.out.println("Entrato.");
		System.out.println("Performing authorization...");*/
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpSession session = request.getSession();
		
	    String path = ((HttpServletRequest) request).getServletPath();
	    
	    Iterator<String> keyParameter = null;
	    if(request.getParameterMap()!=null)
	    	keyParameter = request.getParameterMap().keySet().iterator();
	    if(keyParameter!=null)
	    {
	    	while(keyParameter.hasNext())
	    	{
	    		String parameterTemp = keyParameter.next();
	    		String value = request.getParameter(parameterTemp);
	    		value = value.replaceAll("\"", "\\\"");
	    		if (hasHTMLTags(value)){
	    			response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE);
	    			break;
	    		}
	    	}
	    }
	    
	    //System.out.println("Path eseguito: " + path);
	    String accesso_esterno_attivo = ApplicationProperties.getProperty("accesso_esterno_attivo");
		if (authenticationGranted || excludedUrls.contains(path) || accesso_esterno_attivo.equals("false")) 
		{ 
			//System.out.println("Authorization granted.");
			servletFilterChain.doFilter(servletRequest, servletResponse);
		} 
		else 
		{
		  UserBean u = (UserBean)session.getAttribute("User");
		  if(u==null)
		  {
			 /* System.out.println("Entrato nell'autorizzazione non concessa");
			  System.out.println("Authorization denied!");*/
			  
			 log(request, path);  
			  
			 response.sendRedirect("/login");		 
		}
		  else
		  {
			  /*System.out.println("Entrato nell'autorizzazione concessa");
			  System.out.println("Authorization granted.");*/
			  servletFilterChain.doFilter(servletRequest, servletResponse);
		  }
		}
	}
	

	public boolean hasHTMLTags(String text){
        Matcher matcher = pattern.matcher(text);
        boolean controllo = matcher.find();
        if(controllo == false){
        	Matcher matcherUpper = patternUpper.matcher(text);
        	return matcherUpper.find();
        }
        return controllo;
    }


	public void destroy() 
	{
		//System.out.println("Authorize filter destroyed.");
	}

	
	private void log(HttpServletRequest request, String path) {
		 ConnectionElement ce = null;
			ConnectionPool cp = null;
			Connection db = null;

			ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
			String ceHost = prefs.get("GATEKEEPER.URL");
			String ceUser = prefs.get("GATEKEEPER.USER");
			String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

			ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
			cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");
			
			try {
				db = apriConnessione(request, cp, db, ce);
				java.sql.PreparedStatement pst = db.prepareStatement("insert into log_autorizzazioni_negate(path, ip) values (?, ?)");
				pst.setString(1, path);
				pst.setString(2, request.getLocalAddr());
				pst.execute();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				chiudiConnessione(cp, db);
			}
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