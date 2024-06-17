package org.aspcfs.modules.reportisticainterna.actions;

import java.sql.Connection;
import java.util.ArrayList;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.reportisticainterna.base.Report;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;

public final class ReportisticaInterna extends CFSModule {

	public String executeCommandDefault(ActionContext context) {

		if (!(hasPermission(context, "reportistica-interna-view"))) {
			return ("PermissionError");
		}

		Connection db = null;
		try {
			db = this.getConnection(context);
			
			ArrayList<Report> listaReport = new ArrayList<Report>();
			listaReport = Report.getElenco(db);
			context.getRequest().setAttribute("listaReport", listaReport);

			LookupList siteList = new LookupList(db, "lookup_site_id");
			siteList.removeElementByCode(16);
			//siteList.addItem(300, "TUTTE");
			context.getRequest().setAttribute("SiteList", siteList);
		
		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		return ("DefaultOK");
	}

	 public String executeCommandReport(ActionContext context) {

			if (!(hasPermission(context, "reportistica-interna-view"))) {
				return ("PermissionError");
			}

			Connection db = null;
			try {
				db = this.getConnection(context);
				
				int idReport = Integer.parseInt(context.getRequest().getParameter("idReport")); 
				int idAsl = Integer.parseInt(context.getRequest().getParameter("idAsl")); 
				
				Report report = new Report(db, idReport);
				report.eseguiQueryCount(db, idAsl); 
				context.getRequest().setAttribute("report", report); 
				
				LookupList siteList = new LookupList(db, "lookup_site_id");
				siteList.removeElementByCode(16);
				//siteList.addItem(300, "TUTTE"); 
				context.getRequest().setAttribute("SiteList", siteList);
				
				context.getRequest().setAttribute("idAsl", String.valueOf(idAsl)); 

			} catch (Exception errorMessage) {
				context.getRequest().setAttribute("Error", errorMessage);
				return ("SystemError");
			} finally {
				this.freeConnection(context, db);
			}
			return ("ReportOK");
		}
	 
	 public String executeCommandLista(ActionContext context) {

			if (!(hasPermission(context, "reportistica-interna-view"))) {
				return ("PermissionError");
			}

			Connection db = null;
			try {
				db = this.getConnection(context);
				
					
				int idReport = Integer.parseInt(context.getRequest().getParameter("idReport")); 
				int idAsl = Integer.parseInt(context.getRequest().getParameter("idAsl")); 
				String fonte = context.getRequest().getParameter("fonte"); 

				Report report = new Report(db, idReport);
				report.eseguiQuery(db, idAsl, fonte);
				context.getRequest().setAttribute("report", report); 
				
				LookupList siteList = new LookupList(db, "lookup_site_id"); 
				siteList.removeElementByCode(16);
				//siteList.addItem(300, "TUTTE"); 
				context.getRequest().setAttribute("SiteList", siteList);
				
				context.getRequest().setAttribute("idAsl", String.valueOf(idAsl)); 

			} catch (Exception errorMessage) {
				context.getRequest().setAttribute("Error", errorMessage);
				return ("SystemError");
			} finally {
				this.freeConnection(context, db);
			}
			return ("ReportListaOK");
		}
	 
	 public String executeCommandListaNonPresenti(ActionContext context) {

			if (!(hasPermission(context, "reportistica-interna-view"))) {
				return ("PermissionError");
			}

			Connection db = null;
			try {
				db = this.getConnection(context);
				
					
				int idReport = Integer.parseInt(context.getRequest().getParameter("idReport")); 
				int idAsl = Integer.parseInt(context.getRequest().getParameter("idAsl")); 
				String fonte = context.getRequest().getParameter("fonte"); 

				Report report = new Report(db, idReport);
				report.eseguiQueryRecordNonPresenti(db, idAsl, fonte);
				context.getRequest().setAttribute("report", report); 
				
				LookupList siteList = new LookupList(db, "lookup_site_id");
				siteList.removeElementByCode(16);
				//siteList.addItem(300, "TUTTE"); 
				context.getRequest().setAttribute("SiteList", siteList);
				
				context.getRequest().setAttribute("idAsl", String.valueOf(idAsl)); 

			} catch (Exception errorMessage) {
				context.getRequest().setAttribute("Error", errorMessage);
				return ("SystemError");
			} finally {
				this.freeConnection(context, db);
			}
			return ("ReportListaOK");
		}
	
}

