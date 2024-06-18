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
@Table(name = "lookup_farmaci", schema = "public")
@Where( clause = "enabled" )
public class LookupFarmaci implements java.io.Serializable
{
	private static final long serialVersionUID = 4447343084372790967L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	
	private Set<MagazzinoFarmaci> magazzinoFarmacis = new HashSet<MagazzinoFarmaci>(0);


	public LookupFarmaci()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Farmaci";
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

	@Column(name = "description", length = 256)
	@Length(max = 256)
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
	
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupFarmaci")	
	public Set<MagazzinoFarmaci> getMagazzinoFarmacis() {
		return magazzinoFarmacis;
	}

	public void setMagazzinoFarmacis(Set<MagazzinoFarmaci> magazzinoFarmacis) {
		this.magazzinoFarmacis = magazzinoFarmacis;
	}
	
	@Override
	public String toString()
	{
		return description;
	}
	
}
