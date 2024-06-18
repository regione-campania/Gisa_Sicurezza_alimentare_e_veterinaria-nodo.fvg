package it.us.web.action.test.hibernate;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import it.us.web.action.GenericAction;
import it.us.web.bean.test.Password;
import it.us.web.bean.test.Utente;
import it.us.web.dao.GenericDAO;
import it.us.web.exceptions.AuthorizationException;

public class MyTest extends GenericAction {

	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
		SessionFactory sessionFactory = GenericDAO.getSessionFactory();
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		int utente = (Integer)session.save( new Utente() );
		Password p = new Password();
		p.setUtente( (Utente)session.load(Utente.class, utente) );
		session.save( p );
		tx.commit();
		session.close();
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}

}
