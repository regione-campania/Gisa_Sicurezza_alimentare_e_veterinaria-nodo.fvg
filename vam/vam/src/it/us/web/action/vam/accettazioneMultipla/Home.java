package it.us.web.action.vam.accettazioneMultipla;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.lookup.LookupRazze;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdRichiesteVarie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class Home extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "ACCETTAZIONE", "DETAIL", "MAIN" );
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
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		gotoPage( "/jsp/vam/accettazioneMultipla/home.jsp" );
	}

}
