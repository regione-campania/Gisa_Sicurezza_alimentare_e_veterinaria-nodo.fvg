package it.us.web.action.vam.magazzino.mangimi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CaricoFarmaco;
import it.us.web.bean.vam.CaricoMangime;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.MagazzinoMangimi;
import it.us.web.bean.vam.ScaricoFarmaco;
import it.us.web.bean.vam.ScaricoMangime;
import it.us.web.bean.vam.lookup.LookupFarmaci;
import it.us.web.bean.vam.lookup.LookupTipiFarmaco;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.MagazzinoFarmaciUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.Set;

import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Storico extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "MAGAZZINO", "MANGIMI", "DETAIL" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("magazzinoMangimi");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
								
		MagazzinoMangimi magazzinoMangimi = (MagazzinoMangimi) persistence.find (MagazzinoMangimi.class, interoFromRequest("idMagazzino"));
		req.setAttribute("magazzinoMangimi", magazzinoMangimi);
		
		String tipoStorico = stringaFromRequest("tipoStorico");
		
		if (tipoStorico.equalsIgnoreCase("sc")) {			
			Set<CaricoMangime> listCaricoMangimi	 = (Set<CaricoMangime>) magazzinoMangimi.getCaricoMangimi();			
			req.setAttribute("listCaricoMangimi", listCaricoMangimi);
			gotoPage("popup", "/jsp/vam/magazzino/mangimi/storicoCarico.jsp");
		
		}
		else {			
			Set<ScaricoMangime> listScaricoMangimi = (Set<ScaricoMangime>) magazzinoMangimi.getScaricoMangimi();
			req.setAttribute("listScaricoMangimi", listScaricoMangimi);
			gotoPage("popup", "/jsp/vam/magazzino/mangimi/storicoScarico.jsp");
		}
			
	}

}




