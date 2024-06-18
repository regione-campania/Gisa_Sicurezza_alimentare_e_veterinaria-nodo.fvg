package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.OperazioneChirurgica;

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
@Table(name = "lookup_operazioni_chirurgiche", schema = "public")
@Where( clause = "enabled" )
public class LookupOperazioniChirurgiche implements java.io.Serializable
{
	private static final long serialVersionUID = 5405132252198491580L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	private Set<OperazioneChirurgica> operazioneChirurgicas = new HashSet<OperazioneChirurgica>(0);

	public LookupOperazioniChirurgiche()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Operazione chirurgica";
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupOperazioniChirurgiche")
	@Where( clause = "trashed_date is null" )
	public Set<OperazioneChirurgica> getOperazioneChirurgicas() {
		return this.operazioneChirurgicas;
	}

	public void setOperazioneChirurgicas(
			Set<OperazioneChirurgica> operazioneChirurgicas) {
		this.operazioneChirurgicas = operazioneChirurgicas;
	}
	
	@Override
	public String toString()
	{
		return description;
	}

}
