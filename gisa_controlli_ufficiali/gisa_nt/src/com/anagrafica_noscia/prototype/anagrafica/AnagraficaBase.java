package com.anagrafica_noscia.prototype.anagrafica;

import java.util.List;

import com.anagrafica_noscia.prototype.base_beans.Impresa;
import com.anagrafica_noscia.prototype.base_beans.SoggettoFisico;
import com.anagrafica_noscia.prototype.base_beans.Stabilimento;



/*classe che rappresenta un'istanza di entry di anagrafica
 * e che raggruppa tutte le entita' coinvolte (stabilimento, legale etc...)
 */
public abstract class AnagraficaBase {
	
	
	private Impresa impresa;
	private  List<SoggettoFisico> legaliRappresentanti; /*anche se al max sara' 1 */
	private  List<Stabilimento> stabilimenti; /*anche se al max sara' 1 */
	
	public Impresa getImpresa() {
		return impresa;
	}
	public void setImpresa(Impresa impresa) {
		this.impresa = impresa;
	}
	public  List<SoggettoFisico> getLegaliRappresentanti() {
		return legaliRappresentanti;
	}
	public void setLegaliRappresentanti(List<SoggettoFisico> legaliRappresentanti) {
		this.legaliRappresentanti = legaliRappresentanti;
	}
	public  List<Stabilimento> getStabilimenti() {
		return stabilimenti;
	}
	public void setStabilimenti(List<Stabilimento> stabilimenti) {
		this.stabilimenti = stabilimenti;
	}
}
