package it.us.web.action.vam;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.FelinaRemoteUtil;

public class SwitchToVam extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		isLoggedSessionContext();
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	@Override
	public void execute() throws Exception
	{
		session.setAttribute("system", "vam");
		
		gotoPage("/jsp/vam/switchToVam.jsp");
	}
	
}
