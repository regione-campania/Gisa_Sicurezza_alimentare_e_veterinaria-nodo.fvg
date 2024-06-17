package org.aspcfs.modules.checklistdocumenti.actions;

import java.sql.Connection;
import java.sql.SQLException;

//import org.aspcfs.modules.checklistdocumenti.action.ChecklistDettaglio;
import org.aspcfs.checklist.action.Checklist;
import org.aspcfs.checklist.base.Audit;
import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.opu.base.IndirizzoNotFoundException;
import org.aspcfs.modules.vigilanza.base.Ticket;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;

public class ChecklistDocumenti extends CFSModule{
	
	public String executeCommandStampaChecklist(ActionContext context) throws IndirizzoNotFoundException
	 {
		 
		 if (!hasPermission(context, "checklist-checklist-view")) 
		{
			return ("PermissionError");
		}
		
		String 				id 				= context.getRequest().getParameter("id")	;
			
		Connection db = null;
		try 
		{
			db = this.getConnection(context);
			Checklist c = new Checklist();
			
			c.executeCommandView(context);
			org.aspcfs.checklist.base.Organization 	orgTemp 		= 	(org.aspcfs.checklist.base.Organization) context.getRequest().getAttribute("OrgDetails");
			Organization 							organization	= 	 null;
			
			if ( orgTemp.getOrg_id()>0)
				organization = new Organization(db, orgTemp.getOrg_id());
			else{
				Audit audit 	= 	new Audit( db , id );
				int idStab = audit.getIdStabilimento();
				
				if (DatabaseUtils.getTipologiaPartizione(db, idStab) == Ticket.ALT_OPU_RICHIESTE) {
                    org.aspcfs.modules.suap.base.Stabilimento stab= new org.aspcfs.modules.suap.base.Stabilimento (db, idStab, true) ;                                
                    organization = new Organization();
                    organization.setIdStabilimento(audit.getIdStabilimento());
                    organization.setName(stab.getOperatore().getRagioneSociale());
                    organization.setCategoriaRischio(stab.getCategoriaRischio());
				} else if  (DatabaseUtils.getTipologiaPartizione(db, idStab) == Ticket.ALT_SINTESIS) {
                org.aspcfs.modules.sintesis.base.SintesisStabilimento stab= new org.aspcfs.modules.sintesis.base.SintesisStabilimento (db, idStab, true) ;                                
                organization = new Organization();
                organization.setIdStabilimento(audit.getIdStabilimento());
                organization.setName(stab.getOperatore().getRagioneSociale());
                organization.setCategoriaRischio(stab.getCategoriaRischio());
				}
              
            else{
                    org.aspcfs.modules.opu.base.Stabilimento  stab = new org.aspcfs.modules.opu.base.Stabilimento (db, idStab);
                    organization = new Organization();
                    organization.setIdStabilimento(audit.getIdStabilimento());
                    organization.setName(stab.getOperatore().getRagioneSociale());
                    organization.setCategoriaRischio(stab.getCategoriaRischio());
            }
			}
			
			context.getRequest().setAttribute("OrgDetails", organization);
			LookupList siteList = new LookupList(db, "lookup_site_id");
			context.getRequest().setAttribute("SiteList", siteList);
			
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		finally 
		{
			this.freeConnection(context, db);
		}
		 return "stampaChecklistOk";
	 }
	

	
}
