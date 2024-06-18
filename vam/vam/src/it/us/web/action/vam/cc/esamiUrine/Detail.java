package it.us.web.action.vam.cc.esamiUrine;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameUrine;
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
		setSegnalibroDocumentazione("urine");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		int id = interoFromRequest( "id" );
		
		//Recupero Bean EsameSangue
		EsameUrine eu = (EsameUrine) persistence.find(EsameUrine.class, id);
	
		//Recupero Bean CartellaClinica
		CartellaClinica cc = (CartellaClinica) eu.getCartellaClinica();

		
		req.setAttribute( "eu", eu );		
			
		gotoPage("/jsp/vam/cc/esamiUrine/detail.jsp");
	}
}
