package it.us.web.action.vam.cc.diagnosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Diagnosi;
import it.us.web.bean.vam.EsameSangue;
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
		setSegnalibroDocumentazione("diagnosi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		
		//Recupero di tutte le diagnosi associate alla CC
		ArrayList<Diagnosi> diagnosi = (ArrayList<Diagnosi>) persistence.getNamedQuery("GetDiagnosiByCC").setInteger("idCartellaClinica", idCc).list();

		req.setAttribute("diagnosi", diagnosi);		
	
		gotoPage("/jsp/vam/cc/diagnosi/list.jsp");
	}
}



