package it.us.web.action.vam.cc.chirurgie.tipoIntervento;

import java.util.ArrayList;

import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.TipoIntervento;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class Detail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("tipoIntervento");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
			
		int id = interoFromRequest("idTipoIntervento");
		
		//Recupero Bean TipoIntervento
		TipoIntervento tipoIntervento = (TipoIntervento) persistence.find(TipoIntervento.class, id);
		
		req.setAttribute("tipoIntervento", tipoIntervento);	
		
		gotoPage("/jsp/vam/cc/chirurgie/tipoIntervento/detail.jsp");
	}
}

