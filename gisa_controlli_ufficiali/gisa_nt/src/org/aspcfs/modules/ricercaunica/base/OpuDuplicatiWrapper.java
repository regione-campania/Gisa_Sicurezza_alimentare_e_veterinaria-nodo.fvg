package org.aspcfs.modules.ricercaunica.base;

import java.util.ArrayList;

import org.aspcfs.modules.opu.base.Operatore;

public class OpuDuplicatiWrapper {

	private ArrayList<Operatore> operatoriTrovati;
	
	public OpuDuplicatiWrapper(ArrayList<Operatore> trovati)
	{
		this.setOperatoriTrovati(trovati);
	}

	
	public ArrayList<Operatore> getOperatoriTrovati() {
		return operatoriTrovati;
	}

	public void setOperatoriTrovati(ArrayList<Operatore> operatoriTrovati) {
		this.operatoriTrovati = operatoriTrovati;
	}
}
