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
import it.us.web.util.vam.RegistrazioniUtil;

import java.sql.Connection;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Passaporto extends GenericAction
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
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		
		Context ctxVam = new InitialContext();
		javax.sql.DataSource dsVam = (javax.sql.DataSource)ctxVam.lookup("java:comp/env/jdbc/vamM");
		Connection connectionVam = dsVam.getConnection();
		aggiornaConnessioneApertaSessione(req);
		setConnection(connectionVam);
		
		final Logger logger = LoggerFactory.getLogger(Passaporto.class);
		
		logger.info("Esecuzione rilascio passaporto cane in Vam");
		
		Accettazione				accettazione	= (Accettazione) persistence.find( Accettazione.class, interoFromRequest( "idAccettazione" ) );
		
		LookupOperazioniAccettazione passaporto = (LookupOperazioniAccettazione) persistence.find( LookupOperazioniAccettazione.class, IdOperazioniBdr.passaporto );
		
		AttivitaBdr abdr = new AttivitaBdr();
		abdr.setAccettazione		( accettazione );
		abdr.setEntered				( new Date() );
		abdr.setEnteredBy			( utente.getId() );
		abdr.setModified			( abdr.getEntered() );
		abdr.setModifiedBy			( utente.getId() );
		abdr.setOperazioneBdr		( passaporto );
		
		persistence.insert( abdr );
		
		CaninaRemoteUtil.eseguiRilascioPassaporto(
				accettazione.getAnimale(), 
				stringaFromRequest( "dataPassaporto" ), 
				stringaFromRequest( "numeroPassaporto" ), 
				stringaFromRequest( "notePassaporto" ), 
				utente,req);
		
		int idTipoRegBdr = RegistrazioniUtil.getIdTipoBdr(accettazione.getAnimale(), accettazione, passaporto, connectionVam, utente, connection,req);
		abdr.setIdRegistrazioneBdr(CaninaRemoteUtil.getUltimaRegistrazione(accettazione.getAnimale().getIdentificativo(), idTipoRegBdr, connection,req));
		
		
		persistence.commit();
			
		setMessaggio( "Registrazione rilascio passaporto inserita con successo in BDR" );
		redirectTo( "vam.accettazione.TestRegistrazioni.us?idAccettazione=" + accettazione.getId() );
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}
	
}
