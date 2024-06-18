package it.us.web.action.messaggi;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Enumeration;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;

import it.us.web.action.GenericAction;
import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;

public class ToModifica extends GenericAction {

	@Override
	public void can() throws AuthorizationException
	{
		can(GuiViewDAO.getView("AMMINISTRAZIONE", "MAIN", "MAIN"), "w");
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		Connection db = ds.getConnection();
		
		PreparedStatement pst = null;
		String sql = "select * from dblink_get_messaggio_home(?,?);";
		pst = db.prepareStatement(sql);
		pst.setString(1, Application.get("ambiente"));
		pst.setString(2, "vam");
		ResultSet rs = pst.executeQuery();

		String messaggio = "";
		
		while(rs.next()){
			messaggio = rs.getString(1);
		}
		
		messaggio = messaggio.replaceAll("<center>","");
		messaggio = messaggio.replaceAll("</center>","");
		messaggio = messaggio.replaceAll("<h1>","");
		messaggio = messaggio.replaceAll("</h1>","");
		
		String pathFile = context.getRealPath("jsp/messaggi/messaggio.txt");
		File f = new File(pathFile);
		
		FileOutputStream fos = new FileOutputStream(f);
		PrintStream ps = new PrintStream(fos);
		
		String msg = messaggio;
		ps.print(msg);
		ps.flush();
		
		Timestamp dataUltimaModifica = new Timestamp(System.currentTimeMillis());
        context.setAttribute("MessaggioHome", dataUltimaModifica+"&&<b>"+messaggio+"</b>");
        
		gotoPage("/jsp/messaggi/modifica.jsp");
	}
}	
