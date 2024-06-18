package it.us.web.action.vam.cc.chirurgie;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.constants.IdOperazioniBdr;
import it.us.web.constants.IdOperazioniInBdr;
import it.us.web.constants.Specie;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.RegistrazioniUtil;


public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ecoCuore");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{

		Context ctxBdu = new InitialContext();
		javax.sql.DataSource dsBdu = (javax.sql.DataSource)ctxBdu.lookup("java:comp/env/jdbc/bduS");
		connectionBdu = dsBdu.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connectionBdu);
		
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnection(connection);
		
		
		LookupOperazioniAccettazione operazione = (LookupOperazioniAccettazione)persistence.find(LookupOperazioniAccettazione.class, IdOperazioniBdr.sterilizzazione);
		
		req.setAttribute("operazione", operazione);	
		req.setAttribute( "specie", SpecieAnimali.getInstance() );
		req.setAttribute("regEffettuabili",AnimaliUtil.findRegistrazioniEffettuabili( connection,  cc.getAccettazione().getAnimale(), utente, connectionBdu,req ));
		req.setAttribute("animaleAnagrafica", AnimaliUtil.getAnagrafica(cc.getAccettazione().getAnimale(), persistence, utente, new ServicesStatus(), connectionBdu,req));
		req.setAttribute("idRegBdr", RegistrazioniUtil.getIdRegUnivoca(cc.getAccettazione().getAnimale().getIdentificativo(), connectionBdu, IdOperazioniInBdr.sterilizzazione,req));
		gotoPage("/jsp/vam/cc/chirurgie/list.jsp");
	}
}



