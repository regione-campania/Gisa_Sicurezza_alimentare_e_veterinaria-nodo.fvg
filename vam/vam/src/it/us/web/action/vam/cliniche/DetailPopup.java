package it.us.web.action.vam.cliniche;


import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Clinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class DetailPopup extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CLINICA", "MAIN", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	public void execute() throws Exception
	{
		int id = interoFromRequest("id");
		
		//Recupero Bean Clinica
		Clinica clinica = (Clinica)persistence.find(Clinica.class, id);
		req.setAttribute("clinica", clinica);
		
		gotoPage("popup" , "/jsp/vam/cliniche/detailPopup.jsp");
	}
}