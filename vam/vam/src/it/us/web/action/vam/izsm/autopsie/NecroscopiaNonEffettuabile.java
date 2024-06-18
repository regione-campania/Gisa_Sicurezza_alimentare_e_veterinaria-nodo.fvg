package it.us.web.action.vam.izsm.autopsie;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Animale;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class NecroscopiaNonEffettuabile extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("esameNecroscopico");
	}

	public void execute() throws Exception
	{				
		Animale a = cc.getAccettazione().getAnimale();
		a.setNecroscopiaNonEffettuabile(booleanoFromRequest("flag"));
		persistence.update(a);
		persistence.commit();
		
		setMessaggio("Esame Necroscopico dichiarato " + (booleanoFromRequest("flag")?("non ") : ("")) + "effettuabile");
		goToAction(new it.us.web.action.vam.izsm.autopsie.List());
	}	
}




