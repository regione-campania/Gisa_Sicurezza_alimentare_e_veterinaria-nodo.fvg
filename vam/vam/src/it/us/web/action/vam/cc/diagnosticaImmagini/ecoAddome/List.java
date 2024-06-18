package it.us.web.action.vam.cc.diagnosticaImmagini.ecoAddome;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EcoAddome;
import it.us.web.bean.vam.EcoCuore;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.Set;

public class List extends GenericAction 
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ecoAddome");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void execute() throws Exception
	{
		
		//Recupero di tutti gli ecoAddome associati alla CC
		Set<EcoAddome> ecoAddomi = cc.getEcoAddomes();

		req.setAttribute("ecoAddomi", ecoAddomi);
		
		gotoPage( "/jsp/vam/cc/diagnosticaImmagini/ecoAddome/list.jsp" );
	}

}

