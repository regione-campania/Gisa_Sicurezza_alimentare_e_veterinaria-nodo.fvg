package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.Ehrlichiosi;
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
@Table(name = "lookup_rickettsiosi_esiti", schema = "public")
@Where( clause = "enabled" )
public class LookupRickettsiosiEsiti implements java.io.Serializable {
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	
	private Set<Rickettsiosi> rickettsiosis = new HashSet<Rickettsiosi>(0);
	
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
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lre")
	@Where( clause = "trashed_date is null" )
	public Set<Rickettsiosi> getRickettsiosis() {
		return rickettsiosis;
	}
	public void setRickettsiosis(Set<Rickettsiosi> rickettsiosis) {
		this.rickettsiosis = rickettsiosis;
	}
	
	@Override
	public String toString()
	{
		return description;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Esiti";
	}

}
