package it.us.web.action;

import java.sql.Connection;

import it.us.web.bean.BUtente;
import it.us.web.bean.guc.Utente;
import it.us.web.exceptions.AuthorizationException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action
{	
	public void execute() throws Exception;
	public void can() throws AuthorizationException;
	public void startup( HttpServletRequest req, HttpServletResponse res, ServletContext context );
	public void setConnectionDb( Connection db );
	public void logOperazioniUtente( Utente utente, String operazione, String descrizioneOperazione, String ip ) throws Exception;
	public String getDescrizione();

}
