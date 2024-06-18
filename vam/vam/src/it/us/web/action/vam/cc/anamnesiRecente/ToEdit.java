package it.us.web.action.vam.cc.anamnesiRecente;

import it.us.web.action.GenericAction;
import it.us.web.action.sinantropi.catture.Detail;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToEdit extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("anamnesi");
	}

	public void execute() throws Exception
	{
			gotoPage("/jsp/vam/cc/anamnesiRecente/edit.jsp");
	}
}

