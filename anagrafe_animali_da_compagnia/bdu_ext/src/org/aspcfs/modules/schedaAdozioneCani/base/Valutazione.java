package org.aspcfs.modules.schedaAdozioneCani.base;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import com.darkhorseventures.framework.beans.GenericBean;

public class Valutazione extends GenericBean 
{

	private static Logger log = Logger.getLogger(Valutazione.class);
	static 
	{
		if (System.getProperty("DEBUG") != null) 
		{
			log.setLevel(Level.DEBUG);
		}
	}
	
	private int punteggio;
	private String valutazione;
	
	
	public int getPunteggio() {
		return punteggio;
	}

	public void setPunteggio(int punteggio) {
		this.punteggio = punteggio;
	}
	
	public String getValutazione() {
		return valutazione;
	}

	public void setValutazione(String valutazione) {
		this.valutazione = valutazione;
	}

}
