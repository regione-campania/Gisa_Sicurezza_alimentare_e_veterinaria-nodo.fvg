package org.aspcfs.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.actions.CFSModule;

import com.darkhorseventures.framework.actions.ActionContext;

public class DownloadAppMobile extends CFSModule{
	
	public String  executeCommandSuiteAppMobile(ActionContext context) {
		return "SuiteAppMobile";
	}
	
	public String executeCommandAppMobileIosPreaccettazionesigla(ActionContext context) {
		
		Connection db = null;

        try{
        	 String ambiente = org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("ambiente");
        	 String codice_riscatto_app = "";
        	 
        	 if(ambiente.equalsIgnoreCase("ufficiale")){
        		 db = this.getConnection(context);
            	 String sql = "select download_app_mobile from download_app_mobile(?, ?);";
             	 PreparedStatement st = db.prepareStatement(sql);
             	 st.setInt(1, 1);
             	 st.setInt(2, getUserId(context));
                 ResultSet rs = st.executeQuery();

                 while(rs.next()){
                	 codice_riscatto_app = rs.getString("download_app_mobile");
                 }
        	 } else {
        		 codice_riscatto_app = "ambientedemo";
        	 }
        	 
             context.getRequest().setAttribute("codice_riscatto_app", codice_riscatto_app);
             
        }catch (SQLException e) {
        	e.printStackTrace();
        } finally {
            this.freeConnection(context, db);
        }
		
		return "AppMobileIosPreaccettazionesiglaOK";
	}
	
	
	public String executeCommandRigeneraAppMobileIosPreaccettazionesigla(ActionContext context) {
		
		Connection db = null;

        try{
        	String ambiente = org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("ambiente");
       	 	String codice_riscatto_app = "";
       	 
       	 	if(ambiente.equalsIgnoreCase("ufficiale")){
        	
				db = this.getConnection(context);
				String sql = "select riassegnazione_codice_app_mobile from riassegnazione_codice_app_mobile(?, ?);";
				PreparedStatement st = db.prepareStatement(sql);
				st.setInt(1, 1);
				st.setInt(2, getUserId(context));
				ResultSet rs = st.executeQuery();
				 
				while(rs.next()){
					codice_riscatto_app = rs.getString("riassegnazione_codice_app_mobile");
				}
       	 	} else {
       	 		codice_riscatto_app = "ambientedemo";
       	 	}
            context.getRequest().setAttribute("codice_riscatto_app", codice_riscatto_app);
             
        }catch (SQLException e) {
        	e.printStackTrace();
        } finally {
            this.freeConnection(context, db);
        }
		
		return "AppMobileIosPreaccettazionesiglaOK";
	}
	
public String executeCommandAppMobileIosGisaWebGis(ActionContext context) {
		
		Connection db = null;

        try{
        	String ambiente = org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("ambiente");
       	 	String codice_riscatto_app = "";
       	 
       	 	if(ambiente.equalsIgnoreCase("ufficiale")){
	        	 db = this.getConnection(context);
	        	 String sql = "select download_app_mobile from download_app_mobile(?, ?);";
	         	 PreparedStatement st = db.prepareStatement(sql);
	         	 st.setInt(1, 2); //id app gisa webgis = 2
	         	 st.setInt(2, getUserId(context));
	             ResultSet rs = st.executeQuery();

	             while(rs.next()){
	            	 codice_riscatto_app = rs.getString("download_app_mobile");
	             }
       	 	} else {
       	 		codice_riscatto_app = "ambientedemo";
       	 	}
            context.getRequest().setAttribute("codice_riscatto_app", codice_riscatto_app);
             
        }catch (SQLException e) {
        	e.printStackTrace();
        } finally {
            this.freeConnection(context, db);
        }
		
		return "AppMobileIosGisaWebGisOK";
	}
	
	
	public String executeCommandRigeneraAppMobileIosGisaWebGis(ActionContext context) {
		
		Connection db = null;

        try{
        	String ambiente = org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("ambiente");
       	 	String codice_riscatto_app = "";
       	 
       	 	if(ambiente.equalsIgnoreCase("ufficiale")){
	        	 db = this.getConnection(context);
	        	 String sql = "select riassegnazione_codice_app_mobile from riassegnazione_codice_app_mobile(?, ?);";
	         	 PreparedStatement st = db.prepareStatement(sql);
	         	 st.setInt(1, 2); //id app gisa webgis = 2
	         	 st.setInt(2, getUserId(context));
	             ResultSet rs = st.executeQuery();
	          
	             while(rs.next()){
	            	 codice_riscatto_app = rs.getString("riassegnazione_codice_app_mobile");
	             }
       	 	} else {
       	 		codice_riscatto_app = "ambientedemo";
       	 	}
            context.getRequest().setAttribute("codice_riscatto_app", codice_riscatto_app);
             
        }catch (SQLException e) {
        	e.printStackTrace();
        } finally {
            this.freeConnection(context, db);
        }
		
		return "AppMobileIosGisaWebGisOK";
	}

}
