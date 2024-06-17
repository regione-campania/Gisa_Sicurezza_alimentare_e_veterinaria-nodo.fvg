package org.aspcfs.modules.imbarcazioni.actions;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Logger;

import org.aspcfs.checklist.action.Checklist;
import org.aspcfs.checklist.base.Audit;
import org.aspcfs.checklist.base.AuditChecklist;
import org.aspcfs.checklist.base.AuditChecklistType;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.imbarcazioni.base.Organization;
import org.aspcfs.modules.vigilanza.base.Ticket;
import org.aspcfs.utils.AuditReport;
import org.aspcfs.utils.web.CustomLookupList;

import com.darkhorseventures.framework.actions.ActionContext;

public class CheckListImbarcazioni  extends CFSModule{
	
	Logger logger = Logger.getLogger("MainLogger");
	
	 public String executeCommandAdd(ActionContext context)
	  {
		 logger.info("AGGIUNTA DI NUOVA CHECKLIST PER Imbarcazioni. ACTION CHIAMATA : CheckListImbarcazioni ");
		 
		 if (!hasPermission(context, "checklist-checklist-add"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandAdd(context);
			
			db = this.getConnection(context);
			Organization organization	 = 	new Organization(db, Integer.parseInt(context.getRequest().getParameter("orgId")));
			organization.setAccountSize(context.getRequest().getParameter("accountSize"));
			context.getRequest().setAttribute("OrgDetails", organization);
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
		 return "checklistImbarcazioniAdd";
	 
	  }
	 
	 
	 public String executeCommandSave(ActionContext context)
	  {
		 logger.info("SALVATAGGIO DELLA CHECKLIST PER Imbarcazioni. ACTION CHIAMATA : CheckListImbarcazioni ");
		 
		 if (!hasPermission(context, "checklist-checklist-add")) 
		 {
				return ("PermissionError");
		 }		
		 
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandSave(context);
			
			db = this.getConnection(context);
			Organization organization	 = 	new Organization(db, Integer.parseInt(context.getRequest().getParameter("orgId")));
			context.getRequest().setAttribute("OrgDetails", organization);
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		 return "checklistImbarcazioniSaveOk";
	  }
	 
	 public String executeCommandView(ActionContext context)
	 {
		 logger.info("DETTAGLIO CHECKLIST PER Imbarcazioni. ACTION CHIAMATA : CheckListImbarcazioni ");
		 
		 if (!hasPermission(context, "checklist-checklist-view")) 
		{
			return ("PermissionError");
		}
				
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandView(context);
			
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization 	orgTemp 		= 	(org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization 							organization	= 	new Organization(db, orgTemp.getOrg_id());
			
			context.getRequest().setAttribute("OrgDetails", organization);
			
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		 return "checklistImbarcazioniView";
	 }
	 
	 public String executeCommandModify(ActionContext context)
	 {
		 logger.info("MODIFICA CHECKLIST PER Imbarcazioni. ACTION CHIAMATA : CheckListImbarcazioni ");
		 
		 
		 if (!hasPermission(context, "checklist-checklist-edit")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandModify(context);
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
			context.getRequest().setAttribute("OrgDetails", organization);
			
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		 return "checklistImbarcazioniModify";
	 }
	 
	 public String executeCommandUpdate(ActionContext context)
	 {
		 logger.info("UPDATE CHECKLIST PER Imbarcazioni. ACTION CHIAMATA : CheckListImbarcazioni ");
		 
		 
		 if (!hasPermission(context, "checklist-checklist-edit")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
		
			Checklist c = new Checklist();
			c.executeCommandUpdate(context);
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
			context.getRequest().setAttribute("OrgDetails", organization);
			
		} 
		catch (SQLException e) 
		{
			context.getResponse().setStatus(2012);
			System.out.println("Errore in modifica Checklis : "+e.getMessage());
			context.getRequest().setAttribute("ErroreChecklist", "Errore");
			return executeCommandModify(context);
		}
		 return "checklistImbarcazioniUpdate";
	 }
	 
	 public String executeCommandDelete(ActionContext context)
	 {
		 logger.info("DELETE CHECKLIST PER Imbarcazioni. ACTION CHIAMATA : CheckListImbarcazioni ");
		 
		 
		 if (!hasPermission(context, "checklist-checklist-delete")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandDelete(context);
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
			context.getRequest().setAttribute("OrgDetails", organization);
		
		} 
		
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		 return ("checklistImbarcazioniDelete");
	 }
	 
	 public String executeCommandUpdateCategoria(ActionContext context)
	 {
		 logger.info("AGGIORNA LA CATEGORIA RISCHIO PER Imbarcazioni. ACTION CHIAMATA : CheckListImbarcazioni ");
					
		 Connection db = null;
			
			String idControllo = context.getRequest().getParameter("idC");
			String orgId = context.getRequest().getParameter("orgId");
			
			try 
			{
				db = this.getConnection(context);
				
				//verifica possibilita chiusura CU
				Ticket thisTicket = new Ticket(db, Integer.parseInt(idControllo));
				String messaggioAllegatiSanzione = thisTicket.isControlloChiudibileAllegatiSanzione(db);
				if (messaggioAllegatiSanzione!=null && !messaggioAllegatiSanzione.equals("")){
					int flag = 6;
					context.getRequest().setAttribute("Chiudi",""+flag);
					context.getRequest().setAttribute("Messaggio",messaggioAllegatiSanzione);
					context.getRequest().setAttribute("id", idControllo);
					context.getRequest().setAttribute("orgId", orgId);
					org.aspcfs.modules.imbarcazioni.actions.AccountVigilanza AV = new org.aspcfs.modules.imbarcazioni.actions.AccountVigilanza();
					//return AV.executeCommandTicketDetails(context);
					return AV.executeCommandChiudiTutto(context);
				}
				
							
			Checklist c = new Checklist();
			c.executeCommandUpdateLivello(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
			context.getRequest().setAttribute("OrgDetails", organization);
		
		} 
		
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		AccountVigilanza AV = new AccountVigilanza();
		return AV.executeCommandChiudiTutto(context);
		//return ("checklistImbarcazioniUpdateCategoria");
	 }
	 
	 public String executeCommandStampa(ActionContext context)
	 {
		 logger.info("STAMPA CHECKLIST PER Imbarcazioni. ACTION CHIAMATA : CheckListImbarcazioni ");
		 
		 
		 if (!hasPermission(context, "checklist-checklist-edit")) 
		 {
			return ("PermissionError");
		 }
			
		Connection db = null;
		try 
		{
			
			Checklist c = new Checklist();
			c.executeCommandITextReport(context);
			db = this.getConnection(context);
			org.aspcfs.checklist.base.Organization orgTemp = (org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization organization	 = 	new Organization(db, orgTemp.getOrg_id());
			context.getRequest().setAttribute("OrgDetails", organization);
			
			OutputStream out = context.getResponse().getOutputStream();
			AuditReport report = new AuditReport();
			

			Audit 							audit 				= 	(Audit) context.getRequest().getAttribute("Audit");
			ArrayList<CustomLookupList> 	checklistList 		= 	( ArrayList<CustomLookupList>) context.getRequest().getAttribute("checklistList");
			CustomLookupList 				checklistType 		=	(CustomLookupList) context.getRequest().getAttribute("typeList");
			ArrayList<AuditChecklistType> 	auditChecklistType 	=	(ArrayList<AuditChecklistType>) context.getRequest().getAttribute("auditChecklistType");
			ArrayList<AuditChecklist> 		auditChecklist 		=	( ArrayList<AuditChecklist>) context.getRequest().getAttribute("auditChecklist");
			report.setContext(context);
			report.generate( out, audit, organization, checklistList, checklistType,auditChecklist, auditChecklistType, db);

			out.flush();
		} 
		
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		
		 return ("-none-");
	 }
	 
}