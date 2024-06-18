package it.us.web.action.sinantropi.decessi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.sinantropi.lookup.LookupTipiDocumento;
import it.us.web.bean.vam.lookup.LookupCMI;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class ToAdd extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_decesso");
	}

	public void execute() throws Exception
	{
			
		int idSinantropo = interoFromRequest("idSinantropo");
		
		Sinantropo s = (Sinantropo) persistence.find(Sinantropo.class, idSinantropo);
		
	/*	ArrayList<LookupCMI> listCMI = (ArrayList<LookupCMI>) persistence.createCriteria( LookupCMI.class )
		.addOrder( Order.asc( "level" ) )
		.list(); */
		
		
		req.setAttribute("s", s);		
//		req.setAttribute("listCMI", listCMI);		
		
		gotoPage("sinantropi_default","/jsp/sinantropi/decessi/add.jsp");
			
	}
}



