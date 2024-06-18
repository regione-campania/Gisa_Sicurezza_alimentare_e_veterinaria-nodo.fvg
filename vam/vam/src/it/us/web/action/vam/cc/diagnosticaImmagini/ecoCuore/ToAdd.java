package it.us.web.action.vam.cc.diagnosticaImmagini.ecoCuore;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupEcoCuoreDiagnosi;
import it.us.web.bean.vam.lookup.LookupEcoCuoreAnomalia;
import it.us.web.bean.vam.lookup.LookupEcoCuoreTipo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToAdd extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ecoCuore");
	}

	public void execute() throws Exception
	{

			//Recupero lista diagnosi
			ArrayList<LookupEcoCuoreDiagnosi> diagnosi = (ArrayList<LookupEcoCuoreDiagnosi>)persistence.findAll(LookupEcoCuoreDiagnosi.class);
		
			//Recupero lista tipi esami B-Mode ed M-Mode per l'eco-cuore
			ArrayList<LookupEcoCuoreTipo> tipi = (ArrayList<LookupEcoCuoreTipo>)persistence.findAll(LookupEcoCuoreTipo.class);
		
			//Recupero lista anomalie
			ArrayList<LookupEcoCuoreAnomalia> anomalie = (ArrayList<LookupEcoCuoreAnomalia>)persistence.findAll(LookupEcoCuoreAnomalia.class);

			req.setAttribute("diagnosi", diagnosi);	
			req.setAttribute("tipi",     tipi);	
			req.setAttribute("anomalie",     anomalie);
		
			gotoPage("/jsp/vam/cc/diagnosticaImmagini/ecoCuore/add.jsp");
	}
}

