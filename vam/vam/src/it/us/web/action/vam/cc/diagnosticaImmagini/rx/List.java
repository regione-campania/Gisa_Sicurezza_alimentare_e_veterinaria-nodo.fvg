package it.us.web.action.vam.cc.diagnosticaImmagini.rx;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Rx;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.Set;

public class List extends GenericAction {

	
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

		//Recupero di tutte le rx associati alla CC
		Set<Rx> rx = cc.getRxes();

		req.setAttribute("rx", rx);
				
		gotoPage("/jsp/vam/cc/diagnosticaImmagini/rx/list.jsp");
	}
}



