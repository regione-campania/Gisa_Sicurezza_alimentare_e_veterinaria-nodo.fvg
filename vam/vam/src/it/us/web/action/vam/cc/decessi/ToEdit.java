package it.us.web.action.vam.cc.decessi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupCMI;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;

import java.sql.Connection;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Order;

public class ToEdit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("decesso");
	}

	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
			/*ArrayList<LookupCMI> listCMI = (ArrayList<LookupCMI>) persistence.createCriteria( LookupCMI.class )
			.addOrder( Order.asc( "level" ) )
			.list();*/
				
			
			/*SERVIZIO DECESSO*/			
			ServicesStatus status = new ServicesStatus();
			
			if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 1) {
				RegistrazioniCaninaResponse res	= CaninaRemoteUtil.getInfoDecesso( cc.getAccettazione().getAnimale().getIdentificativo(), utente, status, connection,req );
				
				//Errore nella comunicazione con il Wrapper
				if (!status.isAllRight()) {
					setMessaggio("Errore nella comunicazione con la BDR di riferimento");
					goToAction(new it.us.web.action.vam.cc.Detail());
				}
				
				req.setAttribute("res", res);
			
			}
			else if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 2) {
				RegistrazioniFelinaResponse rfr = FelinaRemoteUtil.getInfoDecesso( cc.getAccettazione().getAnimale().getIdentificativo(), utente, status, connection,req );
				
				//Errore nella comunicazione con il Wrapper
				if (!status.isAllRight()) {
					setMessaggio("Errore nella comunicazione con la BDR di riferimento");
					goToAction(new it.us.web.action.vam.cc.Detail());
				}
				
				req.setAttribute("res", rfr);
			}
			else if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 3) {
				RegistrazioniSinantropiResponse rsr = SinantropoUtil.getInfoDecesso(persistence, cc.getAccettazione().getAnimale());
				req.setAttribute("res", rsr);
			}
				
			//req.setAttribute("listCMI", listCMI);		
			
					
			gotoPage("/jsp/vam/cc/decessi/edit.jsp");
		}
	}