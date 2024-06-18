package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.Leishmaniosi;
import it.us.web.bean.vam.Rickettsiosi;

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
@Table(name = "lookup_leishmaniosi_esiti", schema = "public")
@Where( clause = "enabled" )
public class LookupLeishmaniosiEsiti implements java.io.Serializable {
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	
	private Set<Leishmaniosi> leishmaniosis = new HashSet<Leishmaniosi>(0);
	
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	@Column(name = "id", unique = true, nullable = false)
	@NotNull
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Esito";
	}
	
	
	@Column(name = "description", length = 128)
	@Length(max = 128)
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
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lle")
	@Where( clause = "trashed_date is null" )
	public Set<Leishmaniosi> getLeishmaniosis() {
		return leishmaniosis;
	}
	public void setLeishmaniosis(Set<Leishmaniosi> leishmaniosis) {
		this.leishmaniosis = leishmaniosis;
	}
	
	@Override
	public String toString()
	{
		return description;
	}

}
