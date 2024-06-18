package it.us.web.action.vam.bdr.felina;

import java.sql.Connection;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.AnimaleAnagrafica;
import it.us.web.bean.vam.AttivitaBdr;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdOperazioniInBdr;
import it.us.web.constants.IdTipiTrasferimentoAccettazione;
import it.us.web.constants.Specie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.RegistrazioniUtil;

public class RegistrazioniInterattiveInserite extends GenericAction
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
		Context ctxBdu = new InitialContext();
		javax.sql.DataSource dsBdu = (javax.sql.DataSource)ctxBdu.lookup("java:comp/env/jdbc/bduS");
		connectionBdu = dsBdu.getConnection();
		

		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		connection = ds.getConnection();
		
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		int idAcc = interoFromRequest( "idAccettazione" );
		Accettazione accettazione = (Accettazione) persistence.find( Accettazione.class, idAcc );

		Set<LookupOperazioniAccettazione> registrazioniDaSalvare = accettazione.getOperazioniRichiesteBdrNonEseguite();
		
		String stato = stringaFromRequest("stato");
		int idTipoRegBdr =interoFromRequest("idTipoRegBdr");
		
		for( LookupOperazioniAccettazione loa: registrazioniDaSalvare )
		{
				AttivitaBdr abdr = new AttivitaBdr();
				abdr.setAccettazione	( accettazione );
				abdr.setEntered			( accettazione.getEntered() );
				abdr.setEnteredBy		( utente.getId() );
				abdr.setModified		( abdr.getEntered() );
				abdr.setModifiedBy		( utente.getId() );
				abdr.setOperazioneBdr	( loa );
				
				int idTipoRegBdrDaInserire = RegistrazioniUtil.getIdTipoBdrPreAcc(accettazione.getAnimale(), (accettazione.getTipoTrasferimento()==null)?(null):(accettazione.getTipoTrasferimento().getId()), accettazione.getAdozioneFuoriAsl(), accettazione.getAdozioneVersoAssocCanili(), loa, connection, connectionBdu,req);
				
				if((accettazione.getAnimale().getLookupSpecie().getId()==Specie.CANE || accettazione.getAnimale().getLookupSpecie().getId()==Specie.GATTO) && idTipoRegBdr==idTipoRegBdrDaInserire && CaninaRemoteUtil.getUltimaRegistrazione(accettazione.getAnimale().getIdentificativo(), idTipoRegBdrDaInserire, connection,req)!=null)
					abdr.setIdRegistrazioneBdr(CaninaRemoteUtil.getUltimaRegistrazione(accettazione.getAnimale().getIdentificativo(), idTipoRegBdrDaInserire, connection,req));
				//else
					//abdr.setIdRegistrazioneBdr(SinantropoUtil.getUltimaRegistrazione(accettazione.getAnimale(), idTipoRegBdr));
				
				if(CaninaRemoteUtil.getUltimaRegistrazione(accettazione.getAnimale().getIdentificativo(), idTipoRegBdrDaInserire, connection,req)!=null)
					persistence.insert( abdr );
		}
		
		persistence.commit();
		
		redirectTo( "vam.accettazione.TestRegistrazioni.us?idAccettazione=" + accettazione.getId() );
//		redirectTo( "vam.accettazione.Detail.us?id=" + accettazione.getId() );
	}
	
	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}
	
}
