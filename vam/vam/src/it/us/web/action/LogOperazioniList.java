package it.us.web.action;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.bean.BGuiView;
import it.us.web.bean.UserOperation;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class LogOperazioniList extends GenericAction {

	@Override
	public void can() throws AuthorizationException, Exception {
		BGuiView gui = GuiViewDAO.getView( "LOG_OPERAZIONI", "FUNZIONI", "LIST" );
		can( gui, "w" );
	}

	@Override
	public void setSegnalibroDocumentazione() {
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	
	@Override
	public void execute() throws Exception {
		String username = (String) req.getParameter("username");
		String dateStart = (String) req.getParameter("dateStart");
		String dateEnd = (String) req.getParameter("dateEnd");
		ArrayList<UserOperation> op_list = new ArrayList<UserOperation>();
		
		Context ctx;
		Connection db = null;
		try {
			ctx = new InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/storico");
			db = ds.getConnection();
			if (db!=null){
				UserOperation o = new UserOperation();
				op_list = o.buildList(db, username, dateStart, dateEnd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (db!=null){
				try {
					db.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		req.setAttribute("op_list", op_list);
		gotoPage("/jsp/logOperazioni/list.jsp");
	}
}
