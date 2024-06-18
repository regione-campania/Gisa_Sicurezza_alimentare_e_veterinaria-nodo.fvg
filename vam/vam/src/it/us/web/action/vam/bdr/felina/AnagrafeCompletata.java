package it.us.web.action.vam.bdr.felina;

import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.AttivitaBdr;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.RegistrazioniUtil;

public class AnagrafeCompletata extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("accettazione");
	}

	@Override
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		String identificativo = stringaFromRequest( "identificativo" );
		
		ServicesStatus status = new ServicesStatus();
		
		HashMap<String, Object> fetchAnimale = AnimaliUtil.fetchAnimale( identificativo, persistence, utente, status, connection,req );
		Animale animale = (Animale)fetchAnimale.get("animale");
		if(animale!=null)
			animale.setClinicaChippatura(utente.getClinica());
		
		if( status.isAllRight() )
		{
			if( animale == null ) //animale non presente in locale nè nelle bdr remote -> va inserito in bdr
			{
				setErrore("Non hai inserito in BDR l'animale per il quale si sta procedendo all'accettazione");
				gotoPage( "/jsp/vam/bdr/inserimentoAnagrafe_sceltaSistema.jsp" );
			}
			else
			{
				//flagAnagrafe=on serve a flaggare in automatico l'operazione "Inserimento Anagrafe"
				redirectTo( "vam.accettazione.ToAdd.us?idAnimale=" + animale.getId() + "&flagAnagrafe=on" );
			}
		}
		else
		{
			setErrore( "Si è verificato un errore di comunicazione con la BDR di riferimento: " + status.getError() );
			gotoPage( "/jsp/errore/errore.jsp" );
		}
		
	}
	
}
