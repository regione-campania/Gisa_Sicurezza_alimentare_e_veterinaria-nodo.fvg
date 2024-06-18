package it.us.web.action.vam.cc.rickettsiosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupLeishmaniosiEsiti;
import it.us.web.bean.vam.lookup.LookupRickettsiosiEsiti;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class ToAdd extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("rickettsiosi");
	}

	public void execute() throws Exception
	{		

			ArrayList<LookupRickettsiosiEsiti> listEsiti = (ArrayList<LookupRickettsiosiEsiti>) persistence.findAll(LookupRickettsiosiEsiti.class);
		
			req.setAttribute("listEsiti", listEsiti);		
		
			gotoPage("/jsp/vam/cc/rickettsiosi/add.jsp");
		}	
}

