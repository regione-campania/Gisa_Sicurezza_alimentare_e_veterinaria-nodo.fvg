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

import org.apache.commons.lang.StringEscapeUtils;
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
public class AggiornaHeaderAvvisiPagoPA extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AggiornaHeaderAvvisiPagoPA() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("[AggiornaHeaderAvvisiPagoPA] Inizio procedura.");
		
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
		
		String iuv = request.getParameter("IUV");

		try {
			db = apriConnessione(request, cp, db, ce);
			
			String sql = "";
			
			if (iuv==null || iuv.equalsIgnoreCase(""))
				sql = "select * from pagopa_pagamenti where trashed_date is null and stato_pagamento <> 'PAGAMENTO COMPLETATO' and (header_file_avviso is null or header_file_avviso ='') and data_scadenza::timestamp without time zone > now() order by entered asc;";
			else
				sql ="select * from pagopa_pagamenti where trashed_date is null and identificativo_univoco_versamento = '"+iuv+"';";
			
			PreparedStatement pst = db.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Pagamento p = new Pagamento(db, rs.getInt("id"));
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
				
				if (p.getUrlFileAvviso() != null && !"".equals(p.getUrlFileAvviso())){
					try {
						String codDocumento = PagoPaUtil.inviaADocumentaleConRitorno("", StringEscapeUtils.unescapeHtml(p.getUrlFileAvviso()), "AvvisoPagoPA", ("AVVISO PAGO PA "+p.getIdSanzione()), p.getIdSanzione(), p.getId(), ("IUD: "+p.getIdentificativoUnivocoDovuto()+" IUV: "+p.getIdentificativoUnivocoVersamento()+ " PAGATORE: "+p.getPagatore().getId() + "/"+p.getPagatore().getPartitaIvaCodiceFiscale()+ " URL: "+p.getUrlFileAvviso()), -1);
						PreparedStatement pst = db.prepareStatement("update pagopa_pagamenti set header_file_avviso = ? where id = ?");
						pst.setString(1, codDocumento);
						pst.setInt(2, p.getId()); 
						pst.executeUpdate();
						p.setHeaderFileAvviso(codDocumento);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			
				JSONObject jsonAvviso = new JSONObject();
				jsonAvviso.put("Id sanzione", p.getIdSanzione());
				jsonAvviso.put("IUV", p.getIdentificativoUnivocoVersamento());
				jsonAvviso.put("urlFileAvviso", p.getUrlFileAvviso());
				jsonAvviso.put("headerFileAvviso", p.getHeaderFileAvviso());
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

		jsonFinale.put("Lista avvisi", jsonAvvisi);
		response.setContentType("Application/JSON");
		response.getWriter().write(jsonFinale.toString());

		System.out.println("[AggiornaHeaderAvvisiPagoPA] Fine procedura.");

	}

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

}