package it.us.web.bean.vam.lookup;

import it.us.web.bean.BUtente;
import it.us.web.bean.remoteBean.ProprietarioCane;
import it.us.web.bean.remoteBean.ProprietarioGatto;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.Clinica;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Hashtable;
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
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Type;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_personale_interno", schema = "public")
@Where( clause = "enabled" )
public class LookupPersonaleInterno implements java.io.Serializable
{
	private static final long serialVersionUID = 4228259336170709625L;
	
	private int id;
	private String nominativo;
	private Boolean enabled;
	private LookupAsl asl;
	
	public LookupPersonaleInterno()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Personale interno";
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

	@Column(name = "nominativo")
	@Type(type="text")
	public String getNominativo() {
		return this.nominativo;
	}

	public void setNominativo(String nominativo) {
		this.nominativo = nominativo;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "asl", nullable=true)
	public LookupAsl getAsl() {
		return this.asl;
	}

	public void setAsl(LookupAsl asl) {
		this.asl = asl;
	}
	
	@Override
	public String toString()
	{
		return id+"";
	}

}
