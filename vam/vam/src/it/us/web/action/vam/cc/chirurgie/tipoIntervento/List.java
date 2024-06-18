package it.us.web.action.vam.cc.chirurgie.tipoIntervento;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.TipoIntervento;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;
import java.util.Set;

public class List extends GenericAction {

	
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


		//Recupero di tutte le tipoIntervento associati alla CC
		Set<TipoIntervento> tipoIntervento = cc.getTipoInterventi();

		req.setAttribute("tipoIntervento", tipoIntervento);
				
		gotoPage("/jsp/vam/cc/chirurgie/tipoIntervento/list.jsp");
	}
}



