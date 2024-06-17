package org.aspcf.modules.controlliufficiali.action;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.dpat2019.base.DpatStrumentoCalcoloNominativi;
import org.aspcfs.modules.gestionecu.base.Componente;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.vigilanza.blocchicu.ApplicationProperties;
import org.aspcfs.utils.DwrNucleoIspettivo;
import org.aspcfs.utils.UrlUtil;

import com.darkhorseventures.framework.actions.ActionContext;

public class NucleoIspettivo extends CFSModule {
	
	public String executeCommandList(ActionContext context) {

		int resultCount = -1;
		ArrayList<DpatStrumentoCalcoloNominativi> listaToRet = new ArrayList<DpatStrumentoCalcoloNominativi>();
		Connection db = null;
		try {
			
			db = this.getConnection(context);
			int idQualifica = Integer.parseInt(context.getParameter("idRuolo"));
			int indiceComponente = Integer.parseInt(context.getParameter("indiceComponente"));
			
			
			DpatStrumentoCalcoloNominativi[] lista = DwrNucleoIspettivo.getcomponentiNucleoIspettivoRistrutturato(db,idQualifica, context.getParameter("idAsl"),this.getSystemStatus(context),context.getRequest());
			
			context.getRequest().setAttribute("IndiceComponente", indiceComponente);
			
				
			for (DpatStrumentoCalcoloNominativi nom : lista)
			{
				
				listaToRet.add(nom);
			}
			context.getRequest().setAttribute("ListaToReturn",listaToRet);  
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);

		}
		finally
		{
			super.freeConnection(context, db);
		}
		
		return "stampajson" ;
	}

	
	public String executeCommandAnagrafaComponenteNucleo(ActionContext context){
		
		int indice = Integer.parseInt(context.getRequest().getParameter("indice"));
		context.getRequest().setAttribute("indice",  String.valueOf(indice));
		
		int idQualifica = Integer.parseInt(context.getRequest().getParameter("idQualifica"));
		String nomeQualifica =context.getRequest().getParameter("nomeQualifica");
		context.getRequest().setAttribute("idQualifica",  String.valueOf(idQualifica));
		context.getRequest().setAttribute("nomeQualifica",  nomeQualifica);
		return "AnagrafaComponenteNucleoOK";
	}
	public String executeCommandInsertComponenteNucleo(ActionContext context){
		
		String nome = context.getRequest().getParameter("nome");
		String cognome = context.getRequest().getParameter("cognome");
		
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		int idUtente = 	user.getUserRecord().getId();
		
		int idQualifica =  Integer.parseInt(context.getRequest().getParameter("idQualifica"));
		int indice = Integer.parseInt(context.getRequest().getParameter("indice"));
	
		String sql = "";
		PreparedStatement pst = null;
		Connection db = null;
		int i = 0;
		
		try {
			db = this.getConnection(context);
			
			boolean gisaExt = false;
			String nomeRuolo = "";
			int origine = -1;
			
			PreparedStatement pstRuolo = db.prepareStatement("select * from get_role_gisa_or_ext("+idQualifica+")");
			ResultSet rsRuolo = pstRuolo.executeQuery();
			if (rsRuolo.next()){
			origine = rsRuolo.getInt("origine");
			nomeRuolo = rsRuolo.getString("nome");
			}
			
			if (origine==10)
				gisaExt = false;
			if (origine == 11)
				gisaExt = true;
			
		String outputInserimento = eseguiInserimentoUtenteNucleo(db, gisaExt, nome, cognome, idUtente, idQualifica, nomeRuolo);
		String[] result = outputInserimento.split(";;");
		
		String username = "";	
		String risultato = "";
		
		if (result.length>0){
			risultato = result[0];
			username = result[1];
		}
				
		context.getRequest().setAttribute("risultato", risultato);
		context.getRequest().setAttribute("indice",  String.valueOf(indice));
				
		String urlReloadUtenti = "http://srvGISAL"+ org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("APP_PORTA_GISA") + context.getRequest().getContextPath() + "/ReloadUtenti"; 
		String resp = ""; 
		System.out.println("******************[CHIAMO RELOAD UTENTI TOTALE] "+urlReloadUtenti+"*************");
		resp =UrlUtil.getUrlResponse(urlReloadUtenti);
		context.getRequest().setAttribute("respReloadUtente",  resp);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "SystemError";
		}
		return "InsertComponenteNucleoOK";
	}
	
	private String eseguiInserimentoUtenteNucleo(Connection db, boolean gisaExt, String nome, String cognome, int idUtente, int idQualifica, String nomeRuolo) throws SQLException{
		String result = "";
		PreparedStatement pst = db.prepareStatement("select * from anagrafa_componente_nucleo(?, ?, ?, ?, ?, ?)");
		int i = 0;
		pst.setBoolean(++i, gisaExt);
		pst.setString(++i, nome);
		pst.setString(++i, cognome);
		pst.setInt(++i, idQualifica);
		pst.setString(++i, nomeRuolo);
		pst.setInt(++i, idUtente);

		System.out.println("[INSERISCO UTENTE PER NUCLEO ISPETTIVO] "+pst.toString());
		ResultSet rs = pst.executeQuery();
		if (rs.next())
			result = rs.getString(1);
		return result;
	
		
	}
	
	public String executeCommandListAutoritaCompetenti(ActionContext context) {

		int resultCount = -1; 
		ArrayList<Componente> listaToRet = new ArrayList<Componente>();
		Connection db = null;
		try {
			
			db = this.getConnection(context);
			int idQualifica = Integer.parseInt(context.getParameter("idQualifica"));
			int idAsl = Integer.parseInt(context.getParameter("idAsl"));
			
			Calendar calCorrente = GregorianCalendar.getInstance();
			Date dataCorrente = new Date(System.currentTimeMillis());
			int tolleranzaGiorni = Integer.parseInt(ApplicationProperties.getProperty("TOLLERANZA_MODIFICA_CU"));
			dataCorrente.setDate(dataCorrente.getDate()- tolleranzaGiorni);
			calCorrente.setTime(new Timestamp(dataCorrente.getTime()));
			int anno = calCorrente.get(Calendar.YEAR);
			
			listaToRet = Componente.buildListAutoritaCompetenti(db, anno, idQualifica, idAsl);
			context.getRequest().setAttribute("ListaToReturn",listaToRet);  
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);

		}
		finally
		{
			super.freeConnection(context, db);
		}
		
		return "stampajson" ;
	}
	
	public String executeCommandListMacelli(ActionContext context) {

		int resultCount = -1; 
		ArrayList<Componente> listaToRet = new ArrayList<Componente>();
		Connection db = null;
		try {
			
			db = this.getConnection(context);
			int idQualifica = Integer.parseInt(context.getParameter("idQualifica"));
			int idAsl = Integer.parseInt(context.getParameter("idAsl"));
			
			Calendar calCorrente = GregorianCalendar.getInstance();
			Date dataCorrente = new Date(System.currentTimeMillis());
			int tolleranzaGiorni = Integer.parseInt(ApplicationProperties.getProperty("TOLLERANZA_MODIFICA_CU"));
			dataCorrente.setDate(dataCorrente.getDate()- tolleranzaGiorni);
			calCorrente.setTime(new Timestamp(dataCorrente.getTime()));
			int anno = calCorrente.get(Calendar.YEAR);
			
			listaToRet = Componente.buildListMacelli(db, anno, idQualifica, idAsl);
			context.getRequest().setAttribute("ListaToReturn",listaToRet);  
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);

		}
		finally
		{
			super.freeConnection(context, db);
		}
		
		return "stampajson" ;
	}
}
