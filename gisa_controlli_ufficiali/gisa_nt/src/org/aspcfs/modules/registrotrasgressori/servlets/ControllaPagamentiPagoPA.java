package org.aspcfs.modules.registrotrasgressori.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.modules.registrotrasgressori.base.Pagamento;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;

/**
 * Servlet implementation class ReloadUtenti
 */
public class ControllaPagamentiPagoPA extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControllaPagamentiPagoPA() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("[ControllaPagamentiPagoPA] Inizio procedura.");
		
		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;

		ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
		String ceHost = prefs.get("GATEKEEPER.URL");
		String ceUser = prefs.get("GATEKEEPER.USER");
		String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

		ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
		cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");
		
		ArrayList<Pagamento> listaAvvisi = new ArrayList<Pagamento>();

		JSONObject jsonFinale = new JSONObject();
		JSONArray jsonAvvisi = new JSONArray();

		try {
			db = apriConnessione(request, cp, db, ce);
			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, -1, -1, "", "", "[ControllaPagamentiPagoPA] Inizio.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		int idSanzione = -1;
		int totSanzioni = 0;
		try {
			db = apriConnessione(request, cp, db, ce);
			PreparedStatement pst = db.prepareStatement("select * from pagopa_get_avvisi_non_pagati();");
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Pagamento p = new Pagamento(db, rs.getInt("id_pagamento"));
				listaAvvisi.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		for (int i = 0; i<listaAvvisi.size(); i++) {
			try {
				db = apriConnessione(request, cp, db, ce);
				Pagamento p = (Pagamento) listaAvvisi.get(i);
				String messaggio = "";
				PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaPagamentiPagoPA] Tentativo di verifica stato IUV.");
				PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaPagamentiPagoPA] Tentativo di verifica stato IUV.");
				p.chiediPagati(db, false, -1);

				PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaPagamentiPagoPA] Stato pagamento: "+p.getStatoPagamento());

				JSONObject jsonAvviso = new JSONObject();
				jsonAvviso.put("Id sanzione", p.getIdSanzione());
				jsonAvviso.put("IUV", p.getIdentificativoUnivocoVersamento());
				jsonAvviso.put("Esito operazione", p.getEsitoInvio());
				jsonAvviso.put("Stato pagamento", p.getStatoPagamento());
				jsonAvvisi.put(jsonAvviso);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				chiudiConnessione(cp, db);
			}
		}

		jsonFinale.put("Numero avvisi coinvolti", jsonAvvisi.length());       

		try {
			db = apriConnessione(request, cp, db, ce);
			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, -1, -1, "", "", "[ControllaPagamentiPagoPA] Fine.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		jsonFinale.put("Lista avvisi", jsonAvvisi);
		response.setContentType("Application/JSON");
		response.getWriter().write(jsonFinale.toString());

		System.out.println("[ControllaPagamentiPagoPA] Fine procedura.");

	} 
	
	/*
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 

		System.out.println("[ControllaPagamentiPagoPA] Inizio procedura.");
		
		ArrayList<String> listaIud = new ArrayList<String> ();
		
		MediaType hdr  = MediaType.parse("text/xml;charset=UTF-8");
		
		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;

		ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
		String ceHost = prefs.get("GATEKEEPER.URL");
		String ceUser = prefs.get("GATEKEEPER.USER");
		String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

		ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
		cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");
		
		JSONObject jsonFinale = new JSONObject();
		JSONArray jsonAvvisi = new JSONArray();

		try {
			db = apriConnessione(request, cp, db, ce);
			PreparedStatement pst = db.prepareStatement("select * from temp_pagopa_iud_scaduti where nuovo_stato_pagamento is null limit 1000");
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				listaIud.add(rs.getString("iud"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		for (int i = 0; i<listaIud.size(); i++) {
			try {
				db = apriConnessione(request, cp, db, ce);
				String iud = (String) listaIud.get(i);
				
				String wsreq = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ente=\"http://www.regione.veneto.it/pagamenti/ente/\">   <soapenv:Header/>   <soapenv:Body>      <ente:paaSILChiediPagatiConRicevuta>         <codIpaEnte>R_CAMPAN</codIpaEnte>         <password>VOOYUGNPZZSO</password>         <identificativoUnivocoDovuto>"+iud+"</identificativoUnivocoDovuto>      </ente:paaSILChiediPagatiConRicevuta>   </soapenv:Body></soapenv:Envelope>";
				
				String wsres = null;
				PreparedStatement pst = null;

				RequestBody body = RequestBody.create(hdr, wsreq);
				Request req = new Request.Builder().url("https://mypay.regione.campania.it/pa/services/PagamentiTelematiciDovutiPagati/").post(body).build();
			
				  OkHttpClient client = new OkHttpClient.Builder().connectTimeout(4, TimeUnit.SECONDS).writeTimeout(4, TimeUnit.SECONDS).readTimeout(4, TimeUnit.SECONDS).build();
				  
				  try (Response res = client.newCall(req).execute()) 
				  {
					  wsres = res.body().string();
					  
				  } 
				  catch (IOException e) 
				  {
					  // TODO Auto-generated catch block
					  e.printStackTrace();
				  }
			  
				
				//PER SIMULARE RISPOSTA PAGAMENTO COMPLETATO response="<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ns4:paaSILChiediPagatiConRicevutaRisposta xmlns:ns2=\"http://www.regione.veneto.it/pagamenti/ente/ppthead\" xmlns:ns3=\"http://www.regione.veneto.it/schemas/2012/Pagamenti/Ente/\" xmlns:ns4=\"http://www.regione.veneto.it/pagamenti/ente/\"><pagati>UEZCaFoyRjBhVU52YmxKcFkyVjJkWFJoSUhodGJHNXpQU0pvZEhSd09pOHZkM2QzTG5KbFoybHZibVV1ZG1WdVpYUnZMbWwwTDNOamFHVnRZWE12TWpBeE1pOVFZV2RoYldWdWRHa3ZSVzUwWlM4aVBnb2dJRHgyWlhKemFXOXVaVTluWjJWMGRHOCtOaTR5TGpBOEwzWmxjbk5wYjI1bFQyZG5aWFIwYno0S0lDQThaRzl0YVc1cGJ6NEtJQ0FnSUR4cFpHVnVkR2xtYVdOaGRHbDJiMFJ2YldsdWFXOCtPREF3TVRFNU9UQTJNems4TDJsa1pXNTBhV1pwWTJGMGFYWnZSRzl0YVc1cGJ6NEtJQ0E4TDJSdmJXbHVhVzgrQ2lBZ1BHbGtaVzUwYVdacFkyRjBhWFp2VFdWemMyRm5aMmx2VW1salpYWjFkR0UrT1RkaFlXVmxNRFJrTW1ZNE5HTXdOemt5WXpnM09UUTROalV6TkRaaU16TThMMmxrWlc1MGFXWnBZMkYwYVhadlRXVnpjMkZuWjJsdlVtbGpaWFoxZEdFK0NpQWdQR1JoZEdGUGNtRk5aWE56WVdkbmFXOVNhV05sZG5WMFlUNHlNREl5TFRFeExUSXpWREV3T2pVMU9qTTBMakF3TUNzd01Ub3dNRHd2WkdGMFlVOXlZVTFsYzNOaFoyZHBiMUpwWTJWMmRYUmhQZ29nSUR4eWFXWmxjbWx0Wlc1MGIwMWxjM05oWjJkcGIxSnBZMmhwWlhOMFlUNWhNamc1WlRsa00yVmlaV001TXpFME5UWTRPR1ptTUdGaVpUZzBPR1k0TlRaa056d3ZjbWxtWlhKcGJXVnVkRzlOWlhOellXZG5hVzlTYVdOb2FXVnpkR0UrQ2lBZ1BISnBabVZ5YVcxbGJuUnZSR0YwWVZKcFkyaHBaWE4wWVQ0eU1ESXlMVEV4TFRJekt6QXhPakF3UEM5eWFXWmxjbWx0Wlc1MGIwUmhkR0ZTYVdOb2FXVnpkR0UrQ2lBZ1BHbHpkR2wwZFhSdlFYUjBaWE4wWVc1MFpUNEtJQ0FnSUR4cFpHVnVkR2xtYVdOaGRHbDJiMVZ1YVhadlkyOUJkSFJsYzNSaGJuUmxQZ29nSUNBZ0lDQThkR2x3YjBsa1pXNTBhV1pwWTJGMGFYWnZWVzVwZG05amJ6NUhQQzkwYVhCdlNXUmxiblJwWm1sallYUnBkbTlWYm1sMmIyTnZQZ29nSUNBZ0lDQThZMjlrYVdObFNXUmxiblJwWm1sallYUnBkbTlWYm1sMmIyTnZQa0ZDU1RBek1EWTVQQzlqYjJScFkyVkpaR1Z1ZEdsbWFXTmhkR2wyYjFWdWFYWnZZMjgrQ2lBZ0lDQThMMmxrWlc1MGFXWnBZMkYwYVhadlZXNXBkbTlqYjBGMGRHVnpkR0Z1ZEdVK0NpQWdJQ0E4WkdWdWIyMXBibUY2YVc5dVpVRjBkR1Z6ZEdGdWRHVStTVzUwWlhOaElGTmhibkJoYjJ4dklGTXVjQzVCUEM5a1pXNXZiV2x1WVhwcGIyNWxRWFIwWlhOMFlXNTBaVDRLSUNBOEwybHpkR2wwZFhSdlFYUjBaWE4wWVc1MFpUNEtJQ0E4Wlc1MFpVSmxibVZtYVdOcFlYSnBiejRLSUNBZ0lEeHBaR1Z1ZEdsbWFXTmhkR2wyYjFWdWFYWnZZMjlDWlc1bFptbGphV0Z5YVc4K0NpQWdJQ0FnSUR4MGFYQnZTV1JsYm5ScFptbGpZWFJwZG05VmJtbDJiMk52UGtjOEwzUnBjRzlKWkdWdWRHbG1hV05oZEdsMmIxVnVhWFp2WTI4K0NpQWdJQ0FnSUR4amIyUnBZMlZKWkdWdWRHbG1hV05oZEdsMmIxVnVhWFp2WTI4K09EQXdNVEU1T1RBMk16azhMMk52WkdsalpVbGtaVzUwYVdacFkyRjBhWFp2Vlc1cGRtOWpiejRLSUNBZ0lEd3ZhV1JsYm5ScFptbGpZWFJwZG05VmJtbDJiMk52UW1WdVpXWnBZMmxoY21sdlBnb2dJQ0FnUEdSbGJtOXRhVzVoZW1sdmJtVkNaVzVsWm1samFXRnlhVzgrVW1WbmFXOXVaU0JEWVcxd1lXNXBZVHd2WkdWdWIyMXBibUY2YVc5dVpVSmxibVZtYVdOcFlYSnBiejRLSUNBZ0lEeHBibVJwY21sNmVtOUNaVzVsWm1samFXRnlhVzgrVm1saElGTmhiblJoSUV4MVkybGhQQzlwYm1ScGNtbDZlbTlDWlc1bFptbGphV0Z5YVc4K0NpQWdJQ0E4WTJsMmFXTnZRbVZ1WldacFkybGhjbWx2UGpneFBDOWphWFpwWTI5Q1pXNWxabWxqYVdGeWFXOCtDaUFnSUNBOFkyRndRbVZ1WldacFkybGhjbWx2UGpnd01UTXlQQzlqWVhCQ1pXNWxabWxqYVdGeWFXOCtDaUFnSUNBOGJHOWpZV3hwZEdGQ1pXNWxabWxqYVdGeWFXOCtUbUZ3YjJ4cFBDOXNiMk5oYkdsMFlVSmxibVZtYVdOcFlYSnBiejRLSUNBZ0lEeHdjbTkyYVc1amFXRkNaVzVsWm1samFXRnlhVzgrVGtFOEwzQnliM1pwYm1OcFlVSmxibVZtYVdOcFlYSnBiejRLSUNBZ0lEeHVZWHBwYjI1bFFtVnVaV1pwWTJsaGNtbHZQa2xVUEM5dVlYcHBiMjVsUW1WdVpXWnBZMmxoY21sdlBnb2dJRHd2Wlc1MFpVSmxibVZtYVdOcFlYSnBiejRLSUNBOGMyOW5aMlYwZEc5UVlXZGhkRzl5WlQ0S0lDQWdJRHhwWkdWdWRHbG1hV05oZEdsMmIxVnVhWFp2WTI5UVlXZGhkRzl5WlQ0S0lDQWdJQ0FnUEhScGNHOUpaR1Z1ZEdsbWFXTmhkR2wyYjFWdWFYWnZZMjgrUmp3dmRHbHdiMGxrWlc1MGFXWnBZMkYwYVhadlZXNXBkbTlqYno0S0lDQWdJQ0FnUEdOdlpHbGpaVWxrWlc1MGFXWnBZMkYwYVhadlZXNXBkbTlqYno1R1RGUldRMDQxTjFBeE0wYzRNelJRUEM5amIyUnBZMlZKWkdWdWRHbG1hV05oZEdsMmIxVnVhWFp2WTI4K0NpQWdJQ0E4TDJsa1pXNTBhV1pwWTJGMGFYWnZWVzVwZG05amIxQmhaMkYwYjNKbFBnb2dJQ0FnUEdGdVlXZHlZV1pwWTJGUVlXZGhkRzl5WlQ1R1RFRlZWRThnVmtsT1EwVk9Xazg4TDJGdVlXZHlZV1pwWTJGUVlXZGhkRzl5WlQ0S0lDQThMM052WjJkbGRIUnZVR0ZuWVhSdmNtVStDaUFnUEdSaGRHbFFZV2RoYldWdWRHOCtDaUFnSUNBOFkyOWthV05sUlhOcGRHOVFZV2RoYldWdWRHOCtNRHd2WTI5a2FXTmxSWE5wZEc5UVlXZGhiV1Z1ZEc4K0NpQWdJQ0E4YVcxd2IzSjBiMVJ2ZEdGc1pWQmhaMkYwYno0eE5UQXdMakF3UEM5cGJYQnZjblJ2Vkc5MFlXeGxVR0ZuWVhSdlBnb2dJQ0FnUEdsa1pXNTBhV1pwWTJGMGFYWnZWVzVwZG05amIxWmxjbk5oYldWdWRHOCtNREV3TURBd01EQXdNRGMwTkRJd05qTThMMmxrWlc1MGFXWnBZMkYwYVhadlZXNXBkbTlqYjFabGNuTmhiV1Z1ZEc4K0NpQWdJQ0E4WTI5a2FXTmxRMjl1ZEdWemRHOVFZV2RoYldWdWRHOCtOVFpsT1RZMU1UUTJOV016TkdSallUZzNZelZoTVRobE9HWTROVEpoWVRJOEwyTnZaR2xqWlVOdmJuUmxjM1J2VUdGbllXMWxiblJ2UGdvZ0lDQWdQR1JoZEdsVGFXNW5iMnh2VUdGbllXMWxiblJ2UGdvZ0lDQWdJQ0E4YVdSbGJuUnBabWxqWVhScGRtOVZibWwyYjJOdlJHOTJkWFJ2UGpFNE1qQTBNREF4TURBd05qWTVOVHd2YVdSbGJuUnBabWxqWVhScGRtOVZibWwyYjJOdlJHOTJkWFJ2UGdvZ0lDQWdJQ0E4YzJsdVoyOXNiMGx0Y0c5eWRHOVFZV2RoZEc4K01UVXdNQzR3TUR3dmMybHVaMjlzYjBsdGNHOXlkRzlRWVdkaGRHOCtDaUFnSUNBZ0lEeGxjMmwwYjFOcGJtZHZiRzlRWVdkaGJXVnVkRzgrUlZORlIxVkpWRTg4TDJWemFYUnZVMmx1WjI5c2IxQmhaMkZ0Wlc1MGJ6NEtJQ0FnSUNBZ1BHUmhkR0ZGYzJsMGIxTnBibWR2Ykc5UVlXZGhiV1Z1ZEc4K01qQXlNaTB4TVMweU15c3dNVG93TUR3dlpHRjBZVVZ6YVhSdlUybHVaMjlzYjFCaFoyRnRaVzUwYno0S0lDQWdJQ0FnUEdsa1pXNTBhV1pwWTJGMGFYWnZWVzVwZG05amIxSnBjMk52YzNOcGIyNWxQalUyWlRrMk5URTBOalZqTXpSa1kyRTROMk0xWVRFNFpUaG1PRFV5WVdFeVBDOXBaR1Z1ZEdsbWFXTmhkR2wyYjFWdWFYWnZZMjlTYVhOamIzTnphVzl1WlQ0S0lDQWdJQ0FnUEdOaGRYTmhiR1ZXWlhKellXMWxiblJ2UGk5U1JrSXZNREV3TURBd01EQXdNRGMwTkRJd05qTXZNVFV3TUM0d01DOVVXRlF2VUZZZ1RpNGdNakF2TVRZM0xUSWdMU0JPUVZNZ1UwRWdMU0JTUVZSQklGVk9TVU5CUEM5allYVnpZV3hsVm1WeWMyRnRaVzUwYno0S0lDQWdJQ0FnUEdSaGRHbFRjR1ZqYVdacFkybFNhWE5qYjNOemFXOXVaVDQ1THpnM01URTVPREExTnpZOEwyUmhkR2xUY0dWamFXWnBZMmxTYVhOamIzTnphVzl1WlQ0S0lDQWdJQ0FnUEdsdVpHbGpaVVJoZEdsVGFXNW5iMnh2VUdGbllXMWxiblJ2UGpFOEwybHVaR2xqWlVSaGRHbFRhVzVuYjJ4dlVHRm5ZVzFsYm5SdlBnb2dJQ0FnSUNBOFkyOXRiV2x6YzJsdmJtbEJjSEJzYVdOaGRHVlFVMUErTUM0d01Ed3ZZMjl0YldsemMybHZibWxCY0hCc2FXTmhkR1ZRVTFBK0NpQWdJQ0E4TDJSaGRHbFRhVzVuYjJ4dlVHRm5ZVzFsYm5SdlBnb2dJRHd2WkdGMGFWQmhaMkZ0Wlc1MGJ6NEtQQzlRWVdkaGRHbERiMjVTYVdObGRuVjBZVDQ9</pagati><tipoFirma></tipoFirma><rt>PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIiA/PjxSVCB4bWxuczp4c2k9Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvWE1MU2NoZW1hLWluc3RhbmNlIiB4bWxuczp4cz0iaHR0cDovL3d3dy53My5vcmcvMjAwMS9YTUxTY2hlbWEiIHhtbG5zOnBheV9pPSJodHRwOi8vd3d3LmRpZ2l0cGEuZ292Lml0L3NjaGVtYXMvMjAxMS9QYWdhbWVudGkvIiB4bWxucz0iaHR0cDovL3d3dy5kaWdpdHBhLmdvdi5pdC9zY2hlbWFzLzIwMTEvUGFnYW1lbnRpLyI+PHZlcnNpb25lT2dnZXR0bz42LjIuMDwvdmVyc2lvbmVPZ2dldHRvPjxkb21pbmlvPjxpZGVudGlmaWNhdGl2b0RvbWluaW8+ODAwMTE5OTA2Mzk8L2lkZW50aWZpY2F0aXZvRG9taW5pbz48L2RvbWluaW8+PGlkZW50aWZpY2F0aXZvTWVzc2FnZ2lvUmljZXZ1dGE+OTdhYWVlMDRkMmY4NGMwNzkyYzg3OTQ4NjUzNDZiMzM8L2lkZW50aWZpY2F0aXZvTWVzc2FnZ2lvUmljZXZ1dGE+PGRhdGFPcmFNZXNzYWdnaW9SaWNldnV0YT4yMDIyLTExLTIzVDEwOjU1OjM0PC9kYXRhT3JhTWVzc2FnZ2lvUmljZXZ1dGE+PHJpZmVyaW1lbnRvTWVzc2FnZ2lvUmljaGllc3RhPmEyODllOWQzZWJlYzkzMTQ1Njg4ZmYwYWJlODQ4Zjg1NmQ3PC9yaWZlcmltZW50b01lc3NhZ2dpb1JpY2hpZXN0YT48cmlmZXJpbWVudG9EYXRhUmljaGllc3RhPjIwMjItMTEtMjM8L3JpZmVyaW1lbnRvRGF0YVJpY2hpZXN0YT48aXN0aXR1dG9BdHRlc3RhbnRlPjxpZGVudGlmaWNhdGl2b1VuaXZvY29BdHRlc3RhbnRlPjx0aXBvSWRlbnRpZmljYXRpdm9Vbml2b2NvPkc8L3RpcG9JZGVudGlmaWNhdGl2b1VuaXZvY28+PGNvZGljZUlkZW50aWZpY2F0aXZvVW5pdm9jbz5BQkkwMzA2OTwvY29kaWNlSWRlbnRpZmljYXRpdm9Vbml2b2NvPjwvaWRlbnRpZmljYXRpdm9Vbml2b2NvQXR0ZXN0YW50ZT48ZGVub21pbmF6aW9uZUF0dGVzdGFudGU+SW50ZXNhIFNhbnBhb2xvIFMucC5BPC9kZW5vbWluYXppb25lQXR0ZXN0YW50ZT48L2lzdGl0dXRvQXR0ZXN0YW50ZT48ZW50ZUJlbmVmaWNpYXJpbz48aWRlbnRpZmljYXRpdm9Vbml2b2NvQmVuZWZpY2lhcmlvPjx0aXBvSWRlbnRpZmljYXRpdm9Vbml2b2NvPkc8L3RpcG9JZGVudGlmaWNhdGl2b1VuaXZvY28+PGNvZGljZUlkZW50aWZpY2F0aXZvVW5pdm9jbz44MDAxMTk5MDYzOTwvY29kaWNlSWRlbnRpZmljYXRpdm9Vbml2b2NvPjwvaWRlbnRpZmljYXRpdm9Vbml2b2NvQmVuZWZpY2lhcmlvPjxkZW5vbWluYXppb25lQmVuZWZpY2lhcmlvPlJlZ2lvbmUgQ2FtcGFuaWE8L2Rlbm9taW5hemlvbmVCZW5lZmljaWFyaW8+PGluZGlyaXp6b0JlbmVmaWNpYXJpbz5WaWEgU2FudGEgTHVjaWE8L2luZGlyaXp6b0JlbmVmaWNpYXJpbz48Y2l2aWNvQmVuZWZpY2lhcmlvPjgxPC9jaXZpY29CZW5lZmljaWFyaW8+PGNhcEJlbmVmaWNpYXJpbz44MDEzMjwvY2FwQmVuZWZpY2lhcmlvPjxsb2NhbGl0YUJlbmVmaWNpYXJpbz5OYXBvbGk8L2xvY2FsaXRhQmVuZWZpY2lhcmlvPjxwcm92aW5jaWFCZW5lZmljaWFyaW8+TkE8L3Byb3ZpbmNpYUJlbmVmaWNpYXJpbz48bmF6aW9uZUJlbmVmaWNpYXJpbz5JVDwvbmF6aW9uZUJlbmVmaWNpYXJpbz48L2VudGVCZW5lZmljaWFyaW8+PHNvZ2dldHRvUGFnYXRvcmU+PGlkZW50aWZpY2F0aXZvVW5pdm9jb1BhZ2F0b3JlPjx0aXBvSWRlbnRpZmljYXRpdm9Vbml2b2NvPkY8L3RpcG9JZGVudGlmaWNhdGl2b1VuaXZvY28+PGNvZGljZUlkZW50aWZpY2F0aXZvVW5pdm9jbz5GTFRWQ041N1AxM0c4MzRQPC9jb2RpY2VJZGVudGlmaWNhdGl2b1VuaXZvY28+PC9pZGVudGlmaWNhdGl2b1VuaXZvY29QYWdhdG9yZT48YW5hZ3JhZmljYVBhZ2F0b3JlPkZMQVVUTyBWSU5DRU5aTzwvYW5hZ3JhZmljYVBhZ2F0b3JlPjwvc29nZ2V0dG9QYWdhdG9yZT48ZGF0aVBhZ2FtZW50bz48Y29kaWNlRXNpdG9QYWdhbWVudG8+MDwvY29kaWNlRXNpdG9QYWdhbWVudG8+PGltcG9ydG9Ub3RhbGVQYWdhdG8+MTUwMC4wMDwvaW1wb3J0b1RvdGFsZVBhZ2F0bz48aWRlbnRpZmljYXRpdm9Vbml2b2NvVmVyc2FtZW50bz4wMTAwMDAwMDAwNzQ0MjA2MzwvaWRlbnRpZmljYXRpdm9Vbml2b2NvVmVyc2FtZW50bz48Q29kaWNlQ29udGVzdG9QYWdhbWVudG8+NTZlOTY1MTQ2NWMzNGRjYTg3YzVhMThlOGY4NTJhYTI8L0NvZGljZUNvbnRlc3RvUGFnYW1lbnRvPjxkYXRpU2luZ29sb1BhZ2FtZW50bz48c2luZ29sb0ltcG9ydG9QYWdhdG8+MTUwMC4wMDwvc2luZ29sb0ltcG9ydG9QYWdhdG8+PGVzaXRvU2luZ29sb1BhZ2FtZW50bz5FU0VHVUlUTzwvZXNpdG9TaW5nb2xvUGFnYW1lbnRvPjxkYXRhRXNpdG9TaW5nb2xvUGFnYW1lbnRvPjIwMjItMTEtMjM8L2RhdGFFc2l0b1NpbmdvbG9QYWdhbWVudG8+PGlkZW50aWZpY2F0aXZvVW5pdm9jb1Jpc2Nvc3Npb25lPjU2ZTk2NTE0NjVjMzRkY2E4N2M1YTE4ZThmODUyYWEyPC9pZGVudGlmaWNhdGl2b1VuaXZvY29SaXNjb3NzaW9uZT48Y2F1c2FsZVZlcnNhbWVudG8+L1JGQi8wMTAwMDAwMDAwNzQ0MjA2My8xNTAwLjAwL1RYVC9QViBOLiAyMC8xNjctMiAtIE5BUyBTQSAtIFJBVEEgVU5JQ0E8L2NhdXNhbGVWZXJzYW1lbnRvPjxkYXRpU3BlY2lmaWNpUmlzY29zc2lvbmU+OS8wMzAxMTE0U0EvODcxMTk4MDU3Ni88L2RhdGlTcGVjaWZpY2lSaXNjb3NzaW9uZT48Y29tbWlzc2lvbmlBcHBsaWNhdGVQU1A+MC4wMDwvY29tbWlzc2lvbmlBcHBsaWNhdGVQU1A+PC9kYXRpU2luZ29sb1BhZ2FtZW50bz48L2RhdGlQYWdhbWVudG8+PC9SVD4=</rt></ns4:paaSILChiediPagatiConRicevutaRisposta></soap:Body></soap:Envelope>";
				try {Thread.sleep(500);} catch (InterruptedException e) {e.printStackTrace();}
				

				String faultCode = null;
				String faultString = null;
				String description = null;
				String statoPagamento = null;
				String codiceEsitoPagamento = null;
				String dataRichiesta = null;
				String dataPagamento = null;
				
				if (wsres!=null && !wsres.equals("")){
					faultString = getTagValue(wsres, "faultString");
					faultCode = getTagValue(wsres, "faultCode");
					description = getTagValue(wsres, "description");

					String rt = getTagValue(wsres, "rt");
					String pagati = getTagValue(wsres, "pagati");
					String esito = getTagValue(wsres, "esito");
					String pagati_o_esito = "";
					
					if (pagati!=null && !pagati.equalsIgnoreCase(""))
						pagati_o_esito = pagati;
					else if (esito!=null && !esito.equalsIgnoreCase(""))
						pagati_o_esito = esito;
					else
						pagati_o_esito = rt;

					byte[] decodedBytes = null;
					String decodedString = "";
					
					int k = 0;
					
					while (k++<10 && !decodedString.startsWith("<")){ //decodifico il tag finche' non contiene il contenuto giusto (sono necessari piu' decode in alcuni casi)
							decodedBytes = Base64.getDecoder().decode(pagati_o_esito);
							decodedString = new String(decodedBytes);
							pagati_o_esito = decodedString;
					}
					
					decodedString = decodedString.replaceAll("pay_i:", "");

					// dati pagamento
					codiceEsitoPagamento = getTagValue(decodedString, "codiceEsitoPagamento");
					dataRichiesta =  getTagValue(decodedString, "riferimentoDataRichiesta");
					dataPagamento =  getTagValue(decodedString, "dataEsitoSingoloPagamento");

					if ((faultCode!=null && faultCode.equals("PAA_PAGAMENTO_NON_INIZIATO")))
						statoPagamento = Pagamento.PAGAMENTO_NON_INIZIATO;
					else if ((faultCode!=null && faultCode.equals("PAA_PAGAMENTO_IN_CORSO")))
						statoPagamento = Pagamento.PAGAMENTO_IN_CORSO;
					else if ((codiceEsitoPagamento!=null && codiceEsitoPagamento.equals("0"))) 
						statoPagamento = Pagamento.PAGAMENTO_COMPLETATO;
					else if ((faultCode!=null && faultCode.equals("PAA_SYSTEM_ERROR")) && (description!=null && description.toLowerCase().contains("dovuto scaduto"))) 
						statoPagamento = Pagamento.PAGAMENTO_SCADUTO;
					else
						statoPagamento = faultString;
					
					pst = db.prepareStatement("update temp_pagopa_iud_scaduti set nuovo_stato_pagamento = ?, data_richiesta = ?, data_pagamento = ? where iud = ?");
					pst.setString(1, statoPagamento);
					pst.setString(2, dataRichiesta);
					pst.setString(3, dataPagamento);
					pst.setString(4, iud);
					pst.executeUpdate();
			}
				else {
					
				}
				

				
				


				JSONObject jsonAvviso = new JSONObject();
				jsonAvviso.put("IUD", iud);
				jsonAvviso.put("Nuovo Stato pagamento", statoPagamento);
				jsonAvvisi.put(jsonAvviso);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				chiudiConnessione(cp, db);
			}
		}

		jsonFinale.put("Numero avvisi coinvolti", jsonAvvisi.length());       


		jsonFinale.put("Lista avvisi", jsonAvvisi);
		response.setContentType("Application/JSON");
		response.getWriter().write(jsonFinale.toString());

		System.out.println("[ControllaPagamentiPagoPA] Fine procedura.");

	}
*/

	private Connection apriConnessione(HttpServletRequest request, ConnectionPool cp, Connection db, ConnectionElement ce) throws SQLException{
		db = cp.getConnection(ce, null);
		return db;
	}
	private void chiudiConnessione(ConnectionPool cp, Connection db){
		if (cp != null) {
			if (db != null) {
				cp.free(db, null);
			}
		}
	}
	
	public static String getTagValue(String xml, String tagName){
		String esito = "";
	    try {esito =  xml.split("<"+tagName+">")[1].split("</"+tagName+">")[0]; } catch (Exception e) {}
	    return esito;
	}

}