package it.us.web.bean.vam;

import java.util.Set;
import it.us.web.bean.vam.lookup.LookupEcoAddomeReferti;
import it.us.web.bean.vam.lookup.LookupEcoAddomeTipo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "eco_addome_esito", schema = "public")
public class EcoAddomeEsito implements java.io.Serializable
{
	private static final long serialVersionUID = -8091002289851989785L;
	
	private int id;
	private Boolean normale;
	private EcoAddome ecoAddome;
	private LookupEcoAddomeTipo tipo;
	private Set<LookupEcoAddomeReferti> lookupEcoAddomeReferti;

	public EcoAddomeEsito()
	{
		
	}

	@Override
	public String toString()
	{
		return id+"";
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Esito";
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
	
	@Column(name = "normale")
	public Boolean getNormale() {
		return this.normale;
	}

	public void setNormale(Boolean normale) {
		this.normale = normale;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="id_eco_addome")
	public EcoAddome getEcoAddome() {
		return ecoAddome;
	}

	public void setEcoAddome(EcoAddome ecoAddome) {
		this.ecoAddome = ecoAddome;
	}
	
	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "eco_addome_esito_referti", 
			joinColumns =        { @JoinColumn(name = "id_eco_addome_esito", nullable = false, updatable = false) }, 
			inverseJoinColumns = { @JoinColumn(name = "id_referto", nullable = false, updatable = false) })
	public Set<LookupEcoAddomeReferti> getLookupEcoAddomeReferti() {
		return lookupEcoAddomeReferti;
	}

	public void setLookupEcoAddomeReferti(
			Set<LookupEcoAddomeReferti> lookupEcoAddomeReferti) {
		this.lookupEcoAddomeReferti = lookupEcoAddomeReferti;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="eco_addome_tipo")
	public LookupEcoAddomeTipo getTipo() {
		return tipo;
	}

	public void setTipo(LookupEcoAddomeTipo tipo) {
		this.tipo = tipo;
	}
}
