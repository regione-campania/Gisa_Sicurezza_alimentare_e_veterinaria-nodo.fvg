package it.us.web.action.vam.cc.trasferimenti;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Clinica;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.Date;
import java.util.Iterator;

public class ApprovazioneCriuv extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "TRASFERIMENTI", "CRIUV", "MAIN" );
		can( gui, "w" );
	}

	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("trasferimenti");
	}

	public void execute() throws Exception
	{
		Trasferimento trasferimento = (Trasferimento) persistence.find( Trasferimento.class, interoFromRequest( "idTrasferimento" ) );

		trasferimento.setDataAccettazioneCriuv( dataFromRequest( "dataApprovazioneCriuv" ) );
		trasferimento.setNotaCriuv( stringaFromRequest( "notaCriuv" ) );

		Clinica cd = (Clinica) persistence.find( Clinica.class, interoFromRequest( "clinicaDestinazioneId" ) );
		trasferimento.setClinicaDestinazione( cd );

		trasferimento.setModified( new Date() );
		trasferimento.setModifiedBy( utente );
		
		
		Iterator<LookupOperazioniAccettazione> iter = trasferimento.getOperazioniRichieste().iterator();
		while(iter.hasNext())
		{
			LookupOperazioniAccettazione op = iter.next();
			op.getOperazioniCondizionate();
			op.getOperazioniCondizionanti();
		}

		persistence.update( trasferimento );
		persistence.commit();

		setMessaggio( "Richiesta di trasferimento approvata con successo" );
		redirectTo( "vam.cc.trasferimenti.Home.us" );
	}
}