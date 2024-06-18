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
@Table(name = "lookup_esito_rabbia", schema = "public")
@Where( clause = "enabled" )
public class LookupEsitoRabbia implements java.io.Serializable
{
	private static final long serialVersionUID = -3156233441365137861L;
	
	private int id;
	private String description;	
	private Integer level;
	private Boolean enabled;
	
	private boolean sangue;
	private boolean encefalo;
	
	public LookupEsitoRabbia()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Esito";
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
	
	@Column(name = "sangue", nullable = false)
	@NotNull
	public boolean isSangue() {
		return sangue;
	}

	public void setSangue(boolean sangue) {
		this.sangue = sangue;
	}

	@Column(name = "encefalo", nullable = false)
	@NotNull
	public boolean isEncefalo() {
		return encefalo;
	}

	public void setEncefalo(boolean encefalo) {
		this.encefalo = encefalo;
	}

}
