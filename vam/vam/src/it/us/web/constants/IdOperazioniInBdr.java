package it.us.web.constants;

import it.us.web.bean.vam.Trasferimento;

/**
 * Qui vengono mappati gli id delle operazioni in bdr
 * 
 * Tutte le anomalie (classe e non interfaccia, nomi minuscoli, getter) servono per aggirare le limitazioni
 * dell'expression language e permetterne l'accesso anche da jsp
 */
public class IdOperazioniInBdr
{
	private static final IdOperazioniInBdr instance = new IdOperazioniInBdr();
	
	public static final int iscrizione		= 1;
	public static final int adozioneDaColonia				= 19;
	public static final int adozioneDaCanile					= 13;
	public static final int adozioneFuoriAsl					= 67;
	public static final int adozioneVersoAssocCanili			= 61;
	public static final int adozionePresaInCaricoFuoriAsl	= 47;
	public static final int decesso			= 9;
	public static final int trasferimentoFuoriStato						= 39;
	public static final int trasferimentoFuoriRegioneSoloProprietario	= 40;
	public static final int trasferimentoFuoriRegione					= 8;
	public static final int trasferimento								= 16;
	public static final int trasferimentoCanile							= 31;
	public static final int smarrimento		= 11;
	public static final int ritrovamento		= 12;
	public static final int ritrovamentoSmarrNonDenunciato	= 41;
	public static final int passaporto		= 6;
	public static final int furto       		= 4;
	public static final int ricattura   		= 24;
	public static final int sterilizzazione 	= 2;
	public static final int cessione		 	= 59;
	public static final int trasferimentoResidenzaProprietario = 43;
	public static final int prelievoDna = 50;
	public static final int reimmissione = 23;
	public static final int rinnovoPassaporto = 48;
	public static final int ritornoProprietario = 45;
	public static final int trasfCanile					= 31;
	public static final int prelievoLeishmania = 54;
	public static final int ritornoAslOrigine = 55;
	
	private IdOperazioniInBdr()
	{
		
	}
	
	public static IdOperazioniInBdr getInstance()
	{
		return instance;
	}

	public int getIscrizione() {
		return iscrizione;
	}
	public int getAdozioneDaCanile() {
		return adozioneDaCanile;
	}
	
	public int getAdozioneDaColonia() {
		return adozioneDaColonia;
	}
	
	public int getAdozioneFuoriAsl() {
		return adozioneFuoriAsl;
	}
	
	public int getAdozioneVersoAssocCanili() {
		return adozioneVersoAssocCanili;
	}
	
	public int getAdozionePresaInCaricoFuoriAsl() {
		return adozionePresaInCaricoFuoriAsl;
	}
	
	public int getFurto() {
		return furto;
	}
	public int getDecesso() {
		return decesso;
	}
	public int getTrasferimento() {
		return trasferimento;
	}
	public int getTrasferimentoCanile() {
		return trasferimentoCanile;
	}
	public int getTrasferimentoFuoriRegione() {
		return trasferimentoFuoriRegione;
	}
	public int getTrasferimentoFuoriRegioneSoloProprietario() {
		return trasferimentoFuoriRegioneSoloProprietario;
	}
	public int getTrasferimentoFuoriStato() {
		return trasferimentoFuoriStato;
	}
	public int getSmarrimento() {
		return smarrimento;
	}
	public int getRitrovamento() {
		return ritrovamento;
	}
	public int getRitrovamentoSmarrNonDenunciato() {
		return ritrovamentoSmarrNonDenunciato;
	}
	public int getPassaporto() {
		return passaporto;
	}
	
	public int getSterilizzazione() {
		return sterilizzazione;
	}
	public int getRicattura() {
		return ricattura;
	}
	
	public int getCessione() {
		return cessione;
	}
	
	public int getTrasferimentoResidenzaProprietario() {
		return trasferimentoResidenzaProprietario;
	}

	public int getPrelievoDna() {
		return prelievoDna;
	}
	
	public int getPrelievoLeishmania() {
		return prelievoLeishmania;
	}
	
	public int getReimmissione() {
		return reimmissione;
	}
	
	public int getRitornoAslOrigine() {
		return ritornoAslOrigine;
	}
	
	public int getRinnovoPassaporto() {
		return rinnovoPassaporto;
	}
	
	public int getTrasfCanile() {
		return trasfCanile;
	}
	
	public int getRitornoProprietario() {
		return ritornoProprietario;
	}
	
}
