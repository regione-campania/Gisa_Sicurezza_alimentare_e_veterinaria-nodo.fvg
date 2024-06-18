package it.us.web.constants;

/**
 * Qui vengono mappati gli id dei tipi di richiedenti
 * 
 * Tutte le anomalie (classe e non interfaccia, nomi minuscoli, getter) servono per aggirare le limitazioni
 * dell'expression language e permetterne l'accesso anche da jsp
 */
public class IdTipiRichiedente
{
	private static final IdTipiRichiedente instance = new IdTipiRichiedente();
	
	public static final int privato				= 1;
	public static final int personaleInterno	= 2;
	public static final int personaleAsl		= 3;
	public static final int associazione		= 4;
	public static final int altro				= 12;
	
	private IdTipiRichiedente()
	{
		
	}
	
	public static IdTipiRichiedente getInstance()
	{
		return instance;
	}

	public int getPrivato() {
		return privato;
	}

	public int getPersonaleInterno() {
		return personaleInterno;
	}

	public int getPersonaleAsl() {
		return personaleAsl;
	}

	public int getAssociazione() {
		return associazione;
	}

	public int getAltro() {
		return altro;
	}

}
