package it.us.web.tag.vam;

import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.lookup.LookupOperazioniAccettazione;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.dao.hibernate.PersistenceFactory;
import it.us.web.tag.GenericTag;

import javax.servlet.jsp.JspWriter;

public class Checked extends GenericTag
{
	private static final long serialVersionUID = 1L;
	private static final String checkedText = "checked=\"checked\"";
	
	private int idAccettazione;
	private int idLookupOperazione;
	private Persistence persistence;
	
	public int doStartTag()
	{
		try
		{
			persistence = PersistenceFactory.getPersistence();
			
//			ServletRequest req = pageContext.getRequest();
			JspWriter o = pageContext.getOut();
			
			
			if( idAccettazione > 0 && idLookupOperazione > 0 && persistence != null )
			{
				Accettazione acc = (Accettazione) persistence.find( Accettazione.class, idAccettazione );
				LookupOperazioniAccettazione op = (LookupOperazioniAccettazione) 
					persistence.find( LookupOperazioniAccettazione.class, idLookupOperazione );
			
				if( acc.getOperazioniRichieste().contains( op ) )
				{
					o.print(  checkedText  );
				}
			}
			
			return SKIP_BODY;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			PersistenceFactory.closePersistence( persistence, true );
		}
		
		return SKIP_BODY;
	}
	
		
	public int doEndTag()
	{
		return EVAL_BODY_INCLUDE;
	}


	public int getIdAccettazione() {
		return idAccettazione;
	}


	public void setIdAccettazione(int idAccettazione) {
		this.idAccettazione = idAccettazione;
	}


	public int getIdLookupOperazione() {
		return idLookupOperazione;
	}


	public void setIdLookupOperazione(int idLookupOperazione) {
		this.idLookupOperazione = idLookupOperazione;
	}


}