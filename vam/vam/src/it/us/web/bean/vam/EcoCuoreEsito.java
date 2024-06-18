package it.us.web.bean.vam;

import it.us.web.bean.vam.lookup.LookupEcoCuoreAnomalia;
import it.us.web.bean.vam.lookup.LookupEcoCuoreTipo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;

@Entity
@Table(name = "eco_cuore_esito", schema = "public")
@Where( clause = "enabled" )
public class EcoCuoreEsito implements java.io.Serializable
{
	private static final long serialVersionUID = -8091002289851989785L;
	
	private int id;
	private LookupEcoCuoreTipo lookupEcoCuoreTipo;
	private LookupEcoCuoreAnomalia lookupEcoCuoreAnomalia;
	private Boolean enabled;
	private Boolean normale;
	private EcoCuore ecoCuore;

	

	public EcoCuoreEsito()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Esito";
	}
	
	@Override
	public String toString()
	{
		return id+"";
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "anomalia")
	public LookupEcoCuoreAnomalia getLookupEcoCuoreAnomalia() {
		return this.lookupEcoCuoreAnomalia;
	}

	public void setLookupEcoCuoreAnomalia(
			LookupEcoCuoreAnomalia lookupEcoCuoreAnomalia) {
		this.lookupEcoCuoreAnomalia = lookupEcoCuoreAnomalia;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tipo_esame")
	public LookupEcoCuoreTipo getLookupEcoCuoreTipo() {
		return this.lookupEcoCuoreTipo;
	}

	public void setLookupEcoCuoreTipo(
			LookupEcoCuoreTipo lookupEcoCuoreTipo) {
		this.lookupEcoCuoreTipo = lookupEcoCuoreTipo;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	
	@Column(name = "normale")
	public Boolean getNormale() {
		return this.normale;
	}

	public void setNormale(Boolean normale) {
		this.normale = normale;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "eco_cuore", nullable = false)
	public EcoCuore getEcoCuore() {
		return ecoCuore;
	}

	public void setEcoCuore(EcoCuore ecoCuore) {
		this.ecoCuore = ecoCuore;
	}
}
