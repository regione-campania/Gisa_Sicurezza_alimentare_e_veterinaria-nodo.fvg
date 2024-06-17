/*
 *  Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. DARK HORSE
 *  VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.sintesis.actions;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;

import org.aspcf.modules.report.util.Filtro;
import org.aspcf.modules.report.util.StampaPdf;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.campioni.actions.Campioni;
import org.aspcfs.modules.campioni.base.Ticket;
import org.aspcfs.modules.macellazionisintesis.base.CampioneNew;
import org.aspcfs.modules.sintesis.base.SintesisStabilimento;
import org.aspcfs.utils.DwrPreaccettazione;
import org.aspcfs.utils.web.HtmlDialog;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.RequestUtils;
import org.json.JSONObject;

import com.darkhorseventures.framework.actions.ActionContext;

/**
 * Maintains Tickets related to an Account
 * 
 * @author chris
 * @version $Id: AccountTickets.java,v 1.13 2002/12/24 14:newTic.upda53:03 mrajkowski Exp $
 * @created August 15, 2001
 */
public final class AccountCampioni extends CFSModule {

	/**
	 * Sample action for prototyping, by including a specified page
	 * 
	 * @param context
	 *            Description of Parameter
	 * @return Description of the Returned Value
	 */
	public String executeCommandDefault(ActionContext context) {
		String module = context.getRequest().getParameter("module");
		String includePage = context.getRequest().getParameter("include");
		context.getRequest().setAttribute("IncludePage", includePage);
		addModuleBean(context, module, module);
		return getReturn(context, "Include");
	}

	public String executeCommandReopenTicket(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-campioni-edit")) {
			return ("PermissionError");
		}
		
		Integer resultCount = -1 ;
	Connection db = null ;
		try {
			db = this.getConnection(context);
			Campioni c = new Campioni();
			
			c.executeCommandReopenTicket(context,db);
			
			resultCount = (Integer) context.getRequest().getAttribute("resultCount");
			context.getRequest().setAttribute("altId", context.getParameter("altId"));
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}
		if (resultCount == -1) {
			return (executeCommandTicketDetails(context));
		} else if (resultCount == 1) {
			return (executeCommandTicketDetails(context));
		} else {
			context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
			return ("UserError");
		}
	}

	

	/**
	 * Load the ticket details tab
	 * 
	 * @param context
	 *            Description of Parameter
	 * @return Description of the Returned Value
	 */
	public String executeCommandTicketDetails(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-campioni-view")) {
			return ("PermissionError");
		}
		Connection db = null;
		// Parameters
				
		String retPag = null;
		try {
			db = this.getConnection(context);
			
			Integer altId = -1 ;
			Integer idCampione = -1; 
			
			 try {idCampione = Integer.parseInt(context.getRequest().getParameter("id"));} catch (Exception e){}
             if (idCampione == -1)
     			 try {idCampione = Integer.parseInt((String)context.getRequest().getAttribute("id"));} catch (Exception e){}

			Campioni c = new Campioni();
			
			context.getRequest().setAttribute("ActionString", context.getAction().getActionName());
			c.executeCommandTicketDetails(context,db);
			if (context.getRequest().getParameter("altId") != null )
				altId = Integer.parseInt( context.getRequest().getParameter("altId"));			
			else
				if (context.getRequest().getAttribute("altId") != null )
					altId = Integer.parseInt( ""+context.getRequest().getAttribute("altId"));			
			if(altId<1 && context.getRequest().getParameter("altId")!=null )
				altId = Integer.parseInt( context.getRequest().getParameter("altId"));		
			
					
			SintesisStabilimento stab = new SintesisStabilimento(db,altId, true);
			stab.getPrefissoAction(context.getAction().getActionName());
			context.getRequest().setAttribute("OrgDetails", stab);
			
			if ("true".equalsIgnoreCase(org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("NUOVA_GESTIONE_CAMPIONI_MACELLI"))){

				CampioneNew campioneNew = new CampioneNew();
				campioneNew.buildFromIdCampione(db, idCampione);
				if (campioneNew.getIdCapo()>0){
					org.aspcfs.modules.macellazionisintesis.base.Capo capo = new org.aspcfs.modules.macellazionisintesis.base.Capo();
					capo = capo.load(campioneNew.getIdCapo()+"", db);
					context.getRequest().setAttribute("CampioneCapoMatricola", capo.getCd_matricola());
					context.getRequest().setAttribute("CampioneCapoSedutaData", String.valueOf(capo.getVpm_data()));
					context.getRequest().setAttribute("CampioneCapoSedutaNumero", String.valueOf(capo.getCd_seduta_macellazione()));
				}
			}
	
			retPag = "DettaglioOK";

			
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		// return getReturn(context, "TicketDetails");
		return retPag;
	}

	/**
	 * Confirm the delete operation showing dependencies
	 * 
	 * @param context
	 *            Description of the Parameter
	 * @return Description of the Return Value
	 */
	public String executeCommandConfirmDelete(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-campioni-delete")) {
			return ("PermissionError");
		}
		Connection db = null;
		// Parameters
		String id = context.getRequest().getParameter("id");
		int altId = Integer.parseInt(context.getRequest().getParameter("altId"));
		try {
			db = this.getConnection(context);
			SintesisStabilimento stab = new SintesisStabilimento(db,altId, true);
			stab.getPrefissoAction(context.getAction().getActionName());
			SystemStatus systemStatus = this.getSystemStatus(context);
			Ticket ticket = new Ticket(db, Integer.parseInt(id));
			//check permission to record
			
			DependencyList dependencies = ticket.processDependencies(db);
			// Prepare the dialog based on the dependencies
			HtmlDialog htmlDialog = new HtmlDialog();
			dependencies.setSystemStatus(systemStatus);
			htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
			htmlDialog.addMessage(systemStatus
					.getLabel("confirmdelete.caution")
					+ "\n" + dependencies.getHtmlString());
			/*htmlDialog.setHeader(systemStatus.getLabel("confirmdelete.header"));*/
			htmlDialog.addButton(systemStatus.getLabel("global.button.delete"),
					"javascript:window.location.href='"+	stab.getAction() + "Campioni.do?command=DeleteTicket&id="
							+ id
							+ "&altId="
							+ altId
							+ "&forceDelete=true"
							+ RequestUtils.addLinkParams(context.getRequest(),
									"popup|popupType|actionId") + "'");
			htmlDialog.addButton(systemStatus.getLabel("button.cancel"),
					"javascript:parent.window.close()");
			context.getSession().setAttribute("Dialog", htmlDialog);
			
			String checkCampioneCancellabile = ticket.getCampioneCancellabile(db);
			int codiceCampioneCancellabile = Integer.parseInt(checkCampioneCancellabile.split(";;")[0]);
			if (codiceCampioneCancellabile > 0){
				String erroreCampioneCancellabile = checkCampioneCancellabile.split(";;")[1];
				htmlDialog = new HtmlDialog();
				dependencies.setSystemStatus(systemStatus);
				htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
				htmlDialog.addMessage("<font color=\"red\"><b>"+erroreCampioneCancellabile + "</b></font>\n" + dependencies.getHtmlString());
				htmlDialog.addButton(systemStatus.getLabel("button.cancel"), "javascript:parent.window.close()");
				context.getSession().setAttribute("Dialog", htmlDialog);
			}
			//Preaccettazione
			
			DwrPreaccettazione dwrPreacc = new DwrPreaccettazione();
			String result = dwrPreacc.Preaccettazione_CancellazionePreaccettazione(id, "0", String.valueOf(getUserId(context)));
			JSONObject jsonObj;
			jsonObj = new JSONObject(result);
			int esitoCancellazionePreacc =  Integer.parseInt(jsonObj.getString("esito_cancellazione"));
			String erroreCancellazionePreacc = jsonObj.getString("errore_cancellazione");
			
			if (esitoCancellazionePreacc > 0){
				htmlDialog = new HtmlDialog();
				dependencies.setSystemStatus(systemStatus);
				htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
				htmlDialog.addMessage("<font color=\"red\"><b>"+erroreCancellazionePreacc + "</b></font>\n" + dependencies.getHtmlString());
				htmlDialog.addButton(systemStatus.getLabel("button.cancel"), "javascript:parent.window.close()");
				context.getSession().setAttribute("Dialog", htmlDialog);
			}
			return ("ConfirmDeleteOK");
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
	}

	/**
	 * Delete the specified ticket
	 * 
	 * @param context
	 *            Description of Parameter
	 * @return Description of the Returned Value
	 */
	public String executeCommandDeleteTicket(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-campioni-delete")) {
			return ("PermissionError");
		}
		boolean recordDeleted = false;
		Connection db = null;
		// Parameters
		int altId = Integer
				.parseInt(context.getRequest().getParameter("altId"));
		String passedId = context.getRequest().getParameter("id");
		try {
			db = this.getConnection(context);
			SintesisStabilimento stab = new SintesisStabilimento(db,altId, true);
			stab.getPrefissoAction(context.getAction().getActionName());
			Ticket thisTic = new Ticket(db, Integer.parseInt(passedId));
			//check permission to record
			
			
			 String id_controllo=thisTic.getIdControlloUfficiale();
				while(id_controllo.startsWith("0")){
					
					id_controllo=id_controllo.substring(1);
				}

			context.getRequest().setAttribute("idC", id_controllo);
			
			recordDeleted = thisTic.delete(db, getDbNamePath(context));
			if (recordDeleted) {
				processDeleteHook(context, thisTic);
				//del
				String inline = context.getRequest().getParameter("popupType");
				context.getRequest().setAttribute("OrgDetails", stab);
				context
						.getRequest()
						.setAttribute(
								"refreshUrl",
								stab.getAction()+"Vigilanza.do?command=TicketDetails&id="+id_controllo+"&altId="
										+ altId
										+ (inline != null
												&& "inline".equals(inline
														.trim()) ? "&popup=true"
												: ""));
			}
			
			//Preaccettazione
			DwrPreaccettazione dwrPreacc = new DwrPreaccettazione();
			String result = dwrPreacc.Preaccettazione_CancellazionePreaccettazione(passedId, "1", String.valueOf(getUserId(context)));
			JSONObject jsonObj;
			jsonObj = new JSONObject(result);
			int esitoCancellazionePreacc =  Integer.parseInt(jsonObj.getString("esito_cancellazione"));
			String erroreCancellazionePreacc = jsonObj.getString("errore_cancellazione");
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		if (recordDeleted) {
			return ("DeleteTicketOK");
		} else {
			return (executeCommandTicketDetails(context));
		}
	}

	
	
	
	
	/**
	 * Loads the history for the specified ticket
	 * 
	 * @param context
	 *            Description of the Parameter
	 * @return Description of the Return Value
	 */
	public String executeCommandViewHistory(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-campioni-history-view")) {
			return ("PermissionError");
		}
		Connection db = null;
		String ticketId = context.getRequest().getParameter("id");
		try {
			db = this.getConnection(context);
			// Load the ticket
			Ticket thisTic = new Ticket();
			SystemStatus systemStatus = this.getSystemStatus(context);
			thisTic.setSystemStatus(systemStatus);
			thisTic.queryRecord(db, Integer.parseInt(ticketId));
			//check permission to record
			
			// Load the organization
			SintesisStabilimento thisOrganization = new SintesisStabilimento(db, thisTic.getAltId(), true);
			context.getRequest().setAttribute("OrgDetails", thisOrganization);
			// check whether or not the owner is an active User
			
			context.getRequest().setAttribute("TicketDetails", thisTic);
			addRecentItem(context, thisTic);
			addModuleBean(context, "View Tickets", "Ticket Details");
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		return getReturn(context, "ViewHistory");
	}

	// aggiunto da d.dauria
	public String executeCommandAdd(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-campioni-add")) {
			return ("PermissionError");
		}
		Connection db = null;
		
		try {
			db = this.getConnection(context);
			

			// aggiunte queste istruzioni
			String tempaltId = context.getRequest().getParameter("altId");
			int tempid = Integer.parseInt(tempaltId);
			SintesisStabilimento stab = new SintesisStabilimento(db,tempid, true);
			stab.getPrefissoAction(context.getAction().getActionName());
			Campioni c = new Campioni ();
			c.executeCommandAdd(context,db);
			context.getRequest().setAttribute("OrgDetails", stab);

		} catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
	
		if (context.getRequest().getParameter("actionSource") != null) {
			context.getRequest().setAttribute("actionSource",
					context.getRequest().getParameter("actionSource"));
			return "AddTicketOK";
		}
		context.getRequest().setAttribute("systemStatus",
				this.getSystemStatus(context));
		return ("AddOK");
	}
	
	public String executeCommandAddCapoMacello(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-campioni-add")) {
			return ("PermissionError");
		}
		Connection db = null;
		
		try {
			db = this.getConnection(context);
			
			int altId = -1;
			try {altId = Integer.parseInt(context.getRequest().getParameter("altId"));} catch (Exception e) {}
			String matricola = context.getRequest().getParameter("matricola");
			
			int idCapo = -1;
			try {idCapo = Integer.parseInt(context.getRequest().getParameter("idCapo"));} catch (Exception e) {}
			
			String dataPrelievo = context.getRequest().getParameter("dataPrelievo");
			SintesisStabilimento stab = new SintesisStabilimento(db,altId, true);
			stab.getPrefissoAction(context.getAction().getActionName());
			
			LookupList DestinatarioCampione = new LookupList(db, "lookup_destinazione_campione");
			for (int i = 0; i<10; i++) //lascio solo izsm
				if (i!=1)
					DestinatarioCampione.removeElementByLevel(i);
            context.getRequest().setAttribute("DestinatarioCampione", DestinatarioCampione);
            
            Calendar calCorrente = GregorianCalendar.getInstance();
    		Date dataCorrente = new Date(System.currentTimeMillis());
    		int tolleranzaGiorni = Integer.parseInt(org.aspcfs.modules.vigilanza.blocchicu.ApplicationProperties.getProperty("TOLLERANZA_MODIFICA_CU"));
    		dataCorrente.setDate(dataCorrente.getDate()- tolleranzaGiorni);
    		calCorrente.setTime(new Timestamp(dataCorrente.getTime()));
    		int anno_corrente = calCorrente.get(Calendar.YEAR);
    		
            LookupList lookup_tipo_ispezione = new LookupList();
            lookup_tipo_ispezione.setTable("(select * from get_motivazione_campione_macello())");
            lookup_tipo_ispezione.buildList(db);     
            lookup_tipo_ispezione.addItem(-1, "-- SELEZIONA VOCE --");
            context.getRequest().setAttribute("Motivazione", lookup_tipo_ispezione);
            
            LookupList lookup_piani = new LookupList();
            lookup_piani.setTable("(select * from get_motivazione_piani_campione_macello("+anno_corrente+"))"); 
            lookup_piani.buildList(db);     
            lookup_piani.addItem(-1, "-- SELEZIONA VOCE --");
            context.getRequest().setAttribute("Piani", lookup_piani);
            
            LookupList lookup_attivita = new LookupList();
            lookup_attivita.setTable("(select * from get_motivazione_attivita_campione_macello("+anno_corrente+"))");
            lookup_attivita.buildList(db);     
            lookup_attivita.addItem(-1, "-- SELEZIONA VOCE --");
            context.getRequest().setAttribute("Attivita", lookup_attivita);
    
            Campioni c = new Campioni ();
			c.executeCommandAdd(context,db);
			           
			context.getRequest().setAttribute("OrgDetails", stab);
			context.getRequest().setAttribute("matricola", matricola);
			context.getRequest().setAttribute("dataPrelievo", dataPrelievo);
			context.getRequest().setAttribute("idCapo", String.valueOf(idCapo));

		} catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
	
		context.getRequest().setAttribute("systemStatus",
				this.getSystemStatus(context));
		return ("AddCapoMacelloOK");
	}

	public String executeCommandInsert(ActionContext context)
			throws SQLException {
		if (!(hasPermission(context, "sintesis-sintesis-campioni-add"))) {
			return ("PermissionError");
		}
		Connection db = null;
		boolean recordInserted = false;
		boolean contactRecordInserted = false;
		boolean isValid = true;
		Ticket newTic = (Ticket) context.getFormBean();
		
		
		try
		{
			db = this.getConnection(context);
			
			
			Integer altId = 0;
			if(context.getRequest().getParameter("altId")!=null)
				altId = Integer.parseInt(context.getRequest().getParameter("altId"));
			
			SintesisStabilimento thisOrg = new SintesisStabilimento(db, altId, true );
			thisOrg.getPrefissoAction(context.getAction().getActionName());
			context.getRequest().setAttribute("OrgDetails", thisOrg);
			context.getRequest().setAttribute("ragione_sociale", thisOrg.getName());
			
			Campioni c = new Campioni();
			c.executeCommandInsert(context,db);
			
			recordInserted = (Boolean) context.getRequest().getAttribute("recordInserted");
			isValid = (Boolean) context.getRequest().getAttribute("isValid");
			
		} catch (Exception e) {
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		addModuleBean(context, "ViewTickets", "Ticket Insert ok");
		if (recordInserted && isValid) {
			if (context.getRequest().getParameter("actionSource") != null) {
				context.getRequest().setAttribute("actionSource",
						context.getRequest().getParameter("actionSource"));
				return "InsertTicketOK";
			}
			String retPage = "DettaglioOK";
			//String tipo_richiesta = newTic.getTipo_richiesta();
			//tipo_richiesta = (tipo_richiesta == null) ? ("") : (tipo_richiesta);

			retPage = "InsertOK";
		
			return (retPage);// ("InsertOK");
		}
		return (executeCommandAdd(context));
	}
	
	public String executeCommandInsertCapoMacello(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-campioni-add")) {
			return ("PermissionError");
		}
		Connection db = null;
		String jsonResult = "";
		
		try {
			db = this.getConnection(context);
			
			int altId = -1;
			try {altId = Integer.parseInt(context.getRequest().getParameter("altId"));} catch (Exception e) {}
			int idCapo = -1;
			try {idCapo = Integer.parseInt(context.getRequest().getParameter("idCapo"));} catch (Exception e) {}
			String matricola = context.getRequest().getParameter("matricola");
			String dataPrelievo = context.getRequest().getParameter("dataPrelievo");
			String numeroVerbale = context.getRequest().getParameter("numeroVerbale");
			int idMotivo = -1;
			try {idMotivo = Integer.parseInt(context.getRequest().getParameter("idMotivo"));} catch (Exception e) {}
			int idPiano = -1;
			try {idPiano = Integer.parseInt(context.getRequest().getParameter("idPiano"));} catch (Exception e) {}
			int idAttivita = -1;
			try {idAttivita = Integer.parseInt(context.getRequest().getParameter("idAttivita"));} catch (Exception e) {}
			if (idAttivita > 0)
				idMotivo = idAttivita;
			int idMatrice = -1;
			try {idMatrice = Integer.parseInt(context.getRequest().getParameter("idMatrice_1"));} catch (Exception e) {}
			String idAnaliti = "";
			int numAnaliti = -1;
			try {numAnaliti = Integer.parseInt(context.getRequest().getParameter("elementi"));} catch (Exception e) {}
			for (int i = 1; i<=numAnaliti; i++){
				int idAnalita = -1;
				try {idAnalita = Integer.parseInt(context.getRequest().getParameter("analitiId_"+i));} catch (Exception e) {}
				if (i>1)
					idAnaliti+= ",";
				idAnaliti += idAnalita;
			}
			int idLaboratorio = -1;
			try {idLaboratorio = Integer.parseInt(context.getRequest().getParameter("idLaboratorio"));} catch (Exception e) {}	 
			String note = context.getRequest().getParameter("note");

			CampioneNew c = new CampioneNew();
			c.setIdMacello(altId);
			c.setMatricola(matricola);
			c.setDataPrelievo(dataPrelievo);
			c.setNumeroVerbale(numeroVerbale);
			c.setIdMotivo(idMotivo);
			c.setIdPiano(idPiano);
			c.setIdMatrice(idMatrice);
			c.setTipoAnalisi(idAnaliti);
			c.setIdLaboratorio(idLaboratorio);
			c.setIdCapo(idCapo);
			c.setNote(note);
			
			jsonResult = c.insert(db, getUserId(context));
				

		} catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
	
		context.getRequest().setAttribute("jsonResult",jsonResult);
				
		return ("AddCapoMacelloOK");
	}

	public String executeCommandDettaglio(ActionContext context) {
		if (!hasPermission(context, "sintesis-sintesis-view")) {
			return ("PermissionError");
		}
		Connection db = null;
		Ticket newTic = null;
		String ticketId = null;
		SystemStatus systemStatus = this.getSystemStatus(context);
		try {
			String fromDefectDetails = context.getRequest().getParameter(
					"defectCheck");
			if (fromDefectDetails == null
					|| "".equals(fromDefectDetails.trim())) {
				fromDefectDetails = (String) context.getRequest().getAttribute(
						"defectCheck");
			}

			// Parameters
			ticketId = context.getRequest().getParameter("id");
			// Reset the pagedLists since this could be a new visit to this
			// ticket
			deletePagedListInfo(context, "TicketDocumentListInfo");
			deletePagedListInfo(context, "SunListInfo");
			deletePagedListInfo(context, "TMListInfo");
			deletePagedListInfo(context, "CSSListInfo");
			deletePagedListInfo(context, "TicketsFolderInfo");
			deletePagedListInfo(context, "TicketTaskListInfo");
			deletePagedListInfo(context, "ticketPlanWorkListInfo");
			db = this.getConnection(context);
			// Load the ticket
			newTic = new Ticket();
			newTic.queryRecord(db, Integer.parseInt(ticketId));

			// find record permissions for portal users
			

			SintesisStabilimento orgDetails = new SintesisStabilimento(db, newTic.getAltId(), true);
			// check wether or not the product id exists
		

		
		LookupList TipoCampione = new LookupList(db, "lookup_provvedimenti");
			TipoCampione.addItem(-1, systemStatus
					.getLabel("calendar.none.4dashes"));
			context.getRequest().setAttribute("TipoCampione", TipoCampione);

			LookupList EsitoCampione = new LookupList(db,
					"lookup_sanzioni_amministrative");
			EsitoCampione.addItem(-1, systemStatus
					.getLabel("calendar.none.4dashes"));
			context.getRequest().setAttribute("EsitoCampione", EsitoCampione);

			
	LookupList AnimaliNonAlimentari = new LookupList(db,
	"lookup_animali_non_alimentari");
AnimaliNonAlimentari.addItem(-1,
"-- SELEZIONA VOCE --");
context.getRequest().setAttribute("AnimaliNonAlimentari",
	AnimaliNonAlimentari);
		      LookupList lookup_specie_alimento = new LookupList(db,
		      "lookup_specie_alimento");
		      lookup_specie_alimento.addItem(-1,
		      "-- SELEZIONA VOCE --");
		      context.getRequest().setAttribute("lookupSpecieAlimento",
		    		  lookup_specie_alimento);

		      LookupList lookup_tipologia_alimento = new LookupList(db,
		      "lookup_tipologia_alimento");
		      lookup_tipologia_alimento.addItem(-1,
		      "-- SELEZIONA VOCE --");
		      context.getRequest().setAttribute("lookupTipologiaAlimento",
		    		  lookup_tipologia_alimento);
		      
			LookupList SiteIdList = new LookupList(db, "lookup_site_id");
			SiteIdList.addItem(-1, systemStatus
					.getLabel("calendar.none.4dashes"));
			context.getRequest().setAttribute("SiteIdList", SiteIdList);

			LookupList SanzioniPenali = new LookupList(db,
					"lookup_sanzioni_penali");
			SanzioniPenali.addItem(-1, systemStatus
					.getLabel("calendar.none.4dashes"));
			context.getRequest().setAttribute("SanzioniPenali", SanzioniPenali);

			LookupList Sequestri = new LookupList(db, "lookup_sequestri");
			Sequestri.addItem(-1, systemStatus
					.getLabel("calendar.none.4dashes"));
			context.getRequest().setAttribute("Sequestri", Sequestri);
			
		
		} catch (Exception e) {
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		context.getRequest().setAttribute("TicketDetails", newTic);
		addRecentItem(context, newTic);
		addModuleBean(context, "ViewTickets", "View Tickets");

		String retPage = "DettaglioOK";
		String tipo_richiesta = newTic.getTipo_richiesta();
		tipo_richiesta = (tipo_richiesta == null) ? ("") : (tipo_richiesta);

		retPage = "DettaglioOK";

		/*
		 * if( tipo_richiesta.equalsIgnoreCase(
		 * "epidemologia_malattie_infettive" ) ){ retPage =
		 * "DetailsEpidemologia_malattie_infettiveOK"; }else if(
		 * tipo_richiesta.equalsIgnoreCase(
		 * "autorizzazione_trasporto_animali_vivi" ) ){ retPage =
		 * "DetailsAutorizzazione_trasporto_animali_viviOK"; }else if(
		 * tipo_richiesta.equalsIgnoreCase(
		 * "movimentazione_compravendita_animali" ) ){ retPage =
		 * "DetailsMovimentazione_compravendita_animaliOK"; }else if(
		 * tipo_richiesta.equalsIgnoreCase( "macellazioni" ) ){ retPage =
		 * "DetailsMacellazioniOK"; }else if( tipo_richiesta.equalsIgnoreCase(
		 * "attivita_ispettiva_rilascioautorizzazioni_e_vigilanza" ) ){ retPage =
		 * "DetailsAttivita_ispettiva_rilascioautorizzazioni_e_vigilanzaOK";
		 * }else if( tipo_richiesta.equalsIgnoreCase(
		 * "smaltimento_spoglie_animali" ) ){ retPage =
		 * "DetailsSmaltimento_spoglie_animaliOK"; }
		 */

		return (retPage);
	}

	public String executeCommandChiudi(ActionContext context) {
		if (!(hasPermission(context, "sintesis-sintesis-campioni-edit"))) {
			return ("PermissionError");
		}
		int resultCount = -1;
		Connection db = null;
		Ticket thisTicket = null;
		try {
			db = this.getConnection(context);
			thisTicket = new Ticket(db, Integer.parseInt(context.getRequest()
					.getParameter("id")));
			Ticket oldTicket = new Ticket(db, thisTicket.getId());
			//check permission to record
			thisTicket.setModifiedBy(getUserId(context));
			resultCount = thisTicket.chiudi(db);
			if (resultCount <= 0)
			{
				context.getRequest().setAttribute("Messaggio", "Chiusura non avvenuta assicurarsi di aver inserito l' Esito");
			}
			thisTicket.getIdControlloUfficiale();
			String padd="000000";	
			 String id_controllo=thisTicket.getIdControlloUfficiale();
				while(id_controllo.startsWith("0")){
					
					id_controllo=id_controllo.substring(1);
				}

			context.getRequest().setAttribute("idC", id_controllo);
			context.getRequest().setAttribute("altId", thisTicket.getAltId());
			org.aspcfs.modules.vigilanza.base.Ticket cu = new org.aspcfs.modules.vigilanza.base.Ticket(db,Integer.parseInt(thisTicket.getIdControlloUfficiale()));
			context.getRequest().setAttribute("CU", cu);
			
			
			
			
			
			/*
			 * Inifio Giuseppe
			 * 
			 */
			
			
			org.aspcfs.modules.vigilanza.base.Ticket thisTicketV = new org.aspcfs.modules.vigilanza.base.Ticket(
			          db, Integer.parseInt(id_controllo));
			   
			
			String ticketId = context.getRequest().getParameter("id");
		      
		     
			 
			 org.aspcfs.modules.campioni.base.TicketList ticList = new org.aspcfs.modules.campioni.base.TicketList();
			 int passedId = thisTicketV.getIdStabilimento();
			 ticList.setIdStabilimento(passedId);
			 ticList.buildListControlli(db, passedId, id_controllo);

			 
			 org.aspcfs.modules.tamponi.base.TicketList tamponiList = new org.aspcfs.modules.tamponi.base.TicketList();
			 int pasId = thisTicketV.getIdStabilimento();
			 tamponiList.setIdStabilimento(passedId);
			 tamponiList.buildListControlli(db, pasId, id_controllo);

				  	    
				      
				      
				      Iterator campioniIterator=ticList.iterator();
				      Iterator tamponiIterator=tamponiList.iterator();
				      
				      
				      
				      int flag=0;
				      while(campioniIterator.hasNext()){
				    	  
				    	  org.aspcfs.modules.campioni.base.Ticket tic = (org.aspcfs.modules.campioni.base.Ticket) campioniIterator.next();
				    	  
				    	  if(tic.getClosed()==null){
				    		  flag=1;
				    		  
				    		  break;
				    		  
				    	  }
				    		  
				      }
				      
				     
				      while(tamponiIterator.hasNext()){
				    	  
				    	  org.aspcfs.modules.tamponi.base.Ticket tic = (org.aspcfs.modules.tamponi.base.Ticket) tamponiIterator.next();
				    	  
				    	  if(tic.getClosed()==null){
				    		  flag=1;
				    		  
				    		  break;
				  	  }
				    	 	  
				      }
				      
				      
				      if (flag == 0)
				      {
				    	  thisTicketV.apriTemp(db);
				      }
				     
				      
				      if(thisTicketV.isNcrilevate()==true){
				    	  org.aspcfs.modules.nonconformita.base.TicketList nonCList = new org.aspcfs.modules.nonconformita.base.TicketList();
				          int passIdN = thisTicketV.getIdStabilimento();
				          nonCList.setIdStabilimento(passedId);
				          nonCList.buildListControlli(db, passIdN, id_controllo);
				    	  
				          Iterator ncIterator=nonCList.iterator();
				          
				          while(ncIterator.hasNext()){
					    	  
					    	  org.aspcfs.modules.nonconformita.base.Ticket tic = (org.aspcfs.modules.nonconformita.base.Ticket) ncIterator.next();
					    	  
					    	  if(tic.getClosed()==null){
					    		  flag=1;
					    		  
					    		  break;
					    		  
					    	  }
					    		  
					      }
				  
				      }
				      
				    	  org.aspcfs.modules.altriprovvedimenti.base.TicketList nonCList = new org.aspcfs.modules.altriprovvedimenti.base.TicketList();
				          int passIdN = thisTicketV.getIdStabilimento();
				          nonCList.setIdStabilimento(passedId);
				          nonCList.buildListControlli(db, passIdN, id_controllo);
				    	   Iterator ncIterator=nonCList.iterator();
				          while(ncIterator.hasNext()){
					    	  org.aspcfs.modules.altriprovvedimenti.base.Ticket tic = (org.aspcfs.modules.altriprovvedimenti.base.Ticket) ncIterator.next();
					    	  if(tic.getClosed()==null){
					    		  flag=1;
					    		  break;
					    	  }
					      }
				  
				      
				      
				      SintesisStabilimento org = new SintesisStabilimento(db , thisTicketV.getAltId(), true);
				      
				    
				      
				      
				      
				      if(thisTicketV.getTipoCampione()==5){
				    	  
				    	  org.aspcfs.modules.audit.base.AuditList audit = new org.aspcfs.modules.audit.base.AuditList();
				          int AuditOrgId = thisTicketV.getIdStabilimento();
				          String idTi = thisTicketV.getPaddedId();
				          audit.setOrgId(AuditOrgId);
				         
				          audit.buildListControlli(db, AuditOrgId, idTi);
				          
				    	  Iterator itAudit=audit.iterator();
				    	  
				    	  if(!itAudit.hasNext()){
				    		  
				  		    	flag=2;
				  	    			  		    
				    	  }else{
				    	  
			      while(itAudit.hasNext()){
					    	  
					    	  org.aspcfs.modules.audit.base.Audit auditTemp = (org.aspcfs.modules.audit.base.Audit) itAudit.next();
					    	  SintesisStabilimento orgDetails = new SintesisStabilimento(db,thisTicketV.getAltId(), true);
					    	  
					    	  if(thisTicketV.isCategoriaisAggiornata()==false){
					    		  flag=2;
					    		  
					    		  break;
					    		  
					    	  }
					    		  
					    }}
				     }
				          
				      
				      
				      String attivitaCollegate=context.getRequest().getParameter("altro");
				   
							      
				      if(attivitaCollegate==null){
				      if(flag==1 || flag==2){
				    	  context.getRequest().setAttribute("Chiudi", ""+flag);
				    	  return (executeCommandTicketDetails(context));
				    	  
				      }
				      }
				      
				  
				      String chiudiCu = context.getRequest().getParameter("chiudiCu");
					  if(flag==0 ){
						  if(chiudiCu !=null)
						  {
					      thisTicketV.setModifiedBy(getUserId(context));
					      resultCount = thisTicketV.chiudi(db);
						  }else
						  {
							  context.getRequest().setAttribute("Messaggio2", "Attivita collegate al cu chiuse");
						  }
					  }
			
			if (resultCount == -1 || resultCount == -2) {
				return (executeCommandTicketDetails(context));
			} else if (resultCount == 1) {
				thisTicket.queryRecord(db, thisTicket.getId());
				this.processUpdateHook(context, oldTicket, thisTicket);
				
				
				
				return (executeCommandTicketDetails(context));
			}
			
		    
			
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
		return ("UserError");

	}
	

	public String executeCommandStampaScheda(ActionContext context) {
		  Connection db = null;
	      try {
		  
	    	
	        db = this.getConnection(context);
	    	String descrizioneAsl = "";
			
			//instanzia il bean
			Filtro f = new Filtro();
			HttpServletResponse res = context.getResponse();
			
			//recupero dei dati di input
		    String id_campione = context.getParameter("idCampione");
		    int tipoAnalisi = Integer.parseInt(context.getParameter("tipoAnalisi"));
		    f.setIdCampione(Integer.parseInt(id_campione));
		    //Indipendentemente dalla tipologia dei campioni
		    ResultSet rs = f.queryRecord_campioni(db);
	    	if (rs.next())
	    	{
	    		f.setRagioneSociale(rs.getString("ragione_sociale"));
	    		f.setNumVerbale(rs.getString("num_verbale"));
	    		f.setData_referto(rs.getString("data_referto"));
	    		f.setComponente_nucleo(rs.getString("componente_nucleo"));
	    		f.setComponente_nucleo_due(rs.getString("componente_nucleo_due"));
	    		f.setComponente_nucleo_tre(rs.getString("componente_nucleo_tre"));
	    		f.setTipologiaAttivita(rs.getString("tipologia"));
	    		f.setNum_reg(rs.getString("n_reg"));
	    		f.setComune(rs.getString("comune"));
	    		f.setIndirizzo(rs.getString("indirizzo"));
	    		f.setCodiceFiscale(rs.getString("codice_fiscale"));
	    		f.setSedeLegale(rs.getString("sede_legale"));
	    		f.setIndirizzoLegale(rs.getString("indirizzo_legale"));
	    		f.setLegaleRappresentante(rs.getString("nome_rappresentante")+" "+rs.getString("cognome_rappresentante"));
	    		f.setData_nascita_rappresentante(rs.getString("data_nascita_rappresentante"));
	    		f.setLuogo_nascita_rappresentante(rs.getString("luogo_nascita_rappresentante"));
	    		
	    	}	
		    
		    //Campione battereologico
		    if(tipoAnalisi == 1) {
		    	StampaPdf s = new StampaPdf(context,f);
		    	s.stampaVerbaleCampioneBattereologico(context, f, id_campione);
		    }//fine campione battereologico
		    
		    //Campione chimico
		    if(tipoAnalisi == 5) {
		    	StampaPdf s = new StampaPdf(context,f);
		    	s.stampaVerbaleCampioneChimico(context, f, id_campione);
		    }//fine campione chimico
		    
		 }catch (Exception e) {
			  e.printStackTrace();
	        context.getRequest().setAttribute("Error", e);
	        return ("SystemError");
	     } finally {
	        this.freeConnection(context, db);
	     }
	   return ("-none-");//getReturn(context, "AssetsSearchList");

		
	}
	
	public String executeCommandUpdateTicketEsiti(ActionContext context) {
		Connection db = null;
		Ticket thisTicket = null;
		try {
			db = this.getConnection(context);
			Campioni.executeCommandUpdateTicketEsiti(context, db);
		} catch (Exception e) {
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		return executeCommandTicketDetails(context);
}
	public String executeCommandRiapriTicketEsiti(ActionContext context) {
		Connection db = null;
		Ticket thisTicket = null;
		try {
			db = this.getConnection(context);
			Campioni.executeCommandRiapriTicketEsiti(context, db);
		} catch (Exception e) {
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		return executeCommandTicketDetails(context);
}	
	
	
}
