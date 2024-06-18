package it.us.web.action.test.hibernate;

import it.us.web.action.GenericAction;
import it.us.web.bean.test.Utente;
import it.us.web.exceptions.AuthorizationException;

public class Lazy extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
//		Utente test = new Utente();
//		
//		test.setUsername( "paperino" );
//		
//		Password pwd = new Password();
//		pwd.setUsername( "aaaaa" );
//		HashSet<Password> pwds = new HashSet<Password>();
//		pwds.add( pwd );
//		pwds.add( new Password() );
//		
//		persistence.insert( test );
//		
//		for( Password pass: pwds )
//		{
//			pass.setUtente( test );
//			persistence.insert( pass );
//		}
//		
//		persistence.commit();
		
		Utente utente = (Utente) persistence.getNamedQuery("testUtente").list().get( 0 );//find( Utente.class, 1 );
		persistence.commit();
//		GenericHibernateDAO gh = new GenericHibernateDAO();
//		gh.startTransaction();
//		Utente utente = (Utente)gh.find( Utente.class, 1801l );
//		gh.commitTransaction();
//		
		req.setAttribute( "utentex", utente );
		gotoPage( "/jsp/test/lazy.jsp" );
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}

}
