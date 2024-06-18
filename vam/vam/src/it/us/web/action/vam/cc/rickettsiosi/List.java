package it.us.web.action.vam.cc.rickettsiosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ehrlichiosi;
import it.us.web.bean.vam.Rickettsiosi;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "LIST", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("rickettsiosi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		//Recupero di tutti le Rickettsiosi associate alla CC
		ArrayList<Rickettsiosi> r = (ArrayList<Rickettsiosi>) persistence.getNamedQuery("GetRickettsiosiByCC").setInteger("idCartellaClinica", idCc).list();
		
		req.setAttribute("r", r);
				
		gotoPage("/jsp/vam/cc/rickettsiosi/list.jsp");
	}
}



