package it.us.web.constants;

/**
 * Qui vengono mappati gli id delle operazioni in bdr
 * 
 * Tutte le anomalie (classe e non interfaccia, nomi minuscoli, getter) servono per aggirare le limitazioni
 * dell'expression language e permetterne l'accesso anche da jsp
 */
public class IdOperazioniDM
{
	private static final IdOperazioniDM instance = new IdOperazioniDM();
	
	public static final int terapiaDegenza		= 54;
	
	
	private IdOperazioniDM()
	{
		
	}
	
	public static IdOperazioniDM getInstance()
	{
		return instance;
	}

	public int getTerapiaDegenza() {
		return terapiaDegenza;
	}
}
