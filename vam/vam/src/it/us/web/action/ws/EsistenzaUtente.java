package it.us.web.action.ws;

import it.us.web.action.GenericAction;
import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.exceptions.AuthorizationException;

import java.io.PrintWriter;
import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;

public class EsistenzaUtente extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		
	}

	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	@Override
	public void execute() throws Exception
	{
		PrintWriter pw = res.getWriter();
		
		String username  = stringaFromRequest("username");
		ArrayList<SuperUtente> sups = (ArrayList<SuperUtente>) persistence.createCriteria( SuperUtente.class )
			.add( Restrictions.eq( "username", username ) )
			.add( Restrictions.isNull( "trashedDate") ).list();
		
		if( !sups.isEmpty() )
		{
			pw.write("OK");
			pw.flush();
		}
		else
		{
			pw.write("KO");
			pw.flush();
		}
		
		
		
//		String username  = stringaFromRequest("username");
//		ArrayList<BUtente> a = (ArrayList<BUtente>)persistence.getNamedQuery("GetUtente").setString("username",username).list();
//		if(!a.isEmpty())
//		{
//
//			pw.write("OK");
//			pw.flush();
//		}
//		else
//		{
//			pw.write("KO");
//			pw.flush();
//		}
	}
	
}
