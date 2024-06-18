package it.us.web.action.vam.cc.diagnosticaImmagini.tac;

import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.Tac;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class Detail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("tac");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
			
		int id = interoFromRequest("idTac");
		
		//Recupero Bean Tac
		Tac tac = (Tac) persistence.find(Tac.class, id);

		req.setAttribute("tac", tac);	
		
		gotoPage("/jsp/vam/cc/diagnosticaImmagini/tac/detail.jsp");
	}
}

