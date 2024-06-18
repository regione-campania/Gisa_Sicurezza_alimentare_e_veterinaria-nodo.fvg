package it.us.web.action.vam.cc.diagnosticaImmagini.rx;

import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.Rx;
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
		setSegnalibroDocumentazione("rx");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
			
		int id = interoFromRequest("idRx");
		
		//Recupero Bean Rx
		Rx rx = (Rx) persistence.find(Rx.class, id);

		req.setAttribute("rx", rx);	
		
		gotoPage("/jsp/vam/cc/diagnosticaImmagini/rx/detail.jsp");
	}
}

