package it.us.web.action.vam.izsm.esamiIstopatologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Ecg;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoInteressamentoLinfonodale;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoSedeLesione;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumoriPrecedenti;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.lookup.LookupEsameIstopatologicoTipoDiagnosiDAO;
import it.us.web.dao.vam.EsameIstopatologicoDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;
import it.us.web.util.vam.AnimaliUtil;
import it.us.web.util.vam.IstopatologicoUtil;
import it.us.web.util.vam.RegistroTumoriRemoteUtil;

import java.sql.Connection;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.commons.beanutils.BeanUtils;
import org.json.JSONObject;

import configurazione.centralizzata.nuova.gestione.ClientServizioCentralizzato;

public class Edit extends GenericAction {

	
	public void can() throws AuthorizationException
	{
//		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
//		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}

	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnection(connection);
		
		
		javax.sql.DataSource dsBDU = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		connectionBdu = dsBDU.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connectionBdu);
		int idCc = interoFromRequest("idCc");
				
		EsameIstopatologico esame = EsameIstopatologicoDAO.get(interoFromRequest( "idEsame" ), connection);
				
		if(esame.getCartellaClinica()!=null)
		{
			session.setAttribute("cc", esame.getCartellaClinica());
			session.setAttribute("idCc", esame.getCartellaClinica().getId());
			cc = esame.getCartellaClinica();
		}
		
		EsameIstopatologicoDAO.update(stringaFromRequest("dataEsito"), stringaFromRequest("diagnosiNonTumorale"), stringaFromRequest("descrizioneMorfologica"),interoFromRequest( "idEsame" ), connection, interoFromRequest( "idTipoDiagnosi" ), interoFromRequest( "idWhoUmana" ),utente.getId());
				
		setMessaggio( "Esame Istopatologico salvato con successo" );
		
		if (esame.getOutsideCC()==true){
			req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(esame.getAnimale(), persistence, utente, new ServicesStatus(), connectionBdu,req));
			req.setAttribute("animale", esame.getAnimale());
		}
		else {
			req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(esame.getCartellaClinica().getAccettazione().getAnimale(), persistence, utente, new ServicesStatus(), connectionBdu,req));
			req.setAttribute("animale", esame.getCartellaClinica().getAccettazione().getAnimale());
		}
		
		req.setAttribute("esame", esame);
		
		
		String mess = "";
		if(cc!=null)
		{
			if (cc.getPeso()==null || cc.getPeso().equals("")){
				mess = mess+" peso,";
			}
			if (cc.getLookupAlimentazionis().size() == 0){
				mess = mess+" alimentazione,";
			}
			if (cc.getLookupHabitats().size() == 0){
				mess = mess+" habitat,";
			}
		}
		
		if (!mess.equals("")) 
		{
			//setMessaggio( "Potresti aggiungere i seguenti dettagli alla richiesta :" + mess+" cliccando sull'apposito bottone nella home dalla cc." );
		}
		
		
		if(stringaFromRequest("toCc")!=null && stringaFromRequest("toCc").equals("on"))
			gotoPage("/jsp/vam/cc/esamiIstopatologici/detail.jsp" );
		else if(stringaFromRequest("toDetailLLPP")!=null && stringaFromRequest("toDetailLLPP").equals("on")) 
		{
			//String pathVam = Application.get("VAM_PROTOCOLLO") + Application.get("VAM_NOME_HOST") + Application.get("VAM_PORTA") + "/vam";
			ClientServizioCentralizzato sclient = new ClientServizioCentralizzato();
			JSONObject mappaEndPoints = sclient.getMappaEndpointsSca();
			String pathVam = mappaEndPoints.getString("vam");
			
			redirectTo( pathVam + "/vam.richiesteIstopatologici.DetailLLPP.us?id=" + esame.getId(),false);
		}
		else
			redirectTo("vam.izsm.esamiIstopatologici.ToFind.us" );
	}
}
