package it.us.web.action.vam.cc.ecg;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
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
		setSegnalibroDocumentazione("ecg");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		int id = interoFromRequest("idEcg");
		
		//Recupero Bean ECG
		Ecg ecg = (Ecg) persistence.find (Ecg.class, id);
		
		//Recupero Bean CartellaClinica
		CartellaClinica cc = (CartellaClinica) ecg.getCartellaClinica();

			
	
		req.setAttribute("ecg", ecg);		
				
		gotoPage("/jsp/vam/cc/ecg/detail.jsp");
	}
}

