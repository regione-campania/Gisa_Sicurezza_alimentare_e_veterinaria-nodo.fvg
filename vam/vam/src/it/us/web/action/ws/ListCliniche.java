package it.us.web.action.ws;

import it.us.web.action.GenericAction;
import it.us.web.bean.vam.Clinica;
import it.us.web.exceptions.AuthorizationException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;


public class ListCliniche extends GenericAction
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
		try
		{
			//Recupero di tutte le cliniche
			ArrayList<Clinica> clinicheA = (ArrayList<Clinica>) persistence.findAll(Clinica.class);

			Iterator listaCliniche = clinicheA.iterator();

			String cliniche = "";
			Clinica c;

			while (listaCliniche.hasNext()) {
				c = (Clinica) listaCliniche.next();
				cliniche = cliniche + c.getLookupAsl().getId()+"@@@" + c.getId()+"@@@"+c.getNome()+";;;";	
			}


			PrintWriter pw = res.getWriter();
			pw.write(cliniche);
			pw.flush();
		}
		catch(Exception e)
		{
			PrintWriter pw = res.getWriter();
			pw.write("KO");
			pw.flush();
		}
	}
}