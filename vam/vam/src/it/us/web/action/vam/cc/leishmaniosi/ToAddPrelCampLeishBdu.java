package it.us.web.action.vam.cc.leishmaniosi;

import java.sql.Connection;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAritmie;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdOperazioniDM;
import it.us.web.constants.IdOperazioniInBdr;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.RegistrazioniUtil;


public class ToAddPrelCampLeishBdu extends GenericAction 
{

	@Override
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("chirurgia");
	}
	
	@Override
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		
		Context ctxVam = new InitialContext();
		javax.sql.DataSource dsVam = (javax.sql.DataSource)ctxVam.lookup("java:comp/env/jdbc/vamM");
		Connection connectionVam = dsVam.getConnection();
		aggiornaConnessioneApertaSessione(req);
		setConnection(connectionVam);
		
		
		req.setAttribute( "specie", SpecieAnimali.getInstance() );	
		req.setAttribute("animale", cc.getAccettazione().getAnimale());	
		req.setAttribute("operazionePrelievoLeishmania", (LookupOperazioniAccettazione)persistence.find(LookupOperazioniAccettazione.class, IdOperazioniBdr.prelievoLeishmania));
		req.setAttribute("idTipoRegBdr", RegistrazioniUtil.getIdTipoBdr(cc.getAccettazione().getAnimale(), cc.getAccettazione(), (LookupOperazioniAccettazione)persistence.find(LookupOperazioniAccettazione.class, IdOperazioniBdr.prelievoLeishmania), connectionVam, utente, connection,req));
		
		gotoPage("/jsp/vam/cc/leishmaniosi/addPrelCampLeishBdu.jsp");
			
	}

}

