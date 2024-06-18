package it.us.web.action.vam.cc.ricoveri;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.StrutturaClinica;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupDiagnosi;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class Detail extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("ricoveri");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		
		ArrayList<StrutturaClinica> struttureCliniche = (ArrayList<StrutturaClinica>) persistence.getNamedQuery("GetStruttureRicovero").setInteger("idUtente", utente.getId()).list();

		req.setAttribute("sc", struttureCliniche);	
		
		if(cc.getRicoveroData()==null){
			redirectTo( "vam.cc.ricoveri.ToEdit.us" );	
		}else{
			gotoPage("/jsp/vam/cc/ricoveri/detail.jsp");
		}
	}
}

