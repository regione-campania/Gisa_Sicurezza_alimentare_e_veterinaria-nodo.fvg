package it.us.web.action;

import javax.naming.InitialContext;

import it.us.web.bean.BGuiView;
import it.us.web.bean.UserOperation;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import javax.naming.Context;
import javax.naming.InitialContext;

import java.sql.Connection;
import java.sql.SQLException;


public class LogOperazioniDetail extends GenericAction {

	@Override
	public void can() throws AuthorizationException, Exception {
		BGuiView gui = GuiViewDAO.getView( "LOG_OPERAZIONI", "FUNZIONI", "DETAIL" );
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
		int idOp = interoFromRequest("idOp"); 
		Context ctx = null;
		Connection db = null;
		UserOperation op = new UserOperation();
		try {
			ctx = new InitialContext();
			javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/storico");
			db = ds.getConnection();
			if (db!=null){
				op = op.buildRecord(db, idOp);
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
		req.setAttribute("op", op);
		gotoPage("/jsp/logOperazioni/detail.jsp");
	}


}
