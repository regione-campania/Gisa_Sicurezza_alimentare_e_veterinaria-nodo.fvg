package it.us.web.action.vam.cc.trasferimenti;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.constants.Specie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToRifiutoCriuv extends GenericAction  implements Specie
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "TRASFERIMENTI", "CRIUV", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("trasferimenti");
	}

	@Override
	public void execute() throws Exception
	{
		int idTr = interoFromRequest( "id" );
		Trasferimento trasferimento = (Trasferimento) persistence.find( Trasferimento.class, idTr );
		
		req.setAttribute( "trasferimento", trasferimento );
		
		gotoPage( "/jsp/vam/cc/trasferimenti/rifiutoCriuv.jsp" );
	}

}
