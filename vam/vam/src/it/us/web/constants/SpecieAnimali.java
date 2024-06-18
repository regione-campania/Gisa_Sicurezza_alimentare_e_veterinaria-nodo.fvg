package it.us.web.constants;

/**
 * Qui vengono mappati gli id delle specie animale
 * 
 * Tutte le anomalie (classe e non interfaccia, nomi minuscoli, getter) servono per aggirare le limitazioni
 * dell'expression language e permetterne l'accesso anche da jsp
 */
public class SpecieAnimali
{
	private static final SpecieAnimali instance = new SpecieAnimali();
	
	public static final int cane		= 1;
	public static final int gatto		= 2;
	public static final int sinantropo	= 3;
	
	private SpecieAnimali()
	{
		
	}
	
	public static SpecieAnimali getInstance()
	{
		return instance;
	}

	public int getCane() {
		return cane;
	}

	public int getGatto() {
		return gatto;
	}

	public int getSinantropo() {
		return sinantropo;
	}

}
