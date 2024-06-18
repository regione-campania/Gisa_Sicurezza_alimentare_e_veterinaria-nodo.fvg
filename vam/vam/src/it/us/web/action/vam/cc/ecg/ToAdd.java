package it.us.web.action.vam.cc.ecg;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAritmie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToAdd extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ecg");
	}

	public void execute() throws Exception
	{
	
			//Recupero lista aritmie
			ArrayList<LookupAritmie> aritmie = (ArrayList<LookupAritmie>) persistence.findAll(LookupAritmie.class);
		
			req.setAttribute("aritmie", aritmie);		
		
			gotoPage("/jsp/vam/cc/ecg/add.jsp");
	}
}

