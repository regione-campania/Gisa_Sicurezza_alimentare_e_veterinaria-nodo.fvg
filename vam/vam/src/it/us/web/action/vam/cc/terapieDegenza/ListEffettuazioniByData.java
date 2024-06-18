package it.us.web.action.vam.cc.terapieDegenza;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.TerapiaAssegnata;
import it.us.web.bean.vam.TerapiaEffettuata;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class ListEffettuazioniByData extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "LIST", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("terapia");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		
		Timestamp dataEffettuazioniFrom = dataFromRequest("dataEffettuazioni");
		Timestamp dataEffettuazioniTo   = dataFromRequest("dataEffettuazioni");
		
		/* Per recuperare le assegnazione nella data richiesta vengono settate
		 * 2 date (dataFrom e dataTo). La prima corrispondente alla data in calendario
		 * selezionata, la seconda corrispondente alle 00:00 del giorno successivo*/
		dataEffettuazioniFrom.setHours(00);
		dataEffettuazioniFrom.setMinutes(00);
		dataEffettuazioniFrom.setSeconds(00);
				
		dataEffettuazioniTo.setDate(dataEffettuazioniTo.getDate()+1);		
		dataEffettuazioniTo.setHours(00);
		dataEffettuazioniTo.setMinutes(00);
		dataEffettuazioniTo.setSeconds(00);
			
		
		//Recupero di tutte le terapie per data
		ArrayList<TerapiaEffettuata> teList = (ArrayList<TerapiaEffettuata>) persistence.getNamedQuery("GetTerapieEffettuateByData")
		.setDate("dataEffettuazioniFrom", dataEffettuazioniFrom)
		.setDate("dataEffettuazioniTo", dataEffettuazioniTo)
		.setInteger("idTerapiaDegenza", interoFromRequest("idTerapiaDegenza"))
		.list();
	
		req.setAttribute("teList", teList);	
											
		gotoPage("popup", "/jsp/vam/cc/terapieDegenza/listEffettuazioni.jsp");
	}
}


