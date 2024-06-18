package it.us.web.action.vam.cc.diagnosi;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Diagnosi;
import it.us.web.bean.vam.DiagnosiEffettuate;
import it.us.web.bean.vam.lookup.LookupDiagnosi;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.DateUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.hibernate.HibernateException;
import org.hibernate.criterion.Order;

public class Add extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("diagnosi");
	}

	public void execute() throws Exception
	{		
		final Logger logger = LoggerFactory.getLogger(Add.class);
			
		Date dataDiagnosi = DateUtils.parseDateUtil(req.getParameter("dataDiagnosi"));	
		
		Diagnosi diagnosi = new Diagnosi();
		DiagnosiEffettuate diagnosiEffettuate = new DiagnosiEffettuate();
		
		diagnosi.setDataDiagnosi(dataDiagnosi);
		diagnosi.setCartellaClinica( cc );		
		diagnosi.setEntered(new Date());		
		diagnosi.setEnteredBy(utente);
		diagnosi.setModified(new Date());		
		diagnosi.setModifiedBy(utente);	
		diagnosi.setNote(req.getParameter("note"));
		diagnosi.setDiagnosi(stringaFromRequest("diagnosi"));
		diagnosi.setTipoDiagnosi(stringaFromRequest("tipoDiagnosi"));
		
		try {
			persistence.insert(diagnosi);
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(diagnosi);
			}			
			
			ArrayList<LookupDiagnosi> listaDiagnosi = (ArrayList<LookupDiagnosi>) persistence.createCriteria( LookupDiagnosi.class )
			.addOrder( Order.asc( "level" ) )
			.list();
			
			LookupDiagnosi diagnosiCorrente;
			HashSet<DiagnosiEffettuate> listaDiagnosiEffettuate = new HashSet<DiagnosiEffettuate>();
			DiagnosiEffettuate de = null;
			
			for(int i=0; i<listaDiagnosi.size();i++) {
				
				diagnosiCorrente = (LookupDiagnosi) listaDiagnosi.get(i);
				
				if (req.getParameter("op_"+diagnosiCorrente.getId())!=null) {
					
					de = new DiagnosiEffettuate();
					
					de.setDiagnosi(diagnosi);
					de.setListaDiagnosi(diagnosiCorrente);
					
					String tipoDiagnosi = "";
					if (stringaFromRequest("tipoDiagnosi_"+diagnosiCorrente.getId()) != null)
						tipoDiagnosi = req.getParameter("tipoDiagnosi_"+diagnosiCorrente.getId());
					
					if (tipoDiagnosi.equalsIgnoreCase("Provata")) {
						de.setProvata(true);
					}					
					else {
						de.setProvata(false);
					}
						
					persistence.insert(de);
					if(cc.getDataChiusura()!=null)
					{
						beanModificati.add(de);
					}
					cc.setModified( new Date() );
					cc.setModifiedBy( utente );
					persistence.update( cc );
														
				}					
			}
		
		persistence.commit();
		
		}
		catch (RuntimeException e)
		{
			try
			{		
				persistence.rollBack();				
			}
			catch (HibernateException e1)
			{				
				logger.error("Error during Rollback transaction" + e1.getMessage());
			}
			logger.error("Cannot save Diagnosi" + e.getMessage());
			throw e;		
		}
		
		setMessaggio("Diagnosi inserita");
		redirectTo("vam.cc.diagnosi.List.us");
		//gotoPage("/jsp/vam/cc/esamiSangue/add.jsp");
		
		
			
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Diagnosi";
	}
}
