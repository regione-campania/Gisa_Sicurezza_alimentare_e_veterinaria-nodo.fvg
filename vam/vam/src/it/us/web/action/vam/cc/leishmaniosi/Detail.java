package it.us.web.action.vam.cc.leishmaniosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Leishmaniosi;
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
		setSegnalibroDocumentazione("leishmaniosi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		int id = interoFromRequest("idLeishmaniosi");
		
		//Recupero Bean Leishmaniosi
		Leishmaniosi l = (Leishmaniosi) persistence.find(Leishmaniosi.class, id);
		
		//Recupero Bean CartellaClinica
		CartellaClinica cc = (CartellaClinica) l.getCartellaClinica();

		
		req.setAttribute("l", l);	
			
		gotoPage("/jsp/vam/cc/leishmaniosi/detail.jsp");
	}
}

