package it.us.web.dao.hibernate;

import java.util.Properties;

import org.hibernate.Session;

public class PersistenceFactory extends Persistence
{

	protected PersistenceFactory(Session session)
	{
		super(session);
	}
	
	public static Persistence getPersistence()
	{
		return new Persistence( HibernateFactory.openSession() );
	}
	
	public static void closePersistence( Persistence persistence, boolean commit )
	{
		if( persistence != null )
		{
			persistence.destroy( commit );
		}
	}
	
	public static Persistence getPersistenceCanina()
	{
		return new Persistence( HibernateFactory.openSessionCanina() );
	}
	
	public static Persistence getPersistenceFelina()
	{
		return new Persistence( HibernateFactory.openSessionFelina() );
	}
	
	public static Persistence getPersistenceDocumentale()
	{
		return new Persistence( HibernateFactory.openSessionDocumentale() );
	}
}
