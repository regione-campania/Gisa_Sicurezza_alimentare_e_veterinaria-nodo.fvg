package it.us.web.action;

import java.sql.Connection;
import java.sql.SQLException;

import it.us.web.bean.BUtente;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.exceptions.AuthorizationException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action
{	
	public void execute() throws Exception;
	public void can() throws AuthorizationException,Exception;
	public void canClinicaCessata() throws AuthorizationException,Exception;
	public void setSegnalibroDocumentazione();
	public void startup( HttpServletRequest req, HttpServletResponse res, ServletContext context );
	public void setPersistence( Persistence persistence );
	public Persistence getPersistence();
	public void setConnectionBdu( Connection connectionBdu );
	public Connection getConnectionBdu();
	public void setConnection( Connection connection );
	public Connection getConnection();
	public void logOperazioniUtente( BUtente utente, String operazione, String descrizioneOperazione, String ip ) throws Exception;
	public String getDescrizione();
}
