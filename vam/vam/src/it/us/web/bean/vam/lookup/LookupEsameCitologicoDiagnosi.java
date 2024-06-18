package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.EcoCuore;
import it.us.web.bean.vam.EsameCitologico;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.OrderBy;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_esame_citologico_diagnosi", schema = "public")
public class LookupEsameCitologicoDiagnosi implements java.io.Serializable
{
	private static final long serialVersionUID = -8091002289851989785L;
	
	private int id;
	private String description;
	private Set<EsameCitologico> esameCitologicos;
	private String codice;
	private Integer level;
	private Boolean enabled;
	private LookupEsameCitologicoDiagnosi padre;
	private Set<LookupEsameCitologicoDiagnosi> figli = new HashSet<LookupEsameCitologicoDiagnosi>(0);

	@Transient
	public String getNomeEsame()
	{
		return "Diagnosi";
	}
	
	public LookupEsameCitologicoDiagnosi()
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
	
	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}


	@Column(name = "description", length = 64)
	@Length(max = 64)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "diagnosi")
	public Set<EsameCitologico> getEsameCitologicos() {
		return esameCitologicos;
	}

	public void setEsameCitologicos(Set<EsameCitologico> esameCitologicos) {
		this.esameCitologicos = esameCitologicos;
	}
	
	@Column(name = "codice", length = 128)
	@Length(max = 128)
	public String getCodice() {
		return codice;
	}
	
	public void setCodice(String codice) {
		this.codice = codice;
	}

	
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "padre")
	@OrderBy(clause="level asc")
	public Set<LookupEsameCitologicoDiagnosi> getFigli() {
		return figli;
	}
	
	public void setFigli(Set<LookupEsameCitologicoDiagnosi> figli) {
		this.figli = figli;
	}
	
	@Column(name = "level")
	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "padre")
	public LookupEsameCitologicoDiagnosi getPadre() {
		return padre;
	}
	
	public void setPadre(LookupEsameCitologicoDiagnosi padre) {
		this.padre = padre;
	}
	
	
}
