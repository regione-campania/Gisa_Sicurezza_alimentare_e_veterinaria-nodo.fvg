package it.us.web.bean.vam;

import it.us.web.bean.BUtente;
import it.us.web.bean.vam.lookup.LookupDiagnosi;

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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "diagnosi_effettuate", schema = "public")
public class DiagnosiEffettuate implements java.io.Serializable{

	private int id;
	private Diagnosi diagnosi;	
	private LookupDiagnosi listaDiagnosi;	
	private boolean provata;
	private String description;
	
	@Transient
	public String getNomeEsame()
	{
		return "Diagnosi effettuate";
	}
	
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY )
	@Column(name = "id", unique = true, nullable = false)
	@NotNull
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	@Override
	public String toString()
	{
		description = listaDiagnosi.getDescription();
		return description;
	}
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "diagnosi")
	public Diagnosi getDiagnosi() {
		return this.diagnosi;
	}

	public void setDiagnosi(Diagnosi diagnosi) {
		this.diagnosi = diagnosi;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "lookup_diagnosi")
	public LookupDiagnosi getListaDiagnosi() {
		return this.listaDiagnosi;
	}

	public void setListaDiagnosi(LookupDiagnosi listaDiagnosi) {
		this.listaDiagnosi = listaDiagnosi;
	}
	
	@Column(name = "provata", nullable = false)
	@NotNull
	public boolean isProvata() {
		return provata;
	}

	public void setProvata(boolean provata) {
		this.provata = provata;
	}
	

}

