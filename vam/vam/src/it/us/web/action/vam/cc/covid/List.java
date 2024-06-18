package it.us.web.action.vam.cc.covid;

import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAutopsiaSalaSettoria;
import it.us.web.bean.vam.lookup.LookupCovidTipoTest;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class List extends GenericAction
{
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("covid");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{		
		CartellaClinica cc = (CartellaClinica)persistence.find (CartellaClinica.class, (Integer)session.getAttribute("idCc"));
		gotoPage("/jsp/vam/cc/covid/list.jsp");
	}
}
