package it.us.web.action.vam.cc.diagnosticaImmagini.ecoCuore;

import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.EcoCuore;
import it.us.web.bean.vam.EcoCuoreEsito;
import it.us.web.bean.vam.lookup.LookupAritmie;
import it.us.web.bean.vam.lookup.LookupEcoCuoreAnomalia;
import it.us.web.bean.vam.lookup.LookupEcoCuoreDiagnosi;
import it.us.web.bean.vam.lookup.LookupEcoCuoreTipo;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoTipo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToEdit extends GenericAction {

	
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

			int idEcoCuore = interoFromRequest("idEcoCuore");
			
			//Recupero Bean EcoCuore
			EcoCuore ecoCuore = (EcoCuore) persistence.find(EcoCuore.class, idEcoCuore);
			
			//Recupero Lista Esiti EcoCuore
			ArrayList<EcoCuoreEsito> ecoCuoreEsitos = (ArrayList<EcoCuoreEsito>) persistence.createCriteria( EcoCuoreEsito.class ).add( Restrictions.eq( "ecoCuore.id", idEcoCuore ) ).list();
	
			//Recupero lista tipi esami B-Mode ed M-Mode per l'eco-cuore
			ArrayList<LookupEcoCuoreTipo> tipi = (ArrayList<LookupEcoCuoreTipo>)persistence.findAll(LookupEcoCuoreTipo.class);
			
			//Recupero lista diagnosi
			ArrayList<LookupEcoCuoreDiagnosi> diagnosi = (ArrayList<LookupEcoCuoreDiagnosi>)persistence.findAll(LookupEcoCuoreDiagnosi.class);
					
			//Recupero lista anomalie
			ArrayList<LookupEcoCuoreAnomalia> anomalie = (ArrayList<LookupEcoCuoreAnomalia>)persistence.findAll(LookupEcoCuoreAnomalia.class);

			req.setAttribute("diagnosi", diagnosi);	
			req.setAttribute("ecoCuore", ecoCuore);
			req.setAttribute("ecoCuoreEsitos", ecoCuoreEsitos);	
			req.setAttribute("tipi", tipi);	
			req.setAttribute("anomalie", anomalie);	
					
			gotoPage("/jsp/vam/cc/diagnosticaImmagini/ecoCuore/edit.jsp");

	}
}


