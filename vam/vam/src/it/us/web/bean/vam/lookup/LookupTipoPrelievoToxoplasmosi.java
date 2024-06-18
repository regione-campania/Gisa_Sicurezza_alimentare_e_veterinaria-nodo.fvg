package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.Toxoplasmosi;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_tipo_prelievo_toxoplasmosi", schema = "public")
@Where( clause = "enabled" )
public class LookupTipoPrelievoToxoplasmosi implements java.io.Serializable
{
	private static final long serialVersionUID = -3156233441365137861L;
	
	private int id;
	private String description;	
	private Integer level;
	private Boolean enabled;
	
	private Set<Toxoplasmosi> toxoplasmosis = new HashSet<Toxoplasmosi>(0);

	public LookupTipoPrelievoToxoplasmosi()
	{
		
	}
	
	@Override
	public String toString()
	{
		return description;
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

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "toxoplasmosi_tipo_prelievo", schema = "public", joinColumns = { @JoinColumn(name = "tipo_prelievo", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "toxoplasmosi", nullable = false, updatable = false) })
	public Set<Toxoplasmosi> getToxoplasmosis() {
		return toxoplasmosis;
	}

	public void setToxoplasmosis(Set<Toxoplasmosi> toxoplasmosis) {
		this.toxoplasmosis = toxoplasmosis;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Tipo prelievo";
	}
	
	

}

