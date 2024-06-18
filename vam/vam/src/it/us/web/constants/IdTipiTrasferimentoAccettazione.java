package it.us.web.constants;

public class IdTipiTrasferimentoAccettazione
{
	private static final IdTipiTrasferimentoAccettazione instance = new IdTipiTrasferimentoAccettazione();
	
	public static final int proprietaIntraAsl		= 1;
	public static final int proprietaExtraAsl		= 2;
	public static final int proprietaFuoriRegione	= 3;
	public static final int residenza				= 4;
	
	private IdTipiTrasferimentoAccettazione()
	{
		
	}
	
	public static IdTipiTrasferimentoAccettazione getInstance()
	{
		return instance;
	}

	public int getProprietaIntraAsl() {
		return proprietaIntraAsl;
	}

	public int getProprietaExtraAsl() {
		return proprietaExtraAsl;
	}

	public int getProprietaFuoriRegione() {
		return proprietaFuoriRegione;
	}

	public int getResidenza() {
		return residenza;
	}
}
