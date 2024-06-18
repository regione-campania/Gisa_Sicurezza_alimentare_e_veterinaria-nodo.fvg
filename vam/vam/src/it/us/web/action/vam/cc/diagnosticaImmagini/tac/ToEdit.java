package it.us.web.action.vam.cc.diagnosticaImmagini.tac;

import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.Tac;
import it.us.web.bean.vam.lookup.LookupAritmie;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoTipo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToEdit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("tac");
	}

	public void execute() throws Exception
	{

			int idTac = interoFromRequest("idTac");
			
			//Recupero Bean Tac
			Tac tac = (Tac) persistence.find(Tac.class, idTac);

			req.setAttribute("tac", tac);	
				
					
			gotoPage("/jsp/vam/cc/diagnosticaImmagini/tac/edit.jsp");
	}
}


