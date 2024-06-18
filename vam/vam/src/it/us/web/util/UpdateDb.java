package it.us.web.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Environment;

public class UpdateDb {

	public static void main(String[] args) 
	{
		SessionFactory sessionFactory;
		
		//Apertura
		AnnotationConfiguration	annotationConfiguration	= new AnnotationConfiguration().configure().setProperty(Environment.HBM2DDL_AUTO, "update");
    	sessionFactory			= annotationConfiguration.buildSessionFactory();
    	sessionFactory.openSession();
		
		//Chiusura
    	sessionFactory.close();
    	sessionFactory = null;
		
	}
	
}
