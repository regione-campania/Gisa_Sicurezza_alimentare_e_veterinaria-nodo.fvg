package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.TerapiaAssegnata;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;


@Entity
@Table(name = "lookup_tipi_farmaco", schema = "public")
@Where( clause = "enabled" )
public class LookupTipiFarmaco implements java.io.Serializable
{
	private static final long serialVersionUID = 4447343084372790967L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	
	private String unitaMisuraCarico;
	private String unitaMisuraScarico;
	public  float  conversioneScarico;
	

	private Set<MagazzinoFarmaci> magazzinoFarmacis = new HashSet<MagazzinoFarmaci>(0);


	public LookupTipiFarmaco()
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

	@Column(name = "description", length = 64)
	@Length(max = 64)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "level")
	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
		
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupTipiFarmaco")	
	public Set<MagazzinoFarmaci> getMagazzinoFarmacis() {
		return magazzinoFarmacis;
	}

	public void setMagazzinoFarmacis(Set<MagazzinoFarmaci> magazzinoFarmacis) {
		this.magazzinoFarmacis = magazzinoFarmacis;
	}

	@Column(name = "unita_misura_carico", length = 16)
	@Length(max = 16)
	public String getUnitaMisuraCarico() {
		return unitaMisuraCarico;
	}

	public void setUnitaMisuraCarico(String unitaMisuraCarico) {
		this.unitaMisuraCarico = unitaMisuraCarico;
	}

	@Column(name = "unita_misura_scarico", length = 16)
	@Length(max = 16)
	public String getUnitaMisuraScarico() {
		return unitaMisuraScarico;
	}

	public void setUnitaMisuraScarico(String unitaMisuraScarico) {
		this.unitaMisuraScarico = unitaMisuraScarico;
	}

	@Column(name = "conversione_scarico")
	public float getConversioneScarico() {
		return conversioneScarico;
	}

	public void setConversioneScarico(float conversioneScarico) {
		this.conversioneScarico = conversioneScarico;
	}
	
	@Override
	public String toString()
	{
		return description;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Tipo farmaco";
	}
	
}
