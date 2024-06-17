package it.us.web.action.login;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import it.us.web.action.GenericAction;
import it.us.web.action.IndexSca;
import it.us.web.bean.UserOperation;
import it.us.web.exceptions.AuthorizationException;

public class LogoutSca extends GenericAction
{
	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
		if( utenteGuc != null )
		{
			String system = (String) session.getAttribute("system");
			
			try {
				
				 UserOperation uo = new UserOperation();
				 String ip=(String)req.getRemoteAddr();
				 uo.setUsername(utenteGuc.getUsername());
				 uo.setUser_id(utenteGuc.getId());
				 uo.setIp(ip);
				 uo.setData(new Timestamp(new Date().getTime()));
				 uo.setUrl(req.getRequestURL().toString()+(req.getQueryString()!=null ? "?"+req.getQueryString() : ""));
				 uo.setParameter("");
				 uo.setUserBrowser(req.getHeader("user-agent"));
				 uo.setAction("login.Logout");
				 
				if (session.getAttribute("operazioni")!=null){
					 ArrayList<UserOperation> op = (ArrayList<UserOperation>) session.getAttribute("operazioni");
					 op.add(uo);
					 session.removeAttribute("operazioni");
					 session.removeAttribute("ip");
					 session.removeAttribute("idUser");
					 session.setAttribute("operazioni",op);
				} else {
					 ArrayList<UserOperation> op = new ArrayList<UserOperation>();
					 op.add(uo);
					 session.removeAttribute("operazioni");
					 session.removeAttribute("ip");
					 session.removeAttribute("idUser");
					 session.setAttribute("operazioni",op);
				}
				//session.invalidate();
			}
			catch (Exception e) {
				e.printStackTrace();
			}	
			
			((HashMap<String, HttpSession>) session.getServletContext().getAttribute("utenti")).remove(utenteGuc.getUsername(), session);
			session.setAttribute( "utenteGuc", null );
			session.invalidate();			
			utenteGuc = null;
			
			goToAction( new IndexSca() );
			
			
		}
		else {
			
			session.invalidate();			
			goToAction( new IndexSca() );
			
			
		}
		
		
	}
}
