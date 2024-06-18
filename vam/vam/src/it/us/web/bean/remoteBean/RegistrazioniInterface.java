package it.us.web.bean.remoteBean;

import javax.persistence.Column;

public interface RegistrazioniInterface
{
	public Boolean getAdozione();
	public Boolean getAdozioneFuoriAsl();
	public Boolean getAdozioneVersoAssocCanili();
	public void setAdozione(Boolean adozione);
	public void setAdozioneFuoriAsl(Boolean adozioneFuoriAsl);
	public void setAdozioneVersoAssocCanili(Boolean adozioneVersoAssocCanili);
	public Boolean getRitrovamento();
	public void setRitrovamento(Boolean ritrovamento);
	public Boolean getRitrovamentoSmarrNonDenunciato();
	public void setRitrovamentoSmarrNonDenunciato(Boolean ritrovamentoSmarrNonDenunciato);
	public Boolean getSmarrimento();
	public void setSmarrimento(Boolean smarrimento);
	public Boolean getTrasfCanile();
	public void setTrasfCanile(Boolean trasfCanile);
	public Boolean getRitornoProprietario();
	public void setRitornoProprietario(Boolean ritornoProprietario);
	public Boolean getTrasferimento();
	public void setTrasferimento(Boolean trasferimento);
	public Boolean getPassaporto();
	public void setPassaporto(Boolean passaporto);
	public Boolean getFurto();
	public void setFurto(Boolean furto);
	public Boolean getDecesso();
	public void setDecesso(Boolean decesso);
	public Boolean getSterilizzazione();
	public void setSterilizzazione(Boolean sterilizzazione);
	public void setPrelievoDna(Boolean prelievoDna);
	public Boolean getPrelievoDna();
	public void setPrelievoLeishmania(Boolean prelievoLeishmania);
	public Boolean getPrelievoLeishmania();
	public void setRinnovoPassaporto(Boolean rinnovoPassaporto);
	public Boolean getRinnovoPassaporto();
	public Boolean getReimmissione();
	public Boolean getRitornoAslOrigine();
	public Boolean getCessione();
	public void setCessione(Boolean cessione);
	public Boolean getTrasfRegione();
	public void setTrasfRegione(Boolean trasfRegione);
	public Boolean getTrasferimentoResidenzaProp();
	public void setTrasferimentoResidenzaProp(Boolean trasferimentoResidenzaProp);
	public Boolean getRicattura();
	public void setRicattura(Boolean ricattura);
	public Boolean getRitornoCanileOrigine();
	public void setRitornoCanileOrigine(Boolean ritornoCanileOrigine);
}
