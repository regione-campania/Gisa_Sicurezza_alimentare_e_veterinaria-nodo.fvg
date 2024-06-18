package it.us.web.action.vam.agenda;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.StrutturaClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToChooseStruttura extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "MAIN", "MAIN" );
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
		
		ArrayList<StrutturaClinica> strutturePrenotabili = (ArrayList<StrutturaClinica>) persistence.getNamedQuery("GetStrutturePrenotabili").setInteger("idUtente", utente.getId()).list();
		
		req.setAttribute("sp", strutturePrenotabili);	
		
		gotoPage("/jsp/vam/agenda/chooseStruttura.jsp");					
		
	}
}
