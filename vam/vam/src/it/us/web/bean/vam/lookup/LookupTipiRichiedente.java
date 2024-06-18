package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.Accettazione;

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
@Table(name = "lookup_tipi_richiedente", schema = "public")
@Where( clause = "enabled" )
public class LookupTipiRichiedente implements java.io.Serializable
{
	private static final long serialVersionUID = -8881813760216389450L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean forzaPubblica;
	private Boolean enabled;
	private Set<Accettazione> accettaziones = new HashSet<Accettazione>(0);

	public LookupTipiRichiedente()
	{
		
	}

	@Column(name = "forza_pubblica")
	public Boolean getForzaPubblica() {
		return forzaPubblica;
	}

	public void setForzaPubblica(Boolean forzaPubblica) {
		this.forzaPubblica = forzaPubblica;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupTipiRichiedente")
	@Where( clause = "trashed_date is null" )
	public Set<Accettazione> getAccettaziones() {
		return this.accettaziones;
	}

	public void setAccettaziones(Set<Accettazione> accettaziones) {
		this.accettaziones = accettaziones;
	}
	
	@Override
	public String toString()
	{
		return description;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Tipo richiedente";
	}

}
