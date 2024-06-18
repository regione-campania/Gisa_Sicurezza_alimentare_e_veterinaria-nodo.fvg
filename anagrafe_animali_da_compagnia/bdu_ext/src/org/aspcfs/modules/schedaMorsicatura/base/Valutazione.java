package org.aspcfs.modules.schedaMorsicatura.base;

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
	
	private double punteggio;
	private String rischio;
	private String consiglio;
	
	
	public double getPunteggio() {
		return punteggio;
	}

	public void setPunteggio(double punteggio) {
		this.punteggio = punteggio;
	}
	
	public String getRischio() {
		return rischio;
	}

	public void setRischio(String rischio) {
		this.rischio = rischio;
	}
	
	public String getConsiglio() {
		return consiglio;
	}

	public void setConsiglio(String consiglio) {
		this.consiglio = consiglio;
	}

}
