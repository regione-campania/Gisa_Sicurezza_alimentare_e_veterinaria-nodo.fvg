package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.CartellaClinica;

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
@Table(name = "lookup_evento_apertura_cc", schema = "public")
@Where( clause = "enabled" )
public class LookupEventoAperturaCc implements java.io.Serializable
{
	private static final long serialVersionUID = -7225928276157167124L;
	
	private int id;
	private String descrizione;	
	private Boolean enabled;
	
	private Set<CartellaClinica> cartelleCliniche = new HashSet<CartellaClinica>(0);
		
	public LookupEventoAperturaCc()
	{
		
	}
			
	@Override
	public String toString()
	{
		return descrizione;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Evento apertura cc";
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

	@Column(name = "descrizione", length = 256)
	@Length(max = 256)
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
		
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "destinazioneAnimale")	
	public Set<CartellaClinica> getCartelleCliniche() {
		return cartelleCliniche;
	}

	public void setCartelleCliniche(Set<CartellaClinica> cartelleCliniche) {
		this.cartelleCliniche = cartelleCliniche;
	}
}
