package org.aspcfs.modules.managedpat.actions;

import java.sql.Connection;
import java.util.HashMap;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.Constants;

import com.darkhorseventures.framework.actions.ActionContext;
import com.isavvix.tools.FileInfo;
import com.isavvix.tools.HttpMultiPartParser;
import com.zeroio.iteam.base.FileItem;

public final class ManageDPAT extends CFSModule {

public String executeCommandDashboard(ActionContext context) {
	
		 if (!hasPermission(context, "accounts-dashboard-view")) {
			 if (!hasPermission(context, "global-search-view")) {
		        return ("PermissionError");
		     }
			 this.deletePagedListInfo(context, "SearchOrgListInfo");
			 //Bypass dashboard and search form for portal users
		   
		 }   return (executeCommandSearchForm(context));
		  
	}

	public String executeCommandSearchForm(ActionContext context) {
		if (!(hasPermission(context, "global-search-view"))) {
			return ("PermissionError");
		}
		
		return "ListOK";
		
		//
  
	}
	
	 public String executeCommandUpload(ActionContext context) {
		   
		    Organization thisOrg = null;
		    boolean recordInserted = false;
		    boolean isValid = false;
		    Connection db = null;
		    try {
		    	
		    		
		      db = this.getConnection(context);
		      String filePath = this.getPath(context, "accounts");
		      //Process the form data
		      HttpMultiPartParser multiPart = new HttpMultiPartParser();
		      multiPart.setUsePathParam(false);
		      multiPart.setUseUniqueName(true);
		      multiPart.setUseDateForFolder(true);
		      multiPart.setExtensionId(getUserId(context));
		     
		      HashMap parts = multiPart.parseData(context.getRequest(), filePath);
		      
		      context.getRequest().setAttribute("TipoAllegato", (String) parts.get("TipoAllegato"));
			    
		      String id = (String) parts.get("id");
		      String subject = (String) parts.get("subject");
		      String folderId = (String) parts.get("folderId");
		      String actionStepWork = (String) parts.get("actionStepWork");
		      String allowPortalAccess = (String) parts.get("allowPortalAccess");
		      if (folderId != null) {
		        context.getRequest().setAttribute("folderId", folderId);
		      }
		      if (subject != null) {
		        context.getRequest().setAttribute("subject", subject);
		      }
		      if (actionStepWork != null) {
		        context.getRequest().setAttribute("actionStepWork", actionStepWork);
		      }
		      
		    
		      FileInfo ftest = new FileInfo();
		      
		      FileInfo ftest2 =  (FileInfo)  parts.get("id" + (String) parts.get("id"));
		      if (ftest2 instanceof FileInfo) {
		        //Update the database with the resulting file
		        FileInfo newFileInfo = (FileInfo) parts.get("id" + id);
		        //Insert a file description record into the database
		        FileItem thisItem = new FileItem();
		        thisItem.setLinkModuleId(Constants.ACCOUNTS);
		        thisItem.setLinkItemId(Integer.parseInt(id));
		        thisItem.setEnteredBy(getUserId(context));
		        thisItem.setModifiedBy(getUserId(context));
		        thisItem.setFolderId(Integer.parseInt(folderId));
		        thisItem.setSubject(subject);
		        thisItem.setClientFilename(newFileInfo.getClientFileName());
		        thisItem.setFilename(newFileInfo.getRealFilename());
		        thisItem.setVersion(1.0);
		        thisItem.setSize(newFileInfo.getSize());
		        thisItem.setAllowPortalAccess(allowPortalAccess);
		        isValid = this.validateObject(context, db, thisItem);
		        if (isValid) {
		          recordInserted = thisItem.insert(db);
		        }
		        if (recordInserted) {
		          this.processInsertHook(context, thisItem);
		          context.getRequest().setAttribute("fileItem", thisItem);
		          context.getRequest().setAttribute("subject", "");
		       
	  	          context.getRequest().setAttribute("idFile", thisItem.getId());
	  	          context.getRequest().setAttribute("fileCaricato", "yes");
		        }
		      } else {
		        recordInserted = false;
		        HashMap errors = new HashMap();
		        SystemStatus systemStatus = this.getSystemStatus(context);
		        errors.put(
		            "actionError", systemStatus.getLabel(
		                "object.validation.incorrectFileName"));
		        if (subject != null && "".equals(subject.trim())) {
		          errors.put(
		              "subjectError", systemStatus.getLabel(
		                  "object.validation.required"));
		        }
		        processErrors(context, errors);
		      }
		      
		    } catch (Exception e) {
		      context.getRequest().setAttribute("Error", e);
		      return ("SystemError");
		    } finally{
		    	freeConnection(context, db);
		    }
		      return ("UploadListaOK");

		    
		  }
}