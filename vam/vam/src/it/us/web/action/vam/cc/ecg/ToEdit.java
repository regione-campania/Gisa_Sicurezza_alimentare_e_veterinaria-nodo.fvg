package it.us.web.action.vam.cc.ecg;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.lookup.LookupAritmie;
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
		setSegnalibroDocumentazione("ecg");
	}

	public void execute() throws Exception
	{
			int id = interoFromRequest("idEcg");
		
			//Recupero Bean ECG
			Ecg ecg = (Ecg) persistence.find(Ecg.class, id);
		
			//Recupero lista aritmie
			ArrayList<LookupAritmie> aritmie = (ArrayList<LookupAritmie>) persistence.findAll(LookupAritmie.class);
		
			req.setAttribute("aritmie", aritmie);
			req.setAttribute("ecg", ecg);		
			
				
			gotoPage("/jsp/vam/cc/ecg/edit.jsp");
	}
}


