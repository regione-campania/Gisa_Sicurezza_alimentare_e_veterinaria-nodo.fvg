package org.aspcfs.modules.registrocaricoscarico.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.registrocaricoscarico.base.Giacenza;
import org.aspcfs.modules.registrocaricoscarico.base.recapiti.CaricoRecapiti;
import org.aspcfs.modules.registrocaricoscarico.base.recapiti.RegistroRecapiti;
import org.aspcfs.modules.registrocaricoscarico.base.recapiti.ScaricoRecapiti;
import org.aspcfs.modules.registrocaricoscarico.base.seme.CaricoSeme;
import org.aspcfs.modules.registrocaricoscarico.base.seme.RegistroSeme;
import org.aspcfs.modules.registrocaricoscarico.base.seme.ScaricoSeme;
import org.aspcfs.modules.registrocaricoscarico.util.RegistroUtil;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;

public class GestioneRegistroCaricoScarico extends CFSModule{

	public String executeCommandScelta(ActionContext context) {
		if (!hasPermission(context, "registro_carico_scarico-view")) {
		return ("PermissionError");
	}

	int riferimentoId = -1;
	String riferimentoIdNomeTab = null;

	String numRegistrazioneStab = null;
	String ragioneSociale = null;
	int idTipologiaRegistro = -1;
	
	try {riferimentoId = Integer.parseInt(context.getRequest().getParameter("riferimentoId")); } catch (Exception e) {} 
	try {riferimentoIdNomeTab = context.getRequest().getParameter("riferimentoIdNomeTab"); } catch (Exception e) {} 

	Connection db = null;
	try {
		db = this.getConnection(context);
		
		String info[] = RegistroUtil.getInfoRegistroAnagrafica(db, riferimentoId, riferimentoIdNomeTab, -1);
		
		try {
			numRegistrazioneStab = info[0]; 
			ragioneSociale = info[4];
			idTipologiaRegistro = Integer.parseInt(info[1]);
		} catch (Exception e) {}

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return ("SystemError");
	}
	finally
	{
		this.freeConnection(context, db);
	}

	context.getRequest().setAttribute("NumRegistrazioneStab", numRegistrazioneStab);
	context.getRequest().setAttribute("RagioneSociale", ragioneSociale);
	context.getRequest().setAttribute("riferimentoId", String.valueOf(riferimentoId));
	context.getRequest().setAttribute("riferimentoIdNomeTab", riferimentoIdNomeTab);
	context.getRequest().setAttribute("idTipologiaRegistro", String.valueOf(idTipologiaRegistro));

	
	if (idTipologiaRegistro == -1){
		return "ViewSceltaOK";
	}
	else 
		return executeCommandView(context);

}
	
	public String executeCommandView(ActionContext context) {

		int riferimentoId = -1;
		String riferimentoIdNomeTab = null;
		String ret = null;

		String numRegistrazioneStab = null;
		String ragioneSociale = null;
		int idTipologiaRegistro = -1;
		
		int idRegistro = -1;
		
		try {riferimentoId = Integer.parseInt(context.getRequest().getParameter("riferimentoId")); } catch (Exception e) {} 
		if (riferimentoId == -1)
			try {riferimentoId = Integer.parseInt((String)context.getRequest().getAttribute("riferimentoId")); } catch (Exception e) {} 
		
		try {riferimentoIdNomeTab = context.getRequest().getParameter("riferimentoIdNomeTab"); } catch (Exception e) {} 
		if (riferimentoIdNomeTab == null)
			try {riferimentoIdNomeTab = (String)context.getRequest().getAttribute("riferimentoIdNomeTab"); } catch (Exception e) {} 

		try {idTipologiaRegistro = Integer.parseInt(context.getRequest().getParameter("idTipologiaRegistro")); } catch (Exception e) {} 
		if (idTipologiaRegistro == -1)
			try {idTipologiaRegistro = Integer.parseInt((String)context.getRequest().getAttribute("idTipologiaRegistro")); } catch (Exception e) {} 
		
		try {idRegistro = Integer.parseInt(context.getRequest().getParameter("idRegistro")); } catch (Exception e) {} 
		if (idRegistro == -1)
			try {idRegistro = Integer.parseInt((String)context.getRequest().getAttribute("idRegistro")); } catch (Exception e) {} 
		
		try {ragioneSociale = context.getRequest().getParameter("ragioneSociale"); } catch (Exception e) {} 
		if (ragioneSociale == null)
			try {ragioneSociale = (String)context.getRequest().getAttribute("ragioneSociale"); } catch (Exception e) {} 
		
		try {numRegistrazioneStab = context.getRequest().getParameter("NumRegistrazioneStab"); } catch (Exception e) {} 
		if (numRegistrazioneStab == null)
			try {numRegistrazioneStab = (String)context.getRequest().getAttribute("NumRegistrazioneStab"); } catch (Exception e) {} 
		
		Connection db = null;
		try {
			db = this.getConnection(context);
			
			String info[] = null;
			
			if (idRegistro > 0)
				info = RegistroUtil.getInfoRegistro(db, idRegistro);
			else
				info = RegistroUtil.getInfoRegistroAnagrafica(db, riferimentoId, riferimentoIdNomeTab, idTipologiaRegistro);
			
			try {
				numRegistrazioneStab = info[0]; 
				idTipologiaRegistro = Integer.parseInt(info[1]);
				riferimentoId = Integer.parseInt(info[2]);
				riferimentoIdNomeTab = info[3];
				ragioneSociale = info[4];
				
			} catch (Exception e) {}
			
		if ((idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_seme-view")) || (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_recapiti-view"))) {
			return ("PermissionError");
		}
		
			if (idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA) { //REGISTRO SEME
				RegistroSeme registro = new RegistroSeme(db, numRegistrazioneStab);
				context.getRequest().setAttribute("Registro", registro);
				ret = "ViewSemeOK";
			}
			else if (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA) { //REGISTRO RECAPITI
				RegistroRecapiti registro = new RegistroRecapiti(db, numRegistrazioneStab);
				context.getRequest().setAttribute("Registro", registro);
				ret = "ViewRecapitiOK";
			}
			
			caricaLookup(db, context);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("NumRegistrazioneStab", numRegistrazioneStab);
		context.getRequest().setAttribute("RagioneSociale", ragioneSociale);
		context.getRequest().setAttribute("riferimentoId", String.valueOf(riferimentoId));
		context.getRequest().setAttribute("riferimentoIdNomeTab", riferimentoIdNomeTab);
		context.getRequest().setAttribute("idTipologiaRegistro", String.valueOf(idTipologiaRegistro));
		
		return ret;
	}

	
	private void caricaLookup(Connection db, ActionContext context) throws SQLException{
		
		LookupList TipiSpecie = new LookupList(db, "lookup_codici_specie_centri_riproduzione");
		TipiSpecie.addItem(-1, "-- SELEZIONA VOCE --");
		context.getRequest().setAttribute("TipiSpecie", TipiSpecie);
		
		LookupList TipiRazzaBovini = new LookupList(db, "lookup_razze_bovini_centri_riproduzione");
		TipiRazzaBovini.addItem(-1, "-- SELEZIONA VOCE --");
		context.getRequest().setAttribute("TipiRazzaBovini", TipiRazzaBovini);
		
		LookupList TipiRazzaSuini = new LookupList(db, "lookup_razze_suini_centri_riproduzione");
		TipiRazzaSuini.addItem(-1, "-- SELEZIONA VOCE --");
		context.getRequest().setAttribute("TipiRazzaSuini", TipiRazzaSuini);
		
		LookupList TipiRazzaEquini = new LookupList(db, "lookup_razze_equini_centri_riproduzione");
		TipiRazzaEquini.addItem(-1, "-- SELEZIONA VOCE --");
		context.getRequest().setAttribute("TipiRazzaEquini", TipiRazzaEquini);
		
		LookupList TipiRazzaAsini = new LookupList(db, "lookup_razze_asini_centri_riproduzione");
		TipiRazzaAsini.addItem(-1, "-- SELEZIONA VOCE --");
		context.getRequest().setAttribute("TipiRazzaAsini", TipiRazzaAsini);
		
		LookupList TipiSeme = new LookupList(db, "lookup_tipo_seme_embrioni");
		TipiSeme.addItem(-1, "-- SELEZIONA VOCE --");
		context.getRequest().setAttribute("TipiSeme", TipiSeme);
	}
	
	
	public String executeCommandAddModifyCarico(ActionContext context) {

		int idRegistro = -1;
		int idCarico = -1;
		int idTipologiaRegistro = -1;
		String numRegistrazioneStab = null;

		String messaggio = null;
		
		String ret = null;
		
		try {idRegistro = Integer.parseInt(context.getRequest().getParameter("idRegistro")); } catch (Exception e) {} 
		if (idRegistro == -1)
			try {idRegistro = Integer.parseInt((String)context.getRequest().getAttribute("idRegistro")); } catch (Exception e) {} 
		
		try {idCarico = Integer.parseInt(context.getRequest().getParameter("idCarico")); } catch (Exception e) {} 
		if (idCarico == -1)
			try {idCarico = Integer.parseInt((String)context.getRequest().getAttribute("idCarico")); } catch (Exception e) {}  

		try {idTipologiaRegistro = Integer.parseInt(context.getRequest().getParameter("idTipologiaRegistro")); } catch (Exception e) {} 
		if (idTipologiaRegistro == -1)
			try {idTipologiaRegistro = Integer.parseInt((String)context.getRequest().getAttribute("idTipologiaRegistro")); } catch (Exception e) {} 

		try {numRegistrazioneStab = context.getRequest().getParameter("numRegistrazioneStab"); } catch (Exception e) {} 
		if (numRegistrazioneStab == null)
			try {numRegistrazioneStab = (String)context.getRequest().getAttribute("numRegistrazioneStab"); } catch (Exception e) {} 

		try {messaggio = (String)context.getRequest().getAttribute("messaggio"); } catch (Exception e) {} 

		if ((idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_seme-add")) || (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_recapiti-add"))) {
			return ("PermissionError");
		}
		
		Connection db = null;
		try {
			db = this.getConnection(context);

			if (idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA) { //REGISTRO SEME
				RegistroSeme registro = new RegistroSeme(db, idRegistro);
				
				if (registro.getNumRegistrazioneStab()==null)
					registro.setNumRegistrazioneStab(numRegistrazioneStab);
				
				context.getRequest().setAttribute("Registro", registro);
				
				if (idCarico > 0){
					CaricoSeme carico = new CaricoSeme(db, idCarico);
					context.getRequest().setAttribute("Carico", carico);
				}
				
				ret = "AddModifyCaricoSemeOK";
			}
			else if (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA) { //REGISTRO RECAPITI
				RegistroRecapiti registro = new RegistroRecapiti(db, idRegistro);
				
				if (registro.getNumRegistrazioneStab()==null)
					registro.setNumRegistrazioneStab(numRegistrazioneStab);
				
				context.getRequest().setAttribute("Registro", registro);
				
				if (idCarico > 0){
					CaricoRecapiti carico = new CaricoRecapiti(db, idCarico);
					context.getRequest().setAttribute("Carico", carico);
				}
				
				ret = "AddModifyCaricoRecapitiOK";
			}
			
			caricaLookup(db, context);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("Messaggio", messaggio);

		return ret;
	}
	
	public String executeCommandUpsertCarico(ActionContext context) {

		int idRegistro = -1;
		int idCarico = -1;
		int idTipologiaRegistro = -1;
		String numRegistrazioneStab = null;

		try {idRegistro = Integer.parseInt(context.getRequest().getParameter("idRegistro")); } catch (Exception e) {} 
		try {idCarico = Integer.parseInt(context.getRequest().getParameter("idCarico")); } catch (Exception e) {} 
		try {numRegistrazioneStab = context.getRequest().getParameter("numRegistrazioneStab"); } catch (Exception e) {} 
		try {idTipologiaRegistro = Integer.parseInt(context.getRequest().getParameter("idTipologiaRegistro")); } catch (Exception e) {} 
				
		if ((idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_seme-add")) || (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_recapiti-add"))) {
			return ("PermissionError");
		}
		Connection db = null;
		try {
			db = this.getConnection(context);

			if (idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA) { //REGISTRO SEME
				CaricoSeme carico = new CaricoSeme(context);
				carico.upsert(db, numRegistrazioneStab, getUserId(context));
				
				CaricoSeme carico2 = new CaricoSeme(db, carico.getId());
				idRegistro = carico2.getIdRegistro();
				
				context.getRequest().setAttribute("idTipologiaRegistro", String.valueOf(idTipologiaRegistro));
				context.getRequest().setAttribute("idCarico", String.valueOf(carico.getId()));
				context.getRequest().setAttribute("messaggio", carico.getId()>0 ? "Operazione eseguita correttamente. Dati salvati." : "Si e' verificato un errore. L'operazione non e' stata eseguita.");

			}
			else if (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA) { //REGISTRO RECAPITO
				CaricoRecapiti carico = new CaricoRecapiti(context);
				carico.upsert(db, numRegistrazioneStab, getUserId(context));
				
				CaricoRecapiti carico2 = new CaricoRecapiti(db, carico.getId());
				idRegistro = carico2.getIdRegistro();
				
				context.getRequest().setAttribute("idTipologiaRegistro", String.valueOf(idTipologiaRegistro));
				context.getRequest().setAttribute("idCarico", String.valueOf(carico.getId()));
				context.getRequest().setAttribute("messaggio", carico.getId()>0 ? "Operazione eseguita correttamente. Dati salvati." : "Si e' verificato un errore. L'operazione non e' stata eseguita.");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idRegistro", String.valueOf(idRegistro));
	
		return executeCommandAddModifyCarico(context);
	}
	
	public String executeCommandAddModifyScarico(ActionContext context) {
		
		int idCarico = -1;
		int idScarico = -1;
		int idTipologiaRegistro = -1;

		String messaggio = null;
		
		String ret = null;
		
		try {idCarico = Integer.parseInt(context.getRequest().getParameter("idCarico")); } catch (Exception e) {} 
		if (idCarico == -1)
			try {idCarico = Integer.parseInt((String)context.getRequest().getAttribute("idCarico")); } catch (Exception e) {}  

		try {idScarico = Integer.parseInt(context.getRequest().getParameter("idScarico")); } catch (Exception e) {} 
		if (idScarico == -1)
			try {idScarico = Integer.parseInt((String)context.getRequest().getAttribute("idScarico")); } catch (Exception e) {} 
		
		try {idTipologiaRegistro = Integer.parseInt(context.getRequest().getParameter("idTipologiaRegistro")); } catch (Exception e) {} 
		if (idTipologiaRegistro == -1)
			try {idTipologiaRegistro = Integer.parseInt((String)context.getRequest().getAttribute("idTipologiaRegistro")); } catch (Exception e) {} 

		try {messaggio = (String)context.getRequest().getAttribute("messaggio"); } catch (Exception e) {} 

		if ((idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_seme-add")) || (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_recapiti-add"))) {
			return ("PermissionError");
		}
		
		Connection db = null;
		try {
			db = this.getConnection(context);

			if (idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA) { //REGISTRO SEME
				CaricoSeme carico = new CaricoSeme(db, idCarico);
				context.getRequest().setAttribute("Carico", carico);
				
				if (idScarico > 0){
					ScaricoSeme scarico = new ScaricoSeme(db, idScarico);
					context.getRequest().setAttribute("Scarico", scarico);
				}
				
				ret = "AddModifyScaricoSemeOK";
			}
			else if (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA) { //REGISTRO RECAPITO
				CaricoRecapiti carico = new CaricoRecapiti(db, idCarico);
				context.getRequest().setAttribute("Carico", carico);
				
				if (idScarico > 0){
					ScaricoRecapiti scarico = new ScaricoRecapiti(db, idScarico);
					context.getRequest().setAttribute("Scarico", scarico);
				}
				
				ret = "AddModifyScaricoRecapitiOK";
			}
			
			caricaLookup(db, context);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("Messaggio", messaggio);

		return ret;
		
		
	}
	
	public String executeCommandUpsertScarico(ActionContext context) {

		int idScarico = -1;
		int idCarico = -1;
		int idTipologiaRegistro = -1;

		try {idCarico = Integer.parseInt(context.getRequest().getParameter("idCarico")); } catch (Exception e) {} 
		try {idScarico = Integer.parseInt(context.getRequest().getParameter("idScarico")); } catch (Exception e) {} 
		try {idTipologiaRegistro = Integer.parseInt(context.getRequest().getParameter("idTipologiaRegistro")); } catch (Exception e) {} 
				
		if ((idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_seme-add")) || (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_recapiti-add"))) {
			return ("PermissionError");
		}
		Connection db = null;
		try {
			db = this.getConnection(context);

			if (idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA) { //REGISTRO SEME
				
				CaricoSeme carico = new CaricoSeme(db, idCarico);
				
				ScaricoSeme scarico = new ScaricoSeme(context);
				scarico.upsert(db, getUserId(context));
				
				context.getRequest().setAttribute("idTipologiaRegistro", String.valueOf(idTipologiaRegistro));
				context.getRequest().setAttribute("idCarico", String.valueOf(carico.getId()));
				context.getRequest().setAttribute("messaggio", carico.getId()>0 ? "Operazione eseguita correttamente. Dati salvati." : "Si e' verificato un errore. L'operazione non e' stata eseguita.");

			}
			else if (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA) { //REGISTRO RECAPITO
				
				CaricoRecapiti carico = new CaricoRecapiti(db, idCarico);
				
				ScaricoRecapiti scarico = new ScaricoRecapiti(context);
				scarico.upsert(db, getUserId(context));
				
				context.getRequest().setAttribute("idTipologiaRegistro", String.valueOf(idTipologiaRegistro));
				context.getRequest().setAttribute("idCarico", String.valueOf(carico.getId()));
				context.getRequest().setAttribute("messaggio", carico.getId()>0 ? "Operazione eseguita correttamente. Dati salvati." : "Si e' verificato un errore. L'operazione non e' stata eseguita.");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}
	
		return executeCommandAddModifyScarico(context);
	}
	
	public String executeCommandDeleteCarico(ActionContext context) {

		int idRegistro = -1;
		int idCarico = -1;
		int idTipologiaRegistro = -1;

		try {idCarico = Integer.parseInt(context.getRequest().getParameter("idCarico")); } catch (Exception e) {} 
		try {idTipologiaRegistro = Integer.parseInt(context.getRequest().getParameter("idTipologiaRegistro")); } catch (Exception e) {} 
				
		if ((idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_seme-add")) || (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_recapiti-add"))) {
			return ("PermissionError");
		}
		Connection db = null;
		try {
			db = this.getConnection(context);

			if (idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA) { //REGISTRO SEME
				CaricoSeme carico = new CaricoSeme(db, idCarico);
				idRegistro = carico.getIdRegistro();
				carico.delete(db, getUserId(context));
				context.getRequest().setAttribute("messaggio", carico.getId()>0 ? "Operazione eseguita correttamente. Dati elimninati." : "Si e' verificato un errore. L'operazione non e' stata eseguita.");

			}
			else if (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA) { //REGISTRO RECAPITO
				CaricoRecapiti carico = new CaricoRecapiti(db, idCarico);
				idRegistro = carico.getIdRegistro();
				carico.delete(db, getUserId(context));
				
				context.getRequest().setAttribute("messaggio", carico.getId()>0 ? "Operazione eseguita correttamente. Dati eliminati." : "Si e' verificato un errore. L'operazione non e' stata eseguita.");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idRegistro", String.valueOf(idRegistro));
		context.getRequest().setAttribute("idTipologiaRegistro", String.valueOf(idTipologiaRegistro));
		
		return executeCommandView(context);
	}
	
	public String executeCommandDeleteScarico(ActionContext context) {

		int idRegistro = -1;
		int idCarico = -1;
		int idScarico = -1;
		int idTipologiaRegistro = -1;

		try {idScarico = Integer.parseInt(context.getRequest().getParameter("idScarico")); } catch (Exception e) {} 
		try {idTipologiaRegistro = Integer.parseInt(context.getRequest().getParameter("idTipologiaRegistro")); } catch (Exception e) {} 
				
		if ((idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_seme-add")) || (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_recapiti-add"))) {
			return ("PermissionError");
		}
		Connection db = null;
		try {
			db = this.getConnection(context);

			if (idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA) { //REGISTRO SEME
				ScaricoSeme scarico = new ScaricoSeme(db, idScarico);
				CaricoSeme carico = new CaricoSeme(db, scarico.getIdCarico());
				idRegistro = carico.getIdRegistro();
				scarico.delete(db, getUserId(context));
				context.getRequest().setAttribute("messaggio", carico.getId()>0 ? "Operazione eseguita correttamente. Dati eliminati." : "Si e' verificato un errore. L'operazione non e' stata eseguita.");

			}
			else if (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA) { //REGISTRO RECAPITO
				ScaricoRecapiti scarico = new ScaricoRecapiti(db, idScarico);
				CaricoRecapiti carico = new CaricoRecapiti(db, scarico.getIdCarico());
				idRegistro = carico.getIdRegistro();
				scarico.delete(db, getUserId(context));
				context.getRequest().setAttribute("messaggio", carico.getId()>0 ? "Operazione eseguita correttamente. Dati eliminati." : "Si e' verificato un errore. L'operazione non e' stata eseguita.");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idRegistro", String.valueOf(idRegistro));
		context.getRequest().setAttribute("idTipologiaRegistro", String.valueOf(idTipologiaRegistro));
		
		return executeCommandView(context);
	}
	
	public String executeCommandGiacenza(ActionContext context) {

		int idRegistro = -1;
		int idTipologiaRegistro = -1;
		
		String ragioneSociale = null;
		String numRegistrazioneStab = null;
		
		String ret = null;
	
		try {idRegistro = Integer.parseInt(context.getRequest().getParameter("idRegistro")); } catch (Exception e) {} 
		if (idRegistro == -1)
			try {idRegistro = Integer.parseInt((String)context.getRequest().getAttribute("idRegistro")); } catch (Exception e) {} 
		
		try {idTipologiaRegistro = Integer.parseInt(context.getRequest().getParameter("idTipologiaRegistro")); } catch (Exception e) {} 
		if (idTipologiaRegistro == -1)
			try {idTipologiaRegistro = Integer.parseInt((String)context.getRequest().getAttribute("idTipologiaRegistro")); } catch (Exception e) {} 

		
		if ((idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_seme-add")) || (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA && !hasPermission(context, "registro_carico_scarico_recapiti-add"))) {
			return ("PermissionError");
		}
		
		Connection db = null;
		try {
			db = this.getConnection(context);
			
			String info[] = RegistroUtil.getInfoRegistro(db, idRegistro);
			
			try {
				numRegistrazioneStab = info[0]; 
				ragioneSociale = info[4];
			} catch (Exception e) {}

			if (idTipologiaRegistro == RegistroSeme.ID_TIPOLOGIA) { //REGISTRO SEME
				RegistroSeme registro = new RegistroSeme(db, idRegistro);
				ArrayList<Giacenza> listaGiacenza = registro.getGiacenza(db);
				context.getRequest().setAttribute("ListaGiacenza", listaGiacenza);
				ret = "ViewGiacenzaSemeOK";
			}
			else if (idTipologiaRegistro == RegistroRecapiti.ID_TIPOLOGIA) { //REGISTRO RECAPITI
				RegistroRecapiti registro = new RegistroRecapiti(db, idRegistro);
				ArrayList<Giacenza> listaGiacenza = registro.getGiacenza(db);
				context.getRequest().setAttribute("ListaGiacenza", listaGiacenza);
				ret = "ViewGiacenzaRecapitiOK";
			}
			
			caricaLookup(db, context);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("NumRegistrazioneStab", numRegistrazioneStab);
		context.getRequest().setAttribute("RagioneSociale", ragioneSociale);

		return ret;
	}
}
