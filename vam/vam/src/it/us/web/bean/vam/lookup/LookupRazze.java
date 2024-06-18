package it.us.web.bean.vam.lookup;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Where;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "lookup_razze", schema = "public")
@Where( clause = "enabled" )
public class LookupRazze implements java.io.Serializable
{
	private static final long serialVersionUID = -6362067633554376948L;
	
	private int id;
	private String description;
	private Integer level;
	private Boolean cane;
	private Boolean gatto;
	private String enci;
	private Boolean enabled;

	public LookupRazze()
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

	@Column(name = "description", length = 64)
	@Length(max = 64)
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


	@Column(name = "cane")
	public Boolean getCane() {
		return cane;
	}

	public void setCane(Boolean cane) {
		this.cane = cane;
	}


	@Column(name = "gatto")
	public Boolean getGatto() {
		return gatto;
	}

	public void setGatto(Boolean gatto) {
		this.gatto = gatto;
	}

	@Column(name = "enci")
	public String getEnci() {
		return enci;
	}

	public void setEnci(String enci) {
		this.enci = enci;
	}
	
	@Override
	public String toString(){
		return description;
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Razza";
	}

}
