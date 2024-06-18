package it.us.web.action.vam.cc.decessi;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;



public class Detail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("decesso");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);	
		/*SERVIZIO DECESSO*/
		ServicesStatus status = new ServicesStatus();
		
		if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 1 && !cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe()) {
			RegistrazioniCaninaResponse res	= CaninaRemoteUtil.getInfoDecesso( cc.getAccettazione().getAnimale().getIdentificativo(), utente, status, connection ,req);
			req.setAttribute("res", res);
			
			//Errore nella comunicazione con il Wrapper
			if (!status.isAllRight()) {
				setErrore("Errore nella comunicazione con la BDR di riferimento");
				goToAction(new it.us.web.action.vam.cc.Detail());
			}
			if (res == null) {
				goToAction(new ToAdd());
			}
		
		}
		else if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 2 && !cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe()) {
			RegistrazioniFelinaResponse rfr = FelinaRemoteUtil.getInfoDecesso( cc.getAccettazione().getAnimale().getIdentificativo(), utente, status, connection ,req);
			req.setAttribute("res", rfr);
			
			//Errore nella comunicazione con il Wrapper
			if (!status.isAllRight()) {
				setErrore("Errore nella comunicazione con la BDR di riferimento");
				goToAction(new it.us.web.action.vam.cc.Detail());
			}
			if (rfr == null) {
				goToAction(new ToAdd());
			}
		}
		else if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 3 && !cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe()) {
			RegistrazioniSinantropiResponse rsr = SinantropoUtil.getInfoDecesso(persistence, cc.getAccettazione().getAnimale());
			req.setAttribute("res", rsr);
			
			if (rsr == null) {
				goToAction(new ToAdd());
			}
		}
//		else if (cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe() && cc.getAccettazione().getAnimale().getDataMorte() == null) {
//			goToAction(new ToAdd());
//		}
		
		gotoPage("/jsp/vam/cc/decessi/detail.jsp");
				
	}
	
	
}
