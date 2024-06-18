package it.us.web.action.vam.cc.leishmaniosi;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ehrlichiosi;
import it.us.web.bean.vam.Leishmaniosi;
import it.us.web.bean.vam.lookup.LookupLeishmaniosiEsiti;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToEdit extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("leishmaniosi");
	}

	public void execute() throws Exception
	{
	
			int id = interoFromRequest("idLeishmaniosi");		
						
			//Recupero Bean Leishmaniosi
			Leishmaniosi l = (Leishmaniosi) persistence.find(Leishmaniosi.class, id);
			ArrayList<LookupLeishmaniosiEsiti> listEsiti = (ArrayList<LookupLeishmaniosiEsiti>) persistence.findAll(LookupLeishmaniosiEsiti.class);
		
		
			req.setAttribute("l", l);	
			req.setAttribute("listEsiti", listEsiti);	
		
			gotoPage("/jsp/vam/cc/leishmaniosi/edit.jsp");
	}
}


