package it.us.web.action.vam.cc.esamiSangue;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameSangue;
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
		setSegnalibroDocumentazione("sangue");
	}

	public void execute() throws Exception
	{

			int id = interoFromRequest("idEsameSangue");
		
			//Recupero Bean EsameSangue
			EsameSangue es = (EsameSangue) persistence.find(EsameSangue.class, id);

			req.setAttribute("es", es);		
				
			gotoPage("/jsp/vam/cc/esamiSangue/edit.jsp");
	}
}


