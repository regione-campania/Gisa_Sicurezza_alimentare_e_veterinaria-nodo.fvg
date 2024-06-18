package org.aspcfs.modules.richiestecontributi.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.utils.DatabaseUtils;

import com.darkhorseventures.framework.actions.ActionContext;

public class QTestBean {
	public String query;
	
//	private static Logger log = Logger.getLogger(org.aspcfs.modules.richiestecontributi.base.ListaCani.class);
	private transient static java.util.logging.Logger logger = java.util.logging.Logger.getLogger("MainLogger");

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}
	
	public ResultSet executeQuery (Connection db, String query,ActionContext context)throws SQLException {
		
		PreparedStatement ps = db.prepareStatement(query);
		ResultSet rs = null;
		try
		{
			 rs = DatabaseUtils.executeQuery(db, ps);
		}
		catch(SQLException e)
		{
			logger.severe("[CANINA] - EXCEPTION nel metodo executeQuery della classe QTestBean");
			context.getRequest().setAttribute("ErroreQ", e.getMessage());
		}
		
		
		return rs;
		
				
	}
}
