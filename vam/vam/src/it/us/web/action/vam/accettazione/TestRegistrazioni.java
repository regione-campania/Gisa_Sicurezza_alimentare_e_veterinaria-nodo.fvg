package it.us.web.action.vam.accettazione;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Accettazione;
import it.us.web.constants.Specie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class TestRegistrazioni extends GenericAction  implements Specie
{

	@Override
	public void can() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	@Override
	public void execute() throws Exception
	{
		Accettazione accettazione = (Accettazione) persistence.find( Accettazione.class, interoFromRequest( "idAccettazione" ) );
		
		if( eseguireOperazioniInBDR( accettazione ) && accettazione.getAnimale().getLookupSpecie().getId()!=SINANTROPO )
		{
			switch ( accettazione.getAnimale().getLookupSpecie().getId() )
			{
			case CANE:
				redirectTo( "vam.bdr.canina.ToRegistrazioni.us?idAccettazione=" + accettazione.getId() );
				break;
			case GATTO:
				redirectTo( "vam.bdr.felina.ToRegistrazioni.us?idAccettazione=" + accettazione.getId() );
				break;
			case SINANTROPO:
				redirectTo( "vam.bdr.sinantropi.ToRegistrazioni.us?idAccettazione=" + accettazione.getId() );
				break;
			}
		}
		else if ( accettazione != null )
		{
			redirectTo( "vam.accettazione.Detail.us?id=" + accettazione.getId() );
		}
		else
		{
			setErrore( "errore [vam.accettazione.TestRegistrazioni]: accettazione non può essere null" );
			goToAction( new Home() );
		}
	}
	

	private boolean eseguireOperazioniInBDR(Accettazione accettazione) throws Exception
	{
		return accettazione != null && accettazione.getOperazioniRichiesteBdrNonEseguite().size() > 0;
	}

}
