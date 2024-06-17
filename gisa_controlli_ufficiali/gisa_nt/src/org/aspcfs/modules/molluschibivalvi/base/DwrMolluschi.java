package org.aspcfs.modules.molluschibivalvi.base;

	import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.utils.GestoreConnessioni;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;

import com.darkhorseventures.database.ConnectionElement;

	public class DwrMolluschi { 


		
		public static void updateFlag(int orgId, String value) throws SQLException
		{
			
			
			Connection db = null ;
			WebContext ctx = WebContextFactory.get();
			ConnectionElement ce = (ConnectionElement) ctx.getSession().getAttribute("ConnectionElement");
			SystemStatus systemStatus = (SystemStatus) ((Hashtable) ctx.getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
			HttpServletRequest req = ctx.getHttpServletRequest();
			
			UserBean user = (UserBean) ctx.getSession().getAttribute("User");
			int userId = user.getUserId();
			
			try {
				db = GestoreConnessioni.getConnection();
				String sqlVer = "update organization set taglia_non_commerciale = ?, taglia_non_commerciale_data_modifica = now() where org_id = ? ";
				PreparedStatement pst = null ;
			
				pst = db.prepareStatement(sqlVer);
				pst.setBoolean(1, Boolean.valueOf(value));
				pst.setInt(2, orgId);
				pst.executeUpdate();
	
				
			} catch (SQLException e) {
				throw e ;
			}
			catch (NumberFormatException g) {
				throw g ;
			}	
			finally
			{
				GestoreConnessioni.freeConnection(db);
			}
		}
		
		
		
	}


