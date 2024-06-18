
package it.us.web.servlet;

import it.us.web.action.Action;
import it.us.web.action.GenericAction;
import it.us.web.action.Index;
import it.us.web.action.ws.AggiornamentoFunzioniConcesseAddUtente;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.SuperUtenteDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.dao.hibernate.PersistenceFactory;
import it.us.web.exceptions.ActionNotValidException;
import it.us.web.exceptions.NotLoggedException;
import it.us.web.permessi.Permessi;
import it.us.web.util.DateUtils;
import it.us.web.util.FloatConverter;
import it.us.web.util.MyDoubleConverter;
import it.us.web.util.MyIntegerConverter;
import it.us.web.util.properties.Application;
import it.us.web.util.properties.Message;

import java.io.IOException;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.ConvertUtils;

public class ReloadUtenti extends HttpServlet
{
	private static final long serialVersionUID = -8397394451535054535L;

	protected void service(HttpServletRequest req, HttpServletResponse res)
			throws
				ServletException,
				IOException
		{
		try
		{
			
			if(req.getParameter("username")==null || "".equals(req.getParameter("username"))){
				if("add".equals(req.getParameter("type"))||"".equals(req.getParameter("type"))||req.getParameter("type")==null)
				res.sendRedirect(req.getContextPath()+"/ws.AggiornamentoFunzioniConcesseAddUtente.us");
				if("modify".equals(req.getParameter("type")))
					res.sendRedirect(req.getContextPath()+"/ws.AggiornamentoFunzioniConcesseEditUtente.us");

			}
			if("add".equals(req.getParameter("type"))||"".equals(req.getParameter("type"))||req.getParameter("type")==null)
				res.sendRedirect(req.getContextPath()+"/ws.AggiornamentoFunzioniConcesseAddUtente.us?username="+req.getParameter("username"));
				if("modify".equals(req.getParameter("type")))
					res.sendRedirect(req.getContextPath()+"/ws.AggiornamentoFunzioniConcesseEditUtente.us?username="+req.getParameter("username"));

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		
	
	}
	
	
	
	
}

