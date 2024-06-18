package it.us.web.action.vam.cc.leishmaniosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupEhrlichiosiEsiti;
import it.us.web.bean.vam.lookup.LookupLeishmaniosiEsiti;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class ToAdd extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("leishmaniosi");
	}

	public void execute() throws Exception
	{

			ArrayList<LookupLeishmaniosiEsiti> listEsiti = (ArrayList<LookupLeishmaniosiEsiti>) persistence.findAll(LookupLeishmaniosiEsiti.class);

			req.setAttribute("listEsiti", listEsiti);		
		
			gotoPage("/jsp/vam/cc/leishmaniosi/add.jsp");
	}
}


