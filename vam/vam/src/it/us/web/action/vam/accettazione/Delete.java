package it.us.web.action.vam.accettazione;

import java.util.Date;

import org.hibernate.Hibernate;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Accettazione;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class Delete extends GenericAction  implements Specie
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "ACCETTAZIONE", "DELETE", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("accettazione");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
		if(utente!=null && utente.getRuolo()!=null && !utente.getRuolo().equals("16") && !utente.getRuolo().equals("17"))
			super.canClinicaCessata();
	}

	@Override
	public void execute() throws Exception
	{
		Accettazione accettazione = (Accettazione) persistence.find( Accettazione.class, interoFromRequest( "id" ) );
		if( !accettazione.getCancellabile() )
		{
			req.setAttribute( "specie", SpecieAnimali.getInstance() );
			setErrore( "Non è possibile cancellare l'accettazione" );
			redirectTo( "vam.accettazione.Detail.us?id=" + accettazione.getId() );
		}
		else
		{
			accettazione.setTrashedDate( new Date() );
			Hibernate.initialize( accettazione.getOperazioniRichieste() );
			persistence.update( accettazione );
			persistence.commit();
			
			setMessaggio( "Accettazione eliminata con successo" );
			redirectTo( "vam.accettazione.Home.us" );
		}
	} 

}
