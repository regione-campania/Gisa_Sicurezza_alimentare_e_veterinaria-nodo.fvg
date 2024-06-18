package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.EcoCuore;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_eco_cuore_diagnosi", schema = "public")
public class LookupEcoCuoreDiagnosi implements java.io.Serializable
{
	private static final long serialVersionUID = -8091002289851989785L;
	
	private int id;
	private String descrizione;
	private Set<EcoCuore> ecoCuores;

	public LookupEcoCuoreDiagnosi()
	{
		
	}
	
	@Override
	public String toString()
	{
		return descrizione;
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


	@Column(name = "descrizione", length = 64)
	@Length(max = 64)
	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "lookupEcoCuoreDiagnosis")
	public Set<EcoCuore> getEcoCuores() {
		return ecoCuores;
	}

	public void setEcoCuores(Set<EcoCuore> ecoCuores) {
		this.ecoCuores = ecoCuores;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Diagnosi";
	}

}
