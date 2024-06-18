package it.us.web.action.vam.cc.diagnosticaImmagini.ecoAddome;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupEcoAddomeTipo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.ArrayList;


public class ToAdd extends GenericAction 
{

	@Override
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ecoAddome");
	}
	
	@Override
	public void execute() throws Exception
	{
			//Recupero tipi di esami di Eco-Addome
			ArrayList<LookupEcoAddomeTipo> ecoAddomeTipi = (ArrayList<LookupEcoAddomeTipo>) persistence.findAll(LookupEcoAddomeTipo.class);
			
			req.setAttribute( "ecoAddomeTipi", ecoAddomeTipi);
		
			gotoPage( "/jsp/vam/cc/diagnosticaImmagini/ecoAddome/add.jsp" );
	}
}
