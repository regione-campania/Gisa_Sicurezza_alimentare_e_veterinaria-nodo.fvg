package it.us.web.action.vam.cc.esamiObiettivo;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoApparati;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class ToChooseApparato extends GenericAction 
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("esameObiettivo");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void execute() throws Exception
	{
		ArrayList<LookupEsameObiettivoApparati> leoa = (ArrayList<LookupEsameObiettivoApparati>) persistence.findAll(LookupEsameObiettivoApparati.class);
		
		req.setAttribute("leoa", leoa);
		
		gotoPage( "/jsp/vam/cc/esamiObiettivo/chooseApparato.jsp" );
	}

}

