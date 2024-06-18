package it.us.web.action.ws;

import it.us.web.action.GenericAction;
import it.us.web.bean.BRuolo;
import it.us.web.dao.RuoloDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.report.PdfReport;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Vector;

import javax.servlet.ServletOutputStream;

public class ListRuoli extends GenericAction
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
		try{
		Vector<BRuolo> v = RuoloDAO.getRuoli();
		
		Iterator listaRuoli = v.iterator();
		
		BRuolo ruolo;
		String ruoli = "";
		
		while (listaRuoli.hasNext()) {
			ruolo = (BRuolo) listaRuoli.next();
			ruoli = ruoli + ruolo.getId()+"@@@"+ruolo.getRuolo()+";;;";	
		}
		
		
		PrintWriter pw = res.getWriter();
		pw.write(ruoli);
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