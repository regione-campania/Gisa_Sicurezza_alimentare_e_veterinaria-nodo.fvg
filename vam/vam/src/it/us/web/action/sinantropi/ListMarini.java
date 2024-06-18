package it.us.web.action.sinantropi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ticket;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class ListMarini extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "LIST", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_anagrafica");
	}

	public void execute() throws Exception
	{
		
		int idClinica 	= utente.getClinica().getId();
		//ArrayList<Sinantropo> sinantropi = (ArrayList<Sinantropo>)  persistence.findAll(Sinantropo.class);
		
		
		//Recupero dei sinantropi di una determinata ASL
		ArrayList<Sinantropo> sinantropi = (ArrayList<Sinantropo>)  persistence.getNamedQuery("GetSinantropiByClinica")
				.setBoolean("zoo", false)
				.setBoolean("marini", true)
				.setBoolean("sinantropo", false)
				.setInteger("idClinica", idClinica).list();
		
		
		
		if (sinantropi.size() == 0) {
			
			setMessaggio("Nessun Animale Marino presente in banca dati");				
			gotoPage("sinantropi_default","/jsp/homepageS.jsp");	
			
			
		}
		else {			
						
			req.setAttribute("sinantropi", sinantropi);						
			gotoPage("sinantropi_default","/jsp/sinantropi/listMarini.jsp");
			
		}
		
	}
		
}

