package it.us.web.action.vam.cc.ehrlichiosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAritmie;
import it.us.web.bean.vam.lookup.LookupEhrlichiosiEsiti;
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
		setSegnalibroDocumentazione("ehrlichiosi");
	}

	public void execute() throws Exception
	{

			ArrayList<LookupEhrlichiosiEsiti> listEsiti = (ArrayList<LookupEhrlichiosiEsiti>) persistence.findAll(LookupEhrlichiosiEsiti.class);
		
			req.setAttribute("listEsiti", listEsiti);		
		
			gotoPage("/jsp/vam/cc/ehrlichiosi/add.jsp");
	}
}


