package it.us.web.action.vam.cc.esamiIstopatologici;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class List extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		Set<EsameIstopatologico> istopatologici = new HashSet<EsameIstopatologico>();
		if(!cc.getTrasferimentiByCcPostTrasf().isEmpty())
		{
			istopatologici = cc.getTrasferimentiByCcPostTrasf().iterator().next().getCartellaClinica().getEsameIstopatologicos();
		}
		if(!cc.getEsameIstopatologicos().isEmpty())
		{
			Iterator<EsameIstopatologico> iters = cc.getEsameIstopatologicos().iterator();
			while(iters.hasNext())
			{
				EsameIstopatologico esame=iters.next();
				if(esame.getTipoDiagnosi().getId()!=3)
					esame.setDiagnosiNonTumorale("");
				istopatologici.add(esame);
			}
		}
		
		
		req.setAttribute("istopatologici", istopatologici);
				
		gotoPage("/jsp/vam/cc/esamiIstopatologici/list.jsp");
	}
}



