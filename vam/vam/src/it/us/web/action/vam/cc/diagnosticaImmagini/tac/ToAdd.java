package it.us.web.action.vam.cc.diagnosticaImmagini.tac;

import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;

import it.us.web.dao.GuiViewDAO;

public class ToAdd extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );

	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("tac");
	}

	public void execute() throws Exception
	{

			gotoPage("/jsp/vam/cc/diagnosticaImmagini/tac/add.jsp");

	}
}

