package it.us.web.action.vam.cc.ehrlichiosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ehrlichiosi;
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
		setSegnalibroDocumentazione("ehrlichiosi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		int id = interoFromRequest("idEhrlichiosi");
		
		//Recupero Bean Ehrlichiosi
		Ehrlichiosi e = (Ehrlichiosi) persistence.find(Ehrlichiosi.class, id);
		
		req.setAttribute("e", e);	
			
		gotoPage("/jsp/vam/cc/ehrlichiosi/detail.jsp");
	}
}

