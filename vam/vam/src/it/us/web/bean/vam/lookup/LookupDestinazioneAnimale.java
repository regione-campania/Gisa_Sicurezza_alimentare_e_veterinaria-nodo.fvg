package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Diagnosi;

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

import org.hibernate.annotations.Type;
import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_destinazione_animale", schema = "public")
@Where( clause = "enabled" )
public class LookupDestinazioneAnimale implements java.io.Serializable
{
	private static final long serialVersionUID = -7225928276157167124L;
	
	private int id;
	private String description;	
	private String descriptionSinantropo;	
	private Integer level;
	private Boolean enabled;
	
	private boolean cane;
	private boolean gatto;
	private boolean sinantropo;
	
	private boolean dimissioniCcTrasferimento;
	
	private Set<CartellaClinica> cartelleCliniche = new HashSet<CartellaClinica>(0);
		
	@Transient
	public String getNomeEsame()
	{
		return "Destinazione animale";
	}
	
	public LookupDestinazioneAnimale()
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
	
	@Column(name = "description_sinantropo")
	@Type(type="text")
	public String getDescriptionSinantropo() {
		return this.descriptionSinantropo;
	}

	public void setDescriptionSinantropo(String descriptionSinantropo) {
		this.descriptionSinantropo = descriptionSinantropo;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "destinazioneAnimale")	
	public Set<CartellaClinica> getCartelleCliniche() {
		return cartelleCliniche;
	}

	public void setCartelleCliniche(Set<CartellaClinica> cartelleCliniche) {
		this.cartelleCliniche = cartelleCliniche;
	}

	
	@Column(name = "dimissioni_cc_trasferimento", nullable = false)
	@NotNull
	public boolean isDimissioniCcTrasferimento() {
		return dimissioniCcTrasferimento;
	}

	public void setDimissioniCcTrasferimento(boolean dim) {
		this.dimissioniCcTrasferimento = dim;
	}
	
	

}
