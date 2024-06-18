package it.us.web.action.messaggi;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.sql.Timestamp;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.exceptions.AuthorizationException;

public class Modifica extends GenericAction {

	@Override
	public void can() throws AuthorizationException
	{
		can(GuiViewDAO.getView("AMMINISTRAZIONE", "MAIN", "MAIN"), "w");
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		String messaggio = stringaFromRequest("messaggio");

        String pathFile = context.getRealPath("jsp/messaggi/messaggio.txt");

        File f = new File(pathFile);

        FileOutputStream fos = new FileOutputStream(f);
        PrintStream ps = new PrintStream(fos);
        ps.print("<b>"+messaggio+"</b>");
        ps.flush();
        setMessaggio("Messaggio inserito con successo");

        Timestamp dataUltimaModifica = new Timestamp(System.currentTimeMillis());
        context.setAttribute("MessaggioHome", dataUltimaModifica+"&&<b>"+messaggio+"</b>");
		
		gotoPage("/jsp/messaggi/modifica.jsp");
		
	}
}	
