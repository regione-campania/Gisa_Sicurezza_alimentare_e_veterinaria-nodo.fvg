package it.us.web.servlet;

import it.us.web.bean.vam.lookup.LookupCMI;
import it.us.web.bean.vam.lookup.LookupComuni;

import it.us.web.dao.hibernate.Persistence;
import it.us.web.dao.hibernate.PersistenceFactory;

import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class SettaComuni extends HttpServlet
{
	private static final long serialVersionUID = -8397394451535054535L;

	public void init(ServletConfig config) throws ServletException 
	{
		try
		{
			Persistence persistence = null;
			persistence = PersistenceFactory.getPersistence();
			ServletContext context = config.getServletContext();
			
			ArrayList<LookupComuni> listComuni = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
					.addOrder( Order.asc( "description" ) )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			ArrayList<LookupComuni> listComuniBN = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
					.add( Restrictions.eq( "bn", true ) )
					.addOrder( Order.asc( "description" ) )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			ArrayList<LookupComuni> listComuniNA = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
					.add( Restrictions.eq( "na", true ) )
					.addOrder( Order.asc( "description" ) )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			ArrayList<LookupComuni> listComuniSA = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
					.add( Restrictions.eq( "sa", true ) )
					.addOrder( Order.asc( "description" ) )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			ArrayList<LookupComuni> listComuniAV = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
					.add( Restrictions.eq( "av", true ) )
					.addOrder( Order.asc( "description" ) )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			ArrayList<LookupComuni> listComuniCE = (ArrayList<LookupComuni>) persistence.createCriteria( LookupComuni.class )
					.add( Restrictions.eq( "ce", true ) )
					.addOrder( Order.asc( "description" ) )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			ArrayList<LookupCMI> listCMI = (ArrayList<LookupCMI>) persistence.createCriteria( LookupCMI.class )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			PersistenceFactory.closePersistence( persistence, true );
			
			context.setAttribute("listComuni", listComuni);
			context.setAttribute("listComuniBN", listComuniBN);
			context.setAttribute("listComuniNA", listComuniNA);
			context.setAttribute("listComuniSA", listComuniSA);
			context.setAttribute("listComuniCE", listComuniCE);
			context.setAttribute("listComuniAV", listComuniAV);
			context.setAttribute("listCMI", listCMI);

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}	
}

