package it.us.web.bean.vam.lookup;

import it.us.web.bean.vam.MagazzinoArticoliSanitari;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.bean.vam.TerapiaAssegnata;

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
@Table(name = "lookup_articoli_sanitari", schema = "public")
@Where( clause = "enabled" )
public class LookupArticoliSanitari implements java.io.Serializable
{
	private static final long serialVersionUID = 4447343084372790967L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean enabled;
	
	private Set<MagazzinoArticoliSanitari> magazzinoArticoliSanitaris = new HashSet<MagazzinoArticoliSanitari>(0);


	public LookupArticoliSanitari()
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
	
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "lookupArticoliSanitari")	
	public Set<MagazzinoArticoliSanitari> getMagazzinoArticoliSanitaris() {
		return magazzinoArticoliSanitaris;
	}

	public void setMagazzinoArticoliSanitaris(Set<MagazzinoArticoliSanitari> magazzinoArticoliSanitaris) {
		this.magazzinoArticoliSanitaris = magazzinoArticoliSanitaris;
	}
	
	@Override
	public String toString()
	{
		return description;
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Articolo Sanitario";
	}
	
}
