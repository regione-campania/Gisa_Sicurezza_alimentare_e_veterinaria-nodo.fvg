package it.us.web.action.vam.bdr.sinantropi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToAnagrafe extends GenericAction
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
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	@Override
	public void execute() throws Exception
	{
		req.setAttribute("sinantropo", stringaFromRequest("sinantropo"));
		gotoPage( "/jsp/vam/bdr/sinantropi/anagrafa.jsp" );
	}
	
}
