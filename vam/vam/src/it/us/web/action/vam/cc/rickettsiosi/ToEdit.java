package it.us.web.action.vam.cc.rickettsiosi;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Leishmaniosi;
import it.us.web.bean.vam.Rickettsiosi;
import it.us.web.bean.vam.lookup.LookupRickettsiosiEsiti;
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
		setSegnalibroDocumentazione("rickettsiosi");
	}

	public void execute() throws Exception
	{

			int id = interoFromRequest("idRickettsiosi");		
							
			//Recupero Bean Rickettsiosi
			Rickettsiosi r = (Rickettsiosi) persistence.find(Rickettsiosi.class, id);
			ArrayList<LookupRickettsiosiEsiti> listEsiti = (ArrayList<LookupRickettsiosiEsiti>) persistence.findAll(LookupRickettsiosiEsiti.class);
	
			req.setAttribute("r", r);	
			req.setAttribute("listEsiti", listEsiti);	
			
			gotoPage("/jsp/vam/cc/rickettsiosi/edit.jsp");
	}
	
}


