package it.us.web.action.vam.cc.diagnosi;

import java.util.Set;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Diagnosi;
import it.us.web.bean.vam.DiagnosiEffettuate;
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
		setSegnalibroDocumentazione("diagnosi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		int id = interoFromRequest("idDiagnosi");
		
		//Recupero Bean Diagnosi
		Diagnosi d = (Diagnosi) persistence.find (Diagnosi.class, id);
		Set<DiagnosiEffettuate> deList = (Set<DiagnosiEffettuate>) d.getDiagnosiEffettuate();
				
		//Recupero Bean CartellaClinica
		CartellaClinica cc = (CartellaClinica) d.getCartellaClinica();

		req.setAttribute("d", d);	
		req.setAttribute("deList", deList);
			
		gotoPage("/jsp/vam/cc/diagnosi/detail.jsp");
	}
}

