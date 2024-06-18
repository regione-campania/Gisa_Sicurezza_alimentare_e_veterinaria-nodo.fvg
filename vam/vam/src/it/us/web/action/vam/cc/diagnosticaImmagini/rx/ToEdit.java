package it.us.web.action.vam.cc.diagnosticaImmagini.rx;

import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.action.vam.cc.diagnosticaImmagini.tac.Detail;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Rx;
import it.us.web.dao.GuiViewDAO;

public class ToEdit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("rx");
	}

	public void execute() throws Exception
	{

			int idRx = interoFromRequest("idRx");
		
			//Recupero Bean Rx
			Rx rx = (Rx) persistence.find(Rx.class, idRx);

			req.setAttribute("rx", rx);	
			
				
			gotoPage("/jsp/vam/cc/diagnosticaImmagini/rx/edit.jsp");
	
	}
}


