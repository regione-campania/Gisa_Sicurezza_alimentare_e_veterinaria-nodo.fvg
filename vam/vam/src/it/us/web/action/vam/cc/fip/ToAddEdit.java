package it.us.web.action.vam.cc.fip;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Fip;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class ToAddEdit extends GenericAction
{
	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("fip");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{		
	
			boolean modify = booleanoFromRequest( "modify" );
		
			if( modify )
			{
				Fip fip = (Fip) persistence.find( Fip.class, interoFromRequest("idFip"));
				req.setAttribute( "fip", fip );
				req.setAttribute( "modify", true );
			}
		
			gotoPage("/jsp/vam/cc/fip/addEdit.jsp");	
	}
}
