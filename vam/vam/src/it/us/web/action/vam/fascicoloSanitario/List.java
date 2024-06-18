package it.us.web.action.vam.fascicoloSanitario;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.FascicoloSanitario;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class List extends GenericAction
{
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "FASCICOLO_SANITARIO", "LIST", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("fascicoloSanitario");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{		
		ArrayList<FascicoloSanitario> fascicoliSanitari = (ArrayList<FascicoloSanitario>) persistence.getNamedQuery("GetFascicoloSanitarioByClinica").setInteger("idClinica", utente.getClinica().getId()).list();
		
		req.setAttribute( "fascicoliSanitari", fascicoliSanitari );
		
		gotoPage("/jsp/vam/fascicoloSanitario/list.jsp");
	}
}
