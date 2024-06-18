package it.us.web.action.ws;

import it.us.web.action.GenericAction;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.FascicoloSanitario;
import it.us.web.exceptions.AuthorizationException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.criterion.Restrictions;

public class AnimaleRicoverato extends GenericAction
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
		
		//Si controlla se esiste un fascicolo sanitario aperto prima e chiuso dopo una certa data
		PrintWriter pw = res.getWriter();
		
		String mc  = stringaFromRequest("mc");
		Date data  = dataFromRequest("data");
		ArrayList<CartellaClinica> cc = (ArrayList<CartellaClinica>)persistence.getNamedQuery("AnimaleRicoverato").setString( "mc", mc ).setDate( "data", data ).list();
		
		if( !cc.isEmpty() )
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
