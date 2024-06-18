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
@Table(name = "lookup_esame_urine_presenze", schema = "public")
@Where( clause = "enabled" )
public class LookupEsameUrinePresenze implements java.io.Serializable
{
	private static final long serialVersionUID = -3156233441365137861L;
	
	private int id;
	private String descriptionS;
	private String descriptionPM;
	private String descriptionPF;
	private Integer level;
	private Boolean breve;
	private Boolean normale;
	private Boolean enabled;

	public LookupEsameUrinePresenze()
	{
		
	}
	
	@Transient
	public String getNomeEsame()
	{
		return "Presenze";
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

	@Column(name = "description_s", length = 64)
	@Length(max = 64)
	public String getDescriptionS() {
		return this.descriptionS;
	}

	public void setDescriptionS(String descriptionS) {
		this.descriptionS = descriptionS;
	}
	
	@Column(name = "description_pm", length = 64)
	@Length(max = 64)
	public String getDescriptionPM() {
		return this.descriptionPM;
	}

	public void setDescriptionPM(String descriptionPM) {
		this.descriptionPM = descriptionPM;
	}

	@Column(name = "description_pf", length = 64)
	@Length(max = 64)
	public String getDescriptionPF() {
		return this.descriptionPF;
	}

	public void setDescriptionPF(String descriptionPF) {
		this.descriptionPF = descriptionPF;
	}
	
	@Column(name = "level")
	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}
	
	@Column(name = "breve")
	public Boolean getBreve() {
		return this.breve;
	}

	public void setBreve(Boolean breve) {
		this.breve = breve;
	}
	
	@Column(name = "normale")
	public Boolean getNormale() {
		return this.normale;
	}

	public void setNormale(Boolean normale) {
		this.normale = normale;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}
	
	@Override
	public String toString()
	{
		return descriptionS + ", " + descriptionPF + ", " + descriptionPM;
	}

}
