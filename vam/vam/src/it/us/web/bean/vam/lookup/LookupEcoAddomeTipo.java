package it.us.web.bean.vam.lookup;

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

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;
import java.util.Set;

@Entity
@Table(name = "lookup_eco_addome_tipo", schema = "public")
public class LookupEcoAddomeTipo implements java.io.Serializable
{
	private static final long serialVersionUID = -8091002289851989785L;
	
	private int id;
	private String nome;
	private Set<LookupEcoAddomeReferti> lookupEcoAddomeReferti; 

	@Transient
	public String getNomeEsame()
	{
		return "Tipo";
	}
	
	public LookupEcoAddomeTipo()
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

	@Column(name = "nome", length = 64)
	@Length(max = 64)
	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "lookupEcoAddomeTipo")
	@Fetch (FetchMode.SELECT) 
	public Set<LookupEcoAddomeReferti> getLookupEcoAddomeReferti() {
		return lookupEcoAddomeReferti;
	}

	public void setLookupEcoAddomeReferti(
			Set<LookupEcoAddomeReferti> lookupEcoAddomeReferti) {
		this.lookupEcoAddomeReferti = lookupEcoAddomeReferti;
	}
	
	@Override
	public String toString()
	{
		return nome;
	}
	
}
