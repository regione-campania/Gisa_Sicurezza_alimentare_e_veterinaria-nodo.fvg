package org.aspcfs.modules.registrazioniAnimali.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.modules.anagrafe_animali.base.Cane;
import org.aspcfs.modules.anagrafe_animali.base.Furetto;
import org.aspcfs.modules.anagrafe_animali.base.Gatto;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.opu.base.ComuniAnagrafica;
import org.aspcfs.modules.opu.base.LineaProduttiva;
import org.aspcfs.modules.opu.base.Operatore;
import org.aspcfs.modules.registrazioniAnimali.base.SchedaDecessoList;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.PagedListInfo;

import com.darkhorseventures.framework.actions.ActionContext;

public class SchedaDecesso extends CFSModule 
{

	
	public String executeCommandDefault(ActionContext context) 
	{
		
		if (hasPermission(context, "scheda_decesso-insert")) 
			return executeCommandAdd(context);
		else
			return executeCommandList(context);
	}
	
	
	
	
	
	
	public String executeCommandList(ActionContext context) 
	{

	if (!hasPermission(context, "scheda_decesso-view") && !hasPermission(context, "anag_scheda_decesso-view")) 
		return ("PermissionError");
	
	Connection db = null;
	
	UserBean user = (UserBean) context.getSession().getAttribute("User");
	
	try 
	{
		db = this.getConnection(context);
		
		int idAnimale = -1;
		int idUtente = -1;
		String idAnimaleString = (String) context.getRequest().getParameter("idAnimale");
		if(idAnimaleString!=null && !idAnimaleString.equals("") && !idAnimaleString.equals("-1"))
			idAnimale = Integer.parseInt(idAnimaleString);
		if(user.getUserRecord().getRoleId()==24)
			idUtente = user.getUserId();
		
		int idAsl = -1;
		if(user.getUserRecord().getRoleId()!=24 && user.getUserRecord().getRoleId()!=5 && user.getUserRecord().getRoleId()!=6)
			idAsl = user.getSiteId();
		
		
		
		
		SchedaDecessoList schede = new SchedaDecessoList();

		PagedListInfo schedadecessoListInfo = this.getPagedListInfo(context, "schedadecessoListInfo");
		schedadecessoListInfo.setLink("SchedaDecesso.do?command=List&idAnimale=" + idAnimale);
		org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso();
		scheda.setPagedListInfo(schedadecessoListInfo);
		schede = scheda.getSchede(db, idAnimale, idUtente,idAsl);
		context.getRequest().setAttribute("schede",schede);
		
		LookupList causeDecessoList = new LookupList(db, "lookup_scheda_decesso_causa");
		causeDecessoList.addItem(-1, "<-- Selezionare una voce -->");
		context.getRequest().setAttribute("causeDecessoList", causeDecessoList);
		
		LookupList neoplasieList = new LookupList(db, "lookup_scheda_decesso_neoplasia");
		neoplasieList.addItem(-1, "<-- Selezionare una voce -->");
		context.getRequest().setAttribute("neoplasieList", neoplasieList);
	 }
	 catch (SQLException e) 
	 {
		 e.printStackTrace();
	 } 
	 finally 
	 {
		 this.freeConnection(context, db);
	 }
     return "ListOK";
	}
	
	
	public String executeCommandSearch(ActionContext context) 
	{

	if (!hasPermission(context, "scheda_decesso-view") && !hasPermission(context, "anag_scheda_decesso-view")) 
		return ("PermissionError");
	
	Connection db = null;
	
	UserBean user = (UserBean) context.getSession().getAttribute("User");
	
	try 
	{
		db = this.getConnection(context);
		
		int idAnimale = -1;
		int idUtente = -1;
		String idAnimaleString = (String) context.getRequest().getParameter("idAnimale");
		if(idAnimaleString!=null && !idAnimaleString.equals("") && !idAnimaleString.equals("-1"))
			idAnimale = Integer.parseInt(idAnimaleString);
		if(user.getUserRecord().getRoleId()==24)
			idUtente = user.getUserId();
		
		int idAsl = -1;
		if(user.getUserRecord().getRoleId()!=24 && user.getUserRecord().getRoleId()!=5 && user.getUserRecord().getRoleId()!=6)
			idAsl = user.getSiteId();
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		String microchip = null;
		Timestamp dataDa = null;
		Timestamp dataA = null;
		Boolean flagDecesso = null;
		if(context.getRequest().getParameter("microchip")!=null && !context.getRequest().getParameter("microchip").equals(""))
			microchip=context.getRequest().getParameter("microchip");
		if(context.getRequest().getParameter("flagDecesso")!=null && !context.getRequest().getParameter("flagDecesso").equals(""))
			flagDecesso=Boolean.parseBoolean(context.getRequest().getParameter("flagDecesso"));
		if(context.getRequest().getParameter("dataDa")!=null && !context.getRequest().getParameter("dataDa").equals(""))
			dataDa= new Timestamp(sdf.parse(context.getRequest().getParameter("dataDa")).getTime() );
		if(context.getRequest().getParameter("dataA")!=null && !context.getRequest().getParameter("dataA").equals(""))
			dataA= new Timestamp(sdf.parse(context.getRequest().getParameter("dataA")).getTime() ) ;
		
		SchedaDecessoList schede = new SchedaDecessoList();

		PagedListInfo schedadecessoListInfo = this.getPagedListInfo(context, "schedadecessoListInfo");
		schedadecessoListInfo.setLink("SchedaDecesso.do?command=List&idAnimale=" + idAnimale);
		org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso();
		scheda.setPagedListInfo(schedadecessoListInfo);
		schede = scheda.getSchede(db, idAnimale, idUtente,idAsl,microchip,dataDa,dataA,flagDecesso);
		context.getRequest().setAttribute("schede",schede);
		
		LookupList causeDecessoList = new LookupList(db, "lookup_scheda_decesso_causa");
		causeDecessoList.addItem(-1, "<-- Selezionare una voce -->");
		context.getRequest().setAttribute("causeDecessoList", causeDecessoList);
		
		LookupList neoplasieList = new LookupList(db, "lookup_scheda_decesso_neoplasia");
		neoplasieList.addItem(-1, "<-- Selezionare una voce -->");
		context.getRequest().setAttribute("neoplasieList", neoplasieList);
	 }
	 catch (Exception e) 
	 {
		 e.printStackTrace();
	 } 
	 finally 
	 {
		 this.freeConnection(context, db);
	 }
     return "ListOK";
	}
	
	
	public String executeCommandSearchForm(ActionContext context) 
	{

	if (!hasPermission(context, "scheda_decesso-view") && !hasPermission(context, "anag_scheda_decesso-view")) 
		return ("PermissionError");
	
	Connection db = null;
	
	UserBean user = (UserBean) context.getSession().getAttribute("User");
	
	try 
	{
		db = this.getConnection(context);
		
		
	 }
	 catch (Exception e) 
	 {
		 e.printStackTrace();
	 } 
	 finally 
	 {
		 this.freeConnection(context, db);
	 }
     return "SearchFormOK";
	}
     
	public String executeCommandPrintSchedaDecesso(ActionContext context) {

		if (!hasPermission(context, "scheda_decesso-view") && !hasPermission(context, "anag_scheda_decesso-view")) 
		{
			return ("PermissionError");
		}

		Connection db = null;

		Cane thisCane = null;
		Gatto thisGatto = null;
		Furetto thisFuretto = null;
		int idAnimale = -1;
		int idSpecie = -1;

		try {
			ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
			db = this.getConnection(context);

			if ((String) context.getRequest().getParameter("isEmpty") == null) 
			{

				SystemStatus systemStatus = this.getSystemStatus(context);
				String idAnimaleString = (String) context.getRequest().getParameter("idAnimale");
				String idSpecieString = (String) context.getRequest().getParameter("idSpecie");

				if (idAnimaleString != null && !("").equals(idAnimaleString)) {
					idAnimale = new Integer(idAnimaleString).intValue();
				}

				if (idSpecieString != null && !("").equals(idSpecieString)) {
					idSpecie = new Integer(idSpecieString).intValue();
				}

				Animale thisAnimale = new Animale(db, idAnimale);
				context.getRequest().setAttribute("thisAnimale", thisAnimale);

				LookupList causeDecessoList = new LookupList(db, "lookup_scheda_decesso_causa");
				causeDecessoList.addItem(-1, "<-- Selezionare una voce -->");
				context.getRequest().setAttribute("causeDecessoList", causeDecessoList);
				
				LookupList neoplasieList = new LookupList(db, "lookup_scheda_decesso_neoplasia");
				neoplasieList.addItem(-1, "<-- Selezionare una voce -->");
				context.getRequest().setAttribute("neoplasieList", neoplasieList);
				
				LookupList diagnosiCitologiche = new LookupList(db, "lookup_diagnosi_citologica");
				diagnosiCitologiche.setJsEvent("onChange=\"javascript:attivaDiagnosiCitologicaIstologica();\"");
				context.getRequest().setAttribute("diagnosiCitologiche", diagnosiCitologiche);
				
				LookupList diagnosiIstologicheTumorali = new LookupList(db, "lookup_diagnosi_istologica");
				diagnosiIstologicheTumorali.addItem(-1, "<-- Selezionare una voce -->");
				context.getRequest().setAttribute("diagnosiIstologicheTumorali", diagnosiIstologicheTumorali);
				
				LookupList tipoDiagnosiIstologiche = new LookupList(db, "lookup_diagnosi_istologica_tipo",null);
				tipoDiagnosiIstologiche.addItem(-1, "<-- Selezionare tipo diagnosi -->");
				context.getRequest().setAttribute("tipoDiagnosiIstologiche", tipoDiagnosiIstologiche);
				
				org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso scheda = null;
				if(idAnimale>0)
					scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso().getByIdAnimale(db, idAnimale);

				context.getRequest().setAttribute("scheda", scheda);

				
				
				LineaProduttiva linea_proprietario = new LineaProduttiva(db, thisAnimale.getIdProprietario());
				LineaProduttiva linea_detentore = new LineaProduttiva(db, thisAnimale.getIdDetentore());
				context.getRequest().setAttribute("linea_proprietario", linea_proprietario);
				context.getRequest().setAttribute("linea_detentore", linea_detentore);

				Operatore proprietario = new Operatore();
				proprietario.queryRecordOperatorebyIdLineaProduttiva(db, thisAnimale.getIdProprietario());
				context.getRequest().setAttribute("proprietario", proprietario);

				Operatore detentore = new Operatore();
				detentore.queryRecordOperatorebyIdLineaProduttiva(db, thisAnimale.getIdDetentore());
				context.getRequest().setAttribute("detentore", detentore);

				LookupList specieList = new LookupList(db, "lookup_specie");
				specieList.addItem(-1, "--Tutti--");
				context.getRequest().setAttribute("specieList", specieList);

				LookupList razzaList = new LookupList();
				razzaList.setTable("lookup_razza");
				razzaList.setIdSpecie(idSpecie);
				razzaList.buildList(db);
				razzaList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
				// assetManufacturerList.remove(assetManufacturerList.get("N.D."));
				context.getRequest().setAttribute("razzaList", razzaList);

				LookupList tagliaList = new LookupList(db, "lookup_taglia");
				tagliaList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
				// assetManufacturerList.remove(assetManufacturerList.get("N.D."));
				context.getRequest().setAttribute("tagliaList", tagliaList);

				LookupList mantelloList = new LookupList(db, "lookup_mantello");
				mantelloList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
				// assetManufacturerList.remove(assetManufacturerList.get("N.D."));
				context.getRequest().setAttribute("mantelloList", mantelloList);

				ComuniAnagrafica c = new ComuniAnagrafica();
				// PER ORA PRENDO TUTTI I COMUNI E NON SOLO QUELLI RELATIVI
				// ALL'ASL
				// UTENTE
				ArrayList<ComuniAnagrafica> listaComuni = c.buildList(db, -1, 1);
				LookupList comuniList = new LookupList(listaComuni, -1);
				comuniList.addItem(-1, "");
				context.getRequest().setAttribute("comuniList", comuniList);
			}

			else {
				return getReturn(context, "viewCertificatoDecessoEmpty");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.freeConnection(context, db);
		}
		return getReturn(context, "viewCertificatoDecesso");

	}
     
     
	
	public String executeCommandAdd(ActionContext context) 
	{
		if (!hasPermission(context, "scheda_decesso-add") && !hasPermission(context, "anag_scheda_decesso-add")) 
				return ("PermissionError");

		Connection db = null;
		try 
		{
			db = this.getConnection(context);
			
			LookupList causeDecessoList = new LookupList(db, "lookup_scheda_decesso_causa");
			causeDecessoList.addItem(-1, "<-- Selezionare una voce -->");
			causeDecessoList.setJsEvent("onChange=\"attivaDiagnosiDiNeoplasia();\"");
			context.getRequest().setAttribute("causeDecessoList", causeDecessoList);
			
			LookupList neoplasieList = new LookupList(db, "lookup_scheda_decesso_neoplasia");
			neoplasieList.addItem(-1, "<-- Selezionare una voce -->");
			neoplasieList.setJsEvent("onChange=\"attivaTipoDiagnosiIstologica();\"");
			context.getRequest().setAttribute("neoplasieList", neoplasieList);
			
			LookupList diagnosiCitologiche = new LookupList(db, "lookup_diagnosi_citologica");
			diagnosiCitologiche.addItem(-1, "<-- Selezionare una voce -->");
			context.getRequest().setAttribute("diagnosiCitologiche", diagnosiCitologiche);
			
			LookupList diagnosiIstologicheTumorali = new LookupList(db, "lookup_diagnosi_istologica", null);
			diagnosiIstologicheTumorali.addItem(-1, "<-- Selezionare una voce -->");
			diagnosiIstologicheTumorali.setJsEvent("onChange=\"attivaDiagnosiIstologicaTumorale2Livello();\"");
			context.getRequest().setAttribute("diagnosiIstologicheTumorali", diagnosiIstologicheTumorali);
			
			LookupList tipoDiagnosiIstologiche = new LookupList(db, "lookup_diagnosi_istologica_tipo",null);
			tipoDiagnosiIstologiche.addItem(-1, "<-- Selezionare tipo diagnosi -->");
			tipoDiagnosiIstologiche.setJsEvent("onChange=\"attivaDiagnosiIstologicaTumorale();\"");
			context.getRequest().setAttribute("tipoDiagnosiIstologiche", tipoDiagnosiIstologiche);
			
			
		} 
		catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally 
		{
			this.freeConnection(context, db);
		}
		return getReturn(context, "Add");
	}
	
	
	
	public String executeCommandDetail(ActionContext context) 
	{
		if (!hasPermission(context, "scheda_decesso-view") && !hasPermission(context, "anag_scheda_decesso-view")) 
		{
			return ("PermissionError");
		}
		
		String fromRegistrazione = context.getRequest().getParameter("fromRegistrazione");
		context.getRequest().setAttribute("fromRegistrazione", fromRegistrazione);
		
		Connection db = null;
		try 
		{
			//Thread t = Thread.currentThread();
			db = this.getConnection(context);

			//Recupero parametri in input
			int idAnimale = -1;
			int id = -1;
			String idAnimaleString = (String) context.getRequest().getParameter("idAnimale");
			String idString = (String) context.getRequest().getParameter("id");
			if(idAnimaleString==null || idAnimaleString.equals("") || idAnimaleString.equals("-1"))
			{
				if(idString==null || idString.equals("") || idString.equals("-1"))
				{
					throw new Exception("Parametro idAnimale non trovato");
				}
				else
				{
					id = Integer.parseInt(idString);
				}
			}
			else
			{
				idAnimale = Integer.parseInt(idAnimaleString);
			}
			
			LookupList causeDecessoList = new LookupList(db, "lookup_scheda_decesso_causa");
			causeDecessoList.addItem(-1, "<-- Selezionare una voce -->");
			context.getRequest().setAttribute("causeDecessoList", causeDecessoList);
			
			LookupList neoplasieList = new LookupList(db, "lookup_scheda_decesso_neoplasia");
			neoplasieList.addItem(-1, "<-- Selezionare una voce -->");
			context.getRequest().setAttribute("neoplasieList", neoplasieList);
			
			LookupList diagnosiCitologiche = new LookupList(db, "lookup_diagnosi_citologica");
			diagnosiCitologiche.addItem(-1, "<-- Selezionare una voce -->");
			context.getRequest().setAttribute("diagnosiCitologiche", diagnosiCitologiche);
			
			LookupList diagnosiIstologicheTumorali = new LookupList(db, "lookup_diagnosi_istologica");
			diagnosiIstologicheTumorali.addItem(-1, "<-- Selezionare una voce -->");
			context.getRequest().setAttribute("diagnosiIstologicheTumorali", diagnosiIstologicheTumorali);
			
			LookupList tipoDiagnosiIstologiche = new LookupList(db, "lookup_diagnosi_istologica_tipo",null);
			tipoDiagnosiIstologiche.addItem(-1, "<-- Selezionare tipo diagnosi -->");
			context.getRequest().setAttribute("tipoDiagnosiIstologiche", tipoDiagnosiIstologiche);
			
			
			org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso scheda = null;
			if(idAnimale>0)
				scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso().getByIdAnimale(db, idAnimale);
			else if(id>0)
				scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso().getById(db, id);
			
			if(scheda!=null)
			{	
				context.getRequest().setAttribute("idAnimale", scheda.getAnimale().getIdAnimale());
				context.getRequest().setAttribute("animale", scheda.getAnimale());
				context.getRequest().setAttribute("id", scheda.getId());
			}
			else
			{
				context.getRequest().setAttribute("animaleId", idAnimale+"");
				context.getRequest().setAttribute("idSpecie", context.getRequest().getParameter("idSpecie"));
				context.getRequest().setAttribute("Error", "Nessuna scheda di decesso presente per questo animale");
				return "RedirectOK";
			}
			
			context.getRequest().setAttribute("scheda", scheda);
			
			LookupList specieList = new LookupList();
			specieList.setTable("lookup_specie");
			specieList.buildList(db);
			context.getRequest().setAttribute("specieList", specieList);

			LookupList razzaList = new LookupList();
			razzaList.setTable("lookup_razza");
			razzaList.buildList(db);
			context.getRequest().setAttribute("razzaList", razzaList);
			
			LookupList tagliaList = new LookupList(db, "lookup_taglia");
			context.getRequest().setAttribute("tagliaList", tagliaList);

			LookupList mantelloList = new LookupList();
			mantelloList.setTable("lookup_mantello");
			mantelloList.buildList(db);
			context.getRequest().setAttribute("mantelloList", mantelloList);
			
			
			return getReturn(context, "Detail");
				
		} 
		catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally 
		{
			this.freeConnection(context, db);
		}
	}
	
	public String executeCommandInsert(ActionContext context) 
	{
		if (!hasPermission(context, "scheda_decesso-add") && !hasPermission(context, "anag_scheda_decesso-add")) 
		{
			return ("PermissionError");
		}

		SystemStatus systemStatus = this.getSystemStatus(context);
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		Connection db = null;
		try 
		{
			//Thread t = Thread.currentThread();
			db = this.getConnection(context);
			
			int idAnimale = -1;
			String idAnimaleString = (String) context.getRequest().getParameter("idAnimale");
			if(idAnimaleString==null || idAnimaleString.equals("") || idAnimaleString.equals("-1"))
			{
				throw new Exception("Parametro idAnimale non trovato");
			}
			else
			{
				idAnimale = Integer.parseInt(idAnimaleString);
			}
			
			//Inserimento scheda
			org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso scheda = new org.aspcfs.modules.registrazioniAnimali.base.SchedaDecesso();
			scheda.setIdAnimale(idAnimale);
			scheda.setEnteredBy(user.getUserId());
			scheda.setModifiedBy(user.getUserId());
			scheda.setDataDecesso(context.getRequest().getParameter("dataDecesso"));
			scheda.setIdCausa(Integer.parseInt(context.getRequest().getParameter("idCausaDecesso")));
			if(context.getRequest().getParameter("idNeoplasia")!=null && !context.getRequest().getParameter("idNeoplasia").equals("") && !context.getRequest().getParameter("idNeoplasia").equals("-1"))
				scheda.setIdNeoplasia(Integer.parseInt(context.getRequest().getParameter("idNeoplasia")));
			scheda.setNoteNeoplasia(context.getRequest().getParameter("noteNeoplasia"));
			scheda.setNoteCausaDecesso(context.getRequest().getParameter("noteCausaDecesso"));
			if(context.getRequest().getParameter("idDiagnosiCitologica")!=null && !context.getRequest().getParameter("idDiagnosiCitologica").equals("") && !context.getRequest().getParameter("idDiagnosiCitologica").equals("-1"))
				scheda.setIdDiagnosiCitologica(Integer.parseInt(context.getRequest().getParameter("idDiagnosiCitologica")));
			if(context.getRequest().getParameter("dataEsitoIstologico")!=null && !context.getRequest().getParameter("dataEsitoIstologico").equals(""))
				scheda.setDataEsitoIstologico(context.getRequest().getParameter("dataEsitoIstologico"));
			if(context.getRequest().getParameter("descMorfologicaIstologico")!=null && !context.getRequest().getParameter("descMorfologicaIstologico").equals("") )
				scheda.setDescMorfologicaIstologico(context.getRequest().getParameter("descMorfologicaIstologico"));
			if(context.getRequest().getParameter("idTipoDiagnosiIstologica")!=null && !context.getRequest().getParameter("idTipoDiagnosiIstologica").equals("") && !context.getRequest().getParameter("idTipoDiagnosiIstologica").equals("-1"))
				scheda.setIdTipoDiagnosiIstologica(Integer.parseInt(context.getRequest().getParameter("idTipoDiagnosiIstologica")));
			if(context.getRequest().getParameter("noteDiagnosiIstologicaTumorali")!=null && !context.getRequest().getParameter("noteDiagnosiIstologicaTumorali").equals("") && !context.getRequest().getParameter("noteDiagnosiIstologicaTumorali").equals("-1"))
				scheda.setNoteDiagnosiIstologicaTumorali(context.getRequest().getParameter("noteDiagnosiIstologicaTumorali"));
			
			
			
			
			
			if(context.getRequest().getParameter("idDiagnosiIstologicaTumorali2livello")!=null && !context.getRequest().getParameter("idDiagnosiIstologicaTumorali2livello").equals("") && !context.getRequest().getParameter("idDiagnosiIstologicaTumorali2livello").equals("-1"))
				scheda.setIdDiagnosiIstologica(Integer.parseInt(context.getRequest().getParameter("idDiagnosiIstologicaTumorali2livello")));
			scheda.insert(db);
			
			
			return executeCommandDetail(context);

		} 
		catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally 
		{
			this.freeConnection(context, db);
		}
	}
	
	
	
	
	
}
