package it.us.web.action.vam.cc.diagnosticaImmagini.ecoCuore;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EcoCuore;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.Set;

public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ecoCuore");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{

		//Recupero di tutti gli ecoCuore associati alla CC
		Set<EcoCuore> ecoCuore = cc.getEcoCuores();
		
		req.setAttribute("ecoCuore", ecoCuore);
				
		gotoPage("/jsp/vam/cc/diagnosticaImmagini/ecoCuore/list.jsp");
	}
}



