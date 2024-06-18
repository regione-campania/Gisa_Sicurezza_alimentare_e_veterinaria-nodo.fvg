package it.us.web.action.vam.cc.diagnosticaImmagini.ecoAddome;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EcoAddome;
import it.us.web.bean.vam.EcoAddomeEsito;
import it.us.web.bean.vam.lookup.LookupEcoAddomeTipo;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;


public class ToEdit extends GenericAction 
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
			int idEcoAddome = interoFromRequest("idEcoAddome");
		
			//Recupero Bean EcoAddome
			EcoAddome ecoAddome = (EcoAddome) persistence.find(EcoAddome.class, idEcoAddome);
		
			//Recupero Lista Esiti EcoAddome
			ArrayList<EcoAddomeEsito> ecoAddomeEsitos = (ArrayList<EcoAddomeEsito>) persistence.createCriteria( EcoAddomeEsito.class ).add( Restrictions.eq( "ecoAddome.id", idEcoAddome ) ).list();

			//Recupero tipi di esami di Eco-Addome
			ArrayList<LookupEcoAddomeTipo> ecoAddomeTipi = (ArrayList<LookupEcoAddomeTipo>) persistence.findAll(LookupEcoAddomeTipo.class);

		
			req.setAttribute( "ecoAddomeTipi", ecoAddomeTipi);
			req.setAttribute( "ecoAddome", ecoAddome);
			req.setAttribute( "ecoAddomeEsitos", ecoAddomeEsitos);
		
			gotoPage( "/jsp/vam/cc/diagnosticaImmagini/ecoAddome/edit.jsp" );
	}

}
