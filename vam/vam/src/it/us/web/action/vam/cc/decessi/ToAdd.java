package it.us.web.action.vam.cc.decessi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupCMI;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import java.util.ArrayList;
import org.hibernate.criterion.Order;


public class ToAdd extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("decesso");
	}

	public void execute() throws Exception
	{
			/*ArrayList<LookupCMI> listCMI = (ArrayList<LookupCMI>) persistence.createCriteria( LookupCMI.class )
			.addOrder( Order.asc( "level" ) )
			.list();
		
			req.setAttribute("listCMI", listCMI);*/		
				
			gotoPage("/jsp/vam/cc/decessi/add.jsp");
	}
}


