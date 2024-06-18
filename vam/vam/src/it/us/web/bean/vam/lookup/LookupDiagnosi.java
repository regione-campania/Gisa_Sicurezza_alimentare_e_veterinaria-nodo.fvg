package it.us.web.bean.vam.lookup;


import it.us.web.bean.vam.Diagnosi;
import it.us.web.bean.vam.DiagnosiEffettuate;

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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_diagnosi", schema = "public")
@Where( clause = "enabled" )
public class LookupDiagnosi implements java.io.Serializable
{
	private static final long serialVersionUID = -7225928276157167124L;
	
	private int id;
	private String description;
	private boolean medica;
	private boolean chirurgica;
	private boolean infettiva;
	private boolean controlloPeriodico;
	private Integer level;
	private Boolean enabled;
	
	private boolean cane;
	private boolean gatto;
	private boolean sinantropo;
	
	private Set<Diagnosi> diagnosis = new HashSet<Diagnosi>(0);
	private Set<DiagnosiEffettuate> diagnosiEffettuate = new HashSet<DiagnosiEffettuate>(0);

	public LookupDiagnosi()
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

	@Column(name = "description", length = 256)
	@Length(max = 256)
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
	
	@Column(name = "medica", nullable = false)
	@NotNull
	public boolean isMedica() {
		return medica;
	}

	public void setMedica(boolean medica) {
		this.medica = medica;
	}

	@Column(name = "chirurgica", nullable = false)
	@NotNull
	public boolean isChirurgica() {
		return chirurgica;
	}

	public void setChirurgica(boolean chirurgica) {
		this.chirurgica = chirurgica;
	}

	@Column(name = "infettiva", nullable = false)
	@NotNull
	public boolean isInfettiva() {
		return infettiva;
	}

	public void setInfettiva(boolean infettiva) {
		this.infettiva = infettiva;
	}

	@Column(name = "controllo_periodico", nullable = false)
	@NotNull
	public boolean isControlloPeriodico() {
		return controlloPeriodico;
	}

	public void setControlloPeriodico(boolean controlloPeriodico) {
		this.controlloPeriodico = controlloPeriodico;
	}
	
	
	@Column(name = "cane", nullable = false)
	@NotNull
	public boolean isCane() {
		return cane;
	}

	public void setCane(boolean cane) {
		this.cane = cane;
	}

	@Column(name = "gatto", nullable = false)
	@NotNull
	public boolean isGatto() {
		return gatto;
	}

	public void setGatto(boolean gatto) {
		this.gatto = gatto;
	}

	@Column(name = "sinantropo", nullable = false)
	@NotNull
	public boolean isSinantropo() {
		return sinantropo;
	}

	public void setSinantropo(boolean sinantropo) {
		this.sinantropo = sinantropo;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "listaDiagnosi")	
	public Set<DiagnosiEffettuate> getDiagnosiEffettuate() {
		return this.diagnosiEffettuate;
	}

	public void setDiagnosiEffettuate(Set<DiagnosiEffettuate> diagnosiEffettuate) {
		this.diagnosiEffettuate = diagnosiEffettuate;
	}
	

	
}
