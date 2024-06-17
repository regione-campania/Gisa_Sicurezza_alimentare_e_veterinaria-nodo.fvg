package org.aspcfs.modules.registrotrasgressori.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.logging.Logger;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.controller.MiddleServlet;
import org.aspcfs.controller.SecurityHook;
import org.aspcfs.controller.SessionManager;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.controller.UserSession;
import org.aspcfs.modules.admin.base.Role;
import org.aspcfs.modules.admin.base.Suap;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.admin.base.UserOperation;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.login.beans.LoginBean;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.login.utils.CheckLock;
import org.aspcfs.modules.registrotrasgressori.base.Pagamento;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.aspcfs.modules.system.base.Site;
import org.aspcfs.modules.system.base.SiteList;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.FileAesKeyException;
import org.aspcfs.utils.LDAPUtils;
import org.json.JSONObject;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;
import com.darkhorseventures.framework.hooks.CustomHook;

import ext.aspcfs.modules.apiari.base.DelegaList;
import ext.aspcfs.modules.apiari.base.SoggettoFisico;

/**
 * Servlet implementation class ReloadUtenti
 */
public class ControllaPagamentoPagoPA extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControllaPagamentoPagoPA() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;

		String IUV = request.getParameter("IUV");

		Pagamento p = new Pagamento();
		JSONObject jsonFinale = new JSONObject();

		try {
			ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
			String ceHost = prefs.get("GATEKEEPER.URL");
			String ceUser = prefs.get("GATEKEEPER.USER");
			String ceUserPw = prefs.get("GATEKEEPER.PASSWORD"); 

			ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
			cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");
			db = cp.getConnection(ce, null);

			p = new Pagamento(db, IUV);
			
			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaPagamentoPagoPA] ["+IUV+"] Inizio verifica stato pagamento.");

			if (p.getId()>0) {

				try {
					
					p.chiediPagati(db, false, -1);
					
					if (Pagamento.PAGAMENTO_COMPLETATO.equals(p.getStatoPagamento()) && (p.getHeaderFileRicevuta()==null || p.getHeaderFileRicevuta().equals(""))){
						PagoPaUtil.generaPdfRicevuta(null, request, response, db, p.getIdSanzione(), p.getId());
					}

					jsonFinale.put("Esito operazione", "OK");       
					jsonFinale.put("IUV", p.getIdentificativoUnivocoVersamento());
					jsonFinale.put("Stato pagamento", p.getStatoPagamento());
					jsonFinale.put("Data pagamento", p.getRicevuta().getDataEsitoSingoloPagamento());
					jsonFinale.put("Denominazione attestante", p.getRicevuta().getDenominazioneAttestante());
					jsonFinale.put("Denominazione beneficiario", p.getRicevuta().getDenominazioneBeneficiario());
					jsonFinale.put("Importo pagato", p.getRicevuta().getSingoloImportoPagato());
				
				} catch (Exception e) {
					
					jsonFinale.put("Esito operazione", "KO");       
					jsonFinale.put("IUV", IUV);
					jsonFinale.put("Errore", "Errore nella cooperazione applicativa.");
					
				}

			} else {

				jsonFinale.put("Esito operazione", "KO");       
				jsonFinale.put("IUV", IUV);
				jsonFinale.put("Errore", "IUV non presente in banca dati");

			}

			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db,  p.getIdSanzione(), p.getId(), "", "", "[ControllaPagamentoPagoPA] ["+IUV+"] Fine verifica stato pagamento. Esito: "+jsonFinale.toString());

		} catch (Exception e) {
			logger.severe("[ControllaPagamentoPagoPA] Si e' verificata un'eccezione nel controllo dei pagamenti.");
			e.printStackTrace();

			jsonFinale.put("Esito operazione", "KO");       
			jsonFinale.put("Errore", e.getMessage());

		} finally {
			if (cp != null) {
				if (db != null) {
					cp.free(db, null);
				}
			}

			response.reset();
			response.setContentType("Application/JSON");
			response.getWriter().write(jsonFinale.toString());

		}
	}

	
}