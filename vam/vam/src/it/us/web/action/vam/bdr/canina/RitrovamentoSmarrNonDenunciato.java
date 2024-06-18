package it.us.web.action.vam.bdr.canina;

import it.us.web.action.GenericAction;
import it.us.web.action.vam.bdr.felina.Decesso;
import it.us.web.bean.BGuiView;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.AttivitaBdr;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.CaninaRemoteUtil;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RitrovamentoSmarrNonDenunciato extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "ADD", "MAIN" );
		can( gui, "w" );
	}

	@Override
	public void execute() throws Exception
	{
		final Logger logger = LoggerFactory.getLogger(RitrovamentoSmarrNonDenunciato.class);
		
		logger.info("Esecuzione ritrovamento(smarrimento non denunciato) cane in Vam");
		
		Accettazione				accettazione	= (Accettazione) persistence.find( Accettazione.class, interoFromRequest( "idAccettazione" ) );
		
		LookupOperazioniAccettazione ritr = (LookupOperazioniAccettazione) persistence.find( LookupOperazioniAccettazione.class, IdOperazioniBdr.ritrovamentoSmarrNonDenunciato );
		
		AttivitaBdr abdr = new AttivitaBdr();
		abdr.setAccettazione		( accettazione );
		abdr.setEntered				( new Date() );
		abdr.setEnteredBy			( utente.getId() );
		abdr.setModified			( abdr.getEntered() );
		abdr.setModifiedBy			( utente.getId() );
		abdr.setOperazioneBdr		( ritr );
		
		persistence.insert( abdr );
		
		String provincia = stringaFromRequest("provincia");
		String comune = "0"; 
		if (provincia.equals("BN"))		
			comune = stringaFromRequest("comuneBN");
		else if (provincia.equals("NA"))	
			comune = stringaFromRequest("comuneNA");
		else if (provincia.equals("SA"))	
			comune = stringaFromRequest("comuneSA");
		else if (provincia.equals("CE"))	
			comune = stringaFromRequest("comuneCE");
		else if (provincia.equals("AV"))	
			comune = stringaFromRequest("comuneAV");
		
		CaninaRemoteUtil.eseguiRitrovamentoSmarrNonDenunciato(
				accettazione.getAnimale(), 
				stringaFromRequest( "dataRitrovamento" ), 
				stringaFromRequest( "luogoRitrovamento" ), 
				comune,
				"##### RITROVAMENTO CON SMARRIMENTO NON DENUNCIATO: " + stringaFromRequest( "noteRitrovamento" ) + " #####", 
				utente,req);
		
		persistence.commit();
			
		setMessaggio( "Registrazione di ritrovamento(smarrimento non denunciato) inserita con successo" );
		redirectTo( "vam.accettazione.TestRegistrazioni.us?idAccettazione=" + accettazione.getId() );
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}
	
}
