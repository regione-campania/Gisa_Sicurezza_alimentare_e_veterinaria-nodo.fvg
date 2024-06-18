package it.us.web.action.testing;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.lookup.LookupAutopsiaFenomeniCadaverici;
import it.us.web.bean.vam.lookup.LookupAutopsiaModalitaConservazione;
import it.us.web.bean.vam.lookup.LookupAutopsiaOrgani;
import it.us.web.bean.vam.lookup.LookupAutopsiaTipiEsami;
import it.us.web.bean.vam.lookup.LookupCMF;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.Screenshot;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;

import javax.imageio.ImageIO;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class ToAddError extends GenericAction {

	
	public void can() throws AuthorizationException
	{
//		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
//		can( gui, "w" );
	}

	public void execute() throws Exception
	{
		
		String path = context.getRealPath("");		
				
		Screenshot s = new Screenshot();
		BufferedImage bi = s.takeBufferedScreenshot();
		ImageIO.write(bi, "jpg", new File(path+"/testingImages/c.jpg")); 
				
		gotoPage("/jsp/testing/add.jsp");
			
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}
}


