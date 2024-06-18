package it.us.web.action.vam.magazzino.articoliSanitari;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CaricoArticoloSanitario;
import it.us.web.bean.vam.CaricoFarmaco;
import it.us.web.bean.vam.MagazzinoArticoliSanitari;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.ScaricoArticoloSanitario;
import it.us.web.bean.vam.ScaricoFarmaco;
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
		BGuiView gui = GuiViewDAO.getView( "MAGAZZINO", "AS", "DETAIL" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("magazzinoAS");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
								
		MagazzinoArticoliSanitari magazzinoArticoliSanitari = (MagazzinoArticoliSanitari) persistence.find (MagazzinoArticoliSanitari.class, interoFromRequest("idMagazzino"));
		req.setAttribute("magazzinoArticoliSanitari", magazzinoArticoliSanitari);
		
		String tipoStorico = stringaFromRequest("tipoStorico");
		
		if (tipoStorico.equalsIgnoreCase("sc")) {			
			Set<CaricoArticoloSanitario> listCaricoArticoliSanitari	 = (Set<CaricoArticoloSanitario>) magazzinoArticoliSanitari.getCaricoArticoliSanitari();			
			req.setAttribute("listCaricoArticoliSanitari", listCaricoArticoliSanitari);
			gotoPage("popup", "/jsp/vam/magazzino/articoliSanitari/storicoCarico.jsp");
		
		}
		else {			
			Set<ScaricoArticoloSanitario> listScaricoArticoliSanitari = (Set<ScaricoArticoloSanitario>) magazzinoArticoliSanitari.getScaricoArticoliSanitari();
			req.setAttribute("listScaricoArticoliSanitari", listScaricoArticoliSanitari);
			gotoPage("popup", "/jsp/vam/magazzino/articoliSanitari/storicoScarico.jsp");
		}
			
	}

}




