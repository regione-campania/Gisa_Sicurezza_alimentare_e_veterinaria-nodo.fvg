package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.Animale;

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
@Table(name = "lookup_taglie", schema = "public")
@Where( clause = "enabled" )
public class LookupTaglie implements java.io.Serializable
{
	private static final long serialVersionUID = -6362067633554376948L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	private Set<Animale> animales = new HashSet<Animale>(0);

	public LookupTaglie()
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupSpecie")
	@Where( clause = "trashed_date is null" )
	public Set<Animale> getAnimales() {
		return this.animales;
	}

	public void setAnimales(Set<Animale> animales) {
		this.animales = animales;
	}
	
	@Override
	public String toString(){
		return description;
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Taglia";
	}

}