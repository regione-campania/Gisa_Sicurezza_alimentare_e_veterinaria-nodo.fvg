package it.us.web.bean.sinantropi.lookup;

import it.us.web.bean.sinantropi.Detenzioni;
import it.us.web.bean.sinantropi.Sinantropo;
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
import javax.validation.constraints.NotNull;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_tipi_documento", schema = "public")
@Where( clause = "enabled" )
public class LookupTipiDocumento implements java.io.Serializable {
	
	private static final long serialVersionUID = 1414679919315065002L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	private Set<Detenzioni> detenzionis = new HashSet<Detenzioni>(0);
	
	
	public LookupTipiDocumento() {
		
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupTipologiaDocumento")
	@Where( clause = "trashed_date is null" )
	public Set<Detenzioni> getDetenzionis() {
		return detenzionis;
	}


	public void setDetenzionis(Set<Detenzioni> detenzionis) {
		this.detenzionis = detenzionis;
	}
		

	
}

