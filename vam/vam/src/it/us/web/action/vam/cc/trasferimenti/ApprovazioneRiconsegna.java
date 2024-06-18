package it.us.web.action.vam.cc.trasferimenti;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.BUtenteAll;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.Date;
import java.util.Iterator;

import javax.naming.Context;
import javax.naming.InitialContext;

public class ApprovazioneRiconsegna extends GenericAction {

	
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
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		
		Trasferimento trasferimento = (Trasferimento) persistence.find( Trasferimento.class, interoFromRequest( "idTrasferimento" ) );
		
		trasferimento.setDataApprovazioneRiconsegna( dataFromRequest( "dataApprovazioneRiconsegna" ) );
		trasferimento.setNotaRiconsegna( stringaFromRequest( "notaApprovazioneRiconsegna" ) );
		
		trasferimento.setModified( new Date() );
		trasferimento.setModifiedBy( utente );
		
		Iterator<LookupOperazioniAccettazione> iter = trasferimento.getOperazioniRichieste().iterator();
		while(iter.hasNext())
		{
			LookupOperazioniAccettazione op = iter.next();
			op.getOperazioniCondizionate();
			op.getOperazioniCondizionanti();
		}
		
		
		// Apertura nuova cc mittente
		BUtenteAll ut = UtenteDAO.getUtenteAll(trasferimento.getCartellaClinica().getAccettazione().getEnteredBy().getId());
		Accettazione accettazioneNuovaMittente = Riconsegna.nuovaACCmittente(trasferimento, persistence, connection, ut);
		persistence.insert(accettazioneNuovaMittente);
		
		// 2.Creazione nuova cc per il mittente
		CartellaClinica ccNuovaMittente = Riconsegna.nuovaCCmittente(trasferimento, accettazioneNuovaMittente, persistence,connection);
		persistence.insert(ccNuovaMittente);
		
		persistence.update( trasferimento );			
		persistence.commit();
		
		setMessaggio( "Richiesta di rientro approvata con successo" );
		redirectTo( "vam.cc.trasferimenti.Home.us" );
	}
}
