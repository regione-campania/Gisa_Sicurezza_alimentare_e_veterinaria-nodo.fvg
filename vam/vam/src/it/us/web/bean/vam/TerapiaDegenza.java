package it.us.web.bean.vam;

import it.us.web.bean.BUtente;

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "terapia_degenza", schema = "public")
@Where( clause = "trashed_date is null" )
public class TerapiaDegenza implements java.io.Serializable
{
	private static final long serialVersionUID = 5661336423622596083L;
	
	private int id;		
	private CartellaClinica cartellaClinica;
	private Date data;		
	private Date dataChiusura;	
	private Date entered;
	private BUtente enteredBy;
	private Date modified;
	private BUtente modifiedBy;
	private Date trashedDate;
	private String tipo;

	private Set<TerapiaAssegnata> tarapiaAssegnatas = new HashSet<TerapiaAssegnata>(0);
	
	
	public TerapiaDegenza()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Terapia Degenza";
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "cartella_clinica")
	public CartellaClinica getCartellaClinica() {
		return this.cartellaClinica;
	}

	public void setCartellaClinica(CartellaClinica cartellaClinica) {
		this.cartellaClinica = cartellaClinica;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data", length = 13)
	public Date getData() {
		return this.data;
	}

	public void setData(Date data) {
		this.data = data;
	}


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "entered")
	public Date getEntered() {
		return this.entered;
	}

	public void setEntered(Date entered) {
		this.entered = entered;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "modified")
	public Date getModified() {
		return this.modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "trashed_date")
	public Date getTrashedDate() {
		return this.trashedDate;
	}

	public void setTrashedDate(Date trashedDate) {
		this.trashedDate = trashedDate;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "entered_by")
	@NotNull
	public BUtente getEnteredBy() {
		return this.enteredBy;
	}

	public void setEnteredBy(BUtente enteredBy) {
		this.enteredBy = enteredBy;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "modified_by")
	@NotNull
	public BUtente getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(BUtente modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "terapiaDegenza")
	@Where( clause = "trashed_date is null" )
	public Set<TerapiaAssegnata> getTarapiaAssegnatas() {
		return tarapiaAssegnatas;
	}

	public void setTarapiaAssegnatas(Set<TerapiaAssegnata> tarapiaAssegnatas) {
		this.tarapiaAssegnatas = tarapiaAssegnatas;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "data_chiusura")
	public Date getDataChiusura() {
		return this.dataChiusura;
	}

	public void setDataChiusura(Date dataChiusura) {
		this.dataChiusura = dataChiusura;
	}
	
	
	@Column(name = "tipo", length = 13)
	public String getTipo() {
		return this.tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString()
	{
		return id+"";
	}
	
}
