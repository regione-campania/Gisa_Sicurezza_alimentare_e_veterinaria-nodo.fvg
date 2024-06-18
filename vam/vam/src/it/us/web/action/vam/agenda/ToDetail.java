package it.us.web.action.vam.agenda;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.StrutturaClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToDetail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("agenda");
	}

	public void execute() throws Exception
	{			
				
		int idStrutturaClinica = interoFromRequest("idStrutturaClinica");
		
		if (idStrutturaClinica == -1)
			idStrutturaClinica = Integer.parseInt(session.getAttribute("idStrutturaClinica").toString());
		
		StrutturaClinica sc = (StrutturaClinica) persistence.find(StrutturaClinica.class, idStrutturaClinica);
			
		
		session.setAttribute("idStrutturaClinica", idStrutturaClinica);
		req.setAttribute("sc", sc);
		
		
		gotoPage("/jsp/vam/agenda/detail.jsp");					
		
	}
}
