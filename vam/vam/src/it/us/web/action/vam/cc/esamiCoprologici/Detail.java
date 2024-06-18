package it.us.web.action.vam.cc.esamiCoprologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameCoprologico;
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
		setSegnalibroDocumentazione("coprologico");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		EsameCoprologico esame = (EsameCoprologico) persistence.find(EsameCoprologico.class, interoFromRequest("id") );	
		
		//Recupero Bean CartellaClinica
		CartellaClinica cc = (CartellaClinica) esame.getCartellaClinica();
	
		
		req.setAttribute( "esame", esame );		
				
		gotoPage( "/jsp/vam/cc/esamiCoprologici/detail.jsp" );
	}
}

