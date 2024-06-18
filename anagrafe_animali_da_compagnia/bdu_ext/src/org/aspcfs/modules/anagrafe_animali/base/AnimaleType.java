package org.aspcfs.modules.anagrafe_animali.base;

import com.darkhorseventures.framework.beans.GenericBean;

public class AnimaleType extends GenericBean{

	private int idSpecie ;
	private String tipoClasseAnimale ;
	public int getIdSpecie() {
		return idSpecie;
	}
	public void setIdSpecie(int idSpecie) {
		this.idSpecie = idSpecie;
	}
	
	public void setIdSpecie(String idSpecie) {
		if (idSpecie != null && ! "".equals(idSpecie))
		this.idSpecie = Integer.parseInt(idSpecie);
	}
	public String getTipoClasseAnimale() {
		return tipoClasseAnimale;
	}
	public void setTipoClasseAnimale(String tipoClasseAnimale) {
		this.tipoClasseAnimale = tipoClasseAnimale;
	}
	
	
}
