package it.us.web.action.vam.diagnosiCitologica;

import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Clinica;
import it.us.web.bean.vam.EsameCitologico;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.vam.ClinicaDAO;
import it.us.web.dao.vam.EsameCitologicoDAO;
import it.us.web.exceptions.AuthorizationException;

public class ListLLPP extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "RICHIESTA_ISTOPATOLOGICO", "LIST_LLPP", "MAIN" );
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
		
		ArrayList<EsameCitologico> esamiCitologici = new ArrayList<EsameCitologico>();
	
		esamiCitologici = (ArrayList<EsameCitologico>) EsameCitologicoDAO.getByUtente( utente.getId() , connection);
		
		req.setAttribute("esamiCitologici", esamiCitologici);
		gotoPage("onlybody","/jsp/vam/diagnosiCitologica/listLLPP.jsp");	
		
	}
}

