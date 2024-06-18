package it.us.web.action.vam.cc.trasferimenti;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.StatoTrasferimento;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.constants.Specie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.Set;

public class ToRiconsegna extends GenericAction  implements Specie
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
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
	
		Set<Trasferimento> trasfs = null;
		if(!cc.getCcPostTrasferimento() && !cc.getCcRiconsegna())
			trasfs = cc.getTrasferimenti();
		else if(cc.getCcPostTrasferimentoMorto())
			trasfs = cc.getTrasferimentiByCcMortoPostTrasf();
		else if(cc.getCcPostTrasferimento())
			trasfs = cc.getTrasferimentiByCcPostTrasf();
		else if(cc.getCcRiconsegna())
			trasfs = cc.getTrasferimentiByCcPostRiconsegna();
		
		Trasferimento trasferimento = null;
		for( Trasferimento trasf: trasfs )
		{
			if( trasf.getStato().stato == StatoTrasferimento.ACCETTATO_DESTINATARIO || trasf.getStato().stato == StatoTrasferimento.RIFIUTATO_RINCONSEGNA_CRIUV )//trasferimento aperto
			{
				trasferimento = trasf;
			}
		}
		
		req.setAttribute( "trasferimento", trasferimento );
		
		gotoPage( "/jsp/vam/cc/trasferimenti/riconsegna.jsp" );
	}

}
