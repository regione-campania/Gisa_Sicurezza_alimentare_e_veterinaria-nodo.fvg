package it.us.web.bean.vam.lookup;

import java.util.List;
import java.util.ArrayList;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_eco_cuore_tipo", schema = "public")
@Where( clause = "enabled" )
public class LookupEcoCuoreTipo implements java.io.Serializable
{
	private static final long serialVersionUID = 8883800872280582920L;
	
	private int id;
	private String descrizione;
	private Boolean enabled;
	private List<LookupEcoCuoreAnomalia> lookupEcoCuoreAnomalias = new ArrayList<LookupEcoCuoreAnomalia>(0);

	public LookupEcoCuoreTipo()
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

	@Column(name = "descrizione", length = 64)
	@Length(max = 64)
	public String getDescrizione() {
		return this.descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupEcoCuoreTipo")
	public List<LookupEcoCuoreAnomalia> getLookupEcoCuoreAnomalias() {
		return this.lookupEcoCuoreAnomalias;
	}

	public void setLookupEcoCuoreAnomalias(List<LookupEcoCuoreAnomalia> lookupEcoCuoreAnomalias) {
		this.lookupEcoCuoreAnomalias = lookupEcoCuoreAnomalias;
	}
	
	@Override
	public String toString()
	{
		return descrizione;
	}
}
