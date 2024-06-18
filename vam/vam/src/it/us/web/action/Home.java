package it.us.web.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.validation.ConstraintViolationException;

import org.hibernate.criterion.Restrictions;

import it.us.web.bean.vam.StatoTrasferimento;
import it.us.web.bean.vam.Trasferimento;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;

public class Home extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		isLoggedSession();
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("login");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		String entrypointSinantropi = null;
		
		if(session!=null)
			entrypointSinantropi = (String)session.getAttribute("entrypointSinantropi");
		try
		{
			if( utente != null && !context.getAttribute("dbMode").equals("slave")) //riallaccio l'utente al db (altrimenti in fase di login schiatta per via del fetch lazy)
			{
				persistence.update( utente );
			}
		}
		catch(org.hibernate.exception.ConstraintViolationException e)
		{
			System.out.println("Eccezione non bloccante: " + e.getMessage());
		}
		
		String system = (String) session.getAttribute("system");
		
		
		if (system.equalsIgnoreCase("vam"))
		{
			Set<Trasferimento> trasferimentiDaAccettare = new HashSet<Trasferimento>();
			if(utente.getClinica()!=null)
			{
				trasferimentiDaAccettare = utente.getClinica().getTrasferimentiIngressoDaAccettare();
			}
				
			//long millisToday = System.currentTimeMillis();
			//Date dataSettimanaScorsa = new Date(millisToday-(60*60*24*7)*1000);
			
			/*ArrayList<Trasferimento> trasferimentiRientranti = (ArrayList<Trasferimento>) persistence
				.createCriteria( Trasferimento.class )
				.add( Restrictions.eq( "clinicaOrigine", utente.getClinica()) )
				.add( Restrictions.isNotNull( "cartellaClinicaMittenteRiconsegna" ) )
				.createAlias( "cartellaClinicaMittenteRiconsegna", "cc" )
				.add( Restrictions.le( "cc.entered", dataSettimanaScorsa ) )
				.list();*/
			
			req.setAttribute( "trasferimentiDaAccettare", trasferimentiDaAccettare );
			//req.setAttribute( "trasferimentiRientranti", trasferimentiRientranti );

			gotoPage( "/jsp/homepageV.jsp" );
		}
		else
		{
			gotoPage("sinantropi_default", "/jsp/homepageS.jsp" );
		}
	}

}
