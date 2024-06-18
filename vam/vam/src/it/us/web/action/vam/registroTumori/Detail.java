package it.us.web.action.vam.registroTumori;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.EsameCitologico;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.constants.SpecieAnimali;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.AnimaliUtil;
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
		setSegnalibroDocumentazione("registroTumori");
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
		
		EsameIstopatologico esame = null;
		EsameCitologico esameCit = null;
		if(stringaFromRequest("id")!=null)
			 esame = (EsameIstopatologico) persistence.find(EsameIstopatologico.class, interoFromRequest("id") );
		else
			 esameCit = (EsameCitologico) persistence.find(EsameCitologico.class, interoFromRequest("idCit") );
		
		
		//Se il cane non è morto senza mc bisogna leggere in bdr le info sulla morte
		ServicesStatus status = new ServicesStatus();
		
		Animale animale = null;
		
		if(esame!=null)
		{
			if(esame.getOutsideCC())
				animale = esame.getAnimale();
			else
				animale = esame.getCartellaClinica().getAccettazione().getAnimale();
				
			req.setAttribute( "esame", esame );		
		}
		else
		{

			if(esameCit.getOutsideCC())
				animale = esameCit.getAnimale();
			else
				animale = esameCit.getCartellaClinica().getAccettazione().getAnimale();
				
			req.setAttribute( "esame", esameCit );		
		}
		
		if (animale.getLookupSpecie().getId() == 1 && !animale.getDecedutoNonAnagrafe()) 
		{
			RegistrazioniCaninaResponse res	= CaninaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, status, connection,req );
			req.setAttribute("res", res);
		}
		else if (animale.getLookupSpecie().getId() == 2 && !animale.getDecedutoNonAnagrafe()) 
		{
			RegistrazioniFelinaResponse rfr = FelinaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, status, connection,req );
			req.setAttribute("res", rfr);
		}
		else if (animale.getLookupSpecie().getId() == 3 && !animale.getDecedutoNonAnagrafe()) 
		{
			RegistrazioniSinantropiResponse rsr = SinantropoUtil.getInfoDecesso(persistence, animale);
			req.setAttribute("res", rsr);
		}
		
		req.setAttribute( "specie", SpecieAnimali.getInstance() );
		req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(animale, persistence, utente, status, connection,req));
		
		gotoPage("popup", "/jsp/vam/registroTumori/detail.jsp" );
	}
}

