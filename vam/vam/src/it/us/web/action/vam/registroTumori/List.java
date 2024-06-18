package it.us.web.action.vam.registroTumori;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.AltreDiagnosi;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.EsameCitologico;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupAutopsiaOrganiTipiEsamiEsiti;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.vam.EsameCitologicoDAO;
import it.us.web.dao.vam.EsameIstopatologicoDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;

import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Order;

public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("registroTumori");
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
		
		ArrayList<EsameIstopatologico> listEsami = (ArrayList<EsameIstopatologico>) EsameIstopatologicoDAO.getByDiagnosi(1,connection);
		req.setAttribute("listEsami", listEsami);
		
		//Abilitazione 287
		if(Application.get("flusso_287").equals("true"))
		{
			ArrayList<EsameCitologico> listEsamiCit = (ArrayList<EsameCitologico>) EsameCitologicoDAO.getByDiagnosi(1,connection);
			req.setAttribute("listEsamiCit", listEsamiCit);
			
			ArrayList<AltreDiagnosi> altreDiagnosi = new ArrayList<AltreDiagnosi>();
			
			altreDiagnosi = (ArrayList<AltreDiagnosi>) UtenteDAO.getAltreDiagnosi(connection, -1);
			
			req.setAttribute("altreDiagnosi", altreDiagnosi);
		}
		
		req.setAttribute( "specie", SpecieAnimali.getInstance() );		
		
		gotoPage("/jsp/vam/registroTumori/list.jsp");
	}
}



