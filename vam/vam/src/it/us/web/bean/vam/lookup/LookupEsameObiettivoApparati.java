package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.EsameObiettivo;

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
@Table(name = "lookup_esame_obiettivo_apparati", schema = "public")
@Where( clause = "enabled" )
public class LookupEsameObiettivoApparati implements java.io.Serializable
{
	private static final long serialVersionUID = 8883800872280582920L;
	
	private int id;
	private String description;
	private Boolean specifico;
	private Integer level;
	private Boolean enabled;
	//private Set<EsameObiettivo> esameObiettivos = new HashSet<EsameObiettivo>(0);

	public LookupEsameObiettivoApparati()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Apparati";
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

	@Column(name = "specifico")
	public Boolean getSpecifico() {
		return this.specifico;
	}

	public void setSpecifico(Boolean specifico) {
		this.specifico = specifico;
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
	
//	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupEsameObiettivoTipo")
//	@Where( clause = "trashed_date is null" )
//	public Set<EsameObiettivo> getEsameObiettivos() {
//		return this.esameObiettivos;
//	}
//
//	public void setEsameObiettivos(Set<EsameObiettivo> esameObiettivos) {
//		this.esameObiettivos = esameObiettivos;
//	}
	
	@Override
	public String toString()
	{
		return description;
	}

}
