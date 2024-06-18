package it.us.web.action.sinantropi;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.remoteBean.RegistrazioniSinantropi;
import it.us.web.bean.sinantropi.Catture;
import it.us.web.bean.sinantropi.Detenzioni;
import it.us.web.bean.sinantropi.Reimmissioni;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.Autopsia;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.DiagnosiEffettuate;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;

public class DetailZoo extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "BDR", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("sinantropi_anagrafica");
	}

	public void execute() throws Exception
	{
		int idSinantropo = interoFromRequest("idSinantropo");
		
		Sinantropo s = (Sinantropo) persistence.find(Sinantropo.class, idSinantropo);
						
		req.setAttribute("s", s);	
		req.setAttribute("interactiveMode", req.getParameter("interactiveMode"));
		
		//if(s.getTaglia()!=null)
			//req.setAttribute("taglia", s.getTaglia().getDescription());
		//req.setAttribute("mantello", s.getMantello());
		req.setAttribute("razza", s.getRazza());
		
		if ("y".equalsIgnoreCase(req.getParameter("interactiveMode")))		
			gotoPage("sinantropi_popup", "/jsp/sinantropi/detailZoo.jsp");
		else
			gotoPage("sinantropi_default", "/jsp/sinantropi/detailZoo.jsp");
			
	}
}

