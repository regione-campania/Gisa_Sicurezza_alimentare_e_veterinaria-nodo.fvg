package it.us.web.action.vam.cc.ecg;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.EsameSangue;
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
		setSegnalibroDocumentazione("ecg");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{

		//Recupero di tutti gli ecg associati alla CC
		Set<Ecg> ecg = cc.getEcgs();

		req.setAttribute("ecg", ecg);
				
		gotoPage("/jsp/vam/cc/ecg/list.jsp");
	}
}



