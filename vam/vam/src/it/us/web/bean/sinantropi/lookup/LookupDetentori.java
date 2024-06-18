package it.us.web.bean.sinantropi.lookup;

import it.us.web.bean.sinantropi.Detenzioni;
import it.us.web.bean.sinantropi.Sinantropo;
import it.us.web.bean.vam.lookup.LookupComuni;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_detentori_sinantropi", schema = "public")
@Where( clause = "enabled" )
public class LookupDetentori implements java.io.Serializable {
	
	private static final long serialVersionUID = 1414679919315065002L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	private Boolean zoo;
	private Set<Detenzioni> detenzionis = new HashSet<Detenzioni>(0);
	
	private LookupComuni lookupComuni;
	private String indirizzo;
	private String telefono;
	private String fax;
	private String email;
	
	
	public LookupDetentori() {
		
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

	@Column(name = "description", length = 512)
	@Length(max = 512)
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
	
	@Column(name = "zoo")
	public Boolean getZoo() {
		return this.zoo;
	}

	public void setZoo(Boolean zoo) {
		this.zoo = zoo;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupDetentori")
	@Where( clause = "trashed_date is null" )
	public Set<Detenzioni> getDetenzionis() {
		return detenzionis;
	}


	public void setDetenzionis(Set<Detenzioni> detenzionis) {
		this.detenzionis = detenzionis;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "comune")
	public LookupComuni getLookupComuni() {
		return this.lookupComuni;
	}

	public void setLookupComuni(LookupComuni lookupComuni) {
		this.lookupComuni = lookupComuni;
	}
	
	@Column(name = "indirizzo", length = 256)
	@Length(max = 256)
	public String getIndirizzo() {
		return this.indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	@Column(name = "telefono", length = 64)
	@Length(max = 64)
	public String getTelefono() {
		return this.telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	@Column(name = "fax", length = 64)
	@Length(max = 64)
	public String getFax() {
		return this.fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	@Column(name = "email", length = 64)
	@Length(max = 64)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
		

	
}


