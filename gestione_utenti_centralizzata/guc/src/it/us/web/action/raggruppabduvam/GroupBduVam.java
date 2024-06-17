package it.us.web.action.raggruppabduvam;

import java.util.ArrayList;

import org.json.JSONObject;

import it.us.web.action.GenericAction;
import it.us.web.bean.endpointconnector.EndPoint;
import it.us.web.bean.endpointconnector.EndPointConnector;
import it.us.web.bean.endpointconnector.EndPointConnectorList;
import it.us.web.bean.endpointconnector.Operazione;
import it.us.web.bean.raggruppabduvam.Utente;
import it.us.web.bean.raggruppabduvam.UtentiList;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.guc.UrlUtil;

public class GroupBduVam extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		isLogged();
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		int utenteBDU = interoFromRequest("utenteBDU");
		int utenteVAM = interoFromRequest("utenteVAM");
		
		int ruoloBDU = interoFromRequest("ruoloBDU"+utenteBDU);
		int ruoloVAM = interoFromRequest("ruoloVAM"+utenteVAM);
		
		String usernameBDU = stringaFromRequest("usernameBDU"+utenteBDU);
		String usernameVAM = stringaFromRequest("usernameVAM"+utenteVAM);
		
		String sistemaRIF = stringaFromRequest("sistemaRIF");
		String usernameRIF = "";
		
		if (sistemaRIF.equalsIgnoreCase("bdu"))
			usernameRIF = usernameBDU;
		else if (sistemaRIF.equalsIgnoreCase("vam"))
			usernameRIF = usernameVAM;
		
			String esito =  Utente.raggruppa(db, utenteBDU, utenteVAM, ruoloBDU, ruoloVAM, usernameRIF);
			
			JSONObject jsonEsito = new JSONObject(esito);

			if (jsonEsito.get("Esito").equals("OK")) {
				String urlReloadUtenti = null;
				EndPointConnectorList listaEndPointConnector = (EndPointConnectorList) req.getSession().getAttribute("listaEndPointConnector");
				EndPointConnector epcInserimentoBDU = listaEndPointConnector.getByIdOperazioneIdEndPoint(Operazione.INSERTUTENTE, EndPoint.BDU);
				EndPointConnector epcInserimentoVAM = listaEndPointConnector.getByIdOperazioneIdEndPoint(Operazione.INSERTUTENTE, EndPoint.VAM);
				
				urlReloadUtenti	 = epcInserimentoBDU.getUrlReloadUtenti() +usernameBDU;
				System.out.println("[GUC] [RAGGRUPPABDUVAM] RELOAD UTENTI: " + urlReloadUtenti);
				try {String resp = UrlUtil.getUrlResponse(urlReloadUtenti); } catch (Exception e) {}
				
				urlReloadUtenti	 = epcInserimentoVAM.getUrlReloadUtenti() +usernameVAM;
				System.out.println("[GUC] [RAGGRUPPABDUVAM] RELOAD UTENTI: " + urlReloadUtenti);
				try {String resp = UrlUtil.getUrlResponse(urlReloadUtenti); } catch (Exception e) {}
				
				urlReloadUtenti	 = epcInserimentoBDU.getUrlReloadUtenti() +jsonEsito.get("username");
				System.out.println("[GUC] [RAGGRUPPABDUVAM] RELOAD UTENTI: " + urlReloadUtenti);
				try {String resp = UrlUtil.getUrlResponse(urlReloadUtenti); } catch (Exception e) {}
				urlReloadUtenti	 = epcInserimentoVAM.getUrlReloadUtenti() +jsonEsito.get("username");
				System.out.println("[GUC] [RAGGRUPPABDUVAM] RELOAD UTENTI: " + urlReloadUtenti);
				try {String resp = UrlUtil.getUrlResponse(urlReloadUtenti); } catch (Exception e) {}
				
			}
			
			req.setAttribute("esito", esito); 
		
			ArrayList<Utente> listaUtentiBDU = UtentiList.creaLista(db, "bdu");
			req.setAttribute("listaUtentiBDU", listaUtentiBDU);
			
			ArrayList<Utente> listaUtentiVAM = UtentiList.creaLista(db, "vam");
			req.setAttribute("listaUtentiVAM", listaUtentiVAM);
			
			gotoPage( "/jsp/raggruppabduvam/utentilist.jsp" );
	}


}
