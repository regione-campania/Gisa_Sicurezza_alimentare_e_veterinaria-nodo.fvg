package it.us.web.action.vam.cc.covid;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Covid;
import it.us.web.bean.vam.Fip;
import it.us.web.bean.vam.lookup.LookupCovidTipoTest;
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
				Covid covid = (Covid) persistence.find( Covid.class, interoFromRequest("idCovid"));
				req.setAttribute( "covid", covid );
				req.setAttribute( "modify", true );
			}
			
			ArrayList<LookupCovidTipoTest> listCovidTipoTest = (ArrayList<LookupCovidTipoTest>) persistence.createCriteria( LookupCovidTipoTest.class ).list();
			req.setAttribute("listCovidTipoTest", listCovidTipoTest);
		
			gotoPage("/jsp/vam/cc/covid/addEdit.jsp");	
	}
}
