package it.us.web.action.vam.cc.anamnesiRemota;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("anamnesi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		String idAnimale = cc.getAccettazione().getAnimale().getIdentificativo();
		ArrayList<CartellaClinica> cartelleCliniche = (ArrayList<CartellaClinica>) persistence.getNamedQuery("GetAnamnesi").setString("idAnimale", idAnimale).list();
		
		req.setAttribute("identificativoAnimale", idAnimale);
		req.setAttribute("cartelleCliniche", cartelleCliniche);
				
		gotoPage("/jsp/vam/cc/anamnesiRemota/list.jsp");
	}
}


