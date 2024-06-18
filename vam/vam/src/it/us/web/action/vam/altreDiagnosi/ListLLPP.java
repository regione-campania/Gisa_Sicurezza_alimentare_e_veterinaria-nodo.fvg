package it.us.web.action.vam.altreDiagnosi;

import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.AltreDiagnosi;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.exceptions.AuthorizationException;

public class ListLLPP extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "ALTRE_DIAGNOSI", "LIST_LLPP", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{	
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		
		ArrayList<AltreDiagnosi> altreDiagnosi = new ArrayList<AltreDiagnosi>();
	
		altreDiagnosi = (ArrayList<AltreDiagnosi>) UtenteDAO.getAltreDiagnosi(connection, utente.getSuperutente().getId());
		
		req.setAttribute("altreDiagnosi", altreDiagnosi);
		gotoPage("onlybody","/jsp/vam/altreDiagnosi/listLLPP.jsp");	
		
	}
}

