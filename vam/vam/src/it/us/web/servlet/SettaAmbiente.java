package it.us.web.servlet;

import java.io.IOException;
import java.util.List;

import it.us.web.dao.hibernate.Persistence;
import it.us.web.dao.hibernate.PersistenceFactory;
import it.us.web.util.properties.Application;

public class SettaAmbiente {

	private String ambiente;
	private String dbMode;
	
	public void SettaAmbiente(){}
	
	public void check() throws IOException{
		
		// CONTROLLA SE IL SISTEMA E' MASTER O SLAVE
		Persistence persistence  = PersistenceFactory.getPersistence();
		List<String> result = persistence.createSQLQuery("show transaction_read_only").list();

		for( String a: result )
		{
			if (a.equals("on")){  //DB READONLY
				setDbMode("slave");
				System.out.println("DB READ ONLY MODE");
			}
			else {				  //DB READ/WRITE
				setDbMode("master");
				System.out.println("DB READ/WRITE MODE");	
			}
		}
		
		//RICARICA IL FILE DI PROPERTIES ADATTO 
		Application.reloadProperties(Application.get("ambiente")); 
		
		setAmbiente(Application.get("ambiente"));
		
		PersistenceFactory.closePersistence( persistence, true );
		System.out.println("Caricato file di properties per : "+Application.get("ambiente"));
	}
	
	public String getAmbiente() {
		return ambiente;
	}
	
	public void setAmbiente(String ambiente) {
		this.ambiente = ambiente;
	}

	public String getDbMode() {
		return dbMode;
	}

	public void setDbMode(String dbMode) {
		this.dbMode = dbMode;
	}
	
}
