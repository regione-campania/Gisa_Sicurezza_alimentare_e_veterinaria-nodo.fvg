package it.us.web.util.vam;

import it.us.web.bean.BUtente;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.DiarioClinico;
import it.us.web.bean.vam.DiarioClinicoEsitoEO;
import it.us.web.bean.vam.DiarioClinicoTipoEO;
import it.us.web.bean.vam.EsameObiettivo;
import it.us.web.bean.vam.EsameObiettivoEsito;
import it.us.web.bean.vam.lookup.LookupEsameObiettivoApparati;
import it.us.web.dao.hibernate.Persistence;

import java.util.ArrayList;
import java.util.Date;

public class DiarioClinicoUtil 
{
	
	public static void save( 
				CartellaClinica cc, 
				LookupEsameObiettivoApparati apparato, 
				Date data,
				String temperatura,
				ArrayList<EsameObiettivo> esami,
				BUtente operatore,
				Persistence persistence ) throws Exception
	{
		DiarioClinico dc = new DiarioClinico();

		dc.setCartellaClinica	( cc );
		dc.setApparato			( apparato );
		dc.setData				( data );
		dc.setEntered			( new Date() );
		dc.setEnteredBy			( operatore );
		dc.setTemperatura		( temperatura );
		
		persistence.insert( dc );
		
		for( EsameObiettivo eo: esami )
		{
			DiarioClinicoTipoEO dcteo = new DiarioClinicoTipoEO();
			dcteo.setDiarioClinico( dc );
			dcteo.setNormale( eo.getNormale() );
			dcteo.setTipo	( eo.getLookupEsameObiettivoTipo() );
			
			persistence.insert( dcteo );
			
			for( EsameObiettivoEsito eoe: eo.getEsameObiettivoEsitos() )
			{
				DiarioClinicoEsitoEO dceeo = new DiarioClinicoEsitoEO();
				dceeo.setEsito( eoe.getLookupEsameObiettivoEsito() );
				dceeo.setDiarioClinicoTipoEO( dcteo );
				
				persistence.insert( dceeo );
			}

		}
		
	}
	
}
