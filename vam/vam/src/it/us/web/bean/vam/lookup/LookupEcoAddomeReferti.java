package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.EcoAddomeEsito;

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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_eco_addome_referti", schema = "public")
public class LookupEcoAddomeReferti implements java.io.Serializable
{
	private static final long serialVersionUID = -8091002289851989785L;
	
	private int id;
	private String nome;
	private String tipo;
	private LookupEcoAddomeTipo lookupEcoAddomeTipo;
	private Set<EcoAddomeEsito> ecoAddomeEsitos;
	
	@Transient
	public String getNomeEsame()
	{
		return "Referti";
	}
	
	public LookupEcoAddomeReferti()
	{
		
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

	@Column(name = "nome")
	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="id_eco_addome_tipo")
	public LookupEcoAddomeTipo getLookupEcoAddomeTipo() {
		return lookupEcoAddomeTipo;
	}

	public void setLookupEcoAddomeTipo(LookupEcoAddomeTipo lookupEcoAddomeTipo) {
		this.lookupEcoAddomeTipo = lookupEcoAddomeTipo;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "lookupEcoAddomeReferti")
	public Set<EcoAddomeEsito> getEcoAddomeEsitos() {
		return ecoAddomeEsitos;
	}

	public void setEcoAddomeEsitos(Set<EcoAddomeEsito> ecoAddomeEsitos) {
		this.ecoAddomeEsitos = ecoAddomeEsitos;
	}
	
	
	@Column(name = "tipo")
	@Length(max = 1)
	public String getTipo() {
		return this.tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	@Override
	public String toString()
	{
		return nome;
	}
	
}
