package it.us.web.constants;

/**
 * Qui vengono mappati gli id della sezione "operazioni richieste" dell'accettazione
 * 
 * Tutte le anomalie (classe e non interfaccia, nomi minuscoli, getter) servono per aggirare le limitazioni
 * dell'expression language e permetterne l'accesso anche da jsp
 */
public class IdRichiesteVarie
{
	private static final IdRichiesteVarie instance = new IdRichiesteVarie();
	
	public static final int richiestaPrelievi			= 8;
	public static final int sterilizzazione				= 9;
	public static final int profilassiRabbia			= 10;
	public static final int prontoSoccorso				= 11;
	public static final int esameNecroscopico			= 12;
	public static final int smaltimentoCarogna			= 13;
	public static final int ritorvamentoAltraAsl		= 14;
	public static final int ricoveroInCanile			= 47;
	public static final int incompatibilitaAmbientale	= 48;
	public static final int altro						= 49;
	public static final int attivitaEsterne  			= 53;
	
	private IdRichiesteVarie()
	{
		
	}
	
	public static IdRichiesteVarie getInstance()
	{
		return instance;
	}

	public int getRichiestaPrelievi() {
		return richiestaPrelievi;
	}

	public int getSterilizzazione() {
		return sterilizzazione;
	}

	public int getProfilassiRabbia() {
		return profilassiRabbia;
	}

	public int getProntoSoccorso() {
		return prontoSoccorso;
	}

	public int getEsameNecroscopico() {
		return esameNecroscopico;
	}

	public int getSmaltimentoCarogna() {
		return smaltimentoCarogna;
	}

	public int getRitorvamentoAltraAsl() {
		return ritorvamentoAltraAsl;
	}

	public int getRicoveroInCanile() {
		return ricoveroInCanile;
	}

	public int getIncompatibilitaAmbientale() {
		return incompatibilitaAmbientale;
	}

	public int getAltro() {
		return altro;
	}
	
	public int getAttivitaEsterne() {
		return attivitaEsterne;
	}

}
