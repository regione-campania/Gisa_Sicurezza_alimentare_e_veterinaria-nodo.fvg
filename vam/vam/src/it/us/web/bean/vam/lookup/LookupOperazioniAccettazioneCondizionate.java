package it.us.web.bean.vam.lookup;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_operazioni_accettazione_condizionate", schema = "public")
@Where( clause = "enabled" )
public class LookupOperazioniAccettazioneCondizionate implements java.io.Serializable
{
	private static final long serialVersionUID = -7225928276157167124L;
	
	private int id;
	private String operazioneDaFare;
	private Boolean enabled;
	private LookupOperazioniAccettazione operazioneCondizionata  = new LookupOperazioniAccettazione();
	private LookupOperazioniAccettazione operazioneCondizionante = new LookupOperazioniAccettazione();

	public LookupOperazioniAccettazioneCondizionate()
	{
		
	}
	
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	@Column(name = "id", unique = true, nullable = false)
	@NotNull
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "operazione_da_fare", length = 64)
	@Length(max = 64)
	public String getOperazioneDaFare() {
		return this.operazioneDaFare;
	}

	public void setOperazioneDaFare(String operazioneDaFare) {
		this.operazioneDaFare = operazioneDaFare;
	}


	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "operazione_condizionante")
	@NotNull
	public LookupOperazioniAccettazione getOperazioneCondizionante() {
		return this.operazioneCondizionante;
	}
	
	public void setOperazioneCondizionante(LookupOperazioniAccettazione operazioneCondizionante) {
		this.operazioneCondizionante = operazioneCondizionante;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "operazione_condizionata")
	@NotNull
	public LookupOperazioniAccettazione getOperazioneCondizionata() {
		return this.operazioneCondizionata;
	}
	
	public void setOperazioneCondizionata(LookupOperazioniAccettazione operazioneCondizionata) {
		this.operazioneCondizionata = operazioneCondizionata;
	}
	
}
